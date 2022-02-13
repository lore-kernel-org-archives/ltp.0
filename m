Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA71EC433EF
	for <ltp@archiver.kernel.org>; Sun, 13 Feb 2022 04:29:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD0C13C9F87
	for <ltp@archiver.kernel.org>; Sun, 13 Feb 2022 05:28:57 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 884A23C25CC
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 05:28:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EAC9C1A00153
 for <ltp@lists.linux.it>; Sun, 13 Feb 2022 05:28:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644726524;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=fGlQxogZRR95aV6fhGewUUotDMZrE+DiSWLzu1s258U=;
 b=c1Yv2WaUsAw8YWruQ5qZBUkj7genOYw72LjaRYGkcGG4yM9FN1DxJFpzJkOgGPWOJwnjzj
 e6zLD3Z45VRO4aTnyFeagYUFOkKdsSr1ZsOeVq8dbQqexjV1h1P7l2nxpsBHgCATleKArn
 0IfHnWu8s+HEmy0mHaJN+SwitSMK3OY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-PyBev3_-OF-bl1pQjg6Apg-1; Sat, 12 Feb 2022 23:28:40 -0500
X-MC-Unique: PyBev3_-OF-bl1pQjg6Apg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C85F11006AA0;
 Sun, 13 Feb 2022 04:28:39 +0000 (UTC)
Received: from liwang-workstation.nay.redhat.com (unknown [10.66.81.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E178D5BC48;
 Sun, 13 Feb 2022 04:28:37 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Sun, 13 Feb 2022 12:28:36 +0800
Message-Id: <20220213042836.3028266-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=liwang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] test_children_cleanup: allow child zombied for a while
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Zombie process is already dead after SIGKILL is processed by the kernel,
there's usually a kernel reason (similar to being "blocked" waiting on
a syscall to finish) for the process not terminating.

Due to this child having been moved under PID 1(init), there is no waitpid()
guarantee of reaping it anymore. It completely depends on PID 1(init) reclaims
zombie process at its own pace.

So here allow the child exist in a zombie state if PID 1(init) does not
reclaim resource and update the process table instantly.

Failed CI:
  https://github.com/linux-test-project/ltp/runs/5171298664?check_suite_focus=true

  -------------------
  runtest TINFO: * test_children_cleanup
  tst_test.c:1455: TINFO: Timeout per run is 0h 00m 10s
  test_children_cleanup.c:20: TINFO: Main process 69516 starting
  test_children_cleanup.c:35: TINFO: Forked child 69518
  tst_test.c:1500: TINFO: Killed the leftover descendant processes
  tst_test.c:1506: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
  tst_test.c:1508: TBROK: Test killed! (timeout?)

  -------------------
  runtest TINFO: * test_children_cleanup.sh
  TFAIL: Child process was left behind
  cat /proc/69523/status
  Name:	test_children_c
  State:	Z (zombie)
  Tgid:	69523
  Ngid:	0
  Pid:	69523
  PPid:	1
  ...

New test CI:
  https://github.com/wangli5665/ltp/runs/5171508466?check_suite_focus=true

Also, add some debug codes if test fails.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Martin Doucha <mdoucha@suse.cz>
---
 lib/newlib_tests/test_children_cleanup.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/newlib_tests/test_children_cleanup.sh b/lib/newlib_tests/test_children_cleanup.sh
index 4b4e8b2f0..ec1a0d4fe 100755
--- a/lib/newlib_tests/test_children_cleanup.sh
+++ b/lib/newlib_tests/test_children_cleanup.sh
@@ -13,7 +13,13 @@ if [ "x$CHILD_PID" = "x" ]; then
 elif ! kill -s 0 $CHILD_PID &>/dev/null; then
 	echo "TPASS: Child process was cleaned up"
 	exit 0
+elif grep -q -E "Z|zombie" /proc/$CHILD_PID/status; then
+       echo "TPASS: Child process was in zombie state"
+       exit 0
 else
 	echo "TFAIL: Child process was left behind"
+	echo "cat /proc/$CHILD_PID/status"
+	echo "---------------------------"
+	cat /proc/$CHILD_PID/status
 	exit 1
 fi
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
