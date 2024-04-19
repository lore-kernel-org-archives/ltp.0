Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F17DC4345F
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 12:43:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D42273CFD78
	for <ltp@archiver.kernel.org>; Fri, 19 Apr 2024 14:42:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19A9D3CE3F6
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 14:42:26 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7693F100E335
 for <ltp@lists.linux.it>; Fri, 19 Apr 2024 14:42:26 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CFAE21A38;
 Fri, 19 Apr 2024 12:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713530545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWxHXKHJzlxksujkFGzzvKeY22VZxyud2fUP6wyH22Y=;
 b=P3Oy8IFu3HuSyDF5JgEvLhR9RfP6ya++xd003sSG63znCcaPAcTWgoIxoa2W5Z8bWi0GBv
 t7KiCfnccaIG6TAPpET1DfuGqUVGntjZ8N6TzGGxkY1cZ1a42FqfgxvOgj6t37GcqNqQiV
 46Z/DhrN/nZpqRSLoJjVdes+YqvTMUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713530545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWxHXKHJzlxksujkFGzzvKeY22VZxyud2fUP6wyH22Y=;
 b=frx8JYQ9PM1jdTNnHttzpQVrBG9oBdcjZ/kTKrtpwsAtvk1vbHcWT6mc5jCUtQ6tjLXKy5
 Xw06M2THOQQ6CNAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1713530545; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWxHXKHJzlxksujkFGzzvKeY22VZxyud2fUP6wyH22Y=;
 b=P3Oy8IFu3HuSyDF5JgEvLhR9RfP6ya++xd003sSG63znCcaPAcTWgoIxoa2W5Z8bWi0GBv
 t7KiCfnccaIG6TAPpET1DfuGqUVGntjZ8N6TzGGxkY1cZ1a42FqfgxvOgj6t37GcqNqQiV
 46Z/DhrN/nZpqRSLoJjVdes+YqvTMUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1713530545;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oWxHXKHJzlxksujkFGzzvKeY22VZxyud2fUP6wyH22Y=;
 b=frx8JYQ9PM1jdTNnHttzpQVrBG9oBdcjZ/kTKrtpwsAtvk1vbHcWT6mc5jCUtQ6tjLXKy5
 Xw06M2THOQQ6CNAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0EFB91395B;
 Fri, 19 Apr 2024 12:42:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aBeTAbFmImZNRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Apr 2024 12:42:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 19 Apr 2024 14:42:20 +0200
Message-ID: <20240419124221.207445-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240419124221.207445-1-pvorel@suse.cz>
References: <20240419124221.207445-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-5.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 URI_HIDDEN_PATH(1.00)[https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] doc: Clarify that the only public CI testing is
 build only
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

Also convert .github/workflows/ci.yml as link to github
(unfortunately that remove code formatting).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/writing_tests.rst | 4 ++--
 doc/users/supported_systems.rst  | 9 +++++++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 032fbcbd5..3db56a558 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -346,8 +346,8 @@ Testing builds with GitHub Actions
 Master branch is tested in `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_
 to ensure LTP builds in various distributions, including old, current and
 bleeding edge. ``gcc`` and ``clang`` toolchains are also tested for various
-architectures using cross-compilation. For a full list of tested distros, please
-check ``.github/workflows/ci.yml``.
+architectures using cross-compilation. For a full list of tested distros, please check
+`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
 
 .. note::
 
diff --git a/doc/users/supported_systems.rst b/doc/users/supported_systems.rst
index 82774c2ef..a9086f4d8 100644
--- a/doc/users/supported_systems.rst
+++ b/doc/users/supported_systems.rst
@@ -3,6 +3,12 @@
 Supported systems
 =================
 
+Build testing is done with `GitHub Actions <https://github.com/linux-test-project/ltp/actions>`_.
+
+.. note::
+
+      There is no CI testing of the actual tests run.
+
 Kernel version
 --------------
 
@@ -38,6 +44,9 @@ Oldest tested distributions
       - 10.2.1
       - 11.0.1
 
+For a full list of tested distros, please tested distros, please check
+`.github/workflows/ci.yml <https://github.com/linux-test-project/ltp/blob/master/.github/workflows/ci.yml>`_.
+
 Older distributions are not officially supported, which means that it
 may or may not work. It all depends on your luck. It should be possible
 to compile latest LTP even on slightly older distributions than we
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
