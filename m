Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FD43CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 04:05:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755835557; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mKOD3RRIIfT6LWqt5499L2I2aU3S8PmuTlu+KJyi9EM=;
 b=FSgALYxkUFV0rBQ9shdQcmGLHmw8mwgXIPneWI5SpJ9tFRehc96MzTVCzQ8WGSb4ElVza
 4mTqH6wrf5xv96WpAnaA4lRzdKMEu5YAnDToDyYkofouO7YO9xL0cL4r8CzV5Y3Lf64BYX5
 wYsBaA6pJiYUTPBWiiyDJXXcpqi3nro=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C639C3CCC6B
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 06:05:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FAA33CCC17
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 06:05:11 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9B4731000410
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 06:05:10 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-61a8b640e34so3506962a12.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 21:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755835510; x=1756440310; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qarRCNk/EYVjoDzyGbo12uPdBczRVvbKHgTiYFp6F3U=;
 b=RlPrRGzKM0NTpBNPen6L5tHdi1BTL9Rnx1fhHZC3XnhIBE6HO0vFX+85s5KbTWpIYK
 wT2HwNYTSSFBuNRRQ+lmsgAzOSM/qyI4mkN+eRPgBOtcOOPOu26UAFCkNe8IRaFnQVVQ
 KGp2+3ame0VmthKrseUpEWtHlpTGNkcidgUgdABsoXYAyUAhuEjBXGPksYWTmMb+hOdG
 8Vei4Lj/Vvrh4IsWCMCauAMpTQ2x+9ixDIp2CmiqzLLw6RnZdEkVlZ0VWZgYdCbx814P
 6O12QO9ddS2dSEKxwP2FNw6I8cJlVjaHW9HkB8Q2iuOBHUcp/hMx0BBjlfV3RlLT11tc
 LbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755835510; x=1756440310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qarRCNk/EYVjoDzyGbo12uPdBczRVvbKHgTiYFp6F3U=;
 b=ED5sW4P5GHKwC5V4HQdYRw+tPV7gn59jCFoNyTyXqyYzo8SuNlEZw3FZNir1/xfxE2
 L4a98juGenPdoBPSPXeb01khhthAeEeXeA4Jd9tmowWQBB3UpNPsI4EgMf8uuP4WrkSy
 aS+84XFchToY+XXmmvNxvE+gRtb4lf1DOnP40SmtZOowfwAETB770AEqksEz+VFjE61+
 3OaUFjsYFEvFtU+tbzFWHyAmpyKB0f5xfZjxfu8+GlukYHAQy5aYDqT394aZEXbz1wR5
 iDP8kTEm6mAd+Y64nVB1O/qMvv5+B3Msm1OTYY0Hc+U3VhugUOBwD9Ls3V9tLgz/Xsy+
 1c7Q==
X-Gm-Message-State: AOJu0YwqtB+X+lPalgdBOdMLRBT/wnQEnglg9sjZ8uzJeZN16ocJAd4T
 o3Z2/gfi524nO4xZb/LhppinA12C/cHL1kqEYgZ2D7T5RYzpgYfE8tHKl+8vJ5FIRpaeO2jAL6X
 socU=
X-Gm-Gg: ASbGncuB6SktiUwP22pSf3aV/FvLvhAjz7s8d4o9Ltc469j+vikZSE/VJx64T9NjRyz
 ZLVXaa+OC6TVpB4KzaPTS4Kb28DVnH3uV5GXFe2iGlh6YRWlbO30Bs5o6HcGCRDTdq05TGn7WLs
 00DQNb9yZAe0bUEypTY5lhDd4iwRRPNtaUMNBreLpOm2SlzzxIxS5a9sAuWmiramcXTtG0oya0f
 MfgXCsIfY0k6/YHcZHJEOLYLZ7DwCZg5OvjrJI5q9R7U0jPUC3XYdvvnWH5TjGwuWLxkKupMtYV
 eFr3prxWwXkuTbh/hvz79WmaiuDVGifMVZQ2OLQWHOHrEkspifjiCbMSftXhOjv7NQ3l+beLXHx
 l7Lea0HIwEU9i0Rl9pCq3oYXgxqU93TwzVTQWylchj6g=
X-Google-Smtp-Source: AGHT+IFQp+qug2ORmlmn73nrfnagQIuH1+ugv4Y795cFPJchcwpPfpaNzSpkxDWZc0P1Ies+e52YGg==
X-Received: by 2002:a17:907:96ac:b0:afc:b618:ca7c with SMTP id
 a640c23a62f3a-afe2965ac11mr117804666b.48.1755835509769; 
 Thu, 21 Aug 2025 21:05:09 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded478d74sm518056566b.69.2025.08.21.21.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 21:05:09 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 04:03:58 +0000
Message-ID: <20250822040501.28640-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822040501.28640-1-wegao@suse.com>
References: <20250822034215.28533-1-wegao@suse.com>
 <20250822040501.28640-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] tst_device.c: Add tst_is_mounted_ro/w check
 mount option
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Wei Gao <wegao@suse.com>
---
 include/tst_device.h |  2 ++
 lib/tst_device.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/include/tst_device.h b/include/tst_device.h
index 2597fb4e2..3ea7b5500 100644
--- a/include/tst_device.h
+++ b/include/tst_device.h
@@ -34,6 +34,8 @@ int tst_umount(const char *path);
  */
 int tst_is_mounted(const char *path);
 int tst_is_mounted_at_tmpdir(const char *path);
+int tst_is_mounted_ro(const char *path);
+int tst_is_mounted_rw(const char *path);
 
 /*
  * Clears a first few blocks of the device. This is needed when device has
diff --git a/lib/tst_device.c b/lib/tst_device.c
index 6d1abf065..34f24be7d 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -473,6 +473,48 @@ int tst_is_mounted_at_tmpdir(const char *path)
 	return tst_is_mounted(mpath);
 }
 
+static int tst_mount_has_opt(const char *path, const char *opt)
+{
+	char line[PATH_MAX];
+	FILE *file;
+	int ret = 0;
+
+	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		char mount_point[PATH_MAX], options[PATH_MAX];
+
+		if (sscanf(line, "%*s %s %*s %s", mount_point, options) < 2)
+			continue;
+
+		if (strcmp(mount_point, path) != 0)
+			continue;
+
+		char *tok = strtok(options, ",");
+		while (tok) {
+			if (strcmp(tok, opt) == 0) {
+				ret = 1;
+				break;
+			}
+			tok = strtok(NULL, ",");
+		}
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
+
+int tst_is_mounted_ro(const char *path)
+{
+	return tst_mount_has_opt(path, "ro");
+}
+
+int tst_is_mounted_rw(const char *path)
+{
+	return tst_mount_has_opt(path, "rw");
+}
+
 static int find_stat_file(const char *dev, char *path, size_t path_len)
 {
 	const char *devname = strrchr(dev, '/') + 1;
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
