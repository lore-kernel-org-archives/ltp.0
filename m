Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A03C433EF
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 14:47:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3E31A3C93DA
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 16:47:53 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6D2E3C0756
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 16:47:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3C85520032E
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 16:47:42 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 6C3201F461;
 Mon, 20 Jun 2022 14:47:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655736462; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmMA4RKB7Rd9+oSC29yJgjJaPWWulTdc19ImTiD+pIM=;
 b=BPWWMNdndWix67zBMkKMls9rNeDBuD3bi5X9qm90ra/3BeXPrTiXVbdWZDgUMgnJzdLmsU
 llRXKOF6IhlDWpI3KJFchoUf5zO4K5lUy2Iyg5V7q+GdfeFpZlaoTXj946H8e+TboCB/V3
 heaU6mi4Rc5H9HmWH9JvYIQWQF6C1ZQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655736462;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmMA4RKB7Rd9+oSC29yJgjJaPWWulTdc19ImTiD+pIM=;
 b=Edg+78LpkoDhmoOpxbpmak0tNxiD5MF2NVJffQW+WpANyrG0j+APYUkWrB1XZHvBUvqRGb
 mK4qDaI82jirEtDw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 588862C142;
 Mon, 20 Jun 2022 14:47:42 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 10742A0636; Mon, 20 Jun 2022 16:47:42 +0200 (CEST)
Date: Mon, 20 Jun 2022 16:47:42 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220620144742.hzzizy4pxogyuum4@quack3.lan>
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220620132737.2015073-4-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/4] syscalls/fanotify09: Tidy up the test to make
 it more readable
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 20-06-22 16:27:36, Amir Goldstein wrote:
> Document and tidy up the code dealing with mask flags FAN_ONDIR
> and FAN_EVENT_ONCHILD.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify09.c     | 44 ++++++++++++-------
>  1 file changed, 28 insertions(+), 16 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index a8d56c10b..070ad9933 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -12,21 +12,21 @@
>   */
>  
>  /*
> - * This is a regression test for commit 54a307ba8d3c:
> + * This is a regression test for commit:
>   *
> - *      fanotify: fix logic of events on child
> + *      54a307ba8d3c fanotify: fix logic of events on child
>   *
> - * Test case #1 is a regression test for commit b469e7e47c8a:
> + * Test case #1 is a regression test for commit:
>   *
> - *      fanotify: fix handling of events on child sub-directory
> + *      b469e7e47c8a fanotify: fix handling of events on child sub-directory
>   *
> - * Test case #2 is a regression test for commit 55bf882c7f13:
> + * Test case #2 is a regression test for commit:
>   *
> - *      fanotify: fix merging marks masks with FAN_ONDIR
> + *      55bf882c7f13 fanotify: fix merging marks masks with FAN_ONDIR
>   *
> - * Test case #5 is a regression test for commit 7372e79c9eb9:
> + * Test case #5 is a regression test for commit:
>   *
> - *      fanotify: fix logic of reporting name info with watched parent
> + *      7372e79c9eb9 fanotify: fix logic of reporting name info with watched parent
>   */
>  
>  #define _GNU_SOURCE
> @@ -131,13 +131,26 @@ static struct tcase {
>  static void create_fanotify_groups(struct tcase *tc)
>  {
>  	struct fanotify_mark_type *mark = &tc->mark;
> -	unsigned int i, onchild, report_name, ondir = tc->ondir;
> +	int i;
>  
>  	for (i = 0; i < NUM_GROUPS; i++) {
>  		/*
> -		 * The first group may request events with filename info.
> +		 * The first group may request events with filename info and
> +		 * events on subdirs and always request events on children.
>  		 */
> -		report_name = (i == 0) ? tc->report_name : 0;
> +		unsigned int report_name = tc->report_name;
> +		unsigned int mask_flags = tc->ondir | FAN_EVENT_ON_CHILD;
> +		unsigned int parent_mask;
> +
> +		/*
> +		 * The non-first groups do not request events on children and
> +		 * subdirs.
> +		 */
> +		if (i > 0) {
> +			report_name = 0;
> +			mask_flags = 0;
> +		}
> +
>  		fd_notify[i] = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | report_name |
>  						  FAN_NONBLOCK, O_RDONLY);
>  
> @@ -145,21 +158,20 @@ static void create_fanotify_groups(struct tcase *tc)
>  		 * Add subdir or mount mark for each group with CLOSE event,
>  		 * but only the first group requests events on dir.
>  		 */
> -		onchild = (i == 0) ? FAN_EVENT_ON_CHILD | ondir : 0;
>  		SAFE_FANOTIFY_MARK(fd_notify[i],
>  				    FAN_MARK_ADD | mark->flag,
> -				    FAN_CLOSE_NOWRITE | onchild,
> +				    FAN_CLOSE_NOWRITE | mask_flags,
>  				    AT_FDCWD, tc->close_nowrite);
>  
>  		/*
>  		 * Add inode mark on parent for each group with MODIFY event,
>  		 * but only the first group requests events on child.
>  		 * The one mark with FAN_EVENT_ON_CHILD is needed for
> -		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry
> -		 * flag.
> +		 * setting the DCACHE_FSNOTIFY_PARENT_WATCHED dentry flag.
>  		 */
> +		parent_mask = FAN_MODIFY | tc->ondir | mask_flags;
>  		SAFE_FANOTIFY_MARK(fd_notify[i], FAN_MARK_ADD,
> -				    FAN_MODIFY | ondir | onchild,
> +				    parent_mask,
>  				    AT_FDCWD, ".");
>  	}
>  }
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
