# SysML v2 Systems Engineering & Architecture Atlas Skill (`v2.0.0`)

An industrial-grade Model-Based Systems Engineering (MBSE) plugin and skill package for authoring, validating, grounding, and visualizing **OMG SysML v2** models (`.sysml`) using the **5-Domain Alternative Architecture** methodology, **ISO 19450 Object-Process Methodology (OPM)**, **Spec42** static analysis, and an automated **35-Rule Printable Vector PDF Architecture Atlas Generator**.

---

## Repository Structure

```text
sysml-v2/
├── plugin.json                                     # Plugin manifest (v2.0.0)
├── README.md                                       # Documentation & Master Prompts
└── skills/
    └── sysml-v2/
        ├── SKILL.md                                # Master skill orchestrator & invariants
        ├── references/
        │   ├── templates.sysml                     # Normative SysML v2 metamodel contract
        │   ├── opm_sysml_metamodel.md              # ISO 19450 (OPM) to SysML v2 mapping
        │   └── subsystem_zooming_guide.md          # Recursive subsystem in-zooming guide
        ├── workflows/
        │   ├── d1_stakeholders_goals.md            # Stage 1 Playbook: Stakeholders, Goals, Gaps, Needs
        │   ├── d5_conops_derivation.md             # Stage 2 Playbook: ConOps Activities, Operands, States
        │   ├── d2_problem_functionality.md         # Stage 3 Playbook: Capabilities, Functions, Grounded Reqs
        │   ├── d3_solution_trades.md               # Stage 4 Playbook: N-Candidate Trade Space & COTS BoM
        │   └── subsystem_iteration.md              # Stage 5 Playbook: Iterative Subsystem Zoom-In
        └── scripts/
            └── sysml_atlas_generator.py            # Dynamic .sysml parser & 35-rule Vector PDF Generator
```

---

## Key Capabilities & Architectural Invariants

1. **Five-Domain MBSE Architecture**:
   - **D1 (`D1_StakeholdersAndNeeds.sysml`)**: Lifecycle Stakeholders, Operational Goals (including mandatory LCC/Economic & DIY Feasibility goals), Operational Gaps, and Solution-Neutral Needs.
   - **D5 (`D5_MissionsAndConOps.sysml`)**: ISO 19450 OPM Concept of Operations — Main Activities, Operands, States, Enabling Operators, and Physical Structures.
   - **D2 (`D2_Capabilities.sysml`)**: Solution-Neutral Capabilities (extracted via user stories), Problem-Solving System Functionalities, Requirement Groups, and Quantitative Testable System Requirements grounded in physics formulas, benchmarks, compliance margins, and active Crossref DOIs.
   - **D3 (`D3_SolutionCandidates.sysml`)**: $N$ Solution Candidates per functionality (`Winner`, `RunnerUp`, `Pruned`, `Rejected`), real in-stock COTS components with distributor URLs and pricing, environmental sensitivity analyses, Pugh trade scores, and formal `satisfy` matrix bindings.
   - **Recursive Subsystem In-Zooming (`subsystems/<slug>/`)**: Drill down into any capability or functionality as a child System-of-Interest using inherited boundary budgets.
2. **Two-Tier Formal Inheritance (`SpecificX :> GeneralizedX`)**:
   - Brainstormed specific elements (Tier 2) are formally committed as specializations of the 5–7 generalized abstractions (Tier 1). Unrefined Tier 1 abstractions are automatically detected and flagged as red `«unrefinedElementError»` diagnostic blocks in the PDF Atlas.
3. **Dynamic $N$-Candidate Trade Matrices**:
   - `sysml_atlas_generator.py` dynamically parses any number of candidates ($N$) per functionality and renders $R \times N$ comparison matrices (paginating columns automatically when $N > 6$).
4. **Strict Model-as-Truth (Zero Intermediate HTML)**:
   - All equations, DOIs, distributor links, and Pugh scores live inside `.sysml` attributes.

---

## Automated PDF Architecture Atlas Generator (`sysml_atlas_generator.py`)

