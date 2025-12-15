Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B92AED5B16F
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 12:43:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 022F93D00B7
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 13:43:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 762943C9A3E
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 13:43:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E52B860067B
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 13:43:07 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 75A9A337DB
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 12:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765802586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntb9OjiTTcvZiSYjMeXXOZshOr+40wptg0pj+sOlPc4=;
 b=Po7byTBVrOdHuBcCfcZ4OCYzu8NxD0UZxvnAMEFEPmiZhduQfskPD/e4hk4wTXmH2uHDGb
 t8Ea3ONRIGOEd8G5ZtiduV7AFxw5Q2gDPa7hNpGYMbL5bXwdnMM/9thn8TSQBan/TBIY1j
 iFobATZZe+ubAcGEuAyWX9wxX1H+kHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765802586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntb9OjiTTcvZiSYjMeXXOZshOr+40wptg0pj+sOlPc4=;
 b=jYjw+tFZaJwervq2G2FN3KUdsZ0LRCugMpTj46HrbLkDvzrityBsvUUzbWXgoBqtfUxOKV
 NLu4pc/OoSkkIqCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765802586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntb9OjiTTcvZiSYjMeXXOZshOr+40wptg0pj+sOlPc4=;
 b=Po7byTBVrOdHuBcCfcZ4OCYzu8NxD0UZxvnAMEFEPmiZhduQfskPD/e4hk4wTXmH2uHDGb
 t8Ea3ONRIGOEd8G5ZtiduV7AFxw5Q2gDPa7hNpGYMbL5bXwdnMM/9thn8TSQBan/TBIY1j
 iFobATZZe+ubAcGEuAyWX9wxX1H+kHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765802586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ntb9OjiTTcvZiSYjMeXXOZshOr+40wptg0pj+sOlPc4=;
 b=jYjw+tFZaJwervq2G2FN3KUdsZ0LRCugMpTj46HrbLkDvzrityBsvUUzbWXgoBqtfUxOKV
 NLu4pc/OoSkkIqCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 671523EA65
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 12:43:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t+PnF1oCQGnyPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 12:43:06 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 15 Dec 2025 13:44:04 +0100
Message-ID: <20251215124404.16395-2-chrubis@suse.cz>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251215124404.16395-1-chrubis@suse.cz>
References: <20251215124404.16395-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.69 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.09)[-0.475]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_NONE(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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
 doc/developers/ground_rules.rst | 91 +++++++++++++++++++++++++++++++++
 doc/index.rst                   |  1 +
 2 files changed, 92 insertions(+)
 create mode 100644 doc/developers/ground_rules.rst

Changes in v2:

- added two more rules
- fixes and typos as pointed out by Peter

diff --git a/doc/developers/ground_rules.rst b/doc/developers/ground_rules.rst
new file mode 100644
index 000000000..2bef426aa
--- /dev/null
+++ b/doc/developers/ground_rules.rst
@@ -0,0 +1,91 @@
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
+The first problem is that it will likely introduce very rare test failures,
+that means somebody has to spend time looking into these, which is a wasted
+effort. Nobody likes tests that will fail rarely for no good reason. Even more
+so you cannot run such tests with a background load to ensure that everything
+works correctly on a busy system, because that will increase the likehood of a
+failure.
+
+The second problem is that this wastes resources and slows down a test run. If
+you think that adding a sleep to a test is not a big deal, lets have a look at
+the bigger perspective. There is about 1600 syscall tests in Linux Test
+Project, if 7.5% of them would sleep just for one second, we would end up with
+two minutes of wasted time per testrun. In practice most of the test, that
+historically misused sleep for synchronization, waited for much longer just to
+be sure that things will works even on slower hardware. With sleeps between 2
+and 5 seconds that puts us somewhere between 4 and 10 minutes which is between
+13% and 33% of the syscall runtime on an outdated thinkpad, where the run
+finishes in a bit less than half an hour. It's even worse on newer hardware,
+because this slowdown will not change no matter how fast your machine is, which
+is maybe the reason why this was acceptable twenty years ago but it's not now.
+
+
+What to do instead?
+```````````````````
+
+Use proper synchronization.
+
+There are different problems and different solutions. Most often test needs to
+synchronize between child and parent proces.
+
+The easiest case is that parent needs to wait for a child to finish, that can
+be fixed just be adding a :man2:`waitpid` in the parent which ensures that child is
+finished before parent runs.
+
+Commonly child has to execute certain piece of code before parent can continue.
+For that LTP library implements checkpoints with simple
+:c:func:`TST_CHECKPOINT_WAIT()` and :c:func:`TST_CHECKPOINT_WAKE()` functions based
+on futexes on a piece of shared memory set up by the test library.
+
+Another common case is where child must sleep in a syscall before parent can
+continue, for which we have a :c:func:`TST_PROCESS_STATE_WAIT()` helper that
+polls `/proc/$PID/stat`.
+
+Less often test needs to wait for an action that is done asynchronously, or a
+kernel resource deallocation is deferred to a later time. In such cases the
+best we can do is to poll. In LTP we ended up with a macro that polls by
+calling a piece of code in a loop with exponentially increasing sleeps between
+retries until it succeeds. Which means that instead of sleeping for a maximal
+time event can possibly take the sleep is capped by twice of the optimal
+sleeping time while we avoid polling too aggressively.
+
+
+Use runtime checks for kernel features
+======================================
+
+What is and what isn't supported by kernel is determined by the version
+and configuration of the kernel the systems is currently running on.
+That especially means that any checks done during the compilation cannot
+be used to assume features supported by the kernel the tests end up
+running on. The compile time checks, done by configure script, are only
+useful for enabling fallback kernel API definitions when missing, as we
+do in lapi/ directory.
+
+
+Kernel features and RCs
+=======================
+
+LTP tests or fixes for kernel changes that were not released yet can be posted
+to the LTP list for a review but will not be be accepted until respective
+kernel changes are released. Review of such changes is also considered to be
+lower priority than rest of the changes. This is because kernel changes
+especially in the early RC phase are volatile and could be changed or reverted.
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
