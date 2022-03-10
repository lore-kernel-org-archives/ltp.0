Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB953C433F5
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 16:35:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F21F03C8972
	for <ltp@archiver.kernel.org>; Thu, 10 Mar 2022 17:35:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2328F3C1B97
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 17:34:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8D054600E5E
 for <ltp@lists.linux.it>; Thu, 10 Mar 2022 17:34:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CE02B1F385;
 Thu, 10 Mar 2022 16:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646930094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LrktQO5fjCaGm+ouQnUQyieLIt4YhgjyyTjegVPbXw=;
 b=omGSU37PTxDR3tyV1jfneHNQYMG86DLkSYA1SGvbxQtQAcQFB2byxMtuXGkcmK5hpyQXxt
 lRK742thUg+6WYw6EQPG1Y0bb95NjiY0yd0Z1xH+qv3Vrk+X5y3iizP/BAZR+DNlYVYxao
 CSPb+2k1PvHt39yybXmL+09Tnq36gTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646930094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0LrktQO5fjCaGm+ouQnUQyieLIt4YhgjyyTjegVPbXw=;
 b=t9IE+GzyYBSmDqiUgcMLZs1FnqZxDVCyKe0i50tPX1raBRTCfo12dcgAbeC8MoV1aOB2LB
 OHKJcncZWS2dsjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA59A13FA3;
 Thu, 10 Mar 2022 16:34:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id K/hXLK4oKmJ5GgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 10 Mar 2022 16:34:54 +0000
