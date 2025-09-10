Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D11BFCA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757501405; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3SCTjQ7iLeVSHn3w9iBdBNC4H2F6iZDwnO/G0WgbLRU=;
 b=RpFMRpRFPcnbHKRzsyE0yIuVE/LhYYvWtIgn4cRh/5QpMV/mcDEZRrx6CywvlcpCFoUxY
 uwJheBqpjxASjupdGKD0AX6RR3WdOGzMUuJ8Wl9L/DqTZT4CsgzL5bfT77BjUEJKk5cVt4X
 DtStTjAkIp79APoG4u6mdNPH26/mbrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 260C93CD796
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 12:50:05 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 300463C2966
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 12:49:45 +0200 (CEST)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 65C27600133
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 12:49:44 +0200 (CEST)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-aff0775410eso107622366b.0
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 03:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757501384; x=1758106184; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5FceR7TWYCPkhRKQx5zb/EsAXruY8fECG0se9Gtjmck=;
 b=GChROOe5BBCgJZj2aGUST8JaZFme/uGfZO4gQTg+KjCLkAXqHbAgKtqb2CXKPNluvt
 FrQxCFUbfoBxl6qTlwm55Tgm9W+67mT7ev7JatKeGaPjVfRFxO34VqYTPpcSNoTfRoSu
 k0ZMzWac9LEbo4wQ6/6lMzHxQ123irPoRp0Dj2ovFwIqlOBLH3oIzyqP8DUrAyNICt7G
 uU0ExuaArmv/QyQZGLEmlotllHoAn74wA7oQmR/l16DNeiBfv49rMKtE4crTu3Iu02DG
 17tpFXyK6qcR8wEOvygO1SoZ3Bcp+La39tBUcbXf+63TCUthWMjp9daFX0TntMZMj4B1
 MAGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757501384; x=1758106184;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5FceR7TWYCPkhRKQx5zb/EsAXruY8fECG0se9Gtjmck=;
 b=UuRErKEL8R9vCYbQfmRSHi9YU4RS3C5GWWwCJirTslxcl0W0jzc4QtP0RNfMAMZ1A6
 EGrYk84Bs35h1xH8T+woeKC6VfjV+7LM41l+j4RzoXiAn8BfjUfmHcVV+3j5ILw5nBLu
 fsuEefJB/gwCK/Fj5LQRU0TqCW7R5swT2E/16VVgJ/3+UCnmTQgDWjikr0rJtnpfUc+T
 5jOJPnhqjCVjTXqnJkQGE7NHC5a7VfNIocwItptzBx0QNjBEPIKOIiPl3Ts5c73m5YDc
 rfjMd8CLIjbSv92+btMsQMynt1Lpb2DagW4+TclWWUYDSGL1OBG9s4RVBsyP20Y0GFVH
 XKIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU75soQe2eWzyOpgUWbNFc++oVn4IbKxew/Byux3WOmYvO9V3K2td5q9ZAJCm9q94kKK5g=@lists.linux.it
X-Gm-Message-State: AOJu0YzK0tvc5XpOgEQEUwMaMoUPS1L4/FjCn0uji1aoOymEsK9WiyTz
 on5iy4s+K+Q5O/1v+V/66BSf8n7C0vuoIWIeRm9GoTbasvive5a59Sb0PG+56QqFCA==
X-Gm-Gg: ASbGncvE0jl46twg8JjZ0OTBjo7QhhJN8AAQwEnRvLv6n4SrLnR+SUBVAqsMjcvfiq2
 TB14OqAWQgJLGAHMRl+5DY7BwzwXHiKK5Mvh+QdfS0U36nmLemVb/wPEj9lMntMZeYccHUg4ELR
 IdNQwMS2ms2Z1GQvN+irbU4lNCOoU+ndoY4zLdgSFvoDg+1U5Rjcw3qXnB/BfegSBlruXyrA6Dq
 Zy0Bx8N3Mkuy9YI9sBKDhEOJlH+TcJbUf9J3117z/rF0l7Um4hrcNddmCwma7HWT424nq2TzN7s
 ES01A+/ocZI1afHIRp+smJxSSKd5XTUke6nvwU57KLIQY+haBrnZdGPg5pyNtkGXH9InGoR15Mg
 MpddlpIUemoGfHELz/fy03iYrw+C7+UioT+FjB0XzDkw=
X-Google-Smtp-Source: AGHT+IG5+qfpe2iGYV73DyfCn/7bVbfYElwjwLj5Kp6vDn+d+H0GRExqHq46hp0bIi73tU3DWg03Nw==
X-Received: by 2002:a17:907:1ca2:b0:b04:16fd:9539 with SMTP id
 a640c23a62f3a-b0493291242mr1999779966b.29.1757501383685; 
 Wed, 10 Sep 2025 03:49:43 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-62c018f6656sm3159423a12.36.2025.09.10.03.49.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Sep 2025 03:49:43 -0700 (PDT)
