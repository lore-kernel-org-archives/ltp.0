Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DE35C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 10:48:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A3603C94F3
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 12:48:08 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B44503C1926
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:47:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D453A100052D
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:47:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 15C9621A82;
 Tue, 14 Jun 2022 10:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655203677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wTC4tNqwKtMa0igc+ep8rf+cEwBvn0w8Rpc5b/lQV3g=;
 b=cYDAK5+lA9ApTywWGvLzgHhRSkIwPN8bhyJyL62UPz2fPceIx6f/pv9D44VYOnGTM54Teh
 mvN3EofqQeLf9gjRkWe4RQTPZUTZ0FeSrBPzA0zIVJlf9PhOFHat6CT9VBAPMOzkdvoWF5
 XOovPtRWzd64Qqk3TEGt0S/l/VyVn2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655203677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wTC4tNqwKtMa0igc+ep8rf+cEwBvn0w8Rpc5b/lQV3g=;
 b=SsG6GFrK7+sbsTv6I2nCTiuN3eV2CsGj9hmC/UhTV/sC8SRWaN8Sk6q7AKrheHDbfMndi5
 LFzwP1ca0Zuzw8Aw==
Received: from quack3.suse.cz (unknown [10.163.28.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 05C422C141;
 Tue, 14 Jun 2022 10:47:57 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id B98CBA062E; Tue, 14 Jun 2022 12:47:56 +0200 (CEST)
Date: Tue, 14 Jun 2022 12:47:56 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220614104756.jvaaasc5vm5cm6rq@quack3.lan>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-5-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-5-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/5] syscalls/fanotify10: Mount cycle between test
 cases
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

On Mon 13-06-22 17:38:25, Amir Goldstein wrote:
> Mount cycle detects inode refcount errors and waits for all marks
> of test case to be destructed before continuing to next test case.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  .../kernel/syscalls/fanotify/fanotify10.c     | 25 +++++++++++++------
>  1 file changed, 18 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index efef25135..b9a50672d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -360,6 +360,17 @@ static void cleanup_fanotify_groups(void)
>  	}
>  }
>  
> +/* Flush out all pending dirty inodes and destructing marks */
> +static void mount_cycle(void)
> +{
> +	if (bind_mount_created)
> +		SAFE_UMOUNT(MNT2_PATH);
> +	SAFE_UMOUNT(MOUNT_PATH);
> +	SAFE_MOUNT(tst_device->dev, MOUNT_PATH, tst_device->fs_type, 0, NULL);
> +	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
> +	bind_mount_created = 1;
> +}
> +
>  static void verify_event(int p, int group, struct fanotify_event_metadata *event,
>  			 unsigned long long expected_mask)
>  {
> @@ -508,6 +519,7 @@ static void test_fanotify(unsigned int n)
>  	}
>  cleanup:
>  	cleanup_fanotify_groups();
> +	mount_cycle();
>  }
>  
>  static void setup(void)
> @@ -523,25 +535,24 @@ static void setup(void)
>  		num_classes = NUM_PRIORITIES;
>  	}
>  
> -	/* Create another bind mount at another path for generating events */
> -	SAFE_MKDIR(MNT2_PATH, 0755);
> -	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
> -	bind_mount_created = 1;
> -
>  	SAFE_MKDIR(DIR_PATH, 0755);
>  	SAFE_FILE_PRINTF(FILE_PATH, "1");
>  	SAFE_FILE_PRINTF(FILE2_PATH, "1");
>  
>  	SAFE_CP(TEST_APP, FILE_EXEC_PATH);
>  	SAFE_CP(TEST_APP, FILE2_EXEC_PATH);
> +
> +	/* Create another bind mount at another path for generating events */
> +	SAFE_MKDIR(MNT2_PATH, 0755);
> +	mount_cycle();
>  }
>  
>  static void cleanup(void)
>  {
>  	cleanup_fanotify_groups();
>  
> -	if (bind_mount_created && tst_umount(MNT2_PATH) < 0)
> -		tst_brk(TBROK | TERRNO, "bind umount failed");
> +	if (bind_mount_created)
> +		SAFE_UMOUNT(MNT2_PATH);
>  }
>  
>  static const char *const resource_files[] = {
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
