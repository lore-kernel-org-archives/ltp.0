Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93F2FCCF9E0
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 13:31:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EECE33CF2E0
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 15:31:02 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6FBB3CE152
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 15:30:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5C541600A86
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 15:30:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 60D571F388;
 Fri, 24 Oct 2025 13:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761312645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IK0WDJeDH5h3ePwcWiCFFJg97rtj0H7HnIwd19tEq8=;
 b=tt3qS4xmOavJHf7lhPaXlJ1rfzmWKYYonUj8BKjf0sCZyX7eVR16YPGSELSLip4jEbPyih
 B/KoWAoNGkqCqBRpmR3QjadVSiG5Xp431W5S6ij1BiVuvRN40lhddrT5aAhaVGMQJj+Skp
 1jw/7DQLjSxVwx1Kzmt+BSB32b6nj0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761312645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IK0WDJeDH5h3ePwcWiCFFJg97rtj0H7HnIwd19tEq8=;
 b=9K6zvvFSB0vkIha/Q4RH9jAcrWg1865VqRsBblPfObykExE5RAuuJDz8hbm/uXkh4YOhoX
 GnvFo13thnLUTKCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761312645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IK0WDJeDH5h3ePwcWiCFFJg97rtj0H7HnIwd19tEq8=;
 b=tt3qS4xmOavJHf7lhPaXlJ1rfzmWKYYonUj8BKjf0sCZyX7eVR16YPGSELSLip4jEbPyih
 B/KoWAoNGkqCqBRpmR3QjadVSiG5Xp431W5S6ij1BiVuvRN40lhddrT5aAhaVGMQJj+Skp
 1jw/7DQLjSxVwx1Kzmt+BSB32b6nj0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761312645;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4IK0WDJeDH5h3ePwcWiCFFJg97rtj0H7HnIwd19tEq8=;
 b=9K6zvvFSB0vkIha/Q4RH9jAcrWg1865VqRsBblPfObykExE5RAuuJDz8hbm/uXkh4YOhoX
 GnvFo13thnLUTKCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ED10C132C2;
 Fri, 24 Oct 2025 13:30:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E58zNoR/+2hBCAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 24 Oct 2025 13:30:44 +0000
Date: Fri, 24 Oct 2025 15:30:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20251024133035.GA590258@pevik>
References: <20251024125613.2340799-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251024125613.2340799-1-anders.roxell@linaro.org>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,linaro.org:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: benjamin.copeland@linaro.org, dan.carpenter@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> The file_attr02 test requires XFS filesystem support to properly
> test the FS_IOC_FSSETXATTR ioctl with project quotas. Add the
> XFS kernel configuration requirement to ensure the test can run
> on systems with XFS support either built-in or as a module.

So you have problem on the kernel with CONFIG_XFS_FS=y?
I wonder why tst_get_supported_fs_types() from lib/tst_supported_fs_types.c did
not detect it. Could you please post whole output?

Because if code in struct tst_test.filesystems does not work, many tests would
be affected with this setup. I'm probably missing something, but I'd prefer to
fix the detection in the library than force config (we don't have any CONFIG_.*_FS
in testcases/).

> Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  testcases/kernel/syscalls/file_attr/file_attr02.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
> index f6625985a514..0ad57177078b 100644
> --- a/testcases/kernel/syscalls/file_attr/file_attr02.c
> +++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
> @@ -18,6 +18,11 @@
>  #define BLOCKS 128
>  #define PROJID 16

> +static const char *kconfigs[] = {
> +	"CONFIG_XFS_FS=y | CONFIG_XFS_FS=m",
> +	NULL
> +};
> +
>  static int fd = -1;
>  static int dfd = -1;
>  static struct fsxattr xattr;
> @@ -105,5 +110,6 @@ static struct tst_test test = {
>  	.bufs = (struct tst_buffers []) {
>  		{&attr, .size = sizeof(struct file_attr)},
>  		{}
> -	}
> +	},
> +	.needs_kconfigs = kconfigs,

very nit: we usually use anonymous definition here, instead creating static
variable kconfigs[].

Kind regards,
Petr

>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
