From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 22 Oct 2020 08:55:00 +0100
Subject: [LTP] [PATCH 2/3] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <20201021182001.GF10861@yuki.lan>
References: <20201020100910.10828-1-chrubis@suse.cz>
 <20201020100910.10828-3-chrubis@suse.cz> <871rhrwnb7.fsf@suse.de>
 <20201021182001.GF10861@yuki.lan>
Message-ID: <87pn5avgob.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:
>
>> > +enum tst_op char_to_op(char c)
>> > +{
>> > +	switch (c) {
>> > +	case '(':
>> > +		return TST_OP_LPAR;
>> > +	case ')':
>> > +		return TST_OP_RPAR;
>> > +	case '&':
>> > +		return TST_OP_AND;
>> > +	case '|':
>> > +		return TST_OP_OR;
>> > +	case '!':
>> > +		return TST_OP_NOT;
>> > +	default:
>> > +		return -1;
>> 
>> This should probably be an enum value like TST_OP_INVAL (still may be
>> -1), otherwise it is likely to confuse static anlyses tools.
>
> I tried to avoid adding more enum values since that means that we have
> to explicitly handle them in all switch () bodies. So I'm not sure what
> is worse, adding nop case to a few of these or having numeric value like
> that.

I think it is usually enough to have a 'default' in the switch statement
to prevent warnings about unhandled values?

Of course there is still a tradeoff here, because you end up with an
enum containing unrelated values.

>
>> > +	}
>> > +}
>> > +
>> > +static struct tst_expr *new_op(char c)
>> > +{
>> > +	struct tst_expr *ret;
>> > +
>> > +	ret = malloc(sizeof(struct tst_expr));
>> > +	if (!ret)
>> > +		return NULL;
>> > +
>> > +	ret->op = char_to_op(c);
>> > +	ret->next = NULL;
>> > +	ret->err = NULL;
>> > +
>> > +	return ret;
>> > +}
>> > +
>> > +struct op_list {
>> > +	struct tst_expr *first;
>> > +	struct tst_expr *last;
>> > +	unsigned int cnt;
>> > +};
>> > +
>> > +static void op_list_append(struct op_list *list, struct tst_expr *val)
>> > +{
>> > +	if (!val)
>> > +		return;
>> > +
>> > +	if (!list->first)
>> > +		list->first = val;
>> > +
>> > +	if (list->last)
>> > +		list->last->next = val;
>> > +
>> > +	list->last = val;
>> > +
>> > +	list->cnt++;
>> > +}
>> > +
>> > +static void tokenize(const char *expr, struct op_list *ret)
>> > +{
>> > +	struct tok buf = {};
>> > +	size_t i;
>> > +
>> > +	for (i = 0; expr[i]; i++) {
>> > +		switch (expr[i]) {
>> > +		case '(':
>> > +		case ')':
>> > +		case '!':
>> > +		case '&':
>> > +		case '|':
>> > +			op_list_append(ret, new_var(tok_get(&buf)));
>> > +			op_list_append(ret, new_op(expr[i]));
>> > +		break;
>> > +		case '\t':
>> > +		case ' ':
>> > +			op_list_append(ret, new_var(tok_get(&buf)));
>> > +		break;
>> > +		default:
>> > +			tok_append(&buf, expr[i]);
>> > +		break;
>> > +		}
>> > +	}
>> > +
>> > +	op_list_append(ret, new_var(tok_get(&buf)));
>> > +}
>> > +
>> > +void tst_bool_expr_print(FILE *f, struct tst_expr *expr)
>> > +{
>> > +	struct tst_expr *i;
>> > +	int prev_op = 0;
>> > +
>> > +	for (i = expr; i; i = i->next) {
>> > +		if (i->op != TST_OP_VAR && prev_op)
>> > +			fprintf(f, " ");
>> > +
>> > +		switch (i->op) {
>> > +		case TST_OP_AND:
>> > +			fprintf(f, "&");
>> > +		break;
>> > +		case TST_OP_OR:
>> > +			fprintf(f, "|");
>> > +		break;
>> > +		case TST_OP_NOT:
>> > +			fprintf(f, "!");
>> > +		break;
>> > +		case TST_OP_LPAR:
>> > +			fprintf(f, "(");
>> > +		break;
>> > +		case TST_OP_RPAR:
>> > +			fprintf(f, ")");
>> > +		break;
>> > +		case TST_OP_VAR:
>> > +			fprintf(f, " %s ", i->val);
>> > +		break;
>> > +		}
>> > +
>> > +		if (i->op == TST_OP_VAR)
>> > +			prev_op = 0;
>> > +		else
>> > +			prev_op = 1;
>> > +	}
>> > +}
>> > +
>> > +static void tst_bool_expr_err(FILE *f, struct tst_expr *expr)
>> > +{
>> > +	struct tst_expr *i;
>> > +	int prev_op = 0;
>> > +	unsigned int spaces = 0;
>> > +
>> > +	fprintf(f, "\n");
>> > +
>> > +	for (i = expr; i; i = i->next) {
>> > +		if (i->err)
>> > +			break;
>> > +
>> > +		if (i->op != TST_OP_VAR && prev_op)
>> > +			spaces++;
>> > +
>> > +		switch (i->op) {
>> > +		case TST_OP_VAR:
>> > +			spaces += 2 + strlen(i->val);
>> > +		break;
>> > +		default:
>> > +			spaces++;
>> > +		}
>> > +
>> > +		if (i->op == TST_OP_VAR)
>> > +			prev_op = 0;
>> > +		else
>> > +			prev_op = 1;
>> > +	}
>> > +
>> > +	while (spaces--)
>> > +		putc(' ', f);
>> > +
>> > +	fprintf(f, "^\n");
>> > +	fprintf(f, "%s\n", i->err);
>> > +}
>> > +
>> > +static inline void stack_push(struct tst_expr *stack[], unsigned int *stack_pos,
>> > +                              struct tst_expr *op)
>> > +{
>> > +	stack[(*stack_pos)++] = op;
>> > +}
>> > +
>> > +static inline int stack_empty(unsigned int stack_pos)
>> > +{
>> > +	return stack_pos == 0;
>> > +}
>> > +
>> > +static inline struct tst_expr *stack_pop(struct tst_expr *stack[],
>> > +                                          unsigned int *stack_pos)
>> > +{
>> > +	if (stack_empty(*stack_pos))
>> > +		return NULL;
>> > +
>> > +	return stack[--(*stack_pos)];
>> > +}
>> > +
>> > +static inline enum tst_op stack_top_op(struct tst_expr *stack[],
>> > +                                       unsigned int stack_pos)
>> 
>> Just a nit, but usually this is called peek, right?
>> 
>> As we are peeking at the top/next entry without removing it.
>
> I guess that stack_peek_op() may be better name, it has to have the
> _op there since we dereference.

