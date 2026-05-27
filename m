Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BAEACD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 19:52:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCC593CD529
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 21:52:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B654A3CB44A
 for <ltp@lists.linux.it>; Wed, 27 May 2026 21:52:06 +0200 (CEST)
Received: from mail-dl1-x1241.google.com (mail-dl1-x1241.google.com
 [IPv6:2607:f8b0:4864:20::1241])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 227E2600548
 for <ltp@lists.linux.it>; Wed, 27 May 2026 21:52:00 +0200 (CEST)
Received: by mail-dl1-x1241.google.com with SMTP id
 a92af1059eb24-137335bc3caso2993384c88.0
 for <ltp@lists.linux.it>; Wed, 27 May 2026 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779911518; x=1780516318; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0Sp+s7C7f8D+jwwDxh0Y9qxUvL34f7v6oQb0ido5j04=;
 b=tMedRZpYXaM+XOW/mjm71mPy2YIK9BsS9nrN77mRjy1voUuYxJ4zQHtcRi/wpljOOk
 y375UEIj9ZOWYaNqyixoZFAKQTtC6s8n0X6kiNjxGd/jkZiufQB7f1uHuakDCjB04YrX
 SHKXqcf7C4iEqg374LaKTNJia5TZbRbqCbhdWMwgU5IHTu2mV7x2vsMf40YoysdFQ0pA
 Q0LiodyZTdYgZI05xZWugUsmwukhq9746R+sNvbHoSyqUSHipxnqrMel7uP/fm8N0WZY
 8HFNgStx/JoaGUos/BzEnAS/GsTKCAkTGA+GyZAucw6tQeu9EnoAVTYu+ZtkFNAA41Q2
 7Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779911518; x=1780516318;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0Sp+s7C7f8D+jwwDxh0Y9qxUvL34f7v6oQb0ido5j04=;
 b=GDhogMYAhrnsUiC5L0fBXLkBqc1a9RQVFOX8vjDVXdVU6rvPyu1szuIlViHobpD7Iu
 YMwXc9TVzE/6T7qY2ork2zyIZZN53lDtl0ScggXlOB0uny7phRNC3RNEqHod/rHRz74c
 gMo1syJNVgDHbr0YHWPGyijXwtJXlb/fnK6TS6ed3E0Bjfq/B9ppX8AjDefqWuglzoTe
 Z6heGn+JDhP8LZdbOvdC84EwiGeTIny6tf5JKKhzVZ1JPePQwoIgCixLgTtTG1t+JAdI
 DVaDjtx2OPb71BzB/fBgB0t1RskNZCCpMBzOYLKZVZZRxdeEIjn5o41ewPl0EFNjQ/Uj
 WKQg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9Ay1/VXKN0+4QDrQpYDWbkJ4FNy7aSdUiHt3ZU0EvbtEmEDdmZ5QyK00n6psIJP4V04hY=@lists.linux.it
X-Gm-Message-State: AOJu0Yxs74ORPZQaqafCrONVGlii92Nyyn4R+cwZ3XEy/pTk8ovFQ4u2
 ymlyUGtByZxKHHc4hVpm+ArEm0ur2LxtM/OYaw2TKaitl+3OXh50CPlk
X-Gm-Gg: Acq92OH0cbvuCH0xu7VQxVJNwJEWjUaONiIclEs3NhilM82Ekh1aA1WfpFNc+AprWnW
 8mKV+Dro05lCwkQi+aRUNpxrcFkO9egfhhiRgnGujWBhOIH8SniXoY5DFkLWjurWfHRNEZOWEjm
 2rrvTNoKr/vJIxZNGfJ1ApB/M5KoV+VYOlIEmyK/DFaBxlieFI3XeaKGdAsFKa1gJiogkSjq3uJ
 Xnp4Xh4luaRu72md/3YkWSpd87Pm0fqlyNyTbeSeUYt9IpABR7ORwpnC3Get52ykHXM5tv7LQVO
 LMEcb+IRzD3IsvzhfGmLm95XSclRmxFKSUji8lCrLbeXQpE1brPfMp5x8KNShd7Plku+K8lYEtf
 VTKFuhR7ce8DPEq4zIAjwNgpQv6ComOo+KAgaqUYUC4z62y/l+5OFLRnLpqJ9B4T81KVxpC8I+h
 PoNuzf7NKekN9eZRNiDuHr33QDeSwbVg==
X-Received: by 2002:a05:7022:61a0:b0:133:3c47:92de with SMTP id
 a92af1059eb24-1365f812367mr9061282c88.17.1779911518387; 
 Wed, 27 May 2026 12:51:58 -0700 (PDT)
