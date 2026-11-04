Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE24608362D
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=LRBFvzLl;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RVc4wOuS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793810845; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ywg9xH7Q90bzZjfpJonHrZNZ+vkxz9agL5JZU712sv0=;
 b=LRBFvzLlgPU+G2uRb7qh88H4ouw/KM+EzSsavpbIhZNVaG1w60T9Sjt60w2coaL3CHBS7
 IB9gYXQprngtwYF9j+UYVGKtmRVOuEghSdCeKmrrtux4ZbuE18zmI1+SUmhX85q77GPZ9U3
 O2ENrrsf1EU4nFk3jn5jsECyV0ZDjTk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70D253CC745
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 17:47:25 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E773F3C2707
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:47:05 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4D0E81000350
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:47:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793810823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=C+CpPNWcWUZjuBBFsYgXbJdQGw4fIJ9yo5e+H1Yikrw=;
 b=RVc4wOuSOIo4jvI21BMyUFV3aXtLkcEYylIwzFetHuqycH/ogkerMo0/Ab6fyKIUQqadan
 JeXtXFxQCBQQvbwic3Go83e2In6QD9qdbuyaAdNGfCNtrVjULrDZJfiy6dz05E5VCl2Y82
 xZXQ9WGEGzdxBAzp7ZHXyzuI2oohoUk=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-hYbGGj_tOASleqoSWzwK7w-1; Wed, 04 Nov 2026 11:47:02 -0500
X-MC-Unique: hYbGGj_tOASleqoSWzwK7w-1
X-Mimecast-MFC-AGG-ID: hYbGGj_tOASleqoSWzwK7w_1793810822
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8a88d53c7a6so15094497b3.2
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 08:47:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793810822; x=1794415622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C+CpPNWcWUZjuBBFsYgXbJdQGw4fIJ9yo5e+H1Yikrw=;
 b=geEDMRT2QhzBC/nnk0ph4MDtjP8gcYfTc0xRGcZBhjHSLDsi//9Bi4e8XfbcfcM9Br
 g0mg9cLTJBxcBlB6vvAkXYCYBWlNuzqUkC12CsdxGRu39ggsmWMo+h8rmWPSjwpfHn2b
 1ubcMmhiGh4fTNYDd973U45eR8VCIN6srFXuPIEsBHOcdY/KosDSQ30TKuSz0BKkA8wo
 e2CIDOQQfQLyrtgrK3SP2Rgrh2U0on5llK56OhwstSmyL3LyJoSuO0j7ONfGimwE4+/N
 r75yx0Jlurci9sE+ojEgKLN539vuQhjZHcrS0NocHReCZI/dZGpBDKUjbdV7jntNClyF
 xQQg==
X-Gm-Message-State: APuU4Z8lX4QKv8ftckEnHa5CzSDmy/FAaHg/nrtcGjVOhntKYX1sgVyH
 nKcYTU7yxwY9Tqflz92xPkjtGhqYKUAwt/OXQyf2/EUfyA8mhz7qBilGCPMMXRjPMjgGTMRLN8N
 nn/3m49uHU0qWpWNQdzJbtnGrFd6cvc7eE83d1Nn1buqUaYnB6l2ibML1QHSyh3NJ28fdY2Pp/Z
 hIkez0h9x3zT2PpkaE66WLQUf7pQkynR+6c1F1
X-Gm-Gg: AYBFou1jzkSpriIU4xed/OIMUijv0fFiE0WhNdiNxRciOt8MbjDNVgTj6gGS4ZK9Xus
 sy5Gw+b0C0sOMre80riK7CfYW8bHTFi5qqfHlXSMtIabviEFiCN4EWLiaYt1HiKR2UKtPTMw8Na
 pHbtZb7TPl/CaC2jTJWiFSbCUNyKpcgCUqAmw5QtFuOP7b7xlDGH4PfPfyy8k1sY+pQxDMQKlvu
 /KabQNhgog8VF3U9wRq3zS9jf+AqmsqVrINlrsqedl0uaYB3jtVHGuEBV2padv39w16aqoNvhOu
 ImNLD4KXR9MxoR3I77mR8qKzn9FCUvSsWUVyYxDkXuUEltxCBGl7F+l/zPv8U2K1Vr9QWtaM9PN
 aW+3eVtJfeB7Hrjk3ThJuK1K6Mf0Gu88lm4iQj6QvQJukPNT2QWRsy7ijFuRMduWH24Xz30SnBr
 U=
