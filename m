Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FA3C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:59:21 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4F4560F56
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 11:59:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E4F4560F56
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384A33C71AC
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 12:59:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE5D53C58AF
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:59:09 +0100 (CET)
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com
 [IPv6:2607:f8b0:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DBE5D1A00245
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 12:59:08 +0100 (CET)
Received: by mail-pf1-x429.google.com with SMTP id y4so4922190pfa.5
 for <ltp@lists.linux.it>; Tue, 02 Nov 2021 04:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=QTlz4mPmSXJXulWaI3W7DyrjbcvRROyguUAu6VgIMcM=;
 b=HU0a4Q5E1sbrGT9zCp65mrv8jXTUfbqw3EyubLTXwcKbyDqO7AChG7CJfCGQlL1Cau
 yHHFg78Yh6/q2AqBQ2nirvOhgpaSnU4D0VNo04GfRzC7cb19R0lCLkfQFaPE+sDoK9dC
 NmK+nFdvwO5w5RgXaPn9daZeUMsCl3Bg9RqLJ2X4uKHlHgvhOKzPvN5nZY9VkHzzLeuo
 nAS4FBmW0Vt9z6qOkx+mPTHt/2aAm51JMUiSD5GjFoMgVgEurFYARB1aqbMaD3LZH0zW
 RoEyrgVjT/utjx/7+BdcPWqawmlFMlQifwQ6IpB6Vyoe63RR4bTPr7hgKUInIGY5D8nT
 R6og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QTlz4mPmSXJXulWaI3W7DyrjbcvRROyguUAu6VgIMcM=;
 b=c7IKszgoIxFb64IWF61ByeopZxBlOM784QD80i9fFcLutgHpCU0xbEmonXpDVdjbu6
 zElVa8aNz97NrfyoAA+tqFy2UUJxEOrYXEgjPIpUMnP+qJWiH8w4w1EUB9VzlsAr2N+f
 rMa580MBfGV5VBz40usZc/NO4imALYksfj8rdMZyDgxsWRZBZOA2iLhaeWNA/J/bNRIX
 +qk0EH5QAv6k6BqvL2qnvMiVEAHSk7WEISe1rZ/3+dRRGj73GpDnZTzMvbut+9cp9UHn
 jrOCcMUCjeuZXYatMle2Qn5gol8uhjz0RdSThSB4W2C9FibwWN68UG8ZaqkGY6sOeKzd
 X71A==
X-Gm-Message-State: AOAM531STsewypQKUAQshi3jjPQ9f97qWzunq1BkZXCcePNyXheiybWx
 ZU7olxVIZESp7QVZQwqGlKguAA==
X-Google-Smtp-Source: ABdhPJx8s94AcxtTQWn5+zdMWGa/RRM12ZAo7/b7NR5cDzmqs1KB42ofsUncXIece+KP49W5tRUmWw==
X-Received: by 2002:a63:954a:: with SMTP id t10mr27348586pgn.89.1635854345860; 
 Tue, 02 Nov 2021 04:59:05 -0700 (PDT)
Received: from google.com (64.157.240.35.bc.googleusercontent.com.
 [35.240.157.64])
 by smtp.gmail.com with ESMTPSA id n12sm15645895pgh.55.2021.11.02.04.59.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 04:59:05 -0700 (PDT)
Date: Tue, 2 Nov 2021 11:58:58 +0000
To: Gabriel Krisman Bertazi <krisman@collabora.com>
Message-ID: <YYEoAr743j3IO3ol@google.com>
References: <20211029211732.386127-1-krisman@collabora.com>
 <20211029211732.386127-3-krisman@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211029211732.386127-3-krisman@collabora.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/9] syscalls: fanotify: Add macro to require
 specific events
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
Cc: kernel@collabora.com, khazhy@google.com, jack@suse.com,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 29, 2021 at 06:17:25PM -0300, Gabriel Krisman Bertazi wrote:
> Add a helper for tests to fail if an event is not available in the
> kernel.  Since some events only work with REPORT_FID or a specific
> class, update the verifier to allow those to be specified.
> 
> Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

Made a single comment, otherwise this looks OK to me.

Reviewed-by: Matthew Bobrowski <repnop@google.com>

