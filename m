Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E7B606A31F
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 14:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UkdnWs//
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B0643E9A14
	for <ltp@archiver.kernel.org>; Tue, 27 Oct 2026 15:28:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF3373E20C3
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 15:27:51 +0100 (CET)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D67991A008A7
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 15:27:50 +0100 (CET)
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-48bbb06e746so2244197f8f.3
 for <ltp@lists.linux.it>; Tue, 27 Oct 2026 07:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793111270; x=1793716070; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fvc+g5chQ7unKrQLNJ9BjdgsBZkY5SCuPiGiSkgMFg8=;
 b=UkdnWs//XgR15I5p2NRhbwL5sd4eQB4apiYVxIuIeSTe6ktvHF1y5SgLHZFa9NQBIZ
 wCv5UVxijglXZbM7Zd9h0oQjH0yeuj1001qHFJSUuDXzMI/NqSSzDMhOKpkG5jbScS/f
 qB395YonEFm07SSYKXGtphPp7RZfd581AEyv1zfUUoD7Wj76qSI3FQ3v+4SSdK1R0P8d
 jo7lX7sgNxVdMov2cCCJuVTvrzzFtMj2ZdrJQRJtUBmtnyse6vmi39SSuuvKS/SSaXz/
 U1EOrmykLp+KIgBopSqBGprWEBFzI5sD9/3ffB8pQxi53bWxHXfWDf3LFS/kMVMMidLj
 6jww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793111270; x=1793716070;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=fvc+g5chQ7unKrQLNJ9BjdgsBZkY5SCuPiGiSkgMFg8=;
 b=ypWRXQDUZOMBssjjUGpOqzalGFJ4siYndxnB4krRRTqJ2N/ntMfafBOxzNYeUZ+auI
 SEn6B1Wzjj1YfmzCPVO5U2s3pRp4fC2MnZBrfZahOlxntydy4mv5tKi37bvTDPQfINqi
 kglbSAd22aWSqYkRr5lfzuhCNOW/cR7An8Bho5Om+AxcVyPOEcVL+X01vZWdbKCCG2LL
 rjTy7vLHwSgLYJhkdF4NTG2TaQz9tQnn32kAabyt1c4by62VuhYzyCR3vJQ77+LVo/oI
 RgJ4rX+jdyvtmNnVziL07kc4S/HYN0atRgax3fSaPnYDZlGzHjKEEDl9B6YN0fsDTfGe
 qHrw==
X-Gm-Message-State: AFq9FYLBUPRHd6ZzH/DIv5E1UZ8kc1lN1L3YkAqxuYL8ChLgUnrWbzWl
 EFgTETlwOmUNbBD4jJSDQHdWK9lZ/CUcm8FtLX6PTCZ0rm58fmYsLhdkkvjGhuto
X-Gm-Gg: AYBFou2SM5gPGbEI7q2A25EuIRMPW8N5DCSnaB6Eiht2ZUGDPK9CXdnCCcAPEaccH8v
 03sOkwbHBjImsZpIdlpvnx7n04BqeiI8gs71nogdFoPWVhdwdCK/PKA76Nj4WVClNFTLsfPBmBm
 7RXMCLz9oV2a/VMvQt6MlzG4Eqrw41sxX9KijesLnE7bYQ8dCHqS8xBjHsGKQg9Mx4U1QabLLiJ
 E7jOAYFldaCbrKnCi0emYS1KYMRXJ6TA7du87T+Wr7DhkZi2XcNdhrlrjV23bNDBTDf3tAsb7sU
 AjWaD4sLDUw3UcTgAFSo9c//3KBks3+MRRXgnm/iKENarPY0hPsmrTRQmDXYRM6Fd3d7VvV3aJF
 Knr86LHgq+tK02VhqgQD0bA6KClDpv/0xlTPIczgk4cwgzElKkDZMdt0Cp3O875pGh/4Dc9sGJJ
 PUz03sE26mvNGWOzssNhkFbbZfCKGg+NwkZO8bC2rcF4pkdkz0gjkfFY2VUqT2b8EDEtPkhOOYq
 Yas+m1jzMIGvEOdn+U9R/R9xhkbB/Z31HAcXx1Zb4iQSdi4y/Ulk51VdyonLzEyC/FzFgnOg0mF
 /+Q1IIddOxr92Iu6Adls+xnfT0Okh0MS9qDGym1ehQQMNxP9J7kwbeHxsOSn5L9glaU=
