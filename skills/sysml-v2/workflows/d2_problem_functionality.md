# Stage 3 Playbook: Domain 2 — Progressive Execution of Capabilities $\rightarrow$ Functionalities $\rightarrow$ Requirements

**Target File**: `D2_Capabilities.sysml`  
**Package Name**: `package D2_Capabilities`

---

## 1. CRITICAL EXECUTION RULE: Strict Micro-Step Sequentiality

Domain 2 consists of **3 strictly sequential micro-steps**:
$$\text{3.1 Capabilities} \xrightarrow{\text{commit + spec42}} \text{3.2 Problem-Solving Functionalities} \xrightarrow{\text{commit + spec42}} \text{3.3 Grounded System Requirements}$$

* **NEVER** spawn a Functionalities subagent while the Capabilities subagent is still running or before Capabilities are committed to `D2_Capabilities.sysml` and validated with `spec42`!
* **NEVER** spawn Requirement Research subagents before Functionalities and Requirement Groups are committed to `D2_Capabilities.sysml` and validated with `spec42`!
* Embed all academic citations, Crossref DOIs, physics equations, verified benchmarks, and compliance margins directly into `D2_Capabilities.sysml` attributes (Zero Intermediate HTML).

---

## 2. Progressive Micro-Step Sequence

### Micro-Step 3.1: Solution-Neutral Capabilities ONLY (Derived from Validated D1 Goals)
1. **Spawn**: Passing the validated Goals from `D1_StakeholdersAndNeeds.sysml`, spawn 1–2 **Capability Architect** subagents to extract solution-neutral, stakeholder-oriented capabilities via user stories (`"As a <Stakeholder>, I need to be able to <X>..."`) and cluster them into **5–7 Generalized System Capabilities** (`CAP-01`..`CAP-06`).
   *(Do NOT spawn Functionality or Requirement agents yet! Stop and wait for the Capability subagent(s) to finish.)*
2. **Commit to `D2_Capabilities.sysml`**:
   * Write the base metaclasses (`SystemCapability`, `SystemFunctionality`, `RequirementGroup`, `SystemRequirement`), the 5–7 Tier 1 Generalized Capabilities (`action def <Cap> :> SystemCapability`) with `attribute :>> addressesGoal = "<GoalName>";`, and all Tier 2 Specific Capabilities (`action def <SpecificCap> :> <Cap>`).
3. **Hard Gate 3.1 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 3.2.

---

### Micro-Step 3.2: Problem-Solving System Functionalities ONLY (Derived from Validated Capabilities)
1. **Spawn**: Passing the **exact 5–7 Generalized Capabilities committed in Micro-Step 3.1**, spawn 1–2 **Functional Decomposition Specialist** subagents to generate specific problem-solving functionalities (`Verb + Noun` active syntax) for each capability and cluster them into **5–7 Generalized System Functionalities** (`GSF-01`..`GSF-06`).
   *(Do NOT spawn Requirement Research agents yet! Stop and wait for the Functionality subagent(s) to finish.)*
2. **Commit to `D2_Capabilities.sysml`**:
   * Append the 5–7 Tier 1 Generalized System Functionalities (`action def <Func> :> SystemFunctionality`) with `attribute :>> parentCapability = "<CapName>";`, all Tier 2 Specific Functionalities (`action def <SpecificFunc> :> <Func>`), update `decomposesToFunctionalities` on the parent Capabilities, and define the **5–7 Requirement Groups** (`RG-01`..`RG-06`, `:>` `RequirementGroup`), including the System Feasibility, LCC & Ownership group (`RG-06`).
3. **Hard Gate 3.2 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 3.3.

---

### Micro-Step 3.3: Grounded Quantitative System Requirements (Derived from Validated Functionalities & Needs)
1. **Spawn (Horizontal Parallelism Allowed — Up to 3 Concurrent Subagents)**:
   * Now that the 5–7 Generalized Functionalities and 5–7 Requirement Groups are committed and validated in `D2_Capabilities.sysml`, spawn up to 3 **Requirements & Physics Research Specialist** subagents in parallel (e.g., Agent 1 for `RG-01..02`, Agent 2 for `RG-03..04`, Agent 3 for `RG-05..06`) to formulate **5–9 testable quantitative requirements per group** (`REQ-TECH-01`..`REQ-FEAS-05`).
   * Wait for all requirement subagents to finish.
2. **Commit to `D2_Capabilities.sysml`**:
   * Every `SystemRequirement` (`:> SystemRequirement`) **MUST** populate all 13 contract attributes:
     `reqId`, `statement`, `quantitativeMetric`, `verificationMethod`, `standardOrCitation`, `doiOrUrl` (active clickable URL/DOI), `atomicSpec`, `physicsFormula`, `verifiedBenchmark`, `complianceMargin`, `requirementGroup`, `allocatedFunctionality`, and `parentNeed`.
   * Instantiate action and requirement usages at the bottom of `D2_Capabilities.sysml`.
3. **Hard Gate 3.3 (Validate Before Proceeding to Domain 3)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors and 0 warnings.**
