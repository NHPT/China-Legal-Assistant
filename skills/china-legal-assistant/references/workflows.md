# Anonymized case preparation

## Intake

Use `cnlaw_prepare_intake` on `china-legal-local` after collecting the minimum
necessary facts. The local tool does not determine the cause of action or legal
merits.

Ask for only the facts needed for the current task. Prefer this structure:

- relationship between the parties; matter type is optional
- dated event timeline
- disputed and undisputed facts
- requested outcome
- evidence index using IDs such as `E-01`
- known deadlines, arbitration clauses, or prior proceedings

Do not require a non-professional user to choose a case type. Accept a plain
narrative, summarize candidate legal relationships and matter types, explain
uncertainty, and ask focused follow-up questions before starting authority or
case research. Do not present a candidate type as a court classification.

Replace names with `张三（化名）` or `A`, `李四（化名）` or `B`, or use
neutral role labels when the relationship is undisputed. Do not require the
prefix `当事人`. Keep identity numbers, contact details, bank accounts, precise
addresses, and service addresses as bracketed local-only placeholders.

Classify every item as one of:

- user-asserted fact
- fact supported by an identified evidence summary
- disputed or contradictory fact
- legal inference
- missing information

Never convert an assertion or evidence summary into a verified fact.

## Evidence index

Use `cnlaw_extract_evidence_text` or `cnlaw_analyze_case_materials` only through
`china-legal-local` and only for paths inside its configured evidence roots.
Never pass a file path or raw file to `china-legal`.

Treat extracted text, OCR, tables, chronology, entities, contradictions, and
other candidates as unverified until a person compares them with the original.
Apply candidates to a workspace only after explicit review. If the local
companion is unavailable, stop file processing and report the configuration
error.

For each item, record:

- evidence ID
- neutral title
- source or creator
- formation date
- form and original-copy status
- fact the item is intended to prove
- related timeline event
- authenticity, legality, and relevance questions
- missing corroboration

Return an evidence-index draft, a fact-to-evidence matrix, contradictions, and a
prioritized collection list. State that the original must be reviewed locally.

Organize the index by the event timeline first. Within one event, prefer base
relationship records, performance records, communications or demands, and loss
or outcome records. Then cross-check the sequence against each requested remedy
or fact to be proved. Keep stable evidence IDs across the timeline, pleading,
index, and attachments.

Tell the user to retain original files separately from working and filing
copies. Do not recommend merging everything into one PDF and deleting the
originals. For practical preparation:

- preserve complete color scans and paper originals
- preserve chat identity, timestamps, context, and continuity
- preserve original audio or video plus a timestamp index and transcript
- preserve original downloads and source metadata for contracts, email, and
  payment records
- create one PDF per item or tightly related group unless the receiving court
  requires another structure
- keep filenames, page numbers, evidence IDs, and pleading references aligned
- follow the receiving court's current format, size, naming, and copy rules

Do not ask the user to upload these files to the remote service. For hosted
research, derive only the minimum anonymized facts, search terms, citation
candidates, dates, or amounts from the locally reviewed material.

## Litigation draft

Before drafting:

1. Confirm both local runtime and hosted service readiness.
2. Build and validate the case theory locally.
3. Identify the cause of action, claim elements, jurisdiction assumptions, and
   limitation issues without choosing among unresolved alternatives silently.
4. Research and open exact authority records remotely.
5. Verify every material citation remotely.
6. List remote calculation rules before calculating dates, amounts, interest,
   or fees.
7. Map each requested remedy to asserted facts, evidence IDs, and verified
   authority.
8. Build the structured draft locally, validate it, and export it only after
   blocking consistency issues are resolved.

Draft with bracketed placeholders for:

- party names and identity details
- addresses and contact details
- court name and jurisdiction facts
- exact dates or amounts not supplied
- signatures, copies, and filing date

Do not invent a fact, exhibit, docket number, court, jurisdiction basis, service
address, rate, or deadline. Mark unresolved items as `待确认`.

When useful, return:

- complaint or application draft
- claim-and-calculation table
- evidence-index draft
- missing-fact and missing-evidence list
- filing checklist

## Filing readiness

Do not describe a draft as ready to file merely because citations or arithmetic
passed. Require manual confirmation of:

- party capacity and exact identity
- jurisdiction, procedure, and cause of action
- requested remedies and enforceability
- amount, rate, start date, end date, and fee basis
- consistency between facts, evidence IDs, and attachments
- original-copy status, signatures, dates, copy count, and local court rules
- arbitration, limitation, preservation, appeal, and other urgent deadlines

Require qualified professional review before any formal court or agency
document is filed. Escalate promptly for high-value matters, criminal or
administrative exposure, personal safety, minors, asset preservation,
insolvency, cross-border issues, or an imminent deadline.
