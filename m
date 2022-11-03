Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 562C1C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 10:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0485F3CAD6E
	for <ltp@archiver.kernel.org>; Thu,  3 Nov 2022 11:50:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A84C3C0F12
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 11:49:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 44C14600865
 for <ltp@lists.linux.it>; Thu,  3 Nov 2022 11:49:54 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 3B86E21DA2;
 Thu,  3 Nov 2022 10:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667472594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=db92pW643hQlk7rUJiKNRwC44zKAKA3a5fNvD45V68Q=;
 b=rtl07ilIG88ZqPjnk6M7dcE7AKraJq3PzYOi0aBL42ukHVsBJphbU3fO78xYXtkHAGeblW
 TgE1MK03QK5Kw1kfn+0RhCplG+qzoLK2rNmnJZGDnfuo2Lv4JVTGvinlVYO6yLVB6SBCly
 ncBLG1blrJR87+OTS9xNYLSaUjkSxWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667472594;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=db92pW643hQlk7rUJiKNRwC44zKAKA3a5fNvD45V68Q=;
 b=IVKy9M1mMDlT0d2n/7XmBCyds8586JnW0Bk4kNVac2dfdl85A+VgVAams0P300pJGcx4s9
 SS6aqV/Sx68WSrDg==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 8A9982C141;
 Thu,  3 Nov 2022 10:49:53 +0000 (UTC)
References: <87pme79f3d.fsf@suse.de>
 <20221102203413.547089-1-alessandro.carminati@gmail.com>
 <20221102203413.547089-2-alessandro.carminati@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Thu, 03 Nov 2022 08:04:53 +0000
Organization: Linux Private Site
In-reply-to: <20221102203413.547089-2-alessandro.carminati@gmail.com>
Message-ID: <8735b0jos5.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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

Fundamentally this looks like a much better solution. However there are
a bunch of details to work out.

>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Signed-off-by: Alessandro Carminati <alessandro.carminati@gmail.com>
> ---
>  lib/tst_device.c | 86 ++++++++++++++++++++++++++++++++----------------
>  1 file changed, 57 insertions(+), 29 deletions(-)
>
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index 8419b80c3..4c2bde846 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -33,6 +33,8 @@
>  #include <stdint.h>
>  #include <inttypes.h>
>  #include <sys/sysmacros.h>
> +#include <btrfs/ioctl.h>

