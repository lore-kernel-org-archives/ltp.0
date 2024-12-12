Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 731F6E77180
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 10:33:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE9FC3E8897
	for <ltp@archiver.kernel.org>; Thu, 12 Dec 2024 11:33:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 43A4F3E8891
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 11:33:12 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C1D26396EF
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 11:33:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1BFBF1F445
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733999590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wx/Wu/CIvC/lSJeN+NKBCxAufMv9SmHk/4GW7Xnb+5k=;
 b=bMF+jFTugWEJUsX5nfvr/59QSe+9zKBQg9hm4OIKJxE1+ZT8OzzasnE9VDWl3PwwwAtCzC
 Rj0F82qcUEJLSla9G9LM+i0knurngpy2TgAK+rNOjojXJz4Gfjr7DhNrlB/79koQ8Ijjjj
 xFbv1lKuu4TQkINJ+OmsrBOd1Ib0ibg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733999590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wx/Wu/CIvC/lSJeN+NKBCxAufMv9SmHk/4GW7Xnb+5k=;
 b=dYfZIilg4l7amMvgr5bmeThIOv5WgCo3UYimKdWUXZCw/xaeep+DOazFIZHaCZWvTCkxWn
 a63+81QbGFgi//Ag==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bMF+jFTu;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dYfZIilg
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1733999590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wx/Wu/CIvC/lSJeN+NKBCxAufMv9SmHk/4GW7Xnb+5k=;
 b=bMF+jFTugWEJUsX5nfvr/59QSe+9zKBQg9hm4OIKJxE1+ZT8OzzasnE9VDWl3PwwwAtCzC
 Rj0F82qcUEJLSla9G9LM+i0knurngpy2TgAK+rNOjojXJz4Gfjr7DhNrlB/79koQ8Ijjjj
 xFbv1lKuu4TQkINJ+OmsrBOd1Ib0ibg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1733999590;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Wx/Wu/CIvC/lSJeN+NKBCxAufMv9SmHk/4GW7Xnb+5k=;
 b=dYfZIilg4l7amMvgr5bmeThIOv5WgCo3UYimKdWUXZCw/xaeep+DOazFIZHaCZWvTCkxWn
 a63+81QbGFgi//Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D8A2D13939
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dmkbLuW7WmcuJAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>)
 for <ltp@lists.linux.it>; Thu, 12 Dec 2024 10:33:09 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 12 Dec 2024 11:33:06 +0100
Message-Id: <20241212-doc_syscalls_link-v1-0-69a916958ba9@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAOK7WmcC/x3MQQqAIBBA0avErBPUFKqrRITZVENi4UAU0d2Tl
 m/x/wOMiZChLR5IeBLTHjNUWYBfXVxQ0JQNWmqjtDRi2v3AN3sXAg+B4iacqo01tqqb0UHujoQ
 zXf+z69/3A65USMJjAAAA
X-Change-ID: 20241204-doc_syscalls_link-a184545389ba
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733999589; l=739;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=Q7T0yYz31YLwrQ38mWFmcCecsXUHTbfIEUH4DqXzEFc=;
 b=UVTXU7HhxIp6errKOuFGOI53DwtjQWHLlGPRd9CgHZl1CsQj54ABi6HQWI6/4q9hJMWgVLTLn
 vr+HiyE6kFBALD8yZoKMoIhDbgl+Nvt+MvuB1GyCbEjhAnPmZVQwl4T
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 1BFBF1F445
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_ONE(0.00)[1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] doc: support for links in syscalls
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

This is an optimization of the documentation, which adds a bit of
refactoring and clickable syscalls names inside the statistics table.
In this way, users can click on a syscall and being redirected to the
source code which is testing it.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      doc: cleanup conf.py script
      doc: support for clickable syscalls under stats

 doc/conf.py | 158 ++++++++++++++++++++++++++++++++++--------------------------
 1 file changed, 91 insertions(+), 67 deletions(-)
---
base-commit: 8f2292af050fd64c447dd462880d0b0a19d79448
change-id: 20241204-doc_syscalls_link-a184545389ba

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
