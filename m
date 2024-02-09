Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F345C4829B
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 22:14:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FB543CF4EE
	for <ltp@archiver.kernel.org>; Fri,  9 Feb 2024 23:14:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3903E3CC33D
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 23:14:00 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 313FC2000C3
 for <ltp@lists.linux.it>; Fri,  9 Feb 2024 23:13:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 33CD71F833;
 Fri,  9 Feb 2024 22:13:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707516839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEsuFLBuc9rizjCKewm6fDrD0CIR2uYBcYwMG7oxQW8=;
 b=QFITS8KHDZqcQs5nmLqbwcKTFWQmwuXrI6hejGgaTTArFmxKMbQ7HyRru1QWMLbiGE/8la
 sHXv9qEENm+EpYyRr8+p18YDQlao7Sf+scZ2A4WTlYaQDXh22m7PzzkOnorcfTo/CyTvCB
 hLOnLU0X9obcgYQp948RMAQGJ5lR/u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707516839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEsuFLBuc9rizjCKewm6fDrD0CIR2uYBcYwMG7oxQW8=;
 b=7EVNEE9u0sganSbBpBdKGNtFU4lCB8++tXSbSUqcAM9fRizOOX2425lNNR1DYgN5ZEGz+v
 n+6+gGBkwZdE8TCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707516839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEsuFLBuc9rizjCKewm6fDrD0CIR2uYBcYwMG7oxQW8=;
 b=QFITS8KHDZqcQs5nmLqbwcKTFWQmwuXrI6hejGgaTTArFmxKMbQ7HyRru1QWMLbiGE/8la
 sHXv9qEENm+EpYyRr8+p18YDQlao7Sf+scZ2A4WTlYaQDXh22m7PzzkOnorcfTo/CyTvCB
 hLOnLU0X9obcgYQp948RMAQGJ5lR/u0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707516839;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEsuFLBuc9rizjCKewm6fDrD0CIR2uYBcYwMG7oxQW8=;
 b=7EVNEE9u0sganSbBpBdKGNtFU4lCB8++tXSbSUqcAM9fRizOOX2425lNNR1DYgN5ZEGz+v
 n+6+gGBkwZdE8TCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 16C9C139E7;
 Fri,  9 Feb 2024 22:13:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lypFBKejxmXqcQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 09 Feb 2024 22:13:59 +0000
Date: Fri, 9 Feb 2024 23:13:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240209221357.GB351028@pevik>
References: <20240209105230.28260-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240209105230.28260-1-andrea.cervesato@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-2.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Refactor mount02 test using new LTP API
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

Hi Andrea,

Generally LGTM, few hints below.
...
> +/*\
> + * [Description]
>   *
> - * You should have received a copy of the GNU General Public License along
> - * with this program; if not, write the Free Software Foundation, Inc.,
> - * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> + * Check for basic errors returned by mount(2) system call.
>   *
> + * - ENODEV if filesystem type not configured
> + * - ENOTBLK if specialfile is not a block device
> + * - EBUSY if specialfile is already mounted or it  cannot  be remounted
> + *   read-only, because it still holds files open for writing.
> + * - EINVAL if specialfile or device is invalid or a remount was attempted,
> + *   while source was not already mounted on target.
> + * - EFAULT if special file or device file points to invalid address space.
> + * - ENAMETOOLONG if pathname was longer than MAXPATHLEN.
> + * - ENOENT if pathname was empty or has a nonexistent component.
> + * - ENOTDIR if not a directory.
>   */

...
> -#include <errno.h>
> +#include "tst_test.h"
>  #include <sys/mount.h>
> -#include <sys/types.h>
> -#include <sys/stat.h>
>  #include <sys/sysmacros.h>
This header is not needed.

> -#include <fcntl.h>
> -#include "test.h"
> -#include "safe_macros.h"
> -
> -static void setup(void);
> -static void cleanup(void);

> -char *TCID = "mount02";
> -
> -#define DIR_MODE	(S_IRWXU | S_IRUSR | S_IXUSR | S_IRGRP | S_IXGRP)
> -#define FILE_MODE	(S_IRWXU | S_IRWXG | S_IRWXO)
> +#define MNTPOINT "mntpoint"
#define TEST_FILE MNTPOINT"/file"

And use it later in pre_create_file()
	fd = SAFE_OPEN(TEST_FILE, O_CREAT | O_RDWR, 0700);

>  static char path[PATH_MAX + 2];
>  static const char *long_path = path;
> +static const char *device;
>  static const char *fs_type;
> +static const char *null;
>  static const char *wrong_fs_type = "error";
> -static const char *mntpoint = "mntpoint";
> -static const char *device;
> -static const char *null = NULL;
> -static const char *fault = (void*)-1;
> +static const char *mntpoint = MNTPOINT;
> +static const char *fault = (void *)-1;
Hopefully this will work everywhere.
I wonder if this is a better approach:

tst_get_bad_addr(NULL);

>  static const char *nonexistent = "nonexistent";
>  static const char *char_dev = "char_device";
>  static const char *file = "filename";
>  static int fd;

> -static void do_umount(void);
> -static void close_umount(void);
> -static void do_mount(void);
> -static void mount_open(void);
> +static void pre_mount(void);
> +static void post_umount(void);
> +static void pre_create_file(void);
> +static void post_delete_file(void);

