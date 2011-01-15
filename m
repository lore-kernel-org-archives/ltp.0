Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PdxSh-0001eh-Pb
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 04:09:59 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.72)
	id 1PdxSg-00059Z-Cl
	for ltp-list@lists.sourceforge.net; Sat, 15 Jan 2011 04:09:59 +0000
Received: by wyb40 with SMTP id 40so3381340wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Jan 2011 20:09:52 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D310A5D.6000006@cn.fujitsu.com>
References: <4D310A5D.6000006@cn.fujitsu.com>
Date: Fri, 14 Jan 2011 20:09:52 -0800
Message-ID: <AANLkTin8PLaWHyqu1jQETZXNWWVFizf=SqUj23=mBC5u@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [POSIX][PATCH] Fix bug of the test timer_create.
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, Jan 14, 2011 at 6:45 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
> CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID are CPU-time clock,
> so when the thread/process invokes nanosleep, these clocks will go sleeping
> too.

Fixed -- thanks!
-Garrett

------------------------------------------------------------------------------
Protect Your Site and Customers from Malware Attacks
Learn about various malware tactics and how to avoid them. Understand 
malware threats, the impact they can have on your business, and how you 
can protect your company and customers by using code signing.
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
