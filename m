Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A355C5B56A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 12:30:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DACE3E6CBD
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 14:30:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E70D3E27F7
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 14:30:18 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0E46F600746
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 14:30:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7F652822E7;
 Wed, 12 Aug 2026 12:30:17 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 632AA779B1;
 Wed, 12 Aug 2026 12:30:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id m3oPFllnfGpCKwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Aug 2026 12:30:17 +0000
Date: Wed, 12 Aug 2026 14:30:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260812123007.GA1758016@pevik>
References: <20260810160048.1040517-1-pvorel@suse.cz>
 <20260810160048.1040517-4-pvorel@suse.cz>
 <anxTci_fnDEztVVT@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <anxTci_fnDEztVVT@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 7F652822E7
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > +/*
> > + * Check for the maximal required kernel version.
> > + *
> > + * return: true if the kernel version is low enough, false otherwise.
> > + */
> > +static bool check_max_kver(const char *max_kver, const int brk_nosupp)
> > +{
> > +	char *msg;
> > +	int dots, i, v1, v2, v3;
> > +
> > +	tst_parse_kver(max_kver, &v1, &v2, &v3);
> > +
> > +	for (i = 0, dots = 0; max_kver[i]; i++)
> > +		dots += (max_kver[i] == '.');
> > +
> > +	/*
> > +	 * For mainline kernel release without patch level (single dot e.g. "7.1")
> > +	 * ignore v3 (the sublevel): 7.1.x is always ok.
> > +	 * Do *not* ignore v3 on stable kernel release (2 dots, e.g. 7.1.5).
> > +	 */
> > +	if (tst_kvercmp(v1, v2, v3) > (dots == 1 ? 1023 : 0)) {

> Uff, this is quite ugly. What exactly are we trying to do?

I hoped that was explained in the comment above the code:
 .max_kver = "7.0" should run the test not only kernel <= 7.0,
but also all stable kernels: 7.0.x.
OTOH if there is something backported to stable kernel and one specifies:
.max_kver = "7.0.5" it will be compared just to <= 7.0.5.

Sure, this can be avoided if .max_kver = "7.0" is not inclusive,
i.e. < 7.0 (one would have to use .max_kver = "7.1"), which is less
intuitive, because .min_kver is inclusive).

> Also we are missing wiring for the shell test executor:

I deliberately did not add it and documented my intention in
doc/developers/writing_tests.rst LTP C And Shell Test API Comparison table
+    * - .max_kver
+      - not implemented

The reason is that it's not needed now for shell tests. But sure I can add it.

Kind regards,
Petr

> iff --git a/testcases/lib/tst_run_shell.c b/testcases/lib/tst_run_shell.c
> index 2778fb6d5..263a319bc 100644
> --- a/testcases/lib/tst_run_shell.c
> +++ b/testcases/lib/tst_run_shell.c
> @@ -57,6 +57,7 @@ enum test_attr_ids {
>         DEV_MIN_SIZE,
>         FILESYSTEMS,
>         FORMAT_DEVICE,
> +       MAX_KVER,
>         MIN_CPUS,
>         MIN_MEM_AVAIL,
>         MIN_KVER,
> @@ -91,6 +92,7 @@ static ujson_obj_attr test_attrs[] = {
>         UJSON_OBJ_ATTR_IDX(DEV_MIN_SIZE, "dev_min_size", UJSON_INT),
>         UJSON_OBJ_ATTR_IDX(FILESYSTEMS, "filesystems", UJSON_ARR),
>         UJSON_OBJ_ATTR_IDX(FORMAT_DEVICE, "format_device", UJSON_BOOL),
> +       UJSON_OBJ_ATTR_IDX(MAX_KVER, "max_kver", UJSON_STR),
>         UJSON_OBJ_ATTR_IDX(MIN_CPUS, "min_cpus", UJSON_INT),
>         UJSON_OBJ_ATTR_IDX(MIN_MEM_AVAIL, "min_mem_avail", UJSON_INT),
>         UJSON_OBJ_ATTR_IDX(MIN_KVER, "min_kver", UJSON_STR),
> @@ -462,6 +464,9 @@ static void parse_metadata(void)
>                 case FORMAT_DEVICE:
>                         test.format_device = val.val_bool;
>                 break;
> +               case MAX_KVER:
> +                       test.max_kver = strdup(val.val_str);
> +               break;
>                 case MIN_CPUS:
>                         if (val.val_int <= 0)
>                                 ujson_err(&reader, "Minimal number of cpus must be > 0");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
