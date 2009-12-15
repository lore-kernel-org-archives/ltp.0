Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1NKQgO-0003HP-4c
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 06:14:52 +0000
Received: from smtp-gate3.ryobi.co.jp ([210.163.224.134])
	by sfi-mx-2.v28.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1NKQgM-0008HO-DX
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 06:14:52 +0000
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 15 Dec 2009 15:14:40 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 15 Dec 2009 15:14:39 +0900
Message-ID: <000001ca7d4d$e2a9e7e0$a7fdb7a0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix compiling error on ia64 platform
	(ltp-full-20091130)
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

Hi,

I applied following Casper's patch to "ltp-2009-12-10" cvs,
then "make" succeeded in RHEL5.4 ia64 system:
http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg08991.html

On the other hand, I used Repository's following sources,
but "make" failed.
 - "ptrace.h"   (Revision 1.9)
 - "ptrace04.c" (Revision 1.13)

But, at least, I think that the Repository's revision about "ptrace04.c"
is right. And "ptrace04.c" of "ltp-2009-12-15" cvs is same one.


Today, I arranged Casper's "ptrace.h" patch for "ltp-2009-12-15" cvs
and applied it to this cvs, and "make" succeeded.


I tried following other systems as using this patch, and succeeded:
 - RHEL5.4(kernel : 2.6.18-164.el5) and x86 architecture
 - RHEL5.4(kernel : 2.6.18-164.el5) and x86_64 architecture
 - RHEL4.8(kernel : 2.6.9-89.ELsmp) and x86 architecture


The make failure can be evaded by only adding the condition of 
"system isn't ia64" to the condition of "# include <asm/ptrace.h>" ...



Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
