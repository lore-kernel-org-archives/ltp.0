Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <isimatu.yasuaki@jp.fujitsu.com>) id 1RiFnI-0002Z4-OA
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 01:37:32 +0000
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RiFnH-0001Vx-5i
	for ltp-list@lists.sourceforge.net; Wed, 04 Jan 2012 01:37:32 +0000
Received: from m4.gw.fujitsu.co.jp (unknown [10.0.50.74])
	by fgwmail6.fujitsu.co.jp (Postfix) with ESMTP id 0D7AE3EE0BD
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Jan 2012 10:37:21 +0900 (JST)
Received: from smail (m4 [127.0.0.1])
	by outgoing.m4.gw.fujitsu.co.jp (Postfix) with ESMTP id D0AF245DE54
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Jan 2012 10:37:20 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (s4.gw.fujitsu.co.jp [10.0.50.94])
	by m4.gw.fujitsu.co.jp (Postfix) with ESMTP id B9A9045DE4F
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Jan 2012 10:37:20 +0900 (JST)
Received: from s4.gw.fujitsu.co.jp (localhost.localdomain [127.0.0.1])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id A6CED1DB8042
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Jan 2012 10:37:20 +0900 (JST)
Received: from m105.s.css.fujitsu.com (m105.s.css.fujitsu.com [10.240.81.145])
	by s4.gw.fujitsu.co.jp (Postfix) with ESMTP id 61AB51DB8044
	for <ltp-list@lists.sourceforge.net>;
	Wed,  4 Jan 2012 10:37:20 +0900 (JST)
Message-ID: <4F03AD5E.4000003@jp.fujitsu.com>
Date: Wed, 04 Jan 2012 10:37:34 +0900
From: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
MIME-Version: 1.0
References: <4EFAF5BB.2030407@windriver.com>
In-Reply-To: <4EFAF5BB.2030407@windriver.com>
Subject: Re: [LTP] Posix test case mmap/31-1 fails on Linux/eglibc
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
To: Kang Kai <Kai.Kang@windriver.com>
Cc: ltp-list@lists.sourceforge.net

Hi Kai,

2011/12/28 19:55, Kang Kai wrote:
> Hi all,
>
> I run mmap/31-1 failed with ENOMEM on linux, with error message:
> off: fffffffffffff000, len: fffffffffffff000
> Test FAIL: expect EOVERFLOW but get other error: Cannot allocate memory
>
> But compare to mmap/24-2, it mmap() the same length but pass. Its output:
> available memory: 18446744073709551615
> addr: 7f78c54fa000, len: ffffffffffffffff
> addr: 7f78c54fa000, len: fffffffffffff000
> Test Pass: mmap/24-2.c Get ENOMEM: Cannot allocate memory
>
> So I suppose that mmap/31-1 may need update, but I don't know how to
> make mmap() overflow as expect.
> Any suggestion is appreciated.

I don't think mmap/31-1 need update since it is Linux Kernel's problem,
not the test's problem. The problem is being discussed on LKML.

https://lkml.org/lkml/2011/12/22/85

Regards,
Yasuaki Ishimatsu

>
> Regards,
> Kai
>
> ------------------------------------------------------------------------------
> Write once. Port to many.
> Get the SDK and tools to simplify cross-platform app development. Create
> new or port existing apps to sell to consumers worldwide. Explore the
> Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
> http://p.sf.net/sfu/intel-appdev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>



------------------------------------------------------------------------------
Ridiculously easy VDI. With Citrix VDI-in-a-Box, you don't need a complex
infrastructure or vast IT resources to deliver seamless, secure access to
virtual desktops. With this all-in-one solution, easily deploy virtual 
desktops for less than the cost of PCs and save 60% on VDI infrastructure 
costs. Try it free! http://p.sf.net/sfu/Citrix-VDIinabox
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
