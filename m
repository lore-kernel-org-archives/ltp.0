Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 260F4EB26F3
	for <ltp@archiver.kernel.org>; Tue, 10 Feb 2026 18:23:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 333603CC5E9
	for <ltp@archiver.kernel.org>; Tue, 10 Feb 2026 19:23:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D23C83CC237
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 19:23:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 07796600697
 for <ltp@lists.linux.it>; Tue, 10 Feb 2026 19:23:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3746B3E714;
 Tue, 10 Feb 2026 18:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770747814; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t3VV1EdYdP3kZyNLUBz4TFLNKU56SBshOkI00CO3diU=;
 b=YaMnZrADtHWA2Y9h1Pa/8NCPy5esF16S1LVqKUZh1UuZeon5Tb7fKlcxRYP3eQDusYexq7
 AgZRrUVFSB9+soHBAr5QnbcucDKTqCT9hsmjt8uPBaUVHdmkoYbBnI/TQULo4nb76OQV7m
 ETmrm8/J0pyFWdxxDr2eEXWgR5c7GhY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770747814;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t3VV1EdYdP3kZyNLUBz4TFLNKU56SBshOkI00CO3diU=;
 b=GGsFwAjytYyUtIYVEAxAeKaLp8bQZaWULZBGqFLLDAKdeS+M4T1Y4vwAy2rZwqE61Mh3OT
 z8TompbhEW/WrECA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oE4s7RWw;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VzCVlsqM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1770747813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t3VV1EdYdP3kZyNLUBz4TFLNKU56SBshOkI00CO3diU=;
 b=oE4s7RWwBz5EFDyM6Xc1CyxOTmS+N4pXQpjigk56OLaHhNPojq6SNy3zat9UCwSrS5B0iL
 uIhbYja72BEQmTvByNs24udbUHmUmrv7FbA1EhGhCW9yu87iV/PXNeFMrSg+s75cxhPZaB
 cL5KioFXXw6Jb69jQ98d2avVYeLhSf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1770747813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=t3VV1EdYdP3kZyNLUBz4TFLNKU56SBshOkI00CO3diU=;
 b=VzCVlsqMmwVVtu/5R9rC1PpliAAEGLkzdsO5SbDH0ab4wBBOwp/KeUoQtGac8iVvQaO3O2
 TQpAecgaL1WKH9DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F3C23EA62;
 Tue, 10 Feb 2026 18:23:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TAcCAqV3i2lEPAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 10 Feb 2026 18:23:33 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 10 Feb 2026 19:23:32 +0100
MIME-Version: 1.0
Message-Id: <20260210-fix_cpuset_memory_spread_warnings-v1-1-3e97d58e35a2@suse.com>
X-B4-Tracking: v=1; b=H4sIAKN3i2kC/x2NQQqDMBBFryKzNhBDVfAqpYQkTuwsjDKjtkW8u
 0OXj8/77wRBJhQYqhMYDxJaikJTV5DeoUxoaFQGZ11nXWNNpq9P6y64+RnnhX9eVsYw+k/gQmU
 SE3PXx5gfLrcI+qOzSv/G83VdNwJf+uBzAAAA
X-Change-ID: 20260210-fix_cpuset_memory_spread_warnings-bf67bbf42f5e
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770747813; l=1298;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=tflNhSQxGCys84VT/zLyunhuK0aREprm0YNT7hKtgF0=;
 b=WUX2Wr9qyeEf71A/ki4hx7PHhUC6w8Z1fgRQLyapMs/+PeRQ671FRB6G3x87jgsb61E0K7lHf
 tOcP/IAyuysCqZrxmwDCURiUZeRgFVp1lh1/nL9FmayJMWM74LwQhyz
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 3746B3E714
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] controllers: reduce number of warnings caused by grep
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

Remove stray \ before _ and : which are causing lots of warnings in the
console. There's no need to use backslash when using regexp mode in grep.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .../cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh    | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
index 21e67179b94f03eccd860aa995f4fd653a3d7eae..4c49bb8fd6f14e88be7f026e8525c8082f679265 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_spread_test/cpuset_memory_spread_testset.sh
@@ -81,7 +81,7 @@ set_memsinfo_val()
 get_memsinfo_val()
 {
 	local value=
-	value=`echo "$memsinfo" | grep -e "^\_$1\: "`
+	value=`echo "$memsinfo" | grep -e "^_$1: "`
 	value=`echo "$value" | sed -r "s/^.*\: (.*)$/\1/"`
 	echo "$value"
 }

---
base-commit: 660cfd5a8177b819255f3a0f96f82d3c9bffbe4e
change-id: 20260210-fix_cpuset_memory_spread_warnings-bf67bbf42f5e

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
