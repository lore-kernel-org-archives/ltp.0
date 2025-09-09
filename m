Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C2DBCAC583
	for <ltp@archiver.kernel.org>; Tue,  9 Sep 2025 11:50:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8EE3CD2BE
	for <ltp@archiver.kernel.org>; Tue,  9 Sep 2025 13:50:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A2053CD1C1
 for <ltp@lists.linux.it>; Tue,  9 Sep 2025 13:49:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D781E10005F7
 for <ltp@lists.linux.it>; Tue,  9 Sep 2025 13:49:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 836705D34A;
 Tue,  9 Sep 2025 11:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757418591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmPXLMkOAmuu0Zj7rfbNwuixueotmc59c9ABAj2IW/M=;
 b=rcKBA0kR/IXtrYV8Q1O8DUlDUXqbEBFhTEVuo5XrVIBK6FWB52tCsy4A7TKS1grOIS/70d
 4VrHVMLLYQgysIGiBXcw7iWg+LyVaBIGFswbTIcynJeOIZb2vQl44TPe14JLJca1UqZDGb
 mFdSEiWDOH+VfbJIu2TbGfB2Wp/EUyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757418591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmPXLMkOAmuu0Zj7rfbNwuixueotmc59c9ABAj2IW/M=;
 b=WIIvpSiHsUFnFgERcB2cKSyPncfYE+LYeSntzvsv8nfq3nELxY3F6l/pntS9kPioQfiMaj
 CkjtezlIlSl1wpAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rcKBA0kR;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WIIvpSiH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1757418591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmPXLMkOAmuu0Zj7rfbNwuixueotmc59c9ABAj2IW/M=;
 b=rcKBA0kR/IXtrYV8Q1O8DUlDUXqbEBFhTEVuo5XrVIBK6FWB52tCsy4A7TKS1grOIS/70d
 4VrHVMLLYQgysIGiBXcw7iWg+LyVaBIGFswbTIcynJeOIZb2vQl44TPe14JLJca1UqZDGb
 mFdSEiWDOH+VfbJIu2TbGfB2Wp/EUyQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1757418591;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vmPXLMkOAmuu0Zj7rfbNwuixueotmc59c9ABAj2IW/M=;
 b=WIIvpSiHsUFnFgERcB2cKSyPncfYE+LYeSntzvsv8nfq3nELxY3F6l/pntS9kPioQfiMaj
 CkjtezlIlSl1wpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F24B1365E;
 Tue,  9 Sep 2025 11:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uMrUGl8UwGiPPAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 09 Sep 2025 11:49:51 +0000
Date: Tue, 9 Sep 2025 13:50:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aMAUhpxi1GaDBfGF@yuki.lan>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250902111809.6071-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com,suse.cz,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; TAGGED_RCPT(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim]
X-Rspamd-Queue-Id: 836705D34A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
 partitioning
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
>  .../kernel/syscalls/ioctl/ioctl_loop01.c      | 34 ++++++++-----------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> index c9137bf1e..b70e9fc22 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -78,7 +78,21 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
>  
>  static void verify_ioctl_loop(void)
>  {
> +	int ret;
> +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> +					"primary", "ext4", "1M", "10M", NULL};
> +
> +	tst_fill_file("test.img", 0, 1024 * 1024, 10);
>  	tst_attach_device(dev_path, "test.img");
> +
> +	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
> +	if (!ret)
> +		parted_sup = 1;
> +	else if (ret == 255)
> +		tst_res(TCONF, "parted binary not installed or failed");
> +	else
> +		tst_res(TCONF, "parted exited with %i", ret);

The test should have needs_cmds set to parted (we do that properly in
ioctl09.c) then we do not have to handle the 255 exit code here since
the test would be skipped if it's missing.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
