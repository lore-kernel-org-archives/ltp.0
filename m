Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5231DCCF2C4
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 16:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792339337; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=IQl/HTxwsCfRnyvp1IKS812vWsbrehvJ0Sf4OKCt0w8=;
 b=gt0dNsaUuET7hCmnmtxfpxo0xrobwkORYLKRNEAd7o83srK3WVvA9WLZNl5Mjveje2num
 CSDzzz+UTHb/FRbK2xrwGUB+V/9etCC+XxP86zBOoAdVqzm4fUtecxqtBGLOZo2ucZEsIS3
 SgxcI9GIct4/im/y9ugdbWc9PM1lE6c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 411BD3E2C57
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 18:02:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 722923E2D2C
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 18:01:20 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 25F4F1A00450
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 18:01:20 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso15276895e9.1
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 09:01:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792339279; x=1792944079; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=qEEhz4kRKhFW21n8964hAP11CP9azbfLEYCV+JsH4qE=;
 b=euxHyBupDsIPyu4b2QtdH7TCXeflVqDY9xT/CKMd30QplaUajXPPQothCKxFzb087+
 1MBnExKTlHGo9HsQ0Xk1Ne8D6XFBhH/HspFN3Vw+aJK2/Vh93YTEm7S9wSaE0xqiy5FA
 yJjMVrM871uLYSgjL+ovmlOPKHSH/vneo9mSOXq2xX3/osT0DDnuUTANa2dUSzgBiSgV
 UmZxY1b2lMSRhq44y5RdFkySRAI4OgzkGc00EJW3lcOBg05LVs84r0wWIKTQdXw5mwFg
 /eXVxUq3xGhYaC6ThaElzyx4AmdAtkqOUxKbBTdRy+FoZqBOzWkrg9wGhQs4wGL2HCgM
 O5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339279; x=1792944079;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=qEEhz4kRKhFW21n8964hAP11CP9azbfLEYCV+JsH4qE=;
 b=g9EDdw5sLRVnf3NV+LXgqpSjPdD49KVOwaMkAUcrFrwYI8PDM8lyrY2/Nv072hNb+K
 0dL9le1cs43L89lr/k+nAlekQkGjrii4Oqz2JCIYqIXF5fL79Co4UNcedBQZ14mDjGjI
 egzI2rvfijprenas5Ox+zpAnVOgHeQdp+q1EcGxTNEzqlQL3/Nr4r6hrA+87wMae1HSu
 /D/jg/fqoOYkIKTdN/5T4GeJwSycNDGg3AAGzzRY9eOTfxJxAwdPEM08gQaTPYnYt1+w
 HW++OISrBMr0MbBg+iSNHxKH24KJJto6jeAlvgFzMNy7duxpyxpiL8cwRpSAA9DJKhHa
 ifwQ==
X-Gm-Message-State: AFq9FYKghBJZKcEH1Z3dgJdhH3/2LU8it6aE+g3saBn5lmMUF2z72PDY
 OIzc2l/jFXn+AYfjCPLyijOBLyLvGI2xf5o2TypP2eXT5/TOgagwWQRIFydIsZOkroITHPz30ns
 qBSpP1g0=
X-Gm-Gg: AYBFou2QrfWBn8NXVm5Mwsf5hAMpO0RUnlq6pPw/qm7COKS1OCXgYu6LngndHLyvNCJ
 /mqUURcl9TkDCWYCJ31xXgT6qnU5hT0agDN+cqbACCuyHDnW4rfHL6wIWdV52DOO/3CpuSUcYLz
 HzHSRNEJAOqMlWNNKf+ZbyVYidJWeNG2VpDqlVLkMG6JifMvgd+j989gCFYZBcfcAfJnfMXVrUM
 vVH+46o/GQUm/3e/za0n6M6j5pb1vooXkqgP3eVgW2nlF6NSVOaeA8+lDiitU/j/alDd9DxQdE1
 K5VSx6cz8E2LIWvUJlwPBF64MQldCjL78aX4IOTgms21YRD9vpb/t6IGqvWAWBfMgz04E7sAgDz
 HpyIR8fbBJmhTAWQMXZYPqyinqlQEHz/QQCyuxvS8KcptoTZT0MFBf89gdAG/08XC81bfRrsxp+
 O04Agi2LrZ8vHo5E+J72TQZ/wBhmFTglv63J/F07aIl/39X1UTdJSsrNzBR3UJ0qwaNT3LxQ==
