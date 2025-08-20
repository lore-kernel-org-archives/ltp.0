Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F271CA0EEB
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 00:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755649583; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=5eK0+biEHYe6T2XUsymRBopT3EI21amxNwdIYE0znHE=;
 b=S20kgFB6ySsq4RlrFOJtVELUVPSHXPg3mmKqrcoPZ/ItI78curTz25C0wceDT2zErYPiu
 2O9dorXGl74u10y+t/ga7u9r85H2uPkpZghcSH4Clyy2jfPW7t0ZYzD4npM0jM0qVouwkyg
 A5ibqQ78NUAxD9PyQEwV5XuT04jFx10=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23DB03CCA6A
	for <ltp@archiver.kernel.org>; Wed, 20 Aug 2025 02:26:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA9473C9FEF
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 02:26:01 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 359BA60047F
 for <ltp@lists.linux.it>; Wed, 20 Aug 2025 02:26:01 +0200 (CEST)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-afcb731ca8eso931762066b.0
 for <ltp@lists.linux.it>; Tue, 19 Aug 2025 17:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755649560; x=1756254360; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sWAdcJH8tJZlWKmDmnjfEMT+vgALjs8EjhUL5INDXwA=;
 b=YppQVdcTtxFqx96IO4IBoVUP7bSXLNiKz2J+z0CmfPD9JnuOuGcoQCu5QgZznzXzb/
 SoWqtQtWwzR2v/ST7e+lad5Fxowwl0LcVBzu0FNy5vX906bzt3TNJaze23WmudawwibL
 84lcopVFlidT7jjYenmneFTVAlkRqaGDa0UNBqjqphOGMSlZ4PezJHAYDamDwhzVQiL/
 MFD4AaAYX4hgtF8r3Er6b+2FurWzv4yPPDDjc+EnaprtrKIj+J87a3HMfQdoDZEuqEf7
 N1sLbuSC37+P9UEPv/Bs+lviNCrcim1Sm5K7CgPaciI/bLb0Jl/KUv1CGCazVeD38OyP
 MZqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755649560; x=1756254360;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWAdcJH8tJZlWKmDmnjfEMT+vgALjs8EjhUL5INDXwA=;
 b=lKAOWgbQTcJrpWq3gSHcS880XsWSvQcnW0t0syUWs8LGIuwUufJr/XM1dBQOsSEMyI
 sduQhWRlabCq2WZbxPdsuuNyNH6Xo7bqPGgHkrOwU/FHWMy6MSKHp+kKvBzVrOSqyYSU
 PHANovZ504hFFl+p2O/Pj75UxP5djDkjQqAJ+ddVmFxjHasLWDns2Hz9zv0EsUFhkpyP
 v9OzdYpFTQH2+AIquGHDbHxluA/bOOqHjNwoYZZUJRvTNwULPgfpwLjsG2otlj6UNNSu
 T9nTjGUblMGF2d7t5fJTolari8HpgohdqKs8fRaAAZkiB+fgOI5wO50mCYKtIPwkwdZD
 +Mbg==
X-Gm-Message-State: AOJu0YzdQVqsJBKNfuUUENE6i+4vEg/g7EWLHdQkFFzmqIFlpbrdc3v1
 uMYZ3vJRhe70Ayfb7WdVUTuesl0JHiFt3TTVntmHxPv+Zmas9aTu4GlRjtvjforaU7tYR+R7oBP
 HgUU=
X-Gm-Gg: ASbGnctDDiVOiBkp1JOZ09AVRza7agBhUjdnGLbdPFz2SUXG4ZwaIcXFwFsFY53nKdp
 iuG0zIODi435ZbQ30LWZPdxMXLgA2KS053RaHQnJNln0ALfG3Ucs1+Lhc/YGOXQ9xexqbMy9sJh
 VLSQk/46Xfs4wNhPGJMdSHtawWMpDtoexrTFL3VLHXMeyJLexqph1GuBqAniPEpKL805wYMvm+G
 l6as5reSMDlIcmBKa/9v30kBYG+w8Zhfed+WXzXyrVnHawVf1tj5vWBCB908l4IRw5Tz6hF3iPt
 Lh+bt3B+IzavJp6nEkF3FIRR5nirxX3+IHtV8xM0cwa6400CUAWY+C0xwQHdHdl2Iu5DFy9oCLV
 EJTiVUAVeIXc=
