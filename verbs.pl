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
% verb_forms(?Infinitive, ?SimplePast, ?Perfect) - predicate that verifies/generates
% the forms of a German verb
%
% ?Infinitive - the infinitive verb form
% ?SimplePast - the simple past verb form
% ?Perfect - the perfect verb form
%%
verb_forms(infinitive(machen), simple_past(machten), perfect(haben,gemacht)).
verb_forms(infinitive(nehmen), simple_past(nahmen), perfect(haben,genommen)).
verb_forms(infinitive(gehen), simple_past(gingen), perfect(sein,gegangen)).
verb_forms(infinitive(informieren), simple_past(informierten), perfect(haben, informiert)).
