# Stage 2 Playbook: Domain 5 — Progressive Execution of ConOps & OPM Process Model

**Target File**: `D5_MissionsAndConOps.sysml`  
**Package Name**: `package D5_MissionsAndConOps`

---

## 1. CRITICAL EXECUTION RULE: Strict Micro-Step Sequentiality

Domain 5 consists of **3 strictly sequential micro-steps**:
$$\text{2.1 Main Activities} \xrightarrow{\text{commit + spec42}} \text{2.2 Operands, States, Operators, Structures} \xrightarrow{\text{commit + spec42}} \text{2.3 Cross-Domain Goal/Gap Links}$$

* **NEVER** spawn subagents for Step 2.2 before the 5–7 Generalized Main Activities from Step 2.1 are written to `D5_MissionsAndConOps.sysml` and validated with `spec42 check .`!
* After **every single micro-step**, commit to `D5_MissionsAndConOps.sysml` and run `spec42 check .` (must return `0 errors, 0 warnings`) before spawning the next step's subagents.

---

## 2. Progressive Micro-Step Sequence

### Micro-Step 2.1: Main Operational Activities ONLY (Specific $\rightarrow$ 5–7 Generalized Activities)
1. **Spawn**: Launch a **ConOps Activity Architect** subagent with the framing sentence and the validated `D1_StakeholdersAndNeeds.sysml`.
   *(Do NOT spawn Operand/State/Operator/Structure agents yet! Wait for the Activity subagent to finish.)*
2. **Process Output**:
   * Generate all operational activities across deployment, nominal operation, human interaction/bypass, maintenance, and degraded weather.
   * Cluster into **5–7 Generalized Main Activities** (`ACT-01`..`ACT-06`, specializing `OperationalActivity`).
3. **Commit to `D5_MissionsAndConOps.sysml`**:
   * Write the base OPM metaclasses (`OperationalOperand`, `OperationalState`, `EnablingOperator`, `EnablingStructure`, `OperationalActivity`), the 5–7 Generalized Activities (`action def <Act> :> OperationalActivity`), and the top-level mission sequence (`action def <System>ConOps`).
4. **Hard Gate 2.1 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 2.2.

---

### Micro-Step 2.2: Operands, States, Operators, and Structures (Derived from Validated Activities)
1. **Spawn**: Passing the **exact 5–7 Generalized Activities committed in Micro-Step 2.1**, spawn 1–2 **OPM Enabler & Operand Specialist** subagents to generate for each activity its operands, states, enabling operators, and enabling structures, and cluster them into:
   * **5–7 Generalized Operands** (`OPR-01`..`OPR-06`, `:>` `OperationalOperand`)
   * **5–7 Generalized States** (`STATE-01`..`STATE-06`, `:>` `OperationalState` + `state def OperationalStates`)
   * **5–7 Generalized Enabling Operators** (`OPER-01`..`OPER-06`, `:>` `EnablingOperator`)
   * **5–7 Generalized Enabling Structures** (`STRUC-01`..`STRUC-06`, `:>` `EnablingStructure`)
   *(Wait for the subagent(s) to finish.)*
2. **Commit to `D5_MissionsAndConOps.sysml`**:
   * Write all Operands, States, Operators, and Structures, and bind each `OperationalActivity` to its `in item` / `out item` / `inout item` operands, `enabledByOperator`, `hostedByStructure`, and `activeInState`.
3. **Hard Gate 2.2 (Validate Before Proceeding)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors.** Only after this passes may you start Micro-Step 2.3.

---

### Micro-Step 2.3: Connect Activities to D1 Stakeholder Goals & Operational Gaps
1. **Link**: Connect how the 5–7 generalized activities address the D1 Stakeholder Goals and where in the process the D1 Generalized Gaps impact execution:
   * Inside each `OperationalActivity`, populate:
     * `attribute :>> addressesGoal = "<Goal1> | <Goal2>";`
     * `attribute :>> affectedByGap = "<Gap1> | <Gap2>";`
2. **Hard Gate 2.3 (Validate Before Proceeding to Domain 2)**:
   ```powershell
   & "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
   ```
   **Verify 0 errors and 0 warnings.**
