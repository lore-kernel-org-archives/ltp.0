Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D21C0C531CA
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 12:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784810832; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=5nNGzy34wEiPZPmXFWjK9sUnhx76LQPWhgq3LoUCNFQ=;
 b=Le+1NF7cFVwqkE1nIiRMjtZoD51O9eAbarMAHEHeg6q7CCJbIduSStFAWUrGYPWUiarHV
 On5AAu3kUiHvOJVvP9gfXiF+LyoV6Ne011Bue7E2IKr1Ui9dOR1sZ/2qRzpUYGYd765jINi
 n/Gl3wQEBtljbVfv/Irkaqv7pxV8TX8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 304103E55A0
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 14:47:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 695EB3CE5F9
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:46:53 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D679B60070B
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 14:46:52 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49548aebcd8so4843485e9.3
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 05:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784810812; x=1785415612; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3sbXP2bio4l6Q6cmGKWI0PukufgTeamVwbzWIZrByU4=;
 b=JGFn4MdzYs5PB1W26kvupHWdZZWeefFvrKgDrfAojkgh9LFf/3heCxvcx2Jvc+m37y
 S4OV8HgfUSjqpgwTvTIzAQt37X6LNM1ZJvJGX7Hmk5Mm2a9AU4Dx99xfUqQdh9f6zb1M
 peJbQSlBPbNUDyhRD0MAPZlWPIHUSogCEmkJa2oN44PVLDazAvvXWjW2ki45c9h3bTAf
 ZBpJJxEZEXOgzE7TRJ7ue/6Nn+8b0FaggzrZUiWkAkhkijuBdDbdPX8E27uOPyc4y3Ut
 w3e6EZThpXO/V6RlyH6DCwZK0FPwz0GDLd+sm+X48vyXonKOvVdjPpKzwEjzdz+HdHhe
 5IVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784810812; x=1785415612;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3sbXP2bio4l6Q6cmGKWI0PukufgTeamVwbzWIZrByU4=;
 b=GNx/lpbSqqPXKN23WN4TFVBhugRJusZvfQMvsgnK2Sx77cSAlMza8bukLjXsGU91Pl
 0sCWg3SC1F/Q3THlsyN+VoB0E2bxN7y96vIkwe8Yu5qnwDaftzc+pyS47r/PxLy9g19e
 EYlaBKLsKwbFr2B8wtPlD+YqgSO5kJQtXkCLCYDlFtqP00Lb2pZElx1DZ3shQqAHskCH
 uAukW8BLhuYChkZpRnyD489pWrQ8SOk45g1lcEN3hG2jw3T56PxNUmH4bPGxr3uo5cA1
 Fqhz6eQm8LezvejzSC3nypXJRzxajipFiy4wogOmWLiyfuKdXG/buFU0G5Ya3+lO84E/
 RnTw==
X-Gm-Message-State: AOJu0Yzp8ztASrHqehK/c49AU8DRjj3KqUh9s3lg6aFvAZ1SXFch1Toi
 ZsVQQfDoqnknN9RS4VdG2nu4HHi/SqgBrWeyfUHvK7KNkJeET6xpHKfNO8+fHC4VF2yLQRqFayc
 y29GNeEJlBg==
X-Gm-Gg: AR+sD125jcC7Pevs9nt6QUsJ24x+6jZFHaQmFE85DUf2MktZZ6Bpm8yNZlGwbbvl6L7
 PZnsbK+5TYTL3hJMNel7lqO4wLTFnP25u+hoXM/4y1Ay2DcKcNDw9ysDqqlAVrY2UtfVjfdbs5v
 uQN42YOVIFdcNepRRLVC0bC/Pvgr9oNTV+1aL2fXklHem8l1n1r4N32cn/glEedrjA51jcMzlE0
 0lQPfJD1/FdEqGrcLFYIcXE2TEpTbh8eF1sHKA6yZ4WtWRBkswFezk5TFzDyk24ONSTg5JoG5x9
 JJVV7rhxjkl3FFa6g9SqWJbZj6pfKrxmWJyKpvXOF7fNCOzXwaGkcnSgoxyDlJCZoHRbI3rDzv0
 l/oyZMPjiSJpvAdKaDwgmOmRF4dLUcjX+anyq97gh3Xw0XgBJaKYiCfTms8j/StfF0R3paO+Yjn
 1Fu2nYuwuqLFkQkamqcmRosU5cyA==
