Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 017DFC77B7F
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 07:53:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5A963CB2CF
	for <ltp@archiver.kernel.org>; Wed, 17 May 2023 09:53:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED95F3CB2BF
 for <ltp@lists.linux.it>; Wed, 17 May 2023 09:53:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0C8721A00919
 for <ltp@lists.linux.it>; Wed, 17 May 2023 09:53:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18D52228F7;
 Wed, 17 May 2023 07:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684310007;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNL8wKOdKi3xSfXjqos1IdWVv8RJrIyjWgJQVpMvbfY=;
 b=3Rt9eut12OrtG8R/4d4uDsasPLZ3qVmpwzzH/h19DAZurX4pnoX2kVDBGUgKlQF7GcGr/s
 lNgtpUBNO7U6gBHySFbYn2Vl5d7dZ5N7kbqeSC94EwWskxIUCgFdDpGKjiD2Nie+MFlAUG
 34eS9ESrQqIuRd3s5Z0pZTWJeDS+J/k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684310007;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNL8wKOdKi3xSfXjqos1IdWVv8RJrIyjWgJQVpMvbfY=;
 b=zX4TPmUguGUw6dhB8b2tTyRaaePT1batzNl8XFCekLMDMoCY9Ok8YaZiboeIcOQnFf/og9
 klnoEZUOdLhRItCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F1C4813358;
 Wed, 17 May 2023 07:53:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Mh31OfaHZGT/GQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 17 May 2023 07:53:26 +0000
Date: Wed, 17 May 2023 11:28:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230517092823.GA19852@pevik>
References: <20230422014216.26294-1-wegao@suse.com>
 <20230509003148.16094-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230509003148.16094-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] clone3: Add clone3's clone_args cgroup
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

...
> +++ b/include/tst_cgroup.h
> @@ -157,6 +157,9 @@ const char *
>  tst_cg_group_name(const struct tst_cg_group *const cg)
>  		      __attribute__ ((nonnull, warn_unused_result));

Maybe to add a comment to describe the function? (other functions have a
description).

> +int tst_cg_group_unified_dir_fd(const struct tst_cg_group *const cg)
> +		      __attribute__ ((nonnull, warn_unused_result));
> +
>  /* Remove a descendant CGroup */
>  struct tst_cg_group *
>  tst_cg_group_rm(struct tst_cg_group *const cg)
> diff --git a/include/tst_clone.h b/include/tst_clone.h
> index 9ffdc68d1..7b278dfa7 100644
> --- a/include/tst_clone.h
> +++ b/include/tst_clone.h
> @@ -11,6 +11,7 @@
>  struct tst_clone_args {
>  	uint64_t flags;
>  	uint64_t exit_signal;
> +	uint64_t cgroup;
>  };

...
> +++ b/testcases/kernel/syscalls/clone3/clone303.c
...
> +
> +static void run(void)
> +{
> +	pid_t pid;
> +
> +	pid = clone_into_cgroup(fd);
> +
> +	if (!pid) {
> +		TST_CHECKPOINT_WAIT(0);
> +		return;
> +	}
> +
> +	char buf[BUF_LEN];
> +
> +	SAFE_CG_READ(cg_child_test_simple, "cgroup.procs", buf, BUF_LEN);
> +
> +	int x = atoi(buf);
> +
> +	if (x == pid)
x is using only here. Why not just:
	if (atoi(buf) == pid)

> +		tst_res(TPASS, "clone3 case pass!");
> +	else
> +		tst_brk(TFAIL | TTERRNO, "clone3() failed !");
> +
> +	TST_CHECKPOINT_WAKE(0);
> +
> +	SAFE_WAITPID(pid, NULL, 0);
> +
> +}
> +
> +static void setup(void)
> +{
> +	clone3_supported_by_kernel();
> +
> +	cg_child_test_simple = tst_cg_group_mk(tst_cg, "cg_test_simple");
> +
> +	fd = tst_cg_group_unified_dir_fd(cg_child_test_simple);
> +
> +	if (fd < 0)
> +		tst_res(TFAIL | TTERRNO, "get dir fd failed !");
Wouldn't be better to use here
		tst_brk(TBROK | TTERRNO, "get dir fd failed!");

Or even just
		tst_brk(TBROK, "get dir fd failed!");

Because tst_cg_group_unified_dir_fd() does not do any real operation which would
set errno.

I mean does make sense to continue testing if fd is invalid?
> +}

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
