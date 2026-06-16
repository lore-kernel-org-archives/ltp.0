Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A749CD98D2
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 21:06:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B30B13E6C58
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 23:06:14 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6634C3E2AA8
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:12 +0200 (CEST)
Received: from mail-dy1-x1343.google.com (mail-dy1-x1343.google.com
 [IPv6:2607:f8b0:4864:20::1343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 35461600839
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 23:05:11 +0200 (CEST)
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso498027eec.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781643909; x=1782248709; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J8sOM5A90H3unqhO8X/DmFY28i0IGGFInjtQQkpQOXI=;
 b=edYMw+1Fdeql/p11Yd72c/PorC6UKMSf9uXU8yZ1sY3OcZfPihZoYZwLRnw9erINQs
 LbOummWt5f1PaZPfNSrccsJCEhP8XswRPg/S1+qIb4NxQQBLF1N4klUfkZ7l/6j5RaFv
 rUxoc430LE7PqkAcNQBtT+cUwdK/780DK3sXk2jD1W6abk60MqFWkZ6fa7A8iigzywdg
 uGZHixinWai263/f7i6addDef3DAsfY8wLtNy7cWNp8jTczUrYEEOYAi9R+C8EqejIQi
 Q4R3+fPCL1ghghuIs3BkA8U7LiZzG0PukkRp7py29n7vuNc4XYSr+VQ6XC4tu1dewKTn
 fQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781643909; x=1782248709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J8sOM5A90H3unqhO8X/DmFY28i0IGGFInjtQQkpQOXI=;
 b=JYjjefM/O+5q7NqfeEElC/0uNxPEZbhH4CALo5NXOw0UVoNVI9PBPFt97+83v+Qq0z
 2vfCv4DjXshWGuzsojsoQfGvsEJZNM0zMScOJFYutxZIXD1TcknUvObCPAIoJyX/gybx
 ABiDiNcKk7lJg6tveupKBLoGWv2t2oJh5U5npfXOhWrgKKtLV44QsbkYcP6JGvkp6C8Y
 y36b4jEWG295PA42sNwFHjUaDnDbX7s2Y1yy20APMj/t+jWaHOPUb3SUV+oC4fDka64l
 Bgutx+EZ5EMTanzXP2O8Xp8wahlaykyoRerFvvEbtomee7fRoVE44d7uVupZ+cXnV36D
 DiAA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mZwT/D12BM+gMMva+JtWdhNvQ9qf8+6uajilEQ+OcT53Jzem38id4q69MHXHPIydL1C8=@lists.linux.it
X-Gm-Message-State: AOJu0Ywg4ceg89KH1KaG1qTmsSaThC12pkXpB14FrXSDOW8AZVDjsRyl
 ahKy3WHsc0TLi6hpReZ1VgtUt3TakFyXxfH7vLxcJ3qO3MtbiJ0hIYZZ
X-Gm-Gg: Acq92OEMCsSnSBC0UOeS4MLNhwsQd5tGVl8RUcpOZR1GDNrkhnv69stYAcXT0QfMJHP
 bJFi7wQdx6mQx0TrIfAJX3xxbMFls/T50ORxR4HxbGIXlJUa2la2KgY+HDyumO7U02GW5YOOkx8
 mzvFBkoBcEkeKT6jxDPdgDjvJ6eBKLJzlLlJl+cDXFVrre39e1WMvtDZseqn1dDwyouTgJkFCM2
 50qBaG92P7QpDYoXkOSeGRhMyYKX69qgv2DGnlG/fh+HSF21qCxezhQf07BiYrGOZy+oOnHLxFK
 +PyNqpHkCr17OBJvYwYmw0Cz9X69JhJOPNiu80ifx6Z5VTgLpdwHLyc98NrdE7TQ6hEcUX4cXJQ
 550hXVegPJC5M+u3FaHms63YzW9q3eRq9INBwFSWvU8YDQzpPMWXMTzkZYGUN2pPfwPBWMZ4hko
 w/vDomBrlh4/RwsWor
X-Received: by 2002:a05:7300:2153:b0:304:3c33:7ae7 with SMTP id
 5a478bee46e88-30bc992aa92mr610962eec.7.1781643909439; 
 Tue, 16 Jun 2026 14:05:09 -0700 (PDT)
Received: from cirno ([2605:52c0:2:2f27:be24:11ff:fe89:6f0f])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081e5d0828sm22231766eec.10.2026.06.16.14.05.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 14:05:09 -0700 (PDT)
From: AnonymeMeow <anonymemeow@gmail.com>
To: jack@suse.cz
Date: Wed, 17 Jun 2026 05:04:46 +0800
Message-ID: <20260616210448.12175-4-anonymemeow@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616210448.12175-1-anonymemeow@gmail.com>
References: <20260616210448.12175-1-anonymemeow@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 3/5] fanotify21: Simplify read_pidfd_fdinfo()
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
Cc: amir73il@gmail.com, ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Let callers provide storage for struct pidfd_fdinfo_t instead of
allocating it in read_pidfd_fdinfo() every time. This removes
unnecessary allocation/free paths and the NULL checks after
read_pidfd_fdinfo() and simplifies the code.

Signed-off-by: AnonymeMeow <anonymemeow@gmail.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
---
 .../kernel/syscalls/fanotify/fanotify21.c     | 61 ++++++-------------
 1 file changed, 20 insertions(+), 41 deletions(-)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify21.c b/testcases/kernel/syscalls/fanotify/fanotify21.c
index bd1a43513..22f9767db 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify21.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify21.c
@@ -64,7 +64,7 @@ static struct test_case_t {
 
 static int fanotify_fd;
 static char event_buf[BUF_SZ];
-static struct pidfd_fdinfo_t *self_pidfd_fdinfo;
+static struct pidfd_fdinfo_t exp_pidfd_fdinfo;
 
 static int fd_error_unsupported;
 
@@ -73,12 +73,9 @@ static struct tst_clone_args clone_args = {
 	.exit_signal = SIGCHLD,
 };
 
-static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
+static void read_pidfd_fdinfo(int pidfd, struct pidfd_fdinfo_t *pidfd_fdinfo)
 {
 	char *fdinfo_path;
-	struct pidfd_fdinfo_t *pidfd_fdinfo;
-
-	pidfd_fdinfo = SAFE_MALLOC(sizeof(struct pidfd_fdinfo_t));
 
 	SAFE_ASPRINTF(&fdinfo_path, "/proc/self/fdinfo/%d", pidfd);
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "pos: %d", &pidfd_fdinfo->pos);
@@ -88,8 +85,6 @@ static struct pidfd_fdinfo_t *read_pidfd_fdinfo(int pidfd)
 	SAFE_FILE_LINES_SCANF(fdinfo_path, "NSpid: %d", &pidfd_fdinfo->ns_pid);
 
 	free(fdinfo_path);
-
-	return pidfd_fdinfo;
 }
 
 static void generate_event(void)
@@ -133,12 +128,9 @@ static void do_setup(void)
 
 	pidfd = SAFE_PIDFD_OPEN(getpid(), 0);
 
-	self_pidfd_fdinfo = read_pidfd_fdinfo(pidfd);
-	if (self_pidfd_fdinfo == NULL) {
-		tst_brk(TBROK,
-			"pidfd=%d, failed to read pidfd fdinfo",
-			pidfd);
-	}
+	read_pidfd_fdinfo(pidfd, &exp_pidfd_fdinfo);
+
+	SAFE_CLOSE(pidfd);
 }
 
 static void do_test(unsigned int num)
