# Remote legal research

## Authorities

1. Check `cnlaw_system_status`.
2. Use `cnlaw_list_corpus_sources` when freshness or coverage is material.
3. For material or time-sensitive authorities, call
   `cnlaw_check_legal_updates` with `official_check: true` and exact titles.
4. Stop and disclose the limitation if the result is not `current`; the tool
   does not update the production corpus.
5. Search with `cnlaw_search_authorities`.
6. Open exact records with `cnlaw_get_authority`.
7. Verify quoted text, title, article, effect date, and status with
   `cnlaw_verify_citations`.

Do not convert a result outside the production corpus into a verified conclusion.

## Cases

Use `cnlaw_extract_case_factors`, `cnlaw_search_cases`, and
`cnlaw_compare_case_holdings` only after statutes and judicial interpretations
have been checked. Every case remains `reference_only`. Explain meaningful fact
differences instead of relying on the similarity score.

## Calculations

Call `cnlaw_list_calculation_rules` before using:

- `cnlaw_calculate_deadline`
- `cnlaw_calculate_claim_amount`
- `cnlaw_calculate_litigation_fee`

The caller must supply and justify the applicable start date, period, interest
rate, adjustment, and calculation basis. The tools perform deterministic
calculation, not rule selection.
