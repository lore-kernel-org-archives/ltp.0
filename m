Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0077BC88E5C
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 13:02:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F24BB3E806D
	for <ltp@archiver.kernel.org>; Wed, 16 Sep 2026 15:02:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F38513E18C3
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 15:01:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE37C1000931
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 15:01:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B2C7B1FE5D;
 Wed, 16 Sep 2026 13:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789563709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qdhDmB8FZbRHB/YP1I06PC+0gP0JrLJRRquEJzGdbM=;
 b=DIVfbYpd29ztq6IlbLQ72uAOWKTEb1o/Wt6lRE8ohlnyOhYclxhrH8dGU+cR1wBa8A6/wt
 VVIbzKw63tpAtepKlItIZd9gslnLCrTd033eRaxwawKShkoBKmEyEdIE3+V3Y1WXAkCVw/
 N6tG/WLlCcXLjbIDEgnaXLjat5R/tD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789563709;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qdhDmB8FZbRHB/YP1I06PC+0gP0JrLJRRquEJzGdbM=;
 b=taO6Q9t3NMHDS4tznJp5u3dRTbTJV69hs7zlMWZpCI5BxPfF99k1/kIkKgQfMau9x1fNdW
 bc/K56aFtYvlZSAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789563705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qdhDmB8FZbRHB/YP1I06PC+0gP0JrLJRRquEJzGdbM=;
 b=E2F9nr2d/1mqF3f5efGbxRCZRXj7HwwVdbpAk9RFAs4eRRGj4ssfQ2YZZbpCIaSH+r/k33
 c7kfmdyX9c8Wa33fPnhPuFFKaQilzc+qaP8AeAtXMxlzbc5HQJlJeuzQDIkyxPnSRaGk0u
 fm2e2zC/WR7WXagTZ8LgKhxDzPlVvXk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789563705;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3qdhDmB8FZbRHB/YP1I06PC+0gP0JrLJRRquEJzGdbM=;
 b=JTrJHqIoh74uI1vMSfyFFgFgmRYqJ4eyF5EZFRdZa1wnRgIIbeWnyEGiNZAdl1/ZXJLEl8
 wl6ZkejhWxv+evDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EC630136A5;
 Wed, 16 Sep 2026 13:01:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id P+F3KjiTqmpwAgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Sep 2026 13:01:44 +0000
Date: Wed, 16 Sep 2026 15:01:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20260916130139.GA1763942@pevik>
References: <20260831020028.19193-1-wegao@suse.com>
 <20260831020028.19193-4-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831020028.19193-4-wegao@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13 3/3] open16: allow restricted O_CREAT of FIFOs
 and regular files
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

Hi Wei,

> Add LTP coverage for kernel commit 30aba6656f61 (Linux 4.19), which
> introduced protection against spoofing attacks via O_CREAT of FIFOs
> and regular files in world-writable or group-writable sticky
> directories.

> This commit adds test cases to verify these security restrictions
> (Level 1 and Level 2 protections) for opening FIFOs and regular
> files in world-writable or group-writable sticky directories when the
> file is not owned by the opener.

I was thinking what level you're talking about.
...
> diff --git a/testcases/kernel/syscalls/open/open16.c b/testcases/kernel/syscalls/open/open16.c
> new file mode 100644
> index 000000000..3d29a56ca
> --- /dev/null
> +++ b/testcases/kernel/syscalls/open/open16.c
> @@ -0,0 +1,133 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2026 Wei Gao <wegao@suse.com>
> + */
> +
> +/*\
> + * Verify restricted opening (:manpage:`open(2)` and :manpage:`openat(2)`) of
> + * FIFOs and regular files in sticky directories. This test covers the positive
> + * case where access is allowed when protection is disabled (level 0), and the
> + * negative cases where access is disallowed (EACCES) in world-writable (level
> + * 1) or group-writable (level 2) sticky directories when the file is not owned
> + * by the opener.

Even here it's not clear. Could you just mention that these are
/proc/sys/fs/protected_fifos values? man proc_sys_fs(5) which document it does
not talk about levels at all.

> + *
> + * This test requires root to modify /proc/sys/fs/protected_* sysctls and
> + * to manage file ownership and permissions in sticky directories.
> + */
> +
...
> +#define PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
> +#define PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"

