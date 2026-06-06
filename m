Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05497CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:15:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 07CA43E4E75
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:15:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5B613C9A7C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:13:01 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1F98C6007A4
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:13:01 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490a76757e5so17001745e9.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 23:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780726380; x=1781331180; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
 b=g4qiBZ6jnr1oc2OyIZlRUO1tpHqBc9HBfh8JK/6+X3pQ1dQ0SsN7e9xvTaWRvHs60u
 YV9hzG0YGhCQuWC4R+dTRTpd1l0ceOB9u4cu+ym4ueuRwDwl2Tg98zWdzgfrLnekxkIj
 F+Y6vy7lik4vVVpi54gR6RmH8+hq1hHLhg5sM9gH1z9yYibSg0mCWM3vtxNr7bLi/OiX
 yh6TgUMjNq62oyQYe1o6x+ZGouP5zbADF56JtLZVjUQpiTMcOpLcMxjc8N42YYh540Kk
 I2a6hg4ccuNHX0brJsna5PDQjhv94/85+YViIQCkVSdpzrdxkalc1cS6lDOd3n/ESzzU
 xbcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726380; x=1781331180;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y22J8nzR3UW0cMYCUVJWDcFSFo/6kHGVqnn/SzRaSz8=;
 b=hRHeaFzgWkacleMC3+oCg1xJAlujta4/gYws2poBsFRoQoe2z6n4i3C7mdYNQP/Rm7
 AySfU+R7IBIs/MJgUyadzCr2aOJJrGSRDKkG8QfrvlptaV4u+hdUkC82HC8dgHvhajDu
 kn+oBPLn1pRMLs89Y1MtIhtdnI48eXESgchAb/CF+SI05w+4wFB3stzaP+6SyQ2+BgGW
 raYcKZvMQtS2h3bOGpyfPLCGvkoO6LMPjhUnau2PfFuZb5GRllxiOCmqA5hhiRgYh6j+
 s8MDeIFWXjd77rPzXRQkfRPqbrqeEtVNcb1YULj5OM6kXmX7hnJjZ9t3f9tfoiCode8K
 ATqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9LPc8kenaXix1kln/oswmoTHCDXSgWGzYC03EdQ16P6UZ+6wHdtVISmIb9apqix3OLTHs=@lists.linux.it
X-Gm-Message-State: AOJu0YxfBSp3Q3xiBFRPcojNAHksZM+QdrN8v8Mb7NDNcQqHaqI27b57
 0m5+4O9FPEUD0aULB4GNzo795Sv+3b3JYFfp4/u2zUTQRYlkk/JmRedy
X-Gm-Gg: Acq92OEE+VMKhK7ane70irnIej1jgR7fVF8f+lujThyIEgq1/eywmtJOEq5mxCyBq41
 JrKqqVqAln4sEXxGSnXMRLI92hhq7yqdfC4kAQ67iUVP5qSneWgmCqvkABI8jlNp9eFTwOeOOeU
 3rXmpPbJn1BqZqMaCIOW8p4TnKEFFcmIfAA4lDdBdGmQv4D0eQGfhNnAxEOoIZcN+xxsyEPLHtl
 UiQbDEr6WEwfiHGce2svZKcYJe4lxUHU5ji3ya3o8JhJg0Sp/9xD7jeN+jhvlMh3hD8rmhFUBn2
 jyNuY6WSsl1wevTmzJNtCTNU70/0DrZiAm5tAn86NHmdEl2d0LE3s2zsllpoIHHr0b2g4AWlQVr
 T9HDmDHZtWbyI4ZfXN8YP5JywvlRaHSPGkFl+Ljz+JBS9dNv14v2PKlP44Of4sFAzvu/+ktCpyA
 Pxo4XXru22RT793miARiH2g3oPe4CJsw==
X-Received: by 2002:a05:600c:c0d3:b0:490:b0e0:3de2 with SMTP id
 5b1f17b1804b1-490c265c148mr78044605e9.33.1780726380490; 
 Fri, 05 Jun 2026 23:13:00 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4601f2eadefsm32281391f8f.11.2026.06.05.23.12.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 23:13:00 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Date: Sat,  6 Jun 2026 06:10:31 +0000
Message-ID: <20260606061031.3744880-6-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:13:16 +0200
Subject: [LTP] [PATCH 5/5] vmsplice: make sure we don't wait after writing
 some data
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

Make sure we don't wait for space in pipe after writing some data.
This is needed for compatibility with previous version of vmsplice.
Found by LTP vmsplice01.
See comments in the code and links below for details.

Link: https://lore.kernel.org/all/20260603-raumfahrt-unmerklich-ertrugen-c4ecae70d5f9@brauner/
Link: https://lore.kernel.org/all/CAHk-=wgV-j-G3d+899Zm1pQ=NaJrddPz=GKcL5Yw5DTUM=GaUw@mail.gmail.com/
Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c | 39 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index 77487b307..dbd0debc2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1221,6 +1221,8 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
+	struct pipe_inode_info *pipe;
+
 	if (unlikely(flags & ~SPLICE_F_ALL))
 		return -EINVAL;
 
@@ -1229,11 +1231,44 @@ SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		return -EBADF;
 
 	/* We do vfs_writev/vfs_readv, so it is okay to pass "false" here */
-	if (!get_pipe_info(fd_file(f), /* for_splice = */ false))
+	pipe = get_pipe_info(fd_file(f), /* for_splice = */ false);
+
+	if (!pipe)
 		return -EBADF;
 
 	if (fd_file(f)->f_mode & FMODE_WRITE) {
-		ssize_t ret = vfs_writev(fd_file(f), vec, vlen, NULL, (flags & SPLICE_F_NONBLOCK) ? RWF_NOWAIT : 0);
+		/*
+		 * When writing to the pipe, previous implementation of vmsplice
+		 * first waited for space in the pipe to appear
+		 * (depending on whether SPLICE_F_NONBLOCK was passed),
+		 * then did unconditional non-blocking write to the pipe.
+		 *
+		 * This differs from what pwritev2 does.
+		 *
+		 * For compatibility we do the same thing previous
+		 * implementation did.
+		 *
+		 * We lock the pipe, do pipe_wait_for_space, then unlock
+		 * the pipe, and then do vfs_writev. vfs_writev internally
+		 * locks the pipe again. This may cause TOCTOU: when we
+		 * do vfs_writev, the pipe may become full again. So we
+		 * do a loop.
+		 */
+
+		bool non_block = (flags & SPLICE_F_NONBLOCK) || (fd_file(f)->f_flags & O_NONBLOCK);
+		ssize_t ret;
+
+		do {
+			pipe_lock(pipe);
+			ret = pipe_wait_for_space(pipe, non_block);
+			pipe_unlock(pipe);
+
+			if (ret < 0)
+				break;
+
+			ret = vfs_writev(fd_file(f), vec, vlen, NULL, RWF_NOWAIT);
+		} while (!non_block && ret == -EAGAIN);
+
 		if (ret > 0)
 			add_wchar(current, ret);
 		inc_syscw(current);
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
