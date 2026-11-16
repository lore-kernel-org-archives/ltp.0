Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 294F7606A335
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=UZwglZEh;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=VWm+nypv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794839096; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0hlIfAFQuDClLU+TRAaQW6o7nuSY2u7KRRKfMAUtOc8=;
 b=UZwglZEhljcM1WTBxlYt6Uqmp7vPz7HmCFr04Wj1+ZOl4WCKQFGXLLZQuYXugeh7feZta
 ZXrHd5bp5MK3En4YC97v+wqUu7gVwkN9Puj8rpUndcHHs0k6dXo00FGi1/GJR/g/snUe3j6
 Ko4a1YLxyqjTM+6m8vX767RCzOkQHDo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 948C33EA9DD
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:24:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 358A53EAA1A
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:50 +0100 (CET)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com
 [IPv6:2607:f8b0:4864:20::1048])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C66932001B4
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:49 +0100 (CET)
Received: by mail-pj1-x1048.google.com with SMTP id
 98e67ed59e1d1-3b3a9826f6dso21568a91.1
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838968; x=1795443768; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q4oicAE3QJ8KVZ/pfeA760Ucsb7ci1rJ7q3fjbFt+KE=;
 b=VWm+nypvXWrEpLvLc7W1kns+u4K0+dyHX6B4IqL23Hito03L9MFzCV44Mgl/2hprUd
 YcA+BuNziYcY5OP7KLj+SIfBwd4BiPgoaFWPNl9rfi7yWWAunKtfR6FWWox70d497khc
 8duvtGDA9NbFbnfNb5AJe58LPcLEIQ7ilIt9e09ONxKjp0PMTpOLjCDXpEPvNPb6xB+M
 dRhU8oVPcv0yHlNyeZwr4txq6TIrf+YiTMQUo6pcE+H3gu4avHIs7IbGk0hdgSEvd9Jf
 1fve/0K2D73/x94GRWYRXWRt4DnwDSxPsob9Yy78giaBellKYgwuLFiSf/dbb7lEjngG
 Xm9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838968; x=1795443768;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=q4oicAE3QJ8KVZ/pfeA760Ucsb7ci1rJ7q3fjbFt+KE=;
 b=slqdULcoRVyT/28rCYca00hQJjyb4CcDtwNUX0KGxpiiuOT7o4eK+uhanAfwVJM/eb
 bz+ndCTZGuJW6JavlpVT9qNvRVCrR5/KH2WqvbD6OQBw0JL9T/wH5Pfqp280mrFfgU5E
 lcODGDk6ldNqMqVtDWWAGiS2RFA/TDjT1DGB5ASz6MKjTJRhELN9nJGjE+pwLM9aL7ZL
 R5gLxPp6KRCg/WuVPM0UEnHMahWNt0ywsrdUV5UsSFn5XqxM1u0I12AAWLpzfIejxsvs
 X20wn5OuVdPpUkX6bA7TDMRaMh6EwT27LA6vzw+7MZp0bydKPbt+IciWR2IxOf2PFENB
 Setg==
X-Gm-Message-State: APuU4Z8ooA7nSyvr6t51WDPf/mSQ2rZdA6dwcW+m6E0bNCWvWsuoZVVx
 u3jFaWvNjigtlQRs6J/ITnv74zj8vjKLAK8DX+sIPg0OjKC84GeIn/hVj5yNvBrQrHcr9XdWS35
 z1gO4m/yVjwQJ0OVA/A96oUSo439S14t13H4GXZFesyCA7XGfaf9T6gO4o25OjJcX+YvFLdRXZl
 5ehfr9QrPCh8dQhWjHDpHfC4zrdg==
X-Received: from plble3.prod.google.com ([2002:a17:902:fb03:b0:2ee:2d8e:3c1d])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4f85:b0:3b0:91ce:6720
 with SMTP id 98e67ed59e1d1-3b1b0a1ef3emr9715474a91.30.1794838967773; Mon, 16
 Nov 2026 06:22:47 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:40 +0000
In-Reply-To: <20261116142240.3153725-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261116072346.2462510-1-wakel@google.com>
 <20261116142240.3153725-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142240.3153725-3-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] pipe2_04: Don't assume the minimum pipe size
 is getpagesize()
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: kaleshsingh@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

F_SETPIPE_SZ rounds the requested size up to the minimum pipe capacity,
which is a single pipe buffer of one kernel page. The test expects that
to be equal to the page size reported to userspace.

That is not the case when the page size reported to userspace differs
from the one the kernel uses internally. With the 16K page size
emulation that Android uses on x86_64 the test fails with:

  TFAIL: Pipe size (4096) must be page size (16384)

Conversely, with 16K kernel pages and a 4K page size reported to
userspace, the minimum pipe size is 16384 instead of the expected 4096.

As the minimum pipe size can't be derived from getpagesize(), only
check that F_GETPIPE_SZ on the other end of the pipe returns the size
set by F_SETPIPE_SZ, which is what the test is about. The rest of the
test already uses the actual pipe size.

Suggested-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Wake Liu <wakel@google.com>
---

Notes:
    Changes in v2:
    - Drop the check that the minimum pipe size doesn't exceed
      getpagesize(), which fails when the kernel uses larger pages than
      reported to userspace (Kalesh)

 testcases/kernel/syscalls/pipe2/pipe2_04.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/pipe2/pipe2_04.c b/testcases/kernel/syscalls/pipe2/pipe2_04.c
index 3911f95b4..91aacab79 100644
--- a/testcases/kernel/syscalls/pipe2/pipe2_04.c
+++ b/testcases/kernel/syscalls/pipe2/pipe2_04.c
@@ -57,11 +57,10 @@ static void test_pipe2(void)
 
 static void setup(void)
 {
-	int page_size, pipe_size;
+	int pipe_size, set_size;
 	char *write_buffer;
 
 	SAFE_PIPE2(fds, O_NONBLOCK);
-	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
 
 	flags = SAFE_FCNTL(fds[1], F_GETFL);
 	if (!(flags & O_NONBLOCK))
@@ -70,17 +69,21 @@ static void setup(void)
 	 * A pipe has two file descriptors.
 	 * But in the kernel these two file descriptors point to the same pipe.
 	 * So setting size from first file handle set size for the pipe.
+	 *
+	 * The size is rounded up to the minimum pipe capacity, i.e. a single
+	 * pipe buffer of one kernel page, which can be smaller or larger than
+	 * the page size reported to userspace.
 	 */
-	SAFE_FCNTL(fds[0], F_SETPIPE_SZ, 0);
+	set_size = SAFE_FCNTL(fds[0], F_SETPIPE_SZ, 0);
 
 	/*
 	 * So getting size from the second file descriptor return the size of
 	 * the pipe which was changed before with first file descriptor.
 	 */
 	pipe_size = SAFE_FCNTL(fds[1], F_GETPIPE_SZ);
-	if (pipe_size != page_size)
-		tst_res(TFAIL, "Pipe size (%d) must be page size (%d)",
-				pipe_size, page_size);
+	if (pipe_size != set_size)
+		tst_res(TFAIL, "Pipe size (%d) must be the size set (%d)",
+				pipe_size, set_size);
 
 	write_buffer = SAFE_MALLOC(pipe_size);
 	memset(write_buffer, 'x', pipe_size);
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
