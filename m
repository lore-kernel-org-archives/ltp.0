Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE0F4C433EF
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 16:44:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56F113CAAA6
	for <ltp@archiver.kernel.org>; Fri, 15 Jul 2022 18:44:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EB6E3CA360
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 18:44:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 00FF214002DD
 for <ltp@lists.linux.it>; Fri, 15 Jul 2022 18:44:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 267B21FB88;
 Fri, 15 Jul 2022 16:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657903463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPeuho+Aw0qFa+5lyYrl3zosSd0Yq2DjdMvZRSBJiDg=;
 b=KruQyu23Hzhw14r6n43R1CObgAhJRqUYe8heAxLyA/OwWX1eGo8DsNiKH7Femykk6Ohrq6
 ycjM++xi0eY1uIxTpWiaHO+p96l8o+pUf6U/BIzOyLJNTOmFPv7kjKwk6VyjIgBDCspkgU
 ZZEwgS8TmJ2iJSvVHRzK6txkC1JJSkk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657903463;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gPeuho+Aw0qFa+5lyYrl3zosSd0Yq2DjdMvZRSBJiDg=;
 b=phLES+uP6xADDwqsEmvLT4Vwj841/obBPimn7hC4LhNXPMz6qPN5ihqDpFA1uZOevZmDJQ
 ykwnFXO6zgbg6yDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF46613754;
 Fri, 15 Jul 2022 16:44:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H637NGaZ0WKmdgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Jul 2022 16:44:22 +0000
Date: Fri, 15 Jul 2022 18:44:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "chenhx.fnst@fujitsu.com" <chenhx.fnst@fujitsu.com>
Message-ID: <YtGZZeUm2iB/uySr@pevik>
References: <20220715062519.2480-1-chenhx.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220715062519.2480-1-chenhx.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mount03: Convert to new API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Chen,

quite nice work, but more cleanup is needed.

>  testcases/kernel/syscalls/mount/mount03.c | 462 ++++++++--------------
...
>  #define FILE_MODE	(S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
> -#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
> -			 S_IXGRP|S_IROTH|S_IXOTH)
>  #define SUID_MODE	(S_ISUID|S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH)

@Richie @Li @Metan: There are checkpatch.pl warnings. Yes, kernel folks does not
like permission warnings. Do we want to follow? Or should we remove these from
our checkpatch.pl fork (we use constants in many places)?

$ make check-mount03
mount03.c:29: WARNING: Symbolic permissions 'S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH' are not preferred. Consider using octal permissions '0644'.
mount03.c:30: WARNING: Symbolic permissions 'S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH' are not preferred. Consider using octal permissions '0511'.
mount03.c:50: WARNING: static char array declaration should probably be static const char
mount03.c:103: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
mount03.c:114: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
mount03.c:125: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
mount03.c:181: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
mount03.c:204: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.

...
> +#define MNTPOINT        "mntpoint"
...
> +static char nobody_uid[] = "nobody";
I'd remove constant and use "nobody" in the setup (the same like creat08.c).
If we want to have it defined, I'd use #define (like you use it in MNTPOINT).

Also your code produces warning:
mount03.c:50: WARNING: static char array declaration should probably be static const char

...
> +static int test_ms_nosuid(void)
...
> +	int pid, status;
pid_t pid; // don't use int for pid please.

This is not needed (-1 is handled by SAFE_FORK()), therefore you don't need
switch.

For a readability, your code (most of inherited from the original) is:
static int test_ms_nosuid(void)
{
	int pid, status;

	switch (pid = SAFE_FORK()) {
	case -1:
		tst_brk(TFAIL | TERRNO, "fork failed");
		break;
	case 0:
		SAFE_SETREUID(ltpuser->pw_uid, ltpuser->pw_uid);

		execlp(file, basename(file), NULL);
		exit(1);
	default:
		waitpid(pid, &status, 0);
		if (WIFEXITED(status)) {
			/* reset the setup_uid */
			if (status)
				return 0;
		}
		return 1;
	}
	return 0;
}

* I'm not sure why exit(1),
* we have SAFE_EXECLP. Therefore something like:


static void test_ms_nosuid(void)
{
	int status;
	pid_t pid;

	pid = SAFE_FORK();

	if (!pid) {
		SAFE_SETREUID(ltpuser->pw_uid, ltpuser->pw_uid);
		SAFE_EXECLP(file, basename(file), NULL);
	}

	SAFE_WAITPID(pid, &status, 0);
}

But SAFE_WAITPID() would not allow to print TPASS/TFAIL.

> -/*
> - * test_rwflag(int i, int cnt)
> - * Validate the mount system call for rwflags.
> - */
> -int test_rwflag(int i, int cnt)
> +static void test_rwflag(int i)
Instead of a crazy long switch which is in the original code, we prefer to
use functions which are put into struct tcase via function pointer. See e.g.
mq_open01.c for example.


