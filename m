Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0B8C43458
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 07:31:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FAA03E2E1C
	for <ltp@archiver.kernel.org>; Sat,  4 Jul 2026 09:31:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8382E3E2100
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 09:31:35 +0200 (CEST)
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7074E1A0119E
 for <ltp@lists.linux.it>; Sat,  4 Jul 2026 09:31:29 +0200 (CEST)
Date: Sat, 4 Jul 2026 15:31:23 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1783150288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VQRQe7KEqTJelePI7H1HiN269f435AAGo7utvgBBNGc=;
 b=BXOlFswMyRWIc8u0fjycOg39GwnMf4JWKNnP3TLAMONVsX+5j5rIPaOBazzaJ2AcN5dbDh
 RvWVmZ5d4uRb5kOdNyak4nsHCZYk3NaInTke37deVJpfIKG6VwpkBHWhzjDpXCbcrt6TME
 yhRE9tdkeaOvauGlfum/v7pcb7eEsyE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aki2AjzuU7_ayxrZ@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260703-fix_memcg_stress-v1-1-93bd09a62446@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260703-fix_memcg_stress-v1-1-93bd09a62446@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg_stress: survive OOM by targeting the
 stressors
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

Andrea Cervesato wrote:

> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> The single-cgroup subtest intentionally lets one process fault in the
> whole memory budget to push the system to its memory ceiling, so hitting
> the OOM killer is an expected part of the stress. The problem is that the
> OOM killer could reap the driver script, turning that expected pressure
> into a spurious TBROK.
> 
> Mark the stress processes as the preferred OOM victims. A killed stressor
> is already reaped and cleaned up by the test, while the driver survives
> and reports the result.
> 
> Fixes: 02961a7b2bb4 ("memcg_stress_test.sh: Fix reserved mem calculate")
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> On some systems this might happens:
> 
> [  244.207623][T117130] kirk[3061]: memcg_stress: start (command: memcg_stress_test.sh)
> [  244.391438][T117164] memcg_stress_te (117164): drop_caches: 3
> [ 1444.509722][T119900] kirk[3061]: memcg_stress: end (returncode: -1)
> [ 1444.629434][T119934] kirk[3061]: memcg_control: start (command: memcg_control_test.sh)
> [ 1445.856012][T120020] mem_process invoked oom-killer: gfp_mask=0xcc0(GFP_KERNEL), order=0, oom_score_adj=0

I agree with the underlying goal, keep the driver alive and let the
stressors absorb the OOM pressure, but I'd like to suggest a different
way that mirrors what we already do in the C harness, and that fixes
this at the lib level rather than in the individual test.

In lib/tst_test.c we don't raise the score of the stress/test processes.
Instead we protect the harness and then explicitly drop that protection
in the child before it runs the actual test:

$ grep -A 8 -B 9 tst_enable_oom_protection lib/tst_test.c

void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
{
	unsigned int test_variants = 1;
	struct utsname uval;

	tst_test = self;

	do_setup(argc, argv);
	tst_enable_oom_protection(context->lib_pid);

	SAFE_SIGNAL(SIGALRM, alarm_handler);
	SAFE_SIGNAL(SIGUSR1, heartbeat_handler);

	tst_res(TINFO, "LTP version: "LTP_VERSION);

	uname(&uval);
	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);

$ grep -A 8 -B 9 tst_disable_oom_protection lib/tst_test.c
	alarm(context->overall_time);

	show_failure_hints = 1;

	test_pid = fork();
	if (test_pid < 0)
		tst_brk(TBROK | TERRNO, "fork()");

	if (!test_pid) {
		tst_disable_oom_protection(0);
		SAFE_SIGNAL(SIGALRM, SIG_DFL);
		SAFE_SIGNAL(SIGUSR1, SIG_DFL);
		SAFE_SIGNAL(SIGTERM, SIG_DFL);
		SAFE_SIGNAL(SIGINT, SIG_DFL);
		SAFE_SETPGID(0, 0);
		testrun();
	}

The important detail is that oom_score_adj is inherited across fork.
So the model is: the library process sets itself to -1000, and child
resets itself back to 0 before doing any real work. The harness survives,
the workload stays a normal OOM candidate.

What do you think about doing this in the shell lib so all shell
tests benefit, rather than only memcg_stress?

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