> ---
> Changes since v1:
>   - Use SAFE_FANOTIFY_INIT instead of open coding. (Amir)
>   - Use FAN_CLASS_NOTIF for fanotify12 testcase. (Amir)
> ---
>  testcases/kernel/syscalls/fanotify/fanotify.h   | 17 ++++++++++++++---
>  testcases/kernel/syscalls/fanotify/fanotify03.c |  4 ++--
>  testcases/kernel/syscalls/fanotify/fanotify10.c |  3 ++-
>  testcases/kernel/syscalls/fanotify/fanotify12.c |  3 ++-
>  4 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify.h b/testcases/kernel/syscalls/fanotify/fanotify.h
> index c67db3117e29..820073709571 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify.h
> +++ b/testcases/kernel/syscalls/fanotify/fanotify.h
> @@ -266,14 +266,16 @@ static inline void require_fanotify_access_permissions_supported_by_kernel(void)
>  	SAFE_CLOSE(fd);
>  }
>  
> -static inline int fanotify_events_supported_by_kernel(uint64_t mask)
> +static inline int fanotify_events_supported_by_kernel(uint64_t mask,
> +						      unsigned int init_flags,
> +						      unsigned int mark_flags)
>  {
>  	int fd;
>  	int rval = 0;
>  
> -	fd = SAFE_FANOTIFY_INIT(FAN_CLASS_CONTENT, O_RDONLY);
> +	fd = SAFE_FANOTIFY_INIT(init_flags, O_RDONLY);
>  
> -	if (fanotify_mark(fd, FAN_MARK_ADD, mask, AT_FDCWD, ".") < 0) {
> +	if (fanotify_mark(fd, FAN_MARK_ADD | mark_flags, mask, AT_FDCWD, ".") < 0) {
>  		if (errno == EINVAL) {
>  			rval = -1;
>  		} else {
> @@ -378,4 +380,13 @@ static inline int fanotify_mark_supported_by_kernel(uint64_t flag)
>  				    fanotify_mark_supported_by_kernel(mark_type)); \
>  } while (0)
>  
> +#define REQUIRE_FANOTIFY_EVENTS_SUPPORTED_ON_FS(init_flags, mark_type, mask, fname) do { \
> +	if (mark_type)							\
> +		REQUIRE_MARK_TYPE_SUPPORTED_ON_KERNEL(mark_type);	\
> +	if (init_flags)							\
> +		REQUIRE_FANOTIFY_INIT_FLAGS_SUPPORTED_ON_FS(init_flags, fname); \
> +	fanotify_init_flags_err_msg(#mask, __FILE__, __LINE__, tst_brk_, \
> +		fanotify_events_supported_by_kernel(mask, init_flags, mark_type)); \
> +} while (0)
> +
>  #endif /* __FANOTIFY_H__ */
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify03.c b/testcases/kernel/syscalls/fanotify/fanotify03.c
> index 26d17e64d1f5..2081f0bd1b57 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify03.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify03.c
> @@ -323,8 +323,8 @@ static void setup(void)
>  	require_fanotify_access_permissions_supported_by_kernel();
>  
>  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
> -	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM);
> -
> +	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC_PERM,
> +								      FAN_CLASS_CONTENT, 0);
>  	sprintf(fname, MOUNT_PATH"/fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
>  
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify10.c b/testcases/kernel/syscalls/fanotify/fanotify10.c
> index 92e4d3ff3054..0fa9d1f4f7e4 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify10.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify10.c
> @@ -509,7 +509,8 @@ cleanup:
>  
>  static void setup(void)
>  {
> -	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +								      FAN_CLASS_CONTENT, 0);

I'm wondering whether this is the best combination of mask and
init_flags to use in this particular case? Maybe not to confuse future
readers, using FAN_CLASS_NOTIF explicitly here would be better, WDYT?
It doesn't make a difference, but it's something that caught my eye
while parsing this patch.

>  	filesystem_mark_unsupported = fanotify_mark_supported_by_kernel(FAN_MARK_FILESYSTEM);
>  	fan_report_dfid_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_DFID_NAME,
>  									  MOUNT_PATH);
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify12.c b/testcases/kernel/syscalls/fanotify/fanotify12.c
> index 76f1aca77615..c77dbfd8c23d 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify12.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify12.c
> @@ -222,7 +222,8 @@ cleanup:
>  
>  static void do_setup(void)
>  {
> -	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC);
> +	exec_events_unsupported = fanotify_events_supported_by_kernel(FAN_OPEN_EXEC,
> +								      FAN_CLASS_NOTIF, 0);
>  
>  	sprintf(fname, "fname_%d", getpid());
>  	SAFE_FILE_PRINTF(fname, "1");
> -- 
> 2.33.0

/M

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
