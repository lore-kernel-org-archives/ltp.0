Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RkzrT-0007f9-Lb
	for ltp-list@lists.sourceforge.net; Wed, 11 Jan 2012 15:13:11 +0000
Date: Wed, 11 Jan 2012 16:24:35 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120111152435.GF7143@saboteur.suse.cz>
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
	<1326164470-16612-1-git-send-email-caspar@casparzhang.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1326164470-16612-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH v2] syscalls/xattr: fix compile when xattr.h not
 exist
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> if <attr/xattr.h> doesn't exist, compliation will fail. Fix it in
> autotools level.
> 
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>
> ---
>  configure.ac                                    |    1 +
>  testcases/kernel/syscalls/getxattr/getxattr01.c |   16 +++++++++++++---
>  testcases/kernel/syscalls/getxattr/getxattr02.c |   17 +++++++++++++----
>  testcases/kernel/syscalls/setxattr/setxattr01.c |   16 +++++++++++++---
>  testcases/kernel/syscalls/setxattr/setxattr02.c |   17 +++++++++++++----
>  5 files changed, 53 insertions(+), 14 deletions(-)

Commited, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

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
