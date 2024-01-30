Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDD7AC46CD2
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 07:35:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4FCE03CE0F5
	for <ltp@archiver.kernel.org>; Tue, 30 Jan 2024 08:35:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F24073CE0E2
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:35:12 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 55A2B100096F
 for <ltp@lists.linux.it>; Tue, 30 Jan 2024 08:35:11 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B3DB22052;
 Tue, 30 Jan 2024 07:35:11 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 60624139E1;
 Tue, 30 Jan 2024 07:35:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id UJl9Fq+muGVjTwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jan 2024 07:35:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 30 Jan 2024 08:35:07 +0100
Message-ID: <20240130073507.662414-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130073507.662414-1-pvorel@suse.cz>
References: <20240130073507.662414-1-pvorel@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 7B3DB22052
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] runtest: Remove 'ltp-' prefix from aio* runtests
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Renaming runtest files will force people to rename in their frameworks /
toolings, but it's nice to be consistent.

 runtest/{ltp-aio-stress => aio-stress}     | 0
 runtest/{ltp-aiodio.part1 => aiodio.part1} | 0
 runtest/{ltp-aiodio.part2 => aiodio.part2} | 0
 runtest/{ltp-aiodio.part3 => aiodio.part3} | 0
 runtest/{ltp-aiodio.part4 => aiodio.part4} | 0
 5 files changed, 0 insertions(+), 0 deletions(-)
 rename runtest/{ltp-aio-stress => aio-stress} (100%)
 rename runtest/{ltp-aiodio.part1 => aiodio.part1} (100%)
 rename runtest/{ltp-aiodio.part2 => aiodio.part2} (100%)
 rename runtest/{ltp-aiodio.part3 => aiodio.part3} (100%)
 rename runtest/{ltp-aiodio.part4 => aiodio.part4} (100%)

diff --git a/runtest/ltp-aio-stress b/runtest/aio-stress
similarity index 100%
rename from runtest/ltp-aio-stress
rename to runtest/aio-stress
diff --git a/runtest/ltp-aiodio.part1 b/runtest/aiodio.part1
similarity index 100%
rename from runtest/ltp-aiodio.part1
rename to runtest/aiodio.part1
diff --git a/runtest/ltp-aiodio.part2 b/runtest/aiodio.part2
similarity index 100%
rename from runtest/ltp-aiodio.part2
rename to runtest/aiodio.part2
diff --git a/runtest/ltp-aiodio.part3 b/runtest/aiodio.part3
similarity index 100%
rename from runtest/ltp-aiodio.part3
rename to runtest/aiodio.part3
diff --git a/runtest/ltp-aiodio.part4 b/runtest/aiodio.part4
similarity index 100%
rename from runtest/ltp-aiodio.part4
rename to runtest/aiodio.part4
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
