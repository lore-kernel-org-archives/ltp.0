Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1RkBvc-0000SW-Tu
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 09:54:08 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RkBvc-0006xv-2k
	for ltp-list@lists.sourceforge.net; Mon, 09 Jan 2012 09:54:08 +0000
Message-ID: <4F0AB938.9050504@imgtec.com>
Date: Mon, 9 Jan 2012 09:54:00 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
In-Reply-To: <1326102275-32485-1-git-send-email-caspar@casparzhang.com>
Subject: Re: [LTP] [PATCH] syscalls/xattr: fix compile when xattr.h not exist
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

On 01/09/2012 09:44 AM, Caspar Zhang wrote:
>
> if<attr/xattr.h>  doesn't exist, compliation will fail. Fix it in
> autotools level.
>
> Signed-off-by: Caspar Zhang<caspar@casparzhang.com>
> ---
>   configure.ac                                    |    1 +
>   testcases/kernel/syscalls/getxattr/getxattr01.c |   15 +++++++++++++--
>   testcases/kernel/syscalls/getxattr/getxattr02.c |   16 +++++++++++++---
>   testcases/kernel/syscalls/setxattr/setxattr01.c |   15 +++++++++++++--
>   testcases/kernel/syscalls/setxattr/setxattr02.c |   16 +++++++++++++---
>   5 files changed, 53 insertions(+), 10 deletions(-)
>
>
>
>
The patch looks good to me. Another approach would be to disable these 
two tests for all UCLINUX targets (uClibc does not have attr/xattr.h>) 
from testcases/kernel/syscalls Makefile.

-- 
markos


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
