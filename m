Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8777FC021A0
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 23:52:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD833C998C
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 00:52:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1EDC53C9967
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:52:39 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DCB07200ADF
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 00:52:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 11A741F7BB;
 Tue, 11 Feb 2025 23:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739317958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgWwo0f/Yp5GJyhS1I3TaqddW8A1DnvP8ZGO3DFkq+o=;
 b=PExGxzBX8NFyocob0gO0Nu8gYd8xk+QtnmgORO0fqr6MHetzoLvBvCXKGRY5KZ7Bz4RvW8
 rhyQdUJ1F3x+RGB2NPZXfh315zZ7+vcnLczrjefyz3D8tdZb4vNsWbIhfg9xSJ/5tfhl6a
 0IU8MDd5/SyBpIgEDyD5NPqFD4Fd3QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739317958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgWwo0f/Yp5GJyhS1I3TaqddW8A1DnvP8ZGO3DFkq+o=;
 b=REeEU23tGeK35gwizN0f5vVcmpVmHxEM8s2XT1umftOGlug+5VWXxOdhEJiGK8brr2hUN+
 TU4iC+Q88ZUQT+BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739317958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgWwo0f/Yp5GJyhS1I3TaqddW8A1DnvP8ZGO3DFkq+o=;
 b=PExGxzBX8NFyocob0gO0Nu8gYd8xk+QtnmgORO0fqr6MHetzoLvBvCXKGRY5KZ7Bz4RvW8
 rhyQdUJ1F3x+RGB2NPZXfh315zZ7+vcnLczrjefyz3D8tdZb4vNsWbIhfg9xSJ/5tfhl6a
 0IU8MDd5/SyBpIgEDyD5NPqFD4Fd3QU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739317958;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PgWwo0f/Yp5GJyhS1I3TaqddW8A1DnvP8ZGO3DFkq+o=;
 b=REeEU23tGeK35gwizN0f5vVcmpVmHxEM8s2XT1umftOGlug+5VWXxOdhEJiGK8brr2hUN+
 TU4iC+Q88ZUQT+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC31A13782;
 Tue, 11 Feb 2025 23:52:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HLVWOMXiq2dJewAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Feb 2025 23:52:37 +0000
Date: Wed, 12 Feb 2025 00:52:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250211235232.GA1992438@pevik>
References: <20250211214627.152634-1-jmoyer@redhat.com>
 <20250211214627.152634-3-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211214627.152634-3-jmoyer@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] lib/tst_device.c: check for
 BTRFS_SUPER_MAGIC instead of device major of 0
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

Hi Jeff,

> stat() may return a major number of 0 in st_dev for any number of
> pseudo file systems.  Check for the exact file system instead.  There
> should be no change in behavior with this patch.

> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>
> ---
>  lib/tst_device.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)

> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 70234a83c..744e08a68 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -17,6 +17,8 @@
>  #include <sys/sysmacros.h>
>  #include <linux/btrfs.h>
>  #include <linux/limits.h>
> +#include <sys/vfs.h>
This just includes <sys/statfs.h>, could you please use it (if it's really
needed).

> +#include <linux/magic.h>
Please don't use it. We have TST_BTRFS_MAGIC and TST_OVERLAYFS_MAGIC in
tst_fs.h. If you ask why we mirror magic it was (probably) for compatibility
with very old kernel headers.

>  #include "lapi/syscalls.h"
>  #include "test.h"
>  #include "safe_macros.h"
> @@ -546,9 +548,6 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
>  		sprintf(bdev_path,
>  			"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
>  	} else {
> -		if (errno == ENOTTY)
> -			tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl failed. Is %s on a tmpfs?", tmp_path);
> -
>  		tst_brkm(TBROK | TERRNO, NULL, "BTRFS ioctl on %s failed.", tmp_path);
>  	}
>  	SAFE_CLOSE(NULL, fd);
> @@ -578,6 +577,7 @@ __attribute__((nonnull))
>  void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
>  {
>  	struct stat buf;
> +	struct statfs fsbuf;
>  	char uevent_path[PATH_MAX+PATH_MAX+10]; //10 is for the static uevent path
>  	char dev_name[NAME_MAX];
>  	char tmp_path[PATH_MAX];
> @@ -595,8 +595,13 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
>  	dev_minor = minor(buf.st_dev);
>  	*dev = '\0';

> -	if (dev_major == 0) {
> +	if (statfs(path, &fsbuf) < 0)
> +		tst_brkm(TWARN | TERRNO, NULL, "statfs() failed");
Please use SAFE_STATFS() here.

> +
> +	if (fsbuf.f_type == BTRFS_SUPER_MAGIC) {
We have TST_BTRFS_MAGIC tst_fs.h.

Kind regards,
Petr

>  		btrfs_get_uevent_path(tmp_path, uevent_path);
> +	} else if (dev_major == 0) {
> +		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
>  	} else {
>  		tst_resm(TINFO, "Use uevent strategy");
>  		sprintf(uevent_path,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
