Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B4A8C77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 04:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750739964; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RkN/aIXYRTryt31DRT0igahn7R0G9tUU8vfOZKKdLjw=;
 b=Ocj7NHoTCuwfbuNF77DLJNLbPDWU18BmPEM8WiQN5JjjP8tWMVLwHZuFDx0iVSzp0A28g
 S0WGVKeJJ1M1p7O3/dbB8L56jOeCHtpX84aCi1X7JPo9+WzhfhqT4Ul1Px7+ixglyv2FvVR
 AtevqSkhuAPs1l1mBZKrQ9RBPxBxRAk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A71993CCAA8
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 06:39:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 44D603C312D
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 06:39:02 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0F7EA20116B
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 06:39:01 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a510432236so3606306f8f.0
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 21:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750739940; x=1751344740; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=gr6lBMvvtIkKqbp4tYBJR1awVSxi4ZAeFzekMIQBqnA=;
 b=cZbJ+Ca5A5A2UcVzaMUcsdC2N2UEUzZ+Uj6PFqDeT3XfE2XE84yq+wrxlaNON+2aoM
 0pkzxQo41xPFqUhVdKEpLex9cLa8HqgL4NEZZuGgNfnMw0K9w90UGAJUjkhXyPjffbkf
 3EPsP1k+hjoqYKsDpBM0sP330mHrI9LLNnZITdcSeC6CwPsBHqcJoW7mpXz0EvWHOS7m
 U4X9hWTbbDddF1YuYqo7TvLY8IRLwv0CC9Tj3bL7AI2+iX4xJal1Ibfg9lt5vUYcIfkM
 WfT89bstIUNfUxFiZbshJV4+CM42j4STHlZoL2KsyvjzrK9/sIy33silu5XjtEHdqe7h
 HucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750739940; x=1751344740;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gr6lBMvvtIkKqbp4tYBJR1awVSxi4ZAeFzekMIQBqnA=;
 b=UzziEut4SHpIbq4R3Mn4pDHS6ZbNq1z6ruXA+cBJ8QVJyjtHuIlr8Lg9n6/L8lSru2
 ibsxWP78C5N/LQAPJfe5sQf6y4h2rySAJQoax4gkIjVmD969QLbB/YSUR82XheWsgWm1
 oZyHtLNb7gBtNAUbOoxxtCL8N6fRw5UWeQNQOu37+8IdrrRYUIVdr9jGPreQL44sU3mY
 ItKJudwfgNObUvUPrcWJZqzECuepLTuYDQWYZlwQVFCKLjf1tS3zhHnFPxKApG2MgBif
 0xoQhkE4jxNrDvObo+6+1kJznTW+2AmNl56klT81zAZwrt8thBPVBJ+39g6yF//KZz42
 lrZQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWp+quAlP5QGnUab6rLeHk53YejwhM4VA37r0A/vxk1laaD0XpbGCyQdQ5xKwn7wvM7eZs=@lists.linux.it
X-Gm-Message-State: AOJu0YwRoszgcrunO5f9TTfuMW2MZW/7y+/gLJtD4+XL41U3JoYh55if
 GFjmRlzVpWgxh3HswnlFm9a62KJZ6DW84k8/fuvV3XLcPLZ6a9aEbD9Q+ZyQWxYDhg==
X-Gm-Gg: ASbGncthxdU+xCZ6wuBAJRlRAq2e0ZborVoFLuUgiyAO8SwUVuf5oRGXQMrr1BZ0RLl
 grOCFN3bHB9RIuKovQLePE1PUA52hPsKrfNtE/OkAlDdeasR3488W5fZ+H6nWTxQvXyTqYURlOJ
 YKy9+uvFLA6x0JHk/+JG13k1sCGprxxQdiY79iau55raBOrfz9Z/YElwkkiZNJjl1LAP3h87A1O
 wk320KCN0hDKK9AvV5pUiU1rtzNxIUlI8w1lvr+YfeMwR5RtTV5LNhOALvBNQBsNqJaC2KeUeNu
 y7Mmho5tjdedFc3hSaUNHVEpcIAjaGQQoTlT2BZxRoCmlLvygaa3XxMtD5vD5nJoF8j/4LL/
