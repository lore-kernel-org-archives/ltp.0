Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21F2CD6E44
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 15:20:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0A0A33CFFC6
	for <ltp@archiver.kernel.org>; Thu, 28 May 2026 17:20:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237DF3CB44A
 for <ltp@lists.linux.it>; Thu, 28 May 2026 17:19:43 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8B460602270
 for <ltp@lists.linux.it>; Thu, 28 May 2026 17:19:43 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-bd2d8bb1068so2366608266b.1
 for <ltp@lists.linux.it>; Thu, 28 May 2026 08:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779981583; x=1780586383; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m7ut+RhGP4s1Xy445lkTHmcOOXnl4w9cuBMvQ4t59Vk=;
 b=eyaqwsx1HW9/vffamhOeUl8PodOqIKHHOmJJ+oK1XhTWf8om7tOQ80vs4+PNvUOAKW
 +jMbDuTgrZyCqPBbuPDJV1WCqs1zhOfteeT2YgGmSnhS9x+M6Ds+dzESP+lqZlc0DEW9
 0yLZq6pfNXOSszD/rX8JUNcb4QlVEg41eI7tJDz6bWfvcNMoMTx6F28AKEoNUV5RP9oL
 dbCr2iLJXTKy93N1FzNnBAxSUFIUmdI7xUu9sNv07K/sVdNaOOwgtrxpZMMbHi2qgGJI
 Y8Qh7cPdZipjmOY0PdfMdhEkZ40INPSAGMaqH7/DBI1CRS/28uRvNAYGErgekBHa/clc
 jyHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779981583; x=1780586383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m7ut+RhGP4s1Xy445lkTHmcOOXnl4w9cuBMvQ4t59Vk=;
 b=dVKU8sfi1F/uwsoBrgc71xfAqyzxqsmzBAY3GIc0bR8ymIuoMJEvYo//waXUsx383Q
 59cSTJghY1+SLISTAeOHXNLTmvz7Si3vHXFArpkQdQ9Bh89F6Q2K+YiMXGYVGesCwJ4x
 hIcmS6l/9f+OzyRMBdlIBgudJQsWpOn9b4y+7K7NVgQXhtlmWZmWXCx/etjf3C86WMhL
 Z9IT3uIfkDqAGwKPmksFIo3omgZgqwDFXUX5db+Zdq38vkYyoz74m402q8RuLhEBmgpZ
 So/wLkDtdF9r1GDqc3MvpSF7OKU5nq0iPp/B7hjY43vPBAxf0279UMnWBoSpIMHzZIJA
 P6/w==
X-Forwarded-Encrypted: i=1;
 AFNElJ8rfSyIua8Tpuo4ePvQ6M1i42Yo3oQNYdAuJJ/Ir2TO3L3R8GAu9Tmg2Hp/SznBoVQ8dvs=@lists.linux.it
X-Gm-Message-State: AOJu0YynIZb374vEcRfcCJ91Jc7Eg6T8lGj5NZM2ehC65Ojz1NnvAaPu
 k9x5bdxWz6uBCs1CDdP7Hb/QuxS6DawJi/zzAOhmeVucvbzMsDyVlQ/i
X-Gm-Gg: Acq92OEe6aNTDKHl1lvcPGqYhvZlgVJCuIJoqHDY3kWmjsChw43EYdI8O3vVvM597bM
 JKHMjL/iQAE8PPo49Gszp7vOeaZ1hnsgGHTtEkVJ5oC1q9HXHcVrFdFX90TGBsk1P9RlfMnety9
 vZB2YJPhqKj+TYg8bwZX3v6YOcUM3BybEu3qjaJcBvYcEZKzV9tCmlE+eKw309iVmrHHFbU0Jew
 x6YQ4CBwGr4fiKtZiqm+3X7TLG5Ilw/YWuQZli5m8NqmvS/tS5RnOM2hAqJxH0tuph8vRNGeZ+d
 5I3o9XEnyeoP3EkLvm0tB/fooGPqyblk7a8LlFa0nqkE2iQwSJxnUv1FvhiWF52UZUCimo2m2lA
 7kqLk00Re0DtlvOcHHfOk3LQc8172d9m+qEkzRFVG5qioFYbysXqdSzlJ2WGHhx/rx47tCeAPdy
 yYp1bY3xOt5bgmjlYbO/kefON6YXVpV9gMxZfX3I/SZLWc45i1TpYpxT2Xu2g4HZLZn7TzxpXqa
 GsJwhxseXR+vjpExPZMXm0proLLji3OaXGKac6trk9RmyNP1g==
X-Received: by 2002:a17:907:7803:b0:bd5:e3e:98cf with SMTP id
 a640c23a62f3a-bdd281a5d20mr1281437666b.46.1779981582651; 
 Thu, 28 May 2026 08:19:42 -0700 (PDT)
Received: from localhost
 (2001-1c00-570d-ee00-4e63-8cf6-4447-e472.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:570d:ee00:4e63:8cf6:4447:e472])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc264e419sm724469466b.12.2026.05.28.08.19.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 08:19:41 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 28 May 2026 17:19:38 +0200
Message-ID: <20260528151938.909301-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528151938.909301-1-amir73il@gmail.com>
References: <20260528151938.909301-1-amir73il@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify21: fix test failure when running iterations
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it,
 AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Peter reported that fanotify21 -i2 fails.
Fix this by always remounting ro/rw before every test.
Use a bind mount, where remount works regardless of base fs.

Reported-by: pvorel@suse.cz
Link: https://lore.kernel.org/linux-fsdevel/20260527072312.GA231966@pevik/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Petr,

This is a simplified version of AnonymeMeow's patch.

Thanks,
Amir.

 .../kernel/syscalls/fanotify/fanotify21.c      | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index c95895c93..fd18d7e29 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -123,6 +123,9 @@ static void do_setup(void)
 	int pidfd;
 	int init_flags = FAN_REPORT_PIDFD;
 
+	/* Bind mount so remount ro/rw always work */
+	SAFE_MOUNT(MOUNT_PATH, MOUNT_PATH, "none", MS_BIND, NULL);
+
 	if (tst_variant) {
 		fanotify_fd = -1;
 		fd_error_unsupported = fanotify_init_flags_supported_on_fs(FAN_REPORT_FD_ERROR, ".");
@@ -171,15 +174,9 @@ static void do_test(unsigned int num)
 		return;
 	}
 
-	if (tc->remount_ro) {
-		/* SAFE_MOUNT fails to remount FUSE */
-		if (mount(tst_device->dev, MOUNT_PATH, tst_device->fs_type,
-			  MS_REMOUNT|MS_RDONLY, NULL) != 0) {
-			tst_brk(TFAIL,
-				"filesystem %s failed to remount readonly",
-				tst_device->fs_type);
-		}
-	}
+	/* remount ro/rw the bind mount */
+	SAFE_MOUNT("none", MOUNT_PATH, "none", MS_BIND | MS_REMOUNT |
+		   (tc->remount_ro ? MS_RDONLY : 0), NULL);
 
 	/*
 	 * Generate the event in either self or a child process. Event
@@ -355,6 +352,9 @@ static void do_cleanup(void)
 
 	if (self_pidfd_fdinfo)
 		free(self_pidfd_fdinfo);
+
+	/* Unmount the bind mount */
+	SAFE_UMOUNT(MOUNT_PATH);
 }
 
 static struct tst_test test = {
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
