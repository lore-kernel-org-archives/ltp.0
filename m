Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9394CCFA1F
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 11:58:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 082D33C4E57
	for <ltp@archiver.kernel.org>; Thu, 26 Sep 2024 13:58:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 857723C29CA
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:58:34 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 113E5200C23
 for <ltp@lists.linux.it>; Thu, 26 Sep 2024 13:58:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B70C1F80A;
 Thu, 26 Sep 2024 11:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727351913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIMvrbEYBu7O2c4d70xllR1Ae0JNLtm2V74RLu26hlo=;
 b=qbSqpNGHwXtTN7pPoXe3Am/Trs2YbKlTYsZuhLZWjOI5hh4jAMpS5xMNworUY2eyUuiRRW
 8OavakNTcbakM90mqykDTf3UG2lGtCWiNVDadyCGn+dabdGQHrHKiD2gOk9CTgemE+6iQB
 9Mi8+4XbDeOvDEuXZfkt3zPwfFzPbPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727351913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIMvrbEYBu7O2c4d70xllR1Ae0JNLtm2V74RLu26hlo=;
 b=T8cE4TQNtX1iBxv9bbdWRFOHBsWQwGJkOtbwV6dF0Dp93S0+n+jU6EbEV0/Lr0282xoRAr
 M1cKJ1Mo9DDYJmBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qbSqpNGH;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T8cE4TQN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1727351913; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIMvrbEYBu7O2c4d70xllR1Ae0JNLtm2V74RLu26hlo=;
 b=qbSqpNGHwXtTN7pPoXe3Am/Trs2YbKlTYsZuhLZWjOI5hh4jAMpS5xMNworUY2eyUuiRRW
 8OavakNTcbakM90mqykDTf3UG2lGtCWiNVDadyCGn+dabdGQHrHKiD2gOk9CTgemE+6iQB
 9Mi8+4XbDeOvDEuXZfkt3zPwfFzPbPM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1727351913;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fIMvrbEYBu7O2c4d70xllR1Ae0JNLtm2V74RLu26hlo=;
 b=T8cE4TQNtX1iBxv9bbdWRFOHBsWQwGJkOtbwV6dF0Dp93S0+n+jU6EbEV0/Lr0282xoRAr
 M1cKJ1Mo9DDYJmBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB5AC13793;
 Thu, 26 Sep 2024 11:58:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NGkfJ2hM9WbMSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 26 Sep 2024 11:58:32 +0000
Date: Thu, 26 Sep 2024 13:57:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZvVMJQhI_4tTFfYB@yuki.lan>
References: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240924-ioctl_ficlone01_fix-v1-1-7741e2e13cc2@suse.com>
X-Rspamd-Queue-Id: 1B70C1F80A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix ioctl_ficlone on XFS without reflink support
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void setup(void)
> +{
> +	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
> +		tst_brk(TCONF, "XFS doesn't support reflink");
> +}
> +
>  static void cleanup(void)
>  {
>  	if (src_fd != -1)
> @@ -106,6 +112,7 @@ static void cleanup(void)
>  
>  static struct tst_test test = {
>  	.test_all = run,
> +	.setup = setup,
>  	.cleanup = cleanup,
>  	.min_kver = "4.5",
>  	.needs_root = 1,
> @@ -115,7 +122,7 @@ static struct tst_test test = {
>  		{.type = "bcachefs"},
>  		{.type = "btrfs"},
>  		{
> -			.type = "xfs",
> +			.type = "xfs >= 5.1.0",
>  			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
>  		},
>  		{}
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> index 3cc386c59..8e32ba039 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> @@ -62,6 +62,9 @@ static void setup(void)
>  	int attr;
>  	struct stat sb;
>  
> +	if (!strcmp(tst_device->fs_type, "xfs") && tst_kvercmp(4, 9, 0) < 0)
> +		tst_brk(TCONF, "XFS doesn't support reflink");
> +
>  	rw_file = SAFE_OPEN("ok_only", O_CREAT | O_RDWR, 0640);
>  	ro_file = SAFE_OPEN("rd_only", O_CREAT | O_RDONLY, 0640);
>  	wo_file = SAFE_OPEN("rw_only", O_CREAT | O_WRONLY, 0640);
> @@ -113,7 +116,7 @@ static struct tst_test test = {
>  		{.type = "bcachefs"},
>  		{.type = "btrfs"},
>  		{
> -			.type = "xfs",
> +			.type = "xfs >= 5.1.0",

Does this even work? I suppose that we do have a minimal version syntax
for commands but not for mkfs.foo. And even for commands the version
parser needs to be implemented for each command separately. We have one
for mkfs.ext4 at the moment.

I suppose that we need to add .mkfs_ver string to the struct tst_fs and
possibly .kernel_ver as well so that we can add both checks to the
structures as:

	{
		.type = "xfs",
		.mkfs_ver = ">= 5.1.0",
		.kernel_ver = ">= 4.9.0",
		...
	}

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
