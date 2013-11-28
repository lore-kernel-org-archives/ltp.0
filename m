Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Vm3Wx-0002LR-Am
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 15:29:27 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Vm3Ww-0004Ot-8l
	for ltp-list@lists.sourceforge.net; Thu, 28 Nov 2013 15:29:27 +0000
Message-ID: <52976154.10500@imgtec.com>
Date: Thu, 28 Nov 2013 15:29:24 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1385546874.1596.0.camel@G08JYZSD130126>
	<20131128135908.GA20294@rei.Home>
In-Reply-To: <20131128135908.GA20294@rei.Home>
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
To: ltp-list@lists.sourceforge.net

On 11/28/2013 01:59 PM, chrubis@suse.cz wrote:
> Hi!
>> cleanup the confstr01.c test case.
>>
>
> I've changed the succes message to include the confstr value as:
>
>                                  } else {
> -                                       tst_resm(TPASS, "confstr %s success",
> -                                                test_cases[i].name);
> +                                       tst_resm(TPASS, "confstr %s = '%s'",
> +                                                test_cases[i].name, buf);
>                                  }
>                                  free(buf);
>
> And pushed both patches, thanks.
>

Hi,

since this change I am seeing the following build problem on a uClibc 
based system

confstr01.c:50: error: '_CS_XBS5_ILP32_OFF32_CFLAGS' undeclared here 
(not in a function)
confstr01.c:51: error: '_CS_XBS5_ILP32_OFF32_LDFLAGS' undeclared here 
(not in a function)
confstr01.c:52: error: '_CS_XBS5_ILP32_OFF32_LIBS' undeclared here (not 
in a function)
confstr01.c:53: error: '_CS_XBS5_ILP32_OFF32_LINTFLAGS' undeclared here 
(not in a function)
...

Reverting the recent changes in confstr01.c file seems to "fix" the problem.

-- 
markos


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
