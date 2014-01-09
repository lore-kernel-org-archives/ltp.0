Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1Duh-00064b-KW
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 11:36:39 +0000
Date: Thu, 9 Jan 2014 12:36:19 +0100
From: chrubis@suse.cz
Message-ID: <20140109113619.GB5125@rei.Home>
References: <1387358991.1664.37.camel@G08JYZSD130126>
	<20140107140910.GD27135@rei.Home>
	<1389191490.2879.27.camel@G08JYZSD130126>
	<20140108151501.GA1556@rei>
	<1389254938.2025.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1389254938.2025.3.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] clone/clone08.c: check whether clone supports 7
	arguments
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> > > +#else
> > > +int ltp_clone(unsigned long clone_flags, int (*fn)(void *arg), void *arg,
> > > +		size_t stack_size, void *stack);
> > > +#endif
> > 
> > I wonder if having two different definitions is worth the trouble.
> > Because we can easily use the definition with the ... in both cases.
> > 
> > The result is not optimal in either case. In the first case there would
> > be compilation failures on older distributions, in the second there is a
> > posibility that some of the arguments are ignored if test is not ifdefed
> > properly. I think I like the second case better.
> > 
> Hi
> What do you think that we create a new ltp_clone7args function when
> the HAVE_CLONE7ARGS macro is defined.
> If so, the existing clone test cases will not be affected. And test
> cases,
> like clone08, need 7 arguments, using ltp_clone7args will be ok.

Sounds good but I would go just with ltp_clone7() (there is a tradition
of adding just the number of arguments to newly added functions with the
same name see 'man 2 wait4' for example).

> > Is this string really over 80 chars?
> > 
> > Also in this case it should be main(void) to avoid unused warnings.
> > 
> > And I would rather see one TCID and TST_TOTAL at the top of the test
> > (before the #ifdef HAVE_CLONE7ARGS).
> In clone08, TCID really should be put at the top, sorry.
>  
> But TST_TOTAL is computed by  ARRAY_SIZE(test_cases) when macro
> HAVE_CLONE7ARGS is defined.  When not defined,  TST_TOTAL should be 1.
> It seems that we couldn't put the TST_TOTAL at the top.

I think that even when all the test does it TCONF it should really print
how much of test cases it has skipped, so TST_TOTAL should be
initialized correctly even in this case, but given the fact that it's
complicated in this case settiing it to 1 is also ok.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
