Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76967E7718B
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 08:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1735286507; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=5xjOQD6HtVo8xd9DjbWclb6bz8l6uDO4Pq1muKrakr4=;
 b=aXNzTD5z+pZsJ8u0MxfC0TLl94eM+MpmIvL/zyOXa2zkxo0KfDeuQn0gDizlDHvhWY8Pm
 Ehawt+3GUZe9rZZuGwEF9U6NKKpv2o3uxaR+kAaM/ipQN2bd7cLYFWCVh1GExzjANvGG20h
 Aq1VfyUBFC5f1rAhSz56ojZazgMvbqc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2C693E11D3
	for <ltp@archiver.kernel.org>; Fri, 27 Dec 2024 09:01:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C81E3E11D3
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 09:01:26 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.47;
 helo=esa1.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa1.hc1455-7.c3s2.iphmx.com (esa1.hc1455-7.c3s2.iphmx.com
 [207.54.90.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B844652572
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 09:01:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1735286486; x=1766822486;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=lFksopVyuOEj81hezDSj1I5jxeXhwwC6b5ERCTyL6qo=;
 b=gW7QFK0LSZj35wEpHU0ytSQDmFndLkPoC2jBjGtFGjZI9BV2dkGDihD1
 FX3JwU27LDO5vxz7PKXjI5OPdAU74y1ONERDmsQZ3HS+vMSwh9JOJdSZ3
 XQB53JuWJB9HZeoXQE9tC8BeNHPZ9028OHJ5AuUw+KmO1S3dwaUAYjNHk
 SjWrqbqnxkAUeenFpkeFPis6OZEvr1lACJj1ydBtStPFteM8+h6BqbhG0
 MM+Ztjl3CFKv6PW7JxhxNKgpnuHW90/pLTrYySKJ5leC+zPH/92O4TsjJ
 eLbls7hiFICMWQPNuWljTeToSK6pKsFGxZvIM1oh3uduiGHj2ZzI+Vz/g A==;
X-CSE-ConnectionGUID: lWx9mUVtSG+Uoe7c5UvDEg==
X-CSE-MsgGUID: wgjE1VtCTou0eFN9Rz4Zmw==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="185146267"
X-IronPort-AV: E=Sophos;i="6.12,268,1728918000"; d="scan'208";a="185146267"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa1.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Dec 2024 17:01:21 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id C8F11D6EAD
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:01:18 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id 99FD2D1992
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:01:18 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 21FB420071A3A
 for <ltp@lists.linux.it>; Fri, 27 Dec 2024 17:01:18 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.135.101])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 926131A0003;
 Fri, 27 Dec 2024 16:01:17 +0800 (CST)
To: ltp@lists.linux.it,
	linux-fsdevel@vger.kernel.org
Date: Fri, 27 Dec 2024 16:01:21 +0800
Message-ID: <20241227080121.69847-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28884.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28884.006
X-TMASE-Result: 10--4.072800-10.000000
X-TMASE-MatchedRID: K/VPzqYiD+aoXGwWsKbNNDzHAJTgtKqwBMdp5178zSNgPgeggVwCFlKC
 SV79Dbqw5/gG8CUYditvedD3CYSjHUjEB+CXKX8YsrikU3BgPV2vMPxisLn2/JUKAwcqU3TdBjE
 nKR+6jgDiPg9GiifbJvLsqSqP9dnTEciEU/z3/PVv+ggm5QAi4RhBgVDb4fBgHOUhijZNQhs86a
 y9NNiI8eLzNWBegCW2wgn7iDBesS3fd+P6wwCt85Rncg/kBNofgP7Hdkpmcdepmf67L86KHvuZW
 WEPhjzeuTzpLePz2FKXXb5S+odR3Cpk6eZexLeVMUD4u+EDKx7sN0QAMaCd6QjQSq2FeR7HqSnN
 hjPe4IOzRfzYWxYz6KVFNWIr45mF6dk8zgnUZCyT76aKysvrqA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [issue] cgroup: fail to mount,
 if mount immediately after umount
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi guys,

I ran the LTP case "cgroup cgroup_regression_test.sh" on Cento10,
and found that if mounting cgroup immediately after umount, it will report 
error "cgroup already mounted or mount point busy."

But this does not occur on old kernel(such as Centos9).
Could someone help take a look?

Reproduce Step:
```
# mkdir cgroup
# mount -t cgroup -o none,name=foo cgroup cgroup
# umount cgroup && mount -t cgroup -o none,name=foo cgroup cgroup
mount: /opt/ltp/tmpdir/cgroup: cgroup already mounted or mount point busy.
       dmesg(1) may have more information after failed mount system call.
```

LTP failed case:
```
Running tests.......                                                                                                                                                                                                                                                                                                          
<<<test_start>>>
tag=cgroup stime=1735584666
cmdline="cgroup_regression_test.sh"
contacts=""
analysis=exit
<<<test_output>>>
incrementing stop
cgroup_regression_test 1 TINFO: Running: cgroup_regression_test.sh 
cgroup_regression_test 1 TINFO: Tested kernel: Linux  6.11.0-0.rc5.23.el10.x86_64 #1 SMP PREEMPT_DYNAMIC Mon Sep 23 04:19:12 EDT 2024 x86_64 GNU/Linux
cgroup_regression_test 1 TINFO: Using /tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ as tmpdir (xfs filesystem)
cgroup_regression_test 1 TINFO: timeout per run is 0h 5m 0s
cgroup_regression_test 1 TPASS: no kernel bug was found
mount: /tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ/cgroup: cgroup already mounted or mount point busy.
       dmesg(1) may have more information after failed mount system call.
cgroup_regression_test 2 TFAIL: Failed to mount cgroup filesystem
cgroup_regression_test 3 TCONF: CONFIG_SCHED_DEBUG is not enabled
cgroup_regression_test 4 TCONF: CONFIG_LOCKDEP is not enabled
cgroup_regression_test 5 TINFO: The '/tmp/ltp-q3TtUTWV42/LTP_cgroup_regression_test.68LuGosjOZ/cgroup' is not mounted, skipping umount
cgroup_regression_test 5 TPASS: no kernel bug was found
cgroup_regression_test 6 TPASS: no kernel bug was found
cgroup_regression_test 7 TPASS: no kernel bug was found for test 1
cgroup_regression_test 7 TCONF: skip rest of testing due possible oops triggered by reading /proc/sched_debug
cgroup_regression_test 7 TPASS: no kernel bug was found for test 2
cgroup_regression_test 8 TPASS: no kernel bug was found

Summary:
passed   6
failed   1
broken   0
skipped  3
warnings 0
<<<execution_status>>>
initiation_status="ok"
duration=62 termination_type=exited termination_id=1 corefile=no
cutime=4420 cstime=7914
<<<test_end>>>
INFO: ltp-pan reported some tests FAIL
LTP Version: 20240524-400-gec81cf213
```

Best regards
Ma

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
