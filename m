Return-Path: <SRS0=7Ptb=QG=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B9BC433EF
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:46:28 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D08661108
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 07:46:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D08661108
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 614303C89AD
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 08:46:25 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 801293C7A4A
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:14 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 029CB60043D
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 08:46:13 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 8B4C49F6A0
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 07:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1637307968; bh=Dsy5dA8HC+767TpHni/vDwLjelNslKVZi4BlKXF7l+c=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=e3g9d8JBIyP44SRRQHjvv01gF7C98pzRHUZNRUPh34F566QRxYNkv6FynUdOX5LFE
 Lqvgb3VzbKEmo8wa4PWuKxz/++sw0dY6TkX68mW852GwZCzkOItVbnAk1p//IDcl1i
 muu+3b2QZRLAlVc7Qvb5VKLvFfezd9SdI25T7+X4=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it
Date: Fri, 19 Nov 2021 08:45:50 +0100
Message-Id: <20211119074602.857595-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [Patch 00/12] Fix or suppress compiler warnings in
 posix/conformance/interfaces
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

this set of patches removed all compiler warnings (at least fog gcc10),
for all tests in openposix/conformance/interfaces.
I fixed some real issues in separate patches and a lot of similar problems
in bulk patches.
For two categories of warnings I used pragma diagnostic:
 - nonnull: Two nonnull warnings are triggered, where the test is used
   to explicitly test passing NULL. The only way to fix this warning, is
   to supress it.
 - unused-result for write in signal handlers: There is no good way,
   to handle a failing write-call in a signal handler. Most of the time,
   the test is exited anyway, so supressing the warning seems like the best fix.

While these pragmas are gcc specific IIRC they also work for clang.

Joerg



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