Could you please add these 2 into include/tst_path_defs.h?

> +#define TEST_FIFO_PATH DIR "/" TEST_FIFO
> +
> +static int dir_fd = -1;
> +static uid_t uid1, uid2;
> +static gid_t gid1;
> +
> +static struct tcase {
> +	char *level;
How about define level as int?

I would even not define it and use unsigned int n in verify_open() since the
values are the same, but up to you.

> +	int exp_errno;
> +	uid_t owner_uid;
> +	int use_nobody_gid;
> +	mode_t dir_mode;
> +} tcases[] = {
> +	{"0", 0,      0,  0, 0777 | S_ISVTX},
> +	{"1", EACCES, 0,  0, 0777 | S_ISVTX},
> +	{"2", EACCES, -1, 1, 0030 | S_ISVTX},
> +};

I usually prefer using designated initializers to
1) not having to specify 0
2) 

> +
> +static void verify_open(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	pid_t pid;
> +
> +	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%s", tc->level);
> +	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%s", tc->level);
> +
> +	if (tc->owner_uid != (uid_t)-1 || tc->use_nobody_gid) {
> +		gid_t gid = tc->use_nobody_gid ? gid1 : 0;
> +
> +		SAFE_CHOWN(DIR, tc->owner_uid, gid);
> +	}
> +
> +	if (tc->dir_mode)
> +		SAFE_CHMOD(DIR, tc->dir_mode);
> +
> +	pid = SAFE_FORK();
> +	if (!pid) {

How about:
1) using SAFE_FORK() directly
2) return for parent to save indent (readability)

	if (SAFE_FORK())
		return;

	SAFE_SETGID(gid1);
	SAFE_SETUID(uid2);
	...

> +		SAFE_SETGID(gid1);
> +		SAFE_SETUID(uid2);
> +
> +		if (tc->exp_errno) {
> +			TST_EXP_FAIL2(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
> +				      tc->exp_errno, "openat %s (Level %s)", TEST_FILE, tc->level);
> +			TST_EXP_FAIL2(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
> +				      tc->exp_errno, "open %s (Level %s)", TEST_FIFO, tc->level);
> +		} else {
> +			int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
nit: we don't have to define fd when it's not used, we can use TST_RET.
> +
> +			if (TST_PASS)
> +				SAFE_CLOSE(fd);
> +
> +			fd = TST_EXP_FD(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777));
> +			if (TST_PASS)
> +				SAFE_CLOSE(fd);
> +		}

This else branch use the same code, how about to use TST_EXP_FD_OR_FAIL()?

	TST_EXP_FD_OR_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
			  tc->exp_errno, "openat %s (Level %s)", TEST_FILE, tc->level);
	if (TST_RET != -1)
		SAFE_CLOSE(TST_RET);

	TST_EXP_FD_OR_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
			  tc->exp_errno, "open %s (Level %s)", TEST_FIFO, tc->level);
	if (TST_RET != -1)
		SAFE_CLOSE(TST_RET);

@Cyril @Li: I always wondered if TST_EXP_FD_OR_FAIL() should use TST_EXP_FAIL2().

> +
> +		exit(0);
I guess we need to bother with exit(0) at this point, right?

