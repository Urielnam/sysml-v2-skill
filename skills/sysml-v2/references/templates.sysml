// ============================================================================
// Normative SysML v2 Metamodel Templates for 5-Domain MBSE Architecture
// Compatible with Spec42 Compiler & sysml_atlas_generator.py Dynamic Parser
// ============================================================================

// ----------------------------------------------------------------------------
// 1. Domain 1: Stakeholders, Goals, Gaps, and Needs (D1_StakeholdersAndNeeds.sysml)
// ----------------------------------------------------------------------------
package D1_StakeholdersAndNeeds {
    private import ScalarValues::*;

    // Base Metaclasses (Mandatory for Dynamic Parser Classification)
    part def Stakeholder {
        attribute stakeholderId : String;
    }
    requirement def OperationalGoal {
        attribute goalId : String;
        attribute statement : String;
    }
    concern def OperationalGap {
        attribute gapId : String;
        attribute statement : String;
        attribute obstructedGoal : String;
    }
    requirement def OperationalNeed {
        attribute needId : String;
        attribute statement : String;
        attribute mitigatedGap : String;
    }

    // Tier 1 (Generalized Stakeholder) -> Direct specialization of Stakeholder
    part def GeneralizedStakeholderGroup :> Stakeholder {
        doc /* Active-voice ASD-STE100 description (< 25 words per sentence). */
        attribute :>> stakeholderId = "STK-01";
    }

    // Tier 2 (Specific Stakeholder) -> Specialization of Tier 1 Generalized Group
    part def SpecificPersonaRole :> GeneralizedStakeholderGroup {
        doc /* Concrete stakeholder persona refined under GeneralizedStakeholderGroup. */
    }

    // Tier 1 (Generalized Operational Goal)
    requirement def GeneralizedOperationalGoal :> OperationalGoal {
        doc /* The system shall achieve <measurable operational outcome>. */
        attribute :>> goalId = "GOAL-01";
        attribute :>> statement = "The system shall achieve <measurable operational outcome>.";
        stakeholder primaryUser : GeneralizedStakeholderGroup;
    }

    // Tier 2 (Specific Operational Goal)
    requirement def SpecificOperationalGoal :> GeneralizedOperationalGoal {
        doc /* Specific goal leaf refined under GeneralizedOperationalGoal. */
    }

    // Tier 1 (Generalized Operational Gap)
    concern def GeneralizedOperationalGap :> OperationalGap {
        doc /* Existing alternatives fail because <specific physical/economic limitation>. */
        attribute :>> gapId = "GAP-01";
        attribute :>> statement = "Existing alternatives fail because <specific limitation>.";
        attribute :>> obstructedGoal = "GeneralizedOperationalGoal";
    }

    // Tier 2 (Specific Operational Gap)
    concern def SpecificOperationalGap :> GeneralizedOperationalGap {
        doc /* Specific failure mode gap refined under GeneralizedOperationalGap. */
    }

    // Tier 1 (Generalized Operational Need)
    requirement def GeneralizedOperationalNeed :> OperationalNeed {
        doc /* The system shall provide <solution-neutral operational need>. */
        attribute :>> needId = "OP-NEED-01";
        attribute :>> statement = "The system shall provide <solution-neutral operational need>.";
        attribute :>> mitigatedGap = "GeneralizedOperationalGap";
        stakeholder primaryUser : GeneralizedStakeholderGroup;
    }

    // Tier 2 (Specific Operational Need)
    requirement def SpecificOperationalNeed :> GeneralizedOperationalNeed {
        doc /* Specific operational need refined under GeneralizedOperationalNeed. */
    }
}

