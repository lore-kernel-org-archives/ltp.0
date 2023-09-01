Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F11DDCA0FE1
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:59:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61FDA3CBD83
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:59:08 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D3FD3CB66E
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:58:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C1CD91A010D4
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:58:53 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 20F1F1F853;
 Fri,  1 Sep 2023 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693573133; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uolqaM6CQ2GCQa1Q9R/pN7b80AdBnAioFK7iCBkHDts=;
 b=xJPH6xDMr8tBmyUrga5gWpXbxwWBwJUbeULqUOmnKYCxCnsjkqRrp2eya/SaFLhanOGN/k
 CPJXGPrRC2Ny8vqyJh38YXGFlgk0clW0nw2oWevcIGyFMEYSTjUOO0wJKTVI9FkhUZIx38
 YvBv4vCwTjhXFgVdE5FjLKzd6JMwpiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693573133;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=uolqaM6CQ2GCQa1Q9R/pN7b80AdBnAioFK7iCBkHDts=;
 b=FXf50CfZ0AedvKoGY/xFm539hPiHYx5g8UDDBWdVYmhAKOzEYGrpKvVHesVbLhJaB+Sa2t
 6YawRm0sWW3xEZCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F0AFB1358B;
 Fri,  1 Sep 2023 12:58:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id P748OQzg8WRKMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 01 Sep 2023 12:58:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  1 Sep 2023 14:58:44 +0200
Message-Id: <20230901125844.351042-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ver_linux: Add /proc/meminfo
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

We have free, which shows basic memory info.

But printing /proc/meminfo can be useful to get detailed info or
get any info on embedded systems which might not have procps installed.

+ move free output, to have all memory info after CPU info.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 ver_linux | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/ver_linux b/ver_linux
index 2df1c7b69..7dd0fe176 100755
--- a/ver_linux
+++ b/ver_linux
@@ -130,13 +130,17 @@ if [ -e /proc/modules ]; then
     echo "Modules Loaded         "$X
 fi
 
+echo
+echo 'cpuinfo:'
+tst_cmd_run lscpu || cat /proc/cpuinfo
+
 echo
 echo 'free reports:'
 free
 
 echo
-echo 'cpuinfo:'
-tst_cmd_run lscpu || cat /proc/cpuinfo
+echo 'memory (/proc/meminfo):'
+cat /proc/meminfo
 
 echo
 echo 'available filesystems:'
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
