Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XEgCV-0007kL-C0
	for ltp-list@lists.sourceforge.net; Tue, 05 Aug 2014 14:58:55 +0000
Date: Tue, 5 Aug 2014 16:58:05 +0200
From: chrubis@suse.cz
Message-ID: <20140805145804.GA17966@rei.suse.cz>
References: <c0760953d5915e17e43a5e899bad7f5d0a7fde80.1407249825.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <c0760953d5915e17e43a5e899bad7f5d0a7fde80.1407249825.git.jstancek@redhat.com>
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This is a regression test for madvise(2) system call. It tests
> kernel for NULL ptr deref Oops fixed by:
>   commit ee53664bda169f519ce3c6a22d378f0b946c8178
>   Author: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>   Date:   Fri Dec 20 15:10:03 2013 +0200
>     mm: Fix NULL pointer dereference in madvise(MADV_WILLNEED) support

Looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

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
