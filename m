Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E7CBC02193
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 02:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1738724111; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=5BCklIH0T1h8urVSwgo8OKjaQ4/Rk8PcYBkpIKUi5mA=;
 b=KXtPuC924px0qhhL1QoIOJH4LRlbKhp+MjIGKVbpx7iiE8D/v/OCMvthcNGXjlIlfSG+M
 yGwL2SLReW0Xtf5nUN+RXaO8tvyEHraU9gTr1sePhyt6VCnVL+c3LtAbKqDweUQTF155q8x
 2+/5SHAD3LDVWUTQxJ7w4f3V63boaSQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DF823C2DA5
	for <ltp@archiver.kernel.org>; Wed,  5 Feb 2025 03:55:11 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B02F63C2DA5
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 03:54:49 +0100 (CET)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A6F241422B74
 for <ltp@lists.linux.it>; Wed,  5 Feb 2025 03:54:48 +0100 (CET)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4361b6f9faeso2137065e9.1
 for <ltp@lists.linux.it>; Tue, 04 Feb 2025 18:54:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1738724088; x=1739328888; darn=lists.linux.it;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9Js0LoHdWpKXdIM4zynGhpGSgGPzARb5d2jY55ISCtw=;
 b=OdKH4lQHVuR75FjdvXirz/Stym9aquvClYCAe33/MXg2Lgvr+fQosgi3dxpNUPXKyx
 /4JfoLfbn5BW9n/6nTy5TOvpdzgzViGc8QPcFZfWZ79zq3e8XRwMygQEHL2+W61nxU6l
 xdhvlgjYJCemSfyGd3Czd7azFLap9EwfGxHOlExpBhV+NFl3/vCW0SeU6DXqPLu8aA5L
 vy/afWT3jjirS+z6AxvAgJpCt03kqEKfIDxlmNCc/W3BGvDSSeaHuU38OnrEcD3yZSMC
 6Wu+ladvNyna3Vj2JuMADd+J5QHMfAja2yBy6SvByMMc9wE3KDY2AWm5ZKgECDJxhyEn
 1INQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738724088; x=1739328888;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Js0LoHdWpKXdIM4zynGhpGSgGPzARb5d2jY55ISCtw=;
 b=d+DgqCEHlzzCnzzHUVEjbevTi8gox3CX5izRV6t0BqJH5WR9mddXtfAL5YfAzgi+1E
 VdaT/VNqMedeq4tndoz5wBKulZ3D7Ivl+KlnVSnGFKatv9DoBpk0jlI0mzfeTl2rwYyQ
 BvTfD5PEALXNMaKb4qCbeQ1xub9hvMwQNw/mL6fcHGPl3WYLSeDaLHiC8RA/C/LRlG0R
 HX8MNbRAsOY+yY/n8iMQujnIQ6qbowodb1DJEa60aKEG/K+xzHGClX6xLZhpYixvK/VI
 mvBn9n7fzyztunOsBHaF8VarCrP4Zlm3Gmn+YpMaIv61nAON85At70eywnZqX16PpFX7
 WHvQ==
X-Gm-Message-State: AOJu0YxS/WtJZFrVmzv6zBPYkmhIMqt+gE13dG3MQE64/FxfFc3bjvI3
 HsXD65MHuKVPaJErknyzgiVaU/qnGsJyGdH3ZMvKOhpgkeIyeJ4Vyu9mr4HNBiyAkKPESBMzvIM
 =
X-Gm-Gg: ASbGncu1mDkNsmsP7JWWv8PporaBWOGH2eAYy9OODblsbHgRTGmLXjMOBq7qsgvQOBE
 jhPSs2HvqsIf2Ewc5fNRscQKlCGpB7fEZNtQvLV44PFX/1F5UlsS5Ihvnj7+OXQOxul4MF1Ror+
 NBdbVL5tmmPl4fpMe0WpGDAHndxVKixwFPJxBGLwECpagMtquwsj2u6RKMlEjkUAfQstBxgdfGp
 t4zoMtFv3ZKbHbxWluJRsxezYfw5OpUQxj2KXjuhTLexe5Q/T40OkUA9DlorKU3MhilwvjWNWQ=
