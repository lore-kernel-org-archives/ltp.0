Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB0EC5AC7A
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:48:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 440313D083C
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:48:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9CEF3D085C
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6CE7C2009BD
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F79B3E717;
 Fri, 20 Feb 2026 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771602467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1QpQzAXe++1By1h/6zlrJLBee5KDVVy/JxbFTURbAy4=;
 b=rm1IjK2eOLuWrJZ6fYF8wXLdpTK5qmGjkveoPTkH/Bul+ZHtejFDS/Dq8XqcKTAqTCFHwJ
 WjmDm+UUO3WrEyR3Hjsp80Gj306DeEdu+cA0zl35/Ezfof9YlzAOPuRzbS5td5la+6L/ku
 ajLKlA/znMk7bBuKrrtXf5j96lxQho0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771602467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1QpQzAXe++1By1h/6zlrJLBee5KDVVy/JxbFTURbAy4=;
 b=9e4YCO29T3E69v6pC9VcgBbDgSiFxYczPzLULqD9ZN6qYkcZhAoEhYQ+8OAuC8wecqKAkT
 XwK41zxOVUgagGBQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rm1IjK2e;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9e4YCO29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771602467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1QpQzAXe++1By1h/6zlrJLBee5KDVVy/JxbFTURbAy4=;
 b=rm1IjK2eOLuWrJZ6fYF8wXLdpTK5qmGjkveoPTkH/Bul+ZHtejFDS/Dq8XqcKTAqTCFHwJ
 WjmDm+UUO3WrEyR3Hjsp80Gj306DeEdu+cA0zl35/Ezfof9YlzAOPuRzbS5td5la+6L/ku
 ajLKlA/znMk7bBuKrrtXf5j96lxQho0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771602467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=1QpQzAXe++1By1h/6zlrJLBee5KDVVy/JxbFTURbAy4=;
 b=9e4YCO29T3E69v6pC9VcgBbDgSiFxYczPzLULqD9ZN6qYkcZhAoEhYQ+8OAuC8wecqKAkT
 XwK41zxOVUgagGBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0E22F3EA65;
 Fri, 20 Feb 2026 15:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kWlAAyOCmGkmdwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Feb 2026 15:47:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ppavlu@suse.cz,
	ltp@lists.linux.it
Date: Fri, 20 Feb 2026 16:47:07 +0100
Message-ID: <20260220154742.54150-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 1F79B3E717
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Add test for fanotify monitoring of tracefs
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

Add test for reading basic fanotify events from a tracefs mount.
The test will activate monitoring of FAN_MODIFY events from the
whole mountpoint, create a new kprobe, activate it, deactivate it
and remove it again. This should generate exactly 4 FAN_MODIFY events.

On some kernels with badly backported tracefs fixes, this may trigger
NULL pointer dereference. The testcase is intentionally simple but
sufficient to trigger this kind of bug. More complex tracing subtests
can be added later.

Martin Doucha (2):
  tst_fs.h: Add TST_TRACEFS_MAGIC constant
  Add test for fanotify monitoring of tracing filesystem

 include/tst_fs.h                              |   1 +
 runtest/syscalls                              |   1 +
 runtest/tracing                               |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify25.c     | 126 ++++++++++++++++++
 5 files changed, 130 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify25.c

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
