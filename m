Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6890DD5C0C3
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 12:59:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EF0C3D4957
	for <ltp@archiver.kernel.org>; Fri,  8 Nov 2024 13:58:58 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 25DC53D494F
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 13:58:42 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 875F81020F0C
 for <ltp@lists.linux.it>; Fri,  8 Nov 2024 13:58:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6064F1FE34;
 Fri,  8 Nov 2024 12:58:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731070720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4maN3jBFn/En6eIeOE6LVV1LCFpfp8utI3dEmY+Ku8=;
 b=Raad5XCmT4VVbm/H6E6ebFP1pUnjO2ViyJHQG/wwa/5ZIbPMVRD6N+RWRW1m0uHok1LsLo
 rMrU53VxNNCmtCpiigYAcDHqbNfrPS4nWsmqc0HmQ8HpLyK+bOCWEs1tuFDpcvDkdelKzX
 0K8bCgD7dVjbUNyTJDDHdp26ouzSTHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731070720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4maN3jBFn/En6eIeOE6LVV1LCFpfp8utI3dEmY+Ku8=;
 b=rovaVTeYpGQHsuA9XhEEK3JOf39wtdB2/5XrQK/JYH61sIdaaJtrtc80p7DU4a+gbSDkm8
 qh/MCK9+DDT2d6Bw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731070720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4maN3jBFn/En6eIeOE6LVV1LCFpfp8utI3dEmY+Ku8=;
 b=Raad5XCmT4VVbm/H6E6ebFP1pUnjO2ViyJHQG/wwa/5ZIbPMVRD6N+RWRW1m0uHok1LsLo
 rMrU53VxNNCmtCpiigYAcDHqbNfrPS4nWsmqc0HmQ8HpLyK+bOCWEs1tuFDpcvDkdelKzX
 0K8bCgD7dVjbUNyTJDDHdp26ouzSTHQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731070720;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4maN3jBFn/En6eIeOE6LVV1LCFpfp8utI3dEmY+Ku8=;
 b=rovaVTeYpGQHsuA9XhEEK3JOf39wtdB2/5XrQK/JYH61sIdaaJtrtc80p7DU4a+gbSDkm8
 qh/MCK9+DDT2d6Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 324491394A;
 Fri,  8 Nov 2024 12:58:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id /8ZqCQALLmfKZgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Nov 2024 12:58:40 +0000
Date: Fri, 8 Nov 2024 13:58:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Samir Mulani <samir@linux.vnet.ibm.com>
Message-ID: <20241108125823.GA88155@pevik>
References: <20241025204912.1900449-1-samir@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241025204912.1900449-1-samir@linux.vnet.ibm.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Migrating the
 libhugetlbfs/testcases/alloc-instantiate-race.c test
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it, rnsastry@linux.ibm.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Samir,

Not a whole review, just few notes.

nit: missing static:
$ make check-hugemmap36
hugemmap36.c:28:15: warning: Symbol 'totpages' has no prototype or library ('tst_') prefix. Should it be static?
hugemmap36.c:91:6: warning: Symbol 'check_online_cpus' has no prototype or library ('tst_') prefix. Should it be static?

...
> diff --git a/runtest/hugetlb b/runtest/hugetlb
> index f294e9aaa..cc1e56f16 100644
> --- a/runtest/hugetlb
> +++ b/runtest/hugetlb
> @@ -35,6 +35,7 @@ hugemmap29 hugemmap29
>  hugemmap30 hugemmap30
>  hugemmap31 hugemmap31
>  hugemmap32 hugemmap32
> +hugemmap36 hugemmap36
You added hugemmap36 without -m ... parameter, but that fails.
I also wonder if we should test both private and shared or just one.
Also, if one more important, maybe it could be a default (thus no mandatory to
pass it with -m ...) and the other one optional.

Also I get warning for shared:

./hugemmap36 -m shared
tst_hugepage.c:84: TINFO: 2 hugepage(s) reserved
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_hugL2gsLX as tmpdir (tmpfs filesystem)
tst_test.c:1100: TINFO: Mounting none to /tmp/LTP_hugL2gsLX/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:1890: TINFO: LTP version: 20240930-63-g6408294d8
tst_test.c:1894: TINFO: Tested kernel: 6.12.0-rc6-1.gb3de43a-default #1 SMP PREEMPT_DYNAMIC Mon Nov  4 00:37:44 UTC 2024 (b3de43a) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
hugemmap36.c:241: TINFO: Mapping 1/2 pages..
hugemmap36.c:213: TINFO: instantiating..
hugemmap36.c:132: TINFO: Mapping final page..
hugemmap36.c:145: TINFO: Child 1 status: 0

hugemmap36.c:149: TINFO: Child 2 status: 0

hugemmap36.c:219: TPASS: Test done
hugemmap36.c:251: TWARN: kill(3887,SIGKILL) failed: ESRCH (3)
hugemmap36.c:253: TWARN: kill(3888,SIGKILL) failed: ESRCH (3)

