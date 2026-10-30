# Stage 5 Playbook: Iterative Subsystem Zoom-In (Capability/Functionality $\rightarrow$ Subsystem)

**Target Directory**: `subsystems/<subsystem_slug>/`

---

## 1. When to Use This Playbook

Use this workflow when a top-level (Level 0) system model exists and the user asks to **zoom in on a specific capability or functionality** (e.g., `SenseAndClassifyAirspaceIntruder`, `ClampStructureWithoutPenetration`, `HarvestRenewableEnergyAndShedWeather`) and engineer it as a complete **Subsystem-of-Interest (Level 1)**.

---

## 2. Step-by-Step Execution Sequence

### Step 5.1: Extract Parent Boundary Contract
1. Read the parent workspace files (`D1_StakeholdersAndNeeds.sysml`, `D2_Capabilities.sysml`, `D3_SolutionCandidates.sysml`).
2. Identify the target parent functionality (`GSF-xx`) and its winning sub-assembly (`CAND-xx-WIN`), along with:
   * All parent `SystemRequirement`s allocated to `GSF-xx`.
   * The subsystem's allocated share of system CapEx (`bomCostUsd`), DIY assembly time (`diyAssemblyTimeMinutes`), power budget, and physical interfaces.
3. Formulate the **Level 1 Subsystem Framing Sentence**:
   $$\text{[Parent Host System]} \text{ derives value when } \text{[Target Subsystem]} \text{ executes } \text{[Target Functionality]}$$

### Step 5.2: Initialize Subsystem Workspace (`subsystems/<subsystem_slug>/`)
Create the 5-Domain file suite inside `subsystems/<subsystem_slug>/`:
* `D1_StakeholdersAndNeeds.sysml`
* `D5_MissionsAndConOps.sysml`
* `D2_Capabilities.sysml`
* `D3_SolutionCandidates.sysml`
* `Views.sysml`
* `main.sysml`

### Step 5.3: Execute the 5-Domain Loop at the Subsystem Echelon
1. **Subsystem D1 (`workflows/d1_stakeholders_goals.md`)**:
   * Model the **Parent Host Controller / Chassis**, **Interfacing Neighbor Subsystems**, **Hardware Integrator**, **Firmware/Calibration Operator**, and **Component Supply Chain** as `Stakeholder` groups (with Tier 2 specific roles).
   * Convert the parent requirements allocated to this capability into the subsystem's 5–7 **Generalized Operational Goals** (`GOAL-01..06`), including the subsystem's exact CapEx ceiling and assembly time budget.
   * Derive subsystem-specific **Operational Gaps** (e.g., sensor saturation, bus EMI, thermal throttling, tolerance stack-up) and **Operational Needs**.
2. **Subsystem D5 (`workflows/d5_conops_derivation.md`)**:
   * **In-Zoom** the parent functionality into 5–7 internal sequential/parallel sub-activities (`ACT-01..06`), internal operands (signals, voltages, forces, heat), internal states, sub-operators, and internal structures (PCB, optics mount, housing).
3. **Subsystem D2 (`workflows/d2_problem_functionality.md`)**:
   * Decompose into 5–7 subsystem capabilities and 5–7 subsystem functionalities (`GSF-01..06`).
   * Formulate 25–30 quantitative sub-requirements (`REQ-TECH-01..25`, `REQ-FEAS-01..05`) whose mathematical budgets sum up to satisfy the parent requirements ($\sum t_i \le T_{\text{parent}}$, $\sum \text{Cost}_i \le \text{CapEx}_{\text{parent}}$).
4. **Subsystem D3 (`workflows/d3_solution_trades.md`)**:
   * Evaluate $N$ micro-component candidates per subsystem functionality with real COTS part numbers, distributor URLs, and Pugh matrices.

### Step 5.4: Validate & Compile Subsystem Architecture Atlas
```powershell
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check "subsystems/<subsystem_slug>"

python "<skill_dir>/scripts/sysml_atlas_generator.py" `
  --model-dir "subsystems/<subsystem_slug>" `
  --output-pdf "subsystems/<subsystem_slug>/subsystem_architecture_atlas.pdf" `
  --diagrams-dir "subsystems/<subsystem_slug>/diagrams"
```
