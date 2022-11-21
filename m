Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8877DC433FE
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 14:59:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 286433CCBCF
	for <ltp@archiver.kernel.org>; Mon, 21 Nov 2022 15:59:46 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F3AC3CCB95
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 15:59:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 45AC220AD7C
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 15:59:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1669042772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R7Yo6KSjxNiHOFMBpQ7TjoHo1vd/itwBIeJ/zoYQHBs=;
 b=IBYmuRZC79NUYtsNgbAzzKNo55wFZ1SpxURElNPx35KgzsiggV1W+pM7naWWCSrdTItuEa
 aASa05VSt4YBwlElzYnG3hblvoYQp6/OzgKwwujLHvIsnfHWeqoaVXPdJLP+95DVKnZmvT
 R5s5vqLdLxLL97q5ddsHhJaf0YG06zs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-569-8Dm0yizNNuKZ4MapKjH9Cw-1; Mon, 21 Nov 2022 09:59:31 -0500
X-MC-Unique: 8Dm0yizNNuKZ4MapKjH9Cw-1
Received: by mail-wm1-f70.google.com with SMTP id
 ay19-20020a05600c1e1300b003cf758f1617so9409799wmb.5
 for <ltp@lists.linux.it>; Mon, 21 Nov 2022 06:59:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :references:cc:to:content-language:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R7Yo6KSjxNiHOFMBpQ7TjoHo1vd/itwBIeJ/zoYQHBs=;
 b=gyEwjexkt4ZsGKW+GCXStrWbM7vv0dE/LlFrXV3gTXLkcce8HOvw0/RDKMoo+PEJcC
 GgsyC8tf6dcgAnTgQ6NZPgfd89DcMrSOE5uh6qlG/n2nlif0o8CnGt+D2QYdLGuaT9qq
 q951SDv0TJD9O7uUt+MLZZwJcDeGPbGQ9eTDOUEyv05G87EOkzWNRX4joTCD711DNVDn
 Zx1bBwattlgI2Ive93XIy22Dq9cgmRij69TDmjj/Wnim6QZglE0NsbZZUjC90O/UrFo/
 XQwSEH7Pl0rSs6ALagVdJGPsoWlgWyTDXBLraPp/sl5daX5aFB55mVoDKkHDSsIWQ13z
 Q1Vg==
X-Gm-Message-State: ANoB5pnbDjSwz9GrtHPIwv2TyaxGBfPhPKFeP5w5tYeKnzOPDaACYoh8
 llchXeWGbL0kce7Z8ncp5Nx28bFad4iXYpmWoOcvPzW33qRoSWV1TYChdfXSHJ5y+YqeZVwLSiQ
 7E6mZqHDvPbw=
X-Received: by 2002:a05:600c:3b0c:b0:3cf:8df2:63b7 with SMTP id
 m12-20020a05600c3b0c00b003cf8df263b7mr495620wms.11.1669042770025; 
 Mon, 21 Nov 2022 06:59:30 -0800 (PST)
X-Google-Smtp-Source: AA0mqf5FGNhSQBBF5ReATgi1PxzdPhZC7Lw/u94hw2cj/QGVvno6HvLtvfYGpCQSunRa9FzOFxDLvg==
X-Received: by 2002:a05:600c:3b0c:b0:3cf:8df2:63b7 with SMTP id
 m12-20020a05600c3b0c00b003cf8df263b7mr495605wms.11.1669042769729; 
 Mon, 21 Nov 2022 06:59:29 -0800 (PST)
Received: from [192.168.3.108] (p5b0c67dc.dip0.t-ipconnect.de. [91.12.103.220])
 by smtp.gmail.com with ESMTPSA id
 l32-20020a05600c1d2000b003cfbbd54178sm28487321wms.2.2022.11.21.06.59.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Nov 2022 06:59:29 -0800 (PST)
Message-ID: <34f4e1af-8b1f-fd6b-8345-5b1948de7f14@redhat.com>
Date: Mon, 21 Nov 2022 15:59:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221117121409.179210-1-david@redhat.com> <Y3eI0Q5BTE12+4zO@yuki>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <Y3eI0Q5BTE12+4zO@yuki>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] security/dirtyc0w_shmem: Add new test for
 CVE-2022-2590
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 18.11.22 14:29, Cyril Hrubis wrote:
> Hi!

Hi Cyril,

thanks for your review!

[...]

