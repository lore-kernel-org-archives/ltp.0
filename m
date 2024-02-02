Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCD7CC48291
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 16:48:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E658C3CD2A5
	for <ltp@archiver.kernel.org>; Fri,  2 Feb 2024 17:48:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D8B23CA601
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 17:48:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5AF6760083A
 for <ltp@lists.linux.it>; Fri,  2 Feb 2024 17:48:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33BDB1F822;
 Fri,  2 Feb 2024 16:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706892491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUnSWj0/yFVXZ5A4mUuDYsJVmpaGYx2oyh5YnnsFR5s=;
 b=nEtwtIZWMA9Aklg2jL6sqQpK+DFEO3Uozg0ZCcGm5+ZG/79k3Dp33pjXfeeXMASoUW7K9K
 XDuLJnL/f0gSpLwSfLH/xPd2J8wUA9PUkoF4La1JBher5Uw75PDcH+lNaorgMU3prsi1Yy
 TbPRl4UhKvbtp8dqskbnjakOcF+WdiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706892491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUnSWj0/yFVXZ5A4mUuDYsJVmpaGYx2oyh5YnnsFR5s=;
 b=5usUkSysX09ABSZq6CPrC92FaY/kdGVbKU7JMMUwofkj9bSI7dlxyanp537MsqDohngZvP
 2eKR6UXl0VLQefDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706892491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUnSWj0/yFVXZ5A4mUuDYsJVmpaGYx2oyh5YnnsFR5s=;
 b=nEtwtIZWMA9Aklg2jL6sqQpK+DFEO3Uozg0ZCcGm5+ZG/79k3Dp33pjXfeeXMASoUW7K9K
 XDuLJnL/f0gSpLwSfLH/xPd2J8wUA9PUkoF4La1JBher5Uw75PDcH+lNaorgMU3prsi1Yy
 TbPRl4UhKvbtp8dqskbnjakOcF+WdiM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706892491;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rUnSWj0/yFVXZ5A4mUuDYsJVmpaGYx2oyh5YnnsFR5s=;
 b=5usUkSysX09ABSZq6CPrC92FaY/kdGVbKU7JMMUwofkj9bSI7dlxyanp537MsqDohngZvP
 2eKR6UXl0VLQefDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20E6513A58;
 Fri,  2 Feb 2024 16:48:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HEtWB8scvWUTRQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 02 Feb 2024 16:48:11 +0000
Date: Fri, 2 Feb 2024 17:48:29 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zb0c3WcA6PLSYCYl@yuki>
References: <20240118151547.12980-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240118151547.12980-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.21 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-1.41)[90.95%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Add stat04 test
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
> +#include "tst_test.h"
> +
> +static void test_stat(void)
> +{
> +	char *symname = "my_symlink0";
> +
> +	TST_EXP_PASS(symlink(tst_get_tmpdir(), symname));

This one leaks memory from the tst_get_tmpdir() call, also I suppose
that the symlink can be created once in the test setup and removed once
in the test cleanup.

> +	struct stat path_stat;
> +	struct stat link_stat;
> +
> +	SAFE_STAT(tst_get_tmpdir(), &path_stat);

Here as well, leak. I suppose that we can instead use "."

> +	SAFE_STAT(symname, &link_stat);
> +
> +	TST_EXP_EQ_LI(path_stat.st_dev, link_stat.st_dev);
> +	TST_EXP_EQ_LI(path_stat.st_mode, link_stat.st_mode);
> +	TST_EXP_EQ_LI(path_stat.st_nlink, link_stat.st_nlink);
> +	TST_EXP_EQ_LI(path_stat.st_uid, link_stat.st_uid);
> +	TST_EXP_EQ_LI(path_stat.st_gid, link_stat.st_gid);
> +	TST_EXP_EQ_LI(path_stat.st_size, link_stat.st_size);
> +	TST_EXP_EQ_LI(path_stat.st_atime, link_stat.st_atime);
> +	TST_EXP_EQ_LI(path_stat.st_mtime, link_stat.st_mtime);
> +	TST_EXP_EQ_LI(path_stat.st_ctime, link_stat.st_ctime);
> +
> +	SAFE_UNLINK(symname);
> +}
> +
> +static void test_stat_no_path(void)
> +{
> +	char *symname = "my_symlink1";
> +	struct stat link_stat;
> +
> +	TST_EXP_PASS(symlink("bc+eFhi!k", symname));
> +	TST_EXP_FAIL(stat(symname, &link_stat), ENOENT);
> +
> +	SAFE_UNLINK(symname);
> +}

This one should rather go into stat03.c

> +static void test_stat_loop(void)
> +{
> +	char *symname = "my_symlink2";
> +	struct stat link_stat;
> +
> +	TST_EXP_PASS(symlink(symname, symname));
> +	TST_EXP_FAIL(stat(symname, &link_stat), ELOOP);
> +
> +	SAFE_UNLINK(symname);
> +}

This one is already tested in stat03.c

> +static void run(void)
> +{
> +	test_stat();
> +	test_stat_no_path();
> +	test_stat_loop();
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.needs_tmpdir = 1,
> +};
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