// ----------------------------------------------------------------------------
// 2. Domain 5: Missions & Concept of Operations (D5_MissionsAndConOps.sysml)
// ----------------------------------------------------------------------------
package D5_MissionsAndConOps {
    private import ScalarValues::*;
    private import D1_StakeholdersAndNeeds::*;

    // Base Metaclasses for ISO 19450 OPM ConOps
    item def OperationalOperand {
        attribute operandId : String;
    }
    state def OperationalState {
        attribute stateId : String;
        attribute activeActivity : String;
        attribute activeOperator : String;
    }
    part def EnablingOperator {
        attribute operatorId : String;
        attribute hostedByStructure : String;
        attribute executesActivity : String;
    }
    part def EnablingStructure {
        attribute structureId : String;
        attribute hostsOperator : String;
        attribute interfacesOperand : String;
    }
    action def OperationalActivity {
        attribute activityId : String;
        attribute enabledByOperator : String;
        attribute hostedByStructure : String;
        attribute addressesGoal : String;
        attribute affectedByGap : String;
        attribute activeInState : String;
    }

    // Example Activity with Explicit OPM Linkages
    action def ExecutePrimaryMissionProcess :> OperationalActivity {
        doc /* The operator transforms the input operand into the output state within the structure. */
        attribute :>> activityId = "ACT-01";
        attribute :>> enabledByOperator = "PrimaryOperatorGroup";
        attribute :>> hostedByStructure = "PrimaryPhysicalStructure";
        attribute :>> addressesGoal = "GeneralizedOperationalGoal";
        attribute :>> affectedByGap = "GeneralizedOperationalGap";
        attribute :>> activeInState = "nominalOperationalState";
        in item rawInput : TargetOperand;
        out item processedOutput : TargetOperand;
    }
}

// ----------------------------------------------------------------------------
// 3. Domain 2: Capabilities, Functions, & Requirements (D2_Capabilities.sysml)
// ----------------------------------------------------------------------------
package D2_Capabilities {
    private import ScalarValues::*;
    private import D1_StakeholdersAndNeeds::*;
    private import D5_MissionsAndConOps::*;

    // Base Metaclasses
    action def SystemCapability {
        attribute capabilityId : String;
        attribute addressesGoal : String;
        attribute decomposesToFunctionalities : String;
    }
    action def SystemFunctionality {
        attribute functionalityId : String;
        attribute parentCapability : String;
        attribute requirementGroup : String;
    }
    requirement def RequirementGroup {
        attribute groupId : String;
        attribute groupName : String;
        attribute primaryFunctionality : String;
        attribute parentNeed : String;
    }
    requirement def SystemRequirement {
        attribute reqId : String;
        attribute statement : String;
        attribute quantitativeMetric : String;
        attribute verificationMethod : String;
        attribute standardOrCitation : String;
        attribute doiOrUrl : String;
        attribute atomicSpec : String;
        attribute physicsFormula : String;
        attribute verifiedBenchmark : String;
        attribute complianceMargin : String;
        attribute requirementGroup : String;
        attribute allocatedFunctionality : String;
        attribute parentNeed : String;
    }
}

// ----------------------------------------------------------------------------
// 4. Domain 3: N Solution Candidates & Trade Space (D3_SolutionCandidates.sysml)
// ----------------------------------------------------------------------------
package D3_SolutionCandidates {
    private import ScalarValues::*;
    private import D1_StakeholdersAndNeeds::*;
    private import D5_MissionsAndConOps::*;
    private import D2_Capabilities::*;

    enum def CandidateStatus {
        enum Winner;
        enum RunnerUp;
        enum Pruned;
        enum Rejected;
    }

    part def COTSComponent {
        attribute partName : String;
        attribute manufacturerPartNumber : String;
        attribute manufacturer : String;
        attribute distributor : String;
        attribute verifiedProductLink : String;
        attribute unitCostUsd : Real;
        attribute maturityTrl : Integer;
        attribute assemblyTimeMinutes : Real;
        attribute keyTechnicalSpec : String;
    }

    part def SolutionCandidate {
        attribute candidateId : String;
        attribute candidateName : String;
        attribute status : CandidateStatus;
        attribute primaryFunctionality : String;
        attribute tradeScore : Real;
        attribute billOfMaterials : String;
        attribute rationale : String;
        attribute bomCostUsd : Real;
        attribute diyAssemblyTimeMinutes : Real;
        attribute maturityTrl : Integer;
        attribute verifiedDatasheetLink : String;
        attribute sensitivityMiddaySun : String;
        attribute sensitivityFreezingFogNight : String;
        attribute sensitivityHighWindStorm : String;
        attribute sensitivityEmergencyEvacuation : String;
        attribute pughPerformanceScore : Real;
        attribute pughCostScore : Real;
        attribute pughFeasibilityScore : Real;
        attribute pughMaintenanceScore : Real;
    }
}
