Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B05A606A32C
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 00:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=PY77ij0z;
	dkim=fail reason="signature verification failed" (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=irDlrDfh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793751872; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=+d8KN9bPKLhA5O9TAijnhS4KLGAFMbHJNBfgijnW5eE=;
 b=PY77ij0zobY4Hcn6Wi4DKL5w4YvO8AMW7w4oukW8Z+SxBsjfbJ+KFJ/JkWCYtYZniddbZ
 835leGzHlSaeguhmFxeoiJKQkwXhxyynS3rq5mogPjLPpeqXIvI4YYD8TZJPVU8WSkp/WEP
 m9tteHgXYeGecK2EGi9Lz3hJOU/kX6w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8BF7F3CA17F
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 01:24:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B8073C0F03
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 01:24:10 +0100 (CET)
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 065D02000AF
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 01:24:09 +0100 (CET)
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id A2CB83F684
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 00:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1793751848;
 bh=9TsB8D8Ycte+0S8u5UrfNF+jjPChMq7s3z3nsHrfEGI=;
 h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
 b=irDlrDfhLc1EHPPLaTWh7lQuBHJFGzeOJyxHTLKsSO7IlEoOCqH7XPubv306w7JmS
 dR5FJIPdEYyHzFMlTT+usEgXODT47Ubp/a2iT+dIruI6/kk7yk7POsX2TfY+jeOW8m
 c9Lh94tqUhF0KwAs2d+IRdRX1V4FVWidQnEo8z3eRNxc19/vgijfs01xNY7KYXll8U
 sUfkdi2dpbaMYhchD+U0m03YR6aHlS+GkxBcmFH8QB625j2BhmFfwcH1LbRXHw3OYw
 eWwjbU+z059IvABvgz1K1bC5HWZKzeZkxozWdHR3lAv4ZSvuzN/kTv96fiHArIYbxY
 ldaKVH4PgCOzvCBWkgglR/TZUQOylAyMk4PNOgczw9XsU6Qu7H9HAaeuAbCNZdyfcm
 cBTVMH5ld+hU8RcchgqwLz49sUqgE57Cn+1JPuZXh9AynyQCPNbNYfHf8bB3mk2Fi+
 I9Bp6YTK50Ne4DDbMHMPYcJ0epDQCRWWIfwi5MzD/375bJeyB2vrrMye6YI6QJsZq2
 XDGztXuMbI9sDyFMYGQ+0c3HlH6a3cSwo/IRKmr9G0lM36Zt2x/65MTp6IIAN50t66
 vQy3jjeYF6YpgY+yW5GUk12merJjVbS+kwhLnI6fzI7segT1XtRuSyngHRN2gu/j7K
 g6bG9gb+A7tVMCAP+k+Fb1Hc=
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-16bc6f3fdb1so230674c88.0
 for <ltp@lists.linux.it>; Tue, 03 Nov 2026 16:24:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793751847; x=1794356647;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9TsB8D8Ycte+0S8u5UrfNF+jjPChMq7s3z3nsHrfEGI=;
 b=STb1eenCKXMQYcR2CIOUbogTT1KDXqYMq6KHgV/kZAlFyLOCQEBWICjYg52fp+2JuT
 LnaMzmMhjaGb/Mt2QiAlpwEE3+O4CfRUCyaWnon0Cs1+lOj47erxt5k7vGnJKaJvlJws
 GSfG4B4Eqh1/AdGxnyLrgn9kVIUOt20gEB4swouxChtCXTgx8hemhj9BlWmq1p6mhPXO
 e1vkp7J9oW0hWSFQ1ybwbFjO++HSwuoGrgrQuXL13e+EniF+pQw5Zr87mj8XiuqWyAOZ
 ioO4L1ZpputwAu1ZZ0bPhRjGQsFdGYJ2D8WQlABX6uA1NE3k+us9ExP3cV6TBs4SxBHV
 gbXw==
X-Gm-Message-State: APuU4Z8M2FiSemxw00/k2XZevnvoFtEp/QgCG7pQJwA+IXXd7mvA4+3b
 zfunRAXoezOcrR9huU5thrJaJu/4cHEA0WQcW+vSE1V7oyJcognUdWhKOuQwTAq37+hKwRXeZPW
 tWc0R1EgVMs8GeM9laQSMAdYdqF36OIjKMIfI6NDF8k1NPsvnjRgPgB8oYh84HAaBXbOLWCiEbv
 9/gYc=
X-Gm-Gg: AYBFou13LXcPkIBY3xmgFDnWE2GXdxw9NyqwsrFM1HdvkmDdsZm1IJrIwwY30u7ehNv
 cb8XYqfFf/Qi4Fn/0vJK71CM2K3a1w1rW1Y7OHtz3Y62gKLmx6au5dqUzVJ8hS7RIDttB/MP5RH
 aI8fBRAKYuD4b9ZJLPSitK3Fhz8BhQPMN0/WrwQPTwB9fpIrFTiWkLD++A4iKYX0p+2UmBD+2+0
 Rbk1nx0R2gkD88DRpDzT49c436nkPhRuSMOZbAaEomh/pxs9TUHMtlyYHquWtXIV2GsgxHSULdo
 AQpq6HCtuGvlL9TOZ6FCBqeP8m6FzFH5UoDqovSp6ECaZnFJs6g+z0ewa0e0Ahp3bdIeopJbJwU
 /buKalKQUvA6zfF9F6qKBomkK3lw1yt7tmqYrovypNufaQsUCTKXypm7vUj8=
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id
 a92af1059eb24-1ade740e699mr20117421c88.42.1793751846951; 
 Tue, 03 Nov 2026 16:24:06 -0800 (PST)
X-Received: by 2002:a05:7022:3a02:b0:1ad:e740:e51e with SMTP id
 a92af1059eb24-1ade740e699mr20117380c88.42.1793751846401; 
 Tue, 03 Nov 2026 16:24:06 -0800 (PST)
Received: from ZBook.gateway ([123.208.39.53])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1b245c65194sm2199998c88.19.2026.11.03.16.24.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2026 16:24:06 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 11:23:59 +1100
Message-ID: <20261104002400.56841-1-changwei.zou@canonical.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 0/1] cpuset_memory_spread: rewrite as a C test
 using the LTP cgroup library
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Changwei Zou via ltp <ltp@lists.linux.it>
Reply-To: Changwei Zou <changwei.zou@canonical.com>
Cc: Changwei Zou <changwei.zou@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The cpuset_memory_spread test (from 2009) was split between a shell script
that mounted /dev/cpuset by hand and a C helper (cpuset_mem_hog) driven over
a FIFO and SIGUSR1/SIGUSR2. It checked the cpuset.memory_spread_page policy
by comparing the global per-node FilePages counters in
/sys/devices/system/node/nodeX/meminfo, which also account for unrelated
page-cache activity, so on large or busy NUMA machines the empirical
thresholds became unreliable and the test failed spuriously.

