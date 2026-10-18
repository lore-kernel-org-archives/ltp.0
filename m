Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23CE4CCF2C4
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 16:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792339318; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=7btSk2qTY9SSkwhB32WITrmg/1/BiGAmilktckjW3cI=;
 b=Ru9xWftktMaS9sRDmq+IgYHVfLhxBgzVufOfbSyiQYpDEAYjM7ASB8z//3BHHQ1gZMKzB
 ZZSgr36nDtT5aEPmXnNS5YPWmGeu7L24FX8XkB3uStULYVIBiVzVs1x5/O1j4/ooXagOZ4F
 8jWo2PBI/7fJXGfVEC4AtZ3isadshGs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05C483E28AE
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 18:01:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D157E3E28F4
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 18:01:19 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9142D60047F
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 18:01:18 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-48afcfc4bf5so999623f8f.1
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 09:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792339278; x=1792944078; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=KNpkEBrLtkD10m/dwtl4mjHBM7r7IZtIVZD5C/ujUyg=;
 b=gsstihSwwCfY1tR3gduKYTuvmK7f9rSvmntwUqZS7rvBTNeXEaFF0Q6ROCCQ/6t+kM
 UGgcrYRnmUqJ27XrKbrnFeU8cqFxZj0zBSatcDk++RDnD5TJ7iX2+zXGgmz0KjkV45p/
 2chUsrFHw5vs5dDABLUyilJYSvIfljI5oS6lqv30Tl+UfPOOvAhyF3WMCL5oq26XGR7t
 GbZiNBU4aJoYiZ1jlx5liR7rCCX2FWCZubtt16Y96silVcctmQRFutHwLHa5PNQE8zLD
 ibcfkdbC74n+2v66uNb6LZY2skmgioq4JSmEHEv5oFUKKHzcoC3hoonJmn67Yw+MLb1o
 DTbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339278; x=1792944078;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=KNpkEBrLtkD10m/dwtl4mjHBM7r7IZtIVZD5C/ujUyg=;
 b=Vhj8XqKXhADebLphPLs4xPGTLiJ0ShHwiNSMWbc/DytrTqchP7r/RBpucoedEAWqr7
 YZeHVdKoXnxogs8RnMjhl5t/gpj5PZE1F4BRIC+Qn3fw8DmvVhkDqF38pjuhDSdiuIt1
 Ud6kTVcfEBy2lw9UNUQy4rfxkEhubTOqsIhCRQReDA9BI7fI/Nch/GXxMjurV9scmJPa
 Hv8wX1Biy+DJ58nHWNT/TTLm2nHHH/VzB2v9nj7k+Z4ofomz0cb4BHnreFVG9F8x0s3h
 vzWcYEDe0N1jlH2GRVsO8KJ4nuJ+/x7yb9mi4JtVZ5cO6d7KFpbbh9u7gi2/L1wKmZdM
 wrDg==
X-Gm-Message-State: AFq9FYJC+e+cWS/yKaN97F+A7gbZNF4PpB03B7fLAcmJFpnxHze54j2p
 9r6lZkwWak7mMi1j5Q5rzv5vinqY65Pe4mj4+yrVXLu0/SoCTCJwgK1wmChPtfyzXkXacrCoPFR
 xKdLLGU8=
X-Gm-Gg: AYBFou03saeTUvi2A3bh8O+M6olvuEj8Ot1iq6zy5Qsh+HDdhaS4U3FvARpfs3eGXm0
 ZbE+kc7PLCc7EKwLAxmR/mL8OHGF/69+hH6b6d8x9eM+081MpUN2BE5wliX9xwb7hALFHmMZXWL
 s+T61Z23QM0/2pGd2TliK6EnYbTxmy88nvF5cx9sjbOaJ9Z/HPzTkm+J0gXhVjU+BaaU0uq+rWY
 XQJnVfgSsYONWyYBqOCYMQ4Zl3F/lYZq4egDJE4urkN66LytaGpXDLXu7Nu2EGrGw0tBYy1aeiO
 3dmQiMJpogN+o/kLN0ZR5W2qwryZ1uIn0MvWGQPlPj7xEJ4fRtSVXzV92m8C5DWUoGjACeLtT+4
 khUmawY4eN8AnvwrY700GvuS6DcXKL/XwGLBHvBNc6ojk/W3oDQizMK7y1nSddMSFkCYnhCnmXd
 0soZetpZ68Ij5EV91vBEW5S8CtSUYb2SWaxOZARXmCIjtnHXDFn0GFcSQKKOqT5msoAHKv/SnZ0
 ZuXifmc
X-Received: by 2002:a05:6000:2f86:b0:48d:fd0e:a117 with SMTP id
 ffacd0b85a97d-48e079759c0mr12704635f8f.5.1792339277829; 
 Sun, 18 Oct 2026 09:01:17 -0700 (PDT)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd47104csm19651936f8f.8.2026.10.18.09.01.17
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:01:17 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 18 Oct 2026 18:01:14 +0200
Message-ID: <20261018160115.154430-2-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018160115.154430-1-avinesh.kumar@suse.com>
References: <20261018160115.154430-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] openposix: mq_close/2-1: Use a valid signal
 number for mq_notify()
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

Linux commit 1184f5e82009 ("mqueue: reject mq_notify with signo 0")
in v7.3-rc1, makes mq_notify() with SIGEV_SIGNAL fail with EINVAL
if sigev_signo is 0.

In mq_close/2-1 test, the child registers its notification with signo 0
after the parent's mq_close(), so the call is now rejected before the
queue state is checked and the test fails on v7.3+.

Use SIGUSR1 as a valid signal.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../open_posix_testsuite/conformance/interfaces/mq_close/2-1.c  | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
index 6e704158a575..971278aee730 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mq_close/2-1.c
@@ -193,7 +193,7 @@ static int child_process(char *qname, int read_pipe, int write_pipe)
 	}
 	// try notify after parent closed queue - should succeed
 	se.sigev_notify = SIGEV_SIGNAL;
-	se.sigev_signo = 0;
+	se.sigev_signo = SIGUSR1;
 	rval = mq_notify(queue, &se);
 
 	// send 'd' for success and 'e' for failure
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
