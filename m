Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89058C77B73
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 14:40:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B8823CD3A6
	for <ltp@archiver.kernel.org>; Mon, 22 May 2023 16:40:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B9E973CB0C9
 for <ltp@lists.linux.it>; Mon, 22 May 2023 16:40:23 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id F1C402005DE
 for <ltp@lists.linux.it>; Mon, 22 May 2023 16:40:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9460321D24;
 Mon, 22 May 2023 14:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1684766421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WjZgynBcIC4h5iTaS7FblodZYuzhhbmba9yw11HFlE=;
 b=FWlWgfVR8eC4nVOgsaqKJA2ODPrSJMS0ac+l33pDqNT1gx2sY30QcwWhcBCnuTOMI1QW1F
 GJnNpTVnj30iBdS+5nSeBoVGG+RHBXn6K3Rv3SoviDWvgFZAyzwI/4m40aXwjmozLd/STc
 Rn+fxBI2EWq2BGo1gP6YV8rzKqA7mvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1684766421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1WjZgynBcIC4h5iTaS7FblodZYuzhhbmba9yw11HFlE=;
 b=pGFfLS97eHAqkpKxPU1N1NarhrR7MMWkFsMmS8ROge/KF/BSaxtUkQU57GRM2APGKK6ZBn
 LVZ0+m+qitSqoUDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7F58A13776;
 Mon, 22 May 2023 14:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id G1LjHNV+a2SvJgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 May 2023 14:40:21 +0000
