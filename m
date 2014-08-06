Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XEvsE-0007M5-3a
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 07:43:02 +0000
Received: from mx6-phx2.redhat.com ([209.132.183.39])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XEvsC-0006DY-NA
	for ltp-list@lists.sourceforge.net; Wed, 06 Aug 2014 07:43:02 +0000
Date: Wed, 6 Aug 2014 03:42:52 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <1295578079.3016213.1407310972515.JavaMail.zimbra@redhat.com>
In-Reply-To: <53E11A03.5000704@casparzhang.com>
References: <c0760953d5915e17e43a5e899bad7f5d0a7fde80.1407249825.git.jstancek@redhat.com>
	<53E11A03.5000704@casparzhang.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] madvise05: new testcase for Oops in
 madvise_willneed
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Jan Stancek" <jstancek@redhat.com>, ltp-list@lists.sourceforge.net
> Sent: Tuesday, 5 August, 2014 7:53:07 PM
> Subject: Re: [LTP] [PATCH] madvise05: new testcase for Oops in madvise_willneed
> 
> On 08/05/2014 10:45 PM, Jan Stancek wrote:
> > This is a regression test for madvise(2) system call. It tests
> > kernel for NULL ptr deref Oops fixed by:
> >    commit ee53664bda169f519ce3c6a22d378f0b946c8178
> >    Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >    Date:   Fri Dec 20 15:10:03 2013 +0200
> >      mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support
> >
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >   runtest/syscalls                              |    1 +
> >   testcases/kernel/syscalls/.gitignore          |    1 +
> >   testcases/kernel/syscalls/madvise/madvise05.c |   81
> >   +++++++++++++++++++++++++
> >   3 files changed, 83 insertions(+), 0 deletions(-)
> >   create mode 100644 testcases/kernel/syscalls/madvise/madvise05.c
> >

> Is MADV_WILLNEED available on all releases? If yes, the new case looks
> good to me.

It was introduced before 2.4, so I assume it's available on releases
made after 2002. Also none of other madvise testcases checks/tests for it.

However, I noticed that older kernels fail with EBADF, if there is no
backing file. I'll fix that and send v2.

Regards,
Jan


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