X-Google-Smtp-Source: AGHT+IGbImtoOIlMWFQcqQYDhUaad1M+95DIyy0UedD6sZt8tQAypba7sil8il1gMS6Y4EzV74aSWg==
X-Received: by 2002:a05:6000:4282:b0:3a5:783f:5296 with SMTP id
 ffacd0b85a97d-3a6d13339f6mr12735192f8f.56.1750739940379; 
 Mon, 23 Jun 2025 21:39:00 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-237d87182c8sm98693915ad.232.2025.06.23.21.38.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Jun 2025 21:38:59 -0700 (PDT)
Date: Tue, 24 Jun 2025 12:38:30 -0400
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <aFrUhlpMX-MmUIDg@MiWiFi-CR6608-srv>
References: <20250623073717.338178-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250623073717.338178-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify10,
 fanotify23: fix cleanup of vfs_cache_pressure
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Jan Kara <jack@suse.cz>, Al Viro <viro@zeniv.linux.org.uk>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Jun 23, 2025 at 09:37:17AM +0200, Amir Goldstein wrote:
> Avoid setting vfs_cache_pressure to zero if test was not run
> because kernel does not support fanotify.
> 
> Reported-by: Al Viro <viro@zeniv.linux.org.uk>
> Link: https://lore.kernel.org/linux-fsdevel/20250622215140.GX1880847@ZenIV/
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify10.c | 8 ++++----
>  testcases/kernel/syscalls/fanotify/fanotify23.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index ccb4f55df..2d33416f3 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -102,7 +102,6 @@ static int ignore_mark_unsupported;
>  #define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
>  #define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
>  
> -static int old_cache_pressure;
>  static pid_t child_pid;
>  static int bind_mount_created;
>  static unsigned int num_classes = NUM_CLASSES;
> @@ -925,7 +924,6 @@ static void setup(void)
>  	SAFE_MKDIR(MNT2_PATH, 0755);
>  	mount_cycle();
>  
> -	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
>  	/* Set high priority for evicting inodes */
>  	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
>  }
> @@ -939,8 +937,6 @@ static void cleanup(void)
>  	if (bind_mount_created)
>  		SAFE_UMOUNT(MNT2_PATH);
>  
> -	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
> -
>  	for (i = 0; i < max_file_multi; i++) {
>  		char path[PATH_MAX];
>  
> @@ -972,6 +968,10 @@ static struct tst_test test = {
>  		TEST_APP,
>  		NULL
>  	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{CACHE_PRESSURE_FILE, NULL, TST_SR_TCONF},
> +		{}
> +	},
>  	.tags = (const struct tst_tag[]) {
>  		{"linux-git", "9bdda4e9cf2d"},
>  		{"linux-git", "2f02fd3fa13e"},
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify23.c b/testcases/kernel/syscalls/fanotify/fanotify23.c
> index 26c9e87fb..36c7779da 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify23.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify23.c
> @@ -35,7 +35,6 @@
>  #define DROP_CACHES_FILE "/proc/sys/vm/drop_caches"
>  #define CACHE_PRESSURE_FILE "/proc/sys/vm/vfs_cache_pressure"
>  
> -static int old_cache_pressure;
>  static int fd_notify;
>  
>  static unsigned long long event_set[EVENT_MAX];
> @@ -234,7 +233,6 @@ static void setup(void)
>  						FAN_MARK_FILESYSTEM,
>  						FAN_ATTRIB, MOUNT_PATH);
>  
> -	SAFE_FILE_SCANF(CACHE_PRESSURE_FILE, "%d", &old_cache_pressure);
>  	/* Set high priority for evicting inodes */
>  	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "500");
>  }
> @@ -243,8 +241,6 @@ static void cleanup(void)
>  {
>  	if (fd_notify > 0)
>  		SAFE_CLOSE(fd_notify);
> -
> -	SAFE_FILE_PRINTF(CACHE_PRESSURE_FILE, "%d", old_cache_pressure);
>  }
>  
>  static struct tst_test test = {
> @@ -259,6 +255,10 @@ static struct tst_test test = {
>  		{.type = "ext2"},
>  		{}
>  	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{CACHE_PRESSURE_FILE, NULL, TST_SR_TCONF},
> +		{}
> +	},
>  };
>  
>  #else
> -- 
> 2.43.0

For me this patch more looks like an improvement instead of a fix.
Thanks for your patch.

Acked-by: Wei Gao <wegao@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
