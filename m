Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15A31D58090
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 12:20:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D51E3DAAC9
	for <ltp@archiver.kernel.org>; Mon, 25 Nov 2024 13:20:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 666203DAAC3
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 13:19:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F222A1BD5719
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 13:19:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D96232118F
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 12:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732537139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cs/OkwUv/f10fdj5WKt8sLzWhmtIzmiQJ9ZmhlFSCxI=;
 b=jXQLeymEl+zujRt59QCwj0n3ogq6HnX1P+vu8IZDYBmon3bWUUneEtvNgHcY/5hVT1QdTc
 VhPQwyk/Sz5EZgJkSoBiNHzWfFd01Frj5dNgrgDqxEyPNbXVk6JHxVF3GNZoAXFKBWOLnw
 Nyl/IEx0ugKkzCNdvTp51HEWo1dgr2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732537139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cs/OkwUv/f10fdj5WKt8sLzWhmtIzmiQJ9ZmhlFSCxI=;
 b=jN+a34tS37ZGFL448YR3cWUcq0cSLBDUQ7EpsULmNHQiW5cG7BvJGlF8dHauYeUcXmMdpL
 F8IbEFGo9qNAq0BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=jXQLeymE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=jN+a34tS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732537139; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cs/OkwUv/f10fdj5WKt8sLzWhmtIzmiQJ9ZmhlFSCxI=;
 b=jXQLeymEl+zujRt59QCwj0n3ogq6HnX1P+vu8IZDYBmon3bWUUneEtvNgHcY/5hVT1QdTc
 VhPQwyk/Sz5EZgJkSoBiNHzWfFd01Frj5dNgrgDqxEyPNbXVk6JHxVF3GNZoAXFKBWOLnw
 Nyl/IEx0ugKkzCNdvTp51HEWo1dgr2U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732537139;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cs/OkwUv/f10fdj5WKt8sLzWhmtIzmiQJ9ZmhlFSCxI=;
 b=jN+a34tS37ZGFL448YR3cWUcq0cSLBDUQ7EpsULmNHQiW5cG7BvJGlF8dHauYeUcXmMdpL
 F8IbEFGo9qNAq0BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B3ED413890
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 12:18:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mevtKDNrRGepGwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Mon, 25 Nov 2024 12:18:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 25 Nov 2024 13:18:56 +0100
Message-Id: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIADFrRGcC/x2MQQqAIBAAvyJ7TmgzKvpKRFhtthcVrQjEvycdh
 2EmQaTAFGEUCQI9HNnZAlgJ2E5tDUneC0NTNy0iKsnW39cS6NDb5QJbI7HTpFHR3q8DlM4Xye/
 /nOacP7L1slxjAAAA
X-Change-ID: 20241113-input_refactoring-16aea13ed7b8
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732537139; l=1394;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=uT2qXALobW4CvXVfarS4iGv6QSmRAjy6uY0GnMilePg=;
 b=YRD9y+dgc5KWLUDoZlqWGZ0gnK2VqEf1PUTgEXR/ZfbNl6r6qixr4lOLP3ZkBmNMxxihJH69s
 BnvPArs2vP2CZx9HMsfhf5XlxsHXcrlwECH4N1Z6liRTcQDfgTMGwYA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: D96232118F
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/7] Rewrite input testing suite
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

Cleanup of the input testing suite, using new LTP API and changing
the way we are obtaining information from input devices.
Usage of the tst_uinput.h utilities, rewritten input helper and
simplified the source code.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (7):
      Refactor input01 test
      Refactor input02 test
      Refactor input03 test
      Refactor input04 test
      Refactor input05 test
      Refactor input06 test
      Delete depreacted input test suite helper

 testcases/kernel/input/Makefile       |   6 +-
 testcases/kernel/input/input01.c      | 205 +++++-----------------
 testcases/kernel/input/input02.c      | 132 ++++++--------
 testcases/kernel/input/input03.c      | 174 ++++++++-----------
 testcases/kernel/input/input04.c      | 113 ++++--------
 testcases/kernel/input/input05.c      | 119 ++++---------
 testcases/kernel/input/input06.c      | 190 +++++++++------------
 testcases/kernel/input/input_common.h |  97 +++++++++++
 testcases/kernel/input/input_helper.c | 313 ----------------------------------
 testcases/kernel/input/input_helper.h |  36 ----
 10 files changed, 415 insertions(+), 970 deletions(-)
---
base-commit: ec4161186e51b55d4faaa394dc4607200cb30f68
change-id: 20241113-input_refactoring-16aea13ed7b8

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
