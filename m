Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 918D4CD8C9F
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 09:14:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A25303E4E83
	for <ltp@archiver.kernel.org>; Mon,  8 Jun 2026 11:14:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 851743C9A7C
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:12:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56F39200B02
 for <ltp@lists.linux.it>; Sat,  6 Jun 2026 08:12:13 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-490be29c1c5so31789785e9.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 23:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780726333; x=1781331133; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
 b=BoNPWEsYdKhSTPUxu3EDgGDueXBBbbHWQyN5+Yv0a/KBIKuoV25TjgSBXYXVjKIu03
 l6G7/OLko45ng+8TZi/K6BjGMu4EcpD8p3pTzrKSOkTmWT3Y5QrT9rcb/vQW6INiLhn3
 5S0eCD56myvU2OyCHRWkcetRJ25VJFdysISc12jBh4VvNfEgMUxnWhHzf9FklgIw/Zr/
 YDie1wvZkugEaf02mnwjWlSLbhcWuiX0AMAYWDFgnJ8BZ96zrsKq3HtAgrX+qsu6C25h
 9SFJKv4d35t/IzOr/Od7gUJRHn0vqynigRPdXy7x3ozEYE2OUfn8Vb+x9KdrTvQY+Rd8
 lifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780726333; x=1781331133;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ybLyqkJC8PpxOPGtytqXN1jytQgb2AKCO5QalzHljcA=;
 b=fYAiQ9tTD0/5Fs/zkXI7kCiXsnA2kLITlncNfdBxRaXT1iZkqSPaYebK+pmLa5nN30
 Xliqxx1LYYjKMHAOHQKeE8EuHi2+UtyfsgNWULtsFxlVOgSCH/PWvxfktQxDDAKUhP78
 GbzYgHGm8iaUO9KERuIp83bBmWfH1Af3OPfEAMwBf14h5sBp22zXGTkTycCBEguQH9lM
 s7JR81XbgzyMT8OLhzrkP2Lties5Xu9EUzHZbfvcO2w9vk5Tvta9OEnux8BiSyyUqCXz
 evc+cV7PUgkIYKDLrk05gcQe3lqjGUg/h3FAtYrSP94DegAR2UrnarMSpHCryk9BixSY
 9taw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Y6M9GpT6rvyPLu7U33gARansOcQZlM22qROeFxEkcakKImaAmrCMRGbMNKIp7/l/2J9g=@lists.linux.it
X-Gm-Message-State: AOJu0Yyhs+fhVkqsnessoF2r0XR+AR/KVgZvP/0w6GLwJmE/fOq7GtCq
 2SLJ+dLRise5P4S4+9FS+bPHHM5qshJcIqQs6woajdl3WC8cE4bBhtXj
X-Gm-Gg: Acq92OEb/WpVNVXMUysGVdJDQUqkL2Yf90fl+ZzJYH9hlhmzMgHazF1pCOOhFEq8fKw
 8AOXHBAEdHsseDmbPHhBw+3/EdMyEr09+d+x6A99j2GpueWO9M00NU7w8+qncn0RbF4n3ia/8PI
 Z1F23BhXrfNrF7yMIHclrGQURkL9uUY2I3SpIVOQ4/Ckan15oIAKmyzlcNKiUAmhHFi6EOfVe3J
 oLjsy+lox7+Q0cIOiq6cH9YKqO+IL+Pb5tHnMVachksfut5S3QRGlaEolLR6zMBYGlDM577fdVf
 99m1A4uvU0Ih2lF7+/yBE5eF708UeVSO8ydrG7oDTfh7D+gfJKTrBEIifQEpGgnBCryMH3/BvnJ
 RZhAcVF7CfNi1BtWiqZWUpS8S4Ghm4VnO2GOSTw+nypgCPlvV0Buw9T5GkZnl4Y6F7VTv9KG++Q
 ZA/v3Z7TTQGwjzij2uOxYi8/rT7M3veGx5824axDZt
X-Received: by 2002:a05:600c:8b0c:b0:490:ba61:7981 with SMTP id
 5b1f17b1804b1-490c25c1e4amr103918225e9.23.1780726332629; 
 Fri, 05 Jun 2026 23:12:12 -0700 (PDT)
Received: from localhost ([212.73.77.104]) by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-490c2c9ea37sm178712255e9.0.2026.06.05.23.12.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 23:12:12 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Date: Sat,  6 Jun 2026 06:10:29 +0000
Message-ID: <20260606061031.3744880-4-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260606061031.3744880-1-safinaskar@gmail.com>
References: <20260606061031.3744880-1-safinaskar@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 08 Jun 2026 11:13:16 +0200
Subject: [LTP] [PATCH 3/5] splice: turn wait_for_space flags argument into
 bool
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

I want to do this, because I will move this function to fs/pipe.c.

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 fs/splice.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/splice.c b/fs/splice.c
index 6ddf7dd72..707db2c2c 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1239,7 +1239,7 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 }
 EXPORT_SYMBOL(splice_file_range);
 
-static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
+static int wait_for_space(struct pipe_inode_info *pipe, bool non_block)
 {
 	for (;;) {
 		if (unlikely(!pipe->readers)) {
@@ -1248,7 +1248,7 @@ static int wait_for_space(struct pipe_inode_info *pipe, unsigned flags)
 		}
 		if (!pipe_is_full(pipe))
 			return 0;
-		if (flags & SPLICE_F_NONBLOCK)
+		if (non_block)
 			return -EAGAIN;
 		if (signal_pending(current))
 			return -ERESTARTSYS;
@@ -1268,7 +1268,7 @@ ssize_t splice_file_to_pipe(struct file *in,
 	ssize_t ret;
 
 	pipe_lock(opipe);
-	ret = wait_for_space(opipe, flags);
+	ret = wait_for_space(opipe, flags & SPLICE_F_NONBLOCK);
 	if (!ret)
 		ret = do_splice_read(in, offset, opipe, len, flags);
 	pipe_unlock(opipe);
-- 
2.47.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
