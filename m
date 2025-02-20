Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEEA4C021B1
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 11:15:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3970F3C280D
	for <ltp@archiver.kernel.org>; Thu, 20 Feb 2025 12:15:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A92B3C052E
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 12:15:11 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 23FBE66D4E7
 for <ltp@lists.linux.it>; Thu, 20 Feb 2025 12:15:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0ECDB1F387;
 Thu, 20 Feb 2025 11:15:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740050110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skYyh2Cn4SmKOimu9ueR3rF6B4epZw/IBD9PqhVWS0s=;
 b=1S2VqgK5T9dqhoaDUBOTihlWbHva4SmkgQ5MY88vJ0TTLaJd1inCiXVPC5+mHHqkndnY4x
 UnkpLNjCrc2R6nuIXIgoMRbP1VO9ZKWAYj4103iO8lUzb8+SKfL0/LPWUKvamsFC/IZZ+C
 7cW3WlOCoSdmfh4cYj0+Iej0AXn3xK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740050110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skYyh2Cn4SmKOimu9ueR3rF6B4epZw/IBD9PqhVWS0s=;
 b=7msPR6h3p9UcUZ9oBpTcyNg05BiDhl+wzlPJQHycaabVMbkGgyiyuorY1yPsw23ZKGgJaT
 e072p4m6JRru6sDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="ZU/rN8T+";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=yeeXvNSa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740050109; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skYyh2Cn4SmKOimu9ueR3rF6B4epZw/IBD9PqhVWS0s=;
 b=ZU/rN8T+NPZM2sPf8C0npmG1sOoOE35kPLO6KZNnqmwHnGkjKwnIjdxQ9D9FK2qG0DTLUR
 QwJTmoy2a8PgOzGgnYZa45FXmk4kkRk/y+7AASEDDwC+h2Cw1Ay9KGaaAbwu/EJTz989BV
 qvY+dm5WB2zWHFpO/Afy9ryQKtWosbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740050109;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=skYyh2Cn4SmKOimu9ueR3rF6B4epZw/IBD9PqhVWS0s=;
 b=yeeXvNSaWmI4KG6K8TTK0HwlDKmtpjmE07jchjOOYmK+kcEgtEJ6RE21xWAQ0C3H9YWIod
 w/08HthiyHUpKEDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ECE1C13A42;
 Thu, 20 Feb 2025 11:15:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XoBwOLwOt2c8GQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 20 Feb 2025 11:15:08 +0000
Date: Thu, 20 Feb 2025 12:15:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <Z7cOxcRhtPcZSpsL@yuki.lan>
References: <20250217215038.177250-1-jmoyer@redhat.com>
 <20250217215038.177250-4-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250217215038.177250-4-jmoyer@redhat.com>
