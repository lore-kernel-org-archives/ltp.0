Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A45AC52D71
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 07:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1723188620; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=U0kLHLABg3N5Jr5+BxZpqzWObJnBHxUJz5ALDyd3Bmc=;
 b=YlRPhKp/jFgr6uKaee1lcR52Vzu0Bqj92L7wSkvXnWU8oUMeMxIkW8+ruVXw6h63u6YAY
 o0Bgs1DpHsWDSKfkjgGgaAAqWcuVeIF7pCQW6efPydgEC6r0t+/4x1XuZnOu22jo4flgQHZ
 G1VLAMIcXlU//2/1xL7kaTIdpkCi08U=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A9283D20B4
	for <ltp@archiver.kernel.org>; Fri,  9 Aug 2024 09:30:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D159A3D10CD
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:29:58 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0185710060AD
 for <ltp@lists.linux.it>; Fri,  9 Aug 2024 09:29:56 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so2032540a12.2
 for <ltp@lists.linux.it>; Fri, 09 Aug 2024 00:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1723188596; x=1723793396; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+6WDCJa22hFfomoH2jaakFwvTXAFY7M1xukqjXmGJbs=;
 b=NerysZxZfcOSVXl18tt8+JsPa1LnYLQbT7GJOQYCv1vff5CcOm6sptQVLZdliYj3lI
 HZj7dUZrO+F2v302tHPMCuLAJlcm1e17GmHFKIvyqf+sfT02GbxbzuN5egHfPoNLPafJ
 KFP57kPfiybDjvgwO8ArkjmyWb7aLK7ZyKk0p/RcEMfQUA5FADf7EU23bxJdeoPt9IL5
 nb8yKBUk5Y2TIO01A924lcOVlfL0AkXqlDTn5F3Lw4a9zP5VRiF5Ny1YeNXfroKXIwsf
 j1pQ2rdCPS+Rt2lIEKLwtpu6QdNPCC9j8FKxEKh0bzYiBeZndnMbIYWTCxq6OtHZLKF/
 PL0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723188596; x=1723793396;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+6WDCJa22hFfomoH2jaakFwvTXAFY7M1xukqjXmGJbs=;
 b=eCWpM7FlRGgr60S+tzZKBUr6q9WFfMRfz9zDu4JyIQHxJklLSKJVxIsi5QyA0U1wBh
 60tmqWy0T6VcCVGBCFBglmp7UTBV7fosDfJRmuPeidTwhpuHbisqHXG02Z0WHHmtohFi
 kpxnxPiU4sl9iB0K7FD+KP3NbJOgB6+jc6FVK9g0jUbdTQJ3DmdWoA9CD2P47RVTC5jG
 E5ALlih8XL1dZrt8xwbHYl/kP5aN9t1W+v/4JfTwozAndU39QeXsE+QOaPnCLSyNbTk+
 Ngmy2wv8be5iR4sF1ovETpcnH3u6igAV1w/BKAgdP3VkPeifGAnd+OfR7yCpvaqd4aru
 gWOQ==
X-Gm-Message-State: AOJu0YwMrMubNZIs9DXp7v1czPIFwBdqnj2i8nFv54tTA2HLG5Ye2UdS
 GLVfDgsdXDSyMU8AunVq3j+T7moSCa65Sm9PCRM2E+3RMKsulaWSqNAx6vgIDKc=
X-Google-Smtp-Source: AGHT+IFOqoGe4pogBb4Hqy+wC++RxEZKQufJyDdLELaDmX6OCSUj4TQHTxIahJOy9qql6RBhk79/Lg==
X-Received: by 2002:a17:907:d858:b0:a7a:8586:d36b with SMTP id
 a640c23a62f3a-a80aa54ec04mr58404966b.3.1723188595667; 
 Fri, 09 Aug 2024 00:29:55 -0700 (PDT)
Received: from [10.232.133.25] ([88.128.88.152])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9ec350fsm812435066b.189.2024.08.09.00.29.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Aug 2024 00:29:55 -0700 (PDT)
Message-ID: <77540fcf-1d27-4292-b4c2-8cb45429da61@suse.com>
Date: Fri, 9 Aug 2024 09:29:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240522-process_mrelease-v1-0-41fe2fa44194@suse.com>
 <20240522-process_mrelease-v1-2-41fe2fa44194@suse.com> <ZpfDu0U1fISLDbqC@rei>
