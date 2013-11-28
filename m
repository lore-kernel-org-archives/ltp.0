Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Vm42I-00061S-Hl
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 16:01:50 +0000
Date: Thu, 28 Nov 2013 17:01:17 +0100
From: chrubis@suse.cz
Message-ID: <20131128160116.GB17903@rei.Home>
References: <1385546874.1596.0.camel@G08JYZSD130126>
	<20131128135908.GA20294@rei.Home> <52976154.10500@imgtec.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52976154.10500@imgtec.com>
Subject: Re: [LTP] [PATCH v2 1/2] confstr/confstr01.c: cleanup
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
To: Markos Chandras <Markos.Chandras@imgtec.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> cleanup the confstr01.c test case.
> >>
> >
> > I've changed the succes message to include the confstr value as:
> >
> >                                  } else {
> > -                                       tst_resm(TPASS, "confstr %s success",
> > -                                                test_cases[i].name);
> > +                                       tst_resm(TPASS, "confstr %s = '%s'",
> > +                                                test_cases[i].name, buf);
> >                                  }
> >                                  free(buf);
> >
> > And pushed both patches, thanks.
> >
> 
> Hi,
> 
> since this change I am seeing the following build problem on a uClibc 
> based system
> 
> confstr01.c:50: error: '_CS_XBS5_ILP32_OFF32_CFLAGS' undeclared here 
> (not in a function)
> confstr01.c:51: error: '_CS_XBS5_ILP32_OFF32_LDFLAGS' undeclared here 
> (not in a function)
> confstr01.c:52: error: '_CS_XBS5_ILP32_OFF32_LIBS' undeclared here (not 
> in a function)
> confstr01.c:53: error: '_CS_XBS5_ILP32_OFF32_LINTFLAGS' undeclared here 
> (not in a function)
> ...
> 
> Reverting the recent changes in confstr01.c file seems to "fix" the problem.

Hmm, I looked closely at the changes and that may be the missing _XOPEN_SOURCE.

Does it work after adding:

#define _XOPEN_SOURCE 500

before headers are included?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
