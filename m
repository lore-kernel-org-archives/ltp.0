Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zenglg.jy@cn.fujitsu.com>) id 1Wyu03-00086L-S2
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 02:28:51 +0000
Received: from [59.151.112.132] (helo=heian.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Wyu01-0002TG-Ih
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 02:28:51 +0000
Message-ID: <1403490467.2219.5.camel@G08JYZSD130126>
From: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Date: Mon, 23 Jun 2014 10:27:47 +0800
In-Reply-To: <462849312.27746159.1403256946743.JavaMail.zimbra@redhat.com>
References: <1403248796.26126.0.camel@G08JYZSD130126>
	<462849312.27746159.1403256946743.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH 1/2] wait/wait02: cleanup
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Fri, 2014-06-20 at 05:35 -0400, Jan Stancek wrote:
> >  int TST_TOTAL = 1;
> >  
> > -int exp_enos[] = { 0, 0 };
> > +static int exp_enos[] = { 0, 0 };
> 
> This looks like it can be removed along with TEST_EXP_ENOS().
> 

Got it.

> > +
> > +static int fork_pid, ret_code;
> 
> These can be local variables.
> 

Yeah, these should be local variables.

> > +
> > +	TEST(wait(&ret_code));
> 
> I know this wasn't in original code, but I suggest to add some check for
> ret_code too (WIFEXITED() && WEXITSTATUS() == 1).
> 

OK. I will add them.
And thanks for your review.

Best regards,
Zeng

> Regards,
> Jan
> 
> >  
> > +	if (TEST_RETURN == -1) {
> > +		TEST_ERROR_LOG(TEST_ERRNO);
> > +		tst_resm(TFAIL | TTERRNO, "wait(1) Failed");
> > +	} else {
> > +		tst_resm(TPASS, "wait(&ret_code) returned %ld", TEST_RETURN);
> > +	}
> >  }
> >  
> > -/***************************************************************
> > - * cleanup() - performs all ONE TIME cleanup for this test at
> > - *		completion or premature exit.
> > - ***************************************************************/
> > -void cleanup(void)
> > +static void cleanup(void)
> >  {
> > -	/*
> > -	 * print timing stats if that option was specified.
> > -	 * print errno log if that option was specified.
> > -	 */
> >  	TEST_CLEANUP;
> > -
> >  }
> > --
> > 1.9.3
> > 
> > 
> > 
> > 
> > ------------------------------------------------------------------------------
> > HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
> > Find What Matters Most in Your Big Data with HPCC Systems
> > Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
> > Leverages Graph Analysis for Fast Processing & Easy Data Exploration
> > http://p.sf.net/sfu/hpccsystems
> > _______________________________________________
> > Ltp-list mailing list
> > Ltp-list@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/ltp-list
> > 



------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
