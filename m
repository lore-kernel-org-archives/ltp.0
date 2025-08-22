Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3056CA0EED
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 06:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755844461; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=jAKmLTlnHOXuS4Heic0DKYwclTZVZJhpCmdMQlqzFTU=;
 b=HGUfRupFahxsRzb1oHkks2jhakaP6kI89JpHaCcrnfFbGDLKHAEcATPF5BcBMywMV2yOn
 sTtxP4ZZa/5CQIrF4WgP5E2InFSPBkYhmYXSmlxQEDVkz7fxylQ8dKUw1UMx1oCoB0+aWHB
 6OoEO2QOyWrK7yJr71JO6TyPinDIJww=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B0C53CCDDA
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 08:34:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2ADEF3CCD4A
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 08:33:42 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B21AA2000DC
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 08:33:40 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afcb7a16441so257930766b.2
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 23:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755844420; x=1756449220; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQ1YTd2aG/idnaN7HsDGQxsBQFMTjhLruKE+GS6dpk0=;
 b=RdOTmVCStHtgB/VQ3mptBp7hG67qq3Nnpw5Jo1rWVqVWMJNftTAl5b51lN4fS46PzP
 +knTT1HK9KdhhA+mzAOYI0/TmBcah1G/lP65GFfQgyuKaSS8NZCigXm0Z/mm3enmFNlJ
 cQp4rZ14keuKTv0px+BNFzF72ZYm8bZRwhge2mUKk2yLi1n4l9yanKWXlw/Y0+CaKWh8
 MnGC3/ZaYo4+CC/JYkUcG0SuKqXhl5hNArKTs5RnNEhNaFodzdh2MQDztMoi8hX85kZK
 UAsWpEYU7/gOWD5mGGKYQGhvdP2TWB7IDkHjoEQ5n7ZPy9Q/RSS3B6Q7m+EXj3m+HJeR
 4ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755844420; x=1756449220;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RQ1YTd2aG/idnaN7HsDGQxsBQFMTjhLruKE+GS6dpk0=;
 b=pY+CQ85Fw4Ht2yEaV4jd7ikmKE++9HH6Uyu3EhZxUJHKXuk4zAS8YNZsr0lZ3cT+TF
 heeNxpVkhK3mB0U6eDDQ2w4JA7wc5SG2m8CcJ3dapeRZRmELefpPzstzjJPSlJpN5Qhz
 cmoaHfs9C0kYOR4JsyomgirF+zl4EMfmXDMR8E/psyproYXOPcl9nvF9oaARpXOKbjHA
 dAlHaGUTmuX69QUA52knaULKqbsYdjv78TEWVuCrvXIjLePLIsDuXhUWC8/GDzvERujV
 yGln5wXAAVpYUpR2B2/PXZAVHDc+84SXVTcMXHj7tK1+ZoNcj3ndvlvCRh7XDxhLu6N5
 Uv5g==
X-Gm-Message-State: AOJu0Yy6QCt0R8HhgHvFH1ZndIdKSytF15kf8R9ZZsbg0acu5LcNA+Lj
 wuyOWCONpVGfPdU+55waqMoWYnfazx4tIGmhkWblcSWnkvgslkBlU46LK5FwH6wAlGxSqjWUHWQ
 RpRQ=
X-Gm-Gg: ASbGncvEMH+fJSo+/cMCRvuJmZI2neZuJJWdj4NpjLwgcA+zHM0DITTneQDpc3Vh/5e
 h+U4c9GW1s6XmiF6kbeQdN891JJo61Wb/cC+vvBHUPltIww5DrfBS0D4gRfl64ZPqmWTuh471UW
 qF/Gy+HIvVeidwu4xSuUdFNO1zwjCd5HBeRtURrM3p1MnqLl7suOXvDNcUlupuhG4TnaqyMK56H
 Wj8XTPeLuFq/ln/eXGp/Bs4glG1W6qNdkaUj3CFhNppiVHJlIagtLVnXOhUT9oeuOM6GIsyLrkI
 L4WApISbuhFwfL0yqNZPYJDNHEbwA41y2m7425ridPcqFldWPJrP5Xi9POJWr62oGYtN24Bl2Rg
 N2HndmfmibcLuP6ywxYl3wCaUGoeGsnctVBmG5Szvy5s=
X-Google-Smtp-Source: AGHT+IFz/FcJpMAePEz5oKTolOao80P09Q72KRW0A+UPq53MCjjpFVruFYnyj3kNJ3/mvp3MBWGnPw==
X-Received: by 2002:a17:906:c149:b0:afd:d9e3:9541 with SMTP id
 a640c23a62f3a-afe296e8705mr152424766b.65.1755844419900; 
 Thu, 21 Aug 2025 23:33:39 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded4c8708sm539196066b.86.2025.08.21.23.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 23:33:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 06:33:06 +0000
Message-ID: <20250822063331.28886-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822063331.28886-1-wegao@suse.com>
References: <20250822040501.28640-1-wegao@suse.com>
 <20250822063331.28886-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 1/2] tst_device.c: Add tst_is_mounted_ro/w check
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
 lib/tst_device.c     | 48 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+)

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
index 6d1abf065..7f9a2b2f6 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -473,6 +473,54 @@ int tst_is_mounted_at_tmpdir(const char *path)
 	return tst_is_mounted(mpath);
 }
 
+static int tst_mount_has_opt(const char *path, const char *opt)
+{
+	char line[PATH_MAX];
+	FILE *file;
+	int ret = 0;
+	char abspath[PATH_MAX];
+
+	if (!realpath(path, abspath)) {
+		tst_resm(TWARN | TERRNO, "realpath(%s) failed", path);
+		return 0;
+	}
+
+	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		char mount_point[PATH_MAX], options[PATH_MAX];
+
+		if (sscanf(line, "%*s %s %*s %s", mount_point, options) < 2)
+			continue;
+
+		if (strcmp(mount_point, abspath) != 0)
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
