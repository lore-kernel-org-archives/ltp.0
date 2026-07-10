Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84B0C43458
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 14:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783693964; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=nA4r5tKY2Emthh75oDUlhyttt1WUF2Dtk8jkZ0yTKm0=;
 b=qzP4oKIsv9CDqFBa62BR4L3iZj9wAUVzp/6erniJPv7aowGkd4awxij7413cPNgloPCyP
 iUP+KXwl9H104uZU+OOHAcIa36Xh9vIn6Q8OXx2/iAjA+fsfnOpF2VlbW33f/qJ0LyFMXBR
 dGT3NzEolEqicQrEJoXrhS68xUd6Kog=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09A943E5C5E
	for <ltp@archiver.kernel.org>; Fri, 10 Jul 2026 16:32:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0DC8F3C8231
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 16:32:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2ACF4200AE9
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 16:32:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783693940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=K5IJytPC1PNTswVmxg6bWjlSKzAFvgYYjdJ8D8aJSEI=;
 b=JJ3fIVfCIR6xrAxAPBCSEmHf+rzh9PKWWrGZqLwf9+9q/5d3zENh/nCQrmumABeQ0GHA33
 gUxEZO+c4sBFOrPt3VgJ7PLRzdH97VY/lbAO7nYx0V6CVnbpYrY0BSc7/xWiHT9kNiWXRV
 oECxz8EtwP0wHfLUuaICfmBYkkWDJuo=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-IXNaZpRXOL-F6x2fVLswlw-1; Fri, 10 Jul 2026 10:32:18 -0400
X-MC-Unique: IXNaZpRXOL-F6x2fVLswlw-1
X-Mimecast-MFC-AGG-ID: IXNaZpRXOL-F6x2fVLswlw_1783693938
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8dc607c8a54so20945286d6.2
 for <ltp@lists.linux.it>; Fri, 10 Jul 2026 07:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783693938; x=1784298738;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5IJytPC1PNTswVmxg6bWjlSKzAFvgYYjdJ8D8aJSEI=;
 b=r7eg+X9bLiWxEvKmzqcRTQaoDSNxVICO1m3zmBnaRNGasZ9pHj5XZx/kvmlbJaPdax
 rAxQ1Cylu5YAp1cuoN5eLzKDHvSwir76fBW5c3vrJbyrG4iECJIngaM9yNfpva0rF8yC
 2ZALjRJzetha9nuvd0ukWcMBo7w9vfi1lqurjzTKgyZAX4BPi4EBBqFbQTYuSewLxHjc
 KXSV+25oO0dmMEHFeNK0dUUEVtFaFk2oeFigsLyPTOcyxej3jhBD7lLFv0gykOF6mjjs
 aXCfVy43ZJMJA9xkGfkGfa2CYFpG/hbdJ84ih/Gy4stiB3uzxuie0ngNByowMh5+G4GM
 c+XQ==
X-Gm-Message-State: AOJu0YyxU4Cp4i+gYkwWxZs+yFH/K+vIjpYUukQ08rMHazQ3r6vDXLNJ
 NPxFdEX9jcvgRmOtyEEjT02+w8CFdXzqa9rqBz+8bHrl6OCx5Xx804O0oL9ySOxI09cXeKBMn0a
 YD+/gSEGdSBGq0Loubfdyrfg3K7ryEmRadYev1axZ6BNUSG6npH08xFQBeO9vh6CytluLKUn9UB
 bj5+gP2JX4UiD8FRnFzAolqutvyccssCehPzPG
X-Gm-Gg: AfdE7cnyiTP3Ma8tI8Ph731ebxDX71Qx8CxD4N98jjqBWbKBNguCOAs8bRlVdTaCdkl
 WzKZyfGLuYrgRj2GH7ZOTBsZxxhRAzcBBZjlI7ytcwrjyBAhs3HyihauDGLCw62TokvlVZ24MXo
 KbTxWEZt4LFRdpG+lDvEHgRSRaRfE+DqgbALeess3LD9icfmvYYZLneAK4npfhvLOSMz889Ebyv
 HuUZk4OviICjQE3BLFidOVkon/kMT5Ew89lHBdUyC3Scjkz+VdffylZfa4mJsjMCyOuMQfmnbJ/
 luVv1MoJdQ6pODHszfjikupHpjtDlvfz8YLyZLW7MBRGbByjvwqKr4COzep+pRJxdberSmW/sRF
 JI0M6PpbOTSNlMIl+yHt09qI/5c56l/u2Pj30
X-Received: by 2002:a05:6214:410:b0:8ee:d9e7:be2d with SMTP id
 6a1803df08f44-8fec04e89f8mr148375336d6.7.1783693938007; 
 Fri, 10 Jul 2026 07:32:18 -0700 (PDT)
X-Received: by 2002:a05:6214:410:b0:8ee:d9e7:be2d with SMTP id
 6a1803df08f44-8fec04e89f8mr148374646d6.7.1783693937318; 
 Fri, 10 Jul 2026 07:32:17 -0700 (PDT)
Received: from sbertram-thinkpadp1gen5.bos.com ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ffd7c1e8aesm41801176d6.28.2026.07.10.07.32.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 07:32:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 10 Jul 2026 10:31:19 -0400
Message-ID: <20260710143155.588390-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xLnByAwTp4CfEoF8pekyerxi3W8sImq8y6yoGNxGIvs_1783693938
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] pipe13: Scale child reap window with
 LTP_TIMEOUT_MUL
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The post-close wait used a fixed 1000000 us cap on exponential backoff
(~524 ms total). Scale that cap with tst_multiply_timeout() so debug
kernels and LTP_TIMEOUT_MUL apply, fixing failures under parallel
Kirk workers without changing default behavior on non-debug systems.

Before (only with case 100):

pipe13.c:50: TINFO: Creating 100 child processes
pipe13.c:81: TINFO: pid 435007 still sleeps
...
pipe13.c:81: TINFO: pid 435300 still sleeps
pipe13.c:89: TFAIL: Closed pipe didn't wake up everyone
The list varied but sometimes up to 20 would remained asleep.

After using tst_multiply_timeout(), test passes.

The failure before would happen, when using 4 paralell workers
on a debug kernel, about 1 to 2 times when iterated 5 times.
With the addition of the function, under the same conditions,
it has not failed in 100 iterations.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 testcases/kernel/syscalls/pipe/pipe13.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/pipe/pipe13.c b/testcases/kernel/syscalls/pipe/pipe13.c
index 5d76e1f00..cf1ccbcbc 100644
--- a/testcases/kernel/syscalls/pipe/pipe13.c
+++ b/testcases/kernel/syscalls/pipe/pipe13.c
@@ -44,6 +44,7 @@ static void verify_pipe(unsigned int n)
 	int ret;
 	unsigned int i, cnt = 0, sleep_us = 1, fail = 0;
 	unsigned int child_num = tcases[n];
+	unsigned int sleep_us_cap = tst_multiply_timeout(1000) * 1000U;
 	int pid[child_num];
 
 	SAFE_PIPE(fds);
@@ -60,7 +61,7 @@ static void verify_pipe(unsigned int n)
 	SAFE_CLOSE(fds[0]);
 	SAFE_CLOSE(fds[1]);
 
-	while (cnt < child_num && sleep_us < 1000000) {
+	while (cnt < child_num && sleep_us < sleep_us_cap) {
 		ret = waitpid(-1, NULL, WNOHANG);
 		if (ret < 0)
 			tst_brk(TBROK | TERRNO, "waitpid()");
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
