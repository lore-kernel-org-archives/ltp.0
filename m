Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1518E606A328
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 14:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=oDlkq1JW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fzojdOY4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793803633; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=f9lVktYavp9/1P9D3sDy3+VWHXGiT6qhqsyOMFsnlaI=;
 b=oDlkq1JWav5AfcDpojpYWw919H4d+LPcbX2sKLrOnXXcOAFpCcxbS2mVLdXLsAC8+UIKA
 saBovRi/ODzf7wlVd2+WUusT5o+vTAHKwMwvvdzJvSiSNNHvl7KabIuhEuzj7T7Alz0G6B1
 j5yK2+a11gSoP/L1p6Rqt3w0h6tmj6A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B3A893CC187
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 15:47:13 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFF003CC097
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 15:46:53 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F35F61000367
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 15:46:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793803611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A7YzyxBWY9wbzw+KD8hz8nrn6W5RkfNtClvS0wwnDGY=;
 b=fzojdOY4Sx/E/E1mBTHfDwnyfUmp+fgromEkDAfny8fJAkqPUOIa0B33OiKZ0TYRoFQyHw
 tKbZy69+kJzUKb3N8di5fE2yupwzogzUEtKMsBAKl3RRG0FHW5nxnZ8rW37FQkYSZE07rR
 +HFA4UgrJ5eFHVXJ5EH0Gc3zJLOYT0Q=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-jBF0ST95Nx6OwAOOwddPZA-1; Wed, 04 Nov 2026 09:46:49 -0500
X-MC-Unique: jBF0ST95Nx6OwAOOwddPZA-1
X-Mimecast-MFC-AGG-ID: jBF0ST95Nx6OwAOOwddPZA_1793803609
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b155f4eb8eso12832167b3.1
 for <ltp@lists.linux.it>; Wed, 04 Nov 2026 06:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793803609; x=1794408409;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=A7YzyxBWY9wbzw+KD8hz8nrn6W5RkfNtClvS0wwnDGY=;
 b=pV3qrixyvWyBAVTZwAzl130XS9+OJR/W4XYwLG01F0pVlS+41qbs9U8+0kvQpd+s3Q
 lKxAm8QDyu/o0QqSvB2vMQnEP2sgmGByLzPaIELxnQyuOCOsnhJrRXlCRas+gPiTfmXY
 UoLXnaw2fVtUdaNRU6DGAfHInXdoZjKE6FNYQwtpHTk6fCcgBguvpnqDJ31shwVvxwMJ
 PVOcGCvek+naFDIyC4LYjLP74sEk8ot4toGqQxVYD01MU7UUC7dIJbDUsvgycO3CqiZO
 iTcu7AaoO4ClfqAAgXOFD9C9voH/UlFkjtx3//tlDt9tsuUVwM+xiv6LFN9ySCBk+OLd
 ll0w==
X-Gm-Message-State: APuU4Z/QZjKDkBtJBA1G5J5o1ev0JtGKGg5g+M2GhlknHYsn5S3xOyF2
 wXjBpBEnsU57hhxEPWQ9tsbdBcjAntwm+22lsvXWW0GDZ4+tmbTlDlNqUJE3p2l2kdY1Gywe23I
 iwltxVtxzekK4dwzOHQ94WKK5nGtYDMsJdvxqXVPw8iMnNDZMi3GBpsrM8eiCLMxsUhI5QfDKNr
 iJ5bu6JVE231pjYikpE/uZzrE5DNoPpQtN3wJ0
X-Gm-Gg: AYBFou2OJiamZUkOAKNIfFe5KFpN4O4EcrgA+i0oGS+Q8+I/PslIiml6JLs74tFmuTJ
 27XAD0ZZg2V0sibj1NDlevqWKb8cg9cqRl5UqbAdqT7+G/l8c4UXZDGJ/MsqYxNGen4I4ZHMBf6
 jrcTbwaopy95Q4KVOijj7beb/H5FNTH5E2oICJbn+0uVLTqPQYoBx0+60r3Q1N7Z5WxLwF7yl2B
 mTkIRNE7jptqzHWxXvtudvfcrRczPAz0C0/sGuo6E+OQEpicMc1LzqXngsYcQ+DLo+tnZt8eFxz
 ZGhfm9J2RTv5kVxUQKCvU5YLINT3VR+jKZF7tKxmuXFLXvXxABMSFeB8wrGuXhyPkQkDL/GPMnl
 vqHqCMD8eNcecLeO4Di3g8+mvuViF83ko16mKrnymdBbH4aHya8Hq0J8L23NTBniFp8PKi0PJGA
 ==
X-Received: by 2002:a05:690c:4:b0:8af:de3f:dbef with SMTP id
 00721157ae682-8b2b676a64cmr92668987b3.49.1793803609121; 
 Wed, 04 Nov 2026 06:46:49 -0800 (PST)
X-Received: by 2002:a05:690c:4:b0:8af:de3f:dbef with SMTP id
 00721157ae682-8b2b676a64cmr92668847b3.49.1793803608398; 
 Wed, 04 Nov 2026 06:46:48 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.bos.csb ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8b3098c313esm19905117b3.15.2026.11.04.06.46.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 06:46:47 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 09:46:41 -0500
Message-ID: <20261104144643.377172-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.55.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qxe78y0piBLxl4oVzYjrW6pgEqm2No4O8fEU230Eai4_1793803609
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] accept03/tst_fd: Harden parallel runs against
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
paths with O_EXCL, distinct names for the file and O_PATH cases, and
give accept03 a private tmpdir.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 lib/tst_fd.c                                | 29 +++++++++++++++------
 testcases/kernel/syscalls/accept/accept03.c |  1 +
 2 files changed, 22 insertions(+), 8 deletions(-)

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
diff --git a/testcases/kernel/syscalls/accept/accept03.c b/testcases/kernel/syscalls/accept/accept03.c
index bc472397d..dea4988cf 100644
--- a/testcases/kernel/syscalls/accept/accept03.c
+++ b/testcases/kernel/syscalls/accept/accept03.c
@@ -55,4 +55,5 @@ static void verify_accept(void)
 
 static struct tst_test test = {
 	.test_all = verify_accept,
+	.needs_tmpdir = 1,
 };
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