Test is failing when run more than once:
./hugemmap36 -m private -i2
tst_hugepage.c:84: TINFO: 2 hugepage(s) reserved
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_hugBynfWl as tmpdir (tmpfs filesystem)
tst_test.c:1100: TINFO: Mounting none to /tmp/LTP_hugBynfWl/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:1890: TINFO: LTP version: 20240930-63-g6408294d8
tst_test.c:1894: TINFO: Tested kernel: 6.12.0-rc6-1.gb3de43a-default #1 SMP PREEMPT_DYNAMIC Mon Nov  4 00:37:44 UTC 2024 (b3de43a) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
hugemmap36.c:241: TINFO: Mapping 1/2 pages.. 
hugemmap36.c:213: TINFO: instantiating.. 
hugemmap36.c:132: TINFO: Mapping final page.. 
hugemmap36.c:219: TPASS: Test done
hugemmap36.c:213: TINFO: instantiating.. 
hugemmap36.c:105: TBROK: At least 2 online CPUs are required : ECHILD (10)

Ideally it'd allow to run test more times with -iN or -IN.

Could you please rebase your branch before posting a new version?
(conflict in the runtest and .gitignore)

> diff --git a/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c b/testcases/kernel/mem/hugetlb/hugemmap/hugemmap36.c
...
> +static int one_racer(void *p, int cpu,
> +		     volatile int *mytrigger, volatile int *othertrigger)
> +{
> +	volatile int *pi = p;
> +	cpu_set_t *cpuset;
> +	size_t mask_size;
> +	int err;
> +
> +	// Allocate CPU mask dynamically
> +	cpuset = CPU_ALLOC(cpu + 1);
> +	if (!cpuset)
> +		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
> +	// Get the required size for the allocated CPU set
nit: some comments for obvious things (like this one) are IMHO useless
> +	mask_size = CPU_ALLOC_SIZE(cpu + 1);
> +
> +	/* Split onto different CPUs to encourage the race */
> +	CPU_ZERO_S(mask_size, cpuset);
> +	CPU_SET_S(cpu, mask_size, cpuset);
> +	// Set CPU affinity using the allocated mask size
> +	err = sched_setaffinity(getpid(), mask_size, cpuset);
> +	if (err == -1)
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
> +	/* Ready */
> +	*mytrigger = 1;
> +	/* Wait for the other trigger to be set */
> +	while (!*othertrigger)
> +		;

Shouldn't be here at least minimal usleep() to avoid burning CPU?
Maybe not, because test is really fast.

> +	/* Set the shared value */
> +	*pi = 1;
> +	// Free the dynamically allocated CPU set
Do we need to document this?
> +	CPU_FREE(cpuset);
> +	return 0;
> +}
...

> +static void setup(void)
> +{
> +	totpages = SAFE_READ_MEMINFO(MEMINFO_HPAGE_FREE);
> +	hpage_size = tst_get_hugepage_size();
> +
> +	if (str_op)
> +		if (strcmp(str_op, "shared") == 0)
> +			race_type = MAP_SHARED;
> +		else if (strcmp(str_op, "private") == 0)
> +			race_type = MAP_PRIVATE;
> +		else
> +			tst_res(TFAIL, "Usage:mmap<private|shared>");
It should tst_brk(TBROK, ...) on invalid parameter:
1) tst_brk() to quit the testing immediately
2) TBROK is more suitable than TFAIL in this case.
I also find "Usage:mmap<private|shared>" misleading - I first tried
"mmapprivate".

> +	else
> +		tst_res(TFAIL, "Usage:mmap<private|shared>");
As I said, one could of these be a default.
> +
> +	fd_sync = tst_creat_unlinked(MNTPOINT, 0);
> +	/* Get a shared normal page for synchronization */
> +	q_sync = SAFE_MMAP(NULL, getpagesize(), PROT_READ|PROT_WRITE,
> +			MAP_SHARED|MAP_ANONYMOUS, -1, 0);
> +	tst_res(TINFO, "Mapping %ld/%ld pages.. ", totpages-1, totpages);
> +	p_sync = SAFE_MMAP(NULL, (totpages-1)*hpage_size, PROT_READ|PROT_WRITE,
> +			MAP_SHARED, fd_sync, 0);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd_sync >= 0)
> +		SAFE_CLOSE(fd_sync);
> +	if (child1)
> +		SAFE_KILL(child1, SIGKILL);
> +	if (child2)
> +		SAFE_KILL(child2, SIGKILL);
> +}
> +
> +
> +static struct tst_test test = {
> +	.options = (struct  tst_option[]){
> +		{"m:", &str_op, "Usage:mmap<private|shared>"},
maybe:
		{"m:", &str_op, "Type of mmap() mapping <private|shared>"},

(see ./hugemmap36 -h for whole output)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