This header won't exist on a lot of systems
(e.g. https://github.com/richiejp/ltp/actions/runs/3384063391/jobs/5620599611). Instead
we can import <linux/btrfs.h> which is in the kernel headers and we
already rely on <linux/loop.h>.

It seems though that the definitions we need are 10+ years old and not
arch or config specific, so we dont' have to add them to
lapi/btrfs.h. Unless it turns out Android removes them or something like
that.

So I think it is safe just to switch this to linux/btrfs.h.

> +#include <dirent.h>
>  #include "lapi/syscalls.h"
>  #include "test.h"
>  #include "safe_macros.h"
> @@ -45,6 +47,7 @@
>  
>  #define DEV_FILE "test_dev.img"
>  #define DEV_SIZE_MB 300u
> +#define UUID_STR_SZ 37
>  
>  static char dev_path[1024];
>  static int device_acquired;
> @@ -519,48 +522,73 @@ static int count_match_len(const char *first, const char *second)
>  void tst_find_backing_dev(const char *path, char *dev)
>  {
>  	struct stat buf;
> +	struct btrfs_ioctl_fs_info_args args = {0};
> +	struct dirent *d;
>  	FILE *file;

This var is now unused. Please look at the compiler warnings (and/or
configure your IDE to display them inline with LSP/clangd or similar).

Please silence any warnings relating to your changes otherwise serious
errors get lost in the noise.

> -	char line[PATH_MAX];
> -	char *pre = NULL;
> -	char *next = NULL;
> -	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> -	unsigned int len, best_match_len = 1;
> -	char mnt_point[PATH_MAX];
> +	char uevent_path[PATH_MAX];
> +	char dev_name[NAME_MAX];

It seems NAME_MAX either does not exist on Alpine linux (perhaps due to
muslc) or needs an extra explicit include.

https://github.com/richiejp/ltp/actions/runs/3384078253/jobs/5620630058

> +	char bdev_path[PATH_MAX];
> +	char btrfs_uuid_str[UUID_STR_SZ];
> +	DIR *dir;
> +	unsigned int dev_major, dev_minor;
> +	int fd;
>  
>  	if (stat(path, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
>  
> +	*dev = '\0';

Very minor nit, but moving this around creates unecessary churn when
doing git-blame.

>  	dev_major = major(buf.st_dev);
>  	dev_minor = minor(buf.st_dev);
> -	file = SAFE_FOPEN(NULL, "/proc/self/mountinfo", "r");
> -	*dev = '\0';
> -
> -	while (fgets(line, sizeof(line), file)) {
> -		if (sscanf(line, "%*d %*d %d:%d %*s %s",
> -			&line_mjr, &line_mnr, mnt_point) != 3)
> -			continue;
> -
> -		pre = strstr(line, " - ");
> -		pre = strtok_r(pre, " ", &next);
> -		pre = strtok_r(NULL, " ", &next);
> -		pre = strtok_r(NULL, " ", &next);
>  
> -		if (line_mjr == dev_major && line_mnr == dev_minor) {
> -			strcpy(dev, pre);
> -			break;
> +	if (dev_major == 0) {
> +		tst_resm(TINFO, "Use BTRFS specific strategy");
> +		dir = opendir("/");

What happens if TMPDIR is not on the same mount as '/'?

Also consider what the user will see if opendir fails with for
e.g. EPERM or ENOMEM. (there is SAFE_OPENDIR).

> +		fd = dirfd(dir);

As we only want the fd, we could call open (SAFE_OPEN)
instead. Incredibly dirfd can fail, so it saves some effort.

> +		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {

What happens if the test author allows this function to be called on
tmpfs, rootfs, etc.? Or if the FS is valid, but has the same issue as
BTRFS.

Especially considering this may be discovered in an environment where
it's difficult to trace the test.

> +			sprintf(btrfs_uuid_str,
> +				"%02x%02x%02x%02x-%02x%02x-"
> +				"%02x%02x-%02x%02x-"
> +				"%02x%02x%02x%02x%02x%02x",
> +				args.fsid[0],args.fsid[1],
> +				args.fsid[2],args.fsid[3],
> +				args.fsid[4],args.fsid[5],
> +				args.fsid[6],args.fsid[7],
> +				args.fsid[8],args.fsid[9],
> +				args.fsid[10],args.fsid[11],
> +				args.fsid[12],args.fsid[13],
> +				args.fsid[14],args.fsid[15]);
> +			sprintf(bdev_path,
> +				"/sys/fs/btrfs/%s/devices",
> btrfs_uuid_str);

LTP uses the kernel C style. If you run 'make check-tst_device' in lib
it will run checkpatch.pl and display the formatting issues.

(you can ignore errors not related to your changes).

>  		}
> -
> -		len = count_match_len(path, mnt_point);
> -		if (len > best_match_len) {
> -			strcpy(dev, pre);
> -			best_match_len = len;
> +		closedir(dir);
> +		dir = opendir(bdev_path);
> +		if (!dir){
> +			tst_brkm(TWARN | TERRNO, NULL,
> +				"can't opendir %d", dir);

This isn't a valid format string and this should be TBROK. However it
can all be replaced with SAFE_OPENDIR.

> +		}
> +		while (d = readdir(dir)){

SAFE_READDIR

> +			if (d->d_name[0]!='.')
> +				break;

I suppose that given the present usage, it doesn't matter if there is
more than one backing dev. However we should at least print an info
message if more than one is detected.

> +		}
> +		uevent_path[0]='\0';
> +		closedir(dir);

This frees the memory pointed to by *d and results in a use-after-free
below. I recommend compiling with -fsanatize=undefined,address
(e.g. ./configure CFLAGS="-fsanatize=undefined,address") during
development.

Then instead of getting random segfaults you always get:

=298==ERROR: AddressSanitizer: heap-use-after-free on address 0x62d00000a473 at pc 0x7f1d7077357e bp 0x7ffea26903b0 sp 0x7ffea268fb60
READ of size 6 at 0x62d00000a473 thread T0
    #0 0x7f1d7077357d  (/lib64/libasan.so.8+0x7657d)
    #1 0x7f1d707744ba in __interceptor_vsprintf (/lib64/libasan.so.8+0x774ba)
    #2 0x7f1d7077460e in __interceptor_sprintf (/lib64/libasan.so.8+0x7760e)
    #3 0x413909 in tst_find_backing_dev /home/rich/qa/ltp/lib/tst_device.c:576
    #4 0x40916f in setup /home/rich/qa/ltp/testcases/kernel/syscalls/ioctl/ioctl_loop05.c:128
    #5 0x41ad47 in do_test_setup /home/rich/qa/ltp/lib/tst_test.c:1285
    #6 0x41ad47 in testrun /home/rich/qa/ltp/lib/tst_test.c:1412
    #7 0x41ad47 in fork_testrun /home/rich/qa/ltp/lib/tst_test.c:1558
    #8 0x421670 in tst_run_tcases /home/rich/qa/ltp/lib/tst_test.c:1651
    #9 0x407c6e in main ../../../../include/tst_test.h:379
    #10 0x7f1d6fef75af in __libc_start_call_main (/lib64/libc.so.6+0x275af)
    #11 0x7f1d6fef7678 in __libc_start_main_impl (/lib64/libc.so.6+0x27678)
    #12 0x4084a4 in _start ../sysdeps/x86_64/start.S:115

0x62d00000a473 is located 115 bytes inside of 32816-byte region [0x62d00000a400,0x62d000012430)
freed by thread T0 here:
    #0 0x7f1d707b80e8  (/lib64/libasan.so.8+0xbb0e8)
    #1 0x7f1d6ffa87f0 in __closedir (/lib64/libc.so.6+0xd87f0)

previously allocated by thread T0 here:
    #0 0x7f1d707b940f in __interceptor_malloc (/lib64/libasan.so.8+0xbc40f)
    #1 0x7f1d6ffa8674 in __alloc_dir (/lib64/libc.so.6+0xd8674)

> +		if (d!=NULL) {

Also not kernel style and there is SAFE_CLOSEDIR.

> +			sprintf(uevent_path, "%s/%s/uevent",
> +				bdev_path, d->d_name);
>  		}

If d == NULL then what does that mean?

> +	} else {
> +
> +		tst_resm(TINFO, "Use uevent strategy");
> +		sprintf(uevent_path,
> +			"/sys/dev/block/%d:%d/uevent", dev_major, dev_minor);
>  	}
>  
> -	SAFE_FCLOSE(NULL, file);
> +	if (!access(uevent_path, R_OK)) {

What is the user going to see if this happens?

N.B if we have no options left then we want to fail as fast as possible
with any information that is easily available. This can save a lot of
time remotely debugging/tracing test systems when a simple log message
could have made the issue clear.

> +		FILE_LINES_SCANF(NULL, uevent_path, "DEVNAME=%s", dev_name);
>  
> -	if (!*dev)
> -		tst_brkm(TBROK, NULL, "Cannot find block device for %s", path);
> +		if (dev_name[0])
> +			sprintf(dev, "/dev/%s", dev_name);
> +	}
>  
>  	if (stat(dev, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat(%s) failed", dev);


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
