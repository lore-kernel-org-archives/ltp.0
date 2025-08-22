Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5781CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755848924; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=TJVTnGrAY8aLBJORexdt4ILseHiZKFDjPlWeloNsZgk=;
 b=MR3hjsPX9jwCCYjoeyqmOgdyOvZIjl7hTCSQ4gCN9qf/Uubeq3oFTNMKTlRe6LpQY6Fk2
 H2fwsjk26GTAS7zrnJo90HH68dz4NwlMjy9jTebyD62egccH6RiNXwGKWyHcFy9dFfJLU5A
 d7rW8fIn+b383jwksVZifj9BsKAr/nk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3350F3CCD8B
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 09:48:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E69133CCCE7
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:48:22 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 53BD81000434
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:48:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755848900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p2Nn4rHWP1hYuiMwlvGncX2vTd78IXkx6QMhXGyODJk=;
 b=OW86Bm2QFvISpvmCNfDO07UeyUh8vatN77AeYzb0666FJ/zsa76Xnwr4JTnZJkxOS2L/My
 lwshz3PkXc7MzQEYN7kH0bFv0lmV0rocXtxKlLtIXZ225E1JRWocYw0Sl9o72gny0I8dEP
 MMp+AEA4YsygjL0PXZQUTvdAl/ZzWbA=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-cosB9JMgMOeb_5Itycsu_w-1; Fri,
 22 Aug 2025 03:48:18 -0400
X-MC-Unique: cosB9JMgMOeb_5Itycsu_w-1
X-Mimecast-MFC-AGG-ID: cosB9JMgMOeb_5Itycsu_w_1755848898
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B762418004A7
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:48:17 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 97BCC3001453
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 07:48:16 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri, 22 Aug 2025 15:48:11 +0800
Message-ID: <20250822074811.2192404-1-liwang@redhat.com>
In-Reply-To: <CAEemH2fM4vHRdgHh62krquK5CFuHvpKdJtj--S6Vvt_i0xRBFw@mail.gmail.com>
References: <CAEemH2fM4vHRdgHh62krquK5CFuHvpKdJtj--S6Vvt_i0xRBFw@mail.gmail.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: llkj1QW75oWHZ4VL2aGDctprjUPua33ZF_YpFKK-q8Y_1755848898
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] mount: check path exists before tst_is_mounted
 in cleanup
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

tst_is_mounted() now internally resolves the mount path via realpath(),
which will fail if the path does not exist. In sometest (e.g. mount05),
MNTPOINT2 may not exist yet during cleanup, calling tst_is_mounted()
directly could produce misleading warnings or errors.

Add an explicit access(PATH, F_OK) check before calling tst_is_mounted()
in the cleanup, ensuring we only query mounts for existing paths.

Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    v1 --> v2:
            patch 1/2, keep no change, do not send v2.
            patch 2/2, adding two more files for path exist check

 testcases/kernel/containers/mqns/mqns_03.c | 2 +-
 testcases/kernel/containers/mqns/mqns_04.c | 2 +-
 testcases/kernel/syscalls/mount/mount05.c  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/containers/mqns/mqns_03.c b/testcases/kernel/containers/mqns/mqns_03.c
index 4d3bfc52f..ac8311559 100644
--- a/testcases/kernel/containers/mqns/mqns_03.c
+++ b/testcases/kernel/containers/mqns/mqns_03.c
@@ -130,7 +130,7 @@ static void cleanup(void)
 	if (!access(MQUEUE2, F_OK))
 		SAFE_MQ_UNLINK(MQNAME2);
 
-	if (tst_is_mounted(DEVDIR))
+	if (!access(DEVDIR, F_OK) && tst_is_mounted(DEVDIR))
 		SAFE_UMOUNT(DEVDIR);
 }
 
diff --git a/testcases/kernel/containers/mqns/mqns_04.c b/testcases/kernel/containers/mqns/mqns_04.c
index d28c330c4..790607ecd 100644
--- a/testcases/kernel/containers/mqns/mqns_04.c
+++ b/testcases/kernel/containers/mqns/mqns_04.c
@@ -123,7 +123,7 @@ static void cleanup(void)
 	if (!access(MQUEUE2, F_OK))
 		SAFE_MQ_UNLINK(MQNAME2);
 
-	if (tst_is_mounted(DEVDIR))
+	if (!access(DEVDIR, F_OK) && tst_is_mounted(DEVDIR))
 		SAFE_UMOUNT(DEVDIR);
 }
 
diff --git a/testcases/kernel/syscalls/mount/mount05.c b/testcases/kernel/syscalls/mount/mount05.c
index 66e102a32..5585e230e 100644
--- a/testcases/kernel/syscalls/mount/mount05.c
+++ b/testcases/kernel/syscalls/mount/mount05.c
@@ -35,7 +35,7 @@ static void cleanup(void)
 	if (tst_is_mounted(MNTPOINT1))
 		SAFE_UMOUNT(MNTPOINT1);
 
-	if (tst_is_mounted(MNTPOINT2))
+	if (!access(MNTPOINT2, F_OK) && tst_is_mounted(MNTPOINT2))
 		SAFE_UMOUNT(MNTPOINT2);
 }
 
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
