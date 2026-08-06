Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B758C56208
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 11:30:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3FEA93E2D1F
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 13:30:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 20B983C73AF
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 13:30:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB28E200750
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 13:30:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFD723E06;
 Thu,  6 Aug 2026 11:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786015827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4Fi5HFUS+2KRC1o4NCJFGArtayDI652/96YeiWR0Mo=;
 b=Klh4E2UYsVNR63kSL0TSwtDbQcpeDlEAcCA8RI5HAkkDzkCLJdGUjhLTe+5GDYCOv9V8sP
 KpGgCCQUrtDRJ4/+t5Sr/4ct/rms1aXxmQeBnltB7wLlbAhyzk7tYh6Af1ovIg6qp6F+ZR
 15Fu1+0nDh9B2xAlev9/DdVtdbOuTNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786015827;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4Fi5HFUS+2KRC1o4NCJFGArtayDI652/96YeiWR0Mo=;
 b=4tk5diPfR5dpEykendqnmGHyM6ejjX+9TS8aqWwdfoWkR9nMAiQj/WNpGgBTIXtIBrVBNO
 FiPwVc+Df8CW0xAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786015822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4Fi5HFUS+2KRC1o4NCJFGArtayDI652/96YeiWR0Mo=;
 b=grwAh3w74Tu2f62N70p83rMKY6J8YfDFpEq33nJlthxgnACfJzHrr0yqGGI/48H6BtutbT
 lezQlmKgwtYOJb/EsxN7+n0BPr1fpNnom0bDb04RUEc74CqPsJcPkONEpnbUsZkio3KLFe
 yu0uRY9b66rbxgGwiFL8UlpCtum7g+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786015822;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w4Fi5HFUS+2KRC1o4NCJFGArtayDI652/96YeiWR0Mo=;
 b=cC/Ko32D884ZnhSXeuEIAtqoawf5GUP+fiQvv/tJSAQmHLPfpLrNll7cEju1ljiL1xZyPT
 gJMncPhwuSFzaiBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A3112779B6;
 Thu,  6 Aug 2026 11:30:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id basZJU5wdGphJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 06 Aug 2026 11:30:22 +0000
Date: Thu, 6 Aug 2026 13:30:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260806113013.GA850008@pevik>
References: <20260803021230.14530-1-wegao@suse.com>
 <20260804010439.15195-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804010439.15195-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12] fsconfig04: Check FSCONFIG_SET_PATH
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

> The fsconfig01.c does not test if FSCONFIG_SET_PATH has any effect;
> most of the calls there just set a dummy "sync" parameter. This test
> case aims to verify if the FSCONFIG_SET_PATH operation can be used
> to dynamically change the external journal device of an ext3 or ext4
> filesystem.

LGTM, thanks!
Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +	char loop_name[NAME_MAX];
> +	char path[PATH_MAX + 32];
> +	char device_str[NAME_MAX];
> +	unsigned int major, minor, device_num;
> +	unsigned int found = 0;
very nit: I'd use bool for found (but of course it can stay as int).

> +
> +	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
> +
> +	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
> +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> +	device_num = (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12);
> +	snprintf(device_str, sizeof(device_str), "0x%04x", device_num);
> +
> +	char line[PATH_MAX];
> +	FILE *tune2fs;
> +
> +	snprintf(path, sizeof(path), "tune2fs -l %s 2>&1", dev0);
> +	tune2fs = SAFE_POPEN(path, "r");
> +
> +	while (fgets(line, PATH_MAX, tune2fs)) {
> +		if (*line && strstr(line, "Journal device:") && strstr(line, device_str)) {
> +			found = 1;
> +			break;
> +		}
> +	}
> +
> +	if (found == 1)
> +		tst_res(TPASS, "Device found in journal");
> +	else
> +		tst_res(TFAIL, "Device not found in journal");
> +
> +	pclose(tune2fs);
> +	SAFE_CLOSE(fd);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
.needs_tmpdir is probably useless (run: 'cd doc/ && make clean && make' to see
the errors) => I can delete it before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
