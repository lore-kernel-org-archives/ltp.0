Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDB40C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 13:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785848630; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=NsNef9IabGq3i1T1aNUiBSF1AHsBCM0rL3l5zuGUu6Y=;
 b=ZawHIununoEuUysGmXRWGFRPJIaBYmycrHBPQ2HTFN7bLyiJhvtf3I2QvB7fUHN8ISVXi
 VyC/ouYyBmQx1O/qf+PJ5zGVvcwUj9TVf9jd3seEgs14806mcbCKaTwsKyYshhTv7b6xpnE
 JQXnnwLINjXBaj7nnHOJLDuvhOkYCtY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8FCF3E717E
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 15:03:49 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2CDA43CC870
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:03:27 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93BC2100044F
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 15:03:26 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso33211405e9.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785848606; x=1786453406; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=m8OsmCgJdiCYB4L6Ip8nsxTFm6ITVDPzOYe+Y9cPqUw=;
 b=fQyf0QGSjVKMSz5+34uahyazPxvUmV8vF9tu0njVUQ3tw4h3l0ZJr8rB4FzzhOsgUL
 ASVU14m5CjGwzljGXvvEL4SRSz22sJUaPoRVzs+LHQPIPQvkrRS4Fj6UVbrlvrDRnTMo
 29xtgkaAPwzF88pw4CVc6XvmbRdNy8LVKej4IythtT4ZhniCurH6A1gBWiSIDJB/oct2
 HrKSQERRXDwvlmdKw4FvAP+bil9u+lv6hvaIjdKhPuZY5Z4uOwaMc0i4EprKV/GXdRMb
 23FLis4wgtFrdVy5pdTbWBXAVsMBoCRznQBI/sOdnLdmX9mWLCxEHsR2We5NCDInH5gx
 Ncjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785848606; x=1786453406;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=m8OsmCgJdiCYB4L6Ip8nsxTFm6ITVDPzOYe+Y9cPqUw=;
 b=ssV38SeNIhVlNTHl/0Cl3LqhMSUyS5QvSY0cWAmwCNc82WkAKIKk4ClfC44LRdNgy1
 TaC4epup3eYFpj5orWODn7espxuN19mXwGyRN+2ixO53paQE0QAUOHQkK38gHKcOCo81
 584BdGHxlH3DTGOwxAxlX6YUOC2EdhpDUBbaCfx8oKUgiV925aX/MzqG7TRdn3D3YhNS
 ty4dubZFpzz3d5HLZ8bZlJ+LHPNN4epkOb214io1Rmoa77iXFpNbhK5xAJMsZC6V/ro/
 SHAAQUn+DDQB+qABYQEyLymqUm3js34z92brTRzw4lh+sd7zuKklW2/dlE+ySi6qjaUL
 +phQ==
X-Gm-Message-State: AOJu0YyDD08D/nGIkcuCELhWS17X6s1f+KY7aqDoOGid00SFQueJ9sUM
 BbjT47miKX0jd0s/AjOszM9ce1M4Kv8LIflWfLaGY01NVzU0wly/Vp9XEjFUxgRtF4+HY2RJGE9
 7EpbOkQY=
X-Gm-Gg: AR+sD12HNUKUYRJKwkvRL5FDSuysE0JxTcxSGA82qKW5NUfgDmcjnwKFpzVW9WElCbQ
 W8z89KkYIMg6pbR6kQKr00FT1canARVW7IcrVV7BNz5/lNjtmTMR/LbQb1g/0zii7n/KiJrq+Gp
 6mbPDPoFpWcxw1JFkLouG73Vfg0YaeDRkctv8uY3voK1BHDfVzlEtU7tX1Dfm10rOkUQ7+z00J3
 jkA/RAY23EhEF9BL6Cllaf5MPRwb3TdcZuU6RQUNdWhENIVc6wf7kVEFVfXQ7n8+3Zh804i+gdd
 AqXfobkBwwUiO3oIumQenduwJ9J5pDWl18M47/7rOuW95zqQfIlPLFshzLZ9DabPzqsHqJAmi30
 41c76Zx94+mTGK4qa0r2CP1F7XKHqeSWQb5xf8/h3WPoX+0MS7ZLTrzeLDUBp9WGhDdDUJDz0fi
 4qfZOoVRUVJBGG6FABYcu+KtHErxlY5SJCMPeXd/2x04ktGfyf/0XZ7q5KNwwoneNCto4CveQ6s
 Q56x0GU0oMzugCm+YwrX14Pnoikrv36icPF1UEx/GyRH2sgypkRHKa3DYiwDjGAG8Fg3bKrAJMH
 4r7kt3bA7gykDviU5aFod6ujLX/iQ/HmhTta7A==
