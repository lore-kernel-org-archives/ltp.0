Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MOlxd-0001qM-5V
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 05:14:21 +0000
Received: from an-out-0708.google.com ([209.85.132.242])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOlxb-0003TX-8p
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 05:14:19 +0000
Received: by an-out-0708.google.com with SMTP id c38so2591644ana.37
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 22:14:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A078D013BE@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A078D013BE@svexch01.mvista.com>
Date: Wed, 8 Jul 2009 22:14:18 -0700
Message-ID: <364299f40907082214s4b50c570od28e6513eb87985b@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Tests hanging on multi-core x86 machines
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
To: Henry Yei <hyei@mvista.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jul 8, 2009 at 7:14 PM, Henry Yei<hyei@mvista.com> wrote:
> Has anyone noticed the following tests hanging intermittently on their multicore machines? The kernel being used is 2.6.28 (i686)
>
>
> ppoll01
> ptrace06
> mq_timedrecieve01
>
> These are all tests from Crackerjack and are fairly new. Most of the time these tests pass(or fail), but there's about a 10% chance the processes hang. For all I know there may be many other tests that exhibit the same thing, but I haven't stumbled upon it yet.

1. What are the specs?
2. What's the kernel config?
3. What distro?

Thanks,
-Garrett

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
