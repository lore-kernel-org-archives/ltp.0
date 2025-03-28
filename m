Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD0B2C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 08:37:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1BD103CA1CA
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 09:37:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439733C6AE4
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:37:32 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 8EA58100036D
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 09:37:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 949421F747;
 Fri, 28 Mar 2025 08:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743151050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jp35vSjyWDlxWLQX/3YdUhKQND1cV5dBNB9NkEerdP4=;
 b=CtK/SdeSlchH1EdSq5JFf4nUa1fhVP95dwPJ8Bxc7zRm+/bNQDBhrdKqCRqy/S/S0Dl+FB
 qocf6IH5VQ+OPdfirtuJcxxHBLElTeqkDflsBQ7kGSzrHC5v+n41OgGN5Cqj9oJgjIHit1
 PH7KX3Cge7xH65MN0e7WUSyenjBcIyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743151050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jp35vSjyWDlxWLQX/3YdUhKQND1cV5dBNB9NkEerdP4=;
 b=Nfh2b3TdDuOt8rF6HVvF38Jl4HkLsGL1xTZLOcCP3QURtuJLWCJtcDaL3xdq4zQ5T9KgBS
 TFcCx/60jzf2EsBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743151050; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jp35vSjyWDlxWLQX/3YdUhKQND1cV5dBNB9NkEerdP4=;
 b=CtK/SdeSlchH1EdSq5JFf4nUa1fhVP95dwPJ8Bxc7zRm+/bNQDBhrdKqCRqy/S/S0Dl+FB
 qocf6IH5VQ+OPdfirtuJcxxHBLElTeqkDflsBQ7kGSzrHC5v+n41OgGN5Cqj9oJgjIHit1
 PH7KX3Cge7xH65MN0e7WUSyenjBcIyc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743151050;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=jp35vSjyWDlxWLQX/3YdUhKQND1cV5dBNB9NkEerdP4=;
 b=Nfh2b3TdDuOt8rF6HVvF38Jl4HkLsGL1xTZLOcCP3QURtuJLWCJtcDaL3xdq4zQ5T9KgBS
 TFcCx/60jzf2EsBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7213613927;
 Fri, 28 Mar 2025 08:37:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id u08wGspf5mcEBQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 28 Mar 2025 08:37:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 28 Mar 2025 09:36:56 +0100
Message-Id: <20250328-landlock_unix_socket-v2-0-dd3072962c42@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKhf5mcC/22NwQ6CMBBEf4Xs2ZpaXBRP/ochBMoiG7E1XSAYw
 r9bSbx5mzfJvFlAKDAJXJIFAk0s7F0Es0vAdpW7k+ImMhhtUKcGVV+5pvf2UY6O51JiokFhbup
 aa0yxJojTV6CW5017KyJ3LIMP7+1lOnzbn/D0XzgdlFZ4PmaYtlnW5PYqo9De+icU67p+ACDjB
 By3AAAA
X-Change-ID: 20250325-landlock_unix_socket-592bb00535be
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743151050; l=1429;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=KkKJCNCX9yvIbspl/bYvjQ3dVJrRKrGCUfEXYz2i7Ts=;
 b=LiV3HFE8wv7zx1gtv2lRKBm/bOHmJKvLWsCDDP6bPrqMwkXAB9O7DyfrN5Bpbu0dI9eelmJnd
 C5X7DvrvizuCnNDaOWgnwl1ZZ/CHYIKv2ehFLkjBdM14QHGUck2pOrv
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:mid,
 suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/4] Landlock tests for ABI v6
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

Landlock released a new feature for IPC scoping in the new ABI.
This includes the following new rules which will be tested in
this patch-set:

- LANDLOCK_SCOPE_ABSTRACT_UNIX_SOCKET
- LANDLOCK_SCOPE_SIGNAL

https://docs.kernel.org/userspace-api/landlock.html#ipc-scoping

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- add landlock09 and landlock10 to runtest file
- DOMAIN_LENGTH -> DOMAIN_CNT
- Link to v1: https://lore.kernel.org/r/20250327-landlock_unix_socket-v1-0-584653f66d9c@suse.com

---
Andrea Cervesato (4):
      Add landlock ABI v6 fallback
      landlock02: support landlock ABI v6
      landlock: add landlock09 test
      landlock: add landlock10 test

 include/lapi/landlock.h                            |  23 +++-
 runtest/syscalls                                   |   2 +
 testcases/kernel/syscalls/landlock/.gitignore      |   2 +
 testcases/kernel/syscalls/landlock/landlock02.c    |  12 +-
 testcases/kernel/syscalls/landlock/landlock09.c    | 132 +++++++++++++++++++++
 testcases/kernel/syscalls/landlock/landlock10.c    | 110 +++++++++++++++++
 .../kernel/syscalls/landlock/landlock_common.h     |  11 ++
 7 files changed, 283 insertions(+), 9 deletions(-)
---
base-commit: 753bd13472d4be44eb70ff183b007fe9c5fffa07
change-id: 20250325-landlock_unix_socket-592bb00535be

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
