Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC2FC02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 12:19:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4D573C7BE4
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 13:18:59 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E6463C7BD1
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:18:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8FFDB62D1C9
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 13:18:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737029921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gLEmUF0bAMGMnRH6gsKonxd/kxXBapdCT0eaOdFTS9g=;
 b=L7bh5RpYwdgLifvZuDH7YWJ8XfUZPh67cbxc9VOHdB/qsbXNgBhSBC6K08JBrpmpfE2O9g
 PbxFwYycauZ46IX9ov0ct6M6AKFg4VeT7T17PrIRfKCq3qPd9BkqR5XTio3+OzpUJyKFum
 49yBHvHBGbvqRq3G548kO97A09xa/0M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-ClKPus9kMIyJrEPR0mX3HA-1; Thu,
 16 Jan 2025 07:18:40 -0500
X-MC-Unique: ClKPus9kMIyJrEPR0mX3HA-1
X-Mimecast-MFC-AGG-ID: ClKPus9kMIyJrEPR0mX3HA
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8542E1955E79
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 12:18:39 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.192.62])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2D90019560BF; Thu, 16 Jan 2025 12:18:37 +0000 (UTC)
From: Jan Stancek <jstancek@redhat.com>
To: ltp@lists.linux.it
Date: Thu, 16 Jan 2025 13:18:01 +0100
Message-ID: <1b9d04fe8d4f0f386398216b9a5c172bb010c97f.1737029809.git.jstancek@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xChzrQhYl978iMHGRj3m-qDND5RtnhMZ6mVYmg-cusM_1737029919
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio-stress: fix opened fd leak
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
Cc: liwan@redhat.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In cases where worker completes specified number of `iterations` before
oper completes all `total_ios`, such oper remains on active_list.
This is a problem because cleanup only walks over finished list,
and closes fds only for items on this list. So it's possible for
test to exhaust ulimit for open files and fail:

$ ./aio-stress -a1 -I100 -o2 -r4 -f1 -d1^
aio-stress.c:1347: TPASS: Test passed
aio-stress.c:1285: TINFO: starting with random write
aio-stress.c:1296: TINFO: file size 1024MB, record size 0KB, depth 1, I/O per iteration 1
aio-stress.c:1298: TINFO: max io_submit 1, buffer alignment set to 4KB
aio-stress.c:1300: TINFO: threads 1 files 1 contexts 1 context offset 2MB verification off
aio-stress.c:1314: TBROK: open(file0.bin,1052738,0600) failed: EMFILE (24)

Clean/free also items from active_list. Also don't let `status` from cleanup
be set to zero once it becomes non-zero.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/io/ltp-aiodio/aio-stress.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aio-stress.c b/testcases/kernel/io/ltp-aiodio/aio-stress.c
index 419fc2cd25a4..e84308d1d0e8 100644
--- a/testcases/kernel/io/ltp-aiodio/aio-stress.c
+++ b/testcases/kernel/io/ltp-aiodio/aio-stress.c
@@ -1122,7 +1122,12 @@ restart:
 	while (t->finished_opers) {
 		oper = t->finished_opers;
 		oper_list_del(oper, &t->finished_opers);
-		status = finish_oper(t, oper);
+		status = finish_oper(t, oper) ? : status;
+	}
+	while (t->active_opers) {
+		oper = t->active_opers;
+		oper_list_del(oper, &t->active_opers);
+		status = finish_oper(t, oper) ? : status;
 	}
 
 	if (t->num_global_pending)
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
