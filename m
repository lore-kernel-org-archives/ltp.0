Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28489EB64DA
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 08:47:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B4163CC417
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 10:47:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6A643C9A35
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 10:46:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0BAE200AF2
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 10:46:54 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id ACB732278B;
 Thu, 22 Jun 2023 08:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687423613; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J1TXXkFnQOTXBWHWQr71pNqDt+gA23LnV7lfAUEwHKQ=;
 b=1+af6DkFHTQ9tLkpZWaaRKdt29Jo9BIEJjom7OJXCRIQKg4TIiw9FZxSHvIG/L1UypxY/4
 pJJuqpJDa4QGRr4e8xoVTPDtZjPbEXULxzcz2M0S1uF5EnSxHdMY9NNJniWToJ5NMaYZxZ
 DXtpE6OkhM1yMfJZGHSdmkXcmMk9MsQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687423613;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=J1TXXkFnQOTXBWHWQr71pNqDt+gA23LnV7lfAUEwHKQ=;
 b=ewtV+aKUVyoMHKaIQGw7+KerxBTVOxNCtwryYFDnHzMhJuttFjX1FUCPqCxgEuQuz11FmK
 FUNmwDZXJWdMGcDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A251132BE;
 Thu, 22 Jun 2023 08:46:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yRTdCH0KlGTBBwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 22 Jun 2023 08:46:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Jun 2023 10:46:48 +0200
Message-Id: <20230622084648.490498-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] runtest/net.nfs: Run nfs02_06 on TCP only
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
Cc: Olga Kornievskaia <olga.kornievskaia@gmail.com>,
 Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
 Trond Myklebust <trond.myklebust@hammerspace.com>,
 Chuck Lever <chuck.lever@oracle.com>,
 Anna Schumaker <Anna.Schumaker@Netapp.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UDP support disabled was on NFS server in kernel 5.6.
Due that 2 of 3 nfs06.sh tests runs are being skipped on newer kernels.

Therefore NFSv3 job in nfs02_06 test as TCP. This way all jobs in the
test are TCP, thus test will not be skipped. This also bring NFSv3
testing also under TCP (previously it was tested only on UDP).

Keep UDP in nfs01_06 jobs, so that NFSv3 on UDP is still covered for
older kernels.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 runtest/net.nfs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/runtest/net.nfs b/runtest/net.nfs
index 72cf4b307..15a960017 100644
--- a/runtest/net.nfs
+++ b/runtest/net.nfs
@@ -58,7 +58,7 @@ nfs41_ipv6_05 nfs05.sh -6 -v 4.1 -t tcp
 nfs42_ipv6_05 nfs05.sh -6 -v 4.2 -t tcp
 
 nfs01_06  nfs06.sh -v "3,3,3,4,4,4" -t "udp,udp,tcp,tcp,tcp,tcp"
-nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "udp,tcp,tcp,tcp,tcp,tcp"
+nfs02_06 nfs06.sh -v "3,4,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 nfs03_ipv6_06 nfs06.sh -6 -v "4,4.1,4.1,4.2,4.2,4.2" -t "tcp,tcp,tcp,tcp,tcp,tcp"
 
 nfs3_07 nfs07.sh -v 3 -t udp
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
