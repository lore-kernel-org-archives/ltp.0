Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A6ECF11E2
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 12:33:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728563618; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=tu4tb/78jUMOTSS2vagGPNs6at7fTvAVIUc6U9lRAFY=;
 b=Bfn621mygr55JirLk0YNCyat+NhEqihuUqZ79cR2SYPlMvV0VZyl77XDHrvadslZ+m1fi
 HHlLyjNVnhMfn9XizBMVDVnCuTD20bDnilrgq36dqQNG4MDuJsPQS1AyOou4dIid+341d63
 Z/SFLLUHybad4mfV3vN8SeL3UKV479s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936263C4BE2
	for <ltp@archiver.kernel.org>; Thu, 10 Oct 2024 14:33:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 78E623C042F
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:33:18 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68252143E8C8
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 14:33:17 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a99b1f43aceso3645166b.0
 for <ltp@lists.linux.it>; Thu, 10 Oct 2024 05:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1728563597; x=1729168397; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YqX+tu6A1SbHEPQltqvjTV7JsiI/8eTLwsCjvZ+ZvZQ=;
 b=DSBYBY9BrOCrtA+bgZVDkcVtTJxWgNE/lQITAoALD4cb3Is/t9C5m7ZaLT6pg31agj
 kny7FrGS2YDfVyisz+C+zMzLvTjB2UBpG1slEa2PmR11AobBDVleNQnXLeAzrRpQcKYs
 UZGwVLs1ty4VhpW3Hbzy37PrMbaat/+lws42OtxlyAygyLXSfL/384XqbRw/0uNketIq
 BgH4ffVhkGmWViKIkXQAbNyAfZLxwWADkdKACqBhUCVIx7ZnFah30tzoxzT3ZfapBB23
 ktpXKQBzI2ZFFjxidMq2d5bxv2XaweZ2nUF3dFzLXGNV2owUT9iJdwgNNH2B0l2879C0
 tqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728563597; x=1729168397;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YqX+tu6A1SbHEPQltqvjTV7JsiI/8eTLwsCjvZ+ZvZQ=;
 b=TNbjxNfJSvub4tN0l/nh83J05S3/9zryCy6ac+KDjdmtTxh/wjUpltHkbf6zIgJXE5
 FJmsJhx8wtMsg3Wq7qawn5xhZvf72JcE6TyeYo7LJQZAnoa5O0Q97Ek1OjarO/F5fNbB
 Lf3ZgrjoCzgbnKqHV40MT5/KwQIeMBJD6dGo1Qtdz6mIMa4EJZPP1dkoEd1T2EewWIyz
 lBywLOfkE562fH7Go/GzSz7ntjCYAgkSLz6h/MXwDI9VCbDWhZQuIzBxsbDbYgilxHIQ
 IZyg3ko8UAW+wkBrtMFK6lxPiIC4ckuLXLupTX9e9umiP5vGQa7FtLFm6h/Rri+tPSPl
 41Uw==
X-Gm-Message-State: AOJu0YylpcL/MTVo9jch3ypxZ5A2KBraLDZGLO/a7MZO450JN+8woTew
 oRLvBCZKFKbpohZssqNJAPX968W82kEM1TPjbc7VlJa1a/XRlcMMP0J0AjZllZY=
X-Google-Smtp-Source: AGHT+IEtO2/1Hw/+TlAwhEcZCir9hLL/3dNFDCfJbh8BleV5LhLPtaAj2WAabhiVa4uKwMuelMQXqQ==
X-Received: by 2002:a17:906:4786:b0:a93:bc27:de24 with SMTP id
 a640c23a62f3a-a99a0eb7da0mr336932666b.1.1728563596787; 
 Thu, 10 Oct 2024 05:33:16 -0700 (PDT)
