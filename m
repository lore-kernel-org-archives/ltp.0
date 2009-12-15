Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NKd4s-0002z4-7J
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 19:28:58 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NKd4q-0003Zc-1B
	for ltp-list@lists.sourceforge.net; Tue, 15 Dec 2009 19:28:58 +0000
Received: by pwj11 with SMTP id 11so145338pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 15 Dec 2009 11:28:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1906840727.360001260873181371.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
References: <88580605.359961260873174827.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1906840727.360001260873181371.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
Date: Tue, 15 Dec 2009 11:28:49 -0800
Message-ID: <364299f40912151128v356feae4t6405598a00ae09ca@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix libevent01 testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Dec 15, 2009 at 2:33 AM, Caspar Zhang <czhang@redhat.com> wrote:
> Hi,
>
> I found libevent01 testcase is disabled in testcase/kernel/syscalls/Makefile,
> the testscript can't be installed, I got a "FAIL" in testing. Here's the Patch
> to fix this problem.

I took a look at the Makefile again, and yes, I screwed up... I fixed
the Makefile by using a proper set of LDFLAGS and LDLIBS for just
libevent, so now it compiles and installs properly off cvs HEAD.
Thanks for spotting the run-libevent.sh -> run_libevent.sh typo :).
Cheers,
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
