Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9D06C3DA45
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 12:16:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45ECC3D3835
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 14:16:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 136F23D2BB5
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 14:15:52 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 674FE600C86
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 14:15:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E52381F82B;
 Wed, 10 Jul 2024 12:15:50 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D456C137D2;
 Wed, 10 Jul 2024 12:15:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cwnjMnZ7jmadDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 12:15:50 +0000
Date: Wed, 10 Jul 2024 14:15:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zo57ckoV1LQwjVch@yuki>
References: <20240710-stat04-v3-0-c68a2324ad94@suse.com>
 <20240710-stat04-v3-1-c68a2324ad94@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240710-stat04-v3-1-c68a2324ad94@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: E52381F82B
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] Add stat04 test
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
> +static char symb_path[PATH_MAX];
> +static char file_path[PATH_MAX];
> +static struct stat *file_stat;
> +static struct stat *symb_stat;
> +static char *tmpdir;
> +
> +static void run(void)
> +{
> +	SAFE_STAT(file_path, file_stat);
> +	SAFE_STAT(symb_path, symb_stat);
> +
> +	TST_EXP_EQ_LI(file_stat->st_dev, symb_stat->st_dev);
> +	TST_EXP_EQ_LI(file_stat->st_mode, symb_stat->st_mode);
> +	TST_EXP_EQ_LI(file_stat->st_nlink, symb_stat->st_nlink);
> +	TST_EXP_EQ_LI(file_stat->st_uid, symb_stat->st_uid);
> +	TST_EXP_EQ_LI(file_stat->st_gid, symb_stat->st_gid);
> +	TST_EXP_EQ_LI(file_stat->st_size, symb_stat->st_size);
> +	TST_EXP_EQ_LI(file_stat->st_atime, symb_stat->st_atime);
> +	TST_EXP_EQ_LI(file_stat->st_mtime, symb_stat->st_mtime);
> +	TST_EXP_EQ_LI(file_stat->st_ctime, symb_stat->st_ctime);
> +}
> +
> +static void setup(void)
> +{
> +	char opt_bsize[32];
> +	const char *const fs_opts[] = {opt_bsize, NULL};
> +	struct stat sb;
> +	int pagesize;
> +	int fd;
> +
> +	tmpdir = tst_get_tmpdir();
> +
> +	if (strlen(tmpdir) >= (PATH_MAX - strlen(FILENAME))) {
> +		tst_brk(TCONF, "Temporary folder name is too long. "
> +			"Can't create file");
> +	}
> +
> +	if (strlen(tmpdir) >= (PATH_MAX - strlen(SYMBNAME))) {
> +		tst_brk(TCONF, "Temporary folder name is too long. "
> +			"Can't create symbolic link");
> +	}

Uff, this is so 1990. Can we please use asprintf() instead?


Other than that this looks good to me:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
