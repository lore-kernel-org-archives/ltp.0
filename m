Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67AB2CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:14:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AFF983E5F8C
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:14:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7E6D3C9A7C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:12:37 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 613E72005DA
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:12:37 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-45ef189aa1cso1834108f8f.0
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 23:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780726357; x=1781331157; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
 b=nSsyORWGMzFpQTyftY9osso0CeJi3wqUPehJgQgAeE/gbFkkg+KJ/jafzjfjpFXstQ
 7lD63sGpDWZNPlx6M/Miq10nXdVgMAxvcxVP7ZTnzlXSkzOsJlE6bRbejNz7rWk4CPXy
 xaFDLzlZY6E0pP+dATnimQGvdMBFVeibvsAXZO2g2SoPVuBYM3S5eH/KiorEhepS+z5r
 WvQxvGlUHVybmTujPqzI3LpcdkZQtJSQcdYeFqggzqzQZTntz3/SVtRB3AtfFhMDM7Ko
 EYo2QAZZYSwXG1oKWBCQHS5vZIyfW5xqSuP7Jdf+XVrs8kpofihc60txw36L3T3CgMVx
 /dfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726357; x=1781331157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VhjLk1CMHsJsOzOKQ1JbfvjErAaIXQv49sV6IFA3w98=;
 b=jQkXOmRRHOddMBvWTYS1JGxBHeYGi0RFoTVhc3dCz+sF9Xn43+f7USKqJOeAV/R/q8
 rvkQzNi/yrqzssdW8cIYS6qpZcTjEZSYIcolZs6e81JFjSIVpzMqsEXBpBfAp1uNLY9i
 Eah3QrX4Updjvv4IjKM67xZv1h7shAbkScTOxBE6cHTzGNA6ytiDDrn5k9EvJuTeubt7
 DKphb4U42wpXgPqKd3ixeu2XsTY6RbjDs4SODXdbBp/1tmOk+5P2zrkwpZgxjjB7IsCt
 MN8rlrvHTom/46naiaoWqOneVvae8d7/C+LgW7X1SgrH0uUdOi6rF9QJ2KdmpzbyrTsP
 H2ag==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uIbjgv4D9dPPlYrlpDjUDRb32zkR1AHdRdAQOv2UjUsSLYPAQjwNdktKei/QDv/Xbh2I=@lists.linux.it
X-Gm-Message-State: AOJu0YxTUueQTR7ifS9CHkCzlNbS/bRS7dRlcBHnnJM6S5H2FHz4Dirr
 PeZwKJQZRZPooTGfxXwMs1d2CMVBD9B+Lu0huYPZcmNXe7zJ6U5i5nYs
X-Gm-Gg: Acq92OHItJJeLq3dWK3Hm9DZtK49NJlOzb7ggWudBJEDIi2F3E5swx24QGQfIMhUvwH
 wPJyYt0Byr37Eyq8gbVE4VXEX2xZWoh8XPnbEtIKQdKtmLbEg1Za54h/jQidDsuyY6OXyRVUV0t
 j1Hi7A1G+hTShj9nvfJaEsp1x1ddzvk88QM4wx/jUq2ITbuzYMBJn/PX5Fj4IPC4txjnpdjgnAZ
 mFblSkIkrzwyVAk3lPpaG12p8EBJ470m6iS1Wctk5miPcOw5/6jDzpebVYEjdLZahPGAKhXR898
 fgdO9FUSxLQml41HIuTxazDnQVopuzWN18c9mfn1kp2sh9L8EzKea4Ot3umqlG1u5Md0F2hOaM+
 2S3pcokmQRL5qHNpWWFeIAiPXNuimSCYJSJgS281+c52QLftvLnLXdCo2UOXCzotj2Cx3jWqRmq
 yQMoyU90c0vjcdP8qpiv0iW9lDgr1O1A==
X-Received: by 2002:adf:e545:0:b0:45e:e44b:3136 with SMTP id
 ffacd0b85a97d-4603063a715mr8180799f8f.19.1780726356710; 
 Fri, 05 Jun 2026 23:12:36 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f344541sm29667978f8f.22.2026.06.05.23.12.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 23:12:36 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Date: Sat,  6 Jun 2026 06:10:30 +0000
Message-ID: <20260606061031.3744880-5-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:13:16 +0200
Subject: [LTP] [PATCH 4/5] pipe: move wait_for_space to fs/pipe.c and rename
 it
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
Cc: The 8472 <kernel@infinite-source.de>, patches@lists.linux.dev,
 David Howells <dhowells@redhat.com>, linux-mm@kvack.org,
 Collin Funk <collin.funk1@gmail.com>, Joanne Koong <joannelkoong@gmail.com>,
 Miklos Szeredi <miklos@szeredi.hu>,
 David Laight <david.laight.linux@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, Christoph Hellwig <hch@infradead.org>,
 Steven Rostedt <rostedt@goodmis.org>, fuse-devel@lists.linux.dev,
 David Hildenbrand <david@kernel.org>, Pedro Falcato <pfalcato@suse.de>,
 ltp@lists.linux.it, Jens Axboe <axboe@kernel.dk>,
 Stefan Metzmacher <metze@samba.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andy Lutomirski <luto@amacapital.net>,
 linux-api@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This is needed, because I plan to use it in fs/read_write.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/pipe.c                 | 17 +++++++++++++++++
 fs/splice.c               | 19 +------------------
 include/linux/pipe_fs_i.h |  2 ++
 3 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 9841648c9..c0ccf21b9 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1451,6 +1451,23 @@ long pipe_fcntl(struct file *file, unsigned int cmd, unsigned int arg)
 	return ret;
 }
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block)
+{
+	for (;;) {
+		if (unlikely(!pipe->readers)) {
+			send_sig(SIGPIPE, current, 0);
+			return -EPIPE;
+		}
+		if (!pipe_is_full(pipe))
+			return 0;
+		if (non_block)
+			return -EAGAIN;
+		if (signal_pending(current))
+			return -ERESTARTSYS;
+		pipe_wait_writable(pipe);
+	}
+}
+
 static const struct super_operations pipefs_ops = {
 	.destroy_inode = free_inode_nonrcu,
 	.statfs = simple_statfs,
diff --git a/fs/splice.c b/fs/splice.c
index 707db2c2c..d12243d19 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,23 +1239,6 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
-{
-	for (;;) {
-		if (unlikely(!pipe->readers)) {
-			send_sig(SIGPIPE, current, 0);
-			return -EPIPE;
-		}
-		if (!pipe_is_full(pipe))
-			return 0;
-		if (non_block)
-			return -EAGAIN;
-		if (signal_pending(current))
-			return -ERESTARTSYS;
-		pipe_wait_writable(pipe);
-	}
-}
-
 static int splice_pipe_to_pipe(struct pipe_inode_info *ipipe,
 			       struct pipe_inode_info *opipe,
 			       size_t len, unsigned int flags);
@@ -1268,7 +1251,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
+	ret = pipe_wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
diff --git a/include/linux/pipe_fs_i.h b/include/linux/pipe_fs_i.h
index a1eeed800..be653625d 100644
--- a/include/linux/pipe_fs_i.h
+++ b/include/linux/pipe_fs_i.h
@@ -335,4 +335,6 @@ struct pipe_inode_info *get_pipe_info(struct file *file, bool for_splice);
 int create_pipe_files(struct file **, int);
 unsigned int round_pipe_size(unsigned int size);
 
+int pipe_wait_for_space(struct pipe_inode_info *pipe, bool non_block);
+
 #endif
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
