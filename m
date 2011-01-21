Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pg8AU-0001or-3n
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 04:00:10 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1Pg8AT-0004ne-1B
	for ltp-list@lists.sourceforge.net; Fri, 21 Jan 2011 04:00:10 +0000
Received: by wyb40 with SMTP id 40so1304262wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Jan 2011 20:00:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D3903AC.2070901@cn.fujitsu.com>
References: <4D37EB92.3060901@cn.fujitsu.com>
	<AANLkTin4N+xuTwQP2w7WtGvO20qdsa2mEjeiMi5fFK2d@mail.gmail.com>
	<4D3903AC.2070901@cn.fujitsu.com>
Date: Thu, 20 Jan 2011 20:00:02 -0800
Message-ID: <AANLkTimPKEHGOc4-UQXxSZoNJi5UQD1wB1L2n3iUznhE@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] mprotect02: fix error of the case need
	sighandler()
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Jan 20, 2011 at 7:55 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> Garrett Cooper said the following on 2011-1-20 17:28:
>>> The case expect the signal "SIGSEGV", so should add sighandler().
>>
>> For the first portion of the testcase, yes. For the second part of the
>> testcase, no.
>
> This is OK, but the default signal handler is invoked when an unexpected signal
> is caught. so I think we should add sighandler(). Furthermore, the default
> signal handler make the child process exit 2, but the case expect the child
> process exit 1, this will cause the case fail.
>
> The following patch will reinitialize signal handler.

    This won't work if the number of test loops is > 1 (it will reset
the handler back to the default and fail on the next iteration).
Thanks,
-Garrett

------------------------------------------------------------------------------
Special Offer-- Download ArcSight Logger for FREE (a $49 USD value)!
Finally, a world-class log management solution at an even better price-free!
Download using promo code Free_Logger_4_Dev2Dev. Offer expires 
February 28th, so secure your free ArcSight Logger TODAY! 
http://p.sf.net/sfu/arcsight-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
