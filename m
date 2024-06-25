Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 268A1C30653
	for <ltp@archiver.kernel.org>; Tue, 25 Jun 2024 23:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1719359710; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lgu6jKJLtFsetj+2MPGk0HzvPmGN/cBmaknNbGp5p9I=;
 b=gdmB8Mfpxq7EllDSDu6AeOm/MRHCxX2P86cTjlhfzZdFjcv/Yhk6CvKKSZjk+1DImg3FY
 rWxfwmA8KnEkR0sHsLz+oWFBLUKGtLhXu8oJYwaUFTo9S7+7H+eugZ+ai8HersDvozeAHGp
 DPilMAOzBNgy1atm4yGtn9KDHupBBiQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 919DD3D116C
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 01:55:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F1C33D114F
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:03 +0200 (CEST)
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com
 [IPv6:2607:f8b0:4864:20::449])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A349060093D
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 01:53:02 +0200 (CEST)
Received: by mail-pf1-x449.google.com with SMTP id
 d2e1a72fcca58-706645f6ef3so5436684b3a.0
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 16:53:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1719359581; x=1719964381; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=yk3/aOcG7ivmRAVumcRJq3J97woQW52jHHs2NOppBJc=;
 b=24tSCE93IfI8+vPUIoiHbf1JKPWnTz+L1qSUB4EctYyYybuQyj4rY5w7Ds/+oMBQZO
 LlLaM+Md2ANj5Nki4jnxIWslzd8wCnEblef+YuvZiEJQwaYwOa1O4IoiUP1ioq4hFbMS
 1GnlkBwTxEXXSN9oOegnF0pY1HHc41PeNoQm8GcHlZLtfA16TNynf9zH2dtx6DxoADVi
 rC1WVGUYNkU33fqs5XtBpINvilq1Jgng5inJxhAtzJ98TnAbPXz8EUXjHD89aigi8+0u
 QFGqslOb5NIRPww77I+N6/M3Z8p2n1VH/DB+H1I2XGz3fAP3SikjJbv5twMBinE1UUBX
 d12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719359581; x=1719964381;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yk3/aOcG7ivmRAVumcRJq3J97woQW52jHHs2NOppBJc=;
 b=ZWHBRL2M7oyTrZoZbwjTe4AOaLDCCEYYveMgbZpk081hhrTQ4AxuUfZ5yrvIQs9jFO
 b2dOaZ9jrRB3FKi9bzqtIoQwFTVWmzCuVv/utFTCXvn9LJgxpXaHsYYbldECDJBfcN2o
 XiyBFswYcYAAjQzdbt6mXY9hwKxJ8T3qqdSg1NxBks3aV2f2szkG07AaArh7lWsQlxgX
 +HzCuHK+5m3frClzqykdWpMQjock2bFiu3PBjIL90AENUojPVxvPXfrbgiA8HH5kvWoY
 /OOvVLPPIly5x9BIwQACPIsHoZBMZBz+9tZSM0X8Ht0SbWBE+jmCKcFFoKsGI1GEtT5o
 GfnA==
X-Gm-Message-State: AOJu0YwU1rIFplcSH4TEKCqydaSNkB0QG7UaxgzyyQtjQMlZ75r8p1k0
 ffu1Wfbq4kqDI4OYs8gDs5+GfXlAnEDL0iDOw+3kueuCI4AjYkuwBga3jxIBcHyB3S3S85qyCou
 URXna9o2kDL0teUPH1z0kQ8YY+h0JBeAaa8eMwVIVBrvWELLbkhmjhi6JjvPQ2RiFOIEBBLbRef
 eDOq7sWBi/+M7qgJAJ/0efKMpOUpMZki0=
X-Google-Smtp-Source: AGHT+IHiRWpg+k5IDX0KloCP4h0YbkrzmfN0aOeuIbxeIR0vvDMhai/CX1syKlFJZVvSvXGBaFwJYWzuVnzF
X-Received: from jstultz-noogler2.c.googlers.com
 ([fda3:e722:ac3:cc00:24:72f4:c0a8:600])
 (user=jstultz job=sendgmr) by 2002:a05:6a00:3698:b0:706:6b52:43a7 with SMTP
 id d2e1a72fcca58-706746db53fmr112616b3a.3.1719359580694; Tue, 25 Jun 2024
 16:53:00 -0700 (PDT)
Date: Tue, 25 Jun 2024 16:52:33 -0700
In-Reply-To: <20240625235245.2106313-1-jstultz@google.com>
Mime-Version: 1.0
References: <20240625235245.2106313-1-jstultz@google.com>
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240625235245.2106313-5-jstultz@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/6] sched_football: Add a sleep before the game
 begins to get into steady state
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
From: John Stultz via ltp <ltp@lists.linux.it>
Reply-To: John Stultz <jstultz@google.com>
Cc: kernel-team@android.com, John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Before we begin the game, lets give a little extra time for any
odd initial placement to get sorted before we start testing the
RT scheduling invariant.

Cc: kernel-team@android.com
Cc: Cyril Hrubis <chrubis@suse.cz>
Cc: Darren Hart <darren@os.amperecomputing.com>
Signed-off-by: John Stultz <jstultz@google.com>
---
 testcases/realtime/func/sched_football/sched_football.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 37cff515c..9d12f0193 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -242,6 +242,8 @@ int main(int argc, char *argv[])
 	while (tst_atomic_load(&players_ready) < players_per_team * 4)
 		usleep(100);
 
+	/* let things get into steady state */
+	sleep(2);
 	/* Ok, everyone is on the field, bring out the ref */
 	printf("Starting referee thread\n");
 	result = referee(game_length);
-- 
2.45.2.741.gdbec12cfda-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
