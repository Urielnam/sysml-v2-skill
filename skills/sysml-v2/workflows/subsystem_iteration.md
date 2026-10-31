# Stage 5 Playbook: Iterative Subsystem Zoom-In (Capability/Functionality $\rightarrow$ Subsystem)

**Target Directory**: `subsystems/<subsystem_slug>/`

---

## 1. When to Use This Playbook

Use this workflow when a top-level (Level 0) system model exists and the user asks to **zoom in on a specific capability or functionality** (e.g., `SenseAndClassifyAirspaceIntruder`, `ClampStructureWithoutPenetration`, `HarvestRenewableEnergyAndShedWeather`) and engineer it as a complete **Subsystem-of-Interest (Level 1)**.

---

## 2. CRITICAL EXECUTION RULE: Progressive Micro-Step Barriers

Just like a top-level system model, subsystem engineering **MUST** progress one micro-step at a time with a hard `spec42 check` barrier after every single micro-step:
1. **D1.1 Subsystem Stakeholders ONLY** $\rightarrow$ commit & `spec42 check`
2. **D1.2 Subsystem Goals ONLY** $\rightarrow$ commit & `spec42 check`
3. **D1.3 Subsystem Gaps ONLY** $\rightarrow$ commit & `spec42 check`
4. **D1.4 Subsystem Needs ONLY** $\rightarrow$ commit & `spec42 check`
5. **D5.1 Subsystem Activities ONLY** $\rightarrow$ commit & `spec42 check`
6. **D5.2 Subsystem Operands/States/Operators/Structures** $\rightarrow$ commit & `spec42 check`
7. **D5.3 Subsystem Goal/Gap Process Links** $\rightarrow$ commit & `spec42 check`
8. **D2.1 Subsystem Capabilities ONLY** $\rightarrow$ commit & `spec42 check`
9. **D2.2 Subsystem Functionalities ONLY** $\rightarrow$ commit & `spec42 check`
10. **D2.3 Subsystem Grounded Requirements** $\rightarrow$ commit & `spec42 check`
11. **D3.1 Subsystem $N$-Candidate Trade Space & COTS BoMs** $\rightarrow$ commit & `spec42 check`
12. **D3.2 Subsystem Integrated Baseline & `satisfy` Links** $\rightarrow$ commit & `spec42 check`

**NEVER spawn subagents across different micro-steps simultaneously!**

---

## 3. Step-by-Step Execution Sequence

### Step 5.1: Extract Parent Boundary Contract
1. Read the parent workspace files (`D1_StakeholdersAndNeeds.sysml`, `D2_Capabilities.sysml`, `D3_SolutionCandidates.sysml`).
2. Identify the target parent functionality (`GSF-xx`) and its winning sub-assembly (`CAND-xx-WIN`), along with:
   * All parent `SystemRequirement`s allocated to `GSF-xx`.
   * The subsystem's allocated share of system CapEx (`bomCostUsd`), DIY assembly time (`diyAssemblyTimeMinutes`), power budget, and physical interfaces.
3. Formulate the **Level 1 Subsystem Framing Sentence**:
   $$\text{[Parent Host System]} \text{ derives value when } \text{[Target Subsystem]} \text{ executes } \text{[Target Functionality]}$$

### Step 5.2: Initialize Subsystem Workspace (`subsystems/<subsystem_slug>/`)
Create the directory `subsystems/<subsystem_slug>/` and execute the playbooks (`workflows/d1_stakeholders_goals.md`, `workflows/d5_conops_derivation.md`, `workflows/d2_problem_functionality.md`, `workflows/d3_solution_trades.md`) micro-step by micro-step, validating with:
```powershell
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check "subsystems/<subsystem_slug>"
```
after **every individual micro-step**.

### Step 5.3: Compile Subsystem Printable PDF Architecture Atlas
```powershell
python "C:\Users\yurie\.gemini\config\plugins\sysml-v2\skills\sysml-v2\scripts\sysml_atlas_generator.py" `
  --model-dir "subsystems/<subsystem_slug>" `
  --output-pdf "subsystems/<subsystem_slug>/subsystem_architecture_atlas.pdf" `
  --diagrams-dir "subsystems/<subsystem_slug>/diagrams"
```
