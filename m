Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 727D2C00140
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 12:32:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4443A3CA48E
	for <ltp@archiver.kernel.org>; Wed, 24 Aug 2022 14:32:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D11923CA2E5
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 14:32:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2BAC91000A33
 for <ltp@lists.linux.it>; Wed, 24 Aug 2022 14:32:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88D94205AB;
 Wed, 24 Aug 2022 12:32:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661344364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zcqG125OZEqZWtW7DsZMmeJ083w3h0qTY2rGmxCiU2o=;
 b=fBsklSyFWPJjvEXddyXiUjOkL92h0m1lzVkly8Ca3OYAPPVZo2iUrYKGJCwEBvZtHHBcVM
 FmW5emPnKZrVM7ku879q/ePUHgchx4Ohw06Egb/KPomaM+PIOMASOCRdB0sps+b6ntRH2G
 c4BhV0xc8yftUdOrwb0x+bgPwzmp+h4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661344364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zcqG125OZEqZWtW7DsZMmeJ083w3h0qTY2rGmxCiU2o=;
 b=yWmYDWrOFtF/w/0dNTYwSPlfkZrULxOeSWRjkaxtrul6eIyXB0N67PLDC3sh0HVY5rRq0z
 9NmKADxMJVcKm3Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3789113AC0;
 Wed, 24 Aug 2022 12:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sWQPC2waBmOGUwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 24 Aug 2022 12:32:44 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 24 Aug 2022 14:32:40 +0200
Message-Id: <20220824123240.20092-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC PATCH 1/1] github: Add issue template
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 Xiao Yang <yangx.jy@cn.fujitsu.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

this effort is driven by reports like [1]
You can see the result on my special fork [2].

I considered to mention ML, but in the end I didn't.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/created_by/anilbp
[2] https://github.com/pevik/_ltp_test_issue/issues/new

 .github/issue_template.md | 5 +++++
 1 file changed, 5 insertions(+)
 create mode 100644 .github/issue_template.md

diff --git a/.github/issue_template.md b/.github/issue_template.md
new file mode 100644
index 000000000..caf8907da
--- /dev/null
+++ b/.github/issue_template.md
@@ -0,0 +1,5 @@
+Issues are *not* support forum.
+
+Bugs in the tests should be reported to your Linux distribution.
+
+Issues are *only* for reporting bugs in tests.
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
