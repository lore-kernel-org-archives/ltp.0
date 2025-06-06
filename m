Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBBBC5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:22:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8778A3CA30A
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 14:22:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9629D3C9A93
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 14:21:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BFDA31400067
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 14:21:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F36081F82C;
 Fri,  6 Jun 2025 12:21:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D42E71369F;
 Fri,  6 Jun 2025 12:21:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hTlVMl3dQmjEYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 12:21:49 +0000
Date: Fri, 6 Jun 2025 14:21:44 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606122144.GG1289709@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-7-0b5cff90c21c@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605-conversions-mknod-v5-7-0b5cff90c21c@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: F36081F82C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 7/8] syscalls/mknod07: Convert to new API
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
>  	int mode;
>  	int exp_errno;
>  	int major, minor;
> -} test_cases[] = {
> -	{ "testdir_1/tnode_1", SOCKET_MODE, EACCES, 0, 0 },
> -	{ "testdir_1/tnode_2", FIFO_MODE, EACCES, 0, 0 },
> -	{ "tnode_3", CHR_MODE, EPERM, 1, 3 },
> -	{ "tnode_4", BLK_MODE, EPERM, 0, 0 },
> -	{ "mntpoint/tnode_5", SOCKET_MODE, EROFS, 0, 0 },
> -	{ elooppathname, FIFO_MODE, ELOOP, 0, 0 },
> +} tcases[] = {
> +	{ NULL, FIFO_MODE, ELOOP, 0, 0 },
> +	{ TEMP_DIR "/tnode1", SOCKET_MODE, EACCES, 0, 0 },

I would slightly prefer to use designated initializers as it's more descriptive
and allows to avoid setting 0 or NULL:

	{ .mode = FIFO_MODE, .exp_errno = ELOOP },
	{ .pathname = TEMP_DIR "/tnode1", .mode = SOCKET_MODE, .exp_errno = EACCES },

But let's ignore it.

Thanks for the rewrite!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +	{ TEMP_DIR "/tnode2", FIFO_MODE, EACCES, 0, 0 },
> +	{ "tnode3", CHR_MODE, EPERM, 1, 3 },
> +	{ "tnode4", BLK_MODE, EPERM, 0, 0 },
> +	{ TEMP_MNT "/tnode5", SOCKET_MODE, EROFS, 0, 0 },
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
