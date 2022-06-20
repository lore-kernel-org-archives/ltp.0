Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7308DC43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 09:19:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A53DB3C9223
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 11:19:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B4023C1B8F
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A468810005FB
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 11:19:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E08851FAC6
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655716779; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y/zNsa3EY7bijtsHhZLjENPYTVwErrCebhxrBXykFyE=;
 b=1OTjiW0gnfEzdjXt0FNSb6V45V4Rb3Fn4PFtG/jWoXIGZr9bXTgdyKaxg/y3JlrmMUg/Mw
 yhiODqXtqP77cO0GZPQ8UHV72FQXJNxGkJ3PfJIYUAmBKvf4anNeF6C8cwmA/jneaxxHO0
 UJE7eLgVlVMfWuZxR/FZ6+IiJVw2Jx4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655716779;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Y/zNsa3EY7bijtsHhZLjENPYTVwErrCebhxrBXykFyE=;
 b=oUxaKL3aZ/mLfIOqgP5M3jU20pZcgUjTi8uG9KTTzPlgQkfpC3hvneKGe3ayskGRNstGGj
 ispl4yPemImCZGAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CBC04134CA
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NydyMKs7sGJeQAAAMHmgww
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 09:19:39 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 20 Jun 2022 11:21:39 +0200
Message-Id: <20220620092146.7604-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/7] openposix: Fix 'no return in nonvoid function'
 warnings
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

Fixes LTP compilation in build systems where the 'no return in nonvoid
function' warning is treated as error. More than half of the cases were
actually a buggy tests, which only shows that maybe treating this
warning as an error makes sense.

Cyril Hrubis (7):
  openposix: pthread_rwlockattr_getpshared/2-1: Fix
  openposix: pthread_spin_init/{2-1,2-2}: Fix
  openposix: sem_destroy/3-1: Fix
  openposix: sem_timedwait/11-1: Fix
  openposix: aio_h/2-1: Add return at the end of main()
  openposix: mq_timedreceive: Silence warning
  opeposix: pthread_barrierattr_getpshared/2-1: Simplify codeflow

 .../conformance/definitions/aio_h/2-1.c       |  2 ++
 .../interfaces/mq_timedreceive/5-3.c          |  1 +
 .../pthread_barrierattr_getpshared/2-1.c      | 11 +++----
 .../pthread_rwlockattr_getpshared/2-1.c       | 20 ++++++++++--
 .../interfaces/pthread_spin_init/2-1.c        | 20 ++++++++++--
 .../interfaces/pthread_spin_init/2-2.c        | 20 ++++++++++--
 .../conformance/interfaces/sem_destroy/3-1.c  | 31 +++++++++++++------
 .../interfaces/sem_timedwait/11-1.c           |  9 +++---
 8 files changed, 89 insertions(+), 25 deletions(-)

-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
