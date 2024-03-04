Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71BA4C48BF6
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709565537; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=YsH/FAn2t2xu8xJ3Hs09TEbFNhHwmr3cPO3rE3ptTs8=;
 b=klHouYjiZTftvt2cXwrOTSsTyeLEc5Eiv+lrLamXizUtH3w2cTqpUb8EGwk3aP/a+jQ2a
 a+IWOhzpktlv4dnUZ8ivynkY2eow9t4yzGCG6lKryW5vHU9/nvRGPUuGMaHXCHFUzaTaPTw
 eSIQHfk5DEmL3mvncoyKAEkeoMqbaO8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E84B3CEBB3
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:18:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D1B03CE0C2
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:18:36 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7B066140514E
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:18:34 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-563d56ee65cso7076865a12.2
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 07:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709565514; x=1710170314; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QDKv4tHFTFRGSs7hCWNIUfGAraFLdgkRBsfLQFcr63g=;
 b=TbTrhVZnS4rZRGIP/RBsy/KWk1LJ22Kc9uFGm1rJWxqwPXsTpWyeMXv3YCDmIR/l8R
 IdN+asljW4CZh3Wx9xOo4cUoXbqtoBn26IQYM4PH5k4d0x44jOISmnlCwZ1K0vYmHfVf
 ZtdJthwZewMk6zBR1+LPqltzzvsNs4+XjqaZQowbqL1oFazPCwqBYAdsmOHlcmN03BDE
 mCaVkQun7j1ItewQoEni1q1SgjoBa0NomPDzrMKvmSupe2SXNugL2hUV3Y5pI8kguWOg
 YLukUuzucjrytCjk4nmXJGysKH7F4AtmwHRPeMHi/Qw+FbbDEN+YbGcDnz29653LpuHQ
 mHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709565514; x=1710170314;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QDKv4tHFTFRGSs7hCWNIUfGAraFLdgkRBsfLQFcr63g=;
 b=Sd6PwjI8YRUeKkVbrQ041YNS70M9mh+8ofnAoQU61/syPCiDIVr27NWTkvWARaqG2a
 bqQKKD0iSSv+Rs5ASWy+nwj26Q0tM1I6KrmwKAoR5mFCGDdpWGeoppj1R4THT8iQnRUY
 XYXBkYgutXQb8aHRqyxV7lGCg1GrSgvi+IxvSrmiNCmiVLsYGsFgaLpxsPFK3tb6J8me
 +HnSRTR/wGSe171qQBg4M/0XFqIY7uD02yMWG70MfXDVTmXCq4C+o5Aiu1BOd4GBMcY6
 KIJJl3Vh4gY41nJE4e2DrrD5/EA9uO8xwdvt+mficZve/F/Af7fqhSsuySWYB6KGJT27
 YRTw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm8niklu9HG973+A26oDexzzf8YSIyM08jHGjvrDVlatixOie4uyGuVN1L1pNK1mlpfH8QhcCx4lRFFSc6QR+ceRY=
X-Gm-Message-State: AOJu0YwgcJYMtk5WJMDlVhtPwe4HGRG2I/6hlbW4a4Hffo2PqxbRYL/1
 xAl47/NXPH6n7WcgYMN1v3+cO+zgQqNfeUS4H5wz8iNbyWlenSEAsZr05HpaeOk=
X-Google-Smtp-Source: AGHT+IEd64LLqMriD6kxmKpOPM1M/vMigzw9xutJBvqAwtu4MvWoVrvU2cK5hDSj9eX4VB8PAVCJpw==
X-Received: by 2002:aa7:c657:0:b0:567:3108:727d with SMTP id
 z23-20020aa7c657000000b005673108727dmr3172141edr.11.1709565513877; 
 Mon, 04 Mar 2024 07:18:33 -0800 (PST)
Received: from [10.232.133.85] ([88.128.88.176])
 by smtp.gmail.com with ESMTPSA id
 k8-20020a05640212c800b00567216c1e9bsm2249623edx.88.2024.03.04.07.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 07:18:33 -0800 (PST)
Message-ID: <a287762a-d69e-4bd8-a0b6-04c48030e796@suse.com>
Date: Mon, 4 Mar 2024 16:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Andrea Cervesato <andrea.cervesato@suse.de>, ltp@lists.linux.it
References: <20240304150709.30260-1-andrea.cervesato@suse.de>
 <20240304150709.30260-3-andrea.cervesato@suse.de>
