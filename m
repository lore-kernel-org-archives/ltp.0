Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DF43C433EF
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 08:15:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4505261AA5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 08:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4505261AA5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jv-coder.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4FB93C812B
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 09:15:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C8213C1C46
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 09:15:35 +0100 (CET)
Received: from mail.jv-coder.de (mail.jv-coder.de [5.9.79.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C1ABD1000F59
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 09:15:34 +0100 (CET)
Received: from ubuntu.localdomain (unknown [188.195.115.12])
 by mail.jv-coder.de (Postfix) with ESMTPSA id 158569FBCB;
 Mon, 15 Nov 2021 08:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jv-coder.de; s=dkim;
 t=1636964133; bh=uE6JqLR/yD6L12F7HG2ubQ2I6cdsmFzeodLexGS2Pds=;
 h=From:To:Subject:Date:Message-Id:MIME-Version;
 b=Mgk6JICmiauVsMyz6jG7Vz14fsMHrB4RYxmIBMKAVpVnNcXkYhSVjH66UwVZo9q4W
 q87BbURsWHOag/BEReR0Pc4+n7yNcB5FWMmmImiHe7zuemy0YRwOz53+O8t7qxwRfm
 6EOZ2WZF36PB+thXqaC9DOglAT+T2S2RhNFPKApc=
From: Joerg Vehlow <lkml@jv-coder.de>
To: ltp@lists.linux.it,
	bogdan.lezhepekov@suse.com
Date: Mon, 15 Nov 2021 09:15:23 +0100
Message-Id: <20211115081526.384856-1-lkml@jv-coder.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] (no subject)
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

Subject: [PATCH 0/3] realtime/matrix_mult: Fix test execution

Hi,

this fixes the test execution of matrix_mult.
The workload function was optimized away, because the variables
used for calculations were unreachable outside of the function.

Joerg



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
