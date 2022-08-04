Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C68DC19F2B
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 10:28:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E5FA3C9378
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 12:28:26 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720683C25D7
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 12:28:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D7DBF600F9D
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 12:28:15 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D46EC37C61;
 Thu,  4 Aug 2022 10:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1659608894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iIBuEC43DEkA8oduiKuox1JqAYdvsiglHpnFrQ3pJHo=;
 b=pGtnvP+lYvYlGDLDcfMk+zW7ACcgCe09QtJZsy/km9XHMN3gtOfBvdpqfaNOrowgjJDB+2
 TPeErvRPp+GLFn103hAl4/RxZWhCVSloiTH2BObHfG0jTZAgoHg3m+bBF8i6yhtAZ2wctn
 0THAOcRk8tQO0j+y8OtkjByzIWLAnng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1659608894;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iIBuEC43DEkA8oduiKuox1JqAYdvsiglHpnFrQ3pJHo=;
 b=YlGDjRziaPYtboiduPfsJ4xCp5OSOWZqlGS3yuGY5WwAFuQtbL8e+Gk0/NHL6QMxdJN7Gz
 6ikamx3msrY8FNDA==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 85D212C141;
 Thu,  4 Aug 2022 10:28:14 +0000 (UTC)
References: <1659521981-2241-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Thu, 04 Aug 2022 11:24:08 +0100
In-reply-to: <1659521981-2241-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87zggks3pe.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> safe_cg_open is used to open the sub control's file ie cgroup.procs
> and returns the fd.
>
> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/tst_cgroup.h | 15 +++++++++++++++
>  lib/tst_cgroup.c     | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 54 insertions(+)
>
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index d06847cc6..292c9baa4 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -188,6 +188,21 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>  			 char *const out, const size_t len)
>  			 __attribute__ ((nonnull));
>  
> +#define SAFE_CG_OPEN(cg, file_name, flags)			\
> +	safe_cg_open(__FILE__, __LINE__, (cg), (file_name), (flags))
> +
> +int safe_cg_open(const char *const file, const int lineno,
> +		 const struct tst_cg_group *const cg,
> +		 const char *const file_name, int flags);
> +
> +#define SAFE_CG_FCHOWN(cg, file_name, owner, group)		\
> +	safe_cg_fchown(__FILE__, __LINE__,			\
> +			   (cg), (file_name), (owner), (group))
> +
> +void safe_cg_fchown(const char *const file, const int lineno,
> +		    const struct tst_cg_group *const cg,
> +		    const char *const file_name, uid_t owner, gid_t group);
> +
>  #define SAFE_CG_PRINTF(cg, file_name, fmt, ...)			\
>  	safe_cg_printf(__FILE__, __LINE__,				\
>  			   (cg), (file_name), (fmt), __VA_ARGS__)
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 1cfd79243..dedc0f65b 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -1297,6 +1297,45 @@ ssize_t safe_cg_read(const char *const file, const int lineno,
>  	return read_ret;
>  }
>  
> +int safe_cg_open(const char *const file, const int lineno,
> +			const struct tst_cg_group *cg,
> +			const char *const file_name, int flags)
> +{
> +	const struct cgroup_file *const cfile =
> +		cgroup_file_find(file, lineno, file_name);
> +	struct cgroup_dir *const *dir;
> +	const char *alias;
> +	int fd;
> +
> +	for_each_dir(cg, cfile->ctrl_indx, dir) {
> +		alias = cgroup_file_alias(cfile, *dir);
> +		if (!alias)
> +			continue;
> +
> +		fd = safe_openat(file, lineno, (*dir)->dir_fd, alias,
> flags);

This will only return the last fd that gets opened. That's OK if the
file only exists on a single V1 controller, but if it exists on multiple
controllers (e.g. any cgroup.* file) then we will open multiple files
and only return the fd for the last of them.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
