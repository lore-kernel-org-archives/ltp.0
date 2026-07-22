Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3B2FC44536
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 21:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784755635; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=qFQLsuWNWrss1TY4YqMjXXI/kjz9oYWFRfZ8XjovS8k=;
 b=Qz8opAkv0N+OUI4mFph9t/WoXJ1ZXZB8GAmSfQt+Z5sUe5oI94C9avrSZlSbWVpBPtOsk
 bYKh9Gss4Y8KJOnxZiOrSEWOr2q68OMUeRVMpYVg8zvS9hXAzYG/mNCocjta1FEUDJPmvsZ
 ZoizTchJyNgr9d7SJLIzBPIhelDH01M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B51533E7633
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 23:27:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A96F33E212B
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 23:26:55 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD3232002C1
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 23:26:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784755612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=srUFCIPUgoVZVJinW+fXw1FAiQ66mF0+FAsKDJmtviw=;
 b=TpPDIU/NItuABrszvbMHgPno58WyNffX0gdlahJ4JvOT0Zt+DAN6x+lCZHQf/7dsASJBsi
 a7IXBvK2QC0JrH7Ma5Qx9AHgdXDPvSr4V8rC/aAoWbHLiRc1D0L8B4n7lwjhfqNhaY3o9I
 rIdU0Bdrke7xAXpN+XvajVp8mgoGga4=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-257-JWSPM7M5M9WJ4LAJ4ExNLw-1; Wed,
 22 Jul 2026 17:26:51 -0400
X-MC-Unique: JWSPM7M5M9WJ4LAJ4ExNLw-1
X-Mimecast-MFC-AGG-ID: JWSPM7M5M9WJ4LAJ4ExNLw_1784755610
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ED81F1800749
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 21:26:49 +0000 (UTC)
Received: from bgrech-thinkpadp1gen3.rmtustx.csb (unknown [10.2.16.159])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 56F1B195604E; Wed, 22 Jul 2026 21:26:49 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 22 Jul 2026 16:26:46 -0500
Message-ID: <20260722212646.2340340-1-bgrech@redhat.com>
In-Reply-To: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qEmYOzWR6PSxM-Wyt2wf88GLT1RuP3Fw4CermyY1rxM_1784755610
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec for
 debug kernel reliability
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
From: Brian Grech via ltp <ltp@lists.linux.it>
Reply-To: Brian Grech <bgrech@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On debug kernels with CONFIG_PROVE_LOCKING or PREEMPT_RT, each socket
operation (bind, sendto) takes ~3-4ms instead of <0.5ms on a normal
kernel. The default icmp_msgs_per_sec is 10000; at that rate the token
bucket (burst=50) refills ~37 tokens per 3.7ms inter-packet interval,
so the bucket never drains during the slow send loop and all batches
return identical error counts, causing a false TFAIL.

Lower icmp_msgs_per_sec to 10 so that at most ~0.037 tokens accumulate
per inter-packet interval. The bucket drains during the batch regardless
of kernel speed. Note that icmp_global_allow() caps the refill interval
at HZ jiffies (1 second), so after the 2s inter-batch sleep at most 10
tokens are recovered -- well below the burst of 50 set by this test --
preserving the variability needed to distinguish vulnerable from patched
kernels.

Also add PATH_IPV4_ICMP_MSGS_PER_SEC to tst_path_defs.h alongside the
existing PATH_IPV4_ICMP_MSGS_BURST macro.

Assisted-by: ClaudeCode:claude-sonnet-4-6
Signed-off-by: Brian Grech <bgrech@redhat.com>
---
 include/tst_path_defs.h           |  1 +
 testcases/cve/icmp_rate_limit01.c | 10 ++++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
index 1a60028d3..35fb24274 100644
--- a/include/tst_path_defs.h
+++ b/include/tst_path_defs.h
@@ -79,6 +79,7 @@
 #define PATH_IPV4_ICMP_RATEMASK			"/proc/sys/net/ipv4/icmp_ratemask"
 #define PATH_IPV4_ICMP_ECHO_IGNORE_ALL		"/proc/sys/net/ipv4/icmp_echo_ignore_all"
 #define PATH_IPV4_ICMP_MSGS_BURST		"/proc/sys/net/ipv4/icmp_msgs_burst"
+#define PATH_IPV4_ICMP_MSGS_PER_SEC		"/proc/sys/net/ipv4/icmp_msgs_per_sec"
 #define PATH_IPV4_TCP_PROBE_INTERVAL		"/proc/sys/net/ipv4/tcp_probe_interval"
 #define PATH_IPV4_TCP_KEEPALIVE_TIME		"/proc/sys/net/ipv4/tcp_keepalive_time"
 #define PATH_IPV4_TCP_NOTSENT_LOWAT		"/proc/sys/net/ipv4/tcp_notsent_lowat"
diff --git a/testcases/cve/icmp_rate_limit01.c b/testcases/cve/icmp_rate_limit01.c
index ee2e73544..fa10ae58f 100644
--- a/testcases/cve/icmp_rate_limit01.c
+++ b/testcases/cve/icmp_rate_limit01.c
@@ -63,12 +63,17 @@ static void setup(void)
 	childns = SAFE_OPEN("/proc/self/ns/net", O_RDONLY);
 
 	/*
-	 * Set namespace local rate limit if needed. The global limit might
-	 * be ignored otherwise.
+	 * Set namespace local rate limits if needed. The global limits might
+	 * be ignored otherwise. Lower icmp_msgs_per_sec to ensure rate limiting
+	 * engages even on slow debug kernels where the send loop takes long
+	 * enough that the token bucket refills mid-batch at the default 1000/sec.
 	 */
 	if (!access(PATH_IPV4_ICMP_MSGS_BURST, F_OK))
 		SAFE_FILE_PRINTF(PATH_IPV4_ICMP_MSGS_BURST, "50");
 
+	if (!access(PATH_IPV4_ICMP_MSGS_PER_SEC, F_OK))
+		SAFE_FILE_PRINTF(PATH_IPV4_ICMP_MSGS_PER_SEC, "10");
+
 	/* Configure child namespace */
 	CREATE_VETH_PAIR("ltp_veth1", "ltp_veth2");
 	NETDEV_ADD_ADDRESS_INET("ltp_veth2", htonl(DSTADDR), NETMASK,
@@ -263,6 +268,7 @@ static struct tst_test test = {
 	},
 	.save_restore = (const struct tst_path_val[]) {
 		{PATH_IPV4_ICMP_MSGS_BURST, "50", TST_SR_TBROK},
+		{PATH_IPV4_ICMP_MSGS_PER_SEC, "10", TST_SR_SKIP},
 		{PATH_USER_MAX_USER_NAMESPACES, "1024", TST_SR_SKIP},
 		{}
 	},
-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
