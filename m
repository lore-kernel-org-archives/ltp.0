Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99C4D3B7EA
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 12:02:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D48B83D02E4
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 13:02:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAFDC3D0234
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:01:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8DE5D2009D1
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 13:01:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC4FA3380C
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765281708; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MTJEa0bM5lPrUbKf2ljyjJO/7F2fkBKs7YjuABqEesQ=;
 b=GJNLHTbUBtEpMtOTUjbBm9lxZoHxXnQKq9JH7T8LBMNFiTxlOB8NPX2qPK90aDnVG0Pdo6
 +PiHBqhU1Ol7ZCgKFuLpA+I7nZ2L7yLvivhIN9LFmYhZvo390ja26R6oNzoHKNhiSG0G9Y
 7atI410XpOXBHt/IbWpJckQ4UCjJNrA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765281708;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MTJEa0bM5lPrUbKf2ljyjJO/7F2fkBKs7YjuABqEesQ=;
 b=rcVCAc3Aks4HInCUy61ZxjHzcyL5zHVbXBhaQOB9GZlCuHA2F1f4uYhxEUtnv5Nc5UPyaY
 DohYZyanbY99MxCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h2Urq1qC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=a+w6NuSI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765281706; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MTJEa0bM5lPrUbKf2ljyjJO/7F2fkBKs7YjuABqEesQ=;
 b=h2Urq1qCy9gA3HRDCKtlK3PQ7jyJPwLSwXoV06bRQz4n1GN4ZTN4n8HIiAZel7kfgvvQ+G
 p4vXEThQbUVy4EkkecFagxy3Hf3QOLinJ2dyMfzZLYA3G2CN/QjoKkrmjw818/fzL3/OZP
 jWXT0TjoOoH3keYzHgFnubwiFRAtELo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765281706;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=MTJEa0bM5lPrUbKf2ljyjJO/7F2fkBKs7YjuABqEesQ=;
 b=a+w6NuSI1BlsDzpsifk9/0acwY+ubzxMNNM4ncPYLSs3wKOVh4MvFhAjbYK97isRuxEGjf
 mFJOnBdU0OTl8lCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF0433EA63
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 12:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NJOYNaoPOGmMSQAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 09 Dec 2025 12:01:46 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  9 Dec 2025 13:02:46 +0100
Message-ID: <20251209120246.18435-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: EC4FA3380C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.995]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_ONE(0.00)[1];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] doc: Add ground rules page
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

This is a continued effort to write down the unwritten rules we have in
the project. Feel free to suggest more topics for the page.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 doc/developers/ground_rules.rst | 68 +++++++++++++++++++++++++++++++++
 doc/index.rst                   |  1 +
 2 files changed, 69 insertions(+)
 create mode 100644 doc/developers/ground_rules.rst

diff --git a/doc/developers/ground_rules.rst b/doc/developers/ground_rules.rst
new file mode 100644
index 000000000..701dcd09a
--- /dev/null
+++ b/doc/developers/ground_rules.rst
@@ -0,0 +1,68 @@
+.. SPDX-License-Identifier: GPL-2.0-or-later
+
+Ground Rules
+============
+
+Do not work around kernel bugs
+------------------------------
+
+We have decided what we will not work around bugs in upstream LTP sources. If a
+test fails on your system for a good reason, e.g. patch wasn't backported and
+the bug is present, work around for this will not be accepted upstream. The
+main reason for this decision is that this masks the failure for everyone else.
+
+
+Do not synchronize by sleep
+---------------------------
+
+Why is sleep in tests bad then?
+```````````````````````````````
+
+The first problem is that it may and will introduce very rare test failures,
+that means somebody has to spend time looking into these, which is a wasted
+effort. Also I'm pretty sure that nobody likes tests that will fail rarely for
+no good reason. Even more so you cannot run such tests with a background load
+to ensure that everything works correctly on a bussy system, because that will
+increase the likehood of a failure.
+
+The second problem is that this wastes resources and slowns down a test run. If
+you think that adding a sleep to a test is not a big deal, let me put things
+into a perspective. There is about 1600 syscall tests in Linux Test Project
+(LTP), if 7.5% of them would sleep just for one second, we would end up with
+two minutes of wasted time per testrun. In practice most of the test I've seen
+waited for much longer just to be sure that things will works even on slower
+hardware. With sleeps between 2 and 5 seconds that puts us somewhere between 4
+and 10 minutes which is between 13% and 33% of the syscall runtime on my dated
+thinkpad, where the run finishes in a bit less than half an hour. It's even
+worse on newer hardware, because this slowdown will not change no matter how
+fast your machine is, which is maybe the reason why this was acceptable twenty
+years ago but it's not now.
+
+
+What to do instead?
+```````````````````
+
+Use proper synchronization.
+
+There are different problems and different solutions.
+
+Most often tests needs to synchronize between child and parent proces.
+
+The easiest case is that parent needs to wait for a child to finish, that can
+be fixed just be adding a waitpid() in the parent which ensures that child is
+finished before parent runs.
+
+Commonly child has to execute certain piece of code before parent can continue.
+For that LTP library implements checkpoints with simple wait and wake functions
+based on futexes on a piece of shared memory set up by the test library.
+
+Another common case is where child must sleep in a syscall before parent can
+continue, for which we have a helper that polls /proc/$PID/stat.
+
+Less often tests needs to wait for an action that is done asynchronously, or a
+kernel resource deallocation is deffered to a later time. In such cases the
+best we can do is to poll. In LTP we ended up with a macro that polls by
+calling a piece of code in a loop with exponentially increasing sleeps between
+retries until it succeeeds. Which means that instead of sleeping for a maximal
+time event can possibly take the sleep is capped by twice of the optimal
+sleeping time while we avoid polling too aggressively.
diff --git a/doc/index.rst b/doc/index.rst
index 06b75616f..659549cc3 100644
--- a/doc/index.rst
+++ b/doc/index.rst
@@ -19,6 +19,7 @@
    :hidden:
    :caption: For developers
 
+   developers/ground_rules
    developers/setup_mailinglist
    developers/writing_tests
    developers/test_case_tutorial
-- 
2.51.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