This series rewrites it as a single C test on the new LTP test API and the
LTP cgroup library (tst_cgroup.h), dropping the shell script, the
FIFO/signal handshake and the manual /dev/cpuset management. It now accounts
for only DATAFILE's own page-cache pages via move_pages(2) (NULL node array,
so nothing is migrated), so unrelated page-cache activity can no longer
perturb the result.

cpuset.memory_spread_page only exists in the cgroup v1 cpuset controller, so
the test requires a v1 cpuset hierarchy (.needs_cgroup_ver = TST_CG_V1) and
is skipped (TCONF) on a unified (v2) hierarchy. The patch also registers
cpuset.memory_spread_page in the LTP cgroup library's cpuset file table so
it can be driven through the SAFE_CG_* helpers.

Tested on a 2-node NUMA machine with a v1 cpuset hierarchy: all six subtests
pass.

Changes in v7:
  - Rewritten from the shell+helper pair into a single C test using the
    LTP cgroup library (per maintainer feedback).

v6:
https://lore.kernel.org/ltp/20260905125041.27985-1-changwei.zou@canonical.com/T/#t

Changwei Zou (1):
  cpuset_memory_spread: rewrite as a C test using the LTP cgroup library

 lib/tst_cgroup.c                              |   1 +
 runtest/controllers                           |   2 +-
 .../kernel/controllers/cpuset/.gitignore      |   2 +-
 .../cpuset/cpuset_memory_spread_test/Makefile |   2 +-
 .../cpuset_mem_hog.c                          | 126 ------
 .../cpuset_memory_spread01.c                  | 394 ++++++++++++++++++
 .../cpuset_memory_spread_testset.sh           | 362 ----------------
 7 files changed, 398 insertions(+), 491 deletions(-)
 delete mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_mem_hog.c
 create mode 100644 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread01.c
 delete mode 100755 testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
