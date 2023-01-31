Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A86B3C54EAA
	for <ltp@archiver.kernel.org>; Tue, 31 Jan 2023 00:25:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F7DE3CC880
	for <ltp@archiver.kernel.org>; Tue, 31 Jan 2023 01:25:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5C243CB2FD
 for <ltp@lists.linux.it>; Tue, 31 Jan 2023 01:25:40 +0100 (CET)
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com
 [IPv6:2607:f8b0:4864:20::64a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE53A600494
 for <ltp@lists.linux.it>; Tue, 31 Jan 2023 01:25:39 +0100 (CET)
Received: by mail-pl1-x64a.google.com with SMTP id
 m12-20020a1709026bcc00b001963da9cc71so7355540plt.11
 for <ltp@lists.linux.it>; Mon, 30 Jan 2023 16:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GzRPuTxrYkVAY7T/myJJjS6miT3ZxPahFHNxlMnemuU=;
 b=eAnqU/J+qUAizqvkYP91MX/cRcU0UKNhe+Q6v1ZTccbnaBO/LhPSbBXF4kHE8Wax62
 5YEWpoFjMswuhvPP9TNOuE3DQ/M+7psyefH9d2GTLfOaAMFz3ipgIRviTFZrdNv2trvm
 NC2rls9YbEdxN3Ul+fRgUNsG1wbYQWsxTVJZNjMpewqGF2KPk7rRhpn12ybpgDCzGPdE
 CSyrOeM7JGnCvbsjPir9JN62YCf9VzjNKCQiQNlRd3dr+nt14xP+Afd28zRqScCwAykr
 jxXIMcbCqbGztZsLk0E9epvvb9jEPOoJEdLrucyealvFUJExsTEVtzrzW9HjUU1FfSed
 P4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GzRPuTxrYkVAY7T/myJJjS6miT3ZxPahFHNxlMnemuU=;
 b=zH+B0d/sYtYweEyEzH/XvziTGvnIrAdnJAugN6Twh5Ydq8LQS+3lfxHvrGebUEvYgx
 bJzkbYXFTIYfY/dBn8K5604THb1sUpPHszsxL9rIsLDgyT8aMuSuxk2OlmA3tDF/psdD
 5URZD6ZQr+edapLLsTaWlLKBW8SOxX6v66sQtt7WHucog1OCCl2r3Z8ZR0hbN5AdhThR
 JV9hwfCkJ8lCjfmROJdjnJiUGV5QdOioLuvYlXqjG3ZTMP+7y7lRcW2W+hkgazbE3DLQ
 C4szT1yH+8S/FHgJ024QRrLNSuKEGApi3nE3+cfTTvjbeR1cMRbeHixafU2KtQyC2fbw
 Ejdg==
X-Gm-Message-State: AFqh2kqExUrQAsvphSo6HiKLGan7HNni54a0cq/wv3uwfty5aBFtWqHI
 u7q/WQCXRZ3r7CWwDh8h5qyGdvloNMd+UmBPIQbNYfgn11dIWY+JAYpGOde7lb8zUeUl4byYk4Q
 PR7WN1hb/cbLgOSYiQFK9En98vqx+nkzKufDo/xcruwMtI0ZkLMJRH6go
X-Google-Smtp-Source: AMrXdXsmSuVfwu0GMnq65qapADHq6//0CPqsWrgqvNFEf1atC/fBSqOu3MvFmNYlIQzoJvUilgUe6MlI5+M=
X-Received: from edliaw.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:305d])
 (user=edliaw job=sendgmr) by 2002:a63:f113:0:b0:490:afa3:2334 with SMTP id
 f19-20020a63f113000000b00490afa32334mr5226160pgi.35.1675124737625; Mon, 30
 Jan 2023 16:25:37 -0800 (PST)
Date: Tue, 31 Jan 2023 00:25:32 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.1.456.gfc5497dd1b-goog
Message-ID: <20230131002532.459456-1-edliaw@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] close_range: check for kernel support below 5.9
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
From: Edward Liaw via ltp <ltp@lists.linux.it>
Reply-To: Edward Liaw <edliaw@google.com>
Cc: kernel-team@android.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Check for close_range syscall support in the kernel before running
close_range01 and close_range02 tests.

Signed-off-by: Edward Liaw <edliaw@google.com>
---
 include/lapi/close_range.h                          | 13 +++++++++++++
 .../kernel/syscalls/close_range/close_range01.c     |  2 ++
 .../kernel/syscalls/close_range/close_range02.c     |  1 +
 3 files changed, 16 insertions(+)

diff --git a/include/lapi/close_range.h b/include/lapi/close_range.h
index 19db52d3d..0e464bb30 100644
--- a/include/lapi/close_range.h
+++ b/include/lapi/close_range.h
@@ -25,4 +25,17 @@ static inline int close_range(unsigned int fd, unsigned int max_fd,
 	return tst_syscall(__NR_close_range, fd, max_fd, flags);
 }
 # endif
+
+static inline void close_range_supported_by_kernel(void)
+{
+	long ret;
+
+	if ((tst_kvercmp(5, 9, 0)) < 0) {
+		/* Check if the syscall is backported on an older kernel */
+		ret = syscall(__NR_close_range, 1, 0, 0);
+		if (ret == -1 && errno == ENOSYS)
+			tst_brk(TCONF, "Test not supported on kernel version < v5.9");
+	}
+}
+
 #endif	/* LAPI_CLOSE_RANGE_H__ */
diff --git a/testcases/kernel/syscalls/close_range/close_range01.c b/testcases/kernel/syscalls/close_range/close_range01.c
index 30bb600b6..072bbab66 100644
--- a/testcases/kernel/syscalls/close_range/close_range01.c
+++ b/testcases/kernel/syscalls/close_range/close_range01.c
@@ -53,6 +53,8 @@ static inline void do_close_range(unsigned int fd, unsigned int max_fd,
 
 static void setup(void)
 {
+	close_range_supported_by_kernel();
+
 	struct rlimit nfd;
 
 	SAFE_GETRLIMIT(RLIMIT_NOFILE, &nfd);
diff --git a/testcases/kernel/syscalls/close_range/close_range02.c b/testcases/kernel/syscalls/close_range/close_range02.c
index aec899261..2aa6d2c9f 100644
--- a/testcases/kernel/syscalls/close_range/close_range02.c
+++ b/testcases/kernel/syscalls/close_range/close_range02.c
@@ -111,4 +111,5 @@ static struct tst_test test = {
 	.tcnt = 6,
 	.forks_child = 1,
 	.test = run,
+	.setup = close_range_supported_by_kernel,
 };
-- 
2.39.1.456.gfc5497dd1b-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
