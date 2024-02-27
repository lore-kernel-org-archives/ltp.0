Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EE42C54798
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 10:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709029440; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=vm661GoH5CEg90JgAaC46/s+KTRlF0bX9xl7nqRVqxM=;
 b=PfBC2WVTsWemcEsCyqOwH9/+fFIEO5gOSvyB3aULKAKBEggreNgoAhUeJfT7ACQUY2M+p
 tl+Ro/vMSvu+QtJadZEaEt0u3oRj55yp5Qv8kZZQFk5eXluGNawH3tTJAkihRLpPVtYUhMB
 ecBheZRHgsSeJKyAarJyAN82zZUERms=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6EC8A3CEF13
	for <ltp@archiver.kernel.org>; Tue, 27 Feb 2024 11:24:00 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B006D3CCFCA
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 02:37:32 +0100 (CET)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com
 [IPv6:2607:f8b0:4864:20::b4a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 637AB20092C
 for <ltp@lists.linux.it>; Tue, 27 Feb 2024 02:37:32 +0100 (CET)
Received: by mail-yb1-xb4a.google.com with SMTP id
 3f1490d57ef6-dc647f65573so6120887276.2
 for <ltp@lists.linux.it>; Mon, 26 Feb 2024 17:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1708997851; x=1709602651; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=MEPTeV+Vb+r3R1QmR+QB92YqLj92qefFxcYFa/EVdUU=;
 b=dZ6nQerjksUmcNfQ4BCStzsSUQW9huTZlnafo5/c98vgVmzTiG569zcQ/JQssOzi2p
 nN1iR1k1A51z7RMQAQJqaDEIVQBSs+BocMMANCoNmFnd88i9XMZSQyyvgy04+Yd0Qgxw
 FeE7gxRpHlCYZCUR8+4fZ6Q7/lBg8PGHsDhZQq3q+B7GuUK28I6mm+O63wrkIncy3sPE
 zdpbGK2cq92WPfacletddg5BRdo0S93WPqridjuiJxZVXWGCOp8fB5JtXqdMnY5eMEnj
 PRLdueOkWFqUzsoZbl/IIsb1Z91ffTWjnPtMuHX0xhgkfeYFTzBb9fX17PTxgsAP2LE1
 an9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708997851; x=1709602651;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MEPTeV+Vb+r3R1QmR+QB92YqLj92qefFxcYFa/EVdUU=;
 b=XNHNZ8jldyOqIwu4i8V6lmkgYZIDP+/hwbenfBSI7IEZH3e3rJQ8fueB+oDG5MmoUW
 W+UySdTyYJiJWDnKLM8mGycCgobWlHTRHSVzR4s4waRnfDjI/glh52/dKVW1LIBRVeH4
 1MiajfUB48cFgWdgPEwEZ3HBW00Q3FxpcYpZeV+0rOjDMJBLAjdygPqQSuAWm8BFwSNd
 I/u7yqHJ5fg2GAZJ93LI43Fh5Zg8q3zlSEwXzm2vJb60TTRTCIk0xaHqG3tapYJ/8jwT
 bo2JxNq2mBWpZDiqo87tvWnanaOzJx12tfovlE7jMSX1bJjzU3ChIdE6ssRFTOIjmyLV
 XPGw==
X-Gm-Message-State: AOJu0Yz0rvuM/H3EAmkyjPWiXaAn6JszeL3jZFwaMBEVtwVxGhgbIce1
 nsU+4TOvGHMJ4jsmAOMrgphSbXMSGqvEEwakqthLsDkQ/Lb9q6wPVzCwEusXJgv/rHHMHpvYlOW
 /2s7mZ0KZEJFZ855T9EvYXOwXQRoDHIztnpnnMrxha7ys6gJygeVc5ADVNh7/UoJs8VvXir0CQR
 v8FvvLDQ3/XCzLQetB84X0i535qUNgTqnS
X-Google-Smtp-Source: AGHT+IGk+H70oHmN15zFoYk0A1++eDWpiM9KbPqxG4T9rBFbdlE0IuSlfLfguCUaj/KK4MgUgKKRfLG3KjPn
X-Received: from sergeyu1.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:3094])
 (user=sergeyu job=sendgmr) by 2002:a05:6902:2107:b0:dc9:c54e:c5eb with SMTP
 id dk7-20020a056902210700b00dc9c54ec5ebmr210184ybb.7.1708997850867; Mon, 26
 Feb 2024 17:37:30 -0800 (PST)
Date: Tue, 27 Feb 2024 01:37:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240227013727.1979300-1-sergeyu@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 27 Feb 2024 11:23:38 +0100
Subject: [LTP] [PATCH] Use memset() to fill buffers in diotest
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
From: Sergey Ulanov via ltp <ltp@lists.linux.it>
Reply-To: Sergey Ulanov <sergeyu@google.com>
Cc: Sergey Ulanov <sergeyu@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Previously fillbuf() was calling strncpy() for every byte in the buffer,
which is rather inefficient and was slowing down the tests.

Signed-off-by: Sergey Ulanov <sergeyu@google.com>
---
 testcases/kernel/io/direct_io/diotest_routines.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/testcases/kernel/io/direct_io/diotest_routines.c b/testcases/kernel/io/direct_io/diotest_routines.c
index fe03630ef..793572c37 100644
--- a/testcases/kernel/io/direct_io/diotest_routines.c
+++ b/testcases/kernel/io/direct_io/diotest_routines.c
@@ -55,11 +55,7 @@
 */
 void fillbuf(char *buf, int count, char value)
 {
-	while (count > 0) {
-		strncpy(buf, &value, 1);
-		buf++;
-		count = count - 1;
-	}
+	memset(buf, value, count);
 }
 
 void vfillbuf(struct iovec *iv, int vcnt, char value)
-- 
2.44.0.rc1.240.g4c46232300-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
