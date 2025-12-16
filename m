Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89C94D609D2
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 17:31:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 27AED3D035C
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 18:31:32 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EC72D3D037C
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 18:31:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 612221400777
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 18:31:03 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CBF0033815
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 17:30:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765906256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUKoNWDuHeyZTtkysFLUqXGtQXp0+iX/Q2dPzYUfK5Y=;
 b=cu66U0rTFmLucnFGnxz9ZJeb7S9t/+BNFMWxZrCzqPPrOB2PVkdTynMndeMuxC/l5SH5nv
 TYshUfxWo9M7XK0YyUAvpfDv2Qlb0qgyrfxqJeul8lTzd1kUfimkvMEgom8KcS7EuGNSA0
 YXr2dh3saAPT9sxHzXCccCIAtdnCFUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765906256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUKoNWDuHeyZTtkysFLUqXGtQXp0+iX/Q2dPzYUfK5Y=;
 b=o3e79xqQcqhc4y9DkmnSBQGYYaMgLUBzj2T1YSbxbAGDbQPP3VVuYknfbJ46Ro/VoGror6
 Ri3tLMPEG1KHoiAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765906256; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUKoNWDuHeyZTtkysFLUqXGtQXp0+iX/Q2dPzYUfK5Y=;
 b=cu66U0rTFmLucnFGnxz9ZJeb7S9t/+BNFMWxZrCzqPPrOB2PVkdTynMndeMuxC/l5SH5nv
 TYshUfxWo9M7XK0YyUAvpfDv2Qlb0qgyrfxqJeul8lTzd1kUfimkvMEgom8KcS7EuGNSA0
 YXr2dh3saAPT9sxHzXCccCIAtdnCFUo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765906256;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BUKoNWDuHeyZTtkysFLUqXGtQXp0+iX/Q2dPzYUfK5Y=;
 b=o3e79xqQcqhc4y9DkmnSBQGYYaMgLUBzj2T1YSbxbAGDbQPP3VVuYknfbJ46Ro/VoGror6
 Ri3tLMPEG1KHoiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C07093EA65
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 17:30:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AOPPLlCXQWnDcgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 17:30:56 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 16 Dec 2025 18:30:50 +0100
Message-ID: <20251216173053.29112-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251216173053.29112-1-mdoucha@suse.cz>
References: <20251216173053.29112-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.66 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.06)[-0.321]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] cpuset_memory: Fix race in multinode subtests
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

In two subtests, memory allocation races against a change of the allowed
cpuset nodes list. This causes random failures. Add the missing sleep
to ensure that memory allocation completes before the allowed nodes
get changed.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../cpuset/cpuset_memory_test/cpuset_memory_testset.sh          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
index 1f68d7444..d13c605e2 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_memory_test/cpuset_memory_testset.sh
@@ -354,7 +354,7 @@ talk2memory_test_for_case_12_13()
 	sleep 1
 	echo $1 > "$2/tasks"
 	/bin/kill -s SIGUSR1 $1
-
+	sleep 1
 	echo 0 > "$2/cpuset.mems" || return 1
 	sleep 1
 	/bin/kill -s SIGUSR1 $1
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
