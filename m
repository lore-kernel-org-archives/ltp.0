Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z6xtp-0003Su-U9
	for ltp-list@lists.sourceforge.net; Mon, 22 Jun 2015 09:20:17 +0000
Date: Mon, 22 Jun 2015 11:19:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150622091904.GA6128@rei.suse.de>
References: <1434688335-29172-1-git-send-email-zenglg.jy@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1434688335-29172-1-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] df/df01.sh: Fix 'mkfs.xfs' error.
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 'runltp' use a loop device. If we want to 'mkfs.xfs' the loop device,
> we need to specify '-f(force)' option, if not 'mkfs.xfs' would go
> wrong. The mean of '-f' option is different between 'xfs' and others.
> So we only add the option for 'xfs'.
> 
> Signed-off-by: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
> ---
>  testcases/commands/df/df01.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/commands/df/df01.sh b/testcases/commands/df/df01.sh
> index fe573e5..2b7b804 100755
> --- a/testcases/commands/df/df01.sh
> +++ b/testcases/commands/df/df01.sh
> @@ -32,7 +32,11 @@ setup()
>  
>  	tst_acquire_device
>  
> -	ROD_SILENT mkfs.${FS_TYPE} ${TST_DEVICE}
> +	if [ ${FS_TYPE} = "xfs" ]; then
> +		ROD_SILENT mkfs.${FS_TYPE} -f ${TST_DEVICE}
> +	else
> +		ROD_SILENT mkfs.${FS_TYPE} ${TST_DEVICE}
> +	fi

What about adding tst_mkfs() into the test library and put all
workarounds for specific filesystems there (as we do in the C library)?
Because otherwise we would need to copy this snippet of code into all
testcases that use mkfs...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Monitor 25 network devices or servers for free with OpManager!
OpManager is web-based network management software that monitors 
network devices and physical & virtual servers, alerts via email & sms 
for fault. Monitor 25 devices for free with no restriction. Download now
http://ad.doubleclick.net/ddm/clk/292181274;119417398;o
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
