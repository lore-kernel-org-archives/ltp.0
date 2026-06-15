Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F365CD98C7
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 11:49:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4CE53E5C28
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:49:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BAC13C72DC
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:49:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AB7571000343
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 13:49:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB7616AD2A;
 Mon, 15 Jun 2026 11:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781524168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c249DwJo8dV4464gFO49Y/CjjjY+sLAllWunIHkK5BM=;
 b=ZdPsQQf4FawjPSzPxotFaYRkuOCNnqjvGk9ZWi3Fr8jFzD6ga+JEAi83fw8Dinridn/Jyo
 6aimmkF+Z/evs60wwrqPIa0tEl7+LV7qaxiZtBXbLPV5ZjjtIZbKcqwtEG8uWW4BaeSvMX
 wF5Z5ZmIU3cCcZ99AiZWNsU8dhck5xQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781524168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c249DwJo8dV4464gFO49Y/CjjjY+sLAllWunIHkK5BM=;
 b=jXBqM6+hYZRIA/bvx9Zue0wM7ee//cgkgFLh330DgwVrfEZOD74xSlEyrzFo/6FSh0bJqv
 zjqLq/X7T6+7+5DA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1HIhgCVh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4QZ7r8aC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781524166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c249DwJo8dV4464gFO49Y/CjjjY+sLAllWunIHkK5BM=;
 b=1HIhgCVhTSBqvTli9BWthTWjtaDA6+nv84zJpH1Dg4G5UVHvDDJ7gH1fq5RszihchDRSYJ
 xZpIVQGJtlboqoITRNbBZ5QAoAs1dmlxPQbiXxASAF7UHcgQSk1WpMORgC8mTSpqcOtDdZ
 rttf/FwcBMWFjVTjkTU7HjVotqxDjmE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781524166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c249DwJo8dV4464gFO49Y/CjjjY+sLAllWunIHkK5BM=;
 b=4QZ7r8aC6NvZlLkUfMHIo2Kc38besxlQLEAzSCh64/XggMDJnQYJ7+Hw6V3MLip7vFlKd+
 pPK1UxH8rQmAdDDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C867D779A7;
 Mon, 15 Jun 2026 11:49:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CmnYL8bmL2qvTAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 15 Jun 2026 11:49:26 +0000
Date: Mon, 15 Jun 2026 13:49:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ai_mxxup2GUblbHn@yuki.lan>
References: <20260611-fw_load-v6-0-c2aec79a7ed7@suse.com>
 <20260611-fw_load-v6-4-c2aec79a7ed7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fw_load-v6-4-c2aec79a7ed7@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: DB7616AD2A
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, linux.it:url, yuki.lan:mid, suse.cz:email,
 suse.cz:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 4/4] fw_load: add fw_load02 for custom firmware
 path
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
> +static struct fw_data {
> +	char file[PATH_MAX];
> +	char name[MAX_NAME];
> +	int fake;
> +} firmware[FW_NUM];
> +
> +static void create_firmware(const char *dir)
> +{
> +	struct fw_data *fw = &firmware[fw_count];
> +	char buf[FW_SIZE];
> +	int fd;
> +
> +	snprintf(fw->name, sizeof(fw->name), "n%d_%s", fw_count, FW_NAME);
> +	snprintf(fw->file, sizeof(fw->file), "%s/n%d_%s", dir, fw_count, FW_NAME);
> +	memset(buf, fw_count, FW_SIZE);
> +
> +	fd = SAFE_OPEN(fw->file, O_WRONLY | O_CREAT | O_TRUNC, 0644);
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, buf, FW_SIZE);
> +	SAFE_CLOSE(fd);
> +
> +	fw_count++;
> +}
> +
> +static void run(void)
> +{
> +	struct fw_data *fw;
> +	int result = 0;
> +	int fail;
> +
> +	SAFE_FILE_PRINTF(DEV_FWNUM, "%d", fw_count);
> +	SAFE_FILE_SCANF(DEV_RESULT, "%d", &result);
> +
> +	for (int i = 0; i < fw_count; i++) {
> +		fw = &firmware[i];
> +
> +		if (fw->fake) {
> +			tst_res(result & (1 << i) ? TFAIL : TPASS,
> +				"Firmware '%s' correctly not loaded", fw->name);
> +		} else {
> +			fail = (result & (1 << i)) == 0;
> +			tst_res(fail ? TFAIL : TPASS,
> +				"Firmware '%s' loaded", fw->name);
> +		}
> +	}
> +}

These functions are nearly identical to the fw_load01.c maybe we should
put them into a header and include it into both tests instead?

I guess that we can have a static inline function do_test() that would
take the fw_data and fw_count as an argument and call it from run(). The
same for create_firmare(). We can pas sthe fw_data pointer that would be
initialized instead of acting on globals and put it into the shared
header.

> +static void setup(void)
> +{
> +	char fw_size_param[32];
> +	char *tmpdir = tst_tmpdir_path();
> +
> +	tst_requires_module_signature_disabled();
> +
> +	SAFE_FILE_PRINTF(FW_PATH, "%s", tmpdir);
> +
> +	snprintf(fw_size_param, sizeof(fw_size_param), "fw_size=%d", FW_SIZE);
> +	char *const mod_params[] = {fw_size_param, NULL};
> +
> +	tst_module_load(MNAME_KO, mod_params);
> +	module_loaded = 1;
> +
> +	for (int i = 0; i < FW_NUM - 1; i++)
> +		create_firmware(tmpdir);
> +
> +	/* add a fake file that is never created on disk */
> +	snprintf(firmware[fw_count].name, sizeof(firmware[fw_count].name),
> +		 "n%d_%s", fw_count, FW_NAME);
> +	firmware[fw_count].fake = 1;
> +	fw_count++;

And most of the setup code can be shared as well.

> +}
> +
> +static void cleanup(void)
> +{
> +	if (module_loaded)
> +		tst_module_unload(MNAME_KO);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
> +	.needs_kconfigs = (const char *[]) {
> +		"CONFIG_FW_LOADER=y|CONFIG_FW_LOADER=m",
> +		NULL,
> +	},
> +	.save_restore = (const struct tst_path_val[]) {
> +		{FW_PATH, NULL, TST_SR_TCONF},
> +		{},
> +	},
> +};
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
