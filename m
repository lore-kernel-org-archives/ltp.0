Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA3C48285
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 10:27:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D6EA3CE0B3
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 11:27:57 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AD1E53CE0C9
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:54 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D696600087
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 11:25:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AFB42203D;
 Wed, 31 Jan 2024 10:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706696753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=on0pb4iWxOAwf5OBBWe4Ph64A0ilYHc9SuDyDvJpNkg=;
 b=iwcZ9JVecmuBPc8S2rrcVLXF+Hck4HQsFqIKzW4x0oBHLEO3g3rl5Zn2ZhuImzz8zTCq2P
 lXR+1VWBFR5j+tAhRPpSJyvyP3NVHsN/zR9PDBEFKXnX6nBPMcwQ0gLr/dyky9RKOIcqmo
 H9g6Y6oJKy7nRwFsRKbZenWGfquqdKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706696753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=on0pb4iWxOAwf5OBBWe4Ph64A0ilYHc9SuDyDvJpNkg=;
 b=2yoiR4HBE3JqnYv4gjrPNnQOTE7ZdzpT1eKMlhD2dPAOSGukks6PCwQrn5Y3wqWSUK9Nox
 VpVrGzl0PIXbPcCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706696753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=on0pb4iWxOAwf5OBBWe4Ph64A0ilYHc9SuDyDvJpNkg=;
 b=iwcZ9JVecmuBPc8S2rrcVLXF+Hck4HQsFqIKzW4x0oBHLEO3g3rl5Zn2ZhuImzz8zTCq2P
 lXR+1VWBFR5j+tAhRPpSJyvyP3NVHsN/zR9PDBEFKXnX6nBPMcwQ0gLr/dyky9RKOIcqmo
 H9g6Y6oJKy7nRwFsRKbZenWGfquqdKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706696753;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=on0pb4iWxOAwf5OBBWe4Ph64A0ilYHc9SuDyDvJpNkg=;
 b=2yoiR4HBE3JqnYv4gjrPNnQOTE7ZdzpT1eKMlhD2dPAOSGukks6PCwQrn5Y3wqWSUK9Nox
 VpVrGzl0PIXbPcCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 02C88139D9;
 Wed, 31 Jan 2024 10:25:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Bm5YOTAgumXmMwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 10:25:52 +0000
Date: Wed, 31 Jan 2024 11:25:51 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240131102551.GC890138@pevik>
References: <20240131100018.15767-1-andrea.cervesato@suse.de>
 <20240131100018.15767-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240131100018.15767-3-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Increase default appends operations in
 dio_append
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

Hi Andrea,

> From: Andrea Cervesato <andrea.cervesato@suse.com>

> This test is currently ending quite fast on regular systems, so we
> increase the number of operations in order to have bigger chances to
> find bugs.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  testcases/kernel/io/ltp-aiodio/dio_append.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/io/ltp-aiodio/dio_append.c b/testcases/kernel/io/ltp-aiodio/dio_append.c
> index 057ae73d9..0ecb76e2f 100644
> --- a/testcases/kernel/io/ltp-aiodio/dio_append.c
> +++ b/testcases/kernel/io/ltp-aiodio/dio_append.c
> @@ -33,7 +33,7 @@ static void setup(void)
>  {
>  	numchildren = 16;
>  	writesize = 64 * 1024;
> -	appends = 1000;
> +	appends = 10000;

>  	if (tst_parse_int(str_numchildren, &numchildren, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid number of children '%s'", str_numchildren);
> @@ -44,6 +44,9 @@ static void setup(void)
>  	if (tst_parse_int(str_appends, &appends, 1, INT_MAX))
>  		tst_brk(TBROK, "Invalid number of appends '%s'", str_appends);

> +	if (!tst_fs_has_free(".", appends, writesize))
> +		tst_brk(TCONF, "Not enough space to run the test");

I'm ok to keep this in single commit with increasing the number of operations,
but it should have been at least mentioned in the commit message.

And, if I understand correctly, this was meant by Cyril in v1
https://lore.kernel.org/ltp/ZbjpATp6cK9AkvBm@yuki/

Kind regards,
Petr

> +
>  	run_child = SAFE_MMAP(NULL, sizeof(int), PROT_READ | PROT_WRITE, MAP_SHARED | MAP_ANONYMOUS, -1, 0);
>  }

> @@ -97,7 +100,7 @@ static struct tst_test test = {
>  	.options = (struct tst_option[]) {
>  		{"n:", &str_numchildren, "Number of processes (default 16)"},
>  		{"w:", &str_writesize, "Write size for each append (default 64K)"},
> -		{"c:", &str_appends, "Number of appends (default 1000)"},
> +		{"c:", &str_appends, "Number of appends (default 10000)"},
>  		{}
>  	},
>  	.skip_filesystems = (const char *[]) {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