>  static struct test_case {
>  	const char **device;
>  	const char **mntpoint;
>  	const char **fs_type;
> +	const char *fs_str;
We usually use *desc for this.

>  	unsigned long flag;
>  	int exp_errno;
>  	void (*setup)(void);
>  	void (*cleanup)(void);
> -} tc[] = {
> -	{&device, &mntpoint, &wrong_fs_type, 0, ENODEV, NULL, NULL},
> -	{&char_dev, &mntpoint, &fs_type, 0, ENOTBLK, NULL, NULL},
> -	{&device, &mntpoint, &fs_type, 0, EBUSY, do_mount, do_umount},
> -	{&device, &mntpoint, &fs_type, MS_REMOUNT | MS_RDONLY, EBUSY,
> -	 mount_open, close_umount},
> -	{&null, &mntpoint, &fs_type, 0, EINVAL, NULL, NULL},
> -	{&device, &mntpoint, &null, 0, EINVAL, NULL, NULL},
> -	{&device, &mntpoint, &fs_type, MS_REMOUNT, EINVAL, NULL, NULL},
> -	{&fault, &mntpoint, &fs_type, 0, EFAULT, NULL, NULL},
> -	{&device, &mntpoint, &fault, 0, EFAULT, NULL, NULL},
> -	{&device, &long_path, &fs_type, 0, ENAMETOOLONG, NULL, NULL},
> -	{&device, &nonexistent, &fs_type, 0, ENOENT, NULL, NULL},
> -	{&device, &file, &fs_type, 0, ENOTDIR, NULL, NULL},
> +} test_cases[] = {
> +	{&device, &mntpoint, &wrong_fs_type, "wrong FS type", 0, ENODEV, NULL, NULL},
> +	{&char_dev, &mntpoint, &fs_type, "char device", 0, ENOTBLK, NULL, NULL},
> +	{&device, &mntpoint, &fs_type, "mounted folder", 0, EBUSY, pre_mount, post_umount},
> +	{&device, &mntpoint, &fs_type, "mounted folder containing file", MS_REMOUNT | MS_RDONLY, EBUSY, pre_create_file, post_delete_file},
> +	{&null, &mntpoint, &fs_type, "invalid device", 0, EINVAL, NULL, NULL},
> +	{&device, &mntpoint, &null, "invalid device type", 0, EINVAL, NULL, NULL},
> +	{&device, &mntpoint, &fs_type, "mounted folder", MS_REMOUNT, EINVAL, NULL, NULL},
> +	{&fault, &mntpoint, &fs_type, "fault device", 0, EFAULT, NULL, NULL},
> +	{&device, &mntpoint, &fault, "fault device type", 0, EFAULT, NULL, NULL},
> +	{&device, &long_path, &fs_type, "long name", 0, ENAMETOOLONG, NULL, NULL},
> +	{&device, &nonexistent, &fs_type, "non existant folder", 0, ENOENT, NULL, NULL},
> +	{&device, &file, &fs_type, "file", 0, ENOTDIR, NULL, NULL},

I know this was used before and you just extend it, but if we use less of const
(it'd have to be casted at least for .fs_type as tst_device->fs_type is const),
we could use named constants easily:

} test_cases[] = {
	{ .fs_type = &wrong_fs_type, .desc = "wrong FS type", .exp_errno = ENODEV},
	{ .device = &char_dev, .desc = "char device", .exp_errno = ENOTBLK},
	{ .desc = "mounted folder", .exp_errno = EBUSY, .setup = pre_mount,
		.cleanup = post_umount},
	{ .desc = "mounted folder containing file", .flag = MS_REMOUNT | MS_RDONLY,
		.exp_errno = EBUSY, .setup = pre_create_file, .cleanup = post_delete_file},
	{ .device = &null, .desc = "invalid device", .exp_errno = EINVAL},
	{ .mntpoint = &null, .desc = "invalid device type", .exp_errno = EINVAL},
	{ .desc = "mounted folder", MS_REMOUNT, .exp_errno = EINVAL},
	{ .device = &fault, .desc = "fault device", .exp_errno = EFAULT},
	{ .fs_type = &fault, .desc = "fault device type", .exp_errno = EFAULT},
	{ .mntpoint = &long_path, .desc = "long name", .exp_errno = ENAMETOOLONG},
	{ .mntpoint = &nonexistent, .desc = "non existant folder", .exp_errno = ENOENT},
	{ .mntpoint = &file, .desc = "file", .exp_errno = ENOTDIR},
};

You can happily ignore that, but using field name in struct initializers is 1)
much readable 2) allows to avoid 0 and NULL. Well, we'd have to init some values in run()
- see below (or just add all of them in struct, and at least avoid 0 and  NULL, NULL).

static void run(unsigned int i)
{
	struct test_case *tc = &test_cases[i];

	if (!tc->device)
		tc->device = &device;

	if (!tc->mntpoint)
		tc->mntpoint = &mntpoint;

	if (!tc->fs_type)
		tc->fs_type = &fs_type;

...
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(test_cases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_tmpdir = 1,
no need for .needs_tmpdir

Kind regards,
Petr
> +	.format_device = 1,
> +	.mntpoint = MNTPOINT,
> +};

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
