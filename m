Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D07FFC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 07:13:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D6B43CE22A
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:13:56 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4CD53CC783
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:13:40 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 055DB1400E4F
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 08:13:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D72281FB9C;
 Mon, 22 Jan 2024 07:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705907619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQnr3eR5oGRZkk3u6qtGqtAXJ84t8o5UPSBxRtP1yWo=;
 b=RlfvlNClPTffyMj9O6oY66h1CMM563y383E7MaxG4av4mVc/TrcKLQ/58HOWpgzfH8QBFe
 xRVLpZO8LXvQnPsrtHB0zToKp9RZuiOOUnYjJ39GEG25a4s7wnFy8a8dhzdDx7Wp3ExBs8
 Xc6boWZg/BjDJOa0gtp2CHzH3rT1GkE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705907619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQnr3eR5oGRZkk3u6qtGqtAXJ84t8o5UPSBxRtP1yWo=;
 b=yVWoqCIaOCXwf8Qj260jV4XvrdVj/H0AnnIwdPWkE4NR83qgVZ0PhG1aPkuTzk7tQTcyCh
 Yg4vQIgWhbNerbAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705907618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQnr3eR5oGRZkk3u6qtGqtAXJ84t8o5UPSBxRtP1yWo=;
 b=I/x1XAq5NC7pTJ6UKwm2fOTwsfqRdVFEcHk3dPdFW5cPSiBRG1F8tLfgv5StQq1oVVxVbR
 QWJVbWbBAJaIZX8Nm2KSnVH3RDQqk8W5DCoTE5b73hBoRjE9ULMCAKJWBjfd1GPdHlvqhb
 Hf1o4x/t3KqyajMretw0rkqbU+AWfvg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705907618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aQnr3eR5oGRZkk3u6qtGqtAXJ84t8o5UPSBxRtP1yWo=;
 b=Xko3DsBWziIYX4j5Js/FD9LC/MYKsg0lmrDkkCzYhX3CSb1Xe5ecSTqYqB596dSMuRgFuz
 CKqF5PTtA4XmZ6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFC1A13995;
 Mon, 22 Jan 2024 07:13:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6Z/RLaIVrmX5RwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 07:13:38 +0000
Date: Mon, 22 Jan 2024 08:13:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122071337.GB65606@pevik>
References: <20240120043412.2544860-2-liwang@redhat.com>
 <20240120082725.2550695-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240120082725.2550695-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] libswap: add Btrfs noCOW attribute setting for
 swap files
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

Hi Li,

> The patch aims to ensure swap files on Btrfs filesystems are created
> with the appropriate FS_NOCOW_FL attribute, which is necessary to
> disable CoW (Copy-on-Write) for swap files, perthe btrfs(5) manual page.
> This change is gated behind a kernel version check to ensure compatibility
> with the system's capabilities.

> Signed-off-by: Li Wang <liwang@redhat.com>
> ---

> Notes:
>     Hi Petr,

>       I haven't gotten a chance to test this patch on any Btrfs platform,
>       but only compile successfully without error on my RHEL8/9(xfs).
>       Can you help test and guarantee it works for you?

I'm not able to apply this to the current master. I also got a bit confused by
number of patches for libswap / swapon01. Could you please resend all the
patches again (in a series)? Or push branch to your fork and point the location?
(whatever is easier to you)

Kind regards,
Petr

>  libs/libltpswap/libswap.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 5f9622aca..8b180f288 100644
> --- a/libs/libltpswap/libswap.c
> +++ b/libs/libltpswap/libswap.c
> @@ -4,6 +4,7 @@
>   * Author: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>   */

> +#include <linux/fs.h>
>  #include <errno.h>

>  #define TST_NO_DEFAULT_MAIN
> @@ -23,11 +24,37 @@ static const char *const swap_supported_fs[] = {
>  	NULL
>  };

> +static void set_nocow_attr(const char *filename)
> +{
> +	int fd;
> +	int attrs;
> +
> +	fd = SAFE_OPEN(filename, O_RDONLY);
> +
> +	if (ioctl(fd, FS_IOC_GETFLAGS, &attrs) == -1) {
> +		tst_res(TFAIL | TERRNO, "Error getting attributes");
> +		close(fd);
> +		return;
> +	}
> +
> +	attrs |= FS_NOCOW_FL;
> +
> +	if (ioctl(fd, FS_IOC_SETFLAGS, &attrs) == -1)
> +		tst_res(TFAIL | TERRNO, "Error setting FS_NOCOW_FL attribute");
> +	else
> +		tst_res(TINFO, "FS_NOCOW_FL attribute set on %s\n", filename);
> +
> +	close(fd);
> +}
> +
>  /*
>   * Make a swap file
>   */
>  int make_swapfile(const char *swapfile, int safe)
>  {
> +	long fs_type = tst_fs_type(swapfile);
> +	const char *fstype = tst_fs_type_name(fs_type);
> +
>  	if (!tst_fs_has_free(".", sysconf(_SC_PAGESIZE) * 10, TST_BYTES))
>  		tst_brk(TBROK, "Insufficient disk space to create swap file");

> @@ -35,6 +62,14 @@ int make_swapfile(const char *swapfile, int safe)
>  	if (tst_fill_file(swapfile, 0, sysconf(_SC_PAGESIZE), 10) != 0)
>  		tst_brk(TBROK, "Failed to create swapfile");

> +	/* Btrfs file need set 'nocow' attribute */
> +	if (strcmp(fstype, "btrfs") == 0) {
> +		if (tst_kvercmp(5, 0, 0) > 0)
> +			set_nocow_attr(swapfile);
> +		else
> +			tst_brk(TCONF, "Swapfile on %s not implemented", fstype);
> +	}
> +
>  	/* make the file swapfile */
>  	const char *argv[2 + 1];
>  	argv[0] = "mkswap";

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
