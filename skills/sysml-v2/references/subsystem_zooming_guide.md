# Recursive Subsystem In-Zooming Guide

Complex systems engineering is fractal. Once a top-level (Level 0) system architecture is completed and validated, any **System Capability** (`CAP-xx`) or **System Functionality** (`GSF-xx`) can be zoomed into and engineered as a standalone **Subsystem-of-Interest (Level 1)** using the exact same 5-Domain workflow and PDF Atlas generator.

---

## 1. The Recursive Framing Transformation

When zooming in on a specific functionality $F_k$ allocated to winning candidate $C_k$ inside Parent System $S_0$:

* **Level 0 (Parent) Framing**:
  $$\text{[External Beneficiary]} \text{ derives value when } [S_0] \text{ executes } [\text{Main Mission}]$$
* **Level 1 (Subsystem) Framing**:
  $$[S_0 \text{ / Host Architecture}] \text{ derives value when } [\text{Subsystem } C_k] \text{ executes } [\text{Functionality } F_k]$$

---

## 2. Boundary Hand-off Rules (Parent $\rightarrow$ Child)

| Domain | How Parent Model Constrains the Child Subsystem Model |
| :--- | :--- |
| **D1: Stakeholders & Needs** | • **Primary Stakeholder**: The **Parent Host System** ($S_0$) and adjacent interfacing subsystems become formal stakeholders alongside human installers/maintainers.<br/>• **Top-Level Goals**: The parent `SystemRequirement`s (`REQ-TECH-xx`) and budget ceilings (CapEx share, power share, latency share, mass envelope) allocated to $F_k$ become the child's **Operational Goals** (`GOAL-01..06`).<br/>• **Gaps & Needs**: Focus on subsystem-internal physics, interface bottlenecks, thermal dissipation, signal integrity, and sub-component assembly. |
| **D5: Subsystem ConOps** | • **Process In-Zooming**: Unfold the single parent functionality $F_k$ into 5–7 sequential/parallel internal sub-activities (`ACT-01..06`).<br/>• **Micro-Operands**: Define the internal signals, data buffers, energy flows, and mechanical forces transformed inside the subsystem. |
| **D2: Subsystem Capabilities & Reqs** | • **Sub-Capabilities & Sub-Functionalities**: Decompose into 5–7 subsystem functionalities (e.g., for an Optical Sensing Subsystem: *Lens Optics*, *CMOS Frame Capture*, *Tensor NPU Inference*, *UART Telemetry Serialization*, *Thermal Regulation*, *Housing Seal*).<br/>• **Subsystem Requirements**: Allocate the parent budget mathematically across sub-functions (e.g., $\sum t_i \le T_{\text{parent}}$, $\sum P_i \le P_{\text{parent}}$, $\sum \text{Cost}_i \le \text{CapEx}_{\text{parent}}$). |
| **D3: Sub-Component Trades** | • Generate $N$ candidate sub-component solutions per sub-functionality with real COTS distributor URLs, MPNs, unit costs, and Pugh trade scores. |

---

## 3. Workspace Directory Structure for Subsystems

Create a dedicated subdirectory under `subsystems/<subsystem_slug>/` containing its own 1-to-1 domain files:

```text
project-workspace/
├── D1_StakeholdersAndNeeds.sysml
├── D5_MissionsAndConOps.sysml
├── D2_Capabilities.sysml
├── D3_SolutionCandidates.sysml
├── Views.sysml
├── main.sysml
└── subsystems/
    └── <subsystem_slug>/
        ├── D1_StakeholdersAndNeeds.sysml
        ├── D5_MissionsAndConOps.sysml
        ├── D2_Capabilities.sysml
        ├── D3_SolutionCandidates.sysml
        ├── Views.sysml
        └── main.sysml
```

---

## 4. Validating and Generating the Subsystem Architecture Atlas

Because the subsystem directory follows the identical 5-Domain metamodel contract, both `spec42` and `sysml_atlas_generator.py` run directly on the subsystem folder without modification:

```powershell
# 1. Validate the subsystem model with Spec42 (Must return 0 errors)
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check "subsystems/<subsystem_slug>"

# 2. Generate the complete printable vector PDF Atlas for the subsystem
python "<skill_dir>/scripts/sysml_atlas_generator.py" `
  --model-dir "subsystems/<subsystem_slug>" `
  --output-pdf "subsystems/<subsystem_slug>/subsystem_architecture_atlas.pdf" `
  --diagrams-dir "subsystems/<subsystem_slug>/diagrams"
```