X-Rspamd-Queue-Id: 0ECDB1F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linux.it:url,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] tst_find_backing_dev(): add support for
 overlayfs
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
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 76c3a3e1e..29dc6974f 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2014 Cyril Hrubis chrubis@suse.cz
>   */
>  
> +#define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
> @@ -572,6 +573,136 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
>  	SAFE_CLOSEDIR(NULL, dir);
>  }
>  
> +static char *overlay_mount_from_dev(dev_t dev)
> +{
> +	unsigned dev_major, dev_minor, mnt_major, mnt_minor;
> +	FILE *fp;
> +	char line[PATH_MAX];

PATH_MAX does not really make any sense here. It's as good as any other
number so I would just hardcode 4096 here.

> +	char *mountpoint;
> +	int ret;
> +
> +	dev_major = major(dev);
> +	dev_minor = minor(dev);
> +
> +	fp = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
> +	while (fgets(line, sizeof(line), fp) != NULL) {
> +		ret = sscanf(line, "%*d %*d %u:%u %*s %ms",
> +			     &mnt_major, &mnt_minor, &mountpoint);
> +		if (ret != 3)
> +			tst_brkm(TBROK, NULL,
> +				 "failed to parse mountinfo line: \"%s\"",
                                                                   ^
                We usually use ' instead of " inside of strings in LTP.


> +				 line);
> +		if (mnt_major == dev_major && mnt_minor == dev_minor)
> +			break;
> +		free(mountpoint);
> +		mountpoint = NULL;
> +	}
> +	SAFE_FCLOSE(NULL, fp);
> +	if (!mountpoint)
> +		tst_brkm(TBROK, NULL,
> +			 "Unable to find mount entry for device %u:%u\n",
                                                                      ^
							No newlines in
							tst_*()
							messages please.
> +			 dev_major, dev_minor);
> +
> +	return mountpoint;
> +}
> +
> +static char *overlay_get_upperdir(char *mountpoint)
> +{
> +	FILE *mntf;
> +	struct mntent *mnt;
> +	char *optstr, *optstart, *optend;
> +	char *upperdir = NULL;
> +
> +	mntf = setmntent("/proc/self/mounts", "r");
> +	if (!mntf)
> +		tst_brkm(TBROK | TERRNO, NULL, "Can't open /proc/self/mounts");
> +
> +	while ((mnt = getmntent(mntf)) != NULL) {
> +		if (strncmp(mnt->mnt_dir, mountpoint, strlen(mountpoint)))
> +			continue;

Why strncmp() here? Isn't this possibly generating false positives in
the case that we there is more mounts that have the same prefix that
matches mountpoint?

> +		if (strncmp(mnt->mnt_type, "overlay", strlen("overlay")))
> +			tst_brkm(TBROK, NULL,
> +				 "expected overlayfs on mount point \"%s\", but it is of type %s.",
> +				 mountpoint, mnt->mnt_type);

Here as well, I suppose that the probability of false positive here is
close to zero, but I do not see the reason for strncmp() here either.

> +		optstr = hasmntopt(mnt, "upperdir");
> +		if (optstr) {
> +			optstart = strchr(optstr, '=');
> +			optstart++;
> +			optend = strchrnul(optstr, ',');
> +			upperdir = calloc(optend - optstart + 1, 1);
> +			memcpy(upperdir, optstart, optend - optstart);

Isn't this just a complicated way how to re-implement strndup()?

> +			break;
> +		} else {
> +			tst_brkm(TBROK, NULL,
> +				 "mount point %s does not contain an upperdir",
> +				 mountpoint);
> +		}
> +	}
> +	endmntent(mntf);
> +
> +	if (!upperdir)
> +		tst_brkm(TBROK, NULL,
> +			 "Unable to find mount point \"%s\" in mount table",
> +			 mountpoint);
> +
> +	return upperdir;
> +}
> +
> +/*
> + * To get from a file or directory on an overlayfs to a device
> + * for an underlying mountpoint requires the following steps:
> + *
> + * 1. stat() the pathname and pick out st_dev.
> + * 2. use the st_dev to look up the mount point of the file
> + *    system in /proc/self/mountinfo
> + *
> + * Because 'mountinfo' is a much more complicated file format than
> + * 'mounts', we switch to looking up the mount point in /proc/mounts,
> + * and use the mntent.h helpers to parse the entries.
> + *
> + * 3. Using getmntent(), find the entry for the mount point identified
> + *    in step 2.
> + * 4. Call hasmntopt() to find the upperdir option, and parse that
> + *    option to get to the path name for the upper directory.
> + * 5. Call stat on the upper directory.  This should now contain
> + *    the major and minor number for the underlying device (assuming
> + *    that there aren't nested overlay file systems).
> + * 6. Populate the uevent path.
> + *
> + * Example /proc/self/mountinfo line for overlayfs:
> + *    471 69 0:48 / /tmp rw,relatime shared:242 - overlay overlay rw,seclabel,lowerdir=/tmp,upperdir=/mnt/upper/upper,workdir=/mnt/upper/work,uuid=null
> + *
> + * See section 3.5 of the kernel's Documentation/filesystems/proc.rst file
> + * for a detailed explanation of the mountinfo format.
> + */
> +static void overlay_get_uevent_path(char *tmp_path, char *uevent_path)
> +{
> +	int ret;
> +	struct stat st;
> +	char *mountpoint, *upperdir;
> +
> +	tst_resm(TINFO, "Use OVERLAYFS specific strategy");
> +
> +	ret = stat(tmp_path, &st);
> +	if (ret)
> +		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
> +
> +	mountpoint = overlay_mount_from_dev(st.st_dev);
> +	upperdir = overlay_get_upperdir(mountpoint);
> +	free(mountpoint);

Since the mntpoint is only intermediate result, why can't we pass the
st.dev to the overlay_get_upperdir() and call overlay_mount_from_dev()
from there?

> +	ret = stat(upperdir, &st);
> +	free(upperdir);
> +	if (ret)
> +		tst_brkm(TBROK | TERRNO, NULL, "stat failed");
> +
> +	tst_resm(TINFO, "Warning: used first of multiple backing devices.");
> +	sprintf(uevent_path, "/sys/dev/block/%d:%d/uevent",
> +		major(st.st_dev), minor(st.st_dev));
> +}
> +
>  __attribute__((nonnull))
>  void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
>  {
> @@ -599,6 +730,8 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)
>  
>  	if (fsbuf.f_type == TST_BTRFS_MAGIC) {
>  		btrfs_get_uevent_path(tmp_path, uevent_path);
> +	} else if (fsbuf.f_type == TST_OVERLAYFS_MAGIC) {
> +		overlay_get_uevent_path(tmp_path, uevent_path);
>  	} else if (dev_major == 0) {
>  		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
>  	} else {
> -- 
> 2.43.5
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