Received: from anonyme ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451ef4719sm13705106eec.1.2026.05.27.12.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 12:51:58 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: pvorel@suse.cz
Date: Thu, 28 May 2026 03:50:55 +0800
Message-ID: <20260527195056.337081-1-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527072312.GA231966@pevik>
References: <20260527072312.GA231966@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] fanotify: fix crash when running multiple
 iterations
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
Cc: jack@suse.cz, amir73il@gmail.com, linux-kernel@vger.kernel.org,
 AnonymeMeow <anonymemeow@gmail.com>, repnop@google.com,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This commit fixes ./fanotify13 -i10 crash by restoring the deleted objects
every time a test finishes.

This commit also fixes ./fanotify21 -i10 crash by remounting the read-only
mount (if the mount is remounted read-only during the test) back to
read-write every time a test finishes.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
---

On 2026-05-27 09:23:12+02:00, Petr Vorel wrote:
> @AnonymeMeow nit: if you put whole conversation after --- (below), it will not
> be part of the commit message when one applies the patch. And here should be a
> proper commit message.

Thank you for pointing this out, I will be more mindful the next time
(this time).

> Also I found that fanotify21.c on the current master fails when running more
> than 1 iteration:

Thanks for testing my patch, I didn't know that the standalone test binary
supports the -i option to specify the number of iterations. Running
multiple iterations through kirk's -i option seems to work fine.

I then tested all fanotify tests with the -i option and found that
fanotify13 also crashed when running multiple iterations. I fixed both
fanotify13 and fanotify21 in this patch. So now all fanotify tests pass
with the -i option.

With Best Regards,
AnonymeMeow

---
 .../kernel/syscalls/fanotify/fanotify13.c     | 20 +++++++++++++++++++
 .../kernel/syscalls/fanotify/fanotify21.c     | 13 +++++++++++-
 2 files changed, 32 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify13.c b/testcases/kernel/syscalls/fanotify/fanotify13.c
index 76d40eaf7..540e0b483 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify13.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify13.c
@@ -137,6 +137,16 @@ static void delete_objects(void)
 	}
 }
 
+static void clean_upper_dir(void)
+{
+	unsigned int i;
+
+	SAFE_MOUNT(OVL_UPPER, MOUNT_PATH, "none", MS_BIND, NULL);
+	for (i = 0; i < ARRAY_SIZE(objects); i++)
+		SAFE_UNLINK(objects[i].path);
+	SAFE_UMOUNT(MOUNT_PATH);
+}
+
 static void get_object_stats(void)
 {
 	unsigned int i;
@@ -340,6 +350,15 @@ static void do_test(unsigned int number)
 			"Did not get an expected event (expected: %llx)",
 			event_set[i].expected_mask);
 	}
+
+	if (tc->mask & FAN_DELETE_SELF) {
+		if (tst_variant & 1) {
+			clean_upper_dir();
+		} else {
+			create_objects();
+			get_object_stats();
+		}
+	}
 out:
 	SAFE_CLOSE(fanotify_fd);
 }
@@ -417,6 +436,7 @@ static void do_cleanup(void)
 	if (ovl_bind_mounted)
 		SAFE_UMOUNT(MOUNT_PATH);
 	if (bind_mounted) {
+		delete_objects();
 		SAFE_UMOUNT(MOUNT_PATH);
 		SAFE_RMDIR(MOUNT_PATH);
 	}
diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index 340fb0018..2e3dbd4bd 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -199,7 +199,7 @@ static void do_test(unsigned int num)
 	if (len < 0) {
 		if (tc->remount_ro && !fd_err && errno == EROFS) {
 			tst_res(TPASS, "cannot read event with rw fd from a ro fs");
-			return;
+			goto restore_rw_mount;
 		}
 		tst_brk(TBROK | TERRNO, "reading fanotify events failed");
 	} else if (tc->remount_ro && !fd_err) {
@@ -346,6 +346,17 @@ next_event:
 		if (event_pidfd_fdinfo)
 			free(event_pidfd_fdinfo);
 	}
+
+restore_rw_mount:
+	if (tc->remount_ro) {
+		/* SAFE_MOUNT fails to remount FUSE */
+		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
+			  MS_REMOUNT, NULL) != 0) {
+			tst_brk(TFAIL,
+				"filesystem %s failed to remount read-write",
+				tst_device->fs_type);
+		}
+	}
 }
 
 static void do_cleanup(void)
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
