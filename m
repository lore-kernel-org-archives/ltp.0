Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810E606AB1A
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 22:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=qu/WttKL;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=NhC7LrQq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793830517; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=jdGUegz+GbWHbeX6GZLjNb7eK6nqLy0Tk53VR7iETwk=;
 b=qu/WttKLBN+ZRRMAZO9xiq+qEla0voKnqZm4JslfO0nUoxxb0+mePD8n8ThmHMG1Dwe+G
 TsdO+OSNZ2elh1weDYJU+q3HDZng4ReZPyU9Ra8PjHdy9YFsEujFGDvMmIvYQ+jUOipwUrM
 cvJHSerdJZp9em/2o56n29q0FTnl8a8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 354D23CD628
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 23:15:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A710E3CBD7F
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:14:55 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 17B0210000C6
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 23:14:55 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48df54150dfso846450f8f.0
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 14:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1793830494; x=1794435294; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xL4i/Oz7uY4ewWUHETQaxuqASauNpCtgh07aW3nz2j0=;
 b=NhC7LrQqK6cjYgozQwwVflIrRqbAltsSLLAJDWKFLQgtCBEfeKOwR8pQn8Hvj2DvUy
 EG7i4X03+4yErwMIoMhw+B6tQzShpgxRiFWm4f7EJ+8nEi2Lb3JkTo6czlovrpgJR82b
 xbQtkF+gMmOdZA7N1B6W2KBAyhBDPpDDSiVmHFX58juyE7uPkh0gQyKcdLhE/goX1RpZ
 kqCC/rlJEoXTjd7aatJA+NckN5BLZfF+dLcs7ecFdkT1XkjYXFjaFZcy1njEQ07bboug
 WbxYBVwtKv8bhYvo9qWlMY+WKVUJ0JGfcfsgNX4p/eNglTT8gCDgnAHZW6iHMnyC8x1w
 P59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793830494; x=1794435294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xL4i/Oz7uY4ewWUHETQaxuqASauNpCtgh07aW3nz2j0=;
 b=SZyfalEdbgTKJYJ7i0L0NQ+Bh4/aWBYT40GAckFU4F1uC+dSYnpFrHeDjjDM9PUzfQ
 /ZPTAIkFQLqaKBgZYLB5kV3x0jqjuOXDBylr0fIPMUqfcnerifYlIZ9SxPFszUMHsvOz
 7ydCZLBKxhnh4Uo83ornk0ncu0I6MLGPp45BpN8NjlH/gruYVffh8ibKSuSRAQ1JH5TH
 CP6NAPH/HXL96WSNxkCibpS723ItE2baDXHY36toKovad4SUAHMqi3mVJcCjkBQmpqLm
 F97gI0gMX+iBE2EvpvZ1BUiLIRlti/0XyGxoZe/NU0MCKucC0HHXAWMS57Q6p+MstM0B
 awKA==
X-Gm-Message-State: APuU4Z+Y726H+2s+HuFwnuzwkixxqgTuufAFPc+zWDj0hr5gL6kwyCfe
 NZ29rWlDl98CPMokOqtcZyELv18Mf+jMpSELwcj5EHRcAuEM9gAQ+JRle0QmhWXJ8YjRp4axCyW
 bwP09QIw=
X-Gm-Gg: AYBFou3LtSC3HsRp7GhNUrgnjBzrgRY1UZMqKpMsW+FUG+5EMyehzO22wrU7DxElCDF
 wwT2kpu1wEaY66HSliAXLDpeRdwNAFMUR+ibNJfyq255Aq5kSLjePJ/XO11ZNWifdFsU3ga940q
 RTZtjhN6rjUQEZvo1Ucf3X5K3AvUwBBxHaGSBDZNYJ6cWiJDQJ9KJRsXe5dR39oR8n/fcdyelyg
 0ZYqdTNMb6qxggEUlOV5iBzQFARYRFIbeHkQdsIGTmTo9dCFPWjIuH59+ZTluKgEFewbSoXhtnZ
 WyR45MGwGeihSLKtoN24b1wvT5hZ00THP7BOSGJsDYvM4wU0x4WkXDByHbtjtsREqf1XuNsgSrN
 EKGZZhuQnYzAXiMLd3EqRciBVgXwqa6Ir3W94Z7wUfzMHZZm8TdIs4ovB1VNCZJH/fYhqsF7wDS
 BpgIXIni7Gs1tERibMQUT+CUDnIg0hR90KbkVQ1V2qG0kFYKld87cXYBI6EKN+jLWMkQn/OcKix
 O44ZWWlfyo+UIs/EFIjbTXbb5nhSuWgpId2dt9B7Kqg1t9osGr3OBLyVcZg425HdmFVKGX0D48h
 xKE/pfMeNC3TvCXX1aNpuUCd4Dm7
X-Received: by 2002:a05:6000:240b:b0:490:76de:c78b with SMTP id
 ffacd0b85a97d-49076decae9mr4460261f8f.34.1793830494371; 
 Wed, 04 Nov 2026 14:14:54 -0800 (PST)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed551dbasm5924393f8f.37.2026.11.04.14.14.53
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 14:14:53 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 23:14:50 +0100
Message-ID: <20261104221453.1076748-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/ioctl_loop0[23]: TCONF when LOOP_CHANGE_FD
 is not supported
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Avinesh Kumar <avinesh.kumar@suse.com>

