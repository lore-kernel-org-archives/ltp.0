Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1VtzTT-0007oz-2F
	for ltp-list@lists.sourceforge.net; Fri, 20 Dec 2013 12:46:39 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VtzTS-0006kg-6V
	for ltp-list@lists.sourceforge.net; Fri, 20 Dec 2013 12:46:39 +0000
Message-ID: <52B43BDD.7080304@imgtec.com>
Date: Fri, 20 Dec 2013 12:45:17 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1386937862-12687-1-git-send-email-markos.chandras@imgtec.com>
	<201312160158.02840.vapier@gentoo.org>
In-Reply-To: <201312160158.02840.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH v2] utils: sctp: Fix build for prefixed
	architectures
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net

On 12/16/2013 06:58 AM, Mike Frysinger wrote:
> On Friday 13 December 2013 07:31:02 Markos Chandras wrote:
>> Commit 6f22494d19b605ded308dc0fa713e91cb873f44a
>> "Move sctp to utils and bump it to 1.0.15"
>>
>> introduced a build failure for the prefixed architectures.
>> We need to take into consideration the __USER_LABEL_PREFIX__
>> for architectures that define it when creating symbol aliases.
>>
>> The following upstream patch (0600c8968cc2dea04cbf13ec739216e2939d08fe)
>> fixes the build for the Meta(metag) architecture
>>
>> [...]
>> utils/sctp/func_tests/test_connectx.c:151: undefined reference to
>> `_sctp_connectx' utils/sctp/func_tests/test_connectx.c:163: undefined
>> reference to `_sctp_connectx' [...]
>>
>> Build tested on x86_64 and metag.
>
> we really should fix this instead by not using any symbol renaming.  symbol
> versions might make sense when dealing with a released project and a stable
> shared library API, but it makes no sense in LTP.
>
> perhaps better to have a compile time knob to disable it all ?
> -mike
>
Well whatever works best. Personally I would avoid deviating from 
third-party code unless it's really necessary.

-- 
markos


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
