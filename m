Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DE91C25B75
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 00:56:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F6163CF954
	for <ltp@archiver.kernel.org>; Thu, 16 May 2024 02:56:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2642A3CF804
 for <ltp@lists.linux.it>; Thu, 16 May 2024 02:56:12 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 757D0100128F
 for <ltp@lists.linux.it>; Thu, 16 May 2024 02:56:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9878F3383A;
 Thu, 16 May 2024 00:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715820971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6vdpA5JnBzBykBMJ2VZrFfuQjcaHaiFiV6G6Kjp09I=;
 b=FKXqdeaRGvJ1cZtAtc5mR2UxYP2X7ZFTG1FyMU5ZvvMKtR2KqOVxzYysM3kiHfZTazNWUf
 buX4sDWPQ+XZdDKGB75rPoaMVwZxmfSgTt3VcUYLufgNh1D67XrUHO+osbCHAF133nnITD
 S6JraffylDoHyAXsBVV9RBr7S6Eoius=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715820971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6vdpA5JnBzBykBMJ2VZrFfuQjcaHaiFiV6G6Kjp09I=;
 b=92bJiH6IZlf79pnN4u1EKIOgRotkbFd1NN0yQxNfPQwRmhosGGa8VOLeaTKYotNlj1n1Dl
 0IkZ4O1XREk1TMDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715820971; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6vdpA5JnBzBykBMJ2VZrFfuQjcaHaiFiV6G6Kjp09I=;
 b=FKXqdeaRGvJ1cZtAtc5mR2UxYP2X7ZFTG1FyMU5ZvvMKtR2KqOVxzYysM3kiHfZTazNWUf
 buX4sDWPQ+XZdDKGB75rPoaMVwZxmfSgTt3VcUYLufgNh1D67XrUHO+osbCHAF133nnITD
 S6JraffylDoHyAXsBVV9RBr7S6Eoius=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715820971;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Q6vdpA5JnBzBykBMJ2VZrFfuQjcaHaiFiV6G6Kjp09I=;
 b=92bJiH6IZlf79pnN4u1EKIOgRotkbFd1NN0yQxNfPQwRmhosGGa8VOLeaTKYotNlj1n1Dl
 0IkZ4O1XREk1TMDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69C9A137C3;
 Thu, 16 May 2024 00:56:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ovt/GKtZRWbNJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 16 May 2024 00:56:11 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 16 May 2024 02:55:55 +0200
Message-ID: <20240516005558.253199-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] .skip_in_32bit + rewrite fork14 to new API
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

Hi,

added .skip_in_32bit + resubmit Andrea's fork14 rewrite.

Andrea Cervesato (1):
  Refactor fork14 using new LTP API

Petr Vorel (2):
  tst_kernel.h: Convert docs to sphinx
  lib: Add .skip_in_32bit

 doc/developers/api_c_tests.rst          |   2 +
 include/tst_kernel.h                    |  56 +++++--
 include/tst_test.h                      |   6 +-
 lib/tst_kernel.c                        |  11 ++
 lib/tst_test.c                          |   5 +-
 testcases/kernel/syscalls/fork/fork14.c | 209 +++++++++++-------------
 6 files changed, 157 insertions(+), 132 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
