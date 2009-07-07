Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MOCfC-0001rk-6w
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:58 +0000
Received: from e3.ny.us.ibm.com ([32.97.182.143])
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MOCf6-0002yz-Tl
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 15:32:58 +0000
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <4A53190C.2070809@linux.vnet.ibm.com>
References: <4A53190C.2070809@linux.vnet.ibm.com>
Date: Tue, 07 Jul 2009 21:02:39 +0530
Message-Id: <1246980759.5539.51.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] request to enable realtime tests in default run list
Reply-To: subrata@linux.vnet.ibm.com
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
To: gowrishankar <gomuthuk@linux.vnet.ibm.com>
Cc: ltp-list@lists.sf.net

On Tue, 2009-07-07 at 15:14 +0530, gowrishankar wrote: 
> Hi Subrata,
> 
> We are looking for your concerns as well as from community on enabling realtime
> tests by default. By the way we can broad our realtime tests as well as scan
> the existing tests functionality with the help of community.
> 
> One bottleneck we had in past is that it fails to compile on platforms that
> does not support few arch-specific tests (like TSC related tests) and also
> I am not too sure about remaining platforms than System X and P.
> 
> We can think of either dropping platform specific tests so that RT tests depend
> only on distros (for glibc ??) or conditionally enable them by looking for
> platform ids.
> 
> Also, we can think of enabling/disabling whole RT tests in default LTP build
> for the same reason I said at the top.
> 
> Your thoughts are very welcome.

Write few more m4 rule files, which will take care of stuff below:

     1. header files, 
     2. libraries, 
     3. any other user utilities, 
     4. any other system utilities, 
     5. arch dependencies, 
     6. distro dependencies(if any),

And the test across your patched for all the arch available with you.

Due to recent increase in usage of LTP by other archs like the blackfin,
arm, microblaze, etc. Please get some confirmation from them that your
patch also works fine with their archs. Most interestingly, they would
probably not require the RT tests to build in the first place itself ;-)

Regards--
Subrata

> 
> Thanks for paying attention,
> Gowri


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
