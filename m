Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89B2BCD1292
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 13:05:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B36A63CD088
	for <ltp@archiver.kernel.org>; Thu,  4 Apr 2024 15:05:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BA86F3C111A
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:05:41 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EEEEA6008D7
 for <ltp@lists.linux.it>; Thu,  4 Apr 2024 15:05:40 +0200 (CEST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DFC55D993;
 Thu,  4 Apr 2024 13:05:39 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 06453139E8;
 Thu,  4 Apr 2024 13:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id b25uAKOlDmZ4bAAAn2gu4w
 (envelope-from <chrubis@suse.cz>); Thu, 04 Apr 2024 13:05:39 +0000
Date: Thu, 4 Apr 2024 15:04:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zg6lbcX3_8LYj3k6@yuki>
References: <20240404121521.22483-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240404121521.22483-1-andrea.cervesato@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1DFC55D993
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] New LTP documentation
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Can we please fix the spelling errors before this patchset is applied?

$ make spelling
...
WARNING: developers/build_system.rst:134: : Spell check: Explaination: Explaination.
WARNING: developers/test_case_tutorial.rst:136: : Spell check: initialisation: initialisation code. It is important to note that this is a completely.
WARNING: developers/test_case_tutorial.rst:378: : Spell check: internalising: ABI (Application Binary Interface), rather than internalising actual.
WARNING: developers/test_case_tutorial.rst:638: : Spell check: dependants: dependants before their dependencies..
WARNING: developers/test_case_tutorial.rst:663: : Spell check: organisational: We are about to make some organisational changes to the test, so now would be.
WARNING: developers/test_case_tutorial.rst:1004: : Spell check: organisational: Style and organisational issues are best left to after you have found logical.
WARNING: developers/test_case_tutorial.rst:1030: : Spell check: synchronising: also various helper functions for synchronising and forking processes..
WARNING: developers/writing_tests.rst:51: : Spell check: overcomment: Do not overcomment.
WARNING: developers/writing_tests.rst:67: : Spell check: highlevel: paragraph with highlevel test description at the beginning of the file right.
WARNING: developers/writing_tests.rst:89: : Spell check: vendored: uses (among other checks) our vendored version of.
WARNING: developers/writing_tests.rst:162: : Spell check: vendored: It uses (among other checks) our vendored version of.
WARNING: developers/writing_tests.rst:303: : Spell check: Subexecutables: Subexecutables.
WARNING: maintainers/patch_review.rst:29: : Spell check: behaviour: Use sanitizers e.g. undefined behaviour, address..
WARNING: maintainers/patch_review.rst:66: : Spell check: behaviour: Could future kernel behaviour change without "breaking userland"?.
WARNING: maintainers/patch_review.rst:141: : Spell check: licence: ; the licence for test (e.g. GPL-2.0) should not change.
WARNING: users/setup_tests.rst:7: : Spell check: behaviour: tests behaviour by setting environment variables and using specific tests.
WARNING: users/setup_tests.rst:38: : Spell check: behaviour: file. Force colorized output behaviour: .
WARNING: users/setup_tests.rst:64: : Spell check: tella: empty string, tella the library that system is not a virtual machine..
WARNING: users/setup_tests.rst:69: : Spell check: addjust: It's required to addjust path: .
WARNING: users/setup_tests.rst:97: : Spell check: commandline: variable or set on a commandline by the .
WARNING: users/setup_tests.rst:96: : Spell check: Hoewever:  parameter. Hoewever,.
WARNING: Found 21 misspelled words
build succeeded, 22 warnings.

Most of these are actually valid typos.

Other than that:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