> +	}
> +}
> +
> +static void setup(void)
> +{
> +	struct passwd *pw;
> +
> +	pw = SAFE_GETPWNAM("nobody");
> +	uid1 = pw->pw_uid;
> +	gid1 = pw->pw_gid;
> +	uid2 = tst_get_free_uid(uid1);
> +
> +	umask(0);
> +	SAFE_MKDIR(DIR, 0777 | S_ISVTX);
> +	dir_fd = SAFE_OPEN(DIR, O_DIRECTORY);
> +
> +	int fd = SAFE_OPENAT(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777);
> +
> +	SAFE_CLOSE(fd);
> +	SAFE_MKFIFO(TEST_FIFO_PATH, 0777);
> +	SAFE_CHOWN(TEST_FIFO_PATH, uid1, gid1);
> +	SAFE_CHOWN(DIR "/" TEST_FILE, uid1, gid1);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (dir_fd != -1)
> +		SAFE_CLOSE(dir_fd);
> +}
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.tcnt = ARRAY_SIZE(tcases),
> +	.test = verify_open,
> +	.needs_tmpdir = 1,
> +	.forks_child = 1,
> +	.save_restore = (const struct tst_path_val[]) {
> +		{PROTECTED_REGULAR, NULL, TST_SR_TCONF},
> +		{PROTECTED_FIFOS, NULL, TST_SR_TCONF},
> +		{}
> +	},
> +	.tags = (const struct tst_tag[]) {
> +		{"linux-git", "30aba6656f61"},
30aba6656f61 notes many CVEs, IMHO we should add them as well:

    CVE-2000-1134
    CVE-2007-3852
    CVE-2008-0525
    CVE-2009-0416
    CVE-2011-4834
    CVE-2015-1838
    CVE-2015-7442
    CVE-2016-7489

> +		{}
> +	}
> +};

Feel free to speedup with this (still TODO CVE and using int for "level").

Kind regards,
Petr

diff --git testcases/kernel/syscalls/open/open16.c testcases/kernel/syscalls/open/open16.c
index 3d29a56ca7..0741102103 100644
--- testcases/kernel/syscalls/open/open16.c
+++ testcases/kernel/syscalls/open/open16.c
@@ -47,7 +47,6 @@ static struct tcase {
 static void verify_open(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
-	pid_t pid;
 
 	SAFE_FILE_PRINTF(PROTECTED_REGULAR, "%s", tc->level);
 	SAFE_FILE_PRINTF(PROTECTED_FIFOS, "%s", tc->level);
@@ -61,29 +60,21 @@ static void verify_open(unsigned int n)
 	if (tc->dir_mode)
 		SAFE_CHMOD(DIR, tc->dir_mode);
 
-	pid = SAFE_FORK();
-	if (!pid) {
-		SAFE_SETGID(gid1);
-		SAFE_SETUID(uid2);
+	if (SAFE_FORK())
+		return;
 
-		if (tc->exp_errno) {
-			TST_EXP_FAIL2(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
-				      tc->exp_errno, "openat %s (Level %s)", TEST_FILE, tc->level);
-			TST_EXP_FAIL2(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
-				      tc->exp_errno, "open %s (Level %s)", TEST_FIFO, tc->level);
-		} else {
-			int fd = TST_EXP_FD(openat(dir_fd, TEST_FILE, O_CREAT | O_RDWR, 0777));
+	SAFE_SETGID(gid1);
+	SAFE_SETUID(uid2);
 
-			if (TST_PASS)
-				SAFE_CLOSE(fd);
+	TST_EXP_FD_OR_FAIL(openat(dir_fd, TEST_FILE, O_RDWR | O_CREAT, 0777),
+			  tc->exp_errno, "openat %s (Level %s)", TEST_FILE, tc->level);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
 
-			fd = TST_EXP_FD(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777));
-			if (TST_PASS)
-				SAFE_CLOSE(fd);
-		}
-
-		exit(0);
-	}
+	TST_EXP_FD_OR_FAIL(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777),
+			  tc->exp_errno, "open %s (Level %s)", TEST_FIFO, tc->level);
+	if (TST_RET != -1)
+		SAFE_CLOSE(TST_RET);
 }
 
 static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
