Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D92EAC5B56A
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 16:29:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 55EB73CFF65
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 18:29:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 11BA33CF68D
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:28:39 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EC4191A00708
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 18:28:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CAEDF80E88;
 Mon, 10 Aug 2026 16:28:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786379313; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lAefr5KnglyTMw4b9uXdn9ZWz0HVGszXDafhmjNdq6k=;
 b=ve4IIjyF6u400Trlak+gNJixguI1JwjjHZqOd+LZD1C7n8JaoYg2VAo/xmwokDaibEQFqG
 Z4TMKUhQ1Q2JtrcDzihYFo9Rjz8RMKwcBSrt5lga4EttKdgNe2QhIF7fxXPq1zatuNN0EX
 /CrZuxL2Qdzgnjmth+CH5vjfo59601k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786379313;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lAefr5KnglyTMw4b9uXdn9ZWz0HVGszXDafhmjNdq6k=;
 b=ltmVoqIApsmklbp8GCRAuQhbOQ0aptesfIM2TcTsDgS8ESYm81j/LOedgwGLaVJ4G0ppfA
 cpYcmdQvDFm/5hAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=qeIfm4T4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=dW8ol2qc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1786379309; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lAefr5KnglyTMw4b9uXdn9ZWz0HVGszXDafhmjNdq6k=;
 b=qeIfm4T45ESN7qxoaOpC6G1RoAyeemzP8E0+RwquPHA7e6rT3P9ILWRImqjZxcH1Z9GEr3
 WI6Ye+vaAeJo8HvD9x/QgWNsiikdFEEj5pQgk8cCBtlX325rxyPvbAUuuhdmB/ybixR/qY
 JYkMwTMwyTZF4yLCAPSOR+FtT7i/8Ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1786379309;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=lAefr5KnglyTMw4b9uXdn9ZWz0HVGszXDafhmjNdq6k=;
 b=dW8ol2qcV67ahXpGzZ3ojzUbXhFPReSDlFT/N8RefU0ceVna5/WFuQiEsNwdjz1Hcbsa8d
 AUi7Dch289alfEDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A864779B2;
 Mon, 10 Aug 2026 16:28:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id s5EGIi38eWrHRgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 10 Aug 2026 16:28:29 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 10 Aug 2026 18:28:27 +0200
Message-Id: <20260810-sctphantom-v1-0-f8e9ee72a648@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIACv8eWoC/yXMyw5AMBCF4VeRWWtSdfcqYlE1GIlLOiUS8e6K5
 ZeT81/AaAkZquACiwcxrYtHFAZgRr0MKKjzBiVVJotICjZu84NbZ9GlWqukLOIec/CHzWJP5xe
 rm9+8txMa9xbgvh/bSkafbgAAAA==
X-Change-ID: 20260810-sctphantom-d5aa24983fe7
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786379309; l=833;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=UyJxoZNU0pX63r74+HEtVQQFwlVBnjuw+hgLMEdK5q8=;
 b=9bZQj6hqtSvk6YpsN3iqaO1Iz37aGvZHDHuhdGtRrwcCba0lwCNVEss3OV3J5LFUsiEWKw4Jv
 dRIdeY41iqQDPSV78QrucsvwKGGh9l7X4w66jHylAKIY9lTJlxaxGFs
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CAEDF80E88
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:url,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Add reproducer for sctphantom CVE
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

This reproducer has been created using Kimi K3 and tweaked by human to
match LTP standards. The link which has been used to generate the test
is the following:

https://matrix.tencent.com/en/2026/08/06/sctphantom-CVE-2026-64564

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (2):
      sctp: add lapi fallback definitions
      cve/sctphantom: Add reproducer for CVE-2026-64564

 include/lapi/sctp.h        |  65 +++++
 runtest/cve                |   1 +
 testcases/cve/.gitignore   |   1 +
 testcases/cve/sctphantom.c | 594 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 661 insertions(+)
---
base-commit: 13c2bbab1d71384c10c368c2c2b6e5747eeb5018
change-id: 20260810-sctphantom-d5aa24983fe7

Best regards,
--  
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