>> +
>> +/*
>> + * CVE-2022-2590
>> + *
>> + * This is a regression test for a write race that allows unprivileged programs
>> + * to change readonly files located on tmpfs/shmem on the system.
>> + *
>> + * Fixed by:
>> + *
>> + *   commit 5535be3099717646781ce1540cf725965d680e7b
>> + *   Author: David Hildenbrand <david@redhat.com>
>> + *   Date:   Tue Aug 9 22:56:40 2022 +0200
>> + *
>> + *   mm/gup: fix FOLL_FORCE COW security issue and remove FOLL_COW
>> + */
> 
> This is not a proper documentation comment. We do have a system in place
> that picks up ascii-doc formatted documentation comments and builds a
> documentation based on that.
> 
> The documentation comment has to start with:
> 
> /*\
>   * [Description]
>   *
> 
> 
> Also the CVE and kernel commit are picked from tags when documentation
> is build, so they do not need to be part of the documentation comment.
> 

I used dirtyc0w.c as orientation, which probably wasn't a good idea.

I'll use a simple

/*\
  * [Description]
  *
  * This is a regression test for a write race that allowed unprivileged programs
  * to change readonly files located on tmpfs/shmem on the system using
  * userfaultfd "minor fault handling" (CVE-2022-2590).
  */

>> +#include "config.h"
>> +
>> +#include <pthread.h>
>> +#include <unistd.h>
>> +#include <sys/stat.h>
>> +#include <string.h>
>> +#include <stdlib.h>
>> +#include <stdbool.h>
>> +#include <pwd.h>
>> +
>> +#include "tst_test.h"
>> +
>> +#define TMP_DIR "tmp_dirtyc0w_shmem"
>> +#define TEST_FILE TMP_DIR"/testfile"
>> +#define STR "this is not a test\n"
>> +
>> +static uid_t nobody_uid;
>> +static gid_t nobody_gid;
>> +static bool child_early_exit;
> 
> Anything that is changed from signal handler should be volatile
> otherwise it may end up optimized out.

Ack.

> 
>> +static void sighandler(int sig)
>> +{
>> +	if (sig == SIGCHLD) {
>> +		child_early_exit = true;
>> +		return;
>> +	}
>> +
>> +	_exit(0);
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	struct passwd *pw;
>> +
>> +	umask(0);
>> +
>> +	pw = SAFE_GETPWNAM("nobody");
>> +
>> +	nobody_uid = pw->pw_uid;
>> +	nobody_gid = pw->pw_gid;
>> +
>> +	SAFE_MKDIR(TMP_DIR, 0664);
>> +	SAFE_MOUNT(TMP_DIR, TMP_DIR, "tmpfs", 0, NULL);
>> +}
>> +
>> +static void dirtyc0w_shmem_test(void)
>> +{
>> +	bool failed = false;
>> +	int fd, pid;
>> +	char c;
>> +
>> +	fd = SAFE_OPEN(TEST_FILE, O_WRONLY|O_CREAT|O_EXCL, 0444);
>> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, STR, sizeof(STR)-1);
>> +	SAFE_CLOSE(fd);
> 
> SAFE_FILE_PRINTF() ?

AFAIU, that would mean

SAFE_FILE_PRINTF(TEST_FILE, "%s", STR);
SAFE_CHMOD(TEST_FILE, 0444);

I'll give that a churn.

> 
>> +	pid = SAFE_FORK();
>> +	if (!pid) {
>> +		SAFE_SETGID(nobody_gid);
>> +		SAFE_SETUID(nobody_uid);
>> +		SAFE_EXECLP("dirtyc0w_shmem_child", "dirtyc0w_shmem_child", NULL);
>> +	}
>> +
>> +	TST_CHECKPOINT_WAIT(0);
>> +
>> +	SAFE_SIGNAL(SIGCHLD, sighandler);
>> +	do {
>> +		usleep(100000);
>> +
>> +		SAFE_FILE_SCANF(TEST_FILE, "%c", &c);
>> +
>> +		if (c != 't') {
>> +			failed = true;
>> +			break;
>> +		}
>> +	} while (tst_remaining_runtime() && !child_early_exit);
>> +	SAFE_SIGNAL(SIGCHLD, SIG_DFL);
>> +
>> +	SAFE_KILL(pid, SIGUSR1);
>> +	tst_reap_children();
>> +	SAFE_UNLINK(TEST_FILE);
>> +
>> +	if (child_early_exit)
>> +		tst_res(TINFO, "Early child process exit");
> 
> This will potentionally trigger library detection for buggy tests. A
> test has to report a result in all situations.
> 
> I suppose that this will only happen if child process did exit with
> TBROK or TCONF. If that is the case it should be fine.

Yes, exactly. The child process will only quit in case it fails with
TBROK / TCONF. In all other cases, it will simply run until we zap it.

> 
>> +	else if (failed)
>> +		tst_res(TFAIL, "Bug reproduced!");
>> +	else
>> +		tst_res(TPASS, "Bug not reproduced");
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	SAFE_UMOUNT(TMP_DIR);
>> +}
>> +
>> +static struct tst_test test = {
>> +	.needs_checkpoints = 1,
>> +	.forks_child = 1,
>> +	.needs_root = 1,
> 
> We are missing .needs_tmpdir flag here, otherwise the test will create
> the the TMPDIR in PWD which may fail in certain setups.

Thanks!


-- 
Thanks,

David / dhildenb


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
