Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XFI1D-0000sP-VB
	for ltp-list@lists.sourceforge.net; Thu, 07 Aug 2014 07:21:48 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XFI1C-0001Xo-Mp
	for ltp-list@lists.sourceforge.net; Thu, 07 Aug 2014 07:21:47 +0000
Date: Thu, 7 Aug 2014 03:21:35 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <795326558.3533486.1407396095854.JavaMail.zimbra@redhat.com>
In-Reply-To: <53E2CA8D.9080406@cn.fujitsu.com>
References: <e6cf00e941296bfd4d10edc44f1b9980a8b19489.1407313325.git.jstancek@redhat.com>
	<53E2CA8D.9080406@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH v2] madvise05: new testcase for Oops in
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
To: ltp-list@lists.sourceforge.net





----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Thursday, 7 August, 2014 2:38:37 AM
> Subject: Re: [LTP] [PATCH v2] madvise05: new testcase for Oops in madvise_willneed
> 
> On 08/06/2014 04:31 PM, Jan Stancek wrote:
> > This is a regression test for madvise(2) system call. It tests
> > kernel for NULL ptr deref Oops fixed by:
> >   commit ee53664bda169f519ce3c6a22d378f0b946c8178
> >   Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> >   Date:   Fri Dec 20 15:10:03 2013 +0200
> >     mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support
> > 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> 
> Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>

Pushed.

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
