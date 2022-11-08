Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 579CAC433FE
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 10:20:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B609D3CD8C2
	for <ltp@archiver.kernel.org>; Tue,  8 Nov 2022 11:20:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A8E03C9733
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 11:20:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EAEAD600A4B
 for <ltp@lists.linux.it>; Tue,  8 Nov 2022 11:20:25 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id B81001F889;
 Tue,  8 Nov 2022 10:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667902824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J13ab3dGg8C2FrTU7xayxZoelPI3fkefrsee3slya48=;
 b=WPFPtBNk+F5zQeDJLd9rRIGgMfzxKMKh5RbWQAS9hMKgzyqIns4ojCqba+vSxaqsTQ0u1C
 cXfDOks4vwC4IAyReEVASNZOLP/uYIKyhBJL9lWF+ao1WMPzoM8Y8mMSHJIKyESDN1Evau
 YVpFgR9EG6e4gzw4BpXuXoZCvmdyAu4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667902824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J13ab3dGg8C2FrTU7xayxZoelPI3fkefrsee3slya48=;
 b=0QyOf6bS6IpMx12NLLlExGffdlDpKCeHHIkCKLeci1Ulb/wrhXXUDSCyZnKZ/8ssRVE2+e
 W2pXQ3QxYAcaZzBg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id C8FA72C141;
 Tue,  8 Nov 2022 10:20:23 +0000 (UTC)
References: <87h6zbxgc9.fsf@suse.de>
 <20221107163957.721315-1-alessandro.carminati@gmail.com>
 <20221107163957.721315-2-alessandro.carminati@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Tue, 08 Nov 2022 09:39:44 +0000