Date: Wed, 10 Sep 2025 10:49:42 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aMFXkjca4Wc8qavK@localhost>
References: <20240812-process_mrelease-v2-0-e61249986a0a@suse.com>
 <20240812-process_mrelease-v2-2-e61249986a0a@suse.com>
 <ZuMWkXlr5XPzosn3@yuki.lan>
 <3c6b0382-ca23-4ac0-ae2d-2cf5ca294abf@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3c6b0382-ca23-4ac0-ae2d-2cf5ca294abf@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Oct 10, 2024 at 02:33:09PM +0200, Andrea Cervesato via ltp wrote:
> Hi!
> 
> On 9/12/24 18:28, Cyril Hrubis wrote:
> > Hi!
> > > +static void run(void)
> > > +{
> > > +	int ret;
> > > +	int pidfd;
> > > +	int status;
> > > +	pid_t pid;
> > > +	int restart;
> > > +
> > > +	for (mem_size = CHUNK; mem_size < MAX_SIZE_MB; mem_size += CHUNK) {
> > > +		restart = 0;
> > > +
> > > +		pid = SAFE_FORK();
> > > +		if (!pid) {
> > > +			do_child(mem_size);
> > > +			exit(0);
> > > +		}
> > > +
> > > +		TST_CHECKPOINT_WAIT(0);
> > > +
> > > +		tst_disable_oom_protection(pid);
> > > +
> > > +		if (!memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size)) {
> > > +			tst_res(TFAIL, "Memory is not mapped");
> > > +			break;
> > > +		}
> > > +
> > > +		pidfd = SAFE_PIDFD_OPEN(pid, 0);
> > > +
> > > +		tst_res(TINFO, "Parent: killing child with PID=%d", pid);
> > > +
> > > +		SAFE_KILL(pid, SIGKILL);
> > > +
> > > +		ret = tst_syscall(__NR_process_mrelease, pidfd, 0);
> > > +		if (ret == -1) {
> > > +			if (errno == ESRCH) {
> > > +				tst_res(TINFO, "Parent: child terminated before "
> > > +					"process_mrelease(). Increase memory size and "
> > > +					"restart test");
> > > +
> > > +				restart = 1;
> > Does this even happen? I suppose that until the child has been waited
> > for you shouldn't get ESRCH at all. The memory may be freed
> > asynchronously but the pidfd is valid until we do waitpid, at least
> > that's what the description says:
> > 
> > https://lore.kernel.org/linux-mm/20210902220029.bfau3YxNP%25akpm@linux-foundation.org/
> > 
> > But selftest seems to do the same loop on ESRCH so either the test or
> > the documentation is wrong.
If you add extra sleep between SAFE_KILL(pid, SIGKILL) and tst_syscall
you will get ESRCH, so i guess child process has chance to be fully
reaped before process_mrelease syscall.
> > 
> > Michal any idea which is correct?
> > 
> > > +			} else {
> > > +				tst_res(TFAIL | TERRNO, "process_mrelease(%d,0) error", pidfd);
> > > +			}
> > > +		} else {
> > > +			int timeout_ms = 1000;
> > > +
> > > +			tst_res(TPASS, "process_mrelease(%d,0) passed", pidfd);
> > > +
> > > +			while (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size) &&
> > > +				timeout_ms--)
> > > +				usleep(1000);
> > > +
> > > +			if (memory_is_mapped(pid, *mem_addr, *mem_addr + mem_size))
> > > +				tst_res(TFAIL, "Memory is still mapped inside child memory");
> > > +			else
> > > +				tst_res(TPASS, "Memory has been released");
> > As far as I understand this this will likely pass even without the
> > process_mrelease() call since the process address space is being teared
> > down anyways. But I do not have an idea how to make things better. I
> > guess that if we wanted to know for sure we would have to run some
> > complex statistics with and without the syscall and compare the
> > timings...
> I don't know, I tried to port the kselftest that seemed to be reasonable.
> Let me know if this is still good, otherwise we need to change the whole
> algorithm. But honestly I don't see many other options than the current one.
kselftest does not has this memory check, i have done some test in my
env, this memory check can pass even without the process_mrelease, so i
think we do not need this check.
> > 
> > > +		}
> > > +
> > > +		SAFE_WAITPID(-1, &status, 0);
> > > +		SAFE_CLOSE(pidfd);
> > > +
> > > +		if (!restart)
> > > +			break;
> > > +	}
> > > +}
> > > +
> > > +static void setup(void)
> > > +{
> > > +	mem_addr = SAFE_MMAP(NULL,
> > > +		sizeof(unsigned long),
> > > +		PROT_READ | PROT_WRITE,
> > > +		MAP_SHARED | MAP_ANON,
> > > +		0, 0);
> > > +}
> > > +
> > > +static void cleanup(void)
> > > +{
> > > +	if (mem_addr)
> > > +		SAFE_MUNMAP(mem_addr, sizeof(unsigned long));
> > > +}
> > > +
> > > +static struct tst_test test = {
> > > +	.test_all = run,
> > > +	.setup = setup,
> > > +	.cleanup = cleanup,
> > > +	.needs_root = 1,
> > > +	.forks_child = 1,
> > > +	.min_kver = "5.15",
> > > +	.needs_checkpoints = 1,
> > > +};
> > > 
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > > -- 
> > > Mailing list info: https://lists.linux.it/listinfo/ltp
> Andrea
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
