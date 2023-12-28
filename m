Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 507EAC3DA6E
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 07:21:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BC513C943B
	for <ltp@archiver.kernel.org>; Thu, 28 Dec 2023 08:21:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B293B3C943B
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 08:21:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BEF541000B11
 for <ltp@lists.linux.it>; Thu, 28 Dec 2023 08:21:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703748079;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oUvz8RtoLHTScLZ6zhhebe1ETWiiyKKsAUUSZTLorfs=;
 b=KIRFaSwhvGV+p4UXS0kp8nWRXb2hk52rZ3n4EGeTuPA6MS4RwYY7+E15WH7PSrcmWZGx46
 O5P3F0yttRuYxebnK9Ly4aE9B+EHGhCbVKtsRegjGLTHr4Q2Tpeav2h+K5KKF3LbfYQmEQ
 aWLdhd0sQwgOn29yj2A7bA5aiSKANg4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-wb_6qR_aMhK1LIGesYWWmw-1; Thu, 28 Dec 2023 02:21:15 -0500
X-MC-Unique: wb_6qR_aMhK1LIGesYWWmw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 576ED101A52A;
 Thu, 28 Dec 2023 07:21:15 +0000 (UTC)
Received: from loobloo.redhat.com (unknown [10.72.112.173])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 473933C25;
 Thu, 28 Dec 2023 07:21:12 +0000 (UTC)
From: Shizhao Chen <shichen@redhat.com>
To: ltp@lists.linux.it,
	liwang@redhat.com,
	pvorel@suse.cz
Date: Thu, 28 Dec 2023 15:21:09 +0800
Message-ID: <20231228072109.349636-1-shichen@redhat.com>
In-Reply-To: <20231227065118.209595-1-shichen@redhat.com>
References: <20231227065118.209595-1-shichen@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/1] tools: Fix syntax error caused by "; ;
 " in create_dmesg_entry awk script
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
Cc: shichen@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When running runltp with both -S and -K provided, tests that are supposed to be
"skipped" and report TCONF results were failing due to an unexpected semicolon
at the end of the constructed command.

`-S` replace the test command with `exit 32;`
`-K` appends another semicolon to the command then we get `exit 32;;`

For example:

  >>> 780:madvise06__with_dmesg_entry BROK <<<

       1        <<<test_start>>>
       2        tag=madvise06__with_dmesg_entry stime=1703556061
       3        cmdline="dmesg -c 1>/dev/null 2>&1; exit 32;; dmesg > /mnt/testarea/ltp/output/DMESG_DIR_RHELKT1LITE.FILTERED-dmesg-output-53127-08:48:23PM/madvise06.dmesg.log"
       4        contacts=""
       5        analysis=exit
       6        <<<test_output>>>
       7        sh: -c: line 1: syntax error near unexpected token `;;'
       8        sh: -c: line 1: `dmesg -c 1>/dev/null 2>&1; exit 32;; dmesg > /mnt/testarea/ltp/output/DMESG_DIR_RHELKT1LITE.FILTERED-dmesg-output-53127-08:48:23PM/madvise06.dmesg.log'
       9        <<<execution_status>>>
      10        initiation_status="ok"
      11        duration=0 termination_type=exited termination_id=2 corefile=no
      12        cutime=0 cstime=1
      13        <<<test_end>>>

Signed-off-by: Shizhao Chen <shichen@redhat.com>
---
 tools/create_dmesg_entries_for_each_test.awk | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/create_dmesg_entries_for_each_test.awk b/tools/create_dmesg_entries_for_each_test.awk
index 25d750a55..ffd807fb4 100644
--- a/tools/create_dmesg_entries_for_each_test.awk
+++ b/tools/create_dmesg_entries_for_each_test.awk
@@ -27,6 +27,7 @@ NF && ! /^#/ {
 	for (i = 2; i <= NF; i++) {
 		s = s " " $i
 	}
+	sub(/[;]+$/, "", s)
 	s = s "; dmesg > " DMESG_DIR "/" $1 ".dmesg.log"
 	print s
 }
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
