Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AD35C61DB8
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:07:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1A6B3C9A93
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 14:07:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 64F723C9A93
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 14:06:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D561F600703
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 14:06:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 572461F38E;
 Fri,  6 Jun 2025 12:06:42 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 315441336F;
 Fri,  6 Jun 2025 12:06:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ghDcCdLZQmggWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 12:06:42 +0000
Date: Fri, 6 Jun 2025 14:06:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606120636.GF1289709@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-6-0b5cff90c21c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-conversions-mknod-v5-6-0b5cff90c21c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 572461F38E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 6/8] syscalls/mknod06: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo,

> +static struct tcase {
>  	char *pathname;
>  	char *desc;
>  	int exp_errno;
> -	int (*setupfunc) ();
> -} Test_cases[] = {
> -	{"tnode_1", "Specified node already exists", EEXIST, setup1}, {
> -	NULL, "Invalid address", EFAULT, no_setup}, {
> -	"testdir_2/tnode_2", "Non-existent file", ENOENT, no_setup}, {
> -	"", "Pathname is empty", ENOENT, no_setup}, {
> -	Longpathname, "Pathname too long", ENAMETOOLONG, longpath_setup}, {
> -	"tnode/tnode_3", "Path contains regular file", ENOTDIR, setup3}, {

> -	NULL, NULL, 0, no_setup}
> +} tcases[] = {
> +	{ NULL, "Pathname too long", ENAMETOOLONG },
> +	{ "tnode_1", "Specified node already exists", EEXIST },
> +	{ NULL, "Invalid address", EFAULT },
> +	{ "testdir_2/tnode_2", "Non-existent file", ENOENT },
> +	{ "", "Pathname is empty", ENOENT },
> +	{ "tnode/tnode_3", "Path contains regular file", ENOTDIR },
>  };
Using some constants for path reused ("tnode_1" and "tnode") would be slightly
clearer, but it can stay as is.

...
> +static void setup(void)
>  {
> +	SAFE_MKNOD("tnode_1", MODE_FIFO_RWX, 0);
> +	SAFE_MKNOD("tnode", MODE_FIFO_RWX, 0);

NOTE: if I were the original patch writer, I would really create an empty file,
not a named pipe:
fd = SAFE_OPEN("tnode", O_WRONLY | O_CREAT | O_TRUNC, 0644);
SAFE_CLOSE(fd);

But maybe there was a reason to create named pipe instead of a regular file.

...
> +static struct tst_test test = {
> +	.setup = setup,
> +	.test = run,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.needs_tmpdir = 1,
> +	.bufs = (struct tst_buffers[]) {
> +		{ &longpathname, .size = PATH_MAX + 2 },
> +		{},

+1 for using Guarded buffers.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