Date: Thu, 10 Mar 2022 17:37:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YiopOZu1gNp3rOFp@yuki>
References: <20220310105916.7960-1-andrea.cervesato@suse.de>
 <20220310105916.7960-6-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220310105916.7960-6-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 05/10] Rewrite semtest_2ns.c using new LTP API
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
> +/*\
> + * [Description]
> + *
> + * Test SysV IPC semaphore usage between namespaces.
> + *
> + * [Algorithm]
> + *
> + * Create 2 'containers'
> + * In container1 create semaphore with a specific key
> + * In container2 try to access the semaphore created in container1
> + *
> + * Test is PASS if flag = none and the semaphore is accessible in container2 or
> + * if flag = unshare/clone and the semaphore is not accessible in container2.
> + * If semaphore is not accessible in container2, creates new semaphore with the
> + * same key to double check isloation in IPCNS.
> + *
> + * Test is FAIL if flag = none and the semaphore is not accessible, if
> + * flag = unshare/clone and semaphore is accessible in container2 or if the new
> + * semaphore creation Fails.
> + */
> +
> +#define _GNU_SOURCE
> +
> +#include <sys/wait.h>
> +#include <sys/msg.h>
> +#include <sys/types.h>
>  #include <sys/sem.h>
> -#include <libclone.h>
> -#include "test.h"
> -#include "ipcns_helper.h"
> -
> -#define MY_KEY     124326L
> -#define UNSHARESTR "unshare"
> -#define CLONESTR   "clone"
> -#define NONESTR    "none"
> -
> -char *TCID = "semtest_2ns";
> -int TST_TOTAL = 1;
> -int p1[2];
> -int p2[2];
> +#include "tst_safe_sysv_ipc.h"
> +#include "tst_test.h"
> +#include "common.h"
> +
> +#define MY_KEY 124326L
> +
> +static char *str_op = "clone";
> +static int use_clone;
> +
>  static struct sembuf semop_lock[2] = {
>  	/* sem_num, sem_op, flag */
> -	{0, 0, 0},		/* wait for sem#0 to become 0 */
> -	{0, 1, SEM_UNDO}	/* then increment sem#0 by 1 */
> +	{ 0, 0, 0 }, /* wait for sem#0 to become 0 */
> +	{ 0, 1, SEM_UNDO } /* then increment sem#0 by 1 */
>  };
>  
>  static struct sembuf semop_unlock[1] = {
>  	/* sem_num, sem_op, flag */
> -	{0, -1, (IPC_NOWAIT | SEM_UNDO)}	/* decrement sem#0 by 1 (sets it to 0) */
> +	{ 0, -1, (IPC_NOWAIT | SEM_UNDO) } /* decrement sem#0 by 1 (sets it to 0) */
>  };
>  
>  /*
>   * sem_lock() - Locks the semaphore for crit-sec updation, and unlocks it later
>   */
> -void sem_lock(int id)
> +static void sem_lock(int id)
>  {
> -	/* Checking the semlock and simulating as if the crit-sec is updated */
> -	if (semop(id, &semop_lock[0], 2) < 0) {
> -		perror("sem lock error");
> -		tst_brkm(TBROK, NULL, "semop failed");
> -	}
> -	tst_resm(TINFO, "Sem1: File locked, Critical section is updated...");
> +	SAFE_SEMOP(id, &semop_lock[0], 2);
> +
> +	tst_res(TINFO, "semaphore1: File locked, Critical section is updated...");
> +
>  	sleep(2);
> -	if (semop(id, &semop_unlock[0], 1) < 0) {
> -		perror("sem unlock error");
> -		tst_brkm(TBROK, NULL, "semop failed");
> -	}
> +
> +	SAFE_SEMOP(id, &semop_unlock[0], 1);
>  }
>  
>  /*
>   * check_sem1 -  does not read -- it writes to check_sem2() when it's done.
>   */
> -int check_sem1(void *vtest)
> +static int check_sem1(LTP_ATTRIBUTE_UNUSED void *vtest)
>  {
> -	int id1;
> -
> -	(void) vtest;
> -
> -	close(p1[0]);
> -	/* 1. Create (or fetch if existing) the binary semaphore */
> -	id1 = semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666);
> -	if (id1 == -1) {
> -		perror("Semaphore create");
> -		if (errno != EEXIST) {
> -			perror("semget failure");
> -			tst_brkm(TBROK, NULL, "semget failure");
> -		}
> -		id1 = semget(MY_KEY, 1, 0);
> -		if (id1 == -1) {
> -			perror("Semaphore create");
> -			tst_brkm(TBROK, NULL, "semget failure");
> -		}
> +	TEST(semget(MY_KEY, 1, IPC_CREAT | IPC_EXCL | 0666));
> +	if (TST_RET < 0) {
> +		tst_res(TINFO, "semget failure. Checking existing semaphore");
> +
> +		if (TST_ERR != EEXIST)
> +			tst_brk(TBROK | TRERRNO, "Semaphore creation failed");
> +
> +		SAFE_SEMGET(MY_KEY, 1, 0);
>  	}
>  
> -	write(p1[1], "go", 3);
> -	tst_resm(TINFO, "Cont1: Able to create semaphore");
> -	tst_exit();
> +	tst_res(TINFO, "container1: Able to create semaphore");
> +
> +	return 0;
>  }
>  
>  /*
>   * check_sem2() reads from check_sem1() and writes to main() when it's done.
>   */
> -
> -int check_sem2(void *vtest)
> +static int check_sem2(LTP_ATTRIBUTE_UNUSED void *vtest)
>  {
> -	char buf[3];
> -	int id2;
> -
> -	(void) vtest;
> +	int id;
>  
> -	close(p1[1]);
> -	close(p2[0]);
> -	read(p1[0], buf, 3);
> +	id = semget(MY_KEY, 1, 0);
> +	if (id >= 0) {
> +		sem_lock(id);

I wonder why we even call the sem_lock() here, it does not add any
value to the test and only slows it down for two seconds for no reason
in the case of -m none.


Looking at the code the whole test looks strange and does not make much
sense.

Looking at the check_sem1() I guess that it's supposed to create a
semaphore in one namespace, while the check_sem2() is trying to check if
that leaks into the second namespace. But without the checkpoint
synchronization the order is not guaranteed at all.

I guess that this should really be rewritten so that:

* check_sem1() creates the semaphore, then calls CHECKPOINT_WAKE()

* check_sem2() does CHEKPOINT_WAIT() then check if the semaphore does
  exists

That is the very basic test we should do.

On the top of that we can make the check_sem1() to also lock the
semaphore between the call to wake the other process. And the other
process check_sem2() can attempt to lock it as well with IPC_NOWAIT. If
that fails the reference to the semaphore somehow leaked even if the
namespaces are isolated.


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
