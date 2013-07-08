Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uw9Y7-0001gF-6J
	for ltp-list@lists.sourceforge.net; Mon, 08 Jul 2013 11:24:07 +0000
Date: Mon, 8 Jul 2013 13:25:41 +0200
From: chrubis@suse.cz
Message-ID: <20130708112541.GD23579@rei.Home>
References: <1373014297-30962-1-git-send-email-gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1373014297-30962-1-git-send-email-gaowanlong@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] runltp: try to create ext3 loop device if
 creating ext4 failed
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: Garrett Cooper <yanegomi@gmail.com>, LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier@gentoo.org>

Hi!
> Try to create ext3 loop device if creating ext4 failed since
> some old system can't support ext4 file system or the root
> file system still use ext3 file system.
> 
> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
> ---
>  runltp | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/runltp b/runltp
> index 1309d0a..2c13b56 100755
> --- a/runltp
> +++ b/runltp
> @@ -1002,7 +1002,8 @@ create_block()
>                  return 1
>              else
>                  mkfs.ext4 $LOOP_DEV
> -                [ $? -ne 0 ] && (echo "creating a ext4 block device failed" && return 1)
> +                [ $? -ne 0 ] && (mkfs.ext3 $LOOP_DEV)
> +                [ $? -ne 0 ] && (echo "creating a ext4/3 block device failed" && return 1)
>                  #set the values in alltests which require block device.
>                  DEVICE=$LOOP_DEV
>                  DEVICE_FS_TYPE="ext4"
                         ^
Hmm, you should set the DEVICE_FS_TYPE accordingly too. I wonder if
leaving it set to ext4 will work, have you tested the change?

Otherwise I'm fine with the change.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
