Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 770E3C71135
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 03:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749699781; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=X2TXst1mZ+kj0JOvapcnGxuk4JEDamtDlawGVda6poA=;
 b=Nn9AzSl9wB6LA36nqI66EuOYozJFpsWFvn1/QZLZIN1AEImbPGiV4JIqx55HLL0e+Nwd4
 CkgtZTpaiMe1ApyXbyuu86DQXypeEsckR2YGWsCNlr6b0jlJDP9F7Nx762aYrvCir0Xw/ZS
 RpxtEAR3y9FEpwgWw8epFTcaIaaG37w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1C053CB2D8
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 05:43:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6293CB24E
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 05:42:41 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id BED71140024C
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 05:42:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749699758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xv3LBCFGrQsQvqraIchVbLSfcOHEgCe0898jIl4FrO8=;
 b=IjAqliQD++2Xj8zyustX51ajnLH0ihm20+5fOYa9EaVJ4Xk3N5KekI0fBYosrmMzZQBgmb
 wxfxXy1uvCzuRCcz/hTudzDuLWEcWi1buUojhLMI0Ezs7yI0ki0r8ft3L6Q9oYOeFTEZgr
 bEAMB3B/LBFrkaGepR9Ps2c8mEwFqJo=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-480-hW02XT3XOtOJk2sWPe0m_A-1; Wed,
 11 Jun 2025 23:42:36 -0400
X-MC-Unique: hW02XT3XOtOJk2sWPe0m_A-1
X-Mimecast-MFC-AGG-ID: hW02XT3XOtOJk2sWPe0m_A_1749699756
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CAE7E1801BD8
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 03:42:35 +0000 (UTC)
Received: from dell-per7425-02.rhts.eng.pek2.redhat.com
 (dell-per7425-02.rhts.eng.pek2.redhat.com [10.73.116.18])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id ABF191956048
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 03:42:34 +0000 (UTC)
To: ltp@lists.linux.it
Date: Thu, 12 Jun 2025 11:42:29 +0800
Message-ID: <20250612034229.310523-1-liwang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1L0XUk8sxgaiAzFq9tDUIuNeA9Kys30rcHXvGLEoRus_1749699756
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] safe_mmap: Avoid using TDEBUG before IPC is
 initialized
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

After commit bf9589d5bd ("lib: move test infrastructure states into a shared context structure"),
each test began printing unexpected TDEBUG messages like:

  tst_test.c:142: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 3, 0)
  ...
  tst_test.c:199: TDEBUG: mmap((nil), 4096, PROT_READ | PROT_WRITE(3), 1, 3, 0)

This happens because the logic in tst_res_():

  if (ttype == TDEBUG && context && !context->tdebug)

allows TDEBUG messages to be printed even the context is not yet initialized.
During early test setup (such as in SAFE_MMAP), the shared context may
not be initialized yet, causing debug logs to be emitted unintentionally.

This patch removes the TDEBUG logging from SAFE_MMAP to avoid these
misleading logs during early initialization.

Follow-up: commit bf9589d5bd ("lib: move test infrastructure states into a shared context structure")
Signed-off-by: Li Wang <liwang@redhat.com>
---

Notes:
    I admit that this removal may result in the loss of early debug
    output from the LTP library. However, after reviewing the codebase,
    it appears that this was the only place using TDEBUG during early
    initialization, so removing it simplifies the behavior without
    significant loss of functionality.
    
    But, if someone argues that we need this, I guess we can add a
    macro tst_early_debug(fmt, ...) to replace the tst_res_(TDEBUG, ...).

 include/tst_safe_macros_inline.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/include/tst_safe_macros_inline.h b/include/tst_safe_macros_inline.h
index 15b756860..15500b20a 100644
--- a/include/tst_safe_macros_inline.h
+++ b/include/tst_safe_macros_inline.h
@@ -237,10 +237,6 @@ static inline void *safe_mmap(const char *file, const int lineno,
 
 	tst_prot_to_str(prot, prot_buf);
 
-	tst_res_(file, lineno, TDEBUG,
-		"mmap(%p, %zu, %s(%x), %d, %d, %lld)",
-		addr, length, prot_buf, prot, flags, fd, (long long int)offset);
-
 	rval = mmap(addr, length, prot, flags, fd, offset);
 	if (rval == MAP_FAILED) {
 		tst_brk_(file, lineno, TBROK | TERRNO,
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
