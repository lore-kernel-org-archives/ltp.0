Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8BF8CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:14:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A5D23E2FBC
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:14:05 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F4DB3C9A7C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:11:26 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0695E20091E
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:11:26 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-490b2b037d2so22779045e9.3
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 23:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780726285; x=1781331085; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
 b=f1Odn/eQieGlTUG/UxoAk7gkFDJRqQT/4sAfFJZTnSbVWvQ+prMfBwHB5cPCZR55nW
 KE6Elb3hv9b8863UzWNaHBw1thkogT0qOLURJ9QLCb/Nl5wKlom2WXceuiSP86mpEQfH
 3PlcSJ0cukbLnm201nyILfIPEJeAEFAygPoYD+KfMoSAHCY19I79o2g8+opWuWMIPrHK
 t4Ii2H5urEGkq8D12BNW9+rIkrgjQtLE8sEFAN+vJvZ6XipqGsVKlSRJKUK8+4AjJLMU
 HxP+qun/qizY8yIrhmOJ92B7z21gaUXm9opBTfD9bg53QGZ9u1seWhLn5Aa6u1yJKC+K
 DYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726285; x=1781331085;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T2cQgCHbxQom2kVIv1Cvt6Y9CPEs8rn7euaXGTL0+j8=;
 b=eZ50VWzjOEghBi+XfTYT5pwd1KldROLOrA7Q1Voxdmht4ryDQzZy4oQomuceZcRgDh
 MvZ8gB4+WMXHTuMu1VaOxuPjYXcKHtsxstz5anvWN+tUWiu/zwerPTAixOmQbrJBT5AS
 EW3nGo2vNELu+LV8aq0mH2ABCLI9lBkWqpgzgdZEEsxUdWQL5rDSDTXGmpA/XRhEibBk
 eiysMcteBSmgI6RX7iXKJ00ha9C2n2BZ4aCyXBNcyTXJxQ+izZ1pgQJuM12MZO+8Vv4n
 vJMblvm/9A1wftaSSZJz4qArJY95QJ5RsFZT8y2MNI0IRKd9/oXg0kwWEad7zLvdR4Tp
 qp1w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/izZ51pYebMMpdqCjJi3LjT8MOCUSRGeV7YUjBBDBk9HZ/wZlSFCRjX0H26ruvzfvaCYo=@lists.linux.it
X-Gm-Message-State: AOJu0YxhpCwBGPRR/ucWSodc6h7NfIoVJb0tURl/qF2gvXIFKrReCibo
 rino4BU/SNDzvx3zF50KOzGgwD8RWmaMs+n5USeU2dV431lYbgIW15hLXG1ngg==
X-Gm-Gg: Acq92OEcimAtFJI5EvaNcGji/bVjs6ufnqnW0vq38ms0ked0V7a7Eg4STwD5aIQZizq
 XFXLRLYSVJ1cicjy45LtpmAKWklg5+PmSS0opSxBLvb5pnLGPZxXkAEEf3fmgqcHes4IdKngxE4
 E1/KI470pBpyLt+7Xi7pam8WRkv6GaFwpukBC7qM95fRIaz4cjdqK2boiAO1tPCsBqxUSZsef1T
 xh+ZreOMJMx97FY14ChJsB6EE5DdHqtN55naGcMP9Bky+G26VgRFphQuUenXPiYy9pctNpvSSGB
 WqIlCnxZaiq/HNHXQhWwuw4ergozJ4xQU0DkKHsmRJbZ7h1/Ds6K4MyKX0tc1enQUMFjHVOTC1o
 LwTwca290+GhJ3xlYa1kd176W7F+gbgNDkLTYfiAZtDCxzwXWzJ6bT4Buim8P1ptrYOoeMrbXKV
 LOO8RL9rvRRVFuEV7Aenvx2V+NCFWY4IEoq91AYAok
X-Received: by 2002:a05:600c:a117:b0:490:c2a3:3302 with SMTP id
 5b1f17b1804b1-490c2a3336dmr71973635e9.35.1780726285175; 
 Fri, 05 Jun 2026 23:11:25 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490bc39e024sm273433555e9.4.2026.06.05.23.11.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 23:11:24 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Date: Sat,  6 Jun 2026 06:10:27 +0000
Message-ID: <20260606061031.3744880-2-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:13:16 +0200
Subject: [LTP] [PATCH 1/5] vmsplice: open-code do_writev and do_readv
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

My previous vmsplice patch did the following mistake: I did
"CLASS(fd, f)(fd)", then did some checks on resulting "struct file",
then passed numeric (!) file descriptor to a function.

This is somewhat okay in this particular case, but I still think
this is code smell, so I fix this by open-coding do_writev and do_readv.

Also I insert a comment to warn other developers to keep
do_writev and do_readv in sync with vmsplice(2).

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 1e5444f4d..e224e7cb8 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1070,6 +1070,7 @@ static ssize_t vfs_writev(struct file *file, const struct iovec __user *vec,
 static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 			unsigned long vlen, rwf_t flags)
 {
+	/* All future changes to this function should be kept in sync with vmsplice(2). */
 	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
@@ -1093,6 +1094,7 @@ static ssize_t do_readv(unsigned long fd, const struct iovec __user *vec,
 static ssize_t do_writev(unsigned long fd, const struct iovec __user *vec,
 			 unsigned long vlen, rwf_t flags)
 {
+	/* All future changes to this function should be kept in sync with vmsplice(2). */
 	CLASS(fd_pos, f)(fd);
 	ssize_t ret = -EBADF;
 
@@ -1226,14 +1228,24 @@ SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
 	if (fd_empty(f))
 		return -EBADF;
 
-	/* We do do_writev/do_readv, so it is okay to pass "false" here */
+	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
 	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
 		return -EBADF;
 
-	if (fd_file(f)->f_mode & FMODE_WRITE)
-		return do_writev(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
-	else
-		return do_readv(fd, vec, vlen, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+	if (fd_file(f)->f_mode & FMODE_WRITE) {
+		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		if (ret > 0)
+			add_wchar(current, ret);
+		inc_syscw(current);
+		return ret;
+	} else {
+		ssize_t ret = vfs_readv(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+
+		if (ret > 0)
+			add_rchar(current, ret);
+		inc_syscr(current);
+		return ret;
+	}
 }
 
 /*
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
