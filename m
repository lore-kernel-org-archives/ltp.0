Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B597CCD1BB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 13:13:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 596FA3CF0F3
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 15:13:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC5893C0BB4
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 15:13:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 378E61A009B4
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 15:13:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 58F31211EA;
 Wed, 22 Oct 2025 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761138807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLrKDVV8+DK7MZaIC9Wg7lC+sT4CIjj7Va0oqwb+uLA=;
 b=jG/OUDBhVhMzDj84/UoqKcVBK7kZcwd7eRnEBNmP10F+ONaSUtaf6IfKxB2Oljzt8kd21x
 tPNqac0QvTANvilggUtwJC6NjAOkZsQ2f3i8YnQK8a/PGGUwWFovzDz9hB/cbCSPgscktt
 ihvWJKX3+EIiieAJNl1yTp7O2C5ijhs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761138807;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLrKDVV8+DK7MZaIC9Wg7lC+sT4CIjj7Va0oqwb+uLA=;
 b=QAiia9fWRTrc7d64B0FbIUrYO6+bIgjPNPyZkiBXqcAgTgAZgBusNRgO/GyRPz4Ezmjfxu
 HWz1f9zhpt7SdhAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761138803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLrKDVV8+DK7MZaIC9Wg7lC+sT4CIjj7Va0oqwb+uLA=;
 b=vCX5CzBT/XXRolv/Wr2GjaAdJXBiFuVxxW0gV5KRRpwDuM66/yiZn6i9PmQexff3hA8uLu
 0kFjjemcLfSCJOtVYI0mTw+EaJQBETri6H4+AWsyY9qDXy/d0LYeejfd/HC3XeqPUj2OVd
 RWMx4VaHvOIugylQLiH/wfNw60zjs8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761138803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oLrKDVV8+DK7MZaIC9Wg7lC+sT4CIjj7Va0oqwb+uLA=;
 b=B9r3e1L7KX0WAkPompKmFi4uqCsC7qmDPZtbX/eFFeJBFa1yoGAFS+cEn9RUDh8Gb9nS0E
 1jZp95iKwdWU51Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C6471339F;
 Wed, 22 Oct 2025 13:13:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SGW0DXPY+GjlWQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Oct 2025 13:13:23 +0000
Date: Wed, 22 Oct 2025 15:13:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20251022131321.GA482903@pevik>
References: <20251022095740.8747-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251022095740.8747-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 MISSING_XM_UA(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] ioctl_sg01: Skip USB devices
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

Hi Martin,

> Some USB devices write hardware info and flags to the ioctl(SG_IO)
> response buffer which results in test failure. But the info is constant
> and doesn't represent any security risk. Skip USB devices to prevent
> false positives.

> ---

> I've tested this patch on kernels v4.4 through v6.16. Non-USB generic SCSI
> block devices get correctly found and used, USB block device get skipped.

Thanks a lot for an extensive testing!

I was also verify on my machine with block device connected over USB
that it's skipped (and indeed test was blocked on master).

Tested-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Few notes below.

>  testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 55 +++++++++++++++-----
>  1 file changed, 42 insertions(+), 13 deletions(-)

> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> index fba3816c3..66ff980ce 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
> @@ -29,6 +29,9 @@
>  #include "tst_test.h"
>  #include "tst_memutils.h"

> +#define SYSDIR "/sys/block"
> +#define BLOCKDIR "/sys/block/%s/device"
> +
>  #define BUF_SIZE (128 * 4096)
>  #define CMD_SIZE 6

> @@ -38,42 +41,68 @@ static unsigned char command[CMD_SIZE];
>  static struct sg_io_hdr query;

>  /* TODO: split this off to a separate SCSI library? */
> -static const char *find_generic_scsi_device(int access_flags)
> +static const char *find_generic_scsi_device(int access_flags, int skip_usb)
>  {
> -	DIR *devdir;
> +	DIR *sysdir;
>  	struct dirent *ent;
>  	int tmpfd;
> -	static char devpath[PATH_MAX];
> +	ssize_t length;
> +	char *filename;
> +	static char devpath[PATH_MAX], syspath[PATH_MAX];

> -	errno = 0;
> -	devdir = opendir("/dev");
> +	sysdir = opendir(SYSDIR);

> -	if (!devdir)
> +	if (!sysdir)
>  		return NULL;

> -	while ((ent = SAFE_READDIR(devdir))) {
> -		/* The bug is most likely reproducible only on /dev/sg* */
> -		if (strncmp(ent->d_name, "sg", 2) || !isdigit(ent->d_name[2]))

The kernel fix was done in drivers/scsi/sg.c, it made sense to check it.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a45b599ad808

> +	/* Scan block devices */
> +	while ((ent = SAFE_READDIR(sysdir))) {
> +		if (ent->d_name[0] == '.')
> +			continue;
> +
> +		snprintf(syspath, PATH_MAX, BLOCKDIR, ent->d_name);
> +		syspath[PATH_MAX - 1] = '\0';
> +
> +		/* Real device path matches the physical HW bus path */
> +		if (!realpath(syspath, devpath))
> +			continue;
> +
> +		strncat(devpath, "/generic", PATH_MAX - strlen(devpath) - 1);

On one baremetal machine and on VM with added SCSI device this approach really
works (anything "/generic" was actually pointing to scsi_generic/sg*.

> +		devpath[PATH_MAX - 1] = '\0';
> +		length = readlink(devpath, syspath, PATH_MAX - 1);
> +
> +		if (length < 0)
> +			continue;
> +
> +		syspath[length] = '\0';
> +		filename = basename(syspath);
> +
> +		/* USB devices often return HW info in SG_IO response buffer */
> +		if (skip_usb && strstr(devpath, "/usb")) {

very nit: I would personally avoid skip_usb variable because it is always 1
(skip unconditionally). Or actually allow to set it via getopts.

Kind regards,
Petr

...
>  static void setup(void)
>  {
> -	const char *devpath = find_generic_scsi_device(O_RDONLY);
> +	const char *devpath = find_generic_scsi_device(O_RDONLY, 1);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
