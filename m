Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92815C00145
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:30:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BA5D3CBE7C
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:30:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5ABBD3CBE07
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:30:23 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1DFFA1400142
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:30:22 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 793D333750;
 Mon, 12 Dec 2022 15:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670859022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WjDqbtIacBh3QKb8PSo60sxcEAdfYbi385xqWIqOgAA=;
 b=LkXqPwEyGjVL96oWJHciS5Pve2QJlKwddBgQw5ee1G8uimx5X5WtoyVTmGUeUMmb41S7Bw
 nQHTRDesNjEkiYI718WT8Y8BN5EHsSbUK2PmaC8Js8UWmNMfgT8ekq0nHIa4ocSDsLd62f
 8JgpGYJyq0IFAhiVtZdvNQI2AXIPPok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670859022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WjDqbtIacBh3QKb8PSo60sxcEAdfYbi385xqWIqOgAA=;
 b=u5GyQcjvBghZOicvuo083ueCGrlWL6F6yNk++XjQSn9rON55W0cK8G9OWeOf/usLprSmCG
 K/w8sL+QUonBXrBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0A5C013456;
 Mon, 12 Dec 2022 15:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id A2Q8AQ5Jl2PKZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Dec 2022 15:30:22 +0000
Date: Mon, 12 Dec 2022 16:30:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y5dJDFk5DpAhTKDV@pevik>
References: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1670845229-1981-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/4] lib/tst_kvercmp: Remove old distnames
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Wanlong Gao <gaowanlong@cn.fujitsu.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Our travis-ci has dropped or never used them, they are useless.
> So delete.
They were here before CI. They were meant for using by tests
(no CI related at all).

Added by Wanlong Gao ~10 years ago. Agree they can be dropped, but
Cc Cyril, Li and Jan.

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  lib/tst_kvercmp.c                                   | 12 ------------
>  testcases/kernel/syscalls/inotify/inotify04.c       | 13 +++----------
>  .../kernel/tracing/dynamic_debug/dynamic_debug01.sh |  3 +--
>  3 files changed, 4 insertions(+), 24 deletions(-)

> diff --git a/lib/tst_kvercmp.c b/lib/tst_kvercmp.c
> index dc0daa746..a01b4332b 100644
> --- a/lib/tst_kvercmp.c
> +++ b/lib/tst_kvercmp.c
> @@ -134,18 +134,6 @@ const char *tst_kvcmp_distname(const char *kver)
>  	char *ret = distname;
>  	char *p = distname;

> -	if (strstr(kver, ".el5uek"))
> -		return "OL5UEK";
> -
> -	if (strstr(kver, ".el5"))
> -		return "RHEL5";
> -
> -	if (strstr(kver, ".el6uek"))
> -		return "OL6UEK";
> -
> -	if (strstr(kver, ".el6"))
> -		return "RHEL6";
> -
>  	if (strstr(kver, ".el7"))
>  		return "RHEL7";

> diff --git a/testcases/kernel/syscalls/inotify/inotify04.c b/testcases/kernel/syscalls/inotify/inotify04.c
> index fb9f5c293..c4fce399c 100644
> --- a/testcases/kernel/syscalls/inotify/inotify04.c
> +++ b/testcases/kernel/syscalls/inotify/inotify04.c
> @@ -50,11 +50,6 @@ char event_buf[EVENT_BUF_LEN];

>  int fd_notify, reap_wd_file, reap_wd_dir, wd_dir, wd_file;

> -static struct tst_kern_exv kvers[] = {
> -	{ "RHEL5", "2.6.18-132" },
> -	{ NULL, NULL },
> -};
> -
>  static void cleanup(void)
>  {
>  	if (reap_wd_dir && myinotify_rm_watch(fd_notify, wd_dir) == -1)
> @@ -110,11 +105,9 @@ void verify_inotify(void)
>  	 * This isn't well documented in inotify(7), but it's intuitive if you
>  	 * understand how Unix works.
>  	 */
> -	if (tst_kvercmp2(2, 6, 25, kvers) >= 0) {
> -		event_set[test_cnt].mask = IN_ATTRIB;
> -		strcpy(event_set[test_cnt].name, "");
> -		test_cnt++;
> -	}
> +	event_set[test_cnt].mask = IN_ATTRIB;
> +	strcpy(event_set[test_cnt].name, "");
> +	test_cnt++;

Isn't this unrelated change? I guess you remove it as part of cleanup of old
versions.

>  	event_set[test_cnt].mask = IN_DELETE_SELF;
>  	strcpy(event_set[test_cnt].name, TEST_FILE);
> diff --git a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> index 4b159517b..ca6c840b1 100755
> --- a/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> +++ b/testcases/kernel/tracing/dynamic_debug/dynamic_debug01.sh
> @@ -59,8 +59,7 @@ setup()
>  		tst_brk TBROK "Unable to find $DEBUGFS_CONTROL"
>  	fi

> -	# Both patches with changes were backported to RHEL6 kernel 2.6.32-547
> -	if tst_kvcmp -ge '3.4 RHEL6:2.6.32-547' ; then
> +	if tst_kvcmp -ge 3.4 ; then
>  		NEW_INTERFACE=1
>  		EMPTY_FLAG="=_"
>  	fi

Maybe first remove it from tests and then from infrastructure?
But I'm ok to keep it in single patch, but commit message should be
adjusted to not mention CI (not related to CI at all).

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
