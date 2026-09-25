Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1C2FC9830D
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 08:29:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 076203E61AD
	for <ltp@archiver.kernel.org>; Fri, 25 Sep 2026 10:29:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D4313E619A
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:28:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DF29F1400C4C
 for <ltp@lists.linux.it>; Fri, 25 Sep 2026 10:28:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE4A71FAA0;
 Fri, 25 Sep 2026 08:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790324927; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zf9lbgq0W8UNzfRl/XxaYAmnAp1uBoWA1YNZe7ZGAgc=;
 b=ulB54YbH1HXyDPEonJxVTQYGulxVDqfR/oi15tEQsYvI+FnZqOgrPblrH7IYm/Xrc+Gvci
 bErZF46pJE1Jgb2gTVNEIGwtR44EB8Gx1PP/Brc/XfuwbVMvLBSi3T1vTysOQJGpW1jLxt
 5Sxjb3g/Rnr/saXVl6HyRpJ3Oj9z3R4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790324927;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zf9lbgq0W8UNzfRl/XxaYAmnAp1uBoWA1YNZe7ZGAgc=;
 b=RzdXc75ZkNrIZwRMi8AnB9U55L0ill1YMOPVWQbbdwmArWvVBjWYLjKrqQJxbC2kT9crrF
 8eLY96IEos1AeuCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1790324922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zf9lbgq0W8UNzfRl/XxaYAmnAp1uBoWA1YNZe7ZGAgc=;
 b=CtaWNcFr8gOf6Fx1T+PnG8021lzD/1qsHm0qs44kF3/EUWq78SMF00pgEHDsvEisVDETgk
 z7w1GcROddt/xCysjMHGxNzNpvaYYMmOCx4UAReFngofu/tkIE/0inTKd0F/I+rkhtfHO+
 dF+ooIYY0RzZwA0JYTNmyAPZKVlkE5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1790324922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=zf9lbgq0W8UNzfRl/XxaYAmnAp1uBoWA1YNZe7ZGAgc=;
 b=nsBDVREi0DokB+0ldUuqBzSNWhLd+Cv1eYutbIGOS7YAzfIn3yJF/mN7WFxb38YI5ouqes
 wBB6Nh4DiiO8wmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E8AC13432;
 Fri, 25 Sep 2026 08:28:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HWSGF7owtmohTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 25 Sep 2026 08:28:42 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 25 Sep 2026 10:28:38 +0200
Message-ID: <20260925082840.2408504-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.995];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/2] shmctl03: Fix shmmax clamped to INT_MAX in
 32bit compat mode
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

Changes v2->v3:
* Drop first fix from Andrea:
  https://lore.kernel.org/ltp/20260924112514.2375626-2-pvorel@suse.cz/
  I'm no longer confident it's a good idea even if we document changed
  behavior. See my concern:
  https://lore.kernel.org/ltp/20260925080154.GC2387785@pevik/
  Maybe we should either handle this entirely in shmctl03.c as there is
  no other test which needs it.
* Use unsigned long instead of unsigned long long (no need for that big
  variable)
* Use correct macro TST_EXP_EQ_LU() (agent)
* Read shmmax only once (agent)
* TST_EXP_POSITIVE SAFE_SHMCTL() instead of safe_shmctl() (no TBROK
  instead of TFAIL in case of failure and it's probably slightly more
  readable)

Petr Vorel (2):
  shmctl03: Fix shmmax clamped to INT_MAX in 32bit compat mode
  shmctl03: Use test macros

 testcases/kernel/syscalls/shmctl/shmctl03.c | 24 ++++++++++-----------
 1 file changed, 12 insertions(+), 12 deletions(-)

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
