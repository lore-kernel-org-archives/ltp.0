Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FB1C4332F
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 16:09:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AF803CF388
	for <ltp@archiver.kernel.org>; Tue, 31 Oct 2023 17:09:38 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 008DA3C8883
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 17:09:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0F9CD20099E
 for <ltp@lists.linux.it>; Tue, 31 Oct 2023 17:09:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 31BB01F6E6;
 Tue, 31 Oct 2023 16:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698768565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuYmnU9ZKG2RkhUT0BL+yWcLC7QLpxfXmKg3mkbNYms=;
 b=Clc/4Zt/4QDFUwtLh1RQrRPoKRm8PZl8Evwu8jEFn8BfDsj3xmkNrIDVsLC2y50yuPUucB
 cY0UOVLc6LRidZrp8vIjAo6FYzoLmPnJ5LKKCi6I5w87z+JTqAdcFGhZF5+vQxCAk6xbFk
 SYi9LQ2tMqW3/w8y9nXLgxH8bb9UEP8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698768565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EuYmnU9ZKG2RkhUT0BL+yWcLC7QLpxfXmKg3mkbNYms=;
 b=8C+71iEPYX7SvSS/wdka/LLsYuODNT1BKwjjsXlpqCcQw1VcJlFkN5klZ7+iPU/R9Whuvp
 LJYl0PqwtDg/FkCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AFA5138EF;
 Tue, 31 Oct 2023 16:09:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IM1NAbUmQWUmSgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 31 Oct 2023 16:09:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 31 Oct 2023 17:09:18 +0100
Message-ID: <20231031160918.17845-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231031160918.17845-1-pvorel@suse.cz>
References: <20231031160918.17845-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] runtest/net.nfs: Rename test names
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

