Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 151D8CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755834211; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=mKOD3RRIIfT6LWqt5499L2I2aU3S8PmuTlu+KJyi9EM=;
 b=O0QfsT3xNk/RMTaa5dQoAUtZIoe/qTH1jc3qr1JQWEXsYQYlCyILrBxP3gQ6UFytqKV3z
 3A9wyM8nYsshBhmwKq2KnJ269ZL3gUvyV3qIZv+UoVhrHOnMD/8LtC7MjVA0zkroVGwnLlJ
 PXQvAuH7V9gW0xwPFLxIbQHmSz4GWtg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E250C3CCC71
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 05:43:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4482F3CCC71
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:42:28 +0200 (CEST)
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 657306002CF
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 05:42:25 +0200 (CEST)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-61a99d32a84so3127610a12.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 20:42:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755834145; x=1756438945; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qarRCNk/EYVjoDzyGbo12uPdBczRVvbKHgTiYFp6F3U=;
 b=aIsgvIEfoitrNoQH2XBcX4eJTGqTNlNCcrKNdyctFSGTVf2wixUGu3JiYKsiBl5iFQ
 fnxV1Pgi6mTtf+hUjfWMtNpO1TAPt4e3RrdbKhKDacMqmBemRUGt+iKeq8TDdTIxCScX
 wTbrKvfMyOYlAPjQ5qzFsYYV2FfQq/hBJhHR8nP0WeZ9LTlJ1QkWbSYgo1FZnJJLMkzy
 AWPsbeJzkTsgVd11Ug0n5aksEVQP/CmQ7Gl6vZKrrxm5Bf+aLtkLCipjlTzzn5GIb7Fo
 4qEaKCtuRl/dbf7twu1XwjlCgLOqbOFsC7Fify2FpPU4bOE2Eb0pb46k0IahIYPjXgh8
 h9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755834145; x=1756438945;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qarRCNk/EYVjoDzyGbo12uPdBczRVvbKHgTiYFp6F3U=;
 b=pOis6rKvJ4N8cYNHTNt1nIyYj56IWThUy2bwZe0frpdEvXZTY/p6tGZ1aJ0tahgsSN
 8kuO7/65QSEnUDLUY5W5AAg5dSYFB23SQpPxOzf7Ky+1keYKKR77RJao/qQXRQV5NUx6
 MLs4V3BHjGZEoiBVeM+ZNkBnIbU3qS2dmrErc2TGovv9NhfrrOZuxYwHeetGnRFrvnzc
 qlqC57jP++TNqhVrax+r14xc4n9mVtgesxaX7WkmQVHzHO2n6kPHZGA5mShThT57xpC9
 NIojIx6tuPNL7a0vIp2MV8IsSYxASiQ4fWsUzTDNXWLTdYSoIXvqaOfub9asJvbhurCi
 z3qA==
X-Gm-Message-State: AOJu0Yz8kSxoMsMSxXFepHJtK6s0cAPt9xC/sOq6rUIZ96jzCW8f7d9a
 9lQ1Ou/iONscK92ZrUyZ3PTKRw7bKTKFWaicXQyf5xT1iqYS2zO0hT3yVEAYJZwyxOAd3Z15Wyg
 7O8k=
X-Gm-Gg: ASbGncviBcGvMJnR7SA7BvzjQMpqnEqO6r2nwCrfXktxbrIT5Iha+zpxz4OccJKzapi
 yd3wUD7vWuZZMo4HEAcGXXE9jcDzSrnn8B0yvlBBTJR1YqOfX0LHj6AWUUhjP4/9I+57a/mYRC7
 VGsPhp5e6TzVsnnaV99sroguJHYUIfuXN+P5X0nvo1UEbkGCdwDYgV6Cqz5CbPixxKBVU+mdWBQ
 +32yEYVkD2JSqMdcsTl+yIMfgoNgSFhzAUkJK2mAQgEuRw9sZbVWJmpYTlgF6ytjJ/c+HFh/zyz
 +sqR7f4gfVleS3jYvBPSDK2OV55RDoZwrw5SdAXu5fAOkyGSBy8HMpKzB3IC7TH+CBMnGQ2QP6L
 f+FfhT6E3JADKDWKCYl8ZQDnFHl1rhJa/AByQXc+KyqQ=
X-Google-Smtp-Source: AGHT+IG/tYGSAl8rfAM/pG1gGBj1SlyWE5evTN0SDWgEn+NJYrJYfvjEMcACvuU/k77amgWpaS+aSQ==
X-Received: by 2002:a05:6402:3594:b0:613:5257:6cad with SMTP id
 4fb4d7f45d1cf-61c1afd3368mr1218258a12.11.1755834144662; 
 Thu, 21 Aug 2025 20:42:24 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 4fb4d7f45d1cf-61c20de9872sm285380a12.27.2025.08.21.20.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Aug 2025 20:42:24 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 03:41:39 +0000
Message-ID: <20250822034215.28533-2-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250822034215.28533-1-wegao@suse.com>
References: <20250820002556.26865-1-wegao@suse.com>
 <20250822034215.28533-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] tst_device.c: Add tst_is_mounted_ro/w check
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