Received: from ?IPV6:2a02:a31b:84a1:b780:5af0:a75d:357e:866e?
 ([2a02:a31b:84a1:b780:5af0:a75d:357e:866e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a99a80dc502sm84049366b.146.2024.10.10.05.33.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 10 Oct 2024 05:33:16 -0700 (PDT)
Message-ID: <3c6b0382-ca23-4ac0-ae2d-2cf5ca294abf@suse.com>
Date: Thu, 10 Oct 2024 14:33:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cyril Hrubis <chrubis@suse.cz>, Andrea Cervesato <andrea.cervesato@suse.de>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-2-e61249986a0a@suse.com>
 <ZuMWkXlr5XPzosn3@yuki.lan>
Content-Language: en-US
In-Reply-To: <ZuMWkXlr5XPzosn3@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add process_mrelease01 test
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On 9/12/24 18:28, Cyril Hrubis wrote:
> Hi!
>> +static void run(void)
>> +{
>> +	int ret;
>> +	int pidfd;
>> +	int status;
>> +	pid_t pid;
>> +	int restart;
>> +
>> +	for (mem_size = CHUNK; mem_size < MAX_SIZE_MB; mem_size += CHUNK) {
>> +		restart = 0;
>> +
>> +		pid = SAFE_FORK();
>> +		if (!pid) {
>> +			do_child(mem_size);
>> +			exit(0);
>> +		}
>> +
>> +		TST_CHECKPOINT_WAIT(0);
>> +
>> +		tst_disable_oom_protection(pid);
>> +
>> +		if (!memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size)) {
>> +			tst_res(TFAIL, "Memory is not mapped");
>> +			break;
>> +		}
>> +
>> +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
>> +
>> +		tst_res(TINFO, "Parent: killing child with PID=%d", pid);
>> +
>> +		SAFE_KILL(pid, SIGKILL);
>> +
>> +		ret = tst_syscall(__NR_process_mrelease, pidfd, 0);
>> +		if (ret == -1) {
>> +			if (errno == ESRCH) {
>> +				tst_res(TINFO, "Parent: child terminated before "
>> +					"process_mrelease(). Increase memory size and "
>> +					"restart test");
>> +
>> +				restart = 1;
> Does this even happen? I suppose that until the child has been waited
> for you shouldn't get ESRCH at all. The memory may be freed
> asynchronously but the pidfd is valid until we do waitpid, at least
> that's what the description says:
>
> https://lore.kernel.org/linux-mm/20210902220029.bfau3YxNP%25akpm@linux-foundation.org/
>
> But selftest seems to do the same loop on ESRCH so either the test or
> the documentation is wrong.
>
> Michal any idea which is correct?
>
>> +			} else {
>> +				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
>> +			}
>> +		} else {
>> +			int timeout_ms = 1000;
>> +
>> +			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);
>> +
>> +			while (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size) &&
>> +				timeout_ms--)
>> +				usleep(1000);
>> +
>> +			if (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size))
>> +				tst_res(TFAIL, "Memory is still mapped inside child memory");
>> +			else
>> +				tst_res(TPASS, "Memory has been released");
> As far as I understand this this will likely pass even without the
> process_mrelease() call since the process address space is being teared
> down anyways. But I do not have an idea how to make things better. I
> guess that if we wanted to know for sure we would have to run some
> complex statistics with and without the syscall and compare the
> timings...
I don't know, I tried to port the kselftest that seemed to be 
reasonable. Let me know if this is still good, otherwise we need to 
change the whole algorithm. But honestly I don't see many other options 
than the current one.
>
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
>> +	mem_addr = SAFE_MMAP(NULL,
>> +		sizeof(unsigned long),
>> +		PROT_READ | PROT_WRITE,
>> +		MAP_SHARED | MAP_ANON,
>> +		0, 0);
>> +}
>> +
>> +static void cleanup(void)
>> +{
>> +	if (mem_addr)
>> +		SAFE_MUNMAP(mem_addr, sizeof(unsigned long));
>> +}
>> +
>> +static struct tst_test test = {
>> +	.test_all = run,
>> +	.setup = setup,
>> +	.cleanup = cleanup,
>> +	.needs_root = 1,
>> +	.forks_child = 1,
>> +	.min_kver = "5.15",
>> +	.needs_checkpoints = 1,
>> +};
>>
>> -- 
>> 2.43.0
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
