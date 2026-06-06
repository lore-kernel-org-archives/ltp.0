Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4016CD8C92
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:14:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25F7E3E3056
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:14:20 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E88DA3C9A7C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:11:49 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 948CC20097C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:11:49 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-45ef41adbc1so1941244f8f.0
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 23:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780726309; x=1781331109; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0+ggg4zFesK0IrYb2saIE8cPaSi4XEf6KWehvtWp5AY=;
 b=X7l9cR6q97mfl5oV4LubmWZvSZNJCcsoPt2xonpc3K3SyFgky2jqgz/trJHaAD7z8T
 IFzIRySlpgW8DwxUPEBaa3kMu7ZDrnVIzzfe3z34PvGHaZhY67yR1+dfgtD4n/awX22z
 /Dk3dSnmT2kzYQ+2xYtrdidfd+xgRL8mN5J2h4tIG6dKz1eNZK565NB7waSMVS0ip0WV
 NNIC0IJ3GuObVF9IBXcxeBmRCsFwPd0hDWb7LnqAAqBJFye2eHW0sb6MnqOcotwMyk5a
 /A9PDQci+YMJAWletJKhM8reONvwUv+oQr5ri8h4WacTmV0TUXv4kVTTqShCikqvrOAS
 UayQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726309; x=1781331109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0+ggg4zFesK0IrYb2saIE8cPaSi4XEf6KWehvtWp5AY=;
 b=J528WS7CS8PqxEO7X72IydRRxix4hh/HrjzDO/BFZcxxZlDLX5nhMhemetkyCJMWg8
 M2Wd7Ue51EILv81CVek9j0r4BMeb4/ReEBFLMOalI9kDfG9VV5Cxfb2WXfMYWTWIZKOh
 znk2b2xHoSBERnuygwxgyuygtfMEriP3XzQmoxluwsaT0Ah1s8+YcAN/vIttXZA0iofl
 04FXT9lz1PkHJgGSrUTqBqpiBpyrGcgoMnaaVGhoAcHGth6eo3v6PBU9WK2tYxCw412d
 okI57g2XfB8IlOevDhZI8qsARqrIBUdmxVIxv0WRKI6vi/GTKFFrfPT94Dz1Z9x39QuZ
 piwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/eVk7KoYVxwcK044CmCxGWH/jMvMGjejJkDPXHcW7p6Dyfm54BL64TTYXsJ0oVdplZyE4=@lists.linux.it
X-Gm-Message-State: AOJu0YwXaE69e5Lt6Ty76mv9m/6HwQ58lyWFbXBOFreQlkje40HDOKwI
 B30QXXAP7Zlj/Ikm/Tweg4qKZxHJOx5vN43VimmBrHf79RL0EN/UMuUq
X-Gm-Gg: Acq92OGz66kvCslwU+rL6y5RwG0Zph7hr/pD0F1qJhNWY7vj4FphTBqEPOtarvGIFSu
 rVVfCtjGwtuLyE2UkxpeuaMb2DQUUcnysnn/FRGPWvk1ZXllXKall1w1CehFnFsbyYQVPxskrQj
 MfWD0Pztbd1tLXyfbFIfvesqql7LCA2nmI/Ujq18SFz4EV0CkNLBY1qD2bhUCgiiQIEFutLqPbN
 WABI8ajg3zslMg1hR/dd8FeNk6c3V6H4mS3yA/s6udejXEMsPmzR6IHBAHwhpwe+nQH2nXlh+2i
 QjADQ+DaOQjc9fT3ZlGkcvUGkuLiy22Z5Ac/FRKeB4KOwD6kQzhFOtLqFBdtQPycQDgmYkLahlC
 zCHX1nn75tTENqXLDRRDBE0Yk+pjHus4McVFSoKF6BIRqeTX+FocYvrl8hQUxQlxv2Adj80d7Sq
 FW/kyZ4xU3u0S/nx9ownw6iViJO+sZwoLciXF7nnU2
X-Received: by 2002:adf:e014:0:20b0:45e:f29d:d438 with SMTP id
 ffacd0b85a97d-46030618a38mr7876243f8f.28.1780726308885; 
 Fri, 05 Jun 2026 23:11:48 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-46028a6dce6sm24115947f8f.30.2026.06.05.23.11.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 23:11:48 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Date: Sat,  6 Jun 2026 06:10:28 +0000
Message-ID: <20260606061031.3744880-3-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:13:16 +0200
Subject: [LTP] [PATCH 2/5] vmsplice: change argument type back to "int"
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

My previous vmsplice patchset changed vmsplice argument from
"int" to "unsigned long". This may cause problems, so let's
change it back.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/read_write.c          | 2 +-
 include/linux/syscalls.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/read_write.c b/fs/read_write.c
index e224e7cb8..77487b307 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1218,7 +1218,7 @@ SYSCALL_DEFINE6(pwritev2, unsigned long, fd, const struct iovec __user *, vec,
 /*
  * Legacy preadv2/pwritev2 wrapper.
  */
-SYSCALL_DEFINE4(vmsplice, unsigned long, fd, const struct iovec __user *, vec,
+SYSCALL_DEFINE4(vmsplice, int, fd, const struct iovec __user *, vec,
 		unsigned long, vlen, unsigned int, flags)
 {
 	if (unlikely(flags & ~SPLICE_F_ALL))
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index a86a88207..46a3ec954 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -514,7 +514,7 @@ asmlinkage long sys_ppoll_time32(struct pollfd __user *, unsigned int,
 			  struct old_timespec32 __user *, const sigset_t __user *,
 			  size_t);
 asmlinkage long sys_signalfd4(int ufd, sigset_t __user *user_mask, size_t sizemask, int flags);
-asmlinkage long sys_vmsplice(unsigned long fd, const struct iovec __user *vec,
+asmlinkage long sys_vmsplice(int fd, const struct iovec __user *vec,
 			     unsigned long vlen, unsigned int flags);
 asmlinkage long sys_splice(int fd_in, loff_t __user *off_in,
 			   int fd_out, loff_t __user *off_out,
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
