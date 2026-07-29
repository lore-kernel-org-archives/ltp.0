Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0D9BC53200
	for <ltp@archiver.kernel.org>; Wed, 29 Jul 2026 22:08:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EED153E74A9
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 00:08:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA0393E1664
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 00:08:02 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 32CB8200219
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 00:08:02 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8eeebcdbfa1so3275816d6.1
 for <ltp@lists.linux.it>; Wed, 29 Jul 2026 15:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785362881; x=1785967681; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ChKUGSAGx0mERndqUlQfS0FV+SIwA1Jd1X+f65VKdgQ=;
 b=QDPFTQnSepJBMWXhOMOxeImmWDb4wOJshnGKU5Sn1YnI9OD8SHeONHfIO7D/Snoz9Z
 WbN7iv0JCbvN9DnVjib132uDt2jAIBGG1FLIJHQ6W2hY/BtpV04sVsCrtLVKkA9icBma
 FY/Gcdw7mgr+ltjm7T7VPfRjHc8X3uIBE1hsXvVEE2yMdyHXjzAZ7Ie7CMWoW9mKCeqI
 yoqgvozEitNiu2+JnESZYdgMpp2Brz7nuiK90diqoIKLZHsQiFweHlvYs7rYgEDdtCFP
 gMDmyGFBb+ZmlfvfpLzRJQW0QSoMMUFejSeY8R2OIs/xKvzO3F0203qGupd2A4iYjnvi
 npAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785362881; x=1785967681;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ChKUGSAGx0mERndqUlQfS0FV+SIwA1Jd1X+f65VKdgQ=;
 b=Tf+dhJh65N0tRGjCjJpxz2JGKVfIbpFDiYlp6KtZgCAK4Nyd49IsYZ5b3mamVkvB1P
 RScKJ5WiqcctNPt2PPOI6lpxpCielJVNUnUR1gFbtpKCeUZZINA+zb57+b83jAUmTfSn
 kXZSHVRFow343bQWdKubasv+VKF3G/599Q8uGP1PRCrbdIAbaWrXAJ2IgSUyu+y4cWM+
 UOKfV0KCZ7q+wsde+JcfHLinU82qjz2UyjEA55TIiL9UvEnPVjrN8jTrFTSjFaEwqWYJ
 nxbG3HQblRyTiWXtnVIs5Xy33wQJ3sDtgDwXji3lTzyAIRnyoRGBu5IH9xLp5kLUL+4t
 TjTg==
X-Gm-Message-State: AOJu0YyThGNi+FUQIbKkIF5+d9jlvGplMg74F0l8CvO3zCOUfay3iTyj
 kEf/BYfFAtwt04XInzyi6v0VrnBtm0FyWmWoeXoKY6CkF1Qtq/aolA9q
X-Gm-Gg: AR+sD135klpkLCV3WezdD/3v4UPedVoV8nrD48sACTMlfhNFjvGh1+J8+yJIZJ6Bzxl
 9skbjeod4a9N+71XnExKQRe4kKSVHyduaeCqkpSIH+jNCyXGZKmjTYVCVmB6nHOBI67uihzj2Wf
 2Ojjl9/ZqcJj/HokgwGYcMbe/Z2M1VTI45GLDTuJG7aUoxprpLR9lbjRFEFR3jeAL1qEqRzq6Vq
 067DSL7VONGRPy/+YDaaU9nIXR3gFOTRdRuM52wZiraSeX/sDd8vLCemGgZ3SaSDLvIMoY3mU85
 EWmMYt6YNrgCoi4HvrSGbiF1nJ41/frd9qCSh77k7TSce/WplO2tD5cI+hzPUBcTh3FOTEpnfkL
 k+pEGyzjy8QoOAbtl1XuWMXtdcLO74wPjpP4nzm4DXKYRh0APICQIx2FLEaX4yBnt4IAfW5FFAy
 hpssNGzh7YO4KOxhUBivZoGOlo+alintA6yF2pTtUO6ipf9jL9Envi2RpBsd8ifeTd0JKyu4FOM
 7r3yHsGwtt0h7aY6AFjE6Npw0Qe91OWC7mfWqA7yRvQr7nie61nqfvWZVLfgVlDrmzm3Lv1Mglm
