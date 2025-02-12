Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92015C0219B
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 00:19:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E23BF3C99A6
	for <ltp@archiver.kernel.org>; Wed, 12 Feb 2025 01:19:48 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DBB63C8ED5
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 01:19:32 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 979D91BDB9B9
 for <ltp@lists.linux.it>; Wed, 12 Feb 2025 01:19:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BC66C22B52;
 Wed, 12 Feb 2025 00:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739319570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=To7ggag2X3tQ3tAE2oI0I9ykvZ7gh1PaQ6ES9BBRdss=;
 b=n8IyOq2cmvJar2a/mCLrqgoAF0WjeWFysyTzUikNnJxE1N05MY35A//a1AvtWa9k15J1d7
 3gBKz/fuLNWnUwXAtf5s0HWNobmiJkWfyfWhmW022/Zl5zn3zRwwAbVep8ks1aDMhhhpwk
 0lgDEUV1mUwY6BvzAmaritoAMET9FGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739319570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=To7ggag2X3tQ3tAE2oI0I9ykvZ7gh1PaQ6ES9BBRdss=;
 b=pDaBxzIsMmEFwXpEk8JmSQIKJenFg4H7WYoF4e1wNphhTytP0U7zJVdpJiBeag8NJ9YY8b
 hU9HqIrlzr1qi1CQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739319570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=To7ggag2X3tQ3tAE2oI0I9ykvZ7gh1PaQ6ES9BBRdss=;
 b=n8IyOq2cmvJar2a/mCLrqgoAF0WjeWFysyTzUikNnJxE1N05MY35A//a1AvtWa9k15J1d7
 3gBKz/fuLNWnUwXAtf5s0HWNobmiJkWfyfWhmW022/Zl5zn3zRwwAbVep8ks1aDMhhhpwk
 0lgDEUV1mUwY6BvzAmaritoAMET9FGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739319570;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=To7ggag2X3tQ3tAE2oI0I9ykvZ7gh1PaQ6ES9BBRdss=;
 b=pDaBxzIsMmEFwXpEk8JmSQIKJenFg4H7WYoF4e1wNphhTytP0U7zJVdpJiBeag8NJ9YY8b
 hU9HqIrlzr1qi1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D3F513874;
 Wed, 12 Feb 2025 00:19:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2NqJJBLpq2euJQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 12 Feb 2025 00:19:30 +0000
Date: Wed, 12 Feb 2025 01:19:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jeff Moyer <jmoyer@redhat.com>
Message-ID: <20250212001925.GC1992438@pevik>
References: <20250211214627.152634-1-jmoyer@redhat.com>
 <20250211214627.152634-4-jmoyer@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250211214627.152634-4-jmoyer@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] tst_find_backing_dev(): add support for
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jeff,

> Add checks for overlayfs in tst_find_backing_dev.  As with btrfs, only
> a single device is checked (the upper one) and returned from
> tst_find_backing_dev().

> The implementation uses both /proc/self/mountinfo and /proc/self/mounts.
> The former is used to map a device to a mountpoint, and the latter is
> used to get the file system options for the mountpoint.  All of the
> information is present in mountinfo, but the file format is more complex,
> and there are no glibc helpers for parsing it.

> The '#define _GNU_SOURCE' was added for the use of the strchrnul(3)
> function.

+1 (strangely not needed for current glibc in Tumbleweed, but at least musl
requires it).

> Signed-off-by: Jeff Moyer <jmoyer@redhat.com>

> ---
> v2: Don't use libmount.  Instead, map from device number to mount-point
>     using /proc/self/mountinfo, and then use the mntent.h helpers to get
>     the mount options for the mountpoint from /proc/self/mounts.

Thanks a lot!

> ---
>  lib/tst_device.c | 134 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 134 insertions(+)

> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 744e08a68..4730396b4 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -3,6 +3,7 @@
>   * Copyright (C) 2014 Cyril Hrubis chrubis@suse.cz
>   */

> +#define _GNU_SOURCE
>  #include <sys/types.h>
>  #include <sys/stat.h>
>  #include <sys/ioctl.h>
> @@ -573,6 +574,137 @@ static void btrfs_get_uevent_path(char *tmp_path, char *uevent_path)
>  	SAFE_CLOSEDIR(NULL, dir);
>  }

> +static char *overlay_mount_from_dev(dev_t dev)
> +{
> +	unsigned dev_major, dev_minor, mnt_major, mnt_minor;
> +	FILE *fp;
> +	char line[PATH_MAX];
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
Can you please use SAFE_SSCANF() (our extra checks)?
> +		if (ret != 3)
> +			tst_brkm(TBROK, NULL,
> +				 "failed to parse mountinfo line: \"%s\"",
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
> +
> +		if (strncmp(mnt->mnt_type, "overlay", strlen("overlay")))
> +			tst_brkm(TBROK, NULL,
> +				 "expected overlay file system on mount point "\
> +				 "\"%s\", but it is of type %s.",
nit: I slightly prefer not splitting string when together is not that long.

> +				 mountpoint, mnt->mnt_type);
> +
> +		optstr = hasmntopt(mnt, "upperdir");
> +		if (optstr) {
> +			optstart = strchr(optstr, '=');
> +			optstart++;
> +			optend = strchrnul(optstr, ',');
> +			upperdir = calloc(optend - optstart + 1, 1);
> +			memcpy(upperdir, optstart, optend - optstart);
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
+1

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
+1, thanks for an example and docs.

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
> +
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
> @@ -600,6 +732,8 @@ void tst_find_backing_dev(const char *path, char *dev, size_t dev_size)

>  	if (fsbuf.f_type == BTRFS_SUPER_MAGIC) {
>  		btrfs_get_uevent_path(tmp_path, uevent_path);
> +	} else if (fsbuf.f_type == OVERLAYFS_SUPER_MAGIC) {
As I noted, we have ST_BTRFS_MAGIC and TST_OVERLAYFS_MAGIC in tst_fs.h.
And the reason is now clear, old headers we still support does not have it:

tst_device.c:735:29: error: 'OVERLAYFS_SUPER_MAGIC' undeclared (first use in this function)

https://github.com/pevik/ltp/actions/runs/13274657394/job/37061743549

With this fixed:
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +		overlay_get_uevent_path(tmp_path, uevent_path);
>  	} else if (dev_major == 0) {
>  		tst_brkm(TBROK, NULL, "%s resides on an unsupported pseudo-file system.", path);
>  	} else {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