X-Received: by 2002:a05:600c:8b14:b0:495:4cb8:42b9 with SMTP id
 5b1f17b1804b1-4980c66d8cemr361908305e9.4.1785848604439; 
 Tue, 04 Aug 2026 06:03:24 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb0c5sm78515555e9.4.2026.08.04.06.03.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 06:03:21 -0700 (PDT)
Message-ID: <6a71e319.f3563870.23dd1e.b354@mx.google.com>
To: "Stephen Bertram via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260730171956.237584-1-sbertram@redhat.com>
Date: Tue, 04 Aug 2026 13:03:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v15] semctl01: fix SEM_STAT failures under
 parallel LTP runs
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
Cc: Stephen Bertram <sbertram@redhat.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Stephan,

> diff --git a/include/tse_newipc.h b/include/tse_newipc.h
> index 1d3bbd129..175a60234 100644
> --- a/include/tse_newipc.h
> +++ b/include/tse_newipc.h
> @@ -49,4 +49,24 @@ void *probe_free_addr(const char *file, const int lineno);
>  #define PROBE_FREE_ADDR() \
>  	probe_free_addr(__FILE__, __LINE__)
>  
> +/**
> + * get_ipc_idx_from_id() - Find the kernel index of an IPC resource by id.
> + *
> + * @id: The msqid/semid/shmid to look for.
> + * @max_idx: Highest kernel index to search, from IPC_INFO/SEM_INFO/SHM_INFO.
> + * @stat_fn: Per-family *_STAT wrapper called as stat_fn(idx, buf) for
> + *           each idx in [0, max_idx]; must return the id at idx, or -1
> + *           on error, without aborting the test.
> + * @buf: Buffer passed through to @stat_fn.
> + *
> + * SysV *_STAT commands (MSG_STAT/SEM_STAT/SHM_STAT) take a kernel array
> + * index rather than the id returned by *get(), and that index is not
> + * guaranteed to match the id when other IPC users are active. This walks
> + * the live indices to find the one that currently maps to @id.
> + *
> + * Return: The kernel index mapping to @id, or -1 if none was found.
> + */
> +int get_ipc_idx_from_id(int id, int max_idx,
> +			int (*stat_fn)(int idx, void *buf), void *buf);
> +
>  #endif /* tse_newipc.h */
> diff --git a/libs/newipc/tse_newipc.c b/libs/newipc/tse_newipc.c
> index f7edda6b5..aee286a31 100644
> --- a/libs/newipc/tse_newipc.c
> +++ b/libs/newipc/tse_newipc.c
> @@ -86,3 +86,16 @@ void *probe_free_addr(const char *file, const int lineno)
>  
>  	return addr;
>  }
> +
> +int get_ipc_idx_from_id(int id, int max_idx,
> +			int (*stat_fn)(int idx, void *buf), void *buf)
> +{
> +	int i;
> +
> +	for (i = 0; i <= max_idx; i++) {
> +		if (stat_fn(i, buf) == id)
> +			return i;
> +	}
> +
> +	return -1;
> +}

can we add patch 1/2 for this..