X-Received: by 2002:a05:6214:4007:b0:907:b32f:9b7e with SMTP id
 6a1803df08f44-90830132498mr8201906d6.11.1785362880792; 
 Wed, 29 Jul 2026 15:08:00 -0700 (PDT)
Received: from
 runnervm7i58z.l25leanymyvu5jhxmyizakpyod.cx.internal.cloudapp.net
 ([20.161.58.225]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-908322fd511sm1226566d6.4.2026.07.29.15.08.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 15:08:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Stephen Bertram <sbertram@redhat.com>
Date: Wed, 29 Jul 2026 22:07:59 +0000
Message-ID: <20260729220759.8984-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260729210019.7647-1-sbertram@redhat.com>
References: <20260729210019.7647-1-sbertram@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] semctl01: fix SEM_STAT failures under parallel LTP runs
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

Hi Stephen,

On Wed, 29 Jul 2026, Stephen Bertram wrote:
> semctl01: fix SEM_STAT failures under parallel LTP runs

> SEM_STAT was using the global high index from IPC_INFO, which is not
> stable when other IPC tests run in parallel and can abort the test with
> TBROK.

The body only describes the SEM_STAT part, but the patch also changes
func_iinfo() so that it no longer derives sem_index, and tightens
func_sstat() to compare against sem_id instead of just ">= 0".

Could one more sentence be added so the diff scope is predictable from
the message alone?

> +static int get_sem_idx_from_id(int id)
> +{
> +	struct seminfo info;
> +	struct semid_ds dummy_ds;
> +	union semun arg;
> +	int max_idx, i;
> +
> +	arg.__buf = &info;
> +	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
> +	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);

msgctl12.c currently has the very same construct that this patch is
removing here:

	index_q = SAFE_MSGCTL(msg_q, IPC_INFO, (struct msqid_ds*)&msginfo_buf);

and then uses index_q for MSG_STAT, so it can break the same way under
parallel runs.

Would it make sense to put this id -> index lookup into
include/tse_newipc.h and libs/newipc, so semctl01, msgctl12 and any
future shmctl test can share one implementation instead of open-coding
it per test?

> +	arg.buf = &dummy_ds;
> +	for (i = 0; i <= max_idx; i++) {
> +		/*
> +		 * Bare semctl: unused/unreadable indices fail with
> +		 * EINVAL/EACCES; SAFE_SEMCTL would abort the test.
> +		 */
> +		if (semctl(i, 0, SEM_STAT, arg) == id)
> +			return i;
> +	}

This makes the SEM_STAT test case tautological: the index is found by
calling SEM_STAT and comparing the result to sem_id, and the test case
then repeats the same call on the same index and asserts the same
equality.

> -static void func_sstat(int semidx)
> +static void func_sstat(int semid)
>  {
> -	if (semidx >= 0)
> +	if (semid == sem_id)
>  		tst_res(TPASS, "id of the semaphore set is correct");

The tcase passes SEMUN_CAST & buf, so the kernel fills the global
struct semid_ds, but func_sstat() never looks at it.

Checking the returned data as well, e.g. buf.sem_nsems == PSEMS the way
func_stat() does for IPC_STAT, would give the SEM_STAT case something to
verify beyond the identity the helper already established.

Verdict - Needs revision

Pre-existing issues in the surrounding code, not introduced by this
patch:

The tests[] table declares its callbacks as "void (*func_test)()" and
"void (*func_setup)()". Because of the empty parameter lists, sparse
reports "too many arguments for function func_setup" at lines 308 and
311 and "too many arguments for function func_test" at line 327, plus
several "incorrect type in initializer (different argument counts)"
warnings on the table entries.

sall_setup() uses braces around a single statement body (line 174),
which checkpatch flags.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
