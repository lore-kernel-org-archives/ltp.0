Return-Path: <SRS0=fXc4=OT=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5610FC433EF
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:59:37 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EA80613A6
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 08:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9EA80613A6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux.it
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 417473C819F
	for <ltp@archiver.kernel.org>; Wed, 29 Sep 2021 10:59:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8770D3C17A1
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:59:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D4BF41A00155
 for <ltp@lists.linux.it>; Wed, 29 Sep 2021 10:59:13 +0200 (CEST)
Received: from relay1.suse.de (relay1.suse.de [149.44.160.133])
 by smtp-out1.suse.de (Postfix) with ESMTP id 0C67A2250C;
 Wed, 29 Sep 2021 08:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1632905953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=nYn6GU1ATgW8qnxpgXTq/1EgUkgDmKXdwAf6nIPAc6M=;
 b=URW6hQ8MM67ljQ3y9lr9RgKcFZgOQG+H0VE/4w/DVe3eS8JNQibvp0PkTZuFkQv4tlwzdr
 7D7/E4T+/tEInzxs7GacJj287nJ0LxNglK7RtbCQRTbJMGp4s2ijWWTRiyDCODW1YCUGm2
 hNpJ+oMSVWynk0ovaDLEaBpS3Mb9tBw=
Received: from g78.suse.de (unknown [10.163.24.38])
 by relay1.suse.de (Postfix) with ESMTP id D21D425D8B;
 Wed, 29 Sep 2021 08:59:12 +0000 (UTC)
To: ltp@lists.linux.it
Date: Wed, 29 Sep 2021 09:59:09 +0100
Message-Id: <20210929085910.23073-1-rpalethorpe@suse.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] clock_nanosleep01: Avoid dereferencing bad
 pointers in libc on 32bit
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In 32-bit (regardless of kernel bits) glibc and musl will usually
dereference the timespec pointers and try to read them. In some cases
this might be avoidable, but they must do it in others.

Passing invalid pointers is undefined in POSIX. In any case, AFAICT
libc would have to catch the signal in order to guarantee EFAULT is
returned.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---

Possibly we shouldn't test things like this at all through libc
wrappers.

 .../kernel/syscalls/clock_nanosleep/clock_nanosleep01.c   | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
index 382497918..7dc5a043d 100644
--- a/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
+++ b/testcases/kernel/syscalls/clock_nanosleep/clock_nanosleep01.c
@@ -154,6 +154,14 @@ static void do_test(unsigned int i)
 	else
 		remain = tst_ts_get(rm);
 
+	if ((request == bad_addr || remain == bad_addr) &&
+	    tv->clock_nanosleep == libc_clock_nanosleep &&
+	    sizeof(long) < 8) {
+		tst_res(TCONF,
+			"The libc 32-bit wrapper may dereference req or rem");
+		return;
+	}
+
 	TEST(tv->clock_nanosleep(tc->clk_id, tc->flags, request, remain));
 
 	if (tv->clock_nanosleep == libc_clock_nanosleep) {
-- 
2.33.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
