Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9DB0C982FA
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 11:10:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D856E3E6CD6
	for <ltp@archiver.kernel.org>; Tue, 22 Sep 2026 13:10:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 867613E6C87
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 13:09:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1001D60066E
 for <ltp@lists.linux.it>; Tue, 22 Sep 2026 13:09:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 96FFA1FA79;
 Tue, 22 Sep 2026 11:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790075393; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksYjVWXI1ZWRk+xWSDfP2k5QZyucq4EzA6g5GV3o8Po=;
 b=abJ3WCAwrml6NebFv1MHgMxdklYobeGLpfFoM96BLy7Lk+O1ZWDE13D8+k6Rz9rnVWfyQC
 ASn6Lx3QHG91kQ9uSoIPq48jL5rwism4t7iDD/6X28UgSOPgYMjZ1ie1hc+YlUiQ3KK+XP
 PvzMeBs58pR52I+0hmHcwgKhJs+TZK0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790075393;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksYjVWXI1ZWRk+xWSDfP2k5QZyucq4EzA6g5GV3o8Po=;
 b=W3DEGnms4O+HGToj+0OlA8nH1C6P+IScWwIvM59McAX9DME4O/TfXWY6ks7eU6CaHaEgrx
 cJlSkTz2TzcFU9Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790075389; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksYjVWXI1ZWRk+xWSDfP2k5QZyucq4EzA6g5GV3o8Po=;
 b=Nr6VyThJdvldV/JtGgr1x2gFuOrICExldRl00oWqV8OYyhDDQLuBhDkvl0FxESCIToBwtY
 01WSBDOfw/j6rCMemX7XMfwMM8zK7QCNfbXumA6eWCXwSnSNgl3qEG9X+Lnuad1mvRk20o
 kW0//gfSzyZ1VknXHi2peHBpu2D+1uY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790075389;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ksYjVWXI1ZWRk+xWSDfP2k5QZyucq4EzA6g5GV3o8Po=;
 b=FFcN8laAXhp9DlyCMRNKFs9bAMAiI+3lVTWvf/DBYLIzPlaUVl7GIWjNyAQGISw8n6/rcp
 PC7jeUv4LeDRogDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68A8513A01;
 Tue, 22 Sep 2026 11:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sydtE/1hsmpEWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 22 Sep 2026 11:09:49 +0000
Date: Tue, 22 Sep 2026 13:09:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <arJiBgKNC80acBfY@yuki.lan>
References: <20260922105840.2193537-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260922105840.2193537-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] keyctl30: Check module is presented before
 loading
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
> This fixes test on the system without module:
> 
>     modprobe: FATAL: Module pkcs8_key_parser not found in directory /usr/lib/modules/6.12.0-160100.5-azure
>     tst_cmd.c:112: TBROK: 'modprobe' exited with a non-zero code 1 at tst_cmd.c:112
> 
> With the fix it TCONF as expected:
> 
>     tst_module.c:72: TCONF: Failed to find module 'pkcs8_key_parser'
> 
> Fixes: 1bb448ed9e ("keyctl30: Test KEYCTL_PKEY_QUERY on private key")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> FYI Cyril suggested to add into struct config_module_map:
> 
>  	{"CONFIG_NET_SCH_INGRESS", "sch_ingress"},
>  	{"CONFIG_NET_CLS_MATCHALL", "cls_matchall"},
>  	{"CONFIG_NET_ACT_PEDIT", "act_pedit"},
> +	{"CONFIG_PKCS8_PRIVATE_KEY_PARSER", "pcks8_key_parser"},

I think that this is still cleaner, this way we skip the test even
before we start running it. Maybe we should attempt to auto-generate the
table for all CONFIG_* variables used in LTP.

Also keyctl23.c and keyctl29.c have tst_modprobe("x509_key_parser",
NULL); So we need fix/mappping for x509_key_parser too.

> Although it does not harm this is IMHO just wrong function being used.

That depends, if we decide to have the checks in the tst_kconfig.c then
tst_modprobe() is the only function that should be used.

Also looiks like the primary user of the tst_module_load() are tests
that build modules in LTP tree, where it does make sense, since these
may fail to build and be missing and there are no CONFIG_ variables for
these. The rest of the tests seems to be using tst_modprobe().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
