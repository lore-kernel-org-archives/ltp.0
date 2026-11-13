Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315CB606A31C
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 03:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=fxizpXzo;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=DngG28KU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794539339; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=1OqxDoxHukOqgPIaNP+vz+UvkpZ1PzgmEly3YD1BRkg=;
 b=fxizpXzoSMktYZYKYkYB+9lP5G3l4klWxikP8WfikPjSVlxf7YVM3NYvqxwEoc2c4dk4r
 nS5meFAofzBFEaFMqUhl+h/alWZjm+0uMLcD8iX+I+AWDTQQqFNhGEcQrJU140RpcSP3Ld+
 SR/fyQ9HjmChecD8l8C5NYbH4TTluOM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AF363EAC35
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 04:08:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D9CD3CA78C
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 04:08:39 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78F3F1000A5F
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 04:08:39 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a140e7405dso5797195e9.3
 for <ltp@lists.linux.it>; Thu, 12 Nov 2026 19:08:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794539319; x=1795144119; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=i62GWYqMMHdCN5CKq/0lOjbrnWQAswMNtvYcFxYnuO0=;
 b=DngG28KUoP6nPRv0z2GbMgrUMzaM8lag6toPYrIn6LfIle832x2G5/x+ka78JV1WhM
 FLvTMMlJ5F1INmr1KfJqkKKfL1JQw7H5dGSlJkXZyQK2I2/OxY21VWHGz0Vi4wBCdkm4
 qWPS1DPTgpEikuAiH7JCsiucnDXcr4CnGAteWqy4KbynJE2+1Y/5peGv6ExJfS+umjbB
 H3kRQIKhcu3Pi8McyDL1WMtGlyn0sLHcYyUNXeKf4fNilojL48PrmXiTRzJXo7J59oxM
 YYzIXhJpeTGnY1cWHI05vtS1jxNj+9SEA2qgX+7co0Nu68DPz7UUvNOExgUe66FELY9d
 hiEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794539319; x=1795144119;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=i62GWYqMMHdCN5CKq/0lOjbrnWQAswMNtvYcFxYnuO0=;
 b=IAv8GO3Y1E89BXb5lh1uGqCa1hIXjrluZiJ/n/iOuiiWYfQ7eZ/KEi5x4OntwDcJzB
 ZOvTRjNYw7XtHbHj06lLP5x1KfywlYvw6l0iPujgxv6nA3FYWtKAwIs80zvtcex7DANo
 A6ZPK7sMXJztMCRXe5y4R9Os7HJIDSRgIV/2ovSQcd0TDp5OK+jIZlHmNeivpKKuGn3D
 36lOjo+4xdDyitXe+mgcHgoHf08fMcm7NHuoo5+8tUVkDptgyhpL/6eQbIAGskEu2ql3
 z5YXtzydy3Vx0iSCqFgLexMbz5n/S91/PHi5xRB/8abbsIjo6Aiysdt4YUiSgXoshH+M
 pU/w==
X-Gm-Message-State: APuU4Z+PbsrbYuTDJ//33mkR9gMjI/ghwRsRxc0oboYiPlD0vtGcGFN4
 Rwg7SzatI+rmJyPRQATMym07VvrN2Ns5mdMv6nKw62nOV46QSmjLlc+3sm7hXJJ4G+YSd7KVqQn
 /pA1VKg==
X-Gm-Gg: AYBFou32EBKGeMX1XIg28F1n8KjspXk91xAeixq8kGlEa+hmx5CKH/QC/NQ66MaLNLH
 ab2Ob/G6TZTrni6IY51+bfc+qp7nhV73z5Nv5GspEatJ8HZ7i9L48GYQrP7DTBgC7bB9vdMFMz1
 PaOZiHxdRB9kTMR39uOev9MX5AkjU6P55ZF8Jy+fft4tedaf9QXftvDLa0KyXAdIDhbLLZWRWYE
 aX2bzZssngcMOxBkTqefQ8iMhjBDIXnBxEaw9EPqo/r8vGGmmPAqgsforZ7km3Ir1G0by9SjUXE
 RzOx+wXzThswEaoQG4jgAr/A1WoElxxKuWZx7sQaIMzpdqFe0yni1Q7wUHHMUqUgE2TOuOhOYYw
 A0udTC00r/RJZ5b8rfIbU6lFZvuzfuYXQmM5hTp4TTadRSKxfizTS6lEmlRjBiaBlOF17XNZu20
 rxLKZ55ufDNKPwxXpw52NITUNIuzHWg1Wzozuof8ACOBgGitITjui8qcvjisoTlPOpDHbDjv0My
 wFGHMBazWN/+J0cSZKDy0iVvvDCyBNTPVP7jDu8KA5jAsDtXOUzbsHa0oQmBxg8EBs3uG3RBYRx
 1vrUMsNKwaG0yo6wEnGsuCpyhEV50KuNFloMGPGOQg5Gba3+fNNFs3z1en08/o/EuH0JksOpBAM
 fTcoENnKQ7R3ZaKFw0qcCZJiL8uFI4yXWxA==
