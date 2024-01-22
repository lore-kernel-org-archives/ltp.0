Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44FEBC4725D
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 08:40:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83A2D3CE23B
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:40:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09BF33CD19D
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 09:40:04 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8537D1400FAA
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 09:40:02 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 779FD1FB9E;
 Mon, 22 Jan 2024 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705912802;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyaloe65zVdbWCUYYg9e/OzeMl9bDhP17+8WsEtCnpA=;
 b=VQnNh1uVx+WteKRA7QnZ6ghZdhnF7zj0bhdiM0NMCRHLQIeiv01suSjKJ92mX1FDKxONUl
 QP/Jg4RU6iM7IB7yODCFK2z6T8P7zIYVbZWbz4UTNy0b44jb29X/jn8mSNQECCVcLFAyhc
 GbnCgBYcasZ9iuYVv+XYuQzHkrp84bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705912802;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyaloe65zVdbWCUYYg9e/OzeMl9bDhP17+8WsEtCnpA=;
 b=WayLHAmYCrtDtDMbiO5th5vDEz6fD2NLalBLjE1rfCRiJa/uEUuP6PaFxV9mQZx87HCAUM
 6reoX9hd7f1YqiDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705912802;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyaloe65zVdbWCUYYg9e/OzeMl9bDhP17+8WsEtCnpA=;
 b=VQnNh1uVx+WteKRA7QnZ6ghZdhnF7zj0bhdiM0NMCRHLQIeiv01suSjKJ92mX1FDKxONUl
 QP/Jg4RU6iM7IB7yODCFK2z6T8P7zIYVbZWbz4UTNy0b44jb29X/jn8mSNQECCVcLFAyhc
 GbnCgBYcasZ9iuYVv+XYuQzHkrp84bE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705912802;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vyaloe65zVdbWCUYYg9e/OzeMl9bDhP17+8WsEtCnpA=;
 b=WayLHAmYCrtDtDMbiO5th5vDEz6fD2NLalBLjE1rfCRiJa/uEUuP6PaFxV9mQZx87HCAUM
 6reoX9hd7f1YqiDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4131913995;
 Mon, 22 Jan 2024 08:40:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id X8yVDeIprmWcYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 22 Jan 2024 08:40:02 +0000
Date: Mon, 22 Jan 2024 09:40:00 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240122084000.GB76754@pevik>
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122072948.2568801-4-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240122072948.2568801-4-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] libswap: add Btrfs noCOW attribute setting
 for swap files
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
>  libs/libltpswap/libswap.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)

> diff --git a/libs/libltpswap/libswap.c b/libs/libltpswap/libswap.c
> index 623f2fb3c..0b1d9a227 100644
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
I guess we don't want to break all testing due ioctl failure, right?
Otherwise I would use SAFE_IOCTL().

> +		close(fd);
> +		return;
> +	}
> +
> +	attrs |= FS_NOCOW_FL;
> +
> +	if (ioctl(fd, FS_IOC_SETFLAGS, &attrs) == -1)
> +		tst_res(TFAIL | TERRNO, "Error setting FS_NOCOW_FL attribute");
And here as well.

> +	else
> +		tst_res(TINFO, "FS_NOCOW_FL attribute set on %s\n", filename);
This is redundant new line, please remove \n before merging.

nit: make check reports various of formatting issues (on master there are only
two). Would you dare to fix them? (some of them are added in the first commit).

make check-libswap
CHECK libs/libltpswap/libswap.c
libswap.c:75: WARNING: Missing a blank line after declarations
libswap.c:101: WARNING: please, no spaces at the start of a line
libswap.c:102: WARNING: Missing a blank line after declarations
libswap.c:102: WARNING: please, no spaces at the start of a line
libswap.c:102: WARNING: suspect code indent for conditional statements (7, 15)
libswap.c:103: ERROR: code indent should use tabs where possible
libswap.c:103: WARNING: please, no spaces at the start of a line
libswap.c:103: WARNING: suspect code indent for conditional statements (15, 23)
libswap.c:104: ERROR: code indent should use tabs where possible
libswap.c:104: WARNING: please, no spaces at the start of a line
libswap.c:105: ERROR: code indent should use tabs where possible
libswap.c:105: WARNING: please, no spaces at the start of a line
libswap.c:105: WARNING: suspect code indent for conditional statements (15, 23)
libswap.c:106: ERROR: code indent should use tabs where possible
libswap.c:106: WARNING: please, no spaces at the start of a line
libswap.c:107: WARNING: please, no spaces at the start of a line


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

Maybe using just fs_type (long), i.e. avoid conversion to char * via
tst_fs_type_name()? Or am I missing something?

	long fs_type = tst_fs_type(swapfile);
	...
	if (fs_type == TST_BTRFS_MAGIC) {


Kind regards,
Petr

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