...
> +		snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);
> +		TEST(test_ms_nosuid());
Please don't reuse TEST() macro for normal function. Just call it:

> +		if (TST_RET == 0)
> +			tst_res(TPASS, "mount(2) passed with flag MS_NOSUID");
> +		else
> +			tst_res(TFAIL, "mount(2) failed with flag MS_NOSUID");
There is TST_EXP_PASS() macro:
TST_EXP_PASS(test_ms_nosuid())
if (!TST_PASS)
		return;

But, please don't reuse TEST() macro for normal function. These are meant to be
for syscalls testing, here I'd print TPASS/TFAIL in test_ms_nosuid() and make it
void.

...
> +static void setup(void)
> +{
> +	struct stat file_stat = {0};

> +	ltpuser = getpwnam(nobody_uid);
ltpuser = SAFE_GETPWNAM("nobody");
(or use constant, but SAFE_GETPWNAM is required (no check, see creat08.c)

> +	if (ltpuser == NULL)
> +		tst_res(TFAIL, "getpwnam failed");
> +	snprintf(file, PATH_MAX, "%s/mount03_setuid_test", MNTPOINT);

> +	SAFE_STAT(MNTPOINT, &file_stat);
>  	if (file_stat.st_mode != SUID_MODE &&
> -	    chmod(file, SUID_MODE) < 0)
> -		tst_brkm(TBROK, cleanup,
> -			 "setuid for setuid_test failed");
> -	SAFE_UMOUNT(cleanup, mntpoint);
> -
> -	TEST_PAUSE;
> +	    chmod(MNTPOINT, SUID_MODE) < 0)
> +		tst_res(TFAIL, "setuid for setuid_test failed");
Please use tst_brk(TBROK, ...), original version has tst_brkm(TBROK, ...) for a
reason [1]:
1) tst_brk quits testing, which is usually required in setup function
2) TBROK is usually used instead of TFAIL in setup function

TBROK: Something has failed in test preparation phase.
TFAIL: Test has failed.

(This description should have been in LTP Test Writing Guidelines [2],
because it applies to both C and shell API.)


...
> +static struct tst_test test = {
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.format_device = 1,
> +	.resource_files = resource_files,

Please inline resource files like:
	.resource_files = (const char *const[]) {
		"mount03_setuid_test",
		NULL,
	},

It produces "mount03_setuid_test" in doc [3]:

| .resource_files | mount03_setuid_test |

But using .resource_files = resource_files produces just "resource_files":
| .resource_files | resource_files |

(to make doc locally: cd metadata && make # result is in ../docparse/metadata.html)

> +	.forks_child = 1,
> +	.mntpoint = MNTPOINT,
> +	.skip_filesystems = (const char *const []){"fuse", NULL},
Why you introduced skipping on FUSE? I don't see it in the old code, nothing
mentioned in commit message).

Also when I test it for all filesystems (which could be a good idea for mount
test) it fails for vfat, exfat and ntfs:

	.skip_filesystems = (const char *const []){"vfat", "exfat", "ntfs", NULL},
	.all_filesystems = 1,

Skipping just fuse does not help in my case:

tst_test.c:1599: TINFO: Testing on ntfs
tst_test.c:1064: TINFO: Formatting /dev/loop3 with ntfs opts='' extra opts=''
The partition start sector was not specified for /dev/loop3 and it could not be obtained automatically.  It has been set to 0.
The number of sectors per track was not specified for /dev/loop3 and it could not be obtained automatically.  It has been set to 0.
The number of heads was not specified for /dev/loop3 and it could not be obtained automatically.  It has been set to 0.
To boot from a device, Windows needs the 'partition start sector', the 'sectors per track' and the 'number of heads' to be set.
Windows will not be able to boot from this device.
mount03.c:102: TFAIL: mount(2) passed with flag MS_RDONLY: open fail with EROFS as expected succeeded
tst_device.c:394: TWARN: umount('mntpoint') failed with EINVAL
mount03.c:237: TBROK: umount(mntpoint) failed: EINVAL (22)

tst_test.c:1599: TINFO: Testing on exfat
tst_test.c:1064: TINFO: Formatting /dev/loop2 with exfat opts='' extra opts=''
mount03.c:102: TPASS: mount(2) passed with flag MS_RDONLY: open fail with EROFS as expected : EROFS (30)
mount03.c:112: TBROK: mknod() failed: EPERM (1)

tst_test.c:1599: TINFO: Testing on vfat
tst_test.c:1064: TINFO: Formatting /dev/loop1 with vfat opts='' extra opts=''
mount03.c:102: TPASS: mount(2) passed with flag MS_RDONLY: open fail with EROFS as expected : EROFS (30)
mount03.c:112: TBROK: mknod() failed: EPERM (1)

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API#12-basic-test-interface
[2] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines
[3] http://linux-test-project.github.io/metadata/metadata.stable.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
