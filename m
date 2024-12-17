Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FD1E7717F
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 14:51:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2C12D3ECB21
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 15:51:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF1923EBEDA
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 15:50:50 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ACDFA61D9AB
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 15:50:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7395B2115B;
 Tue, 17 Dec 2024 14:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734447048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jOMtDaZp1WJDko9xi+SxlF/LFq0fEivIz0il7YpdXY0=;
 b=a8+Wa3NaxifjOFZXxoov8Y3+HwpwZJD4BioHpFf5Fo1jiPx/FnYgrB63o3pjdHfhkV2X2K
 7OszMyMlpCYYvThiH8v+qf4CZuXOzdIx4BQ3uwmRQQsfD+Z/H7nuTHK3bMAz842IylK8j4
 5QGiOYGsim8f6NQn8CZxX1bEaciLA+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734447048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jOMtDaZp1WJDko9xi+SxlF/LFq0fEivIz0il7YpdXY0=;
 b=oZ0uejplZrfIhFTA/mXqQZJZPMsPFDgimgZ57QtNjKi58b6GwLi08DV6pkhwk8WTDW/icR
 MdK2Y0RMxdfzmJBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734447047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jOMtDaZp1WJDko9xi+SxlF/LFq0fEivIz0il7YpdXY0=;
 b=J6HuzMgUSjE30SZTENPl+D5sPQ449k3NHsm105eTA3HfZHOL+wm+GsloZbmPDldgYbDmeo
 uDtfr663qQgLv2pgqPGSUFSdm1ZagWBgYS1uXqx/TOhW2PHypdDKSDuMBGRzoJg0N29vnM
 Ml3yqNv3Z57H1H4rI8mv1z8YEeugC0A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734447047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jOMtDaZp1WJDko9xi+SxlF/LFq0fEivIz0il7YpdXY0=;
 b=U555g/T6+iPDgqDA4+gR7nHicWCY4qSIANBk0dNLaxOWLg/U2kikGECAmBEgvN0ANU+Z0h
 VcnNfnZufhnJb6Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 092DF132EA;
 Tue, 17 Dec 2024 14:50:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dM6QO8aPYWfJFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Dec 2024 14:50:46 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 17 Dec 2024 15:50:40 +0100
Message-ID: <20241217145041.44600-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ip_tests.sh: Iprove grep count
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

Some systems have already defined another route with src 127.0.0.1,
therefore more exact pattern is needed.

Also 1) escape '.' (dot) in regex 2) use '-q' instead of redirecting
stdout to /dev/null.

Reported-by: Petr Cervinka <pcervinka@suse.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/iproute/ip_tests.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/iproute/ip_tests.sh b/testcases/network/iproute/ip_tests.sh
index ee9768073f..0b1d5a85e6 100755
--- a/testcases/network/iproute/ip_tests.sh
+++ b/testcases/network/iproute/ip_tests.sh
@@ -179,7 +179,7 @@ test5()
 $ip4_addr via 127.0.0.1 dev lo
 	EOF
 
-	ip route show | grep "$ip4_addr via 127.0.0.1 dev lo" > tst_ip.out 2>&1
+	ip route show | grep "$ip4_addr via 127\.0\.0\.1 dev lo" > tst_ip\.out 2>&1
 	if [ $? -ne 0 ]; then
 		tst_res TFAIL "'ip route show' command failed"
 		return
@@ -195,7 +195,7 @@ $ip4_addr via 127.0.0.1 dev lo
 
 	ROD ip route del $ip4_addr via 127.0.0.1
 
-	ip route show | grep 127.0.0.1 > /dev/null
+	ip route show | grep -q "$ip4_addr via 127\.0\.0\.1 dev lo"
 	if [ $? -eq 0 ]; then
 		tst_res TFAIL "route not deleted"
 		return
-- 
2.47.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
