Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 928FBC36000
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 13:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742563015; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=hvuE/crc4SJf5zVP0xkQsMO5TQe5fR3kW/lrdgBaGgU=;
 b=BIadjzY2AatSX7Rn0o220UCHqPm+EqnfyJmqYe9WIDAmCchXnMctq3nN15Z5taU4xKOMP
 HTvuqeu+x9OzCk8Js24m0yzXH0V8+KrmnFYlwysGxiKIetM6KDrPJBwUwfgCxlXswpZ+CG+
 gU9ixOi57SrMpTppcS+Q3hF00f8MYqU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6A973CAEF9
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 14:16:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A9B13C0614
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 14:16:33 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwang@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E13B51000498
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 14:16:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742562990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pMQ5l/6YfQy++jI6cW9TBrbibOi4/2DsRb12Tuws7a4=;
 b=DBVoREc5hVpOA1sxNY/Qc5q2AAfsO+7Cza7NEb0sFzoMiJgbOiS0pllAWXx2hzne8/V5Lm
 5sJ0aNfaTeXN6EXcOhlBm0yN6m6aAKhsxgqa9KG/gty2uIrJh+ulchOZcTIF+z9UATP+4Y
 xYXP35jNMUBihjcEqxaJnfvZbikjV+U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-260-gPAHwoToMYiGCExq7x9LDg-1; Fri,
 21 Mar 2025 09:16:29 -0400
X-MC-Unique: gPAHwoToMYiGCExq7x9LDg-1
X-Mimecast-MFC-AGG-ID: gPAHwoToMYiGCExq7x9LDg_1742562988
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 873161933B5A
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 13:16:28 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B57519560AF
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 13:16:26 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 21 Mar 2025 21:16:21 +0800
Message-ID: <20250321131621.1870655-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sFuPXXGPNVy483n3SJg5Rn__YFqrAigCJ_bVEsS6xu0_1742562988
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] shell_loader_filesystems: add tmpfs support to avoid
 fail in GitHub CI
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

GitHub CI currently fails when running shell_loader_filesystems.sh because
the Docker environment does not have support for XFS and Btrfs. This results
in a TCONF failure, causing the CI job to fail:

  * shell_loader_filesystems.sh (TCONF, exp: TPASS)
  make: *** [Makefile:210: test-shell-loader] Error 1

To resolve this, we add tmpfs to the list of tested filesystems. Since tmpfs
is always available in GitHub CI, this ensures that the test runs successfully
even when XFS and Btrfs are unavailable.

CI: https://github.com/wangli5665/ltp/actions/runs/13992429178

Signed-off-by: Li Wang <liwang@redhat.com>
---
 testcases/lib/tests/shell_loader_filesystems.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/testcases/lib/tests/shell_loader_filesystems.sh b/testcases/lib/tests/shell_loader_filesystems.sh
index fe6170800..b7e1f9ba4 100755
--- a/testcases/lib/tests/shell_loader_filesystems.sh
+++ b/testcases/lib/tests/shell_loader_filesystems.sh
@@ -9,6 +9,9 @@
 #  "mntpoint": "ltp_mntpoint",
 #  "filesystems": [
 #   {
+#    "type": "tmpfs"
+#   },
+#   {
 #    "type": "btrfs"
 #   },
 #   {
-- 
2.48.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
