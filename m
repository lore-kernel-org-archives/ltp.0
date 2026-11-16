Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F941606A331
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 14:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=YJklURo0;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=cCH+OiHf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794838971; h=date :
 in-reply-to : mime-version : references : message-id : to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kKj737pI0kMkJPpt4OVeWaMYUwbcI99HOIhF2y23+Tk=;
 b=YJklURo0SNWoLnDPdly/fyCXtWLfRO+EEceAMY1Toq1+Z+R9heFFk/tfNOsi8QZPcw5GK
 biIo3Nb+7HrEliTYs06LL8uBYx/xsmsvKfM9SUg6k4CwaSX7ioZ3XPPX6O0qcwfm++FnFkn
 9tdpQw7q+mWhsWNiZW+w/4/SFODtmzk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCD623EA9DB
	for <ltp@archiver.kernel.org>; Mon, 16 Nov 2026 15:22:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B3583EA9DD
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:14 +0100 (CET)
Received: from mail-pl1-x646.google.com (mail-pl1-x646.google.com
 [IPv6:2607:f8b0:4864:20::646])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD48C10002BE
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 15:22:13 +0100 (CET)
Received: by mail-pl1-x646.google.com with SMTP id
 d9443c01a7336-2ed00709df0so32521605ad.0
 for <ltp@lists.linux.it>; Mon, 16 Nov 2026 06:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794838932; x=1795443732; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Liidu/M2TpGHnX9uEsle361nTjXkyObUTOFDICMqKOU=;
 b=cCH+OiHfBw36NNV1/9bY+P5+fjnyaTH61BXV6DZFGkVuurcVssG9+Yyn3gijhzjHvg
 yU+C2t3GAZEkY5RFCn/NIax108wruAb+08ueWQXwakEmFkBvO+MfuA01tUJQtA7ZiUAZ
 OckBJy7r2KcqhHK4BqvT8PSVKHhqTb7KAEdkLMhIPmUYo6y4R+y9YNQbtp/6ooaPJ2fp
 vBcnWEJ7w4STtsKOY8MPhQkmllH09OGCMH/hQ8B3Opbd0QVBOfc6ziIky50BRro+33M8
 N364iw7qk8WX8FFEM1Yt7EdBX/hIlYvgvCElh+/fo4jVEPAeqZX0mvTrPo/WtKzNgm6c
 k/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794838932; x=1795443732;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Liidu/M2TpGHnX9uEsle361nTjXkyObUTOFDICMqKOU=;
 b=ufl9sPZwPga8vyEXjf/TfRJ1SBPecQE0V1rNSrDFbUF/ero01KgzKODphNiu0Le4qp
 72o3FfnrLsVqkoJ8AyIgT40Q2uF9oV9rFsBhbHpOJHsB91xFiW0WelZOF38UdHqZOMBe
 jX2qED7adbMsjmyKFV6a3qCMMBTi6ILHmhdYJA5zhSjZMxeqkSbpKuX7Ug0ce1Hs8Riz
 Fo0HZnnzE84FT2ReP+Ta4/LaaZIbA0wn3Ei/Kj1PR7SDyC790ok+cY8zOiOnYYdZOaB2
 BvprGBnj9sXK/7ltJ7NTENcIzAYRRNmAm/PQOUFe/V0RN+kvDLq1RXi0jddUQyQ7wfK6
 yQsw==
X-Gm-Message-State: APuU4Z9Q/KkAUtkN+tJbwfkTBfduvdAfps2xvHgOazdHIPYSNz1cUvaZ
 MQBzz3zd4h4kAFw+9yqzciXxzaIB/DORpAhh/npR2YN/102dCr7slXn/cCKgj3aDrpFvoE/KZwv
 DiNCOS6nXta8T8MUKCnT4q49s4/sZbI9dibV9bjpt26AQKMs1BWP08Tij/HPQBqGoK1SVzTMZl6
 EKD42xAv6nbmdHe3uxZUQ9EvKjrA==
X-Received: from plble3.prod.google.com ([2002:a17:902:fb03:b0:2ee:2d8e:3c1d])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e94c:b0:2ed:2776:4e5
 with SMTP id d9443c01a7336-2ee0dcd18e8mr107403125ad.58.1794838931702; Mon, 16
 Nov 2026 06:22:11 -0800 (PST)
Date: Mon, 16 Nov 2026 14:22:03 +0000
In-Reply-To: <20261116142206.3151308-1-wakel@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261111093151.374731-1-wakel@google.com>
 <20261116142206.3151308-1-wakel@google.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261116142206.3151308-2-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/4] epoll_wait06,
 fcntl35: Don't assume a pipe buffer is getpagesize()
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

