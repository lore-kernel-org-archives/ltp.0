Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2A0AC433F5
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 20:53:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80FF63C9573
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 21:53:25 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 470993C928A
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:53:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AECCF200B98
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 21:53:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DEF21F389;
 Fri, 14 Jan 2022 20:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642193595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLlfgSRAV6SF6Z1l98rYjnvibTboDV3xPtrDW3umWKo=;
 b=mQlQYgUUCm7LY4DDT7k9YNV7lp2A988xbkcgjDpCkEM+ler/dLDP9+9C8ChDF7AiGN9MG6
 GsinDEQDm2QiKIK2h7D3Qgp8CB9g74Dx7hfya5FN1cKkKaLWaU+zblwh3SxZO21+6HakfV
 gMaF1dB8Q5a44Y1eXUFuLLmp6V9aO2A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642193595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BLlfgSRAV6SF6Z1l98rYjnvibTboDV3xPtrDW3umWKo=;
 b=M1r9L2E2CgkUhLGQ8VrY8ICK0N1IPLvrsCDD+48qj1ahsamPb9UdqhPbEWavZIc2qE2iQQ
 5SNTG1ewsykGuJBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 152A613BB4;
 Fri, 14 Jan 2022 20:53:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SLRLA7vi4WHtWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 20:53:15 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 21:53:08 +0100
Message-Id: <20220114205309.14409-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114205309.14409-1-pvorel@suse.cz>
References: <20220114205309.14409-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/3] testinfo.pl: Support tag values on more lines
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

if value is too long, i.e. adding URL:

.tags = (const struct tst_tag[]) {
	{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
		"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
	},
	{}

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 docparse/testinfo.pl | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docparse/testinfo.pl b/docparse/testinfo.pl
index 8712a530f8..67e435d794 100755
--- a/docparse/testinfo.pl
+++ b/docparse/testinfo.pl
@@ -453,6 +453,12 @@ sub content_all_tests
 				$v = html_a($url, $v);
 			}
 
+			# tag value value can be split into more lines if too long
+			# i.e. URL in known-fail
+			for (@$tag[2 .. $#$tag]) {
+				$v .= " $_";
+			}
+
 			$content .= "\n|" . reference($k) . "\n|$v\n";
 			$tmp2 = 1;
 		}
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
