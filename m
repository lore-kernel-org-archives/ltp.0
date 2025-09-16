Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D99C9CAC599
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 11:03:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF20F3CDAFD
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 13:03:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FA1A3C1AA1
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 13:02:52 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3195F1000641
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 13:02:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B8B522471;
 Tue, 16 Sep 2025 11:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758020570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOqxxgDPzIGni7x1QoOlapTpZyQWa5eVqD04AD39MnU=;
 b=igf/2W0vixlTZ7eRdx7sYjQlpbLMSJy2I9cxFn/2iRZxWeDHVYsmfv7FwMvakiqX8FNWrn
 E9oXzLiGgpqmE1K0YBFk0IDlLqVfTQTgFrU3bK09sukjltj/mFveh2RaxXSeAyGyuaHueV
 +poIOaOcKwl+tpbCZXJCcYiZolLelJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758020570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOqxxgDPzIGni7x1QoOlapTpZyQWa5eVqD04AD39MnU=;
 b=QPd6T8vsPIr70j0P+tIHIV/V8HeI8x1MqjSpSztTwuZlw4hrLeIujyxifM+EmdPtC+SC68
 GGUsZWBCyZOL4eBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1758020570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOqxxgDPzIGni7x1QoOlapTpZyQWa5eVqD04AD39MnU=;
 b=igf/2W0vixlTZ7eRdx7sYjQlpbLMSJy2I9cxFn/2iRZxWeDHVYsmfv7FwMvakiqX8FNWrn
 E9oXzLiGgpqmE1K0YBFk0IDlLqVfTQTgFrU3bK09sukjltj/mFveh2RaxXSeAyGyuaHueV
 +poIOaOcKwl+tpbCZXJCcYiZolLelJs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1758020570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SOqxxgDPzIGni7x1QoOlapTpZyQWa5eVqD04AD39MnU=;
 b=QPd6T8vsPIr70j0P+tIHIV/V8HeI8x1MqjSpSztTwuZlw4hrLeIujyxifM+EmdPtC+SC68
 GGUsZWBCyZOL4eBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 257B3139CB;
 Tue, 16 Sep 2025 11:02:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WXfxBdpDyWjQWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Sep 2025 11:02:50 +0000
Date: Tue, 16 Sep 2025 13:02:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250916110248.GB251329@pevik>
References: <20250529105156.2564268-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250529105156.2564268-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_filesystems01.c: Add test for .filesystems
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

Hi Wei, Cyril,

Cyril, single note below can wait after the release.
Also, please have look if this fulfils your idea about testing the feature.

> Fixes: https://github.com/linux-test-project/ltp/issues/1243
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/newlib_tests/tst_filesystems01.c | 118 +++++++++++++++++++++++++++
>  1 file changed, 118 insertions(+)
>  create mode 100644 lib/newlib_tests/tst_filesystems01.c

The test is running fine on github, please add it to
lib/newlib_tests/runtest.sh.

+++ lib/newlib_tests/runtest.sh
@@ -24,6 +24,7 @@ tst_checkpoint_wait_timeout
 tst_checkpoint_wake_timeout
 tst_device
 tst_expiration_timer
+tst_filesystems01
 tst_fuzzy_sync0[1-3]
 tst_needs_cmds0[1-36-8]
 tst_res_hexd

...
> +	snprintf(str_size, sizeof(str_size), "%u", size);
> +	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", tst_device->dev);
> +	tune2fs = SAFE_POPEN(path, "r");
> +	if (tune2fs == NULL)
> +		tst_brk(TBROK, "Can not popen %s", path);
The point of SAFE_* functions/macros is to avoid having to check in the tests :).
Please remove these 2 lines.

> +	while (fgets(line, PATH_MAX, tune2fs)) {
> +		if (*line && strstr(line, "Inode size:") && strstr(line, str_size)) {
Common patter for fgets() is to check for != NULL, then you don't need "*line &&":
	while (fgets(line, PATH_MAX, tune2fs) != NULL) {
		if (strstr(line, "Inode size:") && strstr(line, str_size)) {

> +			tst_res(TPASS, "check inode size pass");
> +			return 0;
> +		}
> +	}
> +
> +	pclose(tune2fs);
> +	tst_res(TFAIL, "check inode size failed");
> +	return -1;
> +}
> +
> +static int check_mnt_data(char *opt)
> +{
> +	FILE *fp;
> +	char line[PATH_MAX];
> +
> +	fp = SAFE_FOPEN("/proc/mounts", "r");
> +	if (fp == NULL)
> +		tst_brk(TBROK, "Can not open /proc/mounts");
Also here.

> +	while (fgets(line, PATH_MAX, fp)) {
> +		if (*line && strstr(line, tst_device->dev) && strstr(line, opt)) {
Also here.
> +			tst_res(TPASS, "check mnt data pass");
> +			return 0;
> +		}
> +	}
> +	SAFE_FCLOSE(fp);
> +	tst_res(TFAIL, "check mnt data failed");
> +	return -1;
> +}
> +
> +static int check_mkfs_size_opt(unsigned int size)
> +{
> +	char path[PATH_MAX];
> +	char line[PATH_MAX];
> +	FILE *dumpe2fs;
> +	char str_size[NAME_MAX];
> +
> +	snprintf(str_size, sizeof(str_size), "%u", size);
> +	snprintf(path, sizeof(path), "dumpe2fs -h %s 2>&1", tst_device->dev);
> +	dumpe2fs = SAFE_POPEN(path, "r");
> +	if (dumpe2fs == NULL)
> +		tst_brk(TBROK, "Can not popen %s", path);
And here.

> +
> +	while (fgets(line, PATH_MAX, dumpe2fs)) {
> +		if (*line && strstr(line, "Block count:") && strstr(line, str_size)) {
And here.

> +			tst_res(TPASS, "check mkfs size opt pass");
> +			return 0;
> +		}
> +	}
> +
> +	pclose(dumpe2fs);
> +	tst_res(TFAIL, "check mkfs size opt failed");
> +	return -1;
> +}
> +
> +static void do_test(void)
> +{
> +	long fs_type;
> +
> +	fs_type = tst_fs_type(MOUNT_POINT);
> +
> +	if (fs_type == TST_EXT234_MAGIC) {
> +		check_inode_size(128);
check_inode_size() and the other 2 test functions return int but you don't use
the return value. Either use it or change return type to void.

> +		check_mkfs_size_opt(10240);
> +	}
> +
> +	if (fs_type == TST_XFS_MAGIC)
> +		check_mnt_data("usrquota");
While this works, it expect that nobody changes .filesystems below.

@Cyril: wouldn't be useful if the test itself had it's struct tst_fs member
from filesystems[i] available? Static variable, either pointer to the member or
instance of i from run_tcases_per_fs()?

Because we always expect filesystems (.type) is unique in .filesystems. But in
the future we might have test which uses several items in .filesystems with a
different data but an unique filesystem (not needed so far).

Kind regards,
Petr

> +}
> +
> +static struct tst_test test = {
> +	.test_all = do_test,
> +	.needs_root = 1,
> +	.mntpoint = MOUNT_POINT,
> +	.mount_device = 1,
> +	.needs_cmds = (const char *[]) {
> +		"tune2fs",
> +		"dumpe2fs",
> +		NULL
> +	},
> +	.filesystems = (struct tst_fs []) {
> +		{
> +			.type = "ext3",
> +			.mkfs_opts = (const char *const []){"-I", "128", NULL},
> +			.mkfs_size_opt = "10240",
> +		},
> +		{
> +			.type = "xfs",
> +			.mnt_data = "usrquota",
> +		},
> +		{}
> +	},
> +
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