+1

>
>> > +{
>> > +	if (stack_empty(stack_pos))
>> > +		return -1;
>> > +
>> > +	return stack[stack_pos - 1]->op;
>> > +}
>> 
>> Perhaps we should copy & paste the dynamic preallocated vector we
>> created for gfxprim? We are doing a bunch of mallocs and reinventing
>> linked lists and stacks, which can all be represented by the vector
>> IIRC.
>
> I do not think that it would work for the tokenizer/RPN since we reorder
> that and free things from the middle vector is not ideal data structure
> for that, link list is better suited for that work. And as for the stack
> we use, these have nice upper bound on size so we do not really need
> dynamic array for that.

Well it is not really about needing it just for this, I'm more thinking
about deduplicating array, stack and list code in general. However I
guess this can be dealt with separately.

>
>> > +
>> > +/*
>> > + * This is a complete list of which tokens can happen before any of:
>> > + *  - variable
>> > + *  - left parentesis
>> > + *  - negation
>> > + *
>> > + * The -1 represents start of the expression.
>> 
>> Then it should have an entry in the enum.
>
> Same here, if we do that we will end up with nop cases in a few switches
> to avoid warnings.
>
>> > + */
>> > +static inline int check_one(int op)
>> 
>> I guess there is no good name for this xD
>
> As far as I can tell no there isn't :-).
>
>> > +{
>> > +	switch (op) {
>> > +	case TST_OP_AND:
>> > +	case TST_OP_OR:
>> > +	case TST_OP_NOT:
>> > +	case -1:
>> > +	case TST_OP_LPAR:
>> > +		return 0;
>> > +	default:
>> > +		return 1;
>> > +	}
>> > +}
>> > +
>> > +/*
>> > + * And this checks for tokens that can happen before any of:
>> > + * - right parentesis
>> > + * - and
>> > + * - or
>> > + *
>> > + * This is also used to check that the last token in expression is correct one.
>> > + */
>> > +static inline int check_two(int op)
>> > +{
>> > +	switch (op) {
>> > +	case TST_OP_VAR:
>> > +	case TST_OP_RPAR:
>> > +		return 1;
>> > +	default:
>> > +		return 0;
>> > +	}
>> > +}
>> > +
>> > +static struct tst_expr *shunting_yard(struct op_list *list)
>> > +{
>> 
>>         /* Translator stack */
>> > +	struct tst_expr *stack[list->cnt];
>> > +	unsigned int stack_pos = 0;
>
> Or we can reame this to op_stack[]; I prefer naming variables
> reasonably.
>
>> > +	struct tst_expr *out[list->cnt + 1];
>> > +	unsigned int out_pos = 0;
>> > +	struct tst_expr *pars[list->cnt];
>> > +	unsigned int pars_pos = 0;
>> 
>> It seems we just push stuff to this stack then free everything at the
>> end?
>
> Yes, since we eliminate parentesis during the RPN transformation but we
> have to free the allocated memory at the end.
>
>> > +	struct tst_expr *i;
>> > +	unsigned int j;
>> > +	int prev_op = -1;
>> 
>> enum tst_op prev_op = TST_OP_START;
>> 
>> > +
>> > +	for (i = list->first; i; i = i->next) {
>> > +		switch (i->op) {
>> > +		case TST_OP_VAR:
>> > +			if (check_one(prev_op) && prev_op != TST_OP_LPAR) {
>> > +				i->err = "Expected operation";
>> > +				goto err;
>> > +			}
>> > +
>> > +			stack_push(out, &out_pos, i);
>> > +
>> > +			/* pop all negations */
>> 
>> Clearly :-)
>> 
>> This is not the hardest thing to understand here!
>
> I guess so, will remove the comment.
>
> Are there any places in the code that are not commented and should be?

I don't think so, unless you have references/links which you think would
be particularly useful for understanding this implementation of the
algorithm?

-- 
Thank you,
Richard.
