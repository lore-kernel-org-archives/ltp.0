Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MTdek-00013x-GA
	for Ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 15:22:58 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MTdef-0004Hj-Mj
	for Ltp-list@lists.sourceforge.net; Wed, 22 Jul 2009 15:22:58 +0000
Message-Id: <2A0DDADE-5C3C-43F2-9487-98A8A735DC8D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Wed, 22 Jul 2009 10:22:42 -0500
References: <6213bc560907210233l17aa3e75pcb7c20e3faa24195@mail.gmail.com>
Subject: Re: [LTP] msgctl10 fails on Powerpc Linux-2.6.29.6
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
To: srikanth krishnakar <skrishnakar@gmail.com>
Cc: Linuxppc-dev@ozlabs.org, Ltp-list@lists.sourceforge.net

I'm not seeing any BUG* in traps.c @ line 904.

On Jul 21, 2009, at 4:33 AM, srikanth krishnakar wrote:

> The LTP test case msgctl10.c fails on linux-2.6.29.6 for PowerPC  
> architecture (ppc440)
>
>
> msgctl10    1  B------------[ cut here ]------------
> kernel BUG at arch/powerpc/kernel/traps.c:904!
> Oops: Exception in kernel mode, sig: 5 [#9]

I'm not seeing any BUG* in traps.c @ line 904.  Do you have some other  
patches on top of 2.6.29.6?

- k


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
