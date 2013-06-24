Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <eguan@redhat.com>) id 1Ur8ur-0003zC-F6
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:42:53 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Ur8uj-0002Se-Cp
	for ltp-list@lists.sourceforge.net; Mon, 24 Jun 2013 15:42:53 +0000
Date: Mon, 24 Jun 2013 23:42:33 +0800
From: Eryu Guan <eguan@redhat.com>
Message-ID: <20130624154233.GO2542@dhcp-13-216.nay.redhat.com>
References: <1372086727-27722-1-git-send-email-eguan@redhat.com>
	<201306241134.32158.vapier@gentoo.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <201306241134.32158.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] dup2/dup205: close all fds before tst_rmdir()
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On Mon, Jun 24, 2013 at 11:34:31AM -0400, Mike Frysinger wrote:
> On Monday 24 June 2013 11:12:07 Eryu Guan wrote:
> > Close all open fds before calling tst_rmdir() to avoid TWARN caused by
> > NFS silly rename when removing temp dir caused by NFS silly rename.
> 
> "NFS silly rename" duplicated by accident ?

Oh, forgot to remove one "NFS silly rename" when editing commit
message.. Will send v2. Thanks for the review!

Eryu Guan
> 
> code looks fine to me
> -mike



------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
