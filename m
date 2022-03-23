Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6C10C433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 17:54:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B2CC3C94CC
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 18:54:23 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 537063C0358
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 18:54:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7BC346009FC
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 18:54:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0FE1E210F4;
 Wed, 23 Mar 2022 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648058050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1btWoTDW5ucAcByD/qlC3Y+wxPfg3au8NOOMfzttFpE=;
 b=mPkoqrkI7cJR218AIlr20wiPQcYfRHc4BCDzNMnCAw/QYqrvEhYWW5I8wdBgR/zwCyWD0L
 +PtfTxJOMJjbkQAxYU4O+mDQUhi7ERq5BMJ3JEM71gjyrzoVFZS8bm6hj1xCWenU1Hq1Dl
 lgkPTbnEG/hNB6vGuVENZ9T+/9BW1aA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648058050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1btWoTDW5ucAcByD/qlC3Y+wxPfg3au8NOOMfzttFpE=;
 b=mvdvCW/6Vh/fH1s4ZJfaWUy0YjSjezU5gkabaUYfd0MCodp8zoddGpCEayUJx35hMMRjzo
 Q+G06CKrdyhD43CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F079812FC5;
 Wed, 23 Mar 2022 17:54:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Nup9OcFeO2LYLAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 23 Mar 2022 17:54:09 +0000
Date: Wed, 23 Mar 2022 18:56:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YjtfTHjUHeHvSTgG@yuki>
References: <20220315134122.22912-1-rpalethorpe@suse.com>
 <20220315134122.22912-2-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220315134122.22912-2-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cgroups: Add first IO controller test
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
> In V1 there is the blkio controller. This was renamed to just io on
> V2. The interface and functionality is significantly
> different. Presently there do not appear to be any tests for the V2
> controller.
> 
> Note that one can not simply stat a file on BTRFS to find the actual
> block device the filesystem is using. Nor can you read
> /proc/self/mountinfo. BTRFS seems to generate "anonymous"
> devices (e.g. 0:27) and this is what is reported by stat. These
> however are invisible to the IO controller.
> 
> So instead we have to look in /proc/mounts for the device path then
> stat the special (/dev/<device>) file to get the actual major and
> minor device number.
> 
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
>  runtest/controllers                           |   3 +
>  testcases/kernel/controllers/io/.gitignore    |   1 +
>  testcases/kernel/controllers/io/Makefile      |   6 +
>  .../kernel/controllers/io/io_control01.c      | 162 ++++++++++++++++++
>  4 files changed, 172 insertions(+)
>  create mode 100644 testcases/kernel/controllers/io/.gitignore
>  create mode 100644 testcases/kernel/controllers/io/Makefile
>  create mode 100644 testcases/kernel/controllers/io/io_control01.c
> 
> diff --git a/runtest/controllers b/runtest/controllers
> index 3108a2561..22d482050 100644
> --- a/runtest/controllers
> +++ b/runtest/controllers
> @@ -360,6 +360,9 @@ cpuset_regression_test cpuset_regression_test.sh
>  
>  cgroup_xattr	cgroup_xattr
>  
> +# V2 IO controller (was blkio)
> +io_control01 io_control01
> +
>  pids_1_1 pids.sh 1 1 0
>  pids_1_2 pids.sh 1 2 0
>  pids_1_10 pids.sh 1 10 0
> diff --git a/testcases/kernel/controllers/io/.gitignore b/testcases/kernel/controllers/io/.gitignore
> new file mode 100644
> index 000000000..d626fa80d
> --- /dev/null
> +++ b/testcases/kernel/controllers/io/.gitignore
> @@ -0,0 +1 @@
> +io_control01
> diff --git a/testcases/kernel/controllers/io/Makefile b/testcases/kernel/controllers/io/Makefile
> new file mode 100644
> index 000000000..5ea7d67db
> --- /dev/null
> +++ b/testcases/kernel/controllers/io/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +
> +top_srcdir		?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/controllers/io/io_control01.c b/testcases/kernel/controllers/io/io_control01.c
> new file mode 100644
> index 000000000..706e67c89
> --- /dev/null
> +++ b/testcases/kernel/controllers/io/io_control01.c
> @@ -0,0 +1,162 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* [Description]

