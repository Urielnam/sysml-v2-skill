# ISO 19450 Object-Process Methodology (OPM) to SysML v2 Metamodel Mapping

This reference establishes the formal translation between **ISO 19450 (Object-Process Methodology)** and **OMG SysML v2** textual notation within the 5-Domain MBSE Architecture.

---

## 1. Fundamental OPM-to-SysML v2 Correspondence

In OPM, reality is modeled through **Objects** (things that exist, potentially in states) and **Processes** (things that transform objects by creating, consuming, or changing their state).

| OPM Concept (ISO 19450) | SysML v2 Construct | Base Metaclass in `templates.sysml` | Role in Architecture |
| :--- | :--- | :--- | :--- |
| **Process** | `action def` | `OperationalActivity` (`D5`), `SystemCapability` / `SystemFunctionality` (`D2`) | Transforms operands across states. |
| **Operand (Transformee)** | `item def` | `OperationalOperand` (`D5`) | Object consumed, produced, or state-changed by an activity. |
| **State** | `state def` | `OperationalState` (`D5`) | Situation or mode an operand or system occupies. |
| **Agent / Instrument (Enabler)** | `part def` | `EnablingOperator` (`D5`) | Human actor or automated subsystem that enables/executes a process without being consumed. |
| **Physical Hosting Structure** | `part def` | `EnablingStructure` (`D5`) | Structural environment or chassis hosting the operator and interfacing with operands. |
| **Exhibition-Characterization** | `attribute` | `attribute :>> ...` | Quantitative properties, formulas, benchmarks, and metadata. |
| **Generalization-Specialization** | `:>` (`specializes`) | `SpecificX :> GeneralizedX` | Two-tier taxonomy connecting brainstormed specifics to generalized groups. |
| **Aggregation-Participation** | `part <name> : <Type>` | `part cots : COTSComponent` | Whole-part Bill of Materials composition. |

---

## 2. Value Framing Anchor Sentence

Every system or subsystem model begins with a formal **Value Framing Sentence**:

$$\text{[Beneficiary Stakeholder]} \text{ derives value when } \text{[System-of-Interest]} \text{ executes } \text{[Primary Value-Delivering Process]}$$

* **Beneficiary Stakeholder**: Mapped to the primary `Stakeholder` in `D1_StakeholdersAndNeeds.sysml`.
* **System-of-Interest (SoI)**: Mapped to the integrated `SolutionCandidate` in `D3_SolutionCandidates.sysml`.
* **Primary Value-Delivering Process**: Mapped to the top-level `action def <System>ConOps` in `D5_MissionsAndConOps.sysml`.

---

## 3. Procedural vs. Structural Links in Domain 5 (ConOps)

To ensure deterministic extraction by `sysml_atlas_generator.py`, every `OperationalActivity` in `D5_MissionsAndConOps.sysml` must explicitly bind its procedural links:

1. **Consumption / Result / Effect Links (Operands)**:
   * `in item <name> : <OperandType>;` (Operand consumed or required as input)
   * `out item <name> : <OperandType>;` (Operand yielded as output)
   * `inout item <name> : <OperandType>;` (Operand affected / state-transitioned)
2. **Agent / Instrument Links (Operators & Structures)**:
   * `attribute :>> enabledByOperator = "<OperatorName>";`
   * `attribute :>> hostedByStructure = "<StructureName>";`
3. **Problem-Space Traceability (Goals & Gaps)**:
   * `attribute :>> addressesGoal = "<Goal1> | <Goal2>";`
   * `attribute :>> affectedByGap = "<Gap1> | <Gap2>";`
   * `attribute :>> activeInState = "<stateName>";`

---

## 4. Two-Tier Specialization Invariant (Preventing Unrefined Error Blocks)

During brainstorming, agents generate many specific items (e.g., 15–30 specific stakeholders, goals, gaps, needs, capabilities, or functionalities) and then cluster them into 5–7 **Generalized Groups**.

* **NEVER discard the specific items into temporary scratchpads!**
* Commit both tiers into the `.sysml` file using formal specialization (`:>`):
  * **Tier 1 (Generalized Group)**: Specializes the base metaclass (`part def DomesticBalconyUser :> Stakeholder`).
  * **Tier 2 (Specific Element)**: Specializes the Tier 1 Generalized Group (`part def RemoteWorkerOnBalcony :> DomesticBalconyUser`).
* The Atlas Generator (`sysml_atlas_generator.py`) inspects every Tier 1 element in Rules 12, 15, 18, 21, 24, and 28. If a Tier 1 element has zero Tier 2 children in the `.sysml` model, the generator flags it with a red `«unrefinedElementError»` diagnostic block.
