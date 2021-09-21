Return-Path: <SRS0=nxZL=OL=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CF5AC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 13:04:56 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A40F261159
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 13:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A40F261159
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0958C3CA2CB
	for <ltp@archiver.kernel.org>; Tue, 21 Sep 2021 15:04:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94A1B3C2435
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 15:04:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A87A11A01466
 for <ltp@lists.linux.it>; Tue, 21 Sep 2021 15:04:41 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id D69021FED6;
 Tue, 21 Sep 2021 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1632229480; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hl/MOmvXomLoOTDJpYFB1eX0OKjWBWw5KeY0f7BZBk8=;
 b=DDAn3qOj3hI0wsKV+6nC7kwpEoKuHTKIVo5QpbT/czkSEyqcAejn81xt4A/suCV0oxFEmo
 Cn0pouydQemRsd5QaLfWJwxS7TpPEqOzRGwkOr1NxIRaR9LnAwtCDmsgS/XIUHI0U0t4Mu
 X++nb53QCf8CzcKprEebYeluK4pye/4=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay2.suse.de (Postfix) with ESMTP id BE194A3B85;
 Tue, 21 Sep 2021 13:04:39 +0000 (UTC)
To: linux-fsdevel@vger.kernel.org
Date: Tue, 21 Sep 2021 14:01:27 +0100
Message-Id: <20210921130127.24131-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] aio: Wire up compat_sys_io_pgetevents_time64 for x86
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
From: Richard Palethorpe via ltp <ltp@lists.linux.it>
Reply-To: Richard Palethorpe <rpalethorpe@suse.com>
Cc: linux-aio@kvack.org, Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-api@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Deepa Dinamani <deepa.kernel@gmail.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The LTP test io_pgetevents02 fails in 32bit compat mode because an
nr_max of -1 appears to be treated as a large positive integer. This
causes pgetevents_time64 to return an event. The test expects the call
to fail and errno to be set to EINVAL.

Using the compat syscall fixes the issue.

Fixes: 7a35397f8c06 ("io_pgetevents: use __kernel_timespec")
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 960a021d543e..0985d8333368 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -420,7 +420,7 @@
 412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents		compat_sys_io_pgetevents_time64
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
 418	i386	mq_timedsend_time64	sys_mq_timedsend
 419	i386	mq_timedreceive_time64	sys_mq_timedreceive
-- 
2.31.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