A pipe consists of pipe buffers of one kernel page each, but both tests
assume that a pipe buffer is getpagesize() bytes.

epoll_wait06 sets the pipe capacity to getpagesize() and expects the
pipe to consist of a single buffer, so that reading half of the data
does not release a buffer and raise EPOLLOUT. fcntl35 sets
pipe-max-size to getpagesize() and expects it to cap the capacity of a
pipe created by an unprivileged user at that size, and it expects the
default capacity of a pipe created by a privileged user, which is 16
pipe buffers (PIPE_DEF_BUFFERS), to be 16 * getpagesize().

None of this holds when the page size reported to userspace differs
from the one the kernel uses internally. With the 16K page size
emulation that Android uses on x86_64, the pipe of epoll_wait06
consists of four 4K buffers, reading half of the data releases two of
them, and the test fails with:

  TFAIL: SAFE_EPOLL_WAIT(epfd, &evt_receive, 1, 0) (1) != 0 (0)

fcntl35 gets a default capacity of 65536 bytes instead of the expected
262144. Conversely, with 16K kernel pages and a 4K page size reported
to userspace, pipe-max-size is rounded up to a single 16K pipe buffer,
so fcntl35 gets a capacity of 16384 bytes instead of the expected 4096
for the unprivileged user.

Get the size of a pipe buffer from the kernel instead, by shrinking a
pipe to its minimum capacity with F_SETPIPE_SZ, and use it for both
cases of fcntl35. Nothing changes on kernels where both page sizes are
equal.

Suggested-by: Kalesh Singh <kaleshsingh@google.com>
Signed-off-by: Wake Liu <wakel@google.com>
---

Notes:
    Changes in v2:
    - fcntl35: Use the pipe buffer size for the unprivileged case too, as
      pipe-max-size can't be lower than a single pipe buffer (Kalesh)

 .../kernel/syscalls/epoll_wait/epoll_wait06.c | 15 ++++++++-----
 testcases/kernel/syscalls/fcntl/fcntl35.c     | 21 ++++++++++++++++++-
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
index 622830d55..ce4e2d5bc 100644
--- a/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
+++ b/testcases/kernel/syscalls/epoll_wait/epoll_wait06.c
@@ -32,13 +32,18 @@ static int epfd;
 
 static void setup(void)
 {
-	write_size = getpagesize();
-	read_size = write_size / 2;
-
 	SAFE_PIPE2(fds, O_NONBLOCK);
 
-	/* EPOLLOUT will be raised when buffer became empty after becoming full */
-	SAFE_FCNTL(fds[1], F_SETPIPE_SZ, write_size);
+	/*
+	 * EPOLLOUT will be raised when buffer became empty after becoming full.
+	 *
+	 * Shrink the pipe to its minimum capacity, which is a single pipe
+	 * buffer, so that reading only half of the data doesn't release any
+	 * buffer. Use the capacity reported by the kernel rather than
+	 * assuming it matches getpagesize().
+	 */
+	write_size = SAFE_FCNTL(fds[1], F_SETPIPE_SZ, 1);
+	read_size = write_size / 2;
 }
 
 static void cleanup(void)
diff --git a/testcases/kernel/syscalls/fcntl/fcntl35.c b/testcases/kernel/syscalls/fcntl/fcntl35.c
index d17812fd0..bec661509 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl35.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl35.c
@@ -44,9 +44,28 @@ static struct tcase {
 	{&test_max_priv, 0, "a privileged user"}
 };
 
+/*
+ * The pipe capacity is a multiple of the size of a pipe buffer, which is one
+ * page of the kernel. Get it by shrinking a pipe to its minimum capacity,
+ * rather than assuming it matches getpagesize().
+ */
+static int get_pipe_buf_size(void)
+{
+	int fds[2], size;
+
+	SAFE_PIPE(fds);
+	size = SAFE_FCNTL(fds[1], F_SETPIPE_SZ, 1);
+	SAFE_CLOSE(fds[0]);
+	SAFE_CLOSE(fds[1]);
+
+	return size;
+}
+
 static void setup(void)
 {
-	test_max_unpriv = getpagesize();
+	/* pipe-max-size can't be lower than a single pipe buffer */
+	test_max_unpriv = get_pipe_buf_size();
+	/* The default capacity is 16 pipe buffers (PIPE_DEF_BUFFERS) */
 	test_max_priv = test_max_unpriv * 16;
 
 	if (!access(PATH_FS_PIPE_MAX_SIZE, F_OK)) {
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