@@ -195,7 +187,7 @@ static void do_test(unsigned int num)
 	while (i < len) {
 		struct fanotify_event_metadata *event;
 		struct fanotify_event_info_pidfd *info;
-		struct pidfd_fdinfo_t *event_pidfd_fdinfo = NULL;
+		struct pidfd_fdinfo_t event_pidfd_fdinfo;
 
 		event = (struct fanotify_event_metadata *)&event_buf[i];
 		info = (struct fanotify_event_info_pidfd *)(event + 1);
@@ -275,39 +267,32 @@ static void do_test(unsigned int num)
 		 * No pidfd errors occurred, continue with verifying pidfd
 		 * fdinfo validity.
 		 */
-		event_pidfd_fdinfo = read_pidfd_fdinfo(info->pidfd);
-		if (event_pidfd_fdinfo == NULL) {
-			tst_brk(TBROK,
-				"reading fdinfo for pidfd: %d "
-				"describing pid: %u failed",
-				info->pidfd,
-				(unsigned int)event->pid);
-			goto next_event;
-		} else if (event_pidfd_fdinfo->pid != event->pid) {
+		read_pidfd_fdinfo(info->pidfd, &event_pidfd_fdinfo);
+		if (event_pidfd_fdinfo.pid != event->pid) {
 			tst_res(TFAIL,
 				"pidfd provided for incorrect pid "
 				"(expected pidfd for pid: %u, got pidfd for "
 				"pid: %u)",
 				(unsigned int)event->pid,
-				(unsigned int)event_pidfd_fdinfo->pid);
+				(unsigned int)event_pidfd_fdinfo.pid);
 			goto next_event;
-		} else if (memcmp(event_pidfd_fdinfo, self_pidfd_fdinfo,
+		} else if (memcmp(&event_pidfd_fdinfo, &exp_pidfd_fdinfo,
 				  sizeof(struct pidfd_fdinfo_t))) {
 			tst_res(TFAIL,
 				"pidfd fdinfo values for self and event differ "
 				"(expected pos: %d, flags: %x, mnt_id: %d, "
 				"pid: %d, ns_pid: %d, got pos: %d, "
 				"flags: %x, mnt_id: %d, pid: %d, ns_pid: %d",
-				self_pidfd_fdinfo->pos,
-				self_pidfd_fdinfo->flags,
-				self_pidfd_fdinfo->mnt_id,
-				self_pidfd_fdinfo->pid,
-				self_pidfd_fdinfo->ns_pid,
-				event_pidfd_fdinfo->pos,
-				event_pidfd_fdinfo->flags,
-				event_pidfd_fdinfo->mnt_id,
-				event_pidfd_fdinfo->pid,
-				event_pidfd_fdinfo->ns_pid);
+				exp_pidfd_fdinfo.pos,
+				exp_pidfd_fdinfo.flags,
+				exp_pidfd_fdinfo.mnt_id,
+				exp_pidfd_fdinfo.pid,
+				exp_pidfd_fdinfo.ns_pid,
+				event_pidfd_fdinfo.pos,
+				event_pidfd_fdinfo.flags,
+				event_pidfd_fdinfo.mnt_id,
+				event_pidfd_fdinfo.pid,
+				event_pidfd_fdinfo.ns_pid);
 			goto next_event;
 		} else {
 			tst_res(TPASS,
@@ -329,9 +314,6 @@ next_event:
 
 		if (info && info->pidfd >= 0)
 			SAFE_CLOSE(info->pidfd);
-
-		if (event_pidfd_fdinfo)
-			free(event_pidfd_fdinfo);
 	}
 
 	if (tc->want_pidfd_err)
@@ -343,9 +325,6 @@ static void do_cleanup(void)
 	if (fanotify_fd >= 0)
 		SAFE_CLOSE(fanotify_fd);
 
-	if (self_pidfd_fdinfo)
-		free(self_pidfd_fdinfo);
-
 	/* Unmount the bind mount */
 	SAFE_UMOUNT(MOUNT_PATH);
 }
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