X-Received: by 2002:a05:600c:3507:b0:4a0:1f90:594b with SMTP id
 5b1f17b1804b1-4a1d760d7d7mr97240995e9.22.1792339279328; 
 Sun, 18 Oct 2026 09:01:19 -0700 (PDT)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50aafbsm18552624f8f.52.2026.10.18.09.01.18
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:01:18 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 18 Oct 2026 18:01:15 +0200
Message-ID: <20261018160115.154430-3-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018160115.154430-1-avinesh.kumar@suse.com>
References: <20261018160115.154430-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] openposix: mq_close/2-1: Initialize sigev_signo
 and check for EBUSY
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

The first mq_notify() call in the child is expected to fail with EBUSY,
because the parent still has a notification registered on the queue.
But sigev_signo is never set for this call, so the kernel gets whatever
is left on the stack. That is often 0, depending on compiler flags
and stack layout.

This used to be harmless, since do_mq_notify() accepted signo 0 and the
call reached the EBUSY check. Since Linux commit 1184f5e82009 ("mqueue:
reject mq_notify with signo 0"), merged in v7.3-rc1, it fails with
EINVAL before the queue state is checked. The test only checks that the
call failed, not why, so it still passes without exercising the EBUSY
case. Trace on v7.3+ with the previous patch (which fixed the child's
second mq_notify() call) applied:

  # strace -f -e trace=mq_notify ./mq_close_2-1.run-test
  strace: Process 32289 attached
  [pid 32288] mq_notify(4, {sigev_signo=SIGUSR1, sigev_notify=SIGEV_SIGNAL}) = 0
  [pid 32289] mq_notify(3, {sigev_signo=0, sigev_notify=SIGEV_SIGNAL}) = -1 EINVAL (Invalid argument)
  [pid 32289] mq_notify(3, {sigev_signo=SIGUSR1, sigev_notify=SIGEV_SIGNAL}) = 0
  Test PASSED
  [pid 32289] +++ exited with 0 +++

Set sigev_signo to SIGUSR1 and verify the call fails with EBUSY, so an
unexpected errno is reported as failure instead of passing silently:

  # strace -f -e trace=mq_notify ./mq_close_2-1.run-test
  strace: Process 32535 attached
  [pid 32534] mq_notify(4, {sigev_signo=SIGUSR1, sigev_notify=SIGEV_SIGNAL}) = 0
  [pid 32535] mq_notify(3, {sigev_signo=SIGUSR1, sigev_notify=SIGEV_SIGNAL}) = -1 EBUSY (Device or resource busy)
  [pid 32535] mq_notify(3, {sigev_signo=SIGUSR1, sigev_notify=SIGEV_SIGNAL}) = 0
  Test PASSED
  [pid 32535] +++ exited with 0 +++

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../conformance/interfaces/mq_close/2-1.c                 | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
index 971278aee730..48f80a1ee430 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
@@ -175,12 +175,18 @@ static int child_process(char *qname, int read_pipe, int write_pipe)
 	if (queue == (mqd_t) - 1) {
 		return PTS_UNRESOLVED;
 	}
-	// try notify while parent still has queue open - should fail
+	// try notify while parent still has queue open - should fail with EBUSY
 	se.sigev_notify = SIGEV_SIGNAL;
+	se.sigev_signo = SIGUSR1;
 	if (!mq_notify(queue, &se)) {
 		puts(ERROR_PREFIX "mq_notify (2): " "should have failed");
 		return PTS_UNRESOLVED;
 	}
+	if (errno != EBUSY) {
+		perror(ERROR_PREFIX "mq_notify (2): expected EBUSY");
+		return PTS_UNRESOLVED;
+	}
+
 	// send 'b' - signal parent to close queue
 	rval = send_receive(read_pipe, write_pipe, 'b', &reply);
 	if (rval) {
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
