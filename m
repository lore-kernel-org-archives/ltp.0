Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A0606A31C
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 07:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=R91zAZYX;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=XXP+ov9K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794813894; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=p6wBeCaCTWnVKRsQnHMLOZpHU4mxIvlWXOUWdzzLVxg=;
 b=R91zAZYX9YiDnG4qhrs1Yt0hA+TN/8xcyuiXfLq8L6Piejrb6Piz25r1y/Bb/25bKlTs4
 1KahUpjWtNI+yVc32bZAY1VCq04OnBp+gKgLxV9atS1Rd/Gf9PtBTD9XfsLnRUBEI8RfFF7
 9O369DxBk2sDcZCc5eIroitEEpH0D6I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 775783E93F3
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 08:24:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B0F613D066B
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:23:56 +0100 (CET)
Received: from mail-pf1-x447.google.com (mail-pf1-x447.google.com
 [IPv6:2607:f8b0:4864:20::447])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 206CF200763
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 08:23:56 +0100 (CET)
Received: by mail-pf1-x447.google.com with SMTP id
 d2e1a72fcca58-8b930598cf0so4396278b3a.1
 for <ltp@lists.linux.it>; Sun, 15 Nov 2026 23:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794813834; x=1795418634; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JCdfJvzDm3AmV6KyLjJCUnq+FbXo22p1dqljxg/MsuE=;
 b=XXP+ov9Kq2hoesHGrw3pIn9qLeXu6ssFAvZ68eXM7X4LKIvTF5W7TF66Ti2eRgeAby
 JTDsI0d386mffYCvJdO8mr087Zwp4B19mnPd7dMFnNWKmcXRZLSouC15V7rczTTLpAOk
 tfusZgDqc9nqqdbBd6iPNVGKDk0STsZpCvWBcrskuXueje/wr5WbDMoXeLCjo42rdmHi
 UF881rqKmVkEiJ3aPMnvTYIY4gwp+OI/c+KMuhI348rGFXIyCby914pKXzuFIgef1iB4
 jOAnDD9UnI2SkAJOI0V66XDuw6D+TqD2ewaxUcmXRm42EmIoRStoO7rhPjwfLook12br
 wlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794813834; x=1795418634;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JCdfJvzDm3AmV6KyLjJCUnq+FbXo22p1dqljxg/MsuE=;
 b=0S2WYWol/MXv1IENXES/hMAysuaMcmRczZ6N4n5d/yZ7a3AyBCOPN+1kj82yLksf7g
 3dF2/tjo4kLcrDOaNQ7LcTig9Co4R1rEiRe4oyylwQ6Sow8ZwS2oRTn+9Uk8oo6G1Gjz
 OfRoNLhXuFEFZSHt981YwoW/Ss2eWec4pSGNnMIsxIOiPxeQgJXdYtrDMhD2yx4nldUh
 p6NLZrUgooNCbSy7xsGPBgzindECVBOtlP0mMxhD174AAAybTwXa+PGA+PVfV/llycK0
 6PxKh3rFjSQ+KQHx7B+e8ufKp4tyMkUmhJQ7nMjqaGYsb7mpZgai3bFzeisPSUX31oJo
 I3Hw==
X-Gm-Message-State: APuU4Z/40THScE0bYB3JbeRUNDaiydW+TXD+tJdjeMPynKT8yqqe5BY7
 o/0Xe2Kd/B55bGKtT+k9D9wuyyO2B7NbK8TZDY05hSUutOLcnIEAhJB+e8ZS+bauwafiDtk26Wa
 DKosLHcAHVUVLTQTMF5pKDaDV3QJecueIY5bIxvhzw0pG5z3rD0Ldrp4mUHEfc74wbeCh0RcARn
 XSR+nTtmMb5ivAguVpNhZ6bh9rng==
X-Received: from pfix4.prod.google.com ([2002:aa7:9a84:0:b0:898:802d:e5fa])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:7e03:b0:3ee:954c:1567
 with SMTP id adf61e73a8af0-3f7a73c5c5fmr6990476637.30.1794813834172; Sun, 15
 Nov 2026 23:23:54 -0800 (PST)
Date: Mon, 16 Nov 2026 07:23:46 +0000
In-Reply-To: <20261116072346.2462510-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116072346.2462510-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116072346.2462510-3-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] pipe2_04: Don't assume the minimum pipe size is
 getpagesize()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

F_SETPIPE_SZ rounds the requested size up to the minimum pipe capacity,
which is a single pipe buffer of one kernel page. The test expects that
to be equal to the page size reported to userspace.

That is not the case when the kernel reports a larger page size to
userspace than it uses internally, as with the 16K page size emulation
that Android uses on x86_64:

  TFAIL: Pipe size (4096) must be page size (16384)

Check that F_GETPIPE_SZ on the other end of the pipe returns the size
set by F_SETPIPE_SZ, which is what the test is about, and that the
minimum size does not exceed the page size. The rest of the test
already uses the actual pipe size.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/syscalls/pipe2/pipe2_04.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
index 3911f95b4..7b071a420 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
@@ -57,7 +57,7 @@ static void test_pipe2(void)
 
 static void setup(void)
 {
-	int page_size, pipe_size;
+	int page_size, pipe_size, set_size;
 	char *write_buffer;
 
 	SAFE_PIPE2(fds, O_NONBLOCK);
@@ -70,17 +70,24 @@ static void setup(void)
 	 * A pipe has two file descriptors.
 	 * But in the kernel these two file descriptors point to the same pipe.
 	 * So setting size from first file handle set size for the pipe.
+	 *
+	 * The size is rounded up to the minimum pipe capacity, i.e. a single
+	 * pipe buffer of one kernel page, which is not necessarily the same
+	 * as the page size reported to userspace.
 	 */
-	SAFE_FCNTL(fds[0], F_SETPIPE_SZ, 0);
+	set_size = SAFE_FCNTL(fds[0], F_SETPIPE_SZ, 0);
+	if (set_size > page_size)
+		tst_res(TFAIL, "Minimum pipe size (%d) exceeds page size (%d)",
+				set_size, page_size);
 
 	/*
 	 * So getting size from the second file descriptor return the size of
 	 * the pipe which was changed before with first file descriptor.
 	 */
 	pipe_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
-	if (pipe_size != page_size)
-		tst_res(TFAIL, "Pipe size (%d) must be page size (%d)",
-				pipe_size, page_size);
+	if (pipe_size != set_size)
+		tst_res(TFAIL, "Pipe size (%d) must be the size set (%d)",
+				pipe_size, set_size);
 
 	write_buffer = SAFE_MALLOC(pipe_size);
 	memset(write_buffer, 'x', pipe_size);
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