Organization: Linux Private Site
In-reply-to: <20221107163957.721315-2-alessandro.carminati@gmail.com>
Message-ID: <877d05wxwe.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_find_backing_dev: Get dev name from
 /sys/dev/block/*/uevent
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
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

I'd like to merge, but discovered some more issues that requuire more
than a fixup before merge.

Also please use the -v flag in git format-patch to version the patches
after the first revision. I don't mind which version you start at now.

Alessandro Carminati <alessandro.carminati@gmail.com> writes:

> In some minimal Linux, the /dev/root can be missing. The consequence of
> this is that mountinfo doesn't contain the correct information. btrfs
> file systems are yet another point of trouble for this function.
>
> The unevent file in sysfs is another method to retrieve device info
> using the sysfs.
>
> btrfs file systems are special from the device name retrieval, and in
> place of use of the minor/major they are approached by using the uuid.
> In the end, btrfs strategy is a slightly modified version of the same
> unevent strategy.
>
> Non btrfs look in "/sys/dev/block/%d:%d/uevent" major, minor
> btrfs look in /sys/fs/btrfs/%s/devices/%s/uevent, uuid, devname
>
> The btrfs handling requires BTRFS specific ioctl for finding the
> file system uuid, and for this reason, btrfs/ioctl.h is needed.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>  lib/tst_device.c | 91 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 61 insertions(+), 30 deletions(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 8419b80c3..054e39bcd 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -33,6 +33,9 @@
>  #include <stdint.h>
>  #include <inttypes.h>
>  #include <sys/sysmacros.h>
> +#include <linux/btrfs.h>
> +#include <linux/limits.h>
> +#include <dirent.h>
>  #include "lapi/syscalls.h"
>  #include "test.h"
>  #include "safe_macros.h"
> @@ -45,6 +48,8 @@
>  
>  #define DEV_FILE "test_dev.img"
>  #define DEV_SIZE_MB 300u
> +#define UUID_STR_SZ 37
> +#define UUID_FMT "%02x%02x%02x%02x-%02x%02x-%02x%02x-%02x%02x-%02x%02x%02x%02x%02x%02x"
>  
>  static char dev_path[1024];
>  static int device_acquired;
> @@ -519,48 +524,74 @@ static int count_match_len(const char *first, const char *second)
>  void tst_find_backing_dev(const char *path, char *dev)
>  {
>  	struct stat buf;
> -	FILE *file;
> -	char line[PATH_MAX];
> -	char *pre = NULL;
> -	char *next = NULL;
> -	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> -	unsigned int len, best_match_len = 1;
> -	char mnt_point[PATH_MAX];
> +	struct btrfs_ioctl_fs_info_args args = {0};
> +	struct dirent *d;
> +	char uevent_path[PATH_MAX];
> +	char dev_name[NAME_MAX];
> +	char bdev_path[PATH_MAX];
> +	char btrfs_uuid_str[UUID_STR_SZ];
> +	DIR *dir;
> +	unsigned int dev_major, dev_minor;
> +	int fd;
>  
>  	if (stat(path, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
>  
>  	dev_major = major(buf.st_dev);
>  	dev_minor = minor(buf.st_dev);
> -	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
>  	*dev = '\0';
>  
> -	while (fgets(line, sizeof(line), file)) {
> -		if (sscanf(line, "%*d %*d %d:%d %*s %s",
> -			&line_mjr, &line_mnr, mnt_point) != 3)
> -			continue;
> -
> -		pre = strstr(line, " - ");
> -		pre = strtok_r(pre, " ", &next);
> -		pre = strtok_r(NULL, " ", &next);
> -		pre = strtok_r(NULL, " ", &next);
> -
> -		if (line_mjr == dev_major && line_mnr == dev_minor) {
> -			strcpy(dev, pre);
> -			break;
> -		}
> -
> -		len = count_match_len(path, mnt_point);
> -		if (len > best_match_len) {
> -			strcpy(dev, pre);
> -			best_match_len = len;
> +	if (dev_major == 0) {
> +		tst_resm(TINFO, "Use BTRFS specific strategy");
> +
> +		fd = SAFE_OPEN(NULL, dirname(path), O_DIRECTORY);

There are two problems here. One is simple and that dirname can modify
path, but path is a const pointer (compiler should warn about dropping
const modifiers). The simple solution is just to copy path into a buffer.

Secondly ioctl_loop05 passes the path to an image, but the self test in
/lib/newlib_tests/tst_device.c passes the mount point. So unless I am
mistaken dirname will return the dir below the mount point which is
wrong.

One option is to try opening path as a dir first and if that fails, use
dirname to get the containing folder. Changeing ioctl_loop05 would also
be valid.

> +		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
> +			sprintf(btrfs_uuid_str,
> +				UUID_FMT,
> +				args.fsid[0], args.fsid[1],
> +				args.fsid[2], args.fsid[3],
> +				args.fsid[4], args.fsid[5],
> +				args.fsid[6], args.fsid[7],
> +				args.fsid[8], args.fsid[9],
> +				args.fsid[10], args.fsid[11],
> +				args.fsid[12], args.fsid[13],
> +				args.fsid[14], args.fsid[15]);
> +			sprintf(bdev_path,
> +				"/sys/fs/btrfs/%s/devices", btrfs_uuid_str);
> +		} else {
> +			tst_brkm(TBROK, NULL, "BTRFS ioctl failed. Is %s
> on a tmpfs?", path);
Need TERRNO here and/or check that the errorno is ENOTTY otherwise the
hint makes no sense.
> +			}
> +		SAFE_CLOSE(NULL, fd);
> +		dir = SAFE_OPENDIR(NULL, bdev_path);
> +		while (d = SAFE_READDIR(NULL, dir)) {
> +			if (d->d_name[0]!='.')

There are a few formatting errors like the missing spaces around !=.

Run make check-tst_device in the lib dir and see the kernel style
guidelines.

> +				break;
>  		}
> +		uevent_path[0] = '\0';
> +		if (d) {
> +			sprintf(uevent_path, "%s/%s/uevent",
> +				bdev_path, d->d_name);
> +		} else {
> +			tst_brkm(TBROK, NULL, "No backining device
> found");

Still need to print some information about where we are looking (bdev_path).

> +			}
> +		if (SAFE_READDIR(NULL, dir))
> +			tst_resm(TINFO, "Warning: used first of multiple backing device.");
> +		SAFE_CLOSEDIR(NULL, dir);
> +	} else {
> +
> +		tst_resm(TINFO, "Use uevent strategy");
> +		sprintf(uevent_path,
> +			"/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
>  	}
>  
> -	SAFE_FCLOSE(NULL, file);
> +	if (!access(uevent_path, R_OK)) {
> +		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
>  
> -	if (!*dev)
> -		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> +		if (dev_name[0])
> +			sprintf(dev, "/dev/%s", dev_name);
> +	} else {
> +		tst_brkm(TBROK, NULL, "uevent file (%s) access failed",
> uevent_path);

Also we can use (TBROK | TERRNO) here as access sets that.

> +		}

make check somehow missing this. The } is indented too far.

>  
>  	if (stat(dev, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);



-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
