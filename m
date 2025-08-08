Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82643C87FD2
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 11:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0270E3CA699
	for <ltp@archiver.kernel.org>; Fri,  8 Aug 2025 13:01:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 241A13C133E
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 13:01:09 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 25F8D10009A2
 for <ltp@lists.linux.it>; Fri,  8 Aug 2025 13:01:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9AD3833E26;
 Fri,  8 Aug 2025 11:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GiYacIpSaIr1+KNAsiQt2NAsD2PhV7wCNKkQMd01jCg=;
 b=jcmA9dA2HbOh5FK5GvyoHc4BQ1dySpkbe0DVa0SsIq/7XKGkP5j79ymJvwI4TizRuRU5BV
 jx8lhrCTMjwX0CASaBDkVGpG7ArdAVSpCMPC9mbOO7yKWL74ZffotqpZt4voJxzEao6E1I
 TuG3D2i/eQ04qDNRlL9vbCP6yDykGTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GiYacIpSaIr1+KNAsiQt2NAsD2PhV7wCNKkQMd01jCg=;
 b=ApwTsFUZeNugzrD7T4jaezshYusLHSPwGXVJVEltK36F6K8BwQ6ksfhBurjxGd0vdPunD+
 b+jkcee17kMPT6CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jcmA9dA2;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ApwTsFUZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754650866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GiYacIpSaIr1+KNAsiQt2NAsD2PhV7wCNKkQMd01jCg=;
 b=jcmA9dA2HbOh5FK5GvyoHc4BQ1dySpkbe0DVa0SsIq/7XKGkP5j79ymJvwI4TizRuRU5BV
 jx8lhrCTMjwX0CASaBDkVGpG7ArdAVSpCMPC9mbOO7yKWL74ZffotqpZt4voJxzEao6E1I
 TuG3D2i/eQ04qDNRlL9vbCP6yDykGTk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754650866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=GiYacIpSaIr1+KNAsiQt2NAsD2PhV7wCNKkQMd01jCg=;
 b=ApwTsFUZeNugzrD7T4jaezshYusLHSPwGXVJVEltK36F6K8BwQ6ksfhBurjxGd0vdPunD+
 b+jkcee17kMPT6CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69C1A13AB6;
 Fri,  8 Aug 2025 11:01:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g2+mF/LYlWgHcwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 08 Aug 2025 11:01:06 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri,  8 Aug 2025 13:00:59 +0200
Message-ID: <20250808110102.454689-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Rspamd-Queue-Id: 9AD3833E26
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:dkim, suse.cz:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/3] autotools: Remove old checks
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

Changes v1->v2:
* Fix compilation error missing endif

Link to v1:
https://patchwork.ozlabs.org/project/ltp/list/?series=468404&state=*

Petr Vorel (3):
  Remove m4/ltp-signalfd.m4
  m4: lapi: Drop check for old libcap-devel
  m4: fcntl31: Remove check for struct f_owner_ex

 configure.ac                              |  2 --
 include/lapi/capability.h                 |  8 --------
 m4/ltp-cap.m4                             | 17 +----------------
 m4/ltp-fcntl.m4                           | 21 ---------------------
 m4/ltp-signalfd.m4                        | 17 -----------------
 testcases/kernel/syscalls/fcntl/fcntl31.c |  8 --------
 6 files changed, 1 insertion(+), 72 deletions(-)
 delete mode 100644 m4/ltp-fcntl.m4
 delete mode 100644 m4/ltp-signalfd.m4

-- 
2.50.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
