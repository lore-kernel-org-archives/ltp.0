Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFE83D44D4F
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 11:14:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 435E03D3198
	for <ltp@archiver.kernel.org>; Wed,  6 Nov 2024 12:14:25 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 706B03CBEF3
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:13:29 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6CEF61A00980
 for <ltp@lists.linux.it>; Wed,  6 Nov 2024 12:13:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 372301F88F;
 Wed,  6 Nov 2024 11:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730891607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fr62iesZYtx0StCi++ygani92trvVIzJW1wzpGoX0+s=;
 b=AdY7ZJlrFMOeI+TX1vpTPSwNeADv58cme7+at66u9wnjqzVR/2uE33j5HfzCnzfW1L2Gnk
 npoZQMwcosGFHJduOqIlcexj5bhkIN35wFErZ9UG6yhcd4cAjZAKzf013lhgmh8uyTtJnF
 qjshEwm12RltNKI45+YhpGE93ewc4JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730891607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fr62iesZYtx0StCi++ygani92trvVIzJW1wzpGoX0+s=;
 b=fPRrzfcacJlkvbdIR1wmqNx6p6i43kaq9/mM7DmntDHOyd0Dixy7utdAutLrt2o+HHMX4x
 BPtg+2XHb8Q1YqDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730891607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fr62iesZYtx0StCi++ygani92trvVIzJW1wzpGoX0+s=;
 b=AdY7ZJlrFMOeI+TX1vpTPSwNeADv58cme7+at66u9wnjqzVR/2uE33j5HfzCnzfW1L2Gnk
 npoZQMwcosGFHJduOqIlcexj5bhkIN35wFErZ9UG6yhcd4cAjZAKzf013lhgmh8uyTtJnF
 qjshEwm12RltNKI45+YhpGE93ewc4JU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730891607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Fr62iesZYtx0StCi++ygani92trvVIzJW1wzpGoX0+s=;
 b=fPRrzfcacJlkvbdIR1wmqNx6p6i43kaq9/mM7DmntDHOyd0Dixy7utdAutLrt2o+HHMX4x
 BPtg+2XHb8Q1YqDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 017B413736;
 Wed,  6 Nov 2024 11:13:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Pg2/OVZPK2eFdQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 06 Nov 2024 11:13:26 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 06 Nov 2024 12:13:14 +0100
Message-Id: <20241106-landlock_network-v3-0-855b14df63c6@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAEpPK2cC/22N7wrCIBRHX2X4OUOda9mn3iMi/HPXZEtDlxVj7
 54bFEF9uXB+cM4dUYRgIaJdMaIAyUbrXYZyVSDdSncGbE1mxAjjRNAN7qUzvdfdycFw96HDiiv
 Fq8ZAzRTK2jVAYx9L8nDM3No4+PBcPiQ6r++Y+I0ligkWWoi6IaUyRO7jLcJa+wuaW4l9fEpJ9
 cdn2TfVthaUz0d8+dM0vQDt3tAO7wAAAA==
X-Change-ID: 20240916-landlock_network-b4bb45fde72b
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730891606; l=2258;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=aEZRSVrjIG+NGhyofLRLG/Z2R7UGhdcQUhhijm/7/KE=;
 b=axsJTi6UOEYrpB9ZqwKfDvZAQzhyXlCDMlweKdq6Q98WjN9R9XS8Yzj4z9+5vdDprpe3JbnE5
 3inSPlemrKhBDBNg73APjgdywltdMnUBWjxiDrQ6nLCNm47fdCM6m1Q
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] landlock network coverage support
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
Changes in v3:
- remove some unused autoconf rules
- use _abi1 struct for landlock01
- better ENVAL handling in landlock01
- cleanup landlock02
- handle both abi1 and abi4 in landlock02
- Link to v2: https://lore.kernel.org/r/20241105-landlock_network-v2-0-d58791487919@suse.com

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

 configure.ac                                       |   5 +-
 include/lapi/capability.h                          |   4 +
 include/lapi/landlock.h                            |  28 +--
 runtest/syscalls                                   |   1 +
 testcases/kernel/syscalls/landlock/.gitignore      |   1 +
 testcases/kernel/syscalls/landlock/landlock01.c    |  15 +-
 testcases/kernel/syscalls/landlock/landlock02.c    |  93 ++++++---
 testcases/kernel/syscalls/landlock/landlock03.c    |   6 +-
 testcases/kernel/syscalls/landlock/landlock04.c    |   6 +-
 testcases/kernel/syscalls/landlock/landlock05.c    |  10 +-
 testcases/kernel/syscalls/landlock/landlock06.c    |  14 +-
 testcases/kernel/syscalls/landlock/landlock07.c    |   6 +-
 testcases/kernel/syscalls/landlock/landlock08.c    | 209 +++++++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     | 134 ++++++++++++-
 14 files changed, 455 insertions(+), 77 deletions(-)
---
base-commit: 6408294d83682635393e36c14bbd6ebd94fead94
change-id: 20240916-landlock_network-b4bb45fde72b

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