X-Received: by 2002:a05:6000:298d:10b0:48a:f404:695e with SMTP id
 ffacd0b85a97d-48e3eba0b4fmr13399496f8f.50.1793111269912; 
 Tue, 27 Oct 2026 07:27:49 -0700 (PDT)
Received: from localhost.suse.org (apn-37-248-176-17.dynamic.gprs.plus.pl.
 [37.248.176.17]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc4d76sm23647523f8f.12.2026.10.27.07.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 07:27:49 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 27 Oct 2026 15:27:47 +0100
Message-ID: <20261027142747.19192-1-sebastianchlad@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261022115410.23845-1-sebastian.chlad@suse.com>
References: <20261022115410.23845-1-sebastian.chlad@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] lib: tst_device: Use exponential backoff for loop
 device detach
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

detach_loop_fd() retries LOOP_CLR_FD 40 times in 50ms steps, a fixed
2s timeout that ignores LTP_TIMEOUT_MUL. When another process still
holds the loop device at cleanup for longer than that, e.g. on a
loaded machine, the test ends with an unwanted
"ioctl(/dev/loopN, LOOP_CLR_FD, 0) no ENXIO for too long" TWARN.

Use TST_RETRY_FN_EXP_BACKOFF() instead, as attach already does since
d90d20046 ("lib: Use backoff polling to wait for loop device nodes").
The detach finishes quickly when the device is released right away,
polling slows down when it is not, and the total timeout (about 2s by
default) is scaled by tst_multiply_timeout().

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Sebastian Chlad <sebastianchlad@gmail.com>
---
Changes in v2:
- Use TST_RETRY_FN_EXP_BACKOFF() instead of scaling the retry count
  with tst_multiply_timeout() (Cyril).
- Link to v1:
  https://lore.kernel.org/ltp/20261022115410.23845-1-sebastian.chlad@suse.com/

 lib/tst_device.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 00304711b..bf77c9ded 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -249,9 +249,14 @@ uint64_t tst_get_device_size(const char *dev_path)
 	return size/1024/1024;
 }
 
+static int loop_clr_fd_busy(int dev_fd)
+{
+	return !ioctl(dev_fd, LOOP_CLR_FD, 0) || errno == EBUSY;
+}
+
 static int detach_loop_fd(const char *dev, int *dev_fd)
 {
-	int ret, i, retval = 1;
+	int ret, retval = 1;
 
 	/* keep trying to clear LOOPDEV until we get ENXIO, a quick succession
 	 * of attach/detach might not give udev enough time to complete
@@ -259,22 +264,19 @@ static int detach_loop_fd(const char *dev, int *dev_fd)
 	 * Since 18048c1af783 ("loop: Fix a race between loop detach and loop open")
 	 * device is detached only after last close.
 	 */
-	for (i = 0; i < 40; i++) {
-		ret = ioctl(*dev_fd, LOOP_CLR_FD, 0);
+	ret = TST_RETRY_FN_EXP_BACKOFF(loop_clr_fd_busy(*dev_fd),
+				       TST_RETVAL_EQ0, 2);
 
-		if (ret && (errno == ENXIO)) {
-			retval = 0;
-			goto exit;
-		}
-
-		if (ret && (errno != EBUSY)) {
-			tst_resm(TWARN,
-				 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
-				 dev, tst_strerrno(errno));
-			goto exit;
-		}
+	if (!ret && (errno == ENXIO)) {
+		retval = 0;
+		goto exit;
+	}
 
-		usleep(50000);
+	if (!ret) {
+		tst_resm(TWARN,
+			 "ioctl(%s, LOOP_CLR_FD, 0) unexpectedly failed with: %s",
+			 dev, tst_strerrno(errno));
+		goto exit;
 	}
 
 	tst_resm(TWARN,
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
