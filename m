Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4680CCD180
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759333201; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7hlvbvp9N0BoR7JP0MdpVXjMaoRw/1QJ9CvGjcRSj1o=;
 b=Ra011egXmPzZbvJFTUWa0TUgkA2Hr/jvMXIJ6q/kh/zDas8IGzQ1Ucb0shaAeg3epWxJQ
 IeFpwphO3t68f0vlEetJB7AoQob1TY19tF8Dbv5xyo396HMw18yGb/L23ZjD7dwQ1M3lTqG
 m6ar0Lsp43On6r71UCOxzt5oy3oq5lw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F7003CE3DA
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 17:40:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB0BB3CE37A
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 17:39:38 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 435621A009AD
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 17:39:37 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D76944177A;
 Wed,  1 Oct 2025 15:39:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C530C4CEF5;
 Wed,  1 Oct 2025 15:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759333173;
 bh=WtEVlB/YEbSlFvYtNBcdguT+bm4fsIj2BYpq1A7Iniw=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XgnMXPctSvRuwYy/18hRVob5/ZdSKRwjcttZoPJW9cvfReYnVs79jLDqVP9p3UlUp
 lgCO02MmMfh8AbPYGs1FFj5Wez195JQWlCDMlsq3nDR9k4CrCgd3gyVf5mK+VAnWWr
 piJ5zMQSkHv8zmJKBBMBk44Bkg4ZDdTxK/H3befI6YE0ZPDu+GYeXOjwEN7/JeuRON
 bM3IF8JBEjFWdzAIirezKoDlCWJ5XQzzhJrAEIBG4PmTffoxfkmKVlkdexk9feEiJ2
 XX//65JSYAdjxaOMRs31yBiKgQFk6+2dd0YWgt8uw9VbiZbIeYUwUtZXkLK3+34XI2
 p3tr0APudIlNg==
Date: Wed, 1 Oct 2025 15:39:31 +0000
To: Mateusz Guzik <mjguzik@gmail.com>
Message-ID: <aN1LM3C3Dc1TrQTq@google.com>
References: <202509301450.138b448f-lkp@intel.com>
 <20250930232957.14361-1-mjguzik@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250930232957.14361-1-mjguzik@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] f2fs: don't call iput() from f2fs_drop_inode()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Jaegeuk Kim via ltp <ltp@lists.linux.it>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, oe-lkp@lists.linux.dev,
 oliver.sang@intel.com, linux-fsdevel@vger.kernel.org, josef@toxicpanda.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 10/01, Mateusz Guzik wrote:
> iput() calls the problematic routine, which does a ->i_count inc/dec
> cycle. Undoing it with iput() recurses into the problem.
> 
> Note f2fs should not be playing games with the refcount to begin with,
> but that will be handled later. Right now solve the immediate
> regression.
> 
> Fixes: bc986b1d756482a ("fs: stop accessing ->i_count directly in f2fs and gfs2")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509301450.138b448f-lkp@intel.com
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>  fs/f2fs/super.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 2619cbbd7d2d..26ec31eb8c80 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1769,7 +1769,7 @@ static int f2fs_drop_inode(struct inode *inode)
>  			sb_end_intwrite(inode->i_sb);
>  
>  			spin_lock(&inode->i_lock);
> -			iput(inode);
> +			atomic_dec(&inode->i_count);

It seems this was applied by Josef [1], added in 6.18-rc1. Let me apply this fix
after my f2fs pull request, since I don't have this issue in my -next tree yet.

[1] https://lore.kernel.org/all/b8e6eb8a3e690ce082828d3580415bf70dfa93aa.1755806649.git.josef@toxicpanda.com/

>  		}
>  		trace_f2fs_drop_inode(inode, 0);
>  		return 0;
> -- 
> 2.43.0
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