Date: Mon, 22 May 2023 16:41:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZGt_GrwbwPJChf6P@yuki>
References: <20230510124206.19627-1-andrea.cervesato@suse.de>
 <20230510124206.19627-4-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230510124206.19627-4-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 3/6] Refactor mqns_03 using new LTP API
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
> +#include "tst_test.h"
> +#include "lapi/sched.h"
> +#include "tst_safe_posix_ipc.h"
> +#include "tst_safe_stdio.h"
> +
> +#define CHECK_MQ_OPEN_RET(x) ((x) >= 0 || ((x) == -1 && errno != EMFILE))
> +
> +#define MQNAME1 "/MQ1"
> +#define MQNAME2 "/MQ2"
> +
> +static char *str_op;
> +static char *devdir;
> +static char *mqueue1;
> +static char *mqueue2;
> +static int *mq_freed1;
> +static int *mq_freed2;
> +
> +static void check_mqueue(void)
>  {
> -	char buf[30];
> -	mqd_t mqd;
>  	int rc;
> +	mqd_t mqd;
>  	struct stat statbuf;
>  
> -	(void) vtest;
> +	tst_res(TINFO, "Creating %s mqueue from within child process", MQNAME1);
>  
> -	close(p1[1]);
> -	close(p2[0]);
> +	mqd = TST_RETRY_FUNC(
> +		mq_open(MQNAME1, O_RDWR | O_CREAT | O_EXCL, 0777, NULL),
> +		CHECK_MQ_OPEN_RET);
> +	if (mqd == -1)
> +		tst_brk(TBROK | TERRNO, "mq_open failed");
>  
> -	if (read(p1[0], buf, 3) != 3) {	/* go */
> -		perror("read failed");
> -		exit(1);
> -	}
> +	SAFE_MQ_CLOSE(mqd);
> +	tst_atomic_inc(mq_freed1);

I do not think that we need atomicity here, the cleanup code does not
run concurently at all as the cleanup in the parent is triggered after
the child did exit. I suppose that instead we need to set the mq_freed
to be volatile because it's shared memory which may change at any
change, so we need to tell that to the compiler.

> -	mqd = tst_syscall(__NR_mq_open, NOSLASH_MQ1, O_RDWR | O_CREAT | O_EXCL,
> -		0755, NULL);
> -	if (mqd == -1) {
> -		write(p2[1], "mqfail", 7);
> -		exit(1);
> -	}
> +	tst_res(TINFO, "Mount %s from within child process", devdir);
>  
> -	mq_close(mqd);
> +	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
>  
> -	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
> -	if (rc == -1) {
> -		write(p2[1], "mount1", 7);
> -		exit(1);
> -	}
> +	SAFE_STAT(mqueue1, &statbuf);
> +	tst_res(TPASS, "%s exists at first mount", mqueue1);
>  
> -	rc = stat(FNAM1, &statbuf);
> -	if (rc == -1) {
> -		write(p2[1], "stat1", 6);
> -		exit(1);
> -	}
> +	tst_res(TINFO, "Creating %s from within child process", mqueue2);
>  
> -	rc = creat(FNAM2, 0755);
> -	if (rc == -1) {
> -		write(p2[1], "creat", 6);
> -		exit(1);
> -	}
> +	rc = SAFE_CREAT(mqueue2, 0755);
> +	SAFE_CLOSE(rc);
> +	tst_atomic_inc(mq_freed2);
>  
> -	close(rc);
> +	tst_res(TINFO, "Mount %s from within child process a second time", devdir);
>  
> -	rc = umount(DEV_MQUEUE2);
> -	if (rc == -1) {
> -		write(p2[1], "umount", 7);
> -		exit(1);
> -	}
> +	SAFE_UMOUNT(devdir);
> +	SAFE_MOUNT("mqueue", devdir, "mqueue", 0, NULL);
>  
> -	rc = mount("mqueue", DEV_MQUEUE2, "mqueue", 0, NULL);
> -	if (rc == -1) {
> -		write(p2[1], "mount2", 7);
> -		exit(1);
> -	}
> +	SAFE_STAT(mqueue1, &statbuf);
> +	tst_res(TPASS, "%s exists at second mount", mqueue1);
>  
> -	rc = stat(FNAM1, &statbuf);
> -	if (rc == -1) {
> -		write(p2[1], "stat2", 7);
> -		exit(1);
> -	}
> +	SAFE_STAT(mqueue2, &statbuf);
> +	tst_res(TPASS, "%s exists at second mount", mqueue2);
>  
> -	rc = stat(FNAM2, &statbuf);
> -	if (rc == -1) {
> -		write(p2[1], "stat3", 7);
> -		exit(1);
> -	}
> +	SAFE_UMOUNT(devdir);
> +
> +	SAFE_MQ_UNLINK(MQNAME1);
> +	tst_atomic_store(0, mq_freed1);
>  
> -	write(p2[1], "done", 5);
> +	SAFE_MQ_UNLINK(MQNAME2);
> +	tst_atomic_store(0, mq_freed2);
> +}
>  
> -	exit(0);
> +static void run(void)
> +{
> +	const struct tst_clone_args clone_args = { CLONE_NEWIPC, SIGCHLD };
> +
> +	if (str_op && !strcmp(str_op, "clone")) {
> +		tst_res(TINFO, "Spawning isolated process");
> +
> +		if (!SAFE_CLONE(&clone_args)) {
> +			check_mqueue();
> +			return;
> +		}
> +	} else if (str_op && !strcmp(str_op, "unshare")) {
> +		tst_res(TINFO, "Spawning unshared process");
> +
> +		if (!SAFE_FORK()) {
> +			SAFE_UNSHARE(CLONE_NEWIPC);
> +			check_mqueue();
> +			return;
> +		}
> +	}
>  }
>  
>  static void setup(void)
>  {
> -	tst_require_root();
> -	check_mqns();
> +	char *tmpdir;
> +
> +	if (!str_op)
> +		tst_brk(TCONF, "Please specify clone|unshare child isolation");
> +
> +	tmpdir = tst_get_tmpdir();
> +
> +	SAFE_ASPRINTF(&devdir, "%s/mqueue", tmpdir);
> +	SAFE_MKDIR(devdir, 0755);
> +
> +	SAFE_ASPRINTF(&mqueue1, "%s" MQNAME1, devdir);
> +	SAFE_ASPRINTF(&mqueue2, "%s" MQNAME2, devdir);
> +
> +	mq_freed1 = SAFE_MMAP(NULL,
> +		sizeof(int),
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);
> +
> +	mq_freed2 = SAFE_MMAP(NULL,
> +		sizeof(int),
> +		PROT_READ | PROT_WRITE,
> +		MAP_SHARED | MAP_ANONYMOUS,
> +		-1, 0);

So here you are allocating two pages of memory for something that is
basically two bitflags. Can you at least change this to a single mmap()
something as:

static int *mq_freed;

	mq_freed = SAFE_MMAP(NULL, 2 * sizeof(int), ...)


	mq_freed[0] = 1;
	...

Moreover since we can actually stat()/access() the mqueue we can as well
check for the existence of the devdir in the cleanup and only remove it
if it exists in the filesystem.

Also I would be more afraid of the mqueue filesystem being mounted in
the temp directory if we trigger a failure between one of the
mount()/umount() calls, so we should as well check if it's mounted in
the cleanup and attempt to umount it.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