> diff --git a/testcases/kernel/syscalls/semctl/Makefile b/testcases/kernel/syscalls/semctl/Makefile
> index 0e7223998..1f1ec9c81 100644
> --- a/testcases/kernel/syscalls/semctl/Makefile
> +++ b/testcases/kernel/syscalls/semctl/Makefile
> @@ -8,6 +8,6 @@ LTPLIBS = ipc newipc
>  include $(top_srcdir)/include/mk/testcases.mk
>  
>  semctl06: LTPLDLIBS = -lltpipc
> -semctl02 semctl03 semctl04 semctl05 semctl07 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
> +semctl01 semctl02 semctl03 semctl04 semctl05 semctl07 semctl08 semctl09: LTPLDLIBS = -lltpnewipc
>  
>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> diff --git a/testcases/kernel/syscalls/semctl/semctl01.c b/testcases/kernel/syscalls/semctl/semctl01.c
> index 5bd675ab6..398cb3028 100644
> --- a/testcases/kernel/syscalls/semctl/semctl01.c
> +++ b/testcases/kernel/syscalls/semctl/semctl01.c
> @@ -210,13 +210,16 @@ static void func_rmid(void)
>  
>  static void func_iinfo(int hidx)
>  {
> -	if (hidx >= 0) {
> -		sem_index = hidx;
> -		tst_res(TPASS, "the highest index is correct");
> -	} else {
> -		sem_index = 0;
> -		tst_res(TFAIL, "the highest index is incorrect");
> -	}
> +	/*
> +	 * Return value is the highest used index. Our set is alive, so the
> +	 * highest used index must be at least our index.
> +	 */
> +	if (hidx >= sem_index)
> +		tst_res(TPASS, "IPC_INFO highest index %d >= our index %d",
> +			hidx, sem_index);
> +	else
> +		tst_res(TFAIL, "IPC_INFO highest index %d < our index %d",
> +			hidx, sem_index);
>  }
>  
>  static void func_sinfo(void)
> @@ -227,12 +230,54 @@ static void func_sinfo(void)
>  		tst_res(TPASS, "number of semaphore sets is correct");
>  }
>  
> -static void func_sstat(int semidx)
> +/*
> + * SEM_STAT fills buf the same way IPC_STAT does. sem_nsems and
> + * sem_perm.mode (set via IPC_SET earlier) verify SEM_STAT's own data,
> + * not just the id already used to find sem_index.
> + */
> +static void func_sstat(int semid)
>  {
> -	if (semidx >= 0)
> -		tst_res(TPASS, "id of the semaphore set is correct");
> +	if (semid != sem_id) {
> +		tst_res(TFAIL, "expected sem_id %d, got %d", sem_id, semid);
> +		return;
> +	}
> +
> +	if (buf.sem_nsems == PSEMS && buf.sem_perm.mode == (SEM_RA | NEWMODE))
> +		tst_res(TPASS, "id and semaphore STAT info are correct (id=%d)",
> +			sem_id);
>  	else
> -		tst_res(TFAIL, "id of the semaphore set is incorrect");
> +		tst_res(TFAIL, "nsems=%d (expected %d), mode=%o (expected %o)",
> +			(int)buf.sem_nsems, PSEMS,
> +			buf.sem_perm.mode, (SEM_RA | NEWMODE));
> +}
> +
> +/*
> + * SAFE_SEMCTL() would abort the test on per-index failures.
> + */
> +static int sem_stat(int idx, void *buf)
> +{
> +	union semun arg;
> +
> +	arg.buf = buf;
> +	return semctl(idx, 0, SEM_STAT, arg);
> +}
> +
> +/*
> + * SEM_STAT takes an index into the kernel's internal array, not a semid.
> + * Return the index that maps to this test's set.
> + */
> +static int get_sem_idx_from_id(int id)
> +{
> +	struct seminfo info;
> +	struct semid_ds dummy_ds;
> +	union semun arg;
> +	int max_idx;
> +
> +	arg.__buf = &info;
> +	/* SEM_INFO ignores semid; but SAFE_SEMCTL requires an lvalue */
> +	max_idx = SAFE_SEMCTL(id, 0, SEM_INFO, arg);
> +
> +	return get_ipc_idx_from_id(id, max_idx, sem_stat, &dummy_ds);
>  }
>  
>  static struct tcases {
> @@ -263,8 +308,15 @@ static void verify_semctl(unsigned int n)
>  	struct tcases *tc = &tests[n];
>  	int rval;
>  
> -	if (sem_id == -1)
> +	if (sem_id == -1) {
>  		sem_id = SAFE_SEMGET(IPC_PRIVATE, PSEMS, IPC_CREAT | IPC_EXCL | SEM_RA);
> +		sem_index = get_sem_idx_from_id(sem_id);
> +		if (sem_index < 0)
> +			tst_brk(TBROK,
> +				"Failed to get sem_id %d to idx mapping", sem_id);
> +		tst_res(TINFO, "sem_id=%d maps to kernel index=%d",
> +			sem_id, sem_index);
> +	}
>  	if (tc->func_setup) {
>  		switch (tc->cmd) {
>  		case GETNCNT:
> diff --git a/testcases/kernel/syscalls/shmctl/shmctl01.c b/testcases/kernel/syscalls/shmctl/shmctl01.c
> index 05aea58cc..bfc11fa39 100644
> --- a/testcases/kernel/syscalls/shmctl/shmctl01.c
> +++ b/testcases/kernel/syscalls/shmctl/shmctl01.c
> @@ -224,20 +224,20 @@ static void dummy_sighandler(int sig)
>  	(void)sig;
>  }
>  
> +static int shm_stat(int idx, void *buf)
> +{
> +	return shmctl(idx, SHM_STAT, buf);
> +}
> +
>  static int get_shm_idx_from_id(int shm_id)
>  {
>  	struct shm_info dummy;
>  	struct shmid_ds dummy_ds;
> -	int max_idx, i;
> +	int max_idx;
>  
>  	max_idx = SAFE_SHMCTL(shm_id, SHM_INFO, (void *)&dummy);
>  
> -	for (i = 0; i <= max_idx; i++) {
> -		if (shmctl(i, SHM_STAT, &dummy_ds) == shm_id)
> -			return i;
> -	}
> -
> -	return -1;
> +	return get_ipc_idx_from_id(shm_id, max_idx, shm_stat, &dummy_ds);
>  }
>  
>  static void setup(void)
> -- 
> 2.55.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

And patch 2/2 for this?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
