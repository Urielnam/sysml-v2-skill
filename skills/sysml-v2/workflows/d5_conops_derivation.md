# Stage 2 Playbook: Domain 5 — Concept of Operations (ConOps) & OPM Process Model

**Target File**: `D5_MissionsAndConOps.sysml`  
**Package Name**: `package D5_MissionsAndConOps`

---

## 1. Purpose & OPM Grounding

Domain 5 models how the organization/user and system operate across the mission lifecycle using **ISO 19450 Object-Process Methodology (OPM)** semantics mapped to SysML v2:
* **Main Operational Activities** (`action def ... :> OperationalActivity`)
* **Operational Operands** (`item def ... :> OperationalOperand`)
* **Operational States** (`state def ... :> OperationalState`)
* **Enabling Operators** (`part def ... :> EnablingOperator`)
* **Enabling Structures** (`part def ... :> EnablingStructure`)

---

## 2. Step-by-Step Execution Sequence

### Step 2.1: Main Operational Activities (Specific $\rightarrow$ 5–7 Generalized Activities)
1. Spawn a **ConOps Process Architect** subagent with the framing sentence and `D1_StakeholdersAndNeeds.sysml`.
2. Brainstorm all operational activities taking place across deployment, nominal operation, human interaction/bypass, maintenance, and degraded/weather conditions.
3. Cluster into **5–7 Generalized Main Activities** (`ACT-01`..`ACT-06`, specializing `OperationalActivity`).
4. Sequence the main activities inside a top-level mission scenario (`action def <System>ConOps`) using `action a1 : Act1; then action a2 : Act2; ...`.

### Step 2.2: Operands, States, Operators, and Structures
1. Spawn up to 2 specialist subagents to identify for each activity:
   * **5–7 Generalized Operands** (`OPR-01`..`OPR-06`, `:>` `OperationalOperand`): Physical entities, energy pulses, or data streams transformed by the activities.
   * **5–7 Generalized States** (`STATE-01`..`STATE-06`, `:>` `OperationalState`): System/operand states orchestrated in `state def OperationalStates`.
   * **5–7 Generalized Enabling Operators** (`OPER-01`..`OPER-06`, `:>` `EnablingOperator`): Human roles or automated subsystems that execute the activities.
   * **5–7 Generalized Enabling Structures** (`STRUC-01`..`STRUC-06`, `:>` `EnablingStructure`): Physical mounts, enclosures, or environment structures hosting the operators.

### Step 2.3: Explicit Cross-Domain & OPM Linkages (No Comment-Only Links!)
Every relationship must be formally encoded using attributes and item flows (never leave links solely inside `//` comments):
* Inside each `OperationalActivity`:
  * `attribute :>> activityId = "ACT-01";`
  * `attribute :>> enabledByOperator = "<OperatorName>";`
  * `attribute :>> hostedByStructure = "<StructureName>";`
  * `attribute :>> addressesGoal = "<Goal1> | <Goal2>";` (links Activity to D1 Goals)
  * `attribute :>> affectedByGap = "<Gap1> | <Gap2>";` (links where D1 Gaps impact the process)
  * `attribute :>> activeInState = "<stateUsageName>";`
  * `in item <inName> : <OperandType>;`
  * `out item <outName> : <OperandType>;`
* Inside each `EnablingOperator`:
  * `attribute :>> hostedByStructure = "<StructureName>";`
  * `attribute :>> executesActivity = "<ActivityName>";`
* Inside each `EnablingStructure`:
  * `attribute :>> hostsOperator = "<OperatorName>";`
  * `attribute :>> interfacesOperand = "<OperandName>";`

---

## 3. Stage 2 Validation Gate

Run the Spec42 compiler check:
```powershell
& "C:\Users\yurie\.vscode\extensions\elan8.spec42-0.57.0\server\win32-x64\spec42.exe" check .
```
Confirm **0 errors and 0 warnings** before moving to Domain 2.
