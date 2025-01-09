Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4298E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 04:56:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 526803C185A
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 05:56:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8F8923C1D56
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:51 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id DB48C625B61
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 05:55:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736398549;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fjvoCy9USls6EZXCiWkpIrvft6Lq+2xEiHUdF3upy9w=;
 b=KRiLMfMgrgnLdauPi3QE+Vkp1hLwgJ8KkYbQpNO1VmtofkURlnBkcift+nVrnsIdAgHW7k
 Nd2YWtIVQpVMZav9iAWdKoCdRLvqBd3i6lcqyCZcciiggKk4nXPB4QpTLAM9+VKJSEQ3VU
 j3aiVgtbQKUGYhm8XMAVMWUeKxi1ulg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-640-Lj1jmA7mNaexgXEs-6NrhA-1; Wed,
 08 Jan 2025 23:55:47 -0500
X-MC-Unique: Lj1jmA7mNaexgXEs-6NrhA-1
X-Mimecast-MFC-AGG-ID: Lj1jmA7mNaexgXEs-6NrhA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC79519560B7
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:46 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92A3619560AD
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 04:55:45 +0000 (UTC)
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Date: Thu,  9 Jan 2025 12:55:30 +0800
Message-ID: <20250109045532.43017-3-liwang@redhat.com>
In-Reply-To: <20250109045532.43017-1-liwang@redhat.com>
References: <20250109045532.43017-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZwvgfrWcj2nLT18VwIclTae0oj-DoI2LEy7C9aoKIUw_1736398546
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/4] lib: add tst_set_timeout for reset entire
 timeout
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Li Wang <liwang@redhat.com>
---
 doc/old/C-Test-API.asciidoc |  9 +++++++++
 include/tst_test.h          |  5 +++++
 lib/tst_test.c              | 13 +++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/doc/old/C-Test-API.asciidoc b/doc/old/C-Test-API.asciidoc
index d4e0276e4..fe9904439 100644
--- a/doc/old/C-Test-API.asciidoc
+++ b/doc/old/C-Test-API.asciidoc
@@ -402,6 +402,15 @@ Returns string describing the status as returned by 'wait()'.
 
 WARNING: This function is not thread safe.
 
+[source,c]
+-------------------------------------------------------------------------------
+void tst_set_timeout(int timeout);
+-------------------------------------------------------------------------------
+
+Allows for setting the entire timeout dynamically during the test setup(). The
+timeout is specified in seconds and represents the total time allowed for a single
+test iteration, including setup, runtime, and teardown phases.
+
 [source,c]
 -------------------------------------------------------------------------------
 void tst_set_runtime(int runtime);
diff --git a/include/tst_test.h b/include/tst_test.h
index 8df05b9bb..2ddfde5b4 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -675,6 +675,11 @@ void tst_reinit(void);
  */
 int tst_run_script(const char *script_name, char *const params[]);
 
+/*
+ * Sets entire timeout in seconds.
+ */
+void tst_set_timeout(int timeout);
+
 unsigned int tst_multiply_timeout(unsigned int timeout);
 
 /*
diff --git a/lib/tst_test.c b/lib/tst_test.c
index 486df6cd7..43583e2f9 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1729,6 +1729,19 @@ static void set_overall_timeout(void)
 		results->overall_time % 60);
 }
 
+void tst_set_timeout(int timeout)
+{
+	int timeout_adj = DEFAULT_TIMEOUT + timeout;
+
+	results->overall_time = tst_multiply_timeout(timeout_adj) + results->runtime;
+
+	tst_res(TINFO, "Overall timeout per run is %uh %02um %02us",
+		results->overall_time/3600, (results->overall_time%3600)/60,
+		results->overall_time % 60);
+
+	heartbeat();
+}
+
 void tst_set_runtime(int runtime)
 {
 	results->runtime = multiply_runtime(runtime);
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
