Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A331CCF9E3
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 12:56:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14C7C3CF2C8
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 14:56:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 68F7C3C7040
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 14:56:18 +0200 (CEST)
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com
 [IPv6:2a00:1450:4864:20::12d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC7A2600BA2
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 14:56:17 +0200 (CEST)
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-57bd7f0e2daso175224e87.0
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 05:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761310577; x=1761915377; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N9MS1LlM3ZrHUuu4HdXQzKg51uAMgQ0xhUy5wlYVKv0=;
 b=tpI5p5QpZkRGCv+VbnJ+25baTXYKYWuraPOXMwcnSg0rVv4RsdzyVEyYFayFWw+Ag8
 /u3FbyjiDFN8LJrb13nzVFKdAdoAvYbmo0jSHgU4iNv3HF9Bp6V/ZEnG6PP1SPlnSKrX
 //Da/hUkge5/lagS12qUvz0banJlF3LM28hQupAk50KWaL7xPTrPKGtOd7OFEBk6/nnK
 zZVQ9Ftk1O98pzX0ZjDIjbkYOmeczQESyibwy1kjGzhdF3uROgUjWebEGuUjMDH73giK
 p9Tsv+r3FCzLavTRmX0FIANC1GEPVeR2gHRYZQWAYzyCltFgtOA+ngiPMIY7Zn5yzQBo
 kp8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761310577; x=1761915377;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9MS1LlM3ZrHUuu4HdXQzKg51uAMgQ0xhUy5wlYVKv0=;
 b=Y+V+w7s59yC9TDwEfjLw8HlZcDzvmvAg+qTmPAFpCFmxLy96bKBC15Ubjb1Q1hG0f/
 rEAf9ZmdtQPkOYhBLuvrBk9l9pq3bJt8cxkc/WW0fS7G4ee0kxfxxj/CxoV2GLr4OLD/
 5naSBbS13nHd/AhjlbBRBnKjHAD5wTuagE9O2Rc2NDGLZqMz4m8zM+juqLuv+Q0dZSGw
 tZlnuACFKGP79CNhp8VfiWSfZCZd9oDHSubzk9Z8XE+/qd4bdEgvPRWjRrEEx0BA27BH
 X3B+aLjniL4G1Xd9P9oHmBgOIE+GGnwrTJPadQ+qVMMI282FBxd5utI32s7UglM23lFU
 e0yQ==
X-Gm-Message-State: AOJu0YzqmPyPjTXSGum0cQsZFRyE2KmqsdvfuPkpvPGi0FeQKG4VcSuV
 dL7ZEUkOiJQlxfTQyOZFLsNrz1ykl6SOp4//iY5+e9WJW7nxyfF6Ij3KouugUxvGfI0ZWrhhT1L
 kovsr
X-Gm-Gg: ASbGnctRRNinm5fhlT46lRmcdSD3MqYyqo96+DrXMxVxZPQCNaqTuOuiB75J3pH1V3R
 OjlMqnA7Y+iZQEvZCC13FvvAPH/6YsVl2unEYKnkNkgqIB5XCgdAulY/h00dAIj8YSWvuNTEBrm
 aLmaTVtVPXkMGnQqVLpPKuHECSjtLH/hx11jxNGnWlqvrp8UMNRgbz2jQL5gCmpRPxJODxtyBDM
 Qi36HhBC8cqIPJlGIq+oeuyTi0LM+tO1+A3VLcQvMza+8bQckwifq/CAaJKUjEzJ936HfRO0JQt
 ADW4SpcPyhNTV8Asx6hzc6EY0DEFhS2kJOBOrnhI58Khas2Qnkl64JeOJFdiX9n8dN+QaF8vNpW
 P0Ljdofc5pJNbJjdXhyUMBmPiTTTI2SEFyIgeZsCocZfv9fq5SfV4MgJWnzJTtLB85kSfAz0Q3T
 Dq6GY975MOkoQ4ac9HkGVTBnuzkgpo+ekOc9pDeaEdkQAh/dU=
X-Google-Smtp-Source: AGHT+IGbVozQfqrA4MCwV1p8XlSj1YpQfrxfGyb/eSo2zT4DDiyjgPDaF5BKqoX9tk3XzsnPJFGBVw==
X-Received: by 2002:a05:6512:2249:b0:592:fa8a:811a with SMTP id
 2adb3069b0e04-592fa8a8392mr819498e87.2.1761310576896; 
 Fri, 24 Oct 2025 05:56:16 -0700 (PDT)
Received: from localhost (c-85-229-7-191.bbcust.telenor.se. [85.229.7.191])
 by smtp.gmail.com with UTF8SMTPSA id
 2adb3069b0e04-592f4d2c6f3sm1629857e87.90.2025.10.24.05.56.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 05:56:15 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: ltp@lists.linux.it
Date: Fri, 24 Oct 2025 14:56:13 +0200
Message-ID: <20251024125613.2340799-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: benjamin.copeland@linaro.org, dan.carpenter@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The file_attr02 test requires XFS filesystem support to properly
test the FS_IOC_FSSETXATTR ioctl with project quotas. Add the
XFS kernel configuration requirement to ensure the test can run
on systems with XFS support either built-in or as a module.

Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 testcases/kernel/syscalls/file_attr/file_attr02.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
index f6625985a514..0ad57177078b 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr02.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
@@ -18,6 +18,11 @@
 #define BLOCKS 128
 #define PROJID 16
 
+static const char *kconfigs[] = {
+	"CONFIG_XFS_FS=y | CONFIG_XFS_FS=m",
+	NULL
+};
+
 static int fd = -1;
 static int dfd = -1;
 static struct fsxattr xattr;
@@ -105,5 +110,6 @@ static struct tst_test test = {
 	.bufs = (struct tst_buffers []) {
 		{&attr, .size = sizeof(struct file_attr)},
 		{}
-	}
+	},
+	.needs_kconfigs = kconfigs,
 };
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
