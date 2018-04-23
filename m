From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Apr 2018 16:19:54 +0200
Subject: [LTP] [PATCH v3 2/2] network/in6_02: Rewrite to the new library
In-Reply-To: <3e9d5d4f-18f8-51b3-746c-e64a6cf4cf68@oracle.com>
References: <20180420072122.16897-1-pvorel@suse.cz>
 <20180420072122.16897-2-pvorel@suse.cz>
 <3e9d5d4f-18f8-51b3-746c-e64a6cf4cf68@oracle.com>
Message-ID: <20180423141954.f4fymitm2kuw7ede@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alexey,


> > -	tst_resm(TPASS, "if_indextoname() tests succeed");
> > +	tst_res(TPASS, "if_indextoname() test succeed");
>                                                  ^
>                                              succeeded?

> >  }...
> > -	for (i = 0; pini[i].if_index; ++i) {
> > +	for (i = 0; pini[i].if_index; i++) {
> ... 
> > +	/*
> > +	 * we need to leak at least a page to detect a leak; 1 byte per call
> >  	 * will be detected with getpagesize() calls.
> >  	 */
> >  	freenicount = getpagesize();
> > -	for (i = 0; i < freenicount; ++i) {
> > +	for (i = 0; i < freenicount; i++) {

> Hmm, looks like you are intentionally changing '++i' with 'i++' for
> the all 'for' loops in this patch, any good reason to do that?


> Other than that, the patch looks good.

Pushed both patches with changes you requested and your Ack-by.
Thanks a lot for a review.


Kind regards,
Petr