In-Reply-To: <20240304150709.30260-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] Add shmat04 SysV IPC bug reproducer
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 3/4/24 16:07, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> This is an LTP port of a SysV bug reproducer provided by Michal Hocko.
>
> When debugging issues with a workload using SysV shmem, Michal Hocko has
> come up with a reproducer that shows how a series of mprotect()
> operations can result in an elevated shm_nattch and thus leak of the
> resource.
>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> result of TST_EXP_EQ_LU() as test result
>
>   runtest/syscalls                              |   1 +
>   runtest/syscalls-ipc                          |   1 +
>   .../kernel/syscalls/ipc/shmat/.gitignore      |   1 +
>   testcases/kernel/syscalls/ipc/shmat/shmat04.c | 112 ++++++++++++++++++
>   4 files changed, 115 insertions(+)
>   create mode 100644 testcases/kernel/syscalls/ipc/shmat/shmat04.c
>
> diff --git a/runtest/syscalls b/runtest/syscalls
> index 7794f1465..cc0144379 100644
> --- a/runtest/syscalls
> +++ b/runtest/syscalls
> @@ -1445,6 +1445,7 @@ setxattr03 setxattr03
>   shmat01 shmat01
>   shmat02 shmat02
>   shmat03 shmat03
> +shmat04 shmat04
>   
>   shmctl01 shmctl01
>   shmctl02 shmctl02
> diff --git a/runtest/syscalls-ipc b/runtest/syscalls-ipc
> index df41140a7..9860394de 100644
> --- a/runtest/syscalls-ipc
> +++ b/runtest/syscalls-ipc
> @@ -49,6 +49,7 @@ semop03 semop03
>   
>   shmat01 shmat01
>   shmat02 shmat02
> +shmat04 shmat04
>   
>   shmctl01 shmctl01
>   shmctl02 shmctl02
> diff --git a/testcases/kernel/syscalls/ipc/shmat/.gitignore b/testcases/kernel/syscalls/ipc/shmat/.gitignore
> index 2b972f8f2..5600b2742 100644
> --- a/testcases/kernel/syscalls/ipc/shmat/.gitignore
> +++ b/testcases/kernel/syscalls/ipc/shmat/.gitignore
> @@ -1,3 +1,4 @@
>   /shmat01
>   /shmat02
>   /shmat03
> +/shmat04
> diff --git a/testcases/kernel/syscalls/ipc/shmat/shmat04.c b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
> new file mode 100644
> index 000000000..caadee961
> --- /dev/null
> +++ b/testcases/kernel/syscalls/ipc/shmat/shmat04.c
> @@ -0,0 +1,112 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC
> + * Author: Michal Hocko <mhocko@suse.com>
> + * LTP port: Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * When debugging issues with a workload using SysV shmem, Michal Hocko has
> + * come up with a reproducer that shows how a series of mprotect()
> + * operations can result in an elevated shm_nattch and thus leak of the
> + * resource.
> + *
> + * The problem is caused by wrong assumptions in vma_merge() commit
> + * 714965ca8252 ("mm/mmap: start distinguishing if vma can be removed in
> + * mergeability test"). The shmem vmas have a vma_ops->close callback
> + * that decrements shm_nattch, and we remove the vma without calling it.
> + *
> + * Patch: https://lore.kernel.org/all/20240222215930.14637-2-vbabka@suse.cz/
> + */
> +
> +#include "tst_test.h"
> +#include "tst_safe_sysv_ipc.h"
> +#include "libnewipc.h"
> +
> +static int segment_id = -1;
> +static int key_id;
> +static int page_size;
> +static size_t segment_size;
> +
> +static void change_access(void *addr, int size, int prot)
> +{
> +	switch (prot) {
> +	case PROT_NONE:
> +		tst_res(TINFO, "Disable memory access. addr: %p - size: %d",
> +			addr, size);
> +		break;
> +	case PROT_WRITE:
> +		tst_res(TINFO, "Enable write memory access. addr: %p - size: %d",
> +			addr, size);
> +		break;
> +	default:
> +		tst_res(TINFO, "Change memory access. addr: %p - size: %d",
> +			addr, size);
> +		break;
> +	}
> +
> +	SAFE_MPROTECT(addr, size, prot);
> +}
There's an error here. I will fix on v4
> +
> +static void run(void)
> +{
> +	struct shmid_ds shmid_ds;
> +	void *sh_mem;
> +
> +	segment_id = SAFE_SHMGET(
> +		key_id,
> +		segment_size,
> +		IPC_CREAT | IPC_EXCL | 0600);
> +
> +	sh_mem = SAFE_SHMAT(segment_id, NULL, 0);
> +
> +	tst_res(TINFO, "Attached at %p. key: %d - size: %lu",
> +		sh_mem, segment_id, segment_size);
> +
> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
> +
> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
> +
> +	change_access(sh_mem + page_size, page_size, PROT_NONE);
> +	change_access(sh_mem, 2 * page_size, PROT_WRITE);
> +
> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
> +
> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
> +	tst_res(TINFO, "Delete attached memory");
> +
> +	SAFE_SHMDT(sh_mem);
> +	SAFE_SHMCTL(segment_id, IPC_STAT, &shmid_ds);
> +
> +	tst_res(TINFO, "Number of attaches: %lu", shmid_ds.shm_nattch);
> +
> +	SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
> +	segment_id = -1;
> +
> +	TST_EXP_EQ_LU(shmid_ds.shm_nattch, 0);
> +}
> +
> +static void setup(void)
> +{
> +	key_id = GETIPCKEY();
> +	page_size = getpagesize();
> +
> +	tst_res(TINFO, "Key id: %d", key_id);
> +	tst_res(TINFO, "Page size: %d", page_size);
> +
> +	segment_size = 3 * page_size;
> +}
> +
> +static void cleanup(void)
> +{
> +	if (segment_id != -1)
> +		SAFE_SHMCTL(segment_id, IPC_RMID, NULL);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +};



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
