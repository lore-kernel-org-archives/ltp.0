Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4863C5CFDB
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 11:05:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DABBD3E6C98
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 13:05:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E7F13DC3E9
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:05:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BE2BD1000741
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:05:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C37593E4A;
 Wed, 12 Aug 2026 11:05:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786532723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74TXcgTNGJM/OgxSZwivQlMRWI9fisOOG5q/3xmtFC0=;
 b=OV9qwTaFDYcP2VOCHxEyZShcccLNxryepbRCDF4a2vJJWMPXkjfHaBSLFbdqYBubPuXfOV
 /2etEGl0FoKimq/s09J1JIrf7CHG4voGiPhLbiRc5OqxqhLbtNT0tmZRmZhtkmkE0xeKGJ
 f3EQpTDF9GoZXBnWe7Xkrok4uRG8ImQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786532723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74TXcgTNGJM/OgxSZwivQlMRWI9fisOOG5q/3xmtFC0=;
 b=/T+ZizE4S5o/cltLY6HUTq8X0rZ+x5pjGSP/0+MsvPU4zf+PIU9g76d2H6DEWacVKtJlD5
 rQYwkx044pm+0MCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=OT2USl7r;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="4/W44Gma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786532719; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74TXcgTNGJM/OgxSZwivQlMRWI9fisOOG5q/3xmtFC0=;
 b=OT2USl7rEH2x0nRB2b6ctUSNyxEziJED2B3Oy06H3KVFosIIfKvRw4bcjaFhNyG2iKG7bm
 gDj3ThYFokhU0nxefEHPtFnEf43kblqvS7KoFOpuU5alLps2tF6Yx28sdjs3MB3OWLAmCH
 O1fiqMT3JQ+TJWMn3J2NoYRws+h3poQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786532719;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=74TXcgTNGJM/OgxSZwivQlMRWI9fisOOG5q/3xmtFC0=;
 b=4/W44GmauFPUT5op9DBNBL5iygNm9Ir7TbaLrM8Bgrl9W9lSk37Soq4rIaVKKNGj8XRKn1
 L4xIIwEkY9ZfLzBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B2019779B1;
 Wed, 12 Aug 2026 11:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id F+eaKm9TfGo/WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 12 Aug 2026 11:05:19 +0000
Date: Wed, 12 Aug 2026 13:05:22 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <anxTci_fnDEztVVT@yuki.lan>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260810160048.1040517-4-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C37593E4A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/7] lib: Add support for max_kver to struct
 tst_test and tst_fs
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
> +/*
> + * Check for the maximal required kernel version.
> + *
> + * return: true if the kernel version is low enough, false otherwise.
> + */
> +static bool check_max_kver(const char *max_kver, const int brk_nosupp)
> +{
> +	char *msg;
> +	int dots, i, v1, v2, v3;
> +
> +	tst_parse_kver(max_kver, &v1, &v2, &v3);
> +
> +	for (i = 0, dots = 0; max_kver[i]; i++)
> +		dots += (max_kver[i] == '.');
> +
> +	/*
> +	 * For mainline kernel release without patch level (single dot e.g. "7.1")
> +	 * ignore v3 (the sublevel): 7.1.x is always ok.
> +	 * Do *not* ignore v3 on stable kernel release (2 dots, e.g. 7.1.5).
> +	 */
> +	if (tst_kvercmp(v1, v2, v3) > (dots == 1 ? 1023 : 0)) {

Uff, this is quite ugly. What exactly are we trying to do?


Also we are missing wiring for the shell test executor:

iff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
index 2778fb6d5..263a319bc 100644
--- a/testcases/lib/tst_run_shell.c
+++ b/testcases/lib/tst_run_shell.c
@@ -57,6 +57,7 @@ enum test_attr_ids {
        DEV_MIN_SIZE,
        FILESYSTEMS,
        FORMAT_DEVICE,
+       MAX_KVER,
        MIN_CPUS,
        MIN_MEM_AVAIL,
        MIN_KVER,
@@ -91,6 +92,7 @@ static ujson_obj_attr test_attrs[] = {
        UJSON_OBJ_ATTR_IDX(DEV_MIN_SIZE, "dev_min_size", UJSON_INT),
        UJSON_OBJ_ATTR_IDX(FILESYSTEMS, "filesystems", UJSON_ARR),
        UJSON_OBJ_ATTR_IDX(FORMAT_DEVICE, "format_device", UJSON_BOOL),
+       UJSON_OBJ_ATTR_IDX(MAX_KVER, "max_kver", UJSON_STR),
        UJSON_OBJ_ATTR_IDX(MIN_CPUS, "min_cpus", UJSON_INT),
        UJSON_OBJ_ATTR_IDX(MIN_MEM_AVAIL, "min_mem_avail", UJSON_INT),
        UJSON_OBJ_ATTR_IDX(MIN_KVER, "min_kver", UJSON_STR),
@@ -462,6 +464,9 @@ static void parse_metadata(void)
                case FORMAT_DEVICE:
                        test.format_device = val.val_bool;
                break;
+               case MAX_KVER:
+                       test.max_kver = strdup(val.val_str);
+               break;
                case MIN_CPUS:
                        if (val.val_int <= 0)
                                ujson_err(&reader, "Minimal number of cpus must be > 0");



-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