X-Google-Smtp-Source: AGHT+IHQWOAc95FAqdKGp3uMbSdN5OA6DghqekoPjER7hrnGpK6TbD2SWKYXw3VgS1v9ksWsdtYiTw==
X-Received: by 2002:a17:907:60d2:b0:ae3:6d27:5246 with SMTP id
 a640c23a62f3a-afdf0205351mr69227666b.48.1755649560068; 
 Tue, 19 Aug 2025 17:26:00 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-afded534e37sm73147566b.103.2025.08.19.17.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Aug 2025 17:25:59 -0700 (PDT)
To: ltp@lists.linux.it
Date: Wed, 20 Aug 2025 00:25:51 +0000
Message-ID: <20250820002556.26865-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] fspick01.c: Check mount point was really remounted
 read only
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

Fixes: #1171
The fspick01 test does not test if FSCONFIG_CMD_RECONFIGURE really
reconfigures the mount point, e.g. if the mount point was really
remounted read only.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/kernel/syscalls/fspick/fspick01.c | 43 ++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fspick/fspick01.c b/testcases/kernel/syscalls/fspick/fspick01.c
index d03cacd3d..c2ad369d4 100644
--- a/testcases/kernel/syscalls/fspick/fspick01.c
+++ b/testcases/kernel/syscalls/fspick/fspick01.c
@@ -6,6 +6,7 @@
  */
 #include "tst_test.h"
 #include "lapi/fsmount.h"
+#include "tst_safe_stdio.h"
 
 #define MNTPOINT		"mntpoint"
 #define TCASE_ENTRY(_flags)	{.name = "Flag " #_flags, .flags = _flags}
@@ -20,11 +21,38 @@ static struct tcase {
 	TCASE_ENTRY(FSPICK_EMPTY_PATH),
 };
 
+static int is_mounted_ro(const char *path)
+{
+	char line[PATH_MAX];
+	FILE *file;
+	int ret = 0;
+
+	file = SAFE_FOPEN("/proc/mounts", "r");
+
+	while (fgets(line, sizeof(line), file)) {
+		char dev[PATH_MAX], mount_point[PATH_MAX], fstype[PATH_MAX], options[PATH_MAX];
+
+		if (sscanf(line, "%s %s %s %s", dev, mount_point, fstype, options) < 4)
+			continue;
+
+		if (strstr(mount_point, path) && (strstr(options, "ro,"))) {
+			ret = 1;
+			break;
+		}
+	}
+
+	SAFE_FCLOSE(file);
+
+	return ret;
+}
+
 static void run(unsigned int n)
 {
 	struct tcase *tc = &tcases[n];
 	int fspick_fd;
 
+	TST_EXP_VAL(is_mounted_ro(MNTPOINT), 0);
+
 	TEST(fspick_fd = fspick(AT_FDCWD, MNTPOINT, tc->flags));
 	if (fspick_fd == -1) {
 		tst_res(TFAIL | TTERRNO, "fspick() failed");
@@ -49,8 +77,21 @@ static void run(unsigned int n)
 		goto out;
 	}
 
-	tst_res(TPASS, "%s: fspick() passed", tc->name);
+	TST_EXP_VAL(is_mounted_ro(MNTPOINT), 1);
 
+	TEST(fsconfig(fspick_fd, FSCONFIG_SET_FLAG, "rw", NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_FLAG) failed");
+		goto out;
+	}
+
+	TEST(fsconfig(fspick_fd, FSCONFIG_CMD_RECONFIGURE, NULL, NULL, 0));
+	if (TST_RET == -1) {
+		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_CMD_RECONFIGURE) failed");
+		goto out;
+	}
+
+	tst_res(TPASS, "%s: fspick() passed", tc->name);
 out:
 	SAFE_CLOSE(fspick_fd);
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
