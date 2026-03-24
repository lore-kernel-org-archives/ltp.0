Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0F20F532E9
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 08:08:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 061BB3E2262
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 09:08:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2D6013E2257
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:08:01 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7D9F0600218
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:08:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A5E834D1CE;
 Tue, 24 Mar 2026 08:08:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774339680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l5ppSJCp4T6bD2tKqeo4Kux3NwB2mTS3oO3p5mhSg30=;
 b=gS2jg5rcVPN8/Nj9h+C9U/w59DENrPp1koqv3LY1UVyi5p5/mwWGzp5gV58o47RcKCAGkR
 2RfXhiuin+7mowb59GGtonhE7kSRF+dq9wpuWgJnCVH1PNkJWdR2px2VG15m9ZgEfGsdv7
 jAziaUmvZ1D1clpthg0bMzkE8D7tzMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774339680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l5ppSJCp4T6bD2tKqeo4Kux3NwB2mTS3oO3p5mhSg30=;
 b=t3VieTeX41K12xRCbzoj2IlyUZEXgaVPXs4QtYuFbi2st71WPHmTT4Dd/jgHgQ0PafddXo
 3zQLd74829xErCBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gS2jg5rc;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=t3VieTeX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774339680; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l5ppSJCp4T6bD2tKqeo4Kux3NwB2mTS3oO3p5mhSg30=;
 b=gS2jg5rcVPN8/Nj9h+C9U/w59DENrPp1koqv3LY1UVyi5p5/mwWGzp5gV58o47RcKCAGkR
 2RfXhiuin+7mowb59GGtonhE7kSRF+dq9wpuWgJnCVH1PNkJWdR2px2VG15m9ZgEfGsdv7
 jAziaUmvZ1D1clpthg0bMzkE8D7tzMY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774339680;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l5ppSJCp4T6bD2tKqeo4Kux3NwB2mTS3oO3p5mhSg30=;
 b=t3VieTeX41K12xRCbzoj2IlyUZEXgaVPXs4QtYuFbi2st71WPHmTT4Dd/jgHgQ0PafddXo
 3zQLd74829xErCBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8665E43D2D;
 Tue, 24 Mar 2026 08:08:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yyEVH2BGwmnGTAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 24 Mar 2026 08:08:00 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 24 Mar 2026 09:08:00 +0100
MIME-Version: 1.0
Message-Id: <20260324-fix_dio_read-v1-1-cf5dfa13e46a@suse.com>
X-B4-Tracking: v=1; b=H4sIAF9GwmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyMT3bTMiviUzPz4otTEFF1jwyRLQxOLJMNkSwsloJaColSgPNi46Nj
 aWgAzo1vxXgAAAA==
X-Change-ID: 20260324-fix_dio_read-31b9148b1c98
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774339680; l=2216;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=ATcOOM3j1Tr20z1+XWcaAQi3Cztr6+bBLRvlLnX/LAg=;
 b=QE3QCg203R4yG88mUtUpPzNmimz18V6OluYFP6wfzNO8FoOx79aPTQjEhPtyeY0ob3UEN4m+d
 ZnEQcQZ+pq0AclJpqhYu1P7baC7P1xADntrT+E2Je6YFeg53iy4QFuT
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 URIBL_BLOCKED(0.00)[suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.com:mid, suse.com:email, suse.de:dkim]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: A5E834D1CE
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] dio_read: fix infinite loop when readsize >= filesize
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The do_direct_reads() function had exit conditions inside the inner
for loop. When readsize >= filesize, the for loop condition is never
true, causing the while(1) loop to spin infinitely without checking
if writers completed or runtime expired.

Move the exit condition checks outside the for loop to ensure they
are evaluated on every iteration, regardless of readsize/filesize
parameters.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
There's a sporadic failure in DOR000 that causes test to loop
indefinetly under s390x. This patch tries to fix the issue by ensuring
test will check runtime and if children completed.
---
 testcases/kernel/io/ltp-aiodio/dio_read.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/testcases/kernel/io/ltp-aiodio/dio_read.c b/testcases/kernel/io/ltp-aiodio/dio_read.c
index 1c913cc2b814e3f6b0673b8926ffce526eb27655..8d1b8adf675e8fa2136b972c18007b2a60dab36a 100644
--- a/testcases/kernel/io/ltp-aiodio/dio_read.c
+++ b/testcases/kernel/io/ltp-aiodio/dio_read.c
@@ -66,20 +66,20 @@ static int do_direct_reads(char *filename, char *bufptr, long long fsize, long l
 	fd = SAFE_OPEN(filename, O_RDONLY | O_DIRECT, 0666);
 
 	while (1) {
-		for (offset = 0; offset + rsize < fsize; offset += rsize) {
-			char *bufoff;
+		if (*children_completed >= numchildren) {
+			tst_res(TINFO,
+				"Writers finshed, exiting reader (iteration %i)",
+				iter);
+			goto exit;
+		}
 
-			if (*children_completed >= numchildren) {
-				tst_res(TINFO,
-					"Writers finshed, exiting reader (iteration %i)",
-					iter);
-				goto exit;
-			}
+		if (!tst_remaining_runtime()) {
+			tst_res(TINFO, "Test out of runtime, exiting");
+			goto exit;
+		}
 
-			if (!tst_remaining_runtime()) {
-				tst_res(TINFO, "Test out of runtime, exiting");
-				goto exit;
-			}
+		for (offset = 0; offset + rsize < fsize; offset += rsize) {
+			char *bufoff;
 
 			w = pread(fd, bufptr, rsize, offset);
 			if (w < 0)

---
base-commit: 475f2dbdce80cca84caf408c910cf4da4779d5a8
change-id: 20260324-fix_dio_read-31b9148b1c98

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
