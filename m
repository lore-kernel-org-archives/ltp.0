Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D466910F2861
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 17:35:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 012D43DB86E
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 18:35:02 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 038113D8BAE
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:44 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 547746021A6
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 18:33:43 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C77AF5BD4A;
 Fri, 27 Mar 2026 17:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xy4BAawfnAMIpAvKSsvGZajf3Re2isRKVR1Dx8H4VEY=;
 b=ItToJ4dkr+0iUJaEpIaoOAcTZeYOirZ1CmKEUCyJ3ikaZvyBkzB6Lq3gnLF7l3dxnj0SsY
 OzmC3QcijAd0Kkud7eX0c/O4H33pawb4/eEC/RFI41t+eHr+04dFk1aix89Jsp/L9SJHGP
 ZbljFZYYI+DHJZaTKR8/lZqI+XdYB7o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632807;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xy4BAawfnAMIpAvKSsvGZajf3Re2isRKVR1Dx8H4VEY=;
 b=rUkVuDeCVvgxOXWbuPuj9773kSjbS14FBn6a6u2A+O/eyvbFbwdfVOU0m8C2Nmz24aVChS
 xOInwlrw2wKuFUBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=V+YTBDaj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="DzxG/AFl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774632806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xy4BAawfnAMIpAvKSsvGZajf3Re2isRKVR1Dx8H4VEY=;
 b=V+YTBDajrv8QNZebWT7nZYTSqIVQUXY/p+eRSZoQwRrQkL60Xlp4pLEd8wNi3PIS0CrT8n
 Q3NHSE3Xx9k6W2AaDqGGZ8Yer0yRiFEVx3CVvtXQYoymQoclw07SEfso6o8iol2ZiWFHeV
 s2A4k1rsIVOeLzaH2KmBTQIjiv2xueE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774632806;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=Xy4BAawfnAMIpAvKSsvGZajf3Re2isRKVR1Dx8H4VEY=;
 b=DzxG/AFlKz0R9mThkG7R3iLn3BF6wgcZzBT2hdZmwH+LFjHg4sTzFTyvxmMsgy8si20k2a
 4j+Vbzq/bQvAg8CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 953B94A0A2;
 Fri, 27 Mar 2026 17:33:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L6vWIma/xmm0DgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 27 Mar 2026 17:33:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 27 Mar 2026 18:32:48 +0100
Message-ID: <20260327173252.1112192-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: C77AF5BD4A
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 0/4] lib: LTP_DEBUG cleanup
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
* C cleanup (tdebug_env[0] != '\0' => *tdebug_env, thanks Li)
* Simplify -D code (Li)
* New commit "doc: newlib_tests: Update debugging parameters"

Link to v2:
https://patchwork.ozlabs.org/project/ltp/list/?series=497627&state=*
https://lore.kernel.org/ltp/20260327154603.GC1092845@pevik/T/#t


Petr Vorel (4):
  lib: Ignore empty LTP_ENABLE_DEBUG
  lib: Rename variable LTP_ENABLE_DEBUG => LTP_DEBUG
  lib: Prefer LTP_DEBUG over -D
  doc: newlib_tests: Update debugging parameters

 doc/developers/debugging.rst     |  6 ++++--
 doc/old/C-Test-API.asciidoc      |  4 ++--
 doc/users/setup_tests.rst        |  4 ++--
 lib/newlib_tests/tst_res_flags.c |  2 +-
 lib/tst_test.c                   | 33 +++++++++++++++-----------------
 5 files changed, 24 insertions(+), 25 deletions(-)

-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