Test names weren't obvious, rename to be more descriptive.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.nfs | 188 ++++++++++++++++++++++++------------------------
 1 file changed, 94 insertions(+), 94 deletions(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 15a960017..7556ed4fc 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -2,107 +2,107 @@
 #
 # PLEASE READ THE README FILE network/README.md BEFORE RUNNING THESE.
 #
-nfs3_01 nfs01.sh -v 3 -t udp
-nfs3t_01 nfs01.sh -v 3 -t tcp
-nfs4_01 nfs01.sh -v 4 -t tcp
-nfs41_01 nfs01.sh -v 4.1 -t tcp
-nfs42_01 nfs01.sh -v 4.2 -t tcp
-nfs3_ipv6_01 nfs01.sh -6 -v 3 -t udp
-nfs3t_ipv6_01 nfs01.sh -6 -v 3 -t tcp
-nfs4_ipv6_01 nfs01.sh -6 -v 4 -t tcp
-nfs41_ipv6_01 nfs01.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_01 nfs01.sh -6 -v 4.2 -t tcp
+nfs01.sh_v3_ipv4_udp nfs01.sh -v 3 -t udp
+nfs01.sh_v3_ipv4_tcp nfs01.sh -v 3 -t tcp
+nfs01.sh_v4_ipv4_tcp nfs01.sh -v 4 -t tcp
+nfs01.sh_v4.1_ipv4_tcp nfs01.sh -v 4.1 -t tcp
+nfs01.sh_v4.2_ipv4_tcp nfs01.sh -v 4.2 -t tcp
+nfs01.sh_v3_ipv6_udp nfs01.sh -6 -v 3 -t udp
+nfs01.sh_v3_ipv6_tcp nfs01.sh -6 -v 3 -t tcp
+nfs01.sh_v4_ipv6_tcp nfs01.sh -6 -v 4 -t tcp
+nfs01.sh_v4.1_ipv6_tcp nfs01.sh -6 -v 4.1 -t tcp
+nfs01.sh_v4.2_ipv6_tcp nfs01.sh -6 -v 4.2 -t tcp
 
-nfs3_02 nfs02.sh -v 3 -t udp
-nfs3t_02 nfs02.sh -v 3 -t tcp
-nfs4_02 nfs02.sh -v 4 -t tcp
-nfs41_02 nfs02.sh -v 4.1 -t tcp
-nfs42_02 nfs02.sh -v 4.2 -t tcp
-nfs3_ipv6_02 nfs02.sh -6 -v 3 -t udp
-nfs3t_ipv6_02 nfs02.sh -6 -v 3 -t tcp
-nfs4_ipv6_02 nfs02.sh -6 -v 4 -t tcp
-nfs41_ipv6_02 nfs02.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_02 nfs02.sh -6 -v 4.2 -t tcp
+nfs02.sh_v3_ipv4_udp nfs02.sh -v 3 -t udp
+nfs02.sh_v3_ipv4_tcp nfs02.sh -v 3 -t tcp
+nfs02.sh_v4_ipv4_tcp nfs02.sh -v 4 -t tcp
+nfs02.sh_v4.1_ipv4_tcp nfs02.sh -v 4.1 -t tcp
+nfs02.sh_v4.2_ipv4_tcp nfs02.sh -v 4.2 -t tcp
+nfs02.sh_v3_ipv6_udp nfs02.sh -6 -v 3 -t udp
+nfs02.sh_v3_ipv6_tcp nfs02.sh -6 -v 3 -t tcp
+nfs02.sh_v4_ipv6_tcp nfs02.sh -6 -v 4 -t tcp
+nfs02.sh_v4.1_ipv6_tcp nfs02.sh -6 -v 4.1 -t tcp
+nfs02.sh_v4.2_ipv6_tcp nfs02.sh -6 -v 4.2 -t tcp
 
-nfs3_03 nfs03.sh -v 3 -t udp
-nfs3t_03 nfs03.sh -v 3 -t tcp
-nfs4_03 nfs03.sh -v 4 -t tcp
-nfs41_03 nfs03.sh -v 4.1 -t tcp
-nfs42_03 nfs03.sh -v 4.2 -t tcp
-nfs3_ipv6_03 nfs03.sh -6 -v 3 -t udp
-nfs3t_ipv6_03 nfs03.sh -6 -v 3 -t tcp
-nfs4_ipv6_03 nfs03.sh -6 -v 4 -t tcp
-nfs41_ipv6_03 nfs03.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_03 nfs03.sh -6 -v 4.2 -t tcp
+nfs03.sh_v3_ipv4_udp nfs03.sh -v 3 -t udp
+nfs03.sh_v3_ipv4_tcp nfs03.sh -v 3 -t tcp
+nfs03.sh_v4_ipv4_tcp nfs03.sh -v 4 -t tcp
+nfs03.sh_v4.1_ipv4_tcp nfs03.sh -v 4.1 -t tcp
+nfs03.sh_v4.2_ipv4_tcp nfs03.sh -v 4.2 -t tcp
+nfs03.sh_v3_ipv6_udp nfs03.sh -6 -v 3 -t udp
+nfs03.sh_v3_ipv6_tcp nfs03.sh -6 -v 3 -t tcp
+nfs03.sh_v4_ipv6_tcp nfs03.sh -6 -v 4 -t tcp
+nfs03.sh_v4.1_ipv6_tcp nfs03.sh -6 -v 4.1 -t tcp
+nfs03.sh_v4.2_ipv6_tcp nfs03.sh -6 -v 4.2 -t tcp
 
-nfs3_04 nfs04.sh -v 3 -t udp
-nfs3t_04 nfs04.sh -v 3 -t tcp
-nfs4_04 nfs04.sh -v 4 -t tcp
-nfs41_04 nfs04.sh -v 4.1 -t tcp
-nfs42_04 nfs04.sh -v 4.2 -t tcp
-nfs3_ipv6_04 nfs04.sh -6 -v 3 -t udp
-nfs3t_ipv6_04 nfs04.sh -6 -v 3 -t tcp
-nfs4_ipv6_04 nfs04.sh -6 -v 4 -t tcp
-nfs41_ipv6_04 nfs04.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_04 nfs04.sh -6 -v 4.2 -t tcp
+nfs04.sh_v3_ipv4_udp nfs04.sh -v 3 -t udp
+nfs04.sh_v3_ipv4_tcp nfs04.sh -v 3 -t tcp
+nfs04.sh_v4_ipv4_tcp nfs04.sh -v 4 -t tcp
+nfs04.sh_v4.1_ipv4_tcp nfs04.sh -v 4.1 -t tcp
+nfs04.sh_v4.2_ipv4_tcp nfs04.sh -v 4.2 -t tcp
+nfs04.sh_v3_ipv6_udp nfs04.sh -6 -v 3 -t udp
+nfs04.sh_v3_ipv6_tcp nfs04.sh -6 -v 3 -t tcp
+nfs04.sh_v4_ipv6_tcp nfs04.sh -6 -v 4 -t tcp
+nfs04.sh_v4.1_ipv6_tcp nfs04.sh -6 -v 4.1 -t tcp
+nfs04.sh_v4.2_ipv6_tcp nfs04.sh -6 -v 4.2 -t tcp
 
-nfs3_05 nfs05.sh -v 3 -t udp
-nfs3t_05 nfs05.sh -v 3 -t tcp
-nfs4_05 nfs05.sh -v 4 -t tcp
-nfs41_05 nfs05.sh -v 4.1 -t tcp
-nfs42_05 nfs05.sh -v 4.2 -t tcp
-nfs3_ipv6_05 nfs05.sh -6 -v 3 -t udp
-nfs3t_ipv6_05 nfs05.sh -6 -v 3 -t tcp
-nfs4_ipv6_05 nfs05.sh -6 -v 4 -t tcp
-nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
+nfs05.sh_v3_ipv4_udp nfs05.sh -v 3 -t udp
+nfs05.sh_v3_ipv4_tcp nfs05.sh -v 3 -t tcp
+nfs05.sh_v4_ipv4_tcp nfs05.sh -v 4 -t tcp
+nfs05.sh_v4.1_ipv4_tcp nfs05.sh -v 4.1 -t tcp
+nfs05.sh_v4.2_ipv4_tcp nfs05.sh -v 4.2 -t tcp
+nfs05.sh_v3_ipv6_udp nfs05.sh -6 -v 3 -t udp
+nfs05.sh_v3_ipv6_tcp nfs05.sh -6 -v 3 -t tcp
+nfs05.sh_v4_ipv6_tcp nfs05.sh -6 -v 4 -t tcp
+nfs05.sh_v4.1_ipv6_tcp nfs05.sh -6 -v 4.1 -t tcp
+nfs05.sh_v4.2_ipv6_tcp nfs05.sh -6 -v 4.2 -t tcp
 
-nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
-nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
-nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06.sh_v3_v4_ipv4_tcp_udp  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
+nfs06.sh_vall_ipv4tcp nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
+nfs06.sh_v4*_ipv6_tcp nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
-nfs3_07 nfs07.sh -v 3 -t udp
-nfs3t_07 nfs07.sh -v 3 -t tcp
-nfs4_07 nfs07.sh -v 4 -t tcp
-nfs41_07 nfs07.sh -v 4.1 -t tcp
-nfs42_07 nfs07.sh -v 4.2 -t tcp
-nfs3_ipv6_07 nfs07.sh -6 -v 3 -t udp
-nfs3t_ipv6_07 nfs07.sh -6 -v 3 -t tcp
-nfs4_ipv6_07 nfs07.sh -6 -v 4 -t tcp
-nfs41_ipv6_07 nfs07.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_07 nfs07.sh -6 -v 4.2 -t tcp
+nfs07.sh_v3_ipv4_udp nfs07.sh -v 3 -t udp
+nfs07.sh_v3_ipv4_tcp nfs07.sh -v 3 -t tcp
+nfs07.sh_v4_ipv4_tcp nfs07.sh -v 4 -t tcp
+nfs07.sh_v4.1_ipv4_tcp nfs07.sh -v 4.1 -t tcp
+nfs07.sh_v4.2_ipv4_tcp nfs07.sh -v 4.2 -t tcp
+nfs07.sh_v3_ipv6_udp nfs07.sh -6 -v 3 -t udp
+nfs07.sh_v3_ipv6_tcp nfs07.sh -6 -v 3 -t tcp
+nfs07.sh_v4_ipv6_tcp nfs07.sh -6 -v 4 -t tcp
+nfs07.sh_v4.1_ipv6_tcp nfs07.sh -6 -v 4.1 -t tcp
+nfs07.sh_v4.2_ipv6_tcp nfs07.sh -6 -v 4.2 -t tcp
 
-nfs3_08 nfs08.sh -v 3 -t udp
-nfs3t_08 nfs08.sh -v 3 -t tcp
-nfs4_08 nfs08.sh -v 4 -t tcp
-nfs41_08 nfs08.sh -v 4.1 -t tcp
-nfs42_08 nfs08.sh -v 4.2 -t tcp
-nfs3_ipv6_08 nfs08.sh -6 -v 3 -t udp
-nfs3t_ipv6_08 nfs08.sh -6 -v 3 -t tcp
-nfs4_ipv6_08 nfs08.sh -6 -v 4 -t tcp
-nfs41_ipv6_08 nfs08.sh -6 -v 4.1 -t tcp
-nfs42_ipv6_08 nfs08.sh -6 -v 4.2 -t tcp
+nfs08.sh_v3_ipv4_udp nfs08.sh -v 3 -t udp
+nfs08.sh_v3_ipv4_tcp nfs08.sh -v 3 -t tcp
+nfs08.sh_v4_ipv4_tcp nfs08.sh -v 4 -t tcp
+nfs08.sh_v4.1_ipv4_tcp nfs08.sh -v 4.1 -t tcp
+nfs08.sh_v4.2_ipv4_tcp nfs08.sh -v 4.2 -t tcp
+nfs08.sh_v3_ipv6_udp nfs08.sh -6 -v 3 -t udp
+nfs08.sh_v3_ipv6_tcp nfs08.sh -6 -v 3 -t tcp
+nfs08.sh_v4_ipv6_tcp nfs08.sh -6 -v 4 -t tcp
+nfs08.sh_v4.1_ipv6_tcp nfs08.sh -6 -v 4.1 -t tcp
+nfs08.sh_v4.2_ipv6_tcp nfs08.sh -6 -v 4.2 -t tcp
 
-nfslock3_01 nfslock01.sh -v 3 -t udp
-nfslock3t_01 nfslock01.sh -v 3 -t tcp
-nfslock4_01 nfslock01.sh -v 4 -t tcp
-nfslock41_01 nfslock01.sh -v 4.1 -t tcp
-nfslock42_01 nfslock01.sh -v 4.2 -t tcp
-nfslock3_ipv6_01 nfslock01.sh -6 -v 3 -t udp
-nfslock3t_ipv6_01 nfslock01.sh -6 -v 3 -t tcp
-nfslock4_ipv6_01 nfslock01.sh -6 -v 4 -t tcp
-nfslock41_ipv6_01 nfslock01.sh -6 -v 4.1 -t tcp
-nfslock42_ipv6_01 nfslock01.sh -6 -v 4.2 -t tcp
+nfslock01.sh_v3_ipv4_udp nfslock01.sh -v 3 -t udp
+nfslock01.sh_v3_ipv4_tcp nfslock01.sh -v 3 -t tcp
+nfslock01.sh_v4_ipv4_tcp nfslock01.sh -v 4 -t tcp
+nfslock01.sh_v4.1_ipv4_tcp nfslock01.sh -v 4.1 -t tcp
+nfslock01.sh_v4.2_ipv4_tcp nfslock01.sh -v 4.2 -t tcp
+nfslock01.sh_v3_ipv6_udp nfslock01.sh -6 -v 3 -t udp
+nfslock01.sh_v3_ipv6_tcp nfslock01.sh -6 -v 3 -t tcp
+nfslock01.sh_v4_ipv6_tcp nfslock01.sh -6 -v 4 -t tcp
+nfslock01.sh_v4.1_ipv6_tcp nfslock01.sh -6 -v 4.1 -t tcp
+nfslock01.sh_v4.2_ipv6_tcp nfslock01.sh -6 -v 4.2 -t tcp
 
-nfsstat3_01 nfsstat01.sh
+nfsstat3.sh nfsstat01.sh
 
-nfsx3 fsx.sh -v 3 -t udp
-nfsx3t fsx.sh -v 3 -t tcp
-nfsx4 fsx.sh -v 4 -t tcp
-nfsx41 fsx.sh -v 4.1 -t tcp
-nfsx42 fsx.sh -v 4.2 -t tcp
-nfsx3_ipv6 fsx.sh -6 -v 3 -t udp
-nfsx3t_ipv6 fsx.sh -6 -v 3 -t tcp
-nfsx4_ipv6 fsx.sh -6 -v 4 -t tcp
-nfsx41_ipv6 fsx.sh -6 -v 4.1 -t tcp
-nfsx42_ipv6 fsx.sh -6 -v 4.2 -t tcp
+fsx.sh_v3_ipv4_udp fsx.sh -v 3 -t udp
+fsx.sh_v3_ipv4_tcp fsx.sh -v 3 -t tcp
+fsx.sh_v4_ipv4_tcp fsx.sh -v 4 -t tcp
+fsx.sh_v4.1_ipv4_tcp fsx.sh -v 4.1 -t tcp
+fsx.sh_v4.2_ipv4_tcp fsx.sh -v 4.2 -t tcp
+fsx.sh_v3_ipv6_udp fsx.sh -6 -v 3 -t udp
+fsx.sh_v3_ipv6_tcp fsx.sh -6 -v 3 -t tcp
+fsx.sh_v4_ipv6_tcp fsx.sh -6 -v 4 -t tcp
+fsx.sh_v4.1_ipv6_tcp fsx.sh -6 -v 4.1 -t tcp
+fsx.sh_v4.2_ipv6_tcp fsx.sh -6 -v 4.2 -t tcp
-- 
2.42.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