X-Received: by 2002:a05:600c:1549:b0:495:64a8:c35c with SMTP id
 5b1f17b1804b1-49573cffcd0mr32481535e9.24.1784810812117; 
 Thu, 23 Jul 2026 05:46:52 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495653c8760sm204718995e9.14.2026.07.23.05.46.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 05:46:51 -0700 (PDT)
Message-ID: <6a620d3b.bf927062.8cfc4.b1e7@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260722044732.3547-4-wegao@suse.com>
Date: Thu, 23 Jul 2026 12:46:50 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v12 3/3] open16: allow restricted O_CREAT of FIFOs
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> Add LTP coverage for kernel commit 30aba6656f61 (Linux 4.19), which
> introduced protection against spoofing attacks via O_CREAT of FIFOs
> and regular files in world-writable or group-writable sticky
> directories.
> 
> This commit adds test cases to verify these security restrictions
> (Level 1 and Level 2 protections) for opening FIFOs and regular
> files in world-writable or group-writable sticky directories when the
> file is not owned by the opener.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  runtest/syscalls                          |   1 +
>  testcases/kernel/syscalls/open/.gitignore |   1 +
>  testcases/kernel/syscalls/open/open16.c   | 135 ++++++++++++++++++++++
>  3 files changed, 137 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/open/open16.c
> 
> diff --git a/runtest/syscalls b/runtest/syscalls
> index a021c79da..4fd62efa8 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1008,6 +1008,7 @@ open12 open12
>  open13 open13
>  open14 open14
>  open15 open15
> +open16 open16
>  
>  openat01 openat01
>  openat02 openat02
> diff --git a/testcases/kernel/syscalls/open/.gitignore b/testcases/kernel/syscalls/open/.gitignore
> index af5997572..d2cacc02e 100644
> --- a/testcases/kernel/syscalls/open/.gitignore
> +++ b/testcases/kernel/syscalls/open/.gitignore
> @@ -13,3 +13,4 @@
>  /open13
>  /open14
>  /open15
> +/open16
> diff --git a/testcases/kernel/syscalls/open/open16.c b/testcases/kernel/syscalls/open/open16.c
> new file mode 100644
> index 000000000..c74601032
> --- /dev/null
> +++ b/testcases/kernel/syscalls/open/open16.c
> @@ -0,0 +1,135 @@
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
> + *
> + * This test requires root to modify /proc/sys/fs/protected_* sysctls and
> + * to manage file ownership and permissions in sticky directories.
> + */
> +
> +#include <pwd.h>
> +#include <stdlib.h>
> +#include "tst_test.h"
> +#include "tst_safe_file_at.h"
> +#include "tst_uid.h"
> +
> +#define DIR "ltp_tmp_check1"
> +#define TEST_FILE "test_file_1"
> +#define TEST_FIFO "test_fifo_1"
> +#define PROTECTED_REGULAR "/proc/sys/fs/protected_regular"
> +#define PROTECTED_FIFOS "/proc/sys/fs/protected_fifos"
> +#define TEST_FIFO_PATH DIR "/" TEST_FIFO
> +
> +static int dir_fd = -1;
> +static uid_t uid1, uid2;
> +static gid_t gid1;
> +
> +static struct tcase {
> +	char *level;
> +	int exp_errno;
> +	uid_t owner_uid;
> +	int use_nobody_gid;
> +	mode_t dir_mode;
> +} tcases[] = {
> +	{"0", 0,      0,  0, 0777 | S_ISVTX},
> +	{"1", EACCES, 0,  0, 0777 | S_ISVTX},
> +	{"2", EACCES, -1, 1, 0030 | S_ISVTX},
> +};
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
> +
> +			if (TST_PASS)
> +				SAFE_CLOSE(fd);
> +
> +			fd = TST_EXP_FD(open(TEST_FIFO_PATH, O_RDWR | O_CREAT, 0777));
> +			if (TST_PASS)
> +				SAFE_CLOSE(fd);
> +		}
> +
> +		exit(0);
> +	}
> +
> +	SAFE_WAITPID(pid, NULL, 0);

not needed, we have tst_reap_children().

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
> +		{}
> +	}
> +};
> -- 
> 2.54.0
> 

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
