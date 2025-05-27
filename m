Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C5C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 05:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748323772; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=9Vdz5K8XU8n5YPhS1EvONX05wRn9gQOp1UZPSZ0oa24=;
 b=b3ulrUxgkPdZz1FuhEDQOxtSlSflkCsfySKiYAPdudoHZN4yuPXVB6M/D0W+Cwop9soOs
 lx1WkCejIgl+yxIV7LnKIy6tvtzVRuRhoHLorSt0Bx1/aIWqL9xjlz6Z+HutSnM5WA9tjyf
 daB4rp3xHN2HNGE1JXE80B09L5+DlzA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D3883C3000
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 07:29:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C1F33C053B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:29:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 878A41400F8F
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:29:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748323747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Kr9x6S5cvb7KRt605PDQjBQ1cOMYjjwsJP1BgSbfO/M=;
 b=cjZzupnhdeHsd+5+y7eOR0hUlPwvQu53VleovvDGwO/sjeEEzOJyCSx8h+bp+l7qVXHE9s
 l0E8593O5I1rjpNTqHa6scFYvnAc0aKhtbyZbSswBem+XUwYgNVSpZOnf7gEf2Ib20rscp
 bs7zz7PC+3/tek6biJyDICqlJc7/78M=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-651-p0afl5ICPW-rD--LNusAWA-1; Tue,
 27 May 2025 01:29:03 -0400
X-MC-Unique: p0afl5ICPW-rD--LNusAWA-1
X-Mimecast-MFC-AGG-ID: p0afl5ICPW-rD--LNusAWA_1748323742
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8D18A1800373; Tue, 27 May 2025 05:29:02 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0C00719560AB; Tue, 27 May 2025 05:29:00 +0000 (UTC)
To: ltp@lists.linux.it
Date: Tue, 27 May 2025 13:28:55 +0800
Message-ID: <20250527052855.150398-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EwbRv9Sf38C_fj34W-Z6qY5IhWrBgmLnsZaZIKwj4q0_1748323742
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] test_controllers: remove outdated blockio test
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The run_io_throttle_test.sh is not exist any more, so let's drop it from
test_controllers file.

Follow-up: commit 7ca7749b54 ("test_controllers: Remove cpuacct")
Signed-off-by: Li Wang <liwang@redhat.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/controllers/test_controllers.sh | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/testcases/kernel/controllers/test_controllers.sh b/testcases/kernel/controllers/test_controllers.sh
index 7df3b468c..774feef3f 100755
--- a/testcases/kernel/controllers/test_controllers.sh
+++ b/testcases/kernel/controllers/test_controllers.sh
@@ -48,8 +48,6 @@ then
 	CPU_CONTROLLER_VALUE=`grep -w cpu /proc/cgroups | cut -f4`;
 	MEM_CONTROLLER=`grep -w memory /proc/cgroups | cut -f1`;
 	MEM_CONTROLLER_VALUE=`grep -w memory /proc/cgroups | cut -f4`;
-	IOTHROTTLE_CONTROLLER=`grep -w blockio /proc/cgroups | cut -f1`;
-	IOTHROTTLE_CONTROLLER_VALUE=`grep -w blockio /proc/cgroups | cut -f4`;
 	FREEZER=`grep -w freezer /proc/cgroups | cut -f1`;
 	FREEZER_VALUE=`grep -w freezer /proc/cgroups | cut -f4`;
 
@@ -85,15 +83,6 @@ then
 		echo "Skipping all memory controller testcases....";
 	fi
 
-	if [ "$IOTHROTTLE_CONTROLLER" = "blockio" ] && [ "$IOTHROTTLE_CONTROLLER_VALUE" = "1" ]
-	then
-		$LTPROOT/testcases/bin/run_io_throttle_test.sh;
-	else
-		echo "CONTROLLERS TESTCASES: WARNING";
-		echo "Either Kernel does not support for io controller or functionality is not enabled";
-		echo "Skipping all block device I/O throttling testcases....";
-	fi
-
 	if [ "$FREEZER" = "freezer" ] && [ "$FREEZER_VALUE" = "1" ]
 	then
 		"$LTPROOT/testcases/bin/run_freezer.sh"
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
