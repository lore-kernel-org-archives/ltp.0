Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98E6EC3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 12:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746794085; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=+9f8N66LHw0CFVbR5+zlLWxmMDk7AEkgeJ2NXF+ulDs=;
 b=FezrU2rm//9SLrHqz/AL+noiENi5fzK5Y3hGFxEXDE4bwrcKCHwZ6VpgwOv0r+oYV2D6z
 Osn2twI2DrQ0fMflBH1t3+uP+iJIspzyID6OFBr9VGsSDvlNQJqtoPG+r8YJ1M7/xaH60JE
 IgytU+VnC/Qr9eZv/FIRBVWiYv4q4Qg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 04DAB3CC1FB
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 14:34:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C7573CC181
 for <ltp@lists.linux.it>; Fri,  9 May 2025 14:34:23 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 446451000443
 for <ltp@lists.linux.it>; Fri,  9 May 2025 14:34:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746794060;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YngY7RP0/zMrrPxCmHSDOLRxecCLPWbVfsWqydBhlfo=;
 b=CdL/6bCUchgy4FTqaayM4WbRyQZGCYxnYpHX2VymQL2Xn0DAedZYORd+DaWQL9zTyBXRCf
 UpxBuYBB0Ybs5Rj+y8Ikx3iL+q8ysl6MzH/wfjVHE7mX6W1z/TG3+jGLzygDfYjZbu6mBD
 rXoDPR6Dbya8ovTpMKZYSzDeG/a30Ww=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-64-ivdzP3MKPAS6f4dUD7ao6g-1; Fri,
 09 May 2025 08:34:19 -0400
X-MC-Unique: ivdzP3MKPAS6f4dUD7ao6g-1
X-Mimecast-MFC-AGG-ID: ivdzP3MKPAS6f4dUD7ao6g_1746794058
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB326195608A; Fri,  9 May 2025 12:34:17 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6979118003FD; Fri,  9 May 2025 12:34:15 +0000 (UTC)
To: ltp@lists.linux.it
Date: Fri,  9 May 2025 20:34:10 +0800
Message-ID: <20250509123410.22406-1-liwang@redhat.com>
In-Reply-To: <20250509113206.59574-1-mdoucha@suse.cz>
References: <20250509113206.59574-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xblT8SCOro-cG4q3LPxggTgSuu9jB6-Fi4SztkoamoY_1746794058
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] mmap_24-1: update code comments
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

Follow-up: mmap_24-1: Change vm.max_map_count if needed
Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Martin Doucha <mdoucha@suse.cz>
---

Notes:
    This patch is based on Martin's vm.max_map_count change, to make
    everything is clear enough from the code to comments.

 .../conformance/interfaces/mmap/24-1.c        | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
index 49673d603..8aebdba61 100644
--- a/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
+++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
@@ -7,15 +7,23 @@
  * source tree.
  *
  * The mmap() function shall fail if:
- * [ENOMEM] MAP_FIXED was specified, and the range [addr,addr+len)
+ * [ENOMEM] MAP_FIXED was specified, and the range [addr, addr+len)
  * exceeds that allowed for the address space of a process;
- * or, if MAP_FIXED was not specified and
- * there is insufficient room in the address space to effect the mapping.
+ * or, if MAP_FIXED was not specified and there is insufficient room
+ * in the address space to effect the mapping;
+ * or, if the process exceeds the maximum number of allowed memory mappings
+ * (as defined by /proc/sys/vm/max_map_count).
  *
  * Test Steps:
- * 1. In a very long loop, keep mapping a shared memory object,
- *    until there this insufficient room in the address space;
- * 3. Should get ENOMEM.
+ * 1. In a very long loop, continuously map a shared memory object without
+ *    unmapping previous ones.
+ * 2. The loop continues until mmap() fails with ENOMEM.
+ *
+ * Note:
+ * This failure may occur due to either exhausting the process's
+ * virtual address space, or hitting the system-wide limit on
+ * the number of memory mappings (especially on systems with large RAM).
+ *
  */
 
 #include <stdio.h>
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
