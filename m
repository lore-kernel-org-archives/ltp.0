Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DE9D1266E
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 09:34:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A57A3D1F1B
	for <ltp@archiver.kernel.org>; Tue,  5 Nov 2024 10:34:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26FC03D1BF4
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 10:34:32 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC60B218EDE
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 10:34:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 10D4321B64
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730799268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9aWoFAH45VOjxUZ/gBrmbxljlcRnchNYspNnI+n5318=;
 b=D0GzWrTZz17aOVxXVGcxm1HqSbFnEjTl0LzvvVNKNsqsRDOlq8ZoHfY/F0rCi4/DZXsAmr
 AfHnetWZKVwMyhkVlWDWKXi/w56Ws6ZVhxkdVpBIgWQFecRg2OzX3Fn1MO10tO8cfrsDtk
 ITvdyLkk99TvIWp1Lbfc2NB02yv0qzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730799268;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9aWoFAH45VOjxUZ/gBrmbxljlcRnchNYspNnI+n5318=;
 b=rI0uIcJzfSP28jeA6o2iUohx5r9PzJf5clk3qCxD82DuzOcLKHOBJ3g2gJ0IxGTFcN1cLv
 OB2l5j/2P+QumvBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730799268; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9aWoFAH45VOjxUZ/gBrmbxljlcRnchNYspNnI+n5318=;
 b=D0GzWrTZz17aOVxXVGcxm1HqSbFnEjTl0LzvvVNKNsqsRDOlq8ZoHfY/F0rCi4/DZXsAmr
 AfHnetWZKVwMyhkVlWDWKXi/w56Ws6ZVhxkdVpBIgWQFecRg2OzX3Fn1MO10tO8cfrsDtk
 ITvdyLkk99TvIWp1Lbfc2NB02yv0qzM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730799268;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9aWoFAH45VOjxUZ/gBrmbxljlcRnchNYspNnI+n5318=;
 b=rI0uIcJzfSP28jeA6o2iUohx5r9PzJf5clk3qCxD82DuzOcLKHOBJ3g2gJ0IxGTFcN1cLv
 OB2l5j/2P+QumvBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA09F1394A
 for <ltp@lists.linux.it>; Tue,  5 Nov 2024 09:34:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MdwMLKPmKWeAPwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Tue, 05 Nov 2024 09:34:27 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 05 Nov 2024 10:34:24 +0100
Message-Id: <20241105-landlock_network-v2-0-d58791487919@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKDmKWcC/2WNyw7CIBQFf6W5azEU0QZX/odpDI+LJa1goKKm4
 d/FJq5cziRnzgIJo8MEx2aBiNklF3wFtmlAD9JfkThTGRhlnIr2QCbpzRT0ePE4P0McieJK8b0
 12DEFdXaPaN1rTZ77yoNLc4jv9SG3X/uLif9YbgklQgvRWbpThspTeiTc6nCDvpTyAbELkM2vA
 AAA
X-Change-ID: 20240916-landlock_network-b4bb45fde72b
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730799267; l=1971;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=4w3z5hCXPMXsAdxyN/hgCzcs+L2mnwr2GlWuiWFO04w=;
 b=UO8/dv7Sw7bUpviMVNz/EckyYOfnOrwfJwIVHF5BaN8mPU0jTk3CXHkNwqGeFj6jAYkY5Ocsg
 r0YXDe22NK6BeIWaTBauaCjHPJ8wAoUPpbXgKrT3ihdF53J5nb4nTfw
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_ONE(0.00)[1];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] landlock network coverage support
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

This testing suite is meant to test the landlock network support.
The landlock fallback had to be modified in order to support ABI v4
which changed the landlock rules structures. Also, a new test has been
added in landlock08, testing bind() and connect() syscalls support.
A few error checks have been added in the landlock02 test.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- check for LANDLOCK_RULE_NET_PORT symbol via autoconf
- split landlock_ruleset_attr for abi1 and abi4
- Link to v1: https://lore.kernel.org/r/20240919-landlock_network-v1-0-9c997f03bd0a@suse.com

---
Andrea Cervesato (4):
      Fallback landlock network support
      Network helpers in landlock suite common functions
      Add landlock08 test
      Add error coverage for landlock network support

 configure.ac                                       |   3 +-
 include/lapi/capability.h                          |   4 +
 include/lapi/landlock.h                            |  28 +--
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/landlock/.gitignore      |   1 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  15 +-
 testcases/kernel/syscalls/landlock/landlock02.c    |  94 ++++++++--
 testcases/kernel/syscalls/landlock/landlock03.c    |   6 +-
 testcases/kernel/syscalls/landlock/landlock04.c    |   6 +-
 testcases/kernel/syscalls/landlock/landlock05.c    |  10 +-
 testcases/kernel/syscalls/landlock/landlock06.c    |  14 +-
 testcases/kernel/syscalls/landlock/landlock07.c    |   6 +-
 testcases/kernel/syscalls/landlock/landlock08.c    | 208 +++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     | 134 ++++++++++++-
 14 files changed, 456 insertions(+), 74 deletions(-)
---
base-commit: 5746e25935a81043d7971d54038636b26355cd0f
change-id: 20240916-landlock_network-b4bb45fde72b

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
