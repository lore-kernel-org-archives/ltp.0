Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfqTD-000567-W9
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 09:06:19 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfqTC-0004xm-Pj
	for ltp-list@lists.sourceforge.net; Thu, 20 Jan 2011 09:06:19 +0000
Received: by wyb40 with SMTP id 40so318244wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 20 Jan 2011 01:06:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D37F00B.8020402@cn.fujitsu.com>
References: <4D37F00B.8020402@cn.fujitsu.com>
Date: Thu, 20 Jan 2011 01:06:12 -0800
Message-ID: <AANLkTiknhda=r6Aex-+UOdAzid-6ZD-FMrA5YM89Pmpv@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] rt_sigprocmask01: fix error of wrong return code
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

On Thu, Jan 20, 2011 at 12:19 AM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> "return 1" should be replaced with "tst_exit()".

Committed -- thanks.
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
