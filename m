Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5E5ECAAA1
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 14:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA9033C98D6
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 16:21:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5BC03C0763
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:20:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 29FE0600052
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 16:20:57 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 5AE2B1FD92;
 Mon, 24 Oct 2022 14:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666621257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDAsxF/QMcPoblSUMvTQHpqP08qEbXbSt+r8TXsUQys=;
 b=W434i+6kzKMmvlTpNCUWITqXaTvANooPQPBrZ34sAIvY96oLMnh7uC3T+NzJgISP9JA60n
 E1KdpJ5RtmCaGZLQ6jqyOY6qDQKnofPD1pbkYl/ZI6eRFSd0U4iGgnziJiOLlLr6NcyWHf
 Nf1KjoEY0c3tmLdb+z//TgMoytgaOLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666621257;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDAsxF/QMcPoblSUMvTQHpqP08qEbXbSt+r8TXsUQys=;
 b=gEkgd/PXm7Q7PDWARLt275pvS6IdOXhjpySspMryz/fS/17XSz3LPtxeqYgsZZgP5lfJ/z
 aL+kWBbSAVsc9gBQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0F14F2C141;
 Mon, 24 Oct 2022 14:20:57 +0000 (UTC)
References: <Y0023HcAOlhfAcJw@lab.hqhome163.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 24 Oct 2022 14:49:32 +0100
In-reply-to: <Y0023HcAOlhfAcJw@lab.hqhome163.com>
Message-ID: <87o7u1xpz1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix tst_find_backing_dev when no initramfs
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Alessandro Carminati <alessandro.carminati@gmail.com> writes:

> mount_root() is the kernel function responsible for mounting the primary
> rootfs.
> A dynamic there, prevents the /dev/root device node in the not yet mounted
> files system. For this reason, in the embedded system that starts without
> an initramfs, or however a proper initscript, the /dev/root device appears
> into the mount table in the / line.
> The test tries to open this /dev/root and fails with a warning.
> This patch aims to fix this situation.

Thanks I probably would have hit this issue sooner or later.

>
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
>
> typo fixes
> ---
>  lib/tst_device.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 8419b80c3..c3427eb31 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -526,6 +526,8 @@ void tst_find_backing_dev(const char *path, char *dev)
>  	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
>  	unsigned int len, best_match_len = 1;
>  	char mnt_point[PATH_MAX];
> +	char tmpbuf1[PATH_MAX];
> +	char tmpbuf2[PATH_MAX];

It would be more readable to use three buffers and give them meaningful names.

>  
>  	if (stat(path, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
> @@ -562,6 +564,24 @@ void tst_find_backing_dev(const char *path, char *dev)
>  	if (!*dev)
>  		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
>  
> +	if (stat(dev, &buf) < 0) {

As there is no harm in calling stat twice; could just do

if (stat(dev, &buf) < 0) && strcmp("/dev/root", dev) == 0) {

Or even replace with strcmp with errno == ENOENT and use this as a
general fallback.

> +		if (strcmp("/dev/root", dev) != 0) {
> +			tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
> +		} else {

Then remove this if statement

> +			sprintf(tmpbuf1, "/sys/dev/block/%d:%d/uevent",
> dev_major, dev_minor);
> +			file = SAFE_FOPEN(NULL, tmpbuf1, "r");
> +			while (fgets(line, sizeof(line), file)) {
> +				if (sscanf(line, "%[^=]=%s", tmpbuf1, tmpbuf2) != 2)
> +					continue;
> +				if (strcmp("DEVNAME", tmpbuf1) == 0) {
> +					sprintf(dev, "/dev/%s", tmpbuf2);
> +					break;
> +				}
> +			}
> +			SAFE_FCLOSE(NULL, file);
> +		}
> +	}
> +
>  	if (stat(dev, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);
>  
> -- 
> 2.34.1


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
