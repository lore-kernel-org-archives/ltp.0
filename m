Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A736BC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 13:59:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3EC553C7BCB
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 14:59:03 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D10EE3C2204
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:58:23 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=afazekas@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 37B3814320D4
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 14:58:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737122301;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FAQLNoybCycPM3RRtgersnqyxUZa8mcd7GD9ZQCS4us=;
 b=IToanDcoMp+KPRSEwnoaJIa5TczvjtA4rmX555zvSUQGjR0kRg9rdvcQ6u87jTlJSUhWSg
 lluKLVaDr5BIfN4QbcH4MbIfNYT6g3zwtjX0OYg4fp2/nh/P/v1u7huPMg7p0riVTGlLJJ
 EhjkbRUe/QdMn6Eo3hp4KnGIsPwxHYA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-kZuBtvjYNdijWmYwavBH8g-1; Fri,
 17 Jan 2025 08:58:20 -0500
X-MC-Unique: kZuBtvjYNdijWmYwavBH8g-1
X-Mimecast-MFC-AGG-ID: kZuBtvjYNdijWmYwavBH8g
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C44B1955DE0
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 13:58:19 +0000 (UTC)
Received: from interceptor.brq.redhat.com (unknown [10.43.2.84])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 9F40C19560A3; Fri, 17 Jan 2025 13:58:18 +0000 (UTC)
From: Attila Fazekas <afazekas@redhat.com>
To: ltp@lists.linux.it
Date: Fri, 17 Jan 2025 14:57:44 +0100
Message-ID: <20250117135745.909549-2-afazekas@redhat.com>
In-Reply-To: <20250117135745.909549-1-afazekas@redhat.com>
References: <20250117135745.909549-1-afazekas@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 80wRPNLNqiCfm0dF4tpm0jCe_d-1KRaBCZIg_VyCgcE_1737122299
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: move get_numcpus to librttest.[ch]
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
Cc: Attila Fazekas <afazekas@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

get_numcpus() can be used by other tests therefore it is
better to move it to a shared place.

Signed-off-by: Attila Fazekas <afazekas@redhat.com>
---
 testcases/realtime/func/prio-preempt/prio-preempt.c | 13 -------------
 testcases/realtime/include/librttest.h              |  4 ++++
 testcases/realtime/lib/librttest.c                  | 13 +++++++++++++
 3 files changed, 17 insertions(+), 13 deletions(-)

diff --git a/testcases/realtime/func/prio-preempt/prio-preempt.c b/testcases/realtime/func/prio-preempt/prio-preempt.c
index 272833763..5dd717d1f 100644
--- a/testcases/realtime/func/prio-preempt/prio-preempt.c
+++ b/testcases/realtime/func/prio-preempt/prio-preempt.c
@@ -288,19 +288,6 @@ void *master_thread(void *arg)
 	return NULL;
 }
 
-int get_numcpus(void)
-{
-	long numcpus_conf = sysconf(_SC_NPROCESSORS_CONF);
-	size_t size = CPU_ALLOC_SIZE(numcpus_conf);
-	cpu_set_t *cpuset = CPU_ALLOC(numcpus_conf);
-
-	CPU_ZERO_S(size, cpuset);
-	/* Get the number of cpus accessible to the current process */
-	sched_getaffinity(0, size, cpuset);
-
-	return CPU_COUNT_S(size, cpuset);
-}
-
 int main(int argc, char *argv[])
 {
 	int pri_boost, numcpus;
diff --git a/testcases/realtime/include/librttest.h b/testcases/realtime/include/librttest.h
index 0a1bb0540..39538c47c 100644
--- a/testcases/realtime/include/librttest.h
+++ b/testcases/realtime/include/librttest.h
@@ -355,4 +355,8 @@ int trace_marker_write(char *buf, int len);
  */
 int atrace_marker_write(char *tag, char *msg);
 
+/* get_numcpus: get the number of cpus accessible to the current process
+ */
+int get_numcpus(void);
+
 #endif /* LIBRTTEST_H */
diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
index 764398179..03566f36d 100644
--- a/testcases/realtime/lib/librttest.c
+++ b/testcases/realtime/lib/librttest.c
@@ -763,3 +763,16 @@ int atrace_marker_write(char *tag, char *msg)
 	return trace_marker_write(trace_buf,
 				  strnlen(trace_buf, TRACE_BUF_LEN));
 }
+
+int get_numcpus(void)
+{
+	long numcpus_conf = sysconf(_SC_NPROCESSORS_CONF);
+	size_t size = CPU_ALLOC_SIZE(numcpus_conf);
+	cpu_set_t *cpuset = CPU_ALLOC(numcpus_conf);
+
+	CPU_ZERO_S(size, cpuset);
+	/* Get the number of cpus accessible to the current process */
+	sched_getaffinity(0, size, cpuset);
+
+	return CPU_COUNT_S(size, cpuset);
+}
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
