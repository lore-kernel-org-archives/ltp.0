Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5AC7C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 08:50:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E35FA3CE745
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 09:50:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E8F43CE745
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 09:50:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 753B66067C3
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 09:50:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710492627;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zO9I8sZDKGEO1Hh6wvF6Phx3nIhD3TPnhoNpgjX+6ak=;
 b=I8sFgSsD5TuxTPYhrzWAozqbg9CiOAmSH9D9uTQk0wei5Z+lnoTPXh4MVxGBr1oxgFtOxO
 tBVMgigOTSFanAyQPEJV/J5oXAGQ2MP/CbfhsmewIAkjWK8fQnHLG7kQwRkNiJz5Qlb8EI
 wU72oc33fK2bY1oFgxNePlQ073xhZ2g=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-GFNFDg0_MaOR1EOpDgNrOA-1; Fri, 15 Mar 2024 04:50:25 -0400
X-MC-Unique: GFNFDg0_MaOR1EOpDgNrOA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2D95800264
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 08:50:24 +0000 (UTC)
Received: from liwang-workstation.lab.eng.nay.redhat.com (unknown
 [10.66.145.229])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A6DB3C21;
 Fri, 15 Mar 2024 08:50:22 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 15 Mar 2024 16:50:19 +0800
Message-Id: <20240315085019.3183671-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tools: fix broken failure-detection when using
 individual dmesg logs
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
Cc: sbertram@redhat.com, Shizhao Chen <shichen@redhat.com>, rasibley@redhat.com,
 Bruno Goncalves <bgoncalv@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch fixes the issue where the exit code of the test was not
properly used or reported after creating the dmesg log. By capturing
the exit code of the test and then using it as the exit status of
the entire command sequence, the script ensures that any failure in
the test is correctly propagated and reported.

Error report:

    Testcase                                           Result     Exit Value
    --------                                           ------     ----------
    cn_pec_sh__with_dmesg_entry                        PASS       0
    kmsg01__with_dmesg_entry                           PASS       0
    rtc02__with_dmesg_entry                            PASS       0
    umip_basic_test__with_dmesg_entry                  PASS       0
    abs01__with_dmesg_entry                            PASS       0
    atof01__with_dmesg_entry                           PASS       0
    float_bessel__with_dmesg_entry                     PASS       0
    float_exp_log__with_dmesg_entry                    PASS       0
    ...
    proc_sched_rt01__with_dmesg_entry                  PASS       0
    ...

    -----------------------------------------------
    Total Tests: 1590
    Total Skipped Tests: 0
    Total Failures: 0
    Kernel Version: 5.14.0-427.el9.x86_64
    Machine Architecture: x86_64

But proc_sched_rt01 indeed get failed in the test:

     <<<test_start>>>
     tag=proc_sched_rt01__with_dmesg_entry stime=1709667487
     cmdline="dmesg -c 1>/dev/null 2>&1; proc_sched_rt01; dmesg >
     	/mnt/testarea/ltp/output/DMESG_DIR_RHELKT1LITE.FILTERED-dmesg-output-51310-02:08:39PM/proc_sched_rt01.dmesg.log"
     contacts=""
     analysis=exit
     <<<test_output>>>
     tst_kconfig.c:87: TINFO: Parsing kernel config '/lib/modules/5.14.0-427.el9.x86_64/config'
     tst_test.c:1709: TINFO: LTP version: 20240129
     tst_test.c:1593: TINFO: Timeout per run is 0h 01m 00s
     proc_sched_rt01.c:45: TFAIL: Expect: timeslice_ms > 0 after reset to default
     proc_sched_rt01.c:51: TPASS: echo 0 > /proc/sys/kernel/sched_rt_period_us : EINVAL (22)
     proc_sched_rt01.c:53: TFAIL: echo -1 > /proc/sys/kernel/sched_rt_period_us invalid retval 2: SUCCESS (0)
     proc_sched_rt01.c:59: TPASS: echo -2 > /proc/sys/kernel/sched_rt_runtime_us : EINVAL (22)
     proc_sched_rt01.c:72: TFAIL: echo rt_period_us+1 > /proc/sys/kernel/sched_rt_runtime_us invalid retval 1: SUCCESS (0)

     HINT: You _MAY_ be missing kernel fixes:

     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c1fc6484e1fb
     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=079be8fc6309

     Summary:
     passed   2
     failed   3
     broken   0
     skipped  0
     warnings 0
     <<<execution_status>>>
     initiation_status="ok"
     duration=0 termination_type=exited termination_id=0 corefile=no
     cutime=0 cstime=1
     <<<test_end>>>

Signed-off-by: Bruno Goncalves <bgoncalv@redhat.com>
CC: Shizhao Chen <shichen@redhat.com>
Cc: Ping Fang <pifang@redhat.com>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 tools/create_dmesg_entries_for_each_test.awk | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/create_dmesg_entries_for_each_test.awk b/tools/create_dmesg_entries_for_each_test.awk
index ffd807fb4..b21364ae0 100644
--- a/tools/create_dmesg_entries_for_each_test.awk
+++ b/tools/create_dmesg_entries_for_each_test.awk
@@ -28,6 +28,8 @@ NF && ! /^#/ {
 		s = s " " $i
 	}
 	sub(/[;]+$/, "", s)
+	s = s "; EXIT_CODE=$?"
 	s = s "; dmesg > " DMESG_DIR "/" $1 ".dmesg.log"
+	s = s "; exit $EXIT_CODE"
 	print s
 }
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
