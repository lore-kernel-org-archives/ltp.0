Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8539CC3DA7D
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 13:44:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DA8263CB64E
	for <ltp@archiver.kernel.org>; Thu,  5 Jan 2023 14:44:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC0673C2B9C
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 14:44:19 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C37731A00982
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 14:44:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D743E16EE4
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 13:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1672926256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MdV2Z5ulojIcf44Ab/eRLf76OdfX7RFXf66R81kWQhk=;
 b=RLTjiaNSncCZgEq7Ddp7JWIEJTR5Fu7sW/Q3DC4SCDtkKg/Kq1DPuptFczgk8szlCGedIp
 ca4tW0OiQnaeez46wsQp13nCVnlEBlRgrZBm+zdhnmaLFw5+szq853B1Qb9Tv2Iq63SpsI
 R5BwzdzQX7h8AKkFjvD/Rx+FzTmRB5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1672926256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MdV2Z5ulojIcf44Ab/eRLf76OdfX7RFXf66R81kWQhk=;
 b=ElJEKAtcFIZyvrwANQFpPhCK5m8OX1KfYfE7j6e+6usA/jV+fRs+HoE0fbDk+VIPnW4nGQ
 PSP+NYI+0Vgx5IDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BFBAA13338
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 13:44:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ykcDLjDUtmMndAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 05 Jan 2023 13:44:16 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  5 Jan 2023 14:44:16 +0100
Message-Id: <20230105134416.15853-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ltp-aiodio.part4: Run DIT000 with only 1 reader
 process
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

New changes in real-time kernel patchset give high priority to direct I/O
readers and may cause writes to block indefinitely if there are too many
reader processes running in parallel. Reduce the number of reader processes
in DIT000 to 1 which was the dio_truncate default before rewrite to new API.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/ltp-aiodio.part4 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
index d88c27a83..c31bef934 100644
--- a/runtest/ltp-aiodio.part4
+++ b/runtest/ltp-aiodio.part4
@@ -56,7 +56,7 @@ ADI007 dio_append
 ADI008 dio_append
 ADI009 dio_append
 #Running dio_truncate
-DIT000 dio_truncate
+DIT000 dio_truncate -n 1
 DIT001 dio_truncate
 DIT002 dio_truncate
 #Running dio_read
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
