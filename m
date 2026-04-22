Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B947F9EDD9
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 14:13:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F21963E580D
	for <ltp@archiver.kernel.org>; Wed, 22 Apr 2026 16:13:34 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C44BB3E5816
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 16:12:44 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 44962600700
 for <ltp@lists.linux.it>; Wed, 22 Apr 2026 16:12:44 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0BEBB5BD33;
 Wed, 22 Apr 2026 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776867159; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j7KZx6KF8Q/Z5amdlxxI2oMHL7A90yAhoSM4HVDx9Ug=;
 b=frScLwXKwu726bNVs/vA4ve9GuJ5pebKmGQ7rlDmcRibuiZsXuzyZJFhdBaSgexg1+ooVf
 7zVRb4DL8QkjNSpI+hTIC8Jl+sPPuRu5HSq2H2wuTWNuO07OkmKAUeloi9IL/zVNxT0IS9
 Jb9lFVaWdX9J6aosn0GBbc+w/P5nryA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776867159;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j7KZx6KF8Q/Z5amdlxxI2oMHL7A90yAhoSM4HVDx9Ug=;
 b=00DQIuchlPLqEq8mulbN9Rb8aCzz4MsBgHBYqKe2MXob4n3hWKLfielVKoxwLrlJmDzeIU
 ymhaUptjVWiZX6Aw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cH7cGOjr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=b6frTwIE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776867158; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j7KZx6KF8Q/Z5amdlxxI2oMHL7A90yAhoSM4HVDx9Ug=;
 b=cH7cGOjro46BVTkqYq+c3UQ2MXpIUutDq6f/amNbrwoT5u2Ikxa0z7kkiuGYfpdFARP5u6
 wjBxqVLtTRwgeXExjM8V+hrojErEStcHqC++ZOMrodmky/272RVpJKMqX7mzlr/lxCVajq
 DgYU866O+6O/FWai3LoPEsQKjm8mcEk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776867158;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=j7KZx6KF8Q/Z5amdlxxI2oMHL7A90yAhoSM4HVDx9Ug=;
 b=b6frTwIELsitVpwF3KI/ruoQJVj1jzIMmXd394wZeXrVqj5HmOlAeshfHzaZpUbR9NeI0D
 g4m9k/+bmeyfdtAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 57F57593AF;
 Wed, 22 Apr 2026 14:12:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mHkSEVXX6GnqUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 22 Apr 2026 14:12:37 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Apr 2026 16:12:29 +0200
Message-ID: <20260422141234.632195-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; DKIM_TRACE(0.00)[suse.cz:+];
 FREEMAIL_CC(0.00)[suse.cz,gmail.com,suse.com,redhat.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[6];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 0BEBB5BD33
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 0/5] lib: LTP_DEBUG cleanup
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
Cc: Martin Cermak <mcermak@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Changes v3->v4:
* New commit "lib: Merge functionality of LTP_QUIET into LTP_REPRODUCIBLE_OUTPUT"
(I wanted to add it before Valgrind release, but too late.)
* Fix typo: "overwriten" -> "overwritten". Also missing closing ')' (Andrea)
* Remove double space before "support" (Andrea)

@Cyril: I know this has very little priority but could it get into
upcoming release?

Link to v4:
https://lore.kernel.org/ltp/20260327173252.1112192-1-pvorel@suse.cz/#r
https://patchwork.ozlabs.org/project/ltp/list/?series=497808&state=*

Petr Vorel (5):
  lib: Ignore empty LTP_ENABLE_DEBUG
  lib: Rename variable LTP_ENABLE_DEBUG => LTP_DEBUG
  lib: Prefer LTP_DEBUG over -D
  doc: newlib_tests: Update debugging parameters
  lib: Merge functionality of LTP_QUIET into LTP_REPRODUCIBLE_OUTPUT

 doc/developers/debugging.rst     |  6 ++--
 doc/old/C-Test-API.asciidoc      |  4 +--
 doc/users/setup_tests.rst        |  4 +--
 lib/newlib_tests/tst_res_flags.c |  2 +-
 lib/tst_test.c                   | 49 +++++++++++++-------------------
 5 files changed, 29 insertions(+), 36 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
