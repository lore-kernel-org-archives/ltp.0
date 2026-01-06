Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B80ADC47BE2
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1767696552; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=Yi9uWhrb2sOh7d/AL56AaguVHbPoFH5oU07547asHFI=;
 b=oMdEnPmppxKDWU67BJTzmNFfIDdG2YzQN8eltjWTww6enXdGDp5maLn926BIeR1nwC/12
 gAkOafQUCHmocTzf0hk0mrMGqQWbyjTlnJDsQkW1fokmt8Bmnlyjlk9k/5ejyitWztja47E
 ZN+V+KXJV1KiMGTzFXmpykRJDZUGNp4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4487E3C1028
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 11:49:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8850B3C029D
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 11:48:48 +0100 (CET)
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com
 [IPv6:2a00:1450:4864:20::12f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0661B2003B8
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 11:48:48 +0100 (CET)
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-59b679cff1fso286205e87.0
 for <ltp@lists.linux.it>; Tue, 06 Jan 2026 02:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1767696527; x=1768301327; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H30Gv3PT4xmFDVXJLSBG5jO6rJZGhacOLmDaWCRkdsU=;
 b=W6FK54oHQu7h+T62tSv7gO1BByiXRqpwxH2ZQBvyx8E4ygOgeb4zzLAFPeCjI9Po2q
 cCOYdk7FsZEAHgEuEq4b43WQxi1ut3RQPFpzEgOZmLe0AwrAJZ59sBhs8pVqdgdWBtR6
 /thwibCjXTvZ5DjPGYiOfE6flJJjd3JBBiGW9jWRrRygwgvX04O9msHzZy6axeMFmIzy
 EiI5aE14mBCyfR4cjeXeKtJJhnjcSyj1SXQ1q6JSBiw5WNx/MQgPfRQ/QkU7ac17VZEE
 IOozXRTPEXpOcPTLlLzY+Str79r8m9w8D14CZrhRr6GUEKEFm3bzPFsyWIYRX+egVbbt
 FpnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767696527; x=1768301327;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H30Gv3PT4xmFDVXJLSBG5jO6rJZGhacOLmDaWCRkdsU=;
 b=IbhCpK9NmEchIQmSGHCqo1RviMyHyQ2h8dv7Wo4Bt+uddU78a30TyVv6S06R+D2J8T
 c2Vv4loKN/UN6gI7CPdcARBGCOfhOM6D4OMYnrUTNSOlQQC6ZTKoWTT1eNWuI/g+5Ulq
 VdICTYpJr7PvMY74hprZSza70iSsmWAv/zksDV9UtlRGW6oPBBm8r6TevcyApmZZdp1f
 5ewIGvEXWsQ2LMp1vWb0RjVApqOHD0QvlSJ57sIOnVEv9V1AKxCDn161OuEV9cC8JJ5D
 Bf65oE/hB5ifPVrKSgYNtOwy9duifS7QVW8KZ8mcZ8TIXNt7sQ+bh0nikLT3KDLXAn/V
 vr9Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXV7VY9CfuFtZcMSFWXpofbRSIiR7JA+kbrraDQtGjX4i56IDgI2zR64FMeNuNwFgM7kDc=@lists.linux.it
X-Gm-Message-State: AOJu0YwbtwBut6YFTDQguwXjmfa7ETCPvlOcGVzgQNmwx5Kw8RUeKQ/n
 +Fz/xMJV9w91Sr/O2MJdN/aqghBG/27YTw+mKROFtPPPcLaM0TXilTeMrKSpJmC8GPY=
X-Gm-Gg: AY/fxX794oY+Mv2IlBi1qA6TrvhnxxqluVIXuuf0KRpLxQZqzWdvWS7lOUgqjqZbPbe
 Dopa2yToEOE8Z+wXin6h+wsFt/55ceRxAOBT74PBW8BdXVNgmLxLj/3xP7ZE7kFlltN+gldygiU
 aE/5gV/7gZRI0pZtgSyAsRXi+1Mxs59LNTZOIot6Wi5RSLNEfXq3PN5jepz/hSPGmJ6XtpKSVYg
 Nu0pYwvBL6Vn2Xn/OgY7HDVetnPHy+zMlo2Cv9gaSN6VE42wfmGjGlO5Z7XF6Qp8niq7pzem20e
 YdI9hobLAPbAyyCjQ9F/THp4S5027f+J4Oc+Pe+aeR2IYhUBcPuIiatb2BHOFDz2ChtHe0TVMlb
 8rwGqmIo9VYteujg9FzkYq1aoY6AF3hOlJPyo6CVAg0udDzDXQkLD48fr8vL5p+FngtiG2bBWni
 n055b8qrszVHRt
X-Google-Smtp-Source: AGHT+IHqwQNM1pNqw02H22E3o1l2TiGjSqEOXjwbdGwur1fZbkpxQW2v7ubPibwqhITvOsb4DCXcBQ==
X-Received: by 2002:a05:6512:3d18:b0:594:253c:209a with SMTP id
 2adb3069b0e04-59b65284758mr972824e87.14.1767696527078; 
 Tue, 06 Jan 2026 02:48:47 -0800 (PST)
Received: from localhost ([88.128.90.65]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-59b6a2b8330sm222216e87.10.2026.01.06.02.48.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jan 2026 02:48:46 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 06 Jan 2026 11:48:45 +0100
Message-Id: <DFHG4D0QCH0V.15I5KETZLUUJ5@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260105130359.647879-1-pvorel@suse.cz>
In-Reply-To: <20260105130359.647879-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] make check: b3: Use --strict when run
 checkpatch.pl
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Mon Jan 5, 2026 at 2:03 PM CET, Petr Vorel wrote:
> The main motivation is to show typos on 'make check' which require --strict:
>
> * TYPO_SPELLING
> tst_cgroup.h:127: CHECK: 'libary' may be misspelled - perhaps 'library'?

+1

>
> Other checks included:
>
> * LINE_SPACING
> tst_test.h:174: CHECK: Please don't use multiple blank lines

+1

>
> * MACRO_ARG_REUSE:
> tst_test.h:69: CHECK: Macro argument reuse 'ttype' - possible side-effects?
>     #define tst_res(ttype, arg_fmt, ...) \
> 	({									\
> 		TST_RES_SUPPORTS_TCONF_TDEBUG_TFAIL_TINFO_TPASS_TWARN(\
> 			!((TTYPE_RESULT(ttype) ?: TCONF) & \
> 	...

+1

>
> * LONG_LINE:
> tst_test.h:73: CHECK: line length of 105 exceeds 100 columns
> => enforced by --strict because we miss kernel fix from v6.11:
> d6bb39519aafe ("checkpatch: really skip LONG_LINE_* when LONG_LINE is ignored")
> (will be fixed by checkpatch.pl update in next commit).

Tricky, I would leave this choice to reviewers.

>
> Whitelist all other checks added by --strict.
> Update also b4 config.
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: here are checked whitelisted. Do we want to add some of these?
>
> Kind regards,
> Petr
>
> * LONG_LINE:
> tst_test.h:73: CHECK: line length of 105 exceeds 100 columns

Like above.

>
> * SPACING
> tst_test.c:1239: CHECK: spaces preferred around that '|' (ctx:VxV)

+1

>
> * MULTIPLE_ASSIGNMENTS
> tst_test.c:1419: CHECK: multiple assignments should be avoided
> TCID = tcid = get_tcid(argv);

+1

>
> * UNNECESSARY_PARENTHESES
> tst_test.c:802: CHECK: Unnecessary parentheses around toptions[i].arg
> *(toptions[i].arg) = optarg ? optarg : "";

Also tricky, sometimes parentheses are useful to clarify certain
concepts.

>
> * PARENTHESIS_ALIGNMENT
> tst_test.c:1300: CHECK: Alignment should match open parenthesis
> 	mnt_data = limit_tmpfs_mount_size(fs->mnt_data,
> 					buf, sizeof(buf), tdev.fs_type);
>

It really depends, for me it's too strick.

> * BRACES
> tst_test.c:2069: CHECK: Blank lines aren't necessary before a close brace '}'
> tst_test.c:1560: CHECK: Blank lines aren't necessary after an open brace '{'
> 	if (!tst_test->all_filesystems && count_fs_descs() <= 1) {
>
> 			if (!tst_fs_is_supported(tdev.fs_type))

+1

>
> * CONCATENATED_STRING
> tst_test.c:200: CHECK: Concatenated strings should use spaces between elements
> 	tst_brk(TBROK, IPC_ENV_VAR" is not defined");

+1

>
> * PREFER_KERNEL_TYPES
> tst_test.c:74: CHECK: Prefer kernel type 's32' over 'int32_t'
> => obviously kernel related

This is kernel related and I would use stdint.h definitions instead,
otherwise we need to import linux headers to use types and we don't
need that.

>
>  .b4-config             | 4 ++--
>  include/mk/env_post.mk | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/.b4-config b/.b4-config
> index 36aa15c38f..5ff045b55b 100644
> --- a/.b4-config
> +++ b/.b4-config
> @@ -4,6 +4,6 @@
>      send-series-to = Linux Test Project <ltp@lists.linux.it>
>      pw-url = https://patchwork.ozlabs.org/
>      pw-project = ltp
> -    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
> -    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
> +    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,BRACES,CONCATENATED_STRING
> +    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,BRACES,CONCATENATED_STRING
>  
> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
> index ab31da73af..947151457b 100644
> --- a/include/mk/env_post.mk
> +++ b/include/mk/env_post.mk
> @@ -73,7 +73,7 @@ CHECK_TARGETS			?= $(addprefix check-,$(notdir $(patsubst %.c,%,$(sort $(wildcar
>  CHECK_TARGETS			:= $(filter-out $(addprefix check-, $(FILTER_OUT_MAKE_TARGETS)), $(CHECK_TARGETS))
>  CHECK_HEADER_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.h))))
>  CHECK				?= $(abs_top_srcdir)/tools/sparse/sparse-ltp
> -CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES
> +CHECK_NOFLAGS			?= $(abs_top_srcdir)/scripts/checkpatch.pl -f --no-tree --terse --no-summary --strict --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING,FILE_PATH_CHANGES,PREFER_KERNEL_TYPES,LONG_LINE,MACRO_ARG_REUSE,SPACING,MULTIPLE_ASSIGNMENTS,UNNECESSARY_PARENTHESES,PARENTHESIS_ALIGNMENT,BRACES,CONCATENATED_STRING
>  SHELL_CHECK			?= $(abs_top_srcdir)/scripts/checkbashisms.pl --force --extra
>  SHELL_CHECK_TARGETS		?= $(addprefix check-,$(notdir $(sort $(wildcard $(abs_srcdir)/*.sh))))
>  


Thanks for checking this.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
