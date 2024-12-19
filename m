Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7838EE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 06:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D58AE3E28F3
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 07:36:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A04B73E28F3
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 07:36:41 +0100 (CET)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com
 [IPv6:2607:f8b0:4864:20::e35])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1652D14302B0
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 07:36:41 +0100 (CET)
Received: by mail-vs1-xe35.google.com with SMTP id
 ada2fe7eead31-4afeccfeda2so244516137.1
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 22:36:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1734590199; x=1735194999; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RLMbCG8mN/n5tZifGkj6lrIMmqMapi4j7SoTdoMRef4=;
 b=LGRdC1eQTihfNSgggv1QHZSDmKuvgTL7ZTrXyzMzQY9/5TwYHRINQdblY4xq96zCyg
 sxHJ1E7Vp1w5WDoJPpN5y6ExNlr1jnZNbirFqsK/4qtFiv7c5VEypQCjUAAdAftpK1r4
 Nq3SjydEZr1Tz+SlmCW1kZHUe5igLMb5sAh1eEINTo22GrgVINV9L8rF9ecfiKm7WJp0
 jsnqXZlSYOAAp1hD4OTjs4auMaHgdh3AC/M5C0mpBqTbs0HajuoZo7/bhygEClYCx0wj
 be2xmLU0ksIsHpdUShtFZ+n7EFoGFVKK5Je/TJTLRuOAWJQonz28fCx81TIhfEgAFMkX
 6FvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734590199; x=1735194999;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RLMbCG8mN/n5tZifGkj6lrIMmqMapi4j7SoTdoMRef4=;
 b=YZ83yXfxYbWj/FFOPWgR65C/n2F1/lb9Esz9f1ug4DJ+ePvrwIzAytb02cobmi8tGZ
 KcAvkrJB2LYdWe4WS3n2V1pUROgR4D8L2LTX8mBj3xziu+rw82R4xu/YnvuoBah3Hzpb
 RN7iI8cwE6QxfBwSh2DJswgqdT+jhjDiR9Bs0GSC+SiiuTqKQuyCeUlo4HfpqXZGZZzP
 6GPHti9X6aHh3tuIIY1Xjp3mQtFcji5PMV4reC50/TSt6xFwoHHlINm4nLePDEWutIMq
 8dIddIc+XL1PvunvC1mt7KF3I2K3hI4pTdAAD04+60O0n8CwUAApDh92Nbe91Gsi3n1/
 zlhA==
X-Gm-Message-State: AOJu0YyZgbV4VY/ZO+jLThMrlP3KCyeN0znfbTDUmk9P7bPWCPuehlXt
 vafokVIGZd1YukGJYohs8yUn/+R0M7E4RUUflkkVX4vQUZexylYQULT1MsvhmC+YbG6Am+a4+yX
 Ti98CORqM8XGoVQ+RRWlJsggsSay5NjSJ/5r6yQ==
X-Gm-Gg: ASbGncuzCuhZchwCYjRG63qd02nS6Rqi343HnqwAZvNSUqaruSQRxGHFZo6KntpYUnJ
 Yb7BYobrD42GqxyivuedTqdgxZefbRkhrZ+MSD1I=
X-Google-Smtp-Source: AGHT+IH9tJ8hqaGRirm7lkZPQxTT5y4oG3LXloy5X7xjRMFA838cqtrNiubVng1A5vD61fB8FM2EmalMFWQmfXHPQwk=
X-Received: by 2002:a67:ef45:0:b0:4b2:af37:1433 with SMTP id
 ada2fe7eead31-4b2af3714d6mr4689338137.13.1734590199391; Wed, 18 Dec 2024
 22:36:39 -0800 (PST)
MIME-Version: 1.0
References: <22b831c6-4a7c-4393-a840-d0b00512acbb.jinguojie.jgj@alibaba-inc.com>
 <4ae915b4-0be1-4ea6-b59e-50c9a960c558.jinguojie.jgj@alibaba-inc.com>
In-Reply-To: <4ae915b4-0be1-4ea6-b59e-50c9a960c558.jinguojie.jgj@alibaba-inc.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Thu, 19 Dec 2024 14:36:28 +0800
Message-ID: <CA+B+MYT=RRPEUQ8WydQWeQkB02xO5=EJd=gqOTXB1F5OUWj9HQ@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] controllers: skip test when cgroup v2 is loaded
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2:
* Correction of comments

V1:
* Initial check for cgroup v2

When running "controllers" case on some newer Linux distributions, there
will be 10 ERROR messages during the setup phase, and several TFAIL
results at the end.

Current "controllers" cases only implement tests for cgroup v1 file interface.
It's better to skip the test after checking that v2 hierarchy has
already been loaded.

[1] https://lists.linux.it/pipermail/ltp/2024-December/041082.html

Signed-off-by: Jin Guojie <guojie.jin@gmail.com>
---
 testcases/kernel/controllers/test_controllers.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/controllers/test_controllers.sh
b/testcases/kernel/controllers/test_controllers.sh
index 7aa974ff2..0b67387ec 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -37,6 +37,15 @@
 #
           #
 ##################################################################################

+# Currently only cgroup v1 interface can be tested.
+# When the v2 hierarchy is already loaded in the system, skip the test.
+mount | grep  " type cgroup2 " &>/dev/null
+if [ $? == 0 ]
+then
+       tst_brkm TCONF "" "test_controllers.sh: V1 controller
required, but mounted on V2"
+       exit 32
+fi
+
 if [ -f /proc/cgroups ]
 then
        CPU_CONTROLLER=`grep -w cpu /proc/cgroups | cut -f1`;
--
2.34.1

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
