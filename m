Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SCMHU-0003ef-RJ
	for ltp-list@lists.sourceforge.net; Tue, 27 Mar 2012 02:37:08 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SCMHU-0003FH-3O
	for ltp-list@lists.sourceforge.net; Tue, 27 Mar 2012 02:37:08 +0000
Received: by pbcum15 with SMTP id um15so7564518pbc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 26 Mar 2012 19:37:02 -0700 (PDT)
Message-ID: <4F71276B.4090302@casparzhang.com>
Date: Tue, 27 Mar 2012 10:35:23 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4F707B51.4090306@redhat.com>
In-Reply-To: <4F707B51.4090306@redhat.com>
Subject: Re: [LTP] [PATCH] mremap: fix dependency on ipc subdir
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 03/26/2012 10:21 PM, Jan Stancek wrote:
> 
> We need to use MAKE_DEPS to declare the ipc subdir depend otherwise
> attempting to do `make mremap01` without building in the ipc subdir
> will fail, and we can hit race conditions in the overall `make`.
> 
> This is same change as in commit:
> commit 7103d3e8e0f9dc1804ba06ee66ee02753e8ce50e
> Author: Mike Frysinger <vapier@gentoo.org>
> Date:   Fri Mar 23 12:27:13 2012 -0400
>      kill: fix dependency on ipc subdir
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
