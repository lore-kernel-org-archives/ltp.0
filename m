Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F1C6C44503
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 09:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768986155; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=BwJ85OYUfaGP/sjUtcH+tIwexpnql7jdpmBUYSPCwUs=;
 b=o/kI9Jv5y3fgoG/ABtoHHXSZ6Ir04WjHYCZ6huzHofs1u+uW3lz95pStTRHu8d1jCuMBP
 bywr2ue7Tf5DDmoyH9+3t5pM/56DMTu8S7z+hZ17FjkNJ0jqB5XisruF0V9un6U1vxPGu6X
 QIEL5RtteNd57V3HuSH6NTpaGrCNNfM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BA913CB277
	for <ltp@archiver.kernel.org>; Wed, 21 Jan 2026 10:02:35 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9435D3CB07D
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 10:02:11 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CAABE1000448
 for <ltp@lists.linux.it>; Wed, 21 Jan 2026 10:02:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768986129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lFXFcWEYhz2XtvDoBQ8r6q2oVwEuM4tsGhVlVCSVJ2w=;
 b=eq1T3I0BpIluf+5vrfd+OIkEpWh2D1DQbABDc4whY59sgzJ7pjb8SSJ+xIXdHWH7BYFM38
 QGcM4wXkod8GWDmlu8ZDtEYB5TzidXrBeeJmsR7m1SiYj/ZAa6XM+U63RiiLamQHCxpsaY
 TRNkeb0VT6uG4LXovCUESYnbS5mYFSw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-55-_V-WvbQoMdCffldUM35Xwg-1; Wed,
 21 Jan 2026 04:02:07 -0500
X-MC-Unique: _V-WvbQoMdCffldUM35Xwg-1
X-Mimecast-MFC-AGG-ID: _V-WvbQoMdCffldUM35Xwg_1768986126
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A580619560B2; Wed, 21 Jan 2026 09:02:05 +0000 (UTC)
Received: from fedora-laptop-x1.redhat.com (unknown [10.72.116.197])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 099661800665; Wed, 21 Jan 2026 09:02:03 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 21 Jan 2026 17:01:59 +0800
Message-ID: <20260121090159.32686-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Xp1Waq3a5IdqGfCdiQ-Iie1su9aFPaVzsupehqyMxbc_1768986126
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/tls: remove the TLS support from i386
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

Using a LTP naked clone() to verify that CLONE_SETTLS is unreliable
when running 32-bit on x86_64, since TLS requires two steps: writing
the descriptor and switching the selector. But CLONE_SETTLS on i386
only overrides the former:

 kernel_clone()
    copy_process()
       copy_thread()
          set_new_tls()
             do_set_thread_area()

In copy_thread(), the child's register frame is copied from the parent
*childregs = *current_pt_regs(); and on the 32-bit side it also does
savesegment(gs, p->thread.gs); saving the current %gs into thread_struct.

Together, this means that unless something explicitly overwrites it later,
the child's initial %gs selector is inherited from the parent.

  https://elixir.bootlin.com/linux/v6.18/source/arch/x86/kernel/process.c#L243

Then, in do_set_thread_area(), the kernel updates the TLS descriptor
set_tls_desc(p, idx, &info, 1); However, when (p != current), the x86_32 path
does not update or refresh any segment selector. So it updates the descriptor
but does not switch the child's %gs selector to the new modified_sel.

  https://elixir.bootlin.com/linux/v6.18/source/arch/x86/kernel/tls.c#L150

Therefore, on i386, relying on CLONE_SETTLS alone can leave the child
executing with the parent's %gs selector, so TLS accesses still resolve
to the old TLS base.

===============

The behavior above explains why clone10 fails even if we update the TLS
descriptor base (either hard-coding or via set_thread_area()).

Example (x86_64 kernel running a 32-bit ELF):

  # uname -rm
  6.19.0-rc2.liwang x86_64

  # readelf -h clone10 |grep Class
  Class:                             ELF32

  # ./clone10
  ...
  clone10.c:48: TINFO: Child (PID: 5262, TID: 5263): TLS value set to: 101
  clone10.c:72: TFAIL: Parent (PID: 5262, TID: 5262): TLS value mismatch: got 101, expected 100

Reported-by: Wei Gao <wegao@suse.com>
Signed-off-by: Li Wang <liwang@redhat.com>
---
 include/lapi/tls.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/include/lapi/tls.h b/include/lapi/tls.h
index a067872e0..f7e2f483f 100644
--- a/include/lapi/tls.h
+++ b/include/lapi/tls.h
@@ -17,10 +17,6 @@
 #include <stdio.h>
 #include <unistd.h>
 
-#if defined(__i386__)
-#include <asm/ldt.h>
-#endif
-
 #include "tst_test.h"
 
 #define TLS_SIZE 4096
@@ -37,7 +33,6 @@ typedef struct {
 #endif
 
 extern void *tls_ptr;
-extern struct user_desc *tls_desc;
 
 static inline void *allocate_tls_area(void)
 {
@@ -59,21 +54,6 @@ static inline void init_tls(void)
 {
 #if defined(__x86_64__) || defined(__aarch64__) || defined(__s390x__)
 	tls_ptr = allocate_tls_area();
-
-#elif defined(__i386__)
-	tls_ptr = allocate_tls_area();
-	tls_desc = SAFE_MALLOC(sizeof(*tls_desc));
-	memset(tls_desc, 0, sizeof(*tls_desc));
-	tls_desc->entry_number = -1;
-	tls_desc->base_addr = (unsigned long)tls_ptr;
-	tls_desc->limit = TLS_SIZE;
-	tls_desc->seg_32bit = 1;
-	tls_desc->contents = 0;
-	tls_desc->read_exec_only = 0;
-	tls_desc->limit_in_pages = 0;
-	tls_desc->seg_not_present = 0;
-	tls_desc->useable = 1;
-
 #else
 	tst_brk(TCONF, "Unsupported architecture for TLS");
 #endif
@@ -87,12 +67,6 @@ static inline void free_tls(void)
 		free(tls_ptr);
 		tls_ptr = NULL;
 	}
-#elif defined(__i386__)
-	if (tls_desc) {
-		free((void *)(uintptr_t)tls_desc->base_addr);
-		free(tls_desc);
-		tls_desc = NULL;
-	}
 #endif
 }
 
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
