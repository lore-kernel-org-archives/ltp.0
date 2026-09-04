Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E97C624DE
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 09:18:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A4143E937D
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 11:18:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 023293E9364
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:18:29 +0200 (CEST)
Received: from mta1.migadu.com (out-168.mta1.migadu.com [95.215.58.168])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 04EAB1A0115A
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 11:18:27 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=V/qrxYewgj48M/JhHSiT7EYEM4+3wDEDw4ZwiOVQ0Sk=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788513505; v=1; x=1789118305;
 b=s+i1RHC2Xx765vmI7I+Y8Nsi4DgGIB/GP0vyajddsBJRUi32+Ex63iRPPI6n3/0xxpBpldm9
 cokRAz5r8el0+O27ah0WQDc97DF0ttrHAJWaCYs/Uhn5rW4hJNXbVquTF9P5Div2N+bYx0ekVk3
 lGXDCLkBWSHnkLnDDiwZ3tAk=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id d51fece1b2cf0851;
 Fri, 04 Sep 2026 09:18:25 +0000
X-Mizu-Trace-ID: d51fece1b2cf0851
X-Migadu-Flow: FLOW_OUT
Date: Fri, 4 Sep 2026 17:18:21 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apqM3bxh26RrnN3g@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260904-coredump-v6-0-b8e3947cc646@suse.com>
 <20260904-coredump-v6-2-b8e3947cc646@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260904-coredump-v6-2-b8e3947cc646@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/2] coredump02: Verify ELF structure and notes
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Overall the test methodology looks good, with just a few minor
code cleanup points below.

> +static void set_pattern(const char *fmt, ...)
> +{
> +	char pattern[PATTERN_MAX];
> +	char readback[PATTERN_MAX];
> +	va_list va;
> +	int len;
> +
> +	va_start(va, fmt);
> +	len = vsnprintf(pattern, sizeof(pattern), fmt, va);
> +	va_end(va);
> +
> +	if (len >= PATTERN_MAX)
> +		tst_brk(TCONF, "core_pattern does not fit into %i bytes", PATTERN_MAX - 1);
> +
> +	SAFE_FILE_PRINTF(PATH_KERN_CORE_PATTERN, "%s", pattern);
> +	SAFE_FILE_LINES_SCANF(PATH_KERN_CORE_PATTERN, "%127[^\n]", readback);
> +
> +	if (strcmp(pattern, readback))
> +		tst_brk(TBROK, "core_pattern readback mismatch: wrote '%s', read '%s'",
> +			pattern, readback);
> +
> +	tst_res(TINFO, "core_pattern is '%s'", pattern);
> +}
> +
> +static pid_t crash_child(void)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = SAFE_FORK();
> +	if (!pid)
> +		abort();
> +
> +	SAFE_WAITPID(pid, &status, 0);
> +
> +	if (!WIFSIGNALED(status) || !WCOREDUMP(status))
> +		tst_brk(TFAIL, "Child did not dump core");
> +
> +	return pid;
> +}

Splitting the core file parsing into a separate test is fine.
For the duplicated code, there are two approaches - I'm okay
with either.

1. create a seperate coredump_common.h

	#cat coredump_common.h
	...

	#ifndef COREDUMP_COMMON_H
	#define COREDUMP_COMMON_H
	
	#include <elf.h>
	#include <sys/wait.h>
	
	#include "tst_test.h"
	#include "lapi/prctl.h"
	
	#define PATTERN_MAX 128
	
	static char cwd[PATH_MAX];
	
	static void set_pattern(const char *fmt, ...)
	{
		// ...
	}
	
	static pid_t crash_child(void)
	{
		// ...
	}
	
	static void coredump_setup(void)
	{
		struct rlimit rl = {RLIM_INFINITY, RLIM_INFINITY};
	
		SAFE_SETRLIMIT(RLIMIT_CORE, &rl);
		SAFE_PRCTL(PR_SET_DUMPABLE, 1, 0, 0, 0);
		SAFE_GETCWD(cwd, sizeof(cwd));
	}
	
	#endif /* COREDUMP_COMMON_H */


2. Merge coredump02 method into coredump01 with use tcnt=3.

	static void run(unsigned int n)
	{
		switch (n) {
		case 0:
			verify_file_pattern_specifiers();
			break;
		case 1:
			verify_file_pattern_content();
			break;
		case 2:
			verify_pipe_pattern();
			break;
		}
	}
	
	static struct tst_test test = {
		.test = run,
		.tcnt = 3,
		// ...
	};


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
