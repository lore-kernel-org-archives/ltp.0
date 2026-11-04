Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4A3606A332
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 03:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=W+3rtJMn
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2084F3CA2D5
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 04:30:58 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 58B183C8F47
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 04:30:43 +0100 (CET)
Received: from mail-dy2-x09.google.com (mail-dy2-x09.google.com
 [IPv6:2607:f8b0:4864:36::9])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E074B2003B5
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 04:30:42 +0100 (CET)
Received: by mail-dy2-x09.google.com with SMTP id
 5a478bee46e88-36c9b5c6faaso86962eec.0
 for <ltp@lists.linux.it>; Tue, 03 Nov 2026 19:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793763041; x=1794367841; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VvT2PfhHjravMzGBaSkeKaphbY12PIOjpuMYagJmsvc=;
 b=W+3rtJMnO8w6ef9vNlbb894Y0j2yJWfelXHJBSY9cpIsli97JMRir6bsSxv3L4icXZ
 z7JbyP+kz0epyrxhXlLdzgFaowqiJc3KbjZxFz21Lo7KpSfaaIemLktSkoDSYP/1CQEE
 yRPVAqTeD+QVdVaa66kYn8GwTc11SMsmU8/IgrzuKenDQgbfB4ZEW8QI1KXy3bRvt69J
 CmpzBdlzKfp+InoqFxdwy1x287I+0iRhYEFJNBaXmTmNun5PFsveqSBDcYwl0doisPJe
 7ezH48bFmy0zLdFHFV/JnRbD7d9wAiEvwGZ+1JIAnuzDqMG0GyGgm2wKlARU7bEB+j2+
 Hj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793763041; x=1794367841;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VvT2PfhHjravMzGBaSkeKaphbY12PIOjpuMYagJmsvc=;
 b=uj3GaEW3lNFe2u5uiggT3FoA0fVTSaP55jtlDhuDvW3rG+UuGnvTJzOM9YOuHOvsmk
 GYvOv0b/sKogScJlGfpf4/QVaz3BYVRQ5WWEOGrOO2lK/viWl3xT8XasWsmcfyqGve+5
 2Tg0tL5Ebs3aE4kQh/F/jJxewVYwyRtoA/mZBd/ECc8x6q80MdtYxUpynNWR0WWG6iK+
 DXn2PqA8bsFDs+WrWoOLkE+yyQcVLeDMqKR6WbnzoGO9XD5CGZKI6HyNfqYlnMrpPDJD
 N5F0AGfq7CXJFTpS8AIuT0OsmjBHPzli1uxM8EqFN89zeiDm6TbvkCXEwLgxv98C7FcY
 V6XA==
X-Gm-Message-State: APuU4Z9IUUCv1SneXMqxGCeDxQ8hG8wk/BL53XR7wjv+wDzjH7tKs/Ic
 NMmjnpgvaG6T3cpDX8hkAKRR89QD6YML82s1rGTJ+g3wTRfkYQiEtrr9
X-Gm-Gg: AYBFou2AbpdeBXNV9lr2l95yRvu4uwS3+pKYkks+W9htReAEdQszRH52U8hCpLw8rbi
 LVjJxfX1HcmoKcQzRD5sg9ZanNtPHovoOdqaApFE9jKd4BqYpCaEJfxlV7ymMiMgdNT3sNP2fSd
 dGmdcXVbY2Ns4vyK/OD9SGEmt9gHTgGHiY32R+e/uB/jvoBWk7G7WqJY+U3Bt2o+C3WbtZ1bQ25
 vgY20tcYLoXOr7YzeiEZb2FoMZZpVhISGPuHGXMAjGAjzRxMdWVG0npyNk3j4KLwaWXprVyH8L+
 EV8OHYAMKE9C1x24loTMFMu5Mc0vEaNbDwu96VuKf0dcFikhf7cQ0IF5WiHpEHhJ2kS/mhL18dz
 0V78+vjgTeAxH3EDiPaRlWPJMfQAiHdkpNKNn9xHvYwedFhPc/wNlBqMjYQFdFbkdSEwDEnCZCJ
 UkVYgZhlOTcKhptvlI3AMrcQ2bTLcmHbPzKQWwDzufjirBHC/2CSNgvN/TTSUmpK28ykR8KBbPZ
 t92FjBtH52toVz3BAvD1vtZVo2NQKtXamkcvgh56qvYs4UMVMS3RQF8vrlIyS++hjZRKpEa6WnN
 rHu8LmzaMqSzftPSgcjygFSEoGAkojthgGx4u4gmhvqEqgM7Xzf84ScYK/UebZbi+osZQaSaTRJ
 cH82rbbD7rY7TV9foLOSc9H9dkZ1BCGp8Ts1i4HIBQ7GZTQ==
