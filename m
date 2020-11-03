From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 3 Nov 2020 14:10:43 +0100
Subject: [LTP] [PATCH v3 1/2] lib: Add generic boolean expression parser
 and eval
In-Reply-To: <87blge62vs.fsf@suse.de>
References: <20201103113821.6820-1-chrubis@suse.cz>
 <20201103113821.6820-2-chrubis@suse.cz> <87blge62vs.fsf@suse.de>
Message-ID: <20201103131043.GB8061@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +struct tst_expr {
> > +	struct tst_expr_tok *expr;
> 
> Maybe call this 'first' or 'head'?
> 
> > +	struct tst_expr_tok *buf;
> 
> I suppose that buf could be a trailing array saving a call to malloc and
> free :-)

Good point I do not know how I missed the simplest solution here.

> > +	if (!check_two(expr->buf[cnt-1].op)) {
> > +		expr->buf[cnt-1].priv = "Unfinished expression";
> > +		goto err;
> > +	}
> 
> This looks a bit odd as it is the only place you use buf like this. Why
> not only use buf until setting expr=out[0] (and only set buf=tok
> initially) or only use expr until free(expr->buf) and/or do --i and use
> that?

I guess that makes sense. I will changed that anyways if I convert the
structure to a trailing array.


-- 
Cyril Hrubis
chrubis@suse.cz
