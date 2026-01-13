Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BC8D38FEB
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 16:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768409064; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=JpaZ4fuTwHsijOiKqfZl0zPR4mM8Ml2zwGkvqRcAMAE=;
 b=CUOncZmBTZSot86T6KZGBjiv1deZYYOmiuAAyjdSp7ugW2mw6yTLRYOvd68UFxQELADw8
 zi+mMDbt5z9xvBuJuqwzheny3PydLirDyRly9u0uAfD29fgltRUx6KhcirHPm6CPs3bjM0t
 EY2hBShl+/aMlxG++oIg/N5aaYNXPcE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 122203C9F5E
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 17:44:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 662423C29FC
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 04:23:02 +0100 (CET)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 51BEE1A00269
 for <ltp@lists.linux.it>; Tue, 13 Jan 2026 04:23:00 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id AFBB66000A;
 Tue, 13 Jan 2026 03:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6324CC116D0;
 Tue, 13 Jan 2026 03:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1768274578;
 bh=qBpGhliMx0mgkoSIcLVrnkmna3UupRTRq4CYtRgHij4=;
 h=From:Date:Subject:To:Cc:Reply-To:From;
 b=uZmzN8am7TsNtjl1J8Tbisho/1vcJZo0S6VCCtTl6DjCIPsn2NZOYTQBUxc2JHgWg
 t990mLwwkR8k5nzcBM+oUW7sFOBiRvQiAYtu1k6qZ6yFTylSm1vH3gkYjjD2Oct6Nj
 WlVr4+e1oo6P2ORGSxAFUkQr49oMOIa70Ij4eHt0JD2dagek0Ue+XKD4BsG33ozVkQ
 LeE96XU+ezVv+9k9w52uaDx56Ca3SwiQY1evybkPFfx5Xzo9ubhxY0K1Y15JXSdjoW
 qGEN61Nwx15Tz30zmDOT8S5oHiEB/awMLRwOaxI269xqNG7z9ofidele9DK0+IYoLX
 YLNUCNTHwZ1qw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 4D96ED29DC7;
 Tue, 13 Jan 2026 03:22:58 +0000 (UTC)
Date: Tue, 13 Jan 2026 11:22:52 +0800
MIME-Version: 1.0
Message-Id: <20260113-checkpatch-v2-1-5dfe8b9f4d90@uniontech.com>
X-B4-Tracking: v=1; b=H4sIAIu6ZWkC/3WOPQ+CMBiE/4rpbE0/sKVODrI66GgYSvvWNkYgg
 ERD+O8WRpHx7vLc3YBaaAK06LAZUAN9aENVRsG2G2S8Lu+Ag40aMcL2RFGFjQfzqHVnPCZMCpl
 KKFwBKAJ1Ay6857IbumTX7HxCefR9aLuq+cwbPZ3Tf3U9xRTbNFVKcsWZ08dXGd90YPzOVM9pY
 cIoIUus0I6AoEmhxCrG+AJzTnKwMZJWrGCUkuVJqUHZRGguf7F8HMcvDt71blUBAAA=
X-Change-ID: 20250919-checkpatch-0276787ebfbe
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, 
 Dwaipayan Ray <dwaipayanray1@gmail.com>, 
 Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1768274577; l=1809;
 i=cryolitia@uniontech.com; s=20250730; h=from:subject:message-id;
 bh=VE6TM5bOD2xrus3PUyCCcDFeowc5jbcfaHJXtjNJP6E=;
 b=H/KmEQriZzSu52B7ZrKMnqG2miNglsyHC9jPS9DFPtDDyHeRknjMSTjUw8oeg5JAuFoPIVG8m
 kMABb8g9rLOCjvhDqFxcPKtvNRnyqmmB3yJsoNFtH9tMhlOJovsCtNo
X-Developer-Key: i=cryolitia@uniontech.com; a=ed25519;
 pk=tZ+U+kQkT45GRGewbMSB4VPmvpD+KkHC/Wv3rMOn/PU=
X-Endpoint-Received: by B4 Relay for cryolitia@uniontech.com/20250730 with
 auth_id=474
X-Original-From: Cryolitia PukNgae <cryolitia@uniontech.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 14 Jan 2026 17:43:59 +0100
Subject: [LTP] [PATCH RESEND v2] checkpatch: Suppress warnings when
 Reported-by: is followed by Link:
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
From: Cryolitia PukNgae via B4 Relay via ltp <ltp@lists.linux.it>
Reply-To: cryolitia@uniontech.com
Cc: Cryolitia PukNgae via B4 Relay
 <devnull+cryolitia.uniontech.com@kernel.org>, linux-doc@vger.kernel.org,
 Cryolitia PukNgae <cryolitia@uniontech.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, workflows@vger.kernel.org, niecheng1@uniontech.com,
 ltp@lists.linux.it, zhanjun@uniontech.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Cryolitia PukNgae <cryolitia@uniontech.com>

> The tag should be followed by a Closes: tag pointing to the report,
> unless the report is not available on the web. The Link: tag can be
> used instead of Closes: if the patch fixes a part of the issue(s)
> being reported.

Accroding to Documentation/process/submitting-patches.rst , Link: is
also acceptable to followed a Reported-by:

Signed-off-by: Cryolitia PukNgae <cryolitia@uniontech.com>
---
Link to previous: https://lore.kernel.org/r/20251023-checkpatch-v1-1-ff73ed1027d6@uniontech.com
---
 scripts/checkpatch.pl | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index c0250244cf7a..dac9d98133c6 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3209,10 +3209,10 @@ sub process {
 			if ($sign_off =~ /^reported(?:|-and-tested)-by:$/i) {
 				if (!defined $lines[$linenr]) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . "\n");
-				} elsif ($rawlines[$linenr] !~ /^closes:\s*/i) {
+					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . "\n");
+				} elsif ($rawlines[$linenr] !~ /^(closes|link):\s*/i) {
 					WARN("BAD_REPORTED_BY_LINK",
-					     "Reported-by: should be immediately followed by Closes: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
+					     "Reported-by: should be immediately followed by Closes: or Link: with a URL to the report\n" . $herecurr . $rawlines[$linenr] . "\n");
 				}
 			}
 		}

---
base-commit: 9448598b22c50c8a5bb77a9103e2d49f134c9578
change-id: 20250919-checkpatch-0276787ebfbe

Best regards,
-- 
Cryolitia PukNgae <cryolitia@uniontech.com>



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