X-Received: by 2002:a05:690c:660e:b0:8ab:40c4:efe with SMTP id
 00721157ae682-8b2b658dbc4mr95397087b3.13.1793810821434; 
 Wed, 04 Nov 2026 08:47:01 -0800 (PST)
X-Received: by 2002:a05:690c:660e:b0:8ab:40c4:efe with SMTP id
 00721157ae682-8b2b658dbc4mr95396757b3.13.1793810819368; 
 Wed, 04 Nov 2026 08:46:59 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.csb ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b309959603sm22468087b3.24.2026.11.04.08.46.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 08:46:58 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 11:46:36 -0500
Message-ID: <20261104164638.407069-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261104144643.377172-1-sbertram@redhat.com>
References: <20261104144643.377172-1-sbertram@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: r0dhvAkyU0UAp2p_jKf7KraCJUOCu-UddA5cysCWe-s_1793810822
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] accept03/tst_fd: Harden parallel runs against
 shared path races
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

Concurrent syscall runs can TBROK in tst_fd when multiple processes
race on fixed fd_file/fd_dir names (unlink ENOENT). Use pid-unique
paths with O_EXCL, distinct names for the file and O_PATH cases.

This covers accept03, epoll_pwait06, ioctl_pidfd01, and splice07,
which call TST_FD_FOREACH without a private tmpdir.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 lib/tst_fd.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/lib/tst_fd.c b/lib/tst_fd.c
index 6538a098c..5d4430cf8 100644
--- a/lib/tst_fd.c
+++ b/lib/tst_fd.c
@@ -30,29 +30,42 @@ struct tst_fd_desc {
 	const char *desc;
 };
 
+static void fd_path(char *buf, size_t len, const char *prefix)
+{
+	snprintf(buf, len, "%s_%d", prefix, getpid());
+}
+
 static void open_file(struct tst_fd *fd)
 {
-	fd->fd = SAFE_OPEN("fd_file", O_RDWR | O_CREAT, 0666);
-	SAFE_UNLINK("fd_file");
+	char path[64];
+
+	fd_path(path, sizeof(path), "fd_file");
+	fd->fd = SAFE_OPEN(path, O_RDWR | O_CREAT | O_EXCL, 0666);
+	SAFE_UNLINK(path);
 }
 
 static void open_path(struct tst_fd *fd)
 {
+	char path[64];
 	int tfd;
 
-	tfd = SAFE_CREAT("fd_file", 0666);
+	fd_path(path, sizeof(path), "fd_path");
+	tfd = SAFE_OPEN(path, O_RDWR | O_CREAT | O_EXCL, 0666);
 	SAFE_CLOSE(tfd);
 
-	fd->fd = SAFE_OPEN("fd_file", O_PATH);
+	fd->fd = SAFE_OPEN(path, O_PATH);
 
-	SAFE_UNLINK("fd_file");
+	SAFE_UNLINK(path);
 }
 
 static void open_dir(struct tst_fd *fd)
 {
-	SAFE_MKDIR("fd_dir", 0700);
-	fd->fd = SAFE_OPEN("fd_dir", O_DIRECTORY);
-	SAFE_RMDIR("fd_dir");
+	char path[64];
+
+	fd_path(path, sizeof(path), "fd_dir");
+	SAFE_MKDIR(path, 0700);
+	fd->fd = SAFE_OPEN(path, O_DIRECTORY);
+	SAFE_RMDIR(path);
 }
 
 static void open_dev_zero(struct tst_fd *fd)
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
