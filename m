Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <filippo.arcidiacono@st.com>) id 1RxaDW-00005Y-Iw
	for ltp-list@lists.sourceforge.net; Wed, 15 Feb 2012 08:27:58 +0000
Received: from eu1sys200aog107.obsmtp.com ([207.126.144.123])
	by sog-mx-4.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RxaDV-0005Sh-HG
	for ltp-list@lists.sourceforge.net; Wed, 15 Feb 2012 08:27:58 +0000
From: Filippo ARCIDIACONO <filippo.arcidiacono@st.com>
References: <1329233615-16625-1-git-send-email-filippo.arcidiacono@st.com>
	<4F3B2FFD.3020408@casparzhang.com>
In-Reply-To: <4F3B2FFD.3020408@casparzhang.com>
Date: Wed, 15 Feb 2012 09:27:19 +0100
Message-ID: <01df01ccebbb$a2d43650$e87ca2f0$@arcidiacono@st.com>
MIME-Version: 1.0
Content-Language: en-us
Subject: Re: [LTP] [PATCH] getrusage03: add opportunity to reduce memory
	allocation's size
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Caspar Zhang' <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

 [snip]

> >  static void inherit_fork(void);
> >  static void inherit_fork2(void);
> > @@ -77,11 +78,23 @@ int main(int argc, char *argv[])
> >
> >  	setup();
> >
> > +	if (argc > 2)
> > +		tst_brkm(TBROK, cleanup, " Too many arguments - Usage: %s
> [factor]", argv[0]);
> > +
> > +	if (argv[1])
> > +		factor_nr = atoi(argv[1]);
> > +
> > +	if (factor_nr == 0)
> > +		tst_brkm(TBROK, cleanup, "Input factor must be != 0");
> 
> Here I want to use an LTP way to pass parameters, i.e. use option_t and
> parse_opts.
> 
> Please take a look at getrusage03_child.c as example.

I have seen that but, I haven't done because it needs to pass only one number.
In any case I will follow your suggestion.

> 
> > +
> > +	tst_resm(TINFO, "Using %d as factor allocation mamory!",
> factor_nr);
> > +
> >  	for (lc = 0; TEST_LOOPING(lc); lc++) {
> >  		Tst_count = 0;
> >
> > -		tst_resm(TINFO, "allocate 100MB");
> > -		consume(100);
> > +		size = 10 * factor_nr;
> > +		tst_resm(TINFO, "allocate %dMB", size);
> > +		consume(size);
> >
> >  		inherit_fork();
> >  		inherit_fork2();
> > @@ -123,17 +136,17 @@ static void inherit_fork(void)
> >  }
> >
> >  /* Testcase #02: fork inherit (cont.)
> > - * expect: initial.children ~= 100MB, child.children = 0 */
> > + * expect: initial.children ~= (10 * factor_nr)MB, child.children =
> 0 */
> >  static void inherit_fork2(void)
> >  {
> >  	tst_resm(TINFO, "Testcase #02: fork inherit(cont.)");
> >
> >  	SAFE_GETRUSAGE(cleanup, RUSAGE_CHILDREN, &ru);
> >  	tst_resm(TINFO, "initial.children = %ld", ru.ru_maxrss);
> > -	if (is_in_delta(ru.ru_maxrss - 102400))
> > -		tst_resm(TPASS, "initial.children ~= 100MB");
> > +	if (is_in_delta(ru.ru_maxrss - (10240 * factor_nr)))
> > +		tst_resm(TPASS, "initial.children ~= %dMB", size);
> 
> `size` in this function is not initialized?

'size' is globally defined, it is initialized in the main().

> 
> >  	else
> > -		tst_resm(TFAIL, "initial.children !~= 100MB");
> > +		tst_resm(TFAIL, "initial.children !~= %dMB", size);
> >
> >  	switch (pid = fork()) {
> >  	case -1:
> > @@ -153,9 +166,11 @@ static void inherit_fork2(void)
> >  }
> >

Thanks for the review.

Filippo.


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
