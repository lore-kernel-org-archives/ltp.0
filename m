Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C69A2C38145
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 00:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 620AB3CA9AC
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 02:07:01 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A7CA3CA708
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 02:06:45 +0200 (CEST)
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com
 [IPv6:2607:f8b0:4864:20::f2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E0A321A0113A
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 02:06:44 +0200 (CEST)
Received: by mail-qv1-xf2b.google.com with SMTP id ml1so5728774qvb.1
 for <ltp@lists.linux.it>; Wed, 07 Sep 2022 17:06:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date;
 bh=52PbA29gz2RHmRHZ4e4H30yWwyZK+ohfedl1Pg9UsaE=;
 b=o+nm9Yi51CIcUHNdQEpSGUK2ghxmWS+4Qneu58Bnh4wF+/D4ISQgEdcHAmO/zd2a4L
 FZBL+PDDRBfDd/QTaeCXtntY5NUxmqFCxtZs48YXSBrz134X55InSOgiCGxoYd+m1JxK
 E+So3JuMHw4VIwBZjzkfgDiW+RKq0oUHCgRqQYP4SyVNrinU9ODRU7loZOd0LUJYVDy2
 4AGNsMP/pOgQzbd4XDAhsakMVm4qml7HKN9/QKoPdI9gAETt3hzVPHOkbEWJl7vRY5PA
 0UJMko/xIa9c8f7q9z/F4/NqHSPU8GqEOQgSQ9MuDqiKu+iQu6+yGFLJDzJmTxJsmrWb
 C6Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=52PbA29gz2RHmRHZ4e4H30yWwyZK+ohfedl1Pg9UsaE=;
 b=VW1Ecfux+r2axa0G+BqxLKqBC5PnfDcTJ1+MeB0WmZorlS29OuZItDwc3tqKZyCFRu
 vvB32bT9EBF9dx3Q1DplXQB9gpb5mA6+KjD96XQug+TS+2KGnOX4wCN/vk/itolX+7oo
 0cQo1oMHGtaDWOr6X2JbVvol/IDZomp+V1AtC5imneSf6gLereRTos2ol/1rl9NyxcCa
 M8ub5VF0G59zjpiaxmF2B7WpuM+Dy3Tt9V4+RcxF2oDUppr5ZTyk8GgQFoDLLt92GdFd
 Nhm7/r0Zep65XcWagx8waiaE0nNbAAkjZ6Gby/ICboXoH+eAEUK9IS/Fv2SbWIpOlRdd
 rt0g==
X-Gm-Message-State: ACgBeo0ymL1r4B6brvXzYVYbl3wwDbbKqn44Z9TgpdkxQeneTjSj7ldW
 VmKLFPs0px3GLdP+vberZnu3ew==
X-Google-Smtp-Source: AA6agR4V9QQhEvJdxBB9QuQTSa6DqBDcdekHFajAQKxXpLGI3Fdp3NXlLCZC18C2rBNiJyB9FVLMyw==
X-Received: by 2002:a0c:f481:0:b0:4aa:a2bf:afc3 with SMTP id
 i1-20020a0cf481000000b004aaa2bfafc3mr5668048qvm.74.1662595603545; 
 Wed, 07 Sep 2022 17:06:43 -0700 (PDT)
Received: from google.com (123.178.145.34.bc.googleusercontent.com.
 [34.145.178.123]) by smtp.gmail.com with ESMTPSA id
 he22-20020a05622a601600b00304fe5247bfsm13003045qtb.36.2022.09.07.17.06.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Sep 2022 17:06:43 -0700 (PDT)
Date: Thu, 8 Sep 2022 00:06:39 +0000
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YxkyD3AKC5aWFiLg@google.com>
References: <20220907110326.2915779-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220907110326.2915779-1-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/fanotify09: Make test case definitions
 more readable
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
From: Matthew Bobrowski via ltp <ltp@lists.linux.it>
Reply-To: Matthew Bobrowski <repnop@google.com>
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 07, 2022 at 02:03:26PM +0300, Amir Goldstein wrote:
> Use explicit field members to initialize test cases and omit
> fields initialized to zero to make the definitions more compact
> and more readable.

Looks fine. I guess we could adopt the same designated intializer pattern across
a bunch of other fanotify LTP tests.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> Rename the field s/close_nowrite/event_path to make its meaning
> less obscure.
>
> Suggested-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
> 
> Hi Petr,
> 
> Here is the cleanup you proposed.
> Please check that I did not make any mistakes...
> 
> Thanks,
> Amir.
> 
>  .../kernel/syscalls/fanotify/fanotify09.c     | 203 ++++++++----------
>  1 file changed, 94 insertions(+), 109 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify09.c b/testcases/kernel/syscalls/fanotify/fanotify09.c
> index e40916c08..3f2db4709 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -82,145 +82,130 @@ static struct tcase {
>  	unsigned int ignore;
>  	unsigned int ignore_flags;
>  	unsigned int report_name;
> -	const char *close_nowrite;
> +	const char *event_path;
>  	int nevents;
>  	unsigned int nonfirst_event;
>  } tcases[] = {
>  	{
> -		"Events on non-dir child with both parent and mount marks",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		0, 0,
> -		0,
> -		DIR_NAME,
> -		1, 0,
> +		.tname = "Events on non-dir child with both parent and mount marks",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.event_path = DIR_NAME,
> +		.nevents = 1,
>  	},
>  	{
> -		"Events on non-dir child and subdir with both parent and mount marks",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		0, 0,
> -		0,
> -		DIR_NAME,
> -		2, 0,
> +		.tname = "Events on non-dir child and subdir with both parent and mount marks",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.event_path = DIR_NAME,
> +		.nevents = 2,
>  	},
>  	{
> -		"Events on non-dir child and parent with both parent and mount marks",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		0, 0,
> -		0,
> -		".",
> -		2, 0
> +		.tname = "Events on non-dir child and parent with both parent and mount marks",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.event_path = ".",
> +		.nevents = 2,
>  	},
>  	{
> -		"Events on non-dir child and subdir with both parent and subdir marks",
> -		INIT_FANOTIFY_MARK_TYPE(INODE),
> -		FAN_ONDIR,
> -		0, 0,
> -		0,
> -		DIR_NAME,
> -		2, 0,
> +		.tname = "Events on non-dir child and subdir with both parent and subdir marks",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(INODE),
> +		.ondir = FAN_ONDIR,
> +		.event_path = DIR_NAME,
> +		.nevents = 2,
>  	},
>  	{
> -		"Events on non-dir children with both parent and mount marks",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		0, 0,
> -		0,
> -		FILE2_NAME,
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on non-dir children with both parent and mount marks",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.event_path = FILE2_NAME,
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	{
> -		"Events on non-dir child with both parent and mount marks and filename info",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		0, 0,
> -		FAN_REPORT_DFID_NAME,
> -		FILE2_NAME,
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on non-dir child with both parent and mount marks and filename info",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.report_name = FAN_REPORT_DFID_NAME,
> +		.event_path = FILE2_NAME,
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	{
> -		"Events on non-dir child with ignore mask on parent",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		FAN_MARK_IGNORED_MASK, 0,
> -		0,
> -		DIR_NAME,
> -		1, 0,
> +		.tname = "Events on non-dir child with ignore mask on parent",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ignore = FAN_MARK_IGNORED_MASK,
> +		.event_path = DIR_NAME,
> +		.nevents = 1,
>  	},
>  	{
> -		"Events on non-dir children with surviving ignore mask on parent",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY, 0,
> -		0,
> -		FILE2_NAME,
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on non-dir children with surviving ignore mask on parent",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ignore = FAN_MARK_IGNORED_MASK | FAN_MARK_IGNORED_SURV_MODIFY,
> +		.event_path = FILE2_NAME,
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	/* FAN_MARK_IGNORE test cases: */
>  	{
> -		"Events on dir with ignore mask that does not apply to dirs",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		FAN_MARK_IGNORE_SURV, 0,
> -		0,
> -		".",
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on dir with ignore mask that does not apply to dirs",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.event_path = ".",
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	{
> -		"Events on dir with ignore mask that does apply to dirs",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		FAN_MARK_IGNORE_SURV, FAN_ONDIR,
> -		0,
> -		".",
> -		2, 0,
> +		.tname = "Events on dir with ignore mask that does apply to dirs",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.ignore_flags = FAN_ONDIR,
> +		.event_path = ".",
> +		.nevents = 2,
>  	},
>  	{
> -		"Events on child with ignore mask on parent that does not apply to children",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		FAN_MARK_IGNORE_SURV, 0,
> -		0,
> -		FILE2_NAME,
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on child with ignore mask on parent that does not apply to children",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.event_path = FILE2_NAME,
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	{
> -		"Events on child with ignore mask on parent that does apply to children",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		0,
> -		FAN_MARK_IGNORE_SURV, FAN_EVENT_ON_CHILD,
> -		0,
> -		FILE2_NAME,
> -		2, 0,
> +		.tname = "Events on child with ignore mask on parent that does apply to children",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.ignore_flags = FAN_EVENT_ON_CHILD,
> +		.event_path = FILE2_NAME,
> +		.nevents = 2,
>  	},
>  	{
> -		"Events on subdir with ignore mask on parent that does not apply to children",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		FAN_MARK_IGNORE_SURV, FAN_ONDIR,
> -		0,
> -		DIR_NAME,
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on subdir with ignore mask on parent that does not apply to children",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.ignore_flags = FAN_ONDIR,
> +		.event_path = DIR_NAME,
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	{
> -		"Events on subdir with ignore mask on parent that does not apply to dirs",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		FAN_MARK_IGNORE_SURV, FAN_EVENT_ON_CHILD,
> -		0,
> -		DIR_NAME,
> -		2, FAN_CLOSE_NOWRITE,
> +		.tname = "Events on subdir with ignore mask on parent that does not apply to dirs",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.ignore_flags = FAN_EVENT_ON_CHILD,
> +		.event_path = DIR_NAME,
> +		.nevents = 2,
> +		.nonfirst_event = FAN_CLOSE_NOWRITE,
>  	},
>  	{
> -		"Events on subdir with ignore mask on parent that does apply to subdirs",
> -		INIT_FANOTIFY_MARK_TYPE(MOUNT),
> -		FAN_ONDIR,
> -		FAN_MARK_IGNORE_SURV, FAN_EVENT_ON_CHILD | FAN_ONDIR,
> -		0,
> -		DIR_NAME,
> -		2, 0,
> +		.tname = "Events on subdir with ignore mask on parent that does apply to subdirs",
> +		.mark = INIT_FANOTIFY_MARK_TYPE(MOUNT),
> +		.ondir = FAN_ONDIR,
> +		.ignore = FAN_MARK_IGNORE_SURV,
> +		.ignore_flags = FAN_EVENT_ON_CHILD | FAN_ONDIR,
> +		.event_path = DIR_NAME,
> +		.nevents = 2,
>  	},
>  };
>  
> @@ -261,7 +246,7 @@ static void create_fanotify_groups(struct tcase *tc)
>  		SAFE_FANOTIFY_MARK(fd_notify[i],
>  				    FAN_MARK_ADD | mark->flag,
>  				    FAN_CLOSE_NOWRITE | mask_flags,
> -				    AT_FDCWD, tc->close_nowrite);
> +				    AT_FDCWD, tc->event_path);
>  
>  		/*
>  		 * Add inode mark on parent for each group with MODIFY event,
> @@ -415,7 +400,7 @@ static void test_fanotify(unsigned int n)
>  	/*
>  	 * generate FAN_CLOSE_NOWRITE event on a child, subdir or "."
>  	 */
> -	dirfd = SAFE_OPEN(tc->close_nowrite, O_RDONLY);
> +	dirfd = SAFE_OPEN(tc->event_path, O_RDONLY);
>  	SAFE_CLOSE(dirfd);
>  
>  	/*
> @@ -443,7 +428,7 @@ static void test_fanotify(unsigned int n)
>  	}
>  	if (tc->nevents > 1 && FAN_EVENT_OK(event, ret)) {
>  		verify_event(0, event, FAN_CLOSE_NOWRITE,
> -			     tc->report_name ? (tc->ondir ? "." : tc->close_nowrite) : "");
> +			     tc->report_name ? (tc->ondir ? "." : tc->event_path) : "");
>  		event = FAN_EVENT_NEXT(event, ret);
>  	}
>  	if (ret > 0) {
> -- 
> 2.25.1
> 
/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
