Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5C1BCD98D2
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:26:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 49B583CB67D
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 11:26:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 49C033CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:26:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A81E10009E7
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 11:26:36 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F026C75D6C;
 Thu, 11 Jun 2026 09:26:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC676779A7;
 Thu, 11 Jun 2026 09:26:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cgEHNEt/KmrOIgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 11 Jun 2026 09:26:35 +0000
Date: Thu, 11 Jun 2026 11:26:34 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aip_SuymPZMvUAvo@yuki.lan>
References: <20260611-fw_load-v5-0-7e21d40ae54a@suse.com>
 <20260611-fw_load-v5-2-7e21d40ae54a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260611-fw_load-v5-2-7e21d40ae54a@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: F026C75D6C
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 2/2] firmware/fw_load: add fw_load02 for custom
 firmware path
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
> +static void setup(void)
> +{
> +	char fw_size_param[32];
> +	char *tmpdir = tst_tmpdir_path();
> +	struct tst_path_val fw_path = {
> +		.path = FW_PATH,
> +		.val = tmpdir,
> +		.flags = TST_SR_TCONF,
> +	};
> +
> +	tst_requires_module_signature_disabled();
> +
> +	/*
> +	 * Point the kernel firmware loader at our writable tmpdir so the
> +	 * test does not depend on a writable /lib/firmware. The previous
> +	 * value is restored automatically during cleanup.
> +	 */
> +	tst_sys_conf_save(&fw_path);

I would say that it's cleaner to add the save_restore to the tst_test
structure without the tmpdir value and use
SAFE_FILE_PRINTF(FW_PATH, "%s", tmpdir) in the test setup. Since if the
test crashes the test library will still restore the FW_PATH

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
