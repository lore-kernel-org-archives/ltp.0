Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PfSV4-0008QG-TR
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:30:38 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.72) id 1PfSV4-0000Xn-2W
	for ltp-list@lists.sourceforge.net; Wed, 19 Jan 2011 07:30:38 +0000
Received: by wyb40 with SMTP id 40so518015wyb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 18 Jan 2011 23:30:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D369178.4010107@cn.fujitsu.com>
References: <4D369178.4010107@cn.fujitsu.com>
Date: Tue, 18 Jan 2011 23:30:31 -0800
Message-ID: <AANLkTikiw2H_w5shE=KmQEpm9cPLq77jqTWOFZ3kRj3C@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] exit_group01: fix error of using wrong TEST_RETURN
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

On Tue, Jan 18, 2011 at 11:23 PM, Peng Haitao <penght@cn.fujitsu.com> wrote:
> Hi Garrett,
>
> "TEST_RETURN" should be replaced with "cpid".

Committed -- thanks!
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
