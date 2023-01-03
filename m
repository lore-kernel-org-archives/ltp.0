Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6D60C3DA7D
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 17:51:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6507A3CDEAC
	for <ltp@archiver.kernel.org>; Tue,  3 Jan 2023 18:51:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5F183CCEA3
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C312A1A00437
 for <ltp@lists.linux.it>; Tue,  3 Jan 2023 18:51:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9F5C020AE3;
 Tue,  3 Jan 2023 17:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672768264; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WIW2/MrmS4h+5xNu6mwmGvmYNiWnHuu3bDFez0VO4t8=;
 b=fRFm1MITrSjR7w8SRce6u80kXJS7lFi9GoGhXcw/kXyz0p36j+UILl/FZMg5CgPLX9J/mW
 6r4Mn6HTQdVncrJXQgG3D1rvdKyeO+TvXrG/e0XsR0Av4CDBOh11rQmklylOStL0/Svile
 E6iMv6iFKT1reYOJOQfxfWDFjMTGq9Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672768264;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=WIW2/MrmS4h+5xNu6mwmGvmYNiWnHuu3bDFez0VO4t8=;
 b=PJ5jQwZyjC338yi4L96wuenTObdueBbHZrqgwwAu2H53NEf/Ev6NE36HdZ/8PLCcoV3CdM
 9W6dTdJkATvkIzBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D69471390C;
 Tue,  3 Jan 2023 17:51:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5ZqeMgdrtGOHNgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 03 Jan 2023 17:51:03 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jan 2023 18:50:56 +0100
Message-Id: <20230103175059.16328-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] doc: tst_kvercmp2 related fixes
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

Petr Vorel (3):
  doc/c-test-api.txt: Update tst_kvercmp{2,}() use
  doc/shell-test-api.txt: Improve tst_kvcmp doc
  doc/API: Link to minimal supported kernel version

 doc/c-test-api.txt     | 20 ++++++++++++++++++--
 doc/shell-test-api.txt | 13 +++++++++++++
 2 files changed, 31 insertions(+), 2 deletions(-)

-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