The bundled Python tool dynamically parses all `.sysml` files in a target workspace, validates them with `spec42`, expands all **35 algorithmic view rules** (enforcing Miller's Law $\le 9$ nodes per view and multi-column balanced grid layouts), and compiles a black-over-white vector PDF with live clickable hyperlinks.

### Prerequisites
- Python 3.10+ (`pip install pypdf`)
- [Graphviz](https://graphviz.org/) (`dot.exe`)
- Microsoft Edge (`msedge.exe` for headless vector PDF print)
- Spec42 VS Code Extension CLI (`spec42.exe`)

### CLI Usage
```powershell
python skills/sysml-v2/scripts/sysml_atlas_generator.py `
  --model-dir "path/to/sysml-workspace" `
  --output-pdf "path/to/sysml-workspace/architecture_atlas_canonical.pdf" `
  --diagrams-dir "path/to/sysml-workspace/diagrams_canonical"
```

---

## Master Prompts

### Master Prompt A: Greenfield System Engineering (End-to-End)

Copy and paste the prompt below to construct a complete, grounded 5-Domain SysML v2 model and compile its printable PDF Architecture Atlas:

```markdown
You are going to construct a complete, grounded Model-Based Systems Engineering (MBSE) architecture in SysML v2 using the `sysml-v2` skill.
Before starting each stage, read the `sysml-v2` skill (`SKILL.md`, `references/templates.sysml`, and the stage playbook in `workflows/`).

### Orchestration & Modeling Rules (Mandatory)
1. **Subagent Spawning (Max 3 Concurrent)**: Whenever you need domain discovery, literature/benchmark research, or COTS trade analysis, spawn a specialist subagent with only the required upstream context. Spawn up to 3 subagents at a time; if you need more, wait for one to finish before spawning more.
2. **Two-Tier Formal Inheritance (Zero Scratchpad Pruning)**: Every time you generate specific items (stakeholders, goals, gaps, needs, capabilities, or functionalities) and group them into 5–7 generalized groups, commit **both** tiers to the `.sysml` file:
   - Tier 1 (Generalized Group): `:> <BaseMetaclass>` (e.g., `part def DomesticBalconyUser :> Stakeholder`)
   - Tier 2 (Specific Items): `:> <GeneralizedGroup>` (e.g., `part def RemoteWorkerOnBalcony :> DomesticBalconyUser`)
   Never leave a generalized element without specific specializations in the `.sysml` model.
3. **Strict Model-as-Truth (Zero Intermediate HTML)**: Embed all academic citations, active Crossref DOIs (`https://doi.org/...`), physics formulas, verified benchmarks, compliance margins, and COTS distributor URLs directly into `.sysml` attributes as defined in `references/templates.sysml`. Do not create intermediate `.html` files.
4. **Step-by-Step Spec42 Gate**: Keep DRY, formally connect every new element to upstream elements using the attributes and keywords in `references/templates.sysml`, and run `spec42 check .` after every step. Do not proceed to the next step until `spec42 check .` passes with **0 errors and 0 warnings**.

### System Value Framing
`[<Beneficiary Stakeholder>] derives value when [<System-of-Interest>] executes [<Primary Value-Delivering Process>]`

---

### Stage 1 — D1: Stakeholders, Goals, Gaps, and Operational Needs (`D1_StakeholdersAndNeeds.sysml`)
Follow `workflows/d1_stakeholders_goals.md` and `references/templates.sysml`:
1. Generate as many specific Stakeholders as possible across the full lifecycle.
2. Group them into 5–7 Generalized Stakeholder groups (`:> Stakeholder`) — ensure lifecycle stakeholders (Purchaser/Budget Holder, DIY Fabricator/Installer, Maintenance Operator, Regulatory/Governance Authority) are represented alongside operational users. Commit both Tier 1 (`:> Stakeholder`) and Tier 2 (`:> <GeneralizedStakeholder>`) to `D1_StakeholdersAndNeeds.sysml`.
3. For each of the 5–7 generalized stakeholders, generate as many specific operational goals as possible.
4. Find 5–7 Generalized Operational Goals (`requirement def ... :> OperationalGoal`). Mandate at least one **Economic/LCC Goal** (e.g., CapEx ceiling, annual OpEx ceiling, 5-year Total Ownership Cost) and one **Feasibility/Adoption Goal** (e.g., DIY Assembly time ceiling with standard hand tools, non-invasive zero-permit mounting). Link each goal to its stakeholders (`stakeholder <role> : <Stakeholder>;`) and commit both Tier 1 and Tier 2 goals.
5. For each of the 5–7 generalized goals, generate as many specific operational gaps as possible.
6. Find 5–7 Generalized Operational Gaps (`concern def ... :> OperationalGap`), linked to their obstructed goal (`attribute :>> obstructedGoal = "<Goal>";`), and commit both Tier 1 and Tier 2 gaps.
7. For each of the 5–7 generalized gaps, generate as many specific operational needs as possible.
8. Find 5–7 Generalized Operational Needs (`requirement def ... :> OperationalNeed`), linked to their mitigated gap (`attribute :>> mitigatedGap = "<Gap>";`) and stakeholders, and commit both Tier 1 and Tier 2 needs.
9. Validate `D1_StakeholdersAndNeeds.sysml` with `spec42 check .` (0 errors).

---

### Stage 2 — D5: Concept of Operations (`D5_MissionsAndConOps.sysml`)
Follow `workflows/d5_conops_derivation.md` and `references/opm_sysml_metamodel.md`:
1. Generate all operational activities taking place across installation, nominal operation, human interaction/bypass, maintenance, and degraded weather.
2. Find 5–7 Generalized Main Activities (`action def ... :> OperationalActivity`) and sequence them in a top-level ConOps scenario (`action def <System>ConOps`).
3. For each activity, generate its operands, states, enabling operators, and enabling structures, and cluster them into:
   - 5–7 Generalized Operands (`item def ... :> OperationalOperand`)
   - 5–7 Generalized States (`state def ... :> OperationalState` + `state def OperationalStates`)
   - 5–7 Generalized Enabling Operators (`part def ... :> EnablingOperator`)
   - 5–7 Generalized Enabling Structures (`part def ... :> EnablingStructure`)
4. Formally link every activity to its input/output operands (`in item`, `out item`, `inout item`), enabling operator (`enabledByOperator`), hosting structure (`hostedByStructure`), active state (`activeInState`), the D1 goals it addresses (`addressesGoal`), and the D1 gaps that affect it (`affectedByGap`).
5. Validate `D5_MissionsAndConOps.sysml` with `spec42 check .` (0 errors).

---

### Stage 3 — D2: Problem-Solving Functionality & Grounded Requirements (`D2_Capabilities.sysml`)
Follow `workflows/d2_problem_functionality.md`:
1. For each stakeholder goal, extract solution-neutral, stakeholder-oriented capabilities via user stories (`"As a <user>, I need to be able to <X>..."`).
2. Find 5–7 Generalized Capabilities (`action def ... :> SystemCapability`), bind `addressesGoal` and `decomposesToFunctionalities`, and commit both Tier 1 and Tier 2 capabilities.
3. For each generalized capability, generate specific problem-solving functionalities (`Verb + Noun`).
4. Find 5–7 Generalized System Functionalities (`action def ... :> SystemFunctionality`), bind `parentCapability` and `requirementGroup`, and commit both Tier 1 and Tier 2 functionalities.
5. Define 5–7 Requirement Groups (`requirement def ... :> RequirementGroup`), including a dedicated System Feasibility, LCC & Ownership group, and generate 5–9 quantitative, testable `SystemRequirement`s per group.
6. Ground every `SystemRequirement` via academic/industrial research, populating all required attributes (`reqId`, `statement`, `quantitativeMetric`, `verificationMethod`, `standardOrCitation`, `doiOrUrl` with active clickable URLs, `atomicSpec`, `physicsFormula`, `verifiedBenchmark`, `complianceMargin`, `requirementGroup`, `allocatedFunctionality`, `parentNeed`).
7. Validate `D2_Capabilities.sysml` with `spec42 check .` (0 errors).

---

### Stage 4 — D3: $N$-Candidate Trade Space, COTS Selection, & Pugh Evaluation (`D3_SolutionCandidates.sysml`)
Follow `workflows/d3_solution_trades.md`:
1. For each generalized functionality, generate $N = 6$ distinct solution candidates (`part def ... :> SolutionCandidate`) using real commercial off-the-shelf (COTS) technologies.
2. Persist **all $N$ candidates per functionality** in `D3_SolutionCandidates.sysml` with explicit `CandidateStatus` (`Winner`, `RunnerUp`, `Pruned`, `Rejected`), `bomCostUsd`, `diyAssemblyTimeMinutes`, `maturityTrl`, `verifiedDatasheetLink`, `rationale`, environmental sensitivity profiles, and Pugh scores (`pughPerformanceScore`, `pughCostScore`, `pughFeasibilityScore`, `pughMaintenanceScore`, `tradeScore`).
3. For the top candidates (`Winner` and `RunnerUp`), decompose their Bill of Materials into nested `part <name> : COTSComponent` blocks with real manufacturer part numbers (MPNs), distributors, unit prices, and clickable catalog links.
4. Define the resulting `Integrated<System>Candidate :> SolutionCandidate` (`primaryFunctionality = "IntegratedSystem"`) combining the winning modular sub-assemblies, and declare formal `satisfy <requirement> by <candidate>;` links for all evaluated candidates.
5. Validate the complete workspace with `spec42 check .` (0 errors).

---

### Stage 5 — Compile Printable Vector PDF Architecture Atlas
Run the bundled `sysml_atlas_generator.py` script on the workspace:
`python "C:\Users\yurie\.gemini\config\plugins\sysml-v2\skills\sysml-v2\scripts\sysml_atlas_generator.py" --model-dir . --output-pdf architecture_atlas_canonical.pdf`
Verify 100% node/edge coverage, 0 unrefined error blocks, all $N$-candidate trade matrices, and clickable links in the compiled PDF.
```

---

### Master Prompt B: Iterative Subsystem Zoom-In (Capability/Functionality $\rightarrow$ Subsystem)

Copy and paste the prompt below when you have an existing model and want to zoom in on a specific capability or functionality and engineer it as a subsystem:

```markdown
We have an existing validated SysML v2 system architecture in this workspace.
I want to **zoom in on the capability/functionality `<TargetCapabilityOrFunctionalityName>`** as a standalone **Subsystem-of-Interest (Level 1)** and perform full 5-Domain Systems Engineering for it.

Read and follow `workflows/subsystem_iteration.md` and `references/subsystem_zooming_guide.md` in the `sysml-v2` skill:

1. **Extract Parent Boundary Contract**:
   - Inspect the parent model (`D1`, `D5`, `D2`, `D3`) to extract all parent requirements, physical interfaces, power/latency budgets, CapEx allocation, and assembly time allocation assigned to `<TargetCapabilityOrFunctionalityName>` and its winning candidate.
   - Formulate the Level 1 Subsystem Framing Sentence:
     `[<Parent Host System>] derives value when [<Target Subsystem>] executes [<Target Functionality>]`
2. **Create Subsystem Workspace**:
   - Create `subsystems/<subsystem_slug>/` containing `D1_StakeholdersAndNeeds.sysml`, `D5_MissionsAndConOps.sysml`, `D2_Capabilities.sysml`, `D3_SolutionCandidates.sysml`, `Views.sysml`, and `main.sysml`.
3. **Execute the 5-Domain Loop for the Subsystem (Max 3 Concurrent Subagents)**:
   - **D1**: Model the Parent Host System, interfacing neighbor subsystems, hardware assembler, firmware/calibration operator, and supply chain as Stakeholders (Tier 1 & Tier 2). Convert the allocated parent requirements and budgets into the subsystem's 5–7 Operational Goals, and derive subsystem-level Operational Gaps and Needs (Tier 1 & Tier 2).
   - **D5**: In-zoom `<TargetCapabilityOrFunctionalityName>` into 5–7 internal sub-activities, internal micro-operands (signals, buffers, power, forces, heat), states, sub-operators, and physical internal structures.
   - **D2**: Derive 5–7 subsystem capabilities and 5–7 subsystem functionalities (Tier 1 & Tier 2), and formulate 25–30 quantitative sub-requirements (`REQ-TECH-01..25`, `REQ-FEAS-01..05`) with physics equations, benchmarks, Crossref DOIs, and sub-budget allocations that mathematically sum up to satisfy the parent system's budget.
   - **D3**: Generate and persist $N = 6$ sub-component candidates per subsystem functionality (`Winner`, `RunnerUp`, `Pruned`, `Rejected`) with real COTS sub-parts, MPNs, distributor links, Pugh scores, and `satisfy` statements.
4. **Validate & Generate Subsystem PDF Atlas**:
   - Validate `subsystems/<subsystem_slug>` with `spec42 check` (must be 0 errors).
   - Run `sysml_atlas_generator.py --model-dir "subsystems/<subsystem_slug>" --output-pdf "subsystems/<subsystem_slug>/subsystem_architecture_atlas.pdf"` and verify 100% node/edge coverage and 0 unrefined errors.
```
