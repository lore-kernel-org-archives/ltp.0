Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sharmaj@gmail.com>) id 1MOGNM-00071P-Q8
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 19:30:48 +0000
Received: from mail-pz0-f178.google.com ([209.85.222.178])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOGND-0002au-8k
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 19:30:48 +0000
Received: by pzk8 with SMTP id 8so4737152pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 07 Jul 2009 12:30:38 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 7 Jul 2009 12:30:38 -0700
Message-ID: <587a08410907071230x3c4f6edaj71e5ace0a19c96ba@mail.gmail.com>
From: Jatin Sharma <sharmaj@gmail.com>
Subject: [LTP] Simple test for eventfd semaphore (eventfd-sem:
	eventfd2_03.c) for ARM architecture
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

Cross-compilation of the ltp-full-20090630 for ARM architecture fails
in the following code. Is there a patch for this code for ARM
architecture?

#ifndef __NR_eventfd2
#if defined(__x86_64__)
#define __NR_eventfd2 290
#elif defined(__i386__)
#define __NR_eventfd2 328
#else
#error Cannot detect your architecture!
#endif
#endif


Thanks,
Jatin

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