X-Received: by 2002:a05:693c:42d9:b0:369:f18f:3492 with SMTP id
 5a478bee46e88-36a423fbc3amr23140987eec.35.1793763040956; 
 Tue, 03 Nov 2026 19:30:40 -0800 (PST)
Received: from
 runnervmnwato.buumwhvxvqyupaxsrmke3llhkg.phxx.internal.cloudapp.net
 ([172.182.245.131]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36ca3966daasm3550550eec.23.2026.11.03.19.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 19:30:40 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Changwei Zou <changwei.zou@canonical.com>
Date: Wed,  4 Nov 2026 03:30:39 +0000
Message-ID: <20261104033039.3895-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104002400.56841-2-changwei.zou@canonical.com>
References: <20261104002400.56841-2-changwei.zou@canonical.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpuset_memory_spread: rewrite as a C test using the LTP
 cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Changwei,

On Wed Nov 4 11:24:00 2026 +1100, Changwei Zou wrote:
> cpuset_memory_spread: rewrite as a C test using the LTP cgroup library

> + * where the file's pages landed. Instead of looking at the noisy global
> + * per-node page-cache counters in ``/sys``, it accounts for only the data
> + * file's own pages: after reading the file it mmaps it, faults every page
> + * in and uses ``move_pages()`` (with a NULL node array, so nothing is

Use :manpage:`move_pages(2)` instead of ``move_pages()`` in the doc comment.

> +/* Build the cpuset.cpus string listing all online CPUs of node 'nd'. */
> +static void node_cpus(int nd, char *cpus, size_t size)
> +{
> +	int ncpus = 0, i;
> +	long online;
> +	char path[PATH_MAX], buf[32];
> +
> +	while (tst_path_exists(PATH_SYS_SYSTEM "/cpu/cpu%d", ncpus))
> +		ncpus++;

numa_helper.h (linked via testcases/kernel/include/lib.mk) already provides
write_node_cpusets(), which gathers a node's online CPUs and sets
cpuset.cpus and cpuset.mems. Use write_node_cpusets() instead of duplicating
this helper.

> +	fd = SAFE_OPEN(DATAFILE, O_RDONLY);
> +	while ((ret = read(fd, buf, sizeof(buf))) > 0)
> +		;
> +	if (ret < 0)
> +		tst_brk(TBROK | TERRNO, "read %s", DATAFILE);
> +	SAFE_CLOSE(fd);

Use SAFE_READ(0, fd, buf, sizeof(buf)) in the loop instead of raw read() and
a manual error check.

> +static void run(void)
> +{
> +	int a = nodes[0];
> +	int b = nodes[1];
> +	const int expect_a[] = { a };
> +	const int expect_b[] = { b };
> +	const int expect_ab[] = { a, b };
> +
> +	do_spread_test(a, -1, 0, expect_a, 1,
> +		       "spread off, single node: local allocation");
> +	do_spread_test(a, -1, 1, expect_a, 1,
> +		       "spread on, single node: all on that node");
> +	do_spread_test(b, -1, 0, expect_b, 1,
> +		       "spread off, single node: local allocation");
> +	do_spread_test(b, -1, 1, expect_b, 1,
> +		       "spread on, single node: all on that node");
> +	do_spread_test(a, b, 0, expect_a, 1,
> +		       "spread off, two nodes: local allocation");
> +	do_spread_test(a, b, 1, expect_ab, 2,
> +		       "spread on, two nodes: even spread");
> +}

Define a struct tcase array and use .test + .tcnt = ARRAY_SIZE(tcases) in
struct tst_test instead of calling do_spread_test() multiple times from
.test_all. Also, in the original test_spread_page1(), cases 3 and 4 kept
cpuset.cpus on node a while setting cpuset.mems to node b to verify
non-local memory node allocation, whereas passing b as cpus_node here binds
both cpuset.cpus and cpuset.mems to node b and repeats cases 1 and 2.

> +	counts = SAFE_MALLOC(MAXNODES * sizeof(*counts));
> +
> +	tst_fill_file(DATAFILE, 0, 1024 * 1024, FILE_MB);
> +
> +	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());

tst_fill_file() does not call tst_brk() on failure; it unlinks DATAFILE and
returns -1, which later causes SAFE_OPEN(DATAFILE, O_RDONLY) to fail with
ENOENT. Check the return value of tst_fill_file() and call tst_brk(TBROK |
TERRNO, ...) on non-zero return.

> +	.test_all = run,
> +	.needs_cgroup_ctrls = (const char *const []){ "cpuset", NULL },
> +	.needs_cgroup_ver = TST_CG_V1,
> +};
> +
> +#else
> +	TST_TEST_TCONF(NUMA_ERROR_MSG);
> +#endif

Pass a literal string to TST_TEST_TCONF() (e.g.
TST_TEST_TCONF("test requires libnuma >= 2")) without leading indentation
instead of the NUMA_ERROR_MSG macro.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
