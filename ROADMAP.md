Create a roadmap of how this project will proceed.

A sensible roadmap for Elowen is phased, so you always have something usable while you expand capabilities and risk surface. Below is a practical sequence you can actually follow.

## Phase 0 – Vision, constraints, and repo setup

- Write down Elowen’s initial scope (domains, platforms, and what you explicitly do *not* want it to touch yet).  
- Finalize the permission matrix (your “explicit permission / confirmation / allowed / not allowed” list) as a versioned config document in the repo.  
- Initialize the GitHub repo with: `README.md`, a `/docs` folder, and a `/server` folder for the core service.

## Phase 1 – Core service and safety layer

- Choose primary stack (Python for the backend service), and define a simple JSON/YAML schema for actions and policies (EXPLICIT_PERMISSION, CONFIRMATION, PERMITTED, NOT_ALLOWED).  
- Implement a small backend service that:  
  - Exposes a basic HTTP API (for future UIs and automations).  
  - Contains the policy engine that takes an “intended action” and decides whether to execute, request confirmation, or reject.  
  - Logs every action and decision to an append‑only log.  

## Phase 2 – LLM integration and text interface

- Integrate the LLM (e.g., Gemini) via its HTTP API from the backend, using function/tool‑calling so the model can suggest structured actions rather than free text.  
- Implement a minimal web or terminal chat client that:  
  - Sends your messages plus current context to the backend.  
  - Shows Elowen’s responses and any pending approvals (with previews for high‑risk actions).  
- Wire the LLM output into the policy engine: model proposes actions → policy checks → either execute, ask you, or deny.

## Phase 3 – Google ecosystem, read‑mostly

- Implement Google OAuth flow and store refresh tokens securely on the host machine (not in Git).  
- Add **read‑only** tools for:  
  - Calendar (list events, free/busy, upcoming week).  
  - Gmail (list threads, fetch bodies/metadata in safe scopes).  
  - Drive (list and read selected files/folders).  
- Teach Elowen to answer questions like “What does my week look like?” or “What’s still open from last week’s emails?” using those tools.

## Phase 4 – Controlled write actions (with guardrails)

- Add tools with policy‑enforced behavior for:  
  - Drafting emails (never send without explicit permission).  
  - Creating new calendar events (confirmation required).  
  - Creating/updating tasks in your chosen store (confirmation required).  
  - Modifying existing calendar events (explicit permission only).  
- Build UI flows to show previews (email body, event fields, task content) and let you approve/deny each proposal quickly.

## Phase 5 – Goals, projects, and proactivity

- Define a simple schema and storage for goals and projects (e.g., a local database or markdown/JSON in a `data/` directory).  
- Give Elowen tools to read/update goals, and a periodic job (e.g., cron) to:  
  - Run a morning planning pass (reconcile goals with calendar and tasks).  
  - Run an evening review (log progress, suggest adjustments).  
- Add event‑based triggers:  
  - New important email.  
  - New meeting scheduled.  
  - Approaching deadlines.  

## Phase 6 – Sensors: context from devices and network

- Start with low‑risk sensors:  
  - Network monitoring (ping key devices/services, check status, feed summaries to Elowen).  
  - Basic desktop context (active window title, app name) from your main workstation, sent to the backend at intervals.  
- Later, add optional higher‑sensitivity sensors behind explicit opt‑in:  
  - Location events from your phone (home/office/gym/commute).  
  - Meeting transcripts for calls (via a recorder or existing meeting‑assistant tool).  
- Extend Elowen’s reasoning to use this context for proactive suggestions, while still routing all external actions through the policy engine.

## Phase 7 – Voice, wake word, and UX polish

- Integrate speech‑to‑text and text‑to‑speech on the backend or via cloud services, exposing a streaming API or websocket to clients.  
- Implement a wake‑word client on desktop/phone (“Hey Elowen”) that:  
  - Records short utterances after the wake word.  
  - Sends them to the backend, then plays back the synthesized response.  
- Refine UX: quick‑approve prompts, dashboards for pending actions, and clear status indicators (listening vs idle vs offline).

## Phase 8 – Hardening, testing, and iteration

- Add automated tests for:  
  - Policy enforcement (e.g., emails are never sent without explicit permission, calendar edits always ask).  
  - Tool contracts and error handling.  
- Add “red‑team” scenarios to a test suite (ambiguous instructions, mis‑detected intents, adversarial prompts) to see how Elowen behaves and tighten rules.  
- Periodically review logs, adjust policies (e.g., promote some safe actions from explicit → confirm → allowed), and refine prompts/instructions to better match how you want Elowen to behave.

## Phase 9 – Optional extensions

- Avatar UI (web/desktop) for a more “butler‑like” presence.  
- Additional ecosystems (e.g., task managers, note systems, smart‑home platforms).  
- Lightweight local models on the Pi for pre‑classification or offline triage, with the main LLM reserved for complex reasoning.

This roadmap keeps risk front‑loaded on design and guardrails, then gradually adds power: **text → tools → goals → sensors → voice**, with continuous testing and policy refinement along the way.

Citations:
[1] Download Technology Roadmap Template [2025] - Superjoin https://www.superjoin.ai/templates/technology-roadmap-template
[2] Best Roadmap Template | Free & Editable in Bit.ai https://bit.ai/templates/roadmap-template
[3] Project roadmap template (AI-powered customization) - Storydoc https://www.storydoc.com/slides/project-roadmap
[4] Customize AI Roadmap Templates Online - Taskade https://www.taskade.com/templates/roadmap
[5] Ai Roadmap - Figma https://www.figma.com/community/plugin/1252751988403263762/ai-roadmap
[6] AI Roadmap Generator Tool - Semblian https://www.sembly.ai/ai-roadmap-generator/
[7] How to Create an AI Product Roadmap (That Actually Works) https://www.news.aakashg.com/p/ai-roadmap
[8] Project Plan Template | Beautiful.ai https://www.beautiful.ai/presentations/project-plan
[9] Free and customizable roadmap templates - Canva https://www.canva.com/templates/s/roadmap/
[10] Roadmap Planning: A Must-Have Guide for PMs - Aha.io https://www.aha.io/roadmapping/guide/roadmap/ultimate-guide