X-Google-Smtp-Source: AGHT+IGAXS+yEDwBc2KGSOm0pjH1QPMZ1mxinV2xHVa6blcmZg1QuhgACHC+n55hrL88pCcOPgRy/Q==
X-Received: by 2002:a05:6000:1fa1:b0:38c:2745:2ddb with SMTP id
 ffacd0b85a97d-38db4630f1dmr667084f8f.2.1738724087910; 
 Tue, 04 Feb 2025 18:54:47 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c5c1016a1sm17493747f8f.21.2025.02.04.18.54.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Feb 2025 18:54:47 -0800 (PST)
Date: Tue, 4 Feb 2025 21:54:41 -0500
To: jstancek@redhat.com
Message-ID: <Z6LS8SfWeWnd5A3C@wegao>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] hugemmap34 trigger oom if compile with
 CFLAGS='-fstack-clash-protection'
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan

Compiling hugemmap34 with CFLAGS='-fstack-clash-protection' causes gcc to insert additional stack address validation checks during alloca calls.  This results in kernel start allocate memory really , eventually triggering an OOM.

In our normal openqa env we do not have such big memory(1024GB) to support this test. So we
 have to disable CFLAGS='-fstack-clash-protection' if we still need this case running in our env.

===log with CFLAGS='-fstack-clash-protection'===
[71073.562094] [T13546] oom-kill:constraint=CONSTRAINT_NONE,nodemask=(null),cpuset=/,mems_allowed=0-1,global_oom,task_memcg=/,task=hugemmap34,pid=13542,uid=0
[71073.562109] [T13546] Out of memory: Killed process 13542 (hugemmap34) total-vm:4764864kB, anon-rss:2816000kB, file-rss:0kB, shmem-rss:0kB, UID:0 pgtables:636kB oom_score_adj:0

tst_hugepage.c:84: TINFO: 1 hugepage(s) reserved
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_hug2vxfh1 as tmpdir (btrfs filesystem)
tst_test.c:1097: TINFO: Mounting none to /tmp/LTP_hug2vxfh1/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:1900: TINFO: LTP version: 20240930
tst_test.c:1904: TINFO: Tested kernel: 6.4.0-150700.40-default #1 SMP Thu Jan 9 12:43:31 UTC 2025 (f78fd5e) ppc64le
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:669: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
tst_test.c:1724: TINFO: Overall timeout per run is 0h 02m 00s
hugemmap34.c:152: TINFO: searching for huge page and child stack placement
hugemmap34.c:175: TINFO: potential stack at address 0x7effff000000
hugemmap34.c:192: TINFO: stack = 0x7effff000000-0x7f0000000000, hugepage = 0x7dffff000000-0x7e0000000000
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=20714)
hugemmap34.c:56: TINFO: Child process starting with top of stack at 0x7effffffff80

tst_test.c:1785: TINFO: Killed the leftover descendant processes
tst_test.c:1792: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1793: TBROK: Test killed! (timeout?)


===log without CFLAGS='-fstack-clash-protection'===
tst_hugepage.c:84: TINFO: 1 hugepage(s) reserved
tst_tmpdir.c:317: TINFO: Using /tmp/LTP_hugjztvoX as tmpdir (btrfs filesystem)
tst_test.c:1097: TINFO: Mounting none to /tmp/LTP_hugjztvoX/hugetlbfs fstyp=hugetlbfs flags=0
tst_test.c:1900: TINFO: LTP version: 20240930
tst_test.c:1904: TINFO: Tested kernel: 6.4.0-150700.40-default #1 SMP Thu Jan 9 12:43:31 UTC 2025 (f78fd5e) ppc64le
tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
tst_kconfig.c:669: TINFO: CONFIG_LATENCYTOP kernel option detected which might slow the execution
tst_test.c:1724: TINFO: Overall timeout per run is 0h 02m 00s
hugemmap34.c:152: TINFO: searching for huge page and child stack placement
hugemmap34.c:175: TINFO: potential stack at address 0x7effff000000
hugemmap34.c:192: TINFO: stack = 0x7effff000000-0x7f0000000000, hugepage = 0x7dffff000000-0x7e0000000000
tst_coredump.c:32: TINFO: Avoid dumping corefile for process(pid=20704)
hugemmap34.c:56: TINFO: Child process starting with top of stack at 0x7effffffff80
hugemmap34.c:77: TINFO: Child process extended stack up to 0x7dfffffeff80, hasn't reached 0x7dffeffeff80
hugemmap34.c:79: TPASS: Child killed by SIGSEGV as expected

Thanks.
Regards
Gao Wei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