Content-Language: en-US
In-Reply-To: <ZpfDu0U1fISLDbqC@rei>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] Add process_mrelease01 test
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 7/17/24 15:14, Cyril Hrubis wrote:
> Hi!
>> +/*\
>> + * [Description]
>> + *
>> + * This test verifies that process_mrelease() syscall is releasing memory from
>> + * a killed process with memory allocation pending.
>> + */
>> +
>> +#include "tst_test.h"
>> +#include "lapi/syscalls.h"
>> +
>> +#define CHUNK (1 * TST_MB)
>> +#define MAX_SIZE_MB (128 * TST_MB)
>> +
>> +static void *mem;
>> +static volatile int *mem_size;
>> +
>> +static void do_child(int size)
>> +{
>> +	tst_res(TINFO, "Child: allocate %d bytes", size);
>> +
>> +	mem = SAFE_MMAP(NULL,
>> +		size,
>> +		PROT_READ | PROT_WRITE,
>> +		MAP_PRIVATE | MAP_ANON,
>> +		0, 0);
> This does not actually alloate any memory, it set ups the vmas but the
> actual memory is not allocated until you fault it by accessing it, so
> you have to actually touch every page to get it faulted, e.g. memset()
> it to something.
>
Yes this is true. I will fix it.
>> +	TST_CHECKPOINT_WAKE_AND_WAIT(0);
>> +
>> +	tst_res(TINFO, "Child: releasing memory");
>> +
>> +	SAFE_MUNMAP(mem, size);
>> +}
>> +
>> +static void run(void)
>> +{
>> +	int ret;
>> +	int pidfd;
>> +	int status;
>> +	pid_t pid;
>> +	volatile int restart;
>> +
>> +	for (*mem_size = CHUNK; *mem_size < MAX_SIZE_MB; *mem_size += CHUNK) {
>> +		restart = 0;
>> +
>> +		pid = SAFE_FORK();
>> +		if (!pid) {
>> +			do_child(*mem_size);
>> +			exit(0);
>> +		}
>> +
>> +		TST_CHECKPOINT_WAIT(0);
>> +		tst_disable_oom_protection(pid);
> What is this needed for?
process_mrelease() overlaps with OOM, since it's used to free up thread 
memory instead of OOM. For this reason we need to disable it, so any OOM 
operation after kill() won't be taken by it.
>
>> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
>> +
>> +		tst_res(TINFO, "Parent: killing child with PID=%d", pid);
>> +
>> +		SAFE_KILL(pid, SIGKILL);
>> +
>> +		ret = tst_syscall(__NR_process_mrelease, pidfd, 0);
>> +		if (ret == -1) {
>> +			if (errno == ESRCH) {
>> +				tst_res(TINFO, "Parent: child terminated before process_mrelease()."
>> +					" Increase memory size and restart test");
>> +
>> +				restart = 1;
> As far as I understand the documentation his condition should not happen
> until you have called wait() on the process.

The minimum requirement is that child has been killed and it's 
accessible from process_mrelease, so if we call wait() on the child, we 
won't be able to reach it anymore, causing ESRCH in process_mrelease().

Please check mrelease_test.c kselftest.

>
>> +			} else {
>> +				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
>> +			}
>> +		} else {
>> +			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);
> Okay it passed, but did we free any memory?
>
> Is the /proc/$pid/ still accessible before we wait on the killed
> process? If it is we can parse the proc maps before and after
> process_mrelease and check if the memory was really freed.
Good idea, I will do that.
>> +		}
>> +
>> +		SAFE_WAITPID(-1, &status, 0);
>> +		SAFE_CLOSE(pidfd);
>> +
>> +		if (!restart)
>> +			break;
>> +	}
>> +}
>> +
>> +static void setup(void)
>> +{
>> +	mem_size = SAFE_MMAP(
>> +		NULL,
>> +		sizeof(int),
>> +		PROT_READ | PROT_WRITE,
>> +		MAP_SHARED | MAP_ANONYMOUS,
>> +		-1, 0);
> Why do we keep the size in shared memory? The forked child has COW
> access to the parent memory, we can use the variables set in the parent
> just fine.
+1
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (mem)
>> +		SAFE_MUNMAP(mem, *mem_size);
> This is allocated in chid and never non NULL in parent.
>
>> +	if (mem_size)
>> +		SAFE_MUNMAP((void *)mem_size, sizeof(int));
>> +}
>> +
>> +static struct tst_test test = {
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.test_all = run,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.min_kver = "5.15",
>> +	.needs_checkpoints = 1,
>> +	.needs_kconfigs = (const char *[]) {
>> +		"CONFIG_MMU=y",
>> +	},
>> +};
>>
>> -- 
>> 2.35.3
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
