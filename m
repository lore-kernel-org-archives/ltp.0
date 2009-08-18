Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MdIRT-0001wv-Pu
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 06:45:11 +0000
Received: from mail-qy0-f181.google.com ([209.85.221.181])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MdIRM-0008Q6-1I
	for ltp-list@lists.sourceforge.net; Tue, 18 Aug 2009 06:45:11 +0000
Received: by qyk11 with SMTP id 11so2718044qyk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 17 Aug 2009 23:44:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f5a7b3810908170937u516ee718yd6db8df547752bc4@mail.gmail.com>
References: <f5a7b3810908170937u516ee718yd6db8df547752bc4@mail.gmail.com>
Date: Mon, 17 Aug 2009 23:44:58 -0700
Message-ID: <364299f40908172344o62861d02rc8e0c3f87de80134@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [FIX PATCHE]ltp-fix-posix-mq_send_5-1 warning
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
To: naresh kamboju <naresh.kernel@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, Brandon Philips <bphilips@suse.de>

On Mon, Aug 17, 2009 at 9:37 AM, naresh kamboju<naresh.kernel@gmail.com> wrote:
> Hi,
>
> I have noticed build warnings for the following test case.
> This patch will fix warnings by removing unused variables in test code.
>
> I have attached patch and below
> Please review the same

    Log before and after?
Thanks,
-Garrett

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
