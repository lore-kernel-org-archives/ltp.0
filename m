Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34CAEB64DA
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 15:02:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FE7F3CA0AE
	for <ltp@archiver.kernel.org>; Thu, 20 Jul 2023 17:02:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F4923C9549
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:12 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F0631001263
 for <ltp@lists.linux.it>; Thu, 20 Jul 2023 17:02:10 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CDFC82069F;
 Thu, 20 Jul 2023 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689865329; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bx3TiSjYIqH4bXr69TyFvD1qmF2SYKB2N+gVW6MDo0s=;
 b=jQvfLcFm03l7PDPb01IFfB595P4rANAMry7oJU0duD0o/ndpl3ScVjwJAL93KZevmhmYXm
 VrbXzp4l/wmPy3oq8Hgoq4bJAlEnycrWnWLeOeoDa1NwTo1cGRWr9eV8fPvc2ckY9TpvCK
 nJFpIeuCwOzIVAS27CD9WQt1g6iHZK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689865329;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bx3TiSjYIqH4bXr69TyFvD1qmF2SYKB2N+gVW6MDo0s=;
 b=Ezdkjqk74J9v03f22Vl8ydhuD3piecBlw8AOyg5iRITFmc009n20M0LPS8Gy1NXWs6F9Nv
 G4h1a5UlHL7aC4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B92A138EC;
 Thu, 20 Jul 2023 15:02:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id o6dGJHFMuWR6CQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jul 2023 15:02:09 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 20 Jul 2023 17:02:02 +0200
Message-Id: <20230720150206.1338520-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] Add .skip_in_secureboot flag
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

Petr Vorel (4):
  tst_lockdown: Check other lockdown configuration
  lib: Add .skip_in_secureboot flag
  {delete,finit,init}_module0[1-3]: Skip on SecureBoot
  doc/c-api: Document .skip_in_* flags

 doc/c-test-api.txt                              |  6 ++++++
 doc/test-writing-guidelines.txt                 |  1 +
 include/tst_test.h                              |  4 ++++
 lib/tst_lockdown.c                              | 11 +++++++----
 lib/tst_test.c                                  |  3 +++
 .../syscalls/delete_module/delete_module01.c    |  2 ++
 .../syscalls/delete_module/delete_module03.c    |  2 ++
 .../syscalls/finit_module/finit_module01.c      |  2 ++
 .../syscalls/finit_module/finit_module02.c      | 17 +++++++++++++----
 .../kernel/syscalls/init_module/init_module01.c |  2 ++
 .../kernel/syscalls/init_module/init_module02.c | 16 ++++++++++++----
 11 files changed, 54 insertions(+), 12 deletions(-)

-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