X-Received: by 2002:a05:600c:37cf:b0:4b2:2ec5:8a2b with SMTP id
 5b1f17b1804b1-4bb55a4301emr25145505e9.10.1794539318802; 
 Thu, 12 Nov 2026 19:08:38 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4bb55a68c5asm24863545e9.1.2026.11.12.19.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 19:08:38 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 13 Nov 2026 03:08:22 +0000
Message-ID: <20261113030836.16976-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261111081150.15101-1-wegao@suse.com>
References: <20261111081150.15101-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] swapon04: Settle udev after mkswap on kernels <
 5.18
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When mkswap formats and closes the loop device, systemd-udevd
asynchronously runs blkid probing on the device. On kernels prior to
5.18, tmpfs shmem_file_read_iter() treats non-iovec read iterators
(!iter_is_iovec(to)) as stacking filesystem reads, allocating real
zero-filled pages into holes (this behavior get fixed by commit
56a8c8eb1eaf ("tmpfs: do not allocate pages on read")).

When a udev worker reads the loop device after swapon-time discard
has punched holes in the tmpfs backing file, the probing reads
re-allocate up to 84 zero-filled pages (672 blocks), causing
blocks_after to exceed max_header_blocks and failing the test
intermittently on tmpfs (e.g. observed on SLE 15-SP4 aarch64):

  swapon04.c:167: TFAIL: blocks_after (672) > max_header_blocks (16)

Tracing block:block_rq_issue confirms that udev-worker reads the loop
device after discard has punched the holes:

  # mkswap writes swap header
  mkswap-703     [000] ..... 2100.340705: block_rq_issue: 7,1 WS 4096 () 0 + 8 [mkswap]
  # sys_swapon reads swap header
  swapon04-701   [000] ..... 2100.345665: block_rq_issue: 7,1 R 4096 () 0 + 8 [swapon04]
  # swapon-time discard punches holes across sectors 8..32767
  kworker/0:1H-31[000] ..... 2100.345715: block_rq_issue: 7,1 DS 16773120 () 8 + 32760 [kworker/0:1H]
  # udev-worker probes loop device 5.5ms after discard, re-allocating tmpfs pages
  (udev-worker)-655 [001] .. 2100.351255: block_rq_issue: 7,1 RA 4096 () 32640 + 8 [(udev-worker)]
  (udev-worker)-655 [000] .. 2100.351302: block_rq_issue: 7,1 RA 4096 () 32752 + 8 [(udev-worker)]
  (udev-worker)-655 [000] .. 2100.352286: block_rq_issue: 7,1 RA 126976 () 264 + 248 [(udev-worker)]

On kernels prior to 5.18, wait for udev to settle after mkswap so that
probing completes before swapon discards the area. On 5.18+, skip settling
so that any regression causing tmpfs to allocate pages on loop reads
is not masked.

Fixes: aabccf0a0117 ("swapon04: Add test for discard flags")
Signed-off-by: Wei Gao <wegao@suse.com>
---
v1->v2:
- Add udevadm to .needs_cmds
- Skip udevadm settling on 5.18+

 testcases/kernel/syscalls/swapon/swapon04.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/syscalls/swapon/swapon04.c b/testcases/kernel/syscalls/swapon/swapon04.c
index de95849e3..e0d59d042 100644
--- a/testcases/kernel/syscalls/swapon/swapon04.c
+++ b/testcases/kernel/syscalls/swapon/swapon04.c
@@ -138,6 +138,7 @@ static void verify_swapon(unsigned int n)
 	struct stat st;
 	blkcnt_t blocks_before, blocks_after;
 	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
+	const char *const udevadm_argv[] = {"udevadm", "settle", NULL};
 
 	tst_res(TINFO, "Testing swapon(%s, %s)", loop_dev, tc->desc);
 
@@ -148,6 +149,8 @@ static void verify_swapon(unsigned int n)
 	SAFE_CLOSE(fd);
 
 	tst_cmd(mkswap_argv, "/dev/null", "/dev/null", 0);
+	if (tst_kvercmp(5, 18, 0) < 0)
+		tst_cmd(udevadm_argv, "/dev/null", "/dev/null", 0);
 
 	SAFE_STAT(BACKING_FILE, &st);
 	blocks_before = st.st_blocks;
@@ -195,6 +198,7 @@ static struct tst_test test = {
 	},
 	.needs_cmds = (struct tst_cmd[]) {
 		{.cmd = "mkswap"},
+		{.cmd = "udevadm"},
 		{}
 	},
 	.needs_kconfigs = (const char *[]) {
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
