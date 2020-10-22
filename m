From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 22 Oct 2020 10:57:56 +0200
Subject: [LTP] [PATCH 2/3] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <87pn5avgob.fsf@suse.de>
References: <20201020100910.10828-1-chrubis@suse.cz>
 <20201020100910.10828-3-chrubis@suse.cz> <871rhrwnb7.fsf@suse.de>
 <20201021182001.GF10861@yuki.lan> <87pn5avgob.fsf@suse.de>
Message-ID: <20201022085756.GB2427@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> > +enum tst_op char_to_op(char c)
> >> > +{
> >> > +	switch (c) {
> >> > +	case '(':
> >> > +		return TST_OP_LPAR;
> >> > +	case ')':
> >> > +		return TST_OP_RPAR;
> >> > +	case '&':
> >> > +		return TST_OP_AND;
> >> > +	case '|':
> >> > +		return TST_OP_OR;
> >> > +	case '!':
> >> > +		return TST_OP_NOT;
> >> > +	default:
> >> > +		return -1;
> >> 
> >> This should probably be an enum value like TST_OP_INVAL (still may be
> >> -1), otherwise it is likely to confuse static anlyses tools.
> >
> > I tried to avoid adding more enum values since that means that we have
> > to explicitly handle them in all switch () bodies. So I'm not sure what
> > is worse, adding nop case to a few of these or having numeric value like
> > that.
> 
> I think it is usually enough to have a 'default' in the switch statement
> to prevent warnings about unhandled values?

That is IMHO wrong as well since this solution defeats the purpose of
the warning in the first place. I do actually like that warning since it
tells me that I have forgotten something.

> Of course there is still a tradeoff here, because you end up with an
> enum containing unrelated values.

And loose the warning as well.

> >> > +{
> >> > +	if (stack_empty(stack_pos))
> >> > +		return -1;
> >> > +
> >> > +	return stack[stack_pos - 1]->op;
> >> > +}
> >> 
> >> Perhaps we should copy & paste the dynamic preallocated vector we
> >> created for gfxprim? We are doing a bunch of mallocs and reinventing
> >> linked lists and stacks, which can all be represented by the vector
> >> IIRC.
> >
> > I do not think that it would work for the tokenizer/RPN since we reorder
> > that and free things from the middle vector is not ideal data structure
> > for that, link list is better suited for that work. And as for the stack
> > we use, these have nice upper bound on size so we do not really need
> > dynamic array for that.
> 
> Well it is not really about needing it just for this, I'm more thinking
> about deduplicating array, stack and list code in general. However I
> guess this can be dealt with separately.

Actually I think that with the token with indexes I can simplify the
code even further and get rid of some.

Thanks for the review I will send a v2 later on.

-- 
Cyril Hrubis
chrubis@suse.cz
