% verbs.pl
% An attempt to understand German verb forms.
%
% Author: Kaitlin Hipkin

% ----------------------------------------------------------
% helper predicates
% ----------------------------------------------------------

%%
% full_german_verb_form(?V) - predicate that generates/verifies a German verb phrase
%
% ?V - a list of variables representing the verb phrase
full_german_verb_form(V) :-
	s(V, []).

% ----------------------------------------------------------
% phrase structure rules
% ----------------------------------------------------------

% the infinitive form of a verb
% s(Infinitive) --> verb(forms(Infinitive, _SimplePast, _Perfect)).

% ----------------------------------------------------------
% lexical rules
% ----------------------------------------------------------

% verb(forms(machen))	--> [machen].
% verb(forms(gehen))	--> [gehen].

%%
% definition(?GermanInf, ?EnglishInf) - predicate that stores the relationship
% between German infinitive forms and their English equivalents
%
% "-" is used to denote a seperable prefix; "+" is used to denote an inseparable prefix.
%
% ?GermanInf - the German infinitive verb form
% ?EnglishInf - the equivalent English infinitive verb form
%%
definition(machen, "to do").
definition(nehmen, "to take").
definition(gehen, "to go").
definition(informieren, "to inform").
definition(rufen, "to shout").
definition(an-rufen, "to call (on the phone)").
definition(sprechen, "to speak").
definition(ver+sprechen, "to promise").
definition(sammeln, "to collect").

%%
% infinitive(?V) - predicate for infinitive verb forms
%
% ?V - the infinitive verb form
%%
infinitive(V) :- definition(V, _).

%%
% ieren_infinitive(?V) - predicate for infinitive forms of "-ieren" verbs
%
% ?V - the infinitive verb form
%%
ieren_infinitive(V) :-
	infinitive(V),
	atomic(V),
	string_concat(_, "ieren", V).

%%
% verb_forms(?Infinitive, ?SimplePast, ?Perfect) - predicate that verifies/generates
% the forms of a German verb
%
% ?Infinitive - the infinitive verb form
% ?SimplePast - the simple past verb form
% ?Perfect - the perfect verb form
%%

% the forms of a verb with a seperable prefix
verb_forms(infinitive(Prefix-InfV),
			simple_past(SimpPastInf-" "-Prefix),
			perfect(HelpVInf,Prefix-PastPart)) :-
	infinitive(Prefix-InfV),
	infinitive(InfV),
	verb_forms(infinitive(InfV), simple_past(SimpPastInf), perfect(HelpVInf,PastPart)).

% the forms of a verb with an inseparable prefix
verb_forms(infinitive(Prefix+InfV),
			simple_past(Prefix+SimpPastInf),
			perfect(HelpVInf,Prefix+PastPart)) :-
	infinitive(Prefix+InfV),
	infinitive(InfV),
	verb_forms(infinitive(InfV), simple_past(SimpPastInf), perfect(HelpVInf,BasePastPart)),
	string_concat(ge, PastPart, BasePastPart).

% the forms of an -ieren verb
verb_forms(infinitive(InfV), simple_past(SimpPastInf), perfect(haben,PastPart)) :-
	ieren_infinitive(InfV),
	string_concat(Root, "ieren", InfV),
	string_concat(Root, "ierten", SimpPastInf),
	string_concat(Root, "iert", PastPart).

% the forms of base verbs
verb_forms(infinitive(machen), simple_past(machten), perfect(haben,gemacht)).
verb_forms(infinitive(nehmen), simple_past(nahmen), perfect(haben,genommen)).
verb_forms(infinitive(gehen), simple_past(gingen), perfect(sein,gegangen)).
verb_forms(infinitive(rufen), simple_past(ruften), perfect(haben,gerufen)).
verb_forms(infinitive(sprechen), simple_past(sprachen), perfect(haben,gesprochen)).
verb_forms(infinitive(sammeln), simple_past(sammelten), perfect(haben,gesammelt)).

% unit tests
%
% start unit tests, prove
% ?- run_tests.
%
:- begin_tests(verb_forms).

% test if verbs with seperable prefix are conjugated based on the root verb
test(sep_prefix_from_root) :-
    once(infinitive(Prefix-Inf)),
    verb_forms(infinitive(Inf), _, _),
    verb_forms(infinitive(Prefix-Inf), _, _).

% test if verbs with inseparable prefix are conjugated based on the root verb
test(insep_prefix_from_root) :-
    once(infinitive(Prefix+Inf)),
    verb_forms(infinitive(Inf), _, _),
    verb_forms(infinitive(Prefix+Inf), _, _).

% test if "-ieren" verbs can be conjugated
test(ieren_infinitive) :-
	once(ieren_infinitive(Inf)),
    verb_forms(infinitive(Inf), _, _).

% test if verb_forms can handle "-eln" verbs
test(eln_verb_forms) :-
    verb_forms(infinitive(ElnInf), _, _),
    atomic(ElnInf),
	string_concat(_, "eln", ElnInf).

:- end_tests(verb_forms).
