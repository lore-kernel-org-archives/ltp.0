Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Pfqoz-0000ur-0T
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 09:28:49 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1Pfqoy-0005h6-0L
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 09:28:48 +0000
Received: by wwi18 with SMTP id 18so353699wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Jan 2011 01:28:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D37EB92.3060901@cn.fujitsu.com>
References: <4D37EB92.3060901@cn.fujitsu.com>
Date: Thu, 20 Jan 2011 01:28:41 -0800
Message-ID: <AANLkTin4N+xuTwQP2w7WtGvO20qdsa2mEjeiMi5fFK2d@mail.gmail.com>
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

On Thu, Jan 20, 2011 at 12:00 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> The case expect the signal "SIGSEGV", so should add sighandler().

For the first portion of the testcase, yes. For the second part of the
testcase, no.
Thanks,
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