This is not the correct docparse hearder.

> + * Perform some I/O on a file and check if at least some of it is
> + * recorded by the I/O controller.
> + *
> + * The exact amount of I/O performed is dependent on the file system,
> + * page cache, scheduler and block driver. We call sync and drop the
> + * file's page cache to force reading and writing. We also write
> + * random data to try to prevent compression.
> + *
> + * The pagecache is a particular issue for reading. If the call to
> + * fadvise is ignored then the data may only be read from the
> + * cache. So that no I/O requests are made.
> + */
> +
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <sys/sysmacros.h>
> +#include <mntent.h>
> +
> +#include "tst_test.h"
> +
> +static unsigned int dev_major, dev_minor;
> +
> +static void run(void)
> +{
> +	int i, fd;
> +	char *line, *buf_ptr;
> +	const size_t pgsz = SAFE_SYSCONF(_SC_PAGESIZE);
> +	char *buf = SAFE_MALLOC(MAX((size_t)BUFSIZ, pgsz));
> +	unsigned long st_rbytes = 0, st_wbytes = 0, st_rios = 0, st_wios = 0;
> +
> +	SAFE_CG_READ(tst_cg, "io.stat", buf, BUFSIZ - 1);
> +	line = strtok_r(buf, "\n", &buf_ptr);
> +	while (line) {
> +		unsigned int mjr, mnr;
> +		unsigned long dbytes, dios;
> +
> +		const int convs =
> +			sscanf(line,
> +			       "%u:%u rbytes=%lu wbytes=%lu rios=%lu wios=%lu dbytes=%lu dios=%lu",
> +			       &mjr, &mnr, &st_rbytes, &st_wbytes, &st_rios, &st_wios,
> +			       &dbytes, &dios);
> +
> +		if (convs < 2)
> +			continue;
> +
> +		tst_res(TINFO, "Found %u:%u in io.stat", dev_major, dev_minor);
> +
> +		if (mjr == dev_major || mnr == dev_minor)
> +			break;
> +
> +		line = strtok_r(NULL, "\n", &buf_ptr);
> +	}
> +
> +	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
> +
> +	fd = SAFE_OPEN("/dev/urandom", O_RDONLY, 0600);
> +	SAFE_READ(1, fd, buf, pgsz);
> +	SAFE_CLOSE(fd);
> +
> +	fd = SAFE_OPEN("mnt/dat", O_WRONLY | O_CREAT, 0600);
> +
> +	for (i = 0; i < 4; i++) {
> +		SAFE_WRITE(1, fd, buf, pgsz);
> +		SAFE_FSYNC(fd);
> +		TST_EXP_PASS_SILENT(posix_fadvise(fd, pgsz * i, pgsz, POSIX_FADV_DONTNEED));
> +	}
> +
> +	SAFE_CLOSE(fd);
> +	fd = SAFE_OPEN("mnt/dat", O_RDONLY, 0600);
> +
> +	for (i = 0; i < 4; i++)
> +		SAFE_READ(1, fd, buf, pgsz);
> +
> +	tst_res(TPASS, "Did some IO in the IO controller");
> +
> +	SAFE_CG_READ(tst_cg, "io.stat", buf, BUFSIZ - 1);
> +	line = strtok_r(buf, "\n", &buf_ptr);
> +	while (line) {
> +		unsigned int mjr, mnr;
> +		unsigned long rbytes, wbytes, rios, wios, dbytes, dios;
> +
> +		const int convs =
> +			sscanf(line,
> +			       "%u:%u rbytes=%lu wbytes=%lu rios=%lu wios=%lu dbytes=%lu dios=%lu",
> +			       &mjr, &mnr, &rbytes, &wbytes, &rios, &wios,
> +			       &dbytes, &dios);
> +
> +		if (convs < 8)
> +			break;
> +
> +		if (mjr != dev_major || mnr != dev_minor) {
> +			line = strtok_r(NULL, "\n", &buf_ptr);
> +			continue;
> +		}
> +
> +		tst_res(TPASS, "Found %u:%u in io.stat", dev_major, dev_minor);
> +		TST_EXP_EXPR(rbytes > st_rbytes, "(rbytes=%lu) > (st_rbytes=%lu)", rbytes, st_rbytes);
> +		TST_EXP_EXPR(wbytes > st_wbytes, "(wbytes=%lu) > (st_wbytes=%lu)", wbytes, st_wbytes);
> +		TST_EXP_EXPR(rios > st_rios, "(rios=%lu) > (st_rios=%lu)", rios, st_rios);
> +		TST_EXP_EXPR(wios > st_wios, "(wios=%lu) > (st_wios=%lu)", wios, st_wios);

So we only test here that the counters are updated, that sounds fine for
a simple test.

Do you plan to try anything for io.max? Maybe something as basic as
running two concurent processes with very different limits and checking
that the more limited process transfer less bytes per unit of time?

> +		goto out;
> +	}

We do have two very similar copies of this parsing code, maybe we should
put that into a function, and pack the parameters into a structure o
avoid copy&paste like this. e.g.

struct iostats {
	unsigned long st_rbytes;
	unsigned long st_wbytes;
	unsigned long st_rios;
	unsigned long st_wios;
};

static int read_iostats(const char *stats,
                        unsigned int dev_min, unsigned int dev_maj,
			struct iostats *iostats);


> +	tst_res(TINFO, "io.stat:\n%s", buf);
> +	tst_res(TFAIL, "Did not find %u:%u in io.stat", dev_major, dev_minor);
> +out:
> +	free(buf);
> +	SAFE_CLOSE(fd);
> +	SAFE_UNLINK("mnt/dat");
> +}
> +
> +static void setup(void)
> +{
> +	char buf[PATH_MAX] = { 0 };
> +	char *path = SAFE_GETCWD(buf, PATH_MAX - sizeof("mnt") - 1);
> +	struct mntent *mnt;
> +	FILE *mntf = setmntent("/proc/self/mounts", "r");
> +	struct stat st;
> +
> +	strcpy(path + strlen(path), "/mnt");
> +
> +	if (!mntf) {
> +		tst_brk(TBROK | TERRNO, "Can't open /proc/self/mounts");
> +		return;
> +	}
> +
> +	mnt = getmntent(mntf);
> +	if (!mnt) {
> +		tst_brk(TBROK | TERRNO, "Can't read mounts or no mounts?");
> +		return;
> +	}
> +
> +	do {
> +		if (strcmp(mnt->mnt_dir, path))
> +			continue;
> +
> +		SAFE_STAT(mnt->mnt_fsname, &st);
> +		dev_major = major(st.st_rdev);
> +		dev_minor = minor(st.st_rdev);
> +
> +		return;
> +
> +	} while ((mnt = getmntent(mntf)));

I guess that this should probably go to the test library. We already
have tst_find_backding_dev() in there which is doing something a bit
similar. Looking at the code what we do here is to translate a
mountpoint into a device so it may be something as:

int tst_find_dev_by_mntpoint()

> +	tst_brk(TBROK, "Could not find mount device");
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.needs_device = 1,
> +	.mntpoint = "mnt",
> +	.mount_device = 1,
> +	.all_filesystems = 1,
> +	.skip_filesystems = (const char *const[]){ "ntfs", "tmpfs", NULL },
> +	.needs_cgroup_ver = TST_CG_V2,
> +	.needs_cgroup_ctrls = (const char *const[]){ "io", NULL },
> +};
> -- 
> 2.35.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
