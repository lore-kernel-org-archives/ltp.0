Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C522C44515
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 11:02:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 369073E226C
	for <ltp@archiver.kernel.org>; Mon, 20 Jul 2026 13:02:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCF0B3C241C
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 13:02:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4CA221000668
 for <ltp@lists.linux.it>; Mon, 20 Jul 2026 13:02:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73D793DF9;
 Mon, 20 Jul 2026 11:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784545355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3VUw5zsd4w9un2+VprwdMdk3FdRK+Ik+b1t3ALdoU4=;
 b=qXgPuAJkaxMC70HHfgfxJgBP25fyVDQXyVKGvARzbSlxA/Ge4f+3v0d4t10qdu0gHSJauz
 CclaeAA8ATBzjpXI39ORZoER256DZfj2VSiDeFVrokr15qsAB9qbAo+xSYoB26djKAc8SA
 9Nkkr9cuy+vtN0M+aOArfMOtlbPsEUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784545355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3VUw5zsd4w9un2+VprwdMdk3FdRK+Ik+b1t3ALdoU4=;
 b=P0kzsPFdRaCtHJyzJEa7IZ5LOPF+RFqCieYT3MdJCX7kmxtykdXT9BG/7Db+HOcekuDAyN
 tUykBT03x5RBsaBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1784545355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3VUw5zsd4w9un2+VprwdMdk3FdRK+Ik+b1t3ALdoU4=;
 b=qXgPuAJkaxMC70HHfgfxJgBP25fyVDQXyVKGvARzbSlxA/Ge4f+3v0d4t10qdu0gHSJauz
 CclaeAA8ATBzjpXI39ORZoER256DZfj2VSiDeFVrokr15qsAB9qbAo+xSYoB26djKAc8SA
 9Nkkr9cuy+vtN0M+aOArfMOtlbPsEUA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1784545355;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3VUw5zsd4w9un2+VprwdMdk3FdRK+Ik+b1t3ALdoU4=;
 b=P0kzsPFdRaCtHJyzJEa7IZ5LOPF+RFqCieYT3MdJCX7kmxtykdXT9BG/7Db+HOcekuDAyN
 tUykBT03x5RBsaBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F6A2779AB;
 Mon, 20 Jul 2026 11:02:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EjWBFksAXmqqAQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 20 Jul 2026 11:02:35 +0000
Date: Mon, 20 Jul 2026 13:02:32 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <al4ASHAmTGEYfIVD@yuki.lan>
References: <20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260717-fix_cve-2026-46331_enoent-v1-1-85425e81ff7a@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2026-46331: fix intermittent ENOENT failure
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  #include <sys/sendfile.h>
> +#include <sys/prctl.h>
> +#include <pwd.h>
>  #include <linux/rtnetlink.h>
>  
>  #include "tst_test.h"
> @@ -128,7 +130,31 @@ static int acc_fd = -1;
>  static void setup(void)
>  {
>  	struct sockaddr_in addr;
> -	int i;
> +	struct passwd *pw;
> +	static const char *const mods[] = {
> +		"sch_ingress", "cls_matchall", "act_pedit"
> +	};
> +	static const char *cmd[] = {"modprobe", NULL, NULL};
> +	unsigned int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(mods); i++) {
> +		cmd[1] = mods[i];
> +
> +		if (tst_cmd(cmd, NULL, "/dev/null", TST_CMD_PASS_RETVAL))
> +			tst_brk(TCONF, "kernel module %s is not available", mods[i]);
> +	}

We do have tst_module_load().

> +	/* Drop privileges so the reproducer runs as an unprivileged user */
> +	pw = SAFE_GETPWNAM("nobody");
> +	SAFE_SETGID(pw->pw_gid);
> +	SAFE_SETUID(pw->pw_uid);
> +
> +	/*
> +	 * setuid() clears the dumpable flag, which makes /proc/self/*
> +	 * owned by root and prevents tst_setup_netns() from writing the
> +	 * uid/gid maps. Restore it so the user namespace can be set up.
> +	 */
> +	SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
>  
>  	tst_setup_netns();
>  	NETDEV_SET_STATE("lo", 1);
> @@ -253,7 +279,12 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> +	.needs_root = 1,
>  	.needs_tmpdir = 1,
> +	.needs_cmds = (struct tst_cmd[]) {
> +		{.cmd = "modprobe"},
> +		{}
> +	},
>  	.needs_kconfigs = (const char *[]) {
>  		"CONFIG_USER_NS=y",
>  		"CONFIG_NET_NS=y",

The check for the module existence should be done by adding:

	"CONFIG_NET_SCH_INGRESS",
	"CONFIG_NET_CLS_MATCHALL",
	"CONFIG_NET_ACT_PEDIT",

to the needs_kconfigs.

And then adding module mappings to tst_kconfig.c

	diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
index 44eacc7c2..277ac6068 100644
--- a/lib/tst_kconfig.c
+++ b/lib/tst_kconfig.c
@@ -162,6 +162,9 @@ static struct config_module_map {
        {"CONFIG_CAN_RAW", "can-raw"},
        {"CONFIG_CAN_BCM", "can-bcm"},
        {"CONFIG_IP_SCTP", "sctp"},
+       {"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
+       {"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
+       {"CONFIG_NET_ACT_PEDIT", "act_pedit"},
        {}
 };


With that the checks will be done in the test library even before the
test is started.

We may also add a flag to tst_test structure to load the modules mapped
to the config variables, something as .kconfig_load.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
