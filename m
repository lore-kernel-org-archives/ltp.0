Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1AEC43334
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 10:26:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6035D3C9468
	for <ltp@archiver.kernel.org>; Tue, 14 Jun 2022 12:26:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F114E3C217F
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:26:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 354E32009F4
 for <ltp@lists.linux.it>; Tue, 14 Jun 2022 12:26:10 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5F25A1F460;
 Tue, 14 Jun 2022 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655202370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNO5C+ivOZ2yZr9voVWlMXGXW4q1ijlS8s2+2l2ULJc=;
 b=p6Ex6hj/AZ/WfffLV1dVyg6TWiHkjCO7njPlqorwlurXQ3qiKUwxKV8/R3YHsJmVBELyrz
 1wzvCIrFNHrtT2wOSsBayih9NX9hkNABiU8HD0/e0V4tMwm23Z6uG6EzoD2rU+U4e7sk9K
 KRIEcvPJKPDgsmy4lnlUIAJzuo7BCwc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655202370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uNO5C+ivOZ2yZr9voVWlMXGXW4q1ijlS8s2+2l2ULJc=;
 b=vM8UvmDivPJXV0rWB1Q2DnAeOk7OCcdG8DxH5MXlmSAwWLH+T9ytITrPWNo8Pr+SqvIZVN
 WgiWamxVVr3QGWAA==
Received: from quack3.suse.cz (unknown [10.163.28.18])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4C5252C141;
 Tue, 14 Jun 2022 10:26:10 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 080C4A062E; Tue, 14 Jun 2022 12:26:10 +0200 (CEST)
Date: Tue, 14 Jun 2022 12:26:09 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220614102609.matiab5wmhc43nm4@quack3.lan>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-4-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220613143826.1328830-4-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] syscalls/fanotify10: Watch directory that is
 not the mount path
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

On Mon 13-06-22 17:38:24, Amir Goldstein wrote:
> Move the test file into a test directory, so we won't set a mark
> on the mount path when watching the children of a directory.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

One question below...

> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 067dd65ae..efef25135 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -74,16 +74,19 @@ static int filesystem_mark_unsupported;
>  
>  #define MOUNT_PATH "fs_mnt"
>  #define MNT2_PATH "mntpoint"
> +#define DIR_NAME "testdir"
>  #define FILE_NAME "testfile"
>  #define FILE2_NAME "testfile2"
>  #define TEST_APP "fanotify_child"
>  #define TEST_APP2 "fanotify_child2"
> -#define FILE_PATH MOUNT_PATH"/"FILE_NAME
> -#define FILE2_PATH MOUNT_PATH"/"FILE2_NAME
> +#define DIR_PATH MOUNT_PATH"/"DIR_NAME
> +#define FILE_PATH DIR_PATH"/"FILE_NAME
> +#define FILE2_PATH DIR_PATH"/"FILE2_NAME
>  #define FILE_EXEC_PATH MOUNT_PATH"/"TEST_APP
>  #define FILE2_EXEC_PATH MOUNT_PATH"/"TEST_APP2
> -#define FILE_MNT2 MNT2_PATH"/"FILE_NAME
> -#define FILE2_MNT2 MNT2_PATH"/"FILE2_NAME
> +#define DIR_MNT2 MNT2_PATH"/"DIR_NAME
> +#define FILE_MNT2 DIR_MNT2"/"FILE_NAME
> +#define FILE2_MNT2 DIR_MNT2"/"FILE2_NAME
>  #define FILE_EXEC_PATH2 MNT2_PATH"/"TEST_APP
>  #define FILE2_EXEC_PATH2 MNT2_PATH"/"TEST_APP2
>  
> @@ -239,50 +242,50 @@ static struct tcase {
>  	},
>  	{
>  		"ignore events on children of directory created on a specific file",
> -		MNT2_PATH, FANOTIFY_INODE,
> -		FILE_PATH, FANOTIFY_INODE,
> +		DIR_MNT2, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,

I'm somewhat confused here why you remove the FILE_PATH test here... In all
the other tests you just replace MNT2_PATH with DIR_PATH which makes sense.

								Honza

>  		FAN_EVENT_ON_CHILD,
>  		FILE_PATH, 0, FAN_OPEN
>  	},
>  	{
>  		"ignore events on file created inside a parent watching children",
>  		FILE_PATH, FANOTIFY_INODE,
> -		MNT2_PATH, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,
>  		FAN_EVENT_ON_CHILD,
>  		FILE_PATH, 0, FAN_OPEN
>  	},
>  	{
>  		"don't ignore events on file created inside a parent not watching children",
>  		FILE_PATH, FANOTIFY_INODE,
> -		MNT2_PATH, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,
>  		0,
>  		FILE_PATH, FAN_OPEN, FAN_OPEN
>  	},
>  	{
>  		"ignore mount events created inside a parent watching children",
>  		FILE_PATH, FANOTIFY_MOUNT,
> -		MNT2_PATH, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,
>  		FAN_EVENT_ON_CHILD,
>  		FILE_PATH, 0, FAN_OPEN
>  	},
>  	{
>  		"don't ignore mount events created inside a parent not watching children",
>  		FILE_PATH, FANOTIFY_MOUNT,
> -		MNT2_PATH, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,
>  		0,
>  		FILE_PATH, FAN_OPEN, FAN_OPEN
>  	},
>  	{
>  		"ignore fs events created inside a parent watching children",
>  		FILE_PATH, FANOTIFY_FILESYSTEM,
> -		MNT2_PATH, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,
>  		FAN_EVENT_ON_CHILD,
>  		FILE_PATH, 0, FAN_OPEN
>  	},
>  	{
>  		"don't ignore fs events created inside a parent not watching children",
>  		FILE_PATH, FANOTIFY_FILESYSTEM,
> -		MNT2_PATH, FANOTIFY_INODE,
> +		DIR_PATH, FANOTIFY_INODE,
>  		0,
>  		FILE_PATH, FAN_OPEN, FAN_OPEN
>  	},
> @@ -525,6 +528,7 @@ static void setup(void)
>  	SAFE_MOUNT(MOUNT_PATH, MNT2_PATH, "none", MS_BIND, NULL);
>  	bind_mount_created = 1;
>  
> +	SAFE_MKDIR(DIR_PATH, 0755);
>  	SAFE_FILE_PRINTF(FILE_PATH, "1");
>  	SAFE_FILE_PRINTF(FILE2_PATH, "1");
>  
> -- 
> 2.25.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