LOOP_CHANGE_FD was removed by d4fabede1da0 ("loop: remove support for
swapping loop fds") n v7.4-rc1 and it fails with EOPNOTSUPP.

ioctl_loop02.c:85: TFAIL: LOOP_CHANGE_FD failed: EOPNOTSUPP (95)
ioctl_loop02.c:97: TFAIL: LOOP_CHANGE_FD failed expected EINVAL got: EOPNOTSUPP (95)

ioctl_loop03.c:34: TFAIL: LOOP_CHANGE_FD failed expected EINVAL got: EOPNOTSUPP (95)

Report TCONF for these checks.

Signed-off-by: Avinesh Kumar <avinesh.kumar@suse.com>
---
 .../kernel/syscalls/ioctl/ioctl_loop02.c      | 49 ++++++++++++-------
 .../kernel/syscalls/ioctl/ioctl_loop03.c      |  6 +++
 2 files changed, 37 insertions(+), 18 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
index 27f8e6cf968a..d0302efc301f 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop02.c
@@ -11,7 +11,9 @@
  *
  * For LOOP_CHANGE_FD, this operation is possible only if the loop device
  * is read-only and the new backing store is the same size and type as the
- * old backing store.
+ * old backing store. The ioctl was removed in Linux v7.4-rc1 by commit
+ * d4fabede1da0 ("loop: remove support for swapping loop fds") and fails with
+ * EOPNOTSUPP since then. The LOOP_CHANGE_FD checks are skipped on such kernels.
  *
  * When using LOOP_CONFIGURE :manpage:`ioctl(2)`, it can set LO_FLAGS_READ_ONLY
  * flag even though backing file with write mode.
@@ -28,7 +30,7 @@ static int file_fd, file_change_fd, file_fd_invalid;
 static char backing_path[1024];
 static char *backing_file_path;
 static char *backing_file_change_path;
-static int attach_flag, dev_fd, loop_configure_sup = 1;
+static int attach_flag, dev_fd, loop_configure_sup = 1, loop_change_fd_sup = 1;
 static char loop_ro_path[1024], dev_path[1024];
 static struct loop_config loopconfig;
 
@@ -80,23 +82,27 @@ static void verify_ioctl_loop(unsigned int n)
 	else
 		tst_res(TPASS | TTERRNO, "Can not write data in RO mode");
 
-	TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_change_fd));
-	if (TST_RET) {
-		tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed");
+	if (!loop_change_fd_sup) {
+		tst_res(TCONF, "LOOP_CHANGE_FD ioctl not supported");
 	} else {
-		tst_res(TPASS, "LOOP_CHANGE_FD succeeded");
-		TST_ASSERT_INT(loop_ro_path, 1);
-		TST_ASSERT_STR(backing_path, backing_file_change_path);
-	}
-
-	TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_fd_invalid));
-	if (TST_RET) {
-		if (TST_ERR == EINVAL)
-			tst_res(TPASS | TTERRNO, "LOOP_CHANGE_FD failed as expected");
-		else
-			tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed expected EINVAL got");
-	} else {
-		tst_res(TFAIL, "LOOP_CHANGE_FD succeeded");
+		TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_change_fd));
+		if (TST_RET) {
+			tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed");
+		} else {
+			tst_res(TPASS, "LOOP_CHANGE_FD succeeded");
+			TST_ASSERT_INT(loop_ro_path, 1);
+			TST_ASSERT_STR(backing_path, backing_file_change_path);
+		}
+
+		TEST(ioctl(dev_fd, LOOP_CHANGE_FD, file_fd_invalid));
+		if (TST_RET) {
+			if (TST_ERR == EINVAL)
+				tst_res(TPASS | TTERRNO, "LOOP_CHANGE_FD failed as expected");
+			else
+				tst_res(TFAIL | TTERRNO, "LOOP_CHANGE_FD failed expected EINVAL got");
+		} else {
+			tst_res(TFAIL, "LOOP_CHANGE_FD succeeded");
+		}
 	}
 
 	SAFE_CLOSE(file_fd);
@@ -134,6 +140,13 @@ static void setup(void)
 		tst_res(TINFO | TERRNO, "LOOP_CONFIGURE is not supported");
 		loop_configure_sup = 0;
 	}
+
+	ret = ioctl(dev_fd, LOOP_CHANGE_FD, -1);
+	if (ret && errno == EOPNOTSUPP) {
+		tst_res(TINFO | TERRNO, "LOOP_CHANGE_FD is not supported");
+		loop_change_fd_sup = 0;
+	}
+
 	loopconfig.info.lo_flags = LO_FLAGS_READ_ONLY;
 }
 
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
index 47f69e800fee..09b5ab3cce9e 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_loop03.c
@@ -10,6 +10,10 @@
  *
  * Tests whether LOOP_CHANGE_FD can not succeed (get EINVAL error)
  * when loop_dev is not read only.
+ *
+ * The ioctl was removed in Linux v7.4-rc1 by commit d4fabede1da0 ("loop:
+ * remove support for swapping loop fds") and fails with EOPNOTSUPP since then.
+ * The test reports TCONF on such kernels.
  */
 
 #include <stdio.h>
@@ -28,6 +32,8 @@ static void verify_ioctl_loop(void)
 		tst_res(TFAIL, "LOOP_CHANGE_FD succeeded unexpectedly");
 		return;
 	}
+	if (TST_ERR == EOPNOTSUPP)
+		tst_brk(TCONF | TTERRNO, "LOOP_CHANGE_FD is not supported");
 	if (TST_ERR == EINVAL)
 		tst_res(TPASS | TTERRNO, "LOOP_CHANGE_FD failed as expected");
 	else
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
