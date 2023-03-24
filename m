Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2A96C6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 00:25:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 709A73CE2F7
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 01:25:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD92A3CE2F7
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:51 +0100 (CET)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com
 [IPv6:2607:f8b0:4864:20::1149])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A49C01A0042A
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 01:24:50 +0100 (CET)
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-54196bfcd5fso2774437b3.4
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 17:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20210112; t=1679617489;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=5VR42ibL4bf5gSYfsByt/kf/pPpCCWkTIyxpPWoGn3g=;
 b=QWm+qKwTMIJgoHMjvGu/wiKAjBTtWQHTzy/NKlmnbju4s89yQQYaaGr7sgvmii7uQ1
 xzfeRrGYJq2YXeOyJQ3DB7hC5tCrxSUBU5lRlOiBlY0FEu5LFraQmc6vB3byloWcjnql
 eVLSv0Oc+av7C4OdFLB8a3PWImumoOSdqblMZrcGUsSGrf1vT1xxQPsTUP9WKZ2hElQq
 /u5N7bBPJeaRLP1YTqSnncUCwpWGQhDj/VsJRIV+v8yW9mx9+mA3ljcrJCQV5VkPe7iK
 eg7qEPfnfmWuZzzZyuhq7LqSgvo8yXc7lXeun+phYTBKk8HwTwkzk/MmdHocGUAbSl2z
 ljNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679617489;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5VR42ibL4bf5gSYfsByt/kf/pPpCCWkTIyxpPWoGn3g=;
 b=4317xfqWRDP51UIGUIy9xScBzdeK4E/NgnqUrKJFbhEGz9SQlZUrtyZMHLGYCyWp3T
 qlpi3Ovq/O5ugftuHIHGEj7ZusjRoXdzRQ7NOBxJI42ugluyiiUYmVKHbSLQAvnlI8Ya
 JjmqcG6o0Z40ge9N4RU8YfiBckx+unSmiAN0nZZuXHhp94Dan2jrv4UeRsDgG0SV9uVK
 Z81gj7PMrBpZwMot3bZc0IrLur+Gh2oS5FVtVKFsJysFe3kQ4BoV8IYwS/SWvNOUuncZ
 08rLWZQhcVE7f6Ug6EpAMghkK8HS0AodSq44EaERcZbhMe6Be94KPuRYUA0x2XGjKUuU
 QWRw==
X-Gm-Message-State: AAQBX9cKKW0jLfIO8J+9ILp79ZUapHcngNBKpmcs/sgBD1k5c6UbIE1u
 HUUsoSOnBb52T9b6Qd6UtODCqsYDvM4zIS07mCwb/HqKaWzzlMW0oWHcyund7hXTou1rrrG64Sx
 hqrcl6sbYeTFxeIENuIfUr+yeH7XOpeeiuRPgpjdioOJTaMBzcISu738S
X-Google-Smtp-Source: AKy350Z/56T64chThNMxXkDLIWh7QbrmAP9oUzcxEgdICOLZ/efyNsPtHV2WN/kJBpWhRKBZMHtL8LznVjA=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a81:b50f:0:b0:544:b8d8:339e with SMTP id
 t15-20020a81b50f000000b00544b8d8339emr204294ywh.5.1679617489485; Thu, 23 Mar
 2023 17:24:49 -0700 (PDT)
Date: Fri, 24 Mar 2023 00:24:40 +0000
In-Reply-To: <20230324002441.987778-1-edliaw@google.com>
Mime-Version: 1.0
References: <20230324002441.987778-1-edliaw@google.com>
X-Mailer: git-send-email 2.40.0.348.gf938b09366-goog
Message-ID: <20230324002441.987778-4-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 3/4] tst_find_free_loopdev: Check return value of
 set_dev_loop_path
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

tst_find_free_loopdev does not check the return value of set_dev_loop_path
and will return the last attempted path even if it does not pass a stat
check.  Change it to return TBROK if it fails to acquire a loop device.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 lib/tst_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 2c83fb764..ba46b7613 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -88,8 +88,8 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path)
-				set_dev_loop_path(rc, path, path_len);
+			if (path && set_dev_loop_path(rc, path, path_len))
+				tst_brkm(TBROK, NULL, "Could not stat loop device %i", rc);
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
-- 
2.40.0.348.gf938b09366-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
