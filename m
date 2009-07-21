Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <bphilips@suse.de>) id 1MT7FB-0001L0-UY
	for ltp-list@lists.sourceforge.net; Tue, 21 Jul 2009 04:46:25 +0000
Date: Mon, 20 Jul 2009 21:45:29 -0700
From: Brandon Philips <bphilips@suse.de>
Message-ID: <20090721044529.GB9807@jenkins.home.ifup.org>
References: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f5a7b3810906300005q2cafdd3dtfe4d659ae6834bb@mail.gmail.com>
Subject: Re: [LTP] [PATCH v2] mq_send/5-1.c: Fix race conditions in the test
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
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>

On 12:35 Tue 30 Jun 2009, naresh kamboju wrote:
> I have noticed some issue with your patch dated on 12-Dec-2008.
> I want conform the problem and root cause.

What is the problem?

> Could you send me your open posix full Results logs of before and
> after your patch with ARCH and Kernel versions?

I never ran the full test suite. To be honest I could never figure out
how to get it running. Are there instructions somewhere?

My fix was triggered by a bug report I got that thought it found a
Kernel regression based on this test and it looked to me like it was
caused by that bug.

Cheers,

	Brandon

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
