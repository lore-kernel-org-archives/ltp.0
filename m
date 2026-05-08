Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89A0CD3436
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 09:18:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 536273E2874
	for <ltp@archiver.kernel.org>; Fri,  8 May 2026 11:18:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3122C3E2463
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D80DF1400209
 for <ltp@lists.linux.it>; Fri,  8 May 2026 11:17:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D19A95CFC6;
 Fri,  8 May 2026 09:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FiZJAdSgTnsjMwFfBr5AGs9MSzs0pybPjM2CBvloyqo=;
 b=gnANQ+Wk3aeJtROgf2AEhEXqJBfNosQB82XLOsYnSCCjG8DnHqavEQgbBLhiROL5yhnBSl
 sDIx9gVpESLzg0fd+fg4VuKuM20fR1rQQZurjw6qksEC50B3j1ldoadKESmJeOeszcQClc
 uTNKqPXy7wN00TBkyLPfNqydhmLvC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FiZJAdSgTnsjMwFfBr5AGs9MSzs0pybPjM2CBvloyqo=;
 b=0nWE4DbOyJ1wlTzu3Qrfzy9gwVhIJitt+3oBokCSSlXsz8WLMyAai3qlh6+Z0hzmSlgDlE
 KkFwnLJetIZyFLAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778231855; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FiZJAdSgTnsjMwFfBr5AGs9MSzs0pybPjM2CBvloyqo=;
 b=gnANQ+Wk3aeJtROgf2AEhEXqJBfNosQB82XLOsYnSCCjG8DnHqavEQgbBLhiROL5yhnBSl
 sDIx9gVpESLzg0fd+fg4VuKuM20fR1rQQZurjw6qksEC50B3j1ldoadKESmJeOeszcQClc
 uTNKqPXy7wN00TBkyLPfNqydhmLvC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778231855;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=FiZJAdSgTnsjMwFfBr5AGs9MSzs0pybPjM2CBvloyqo=;
 b=0nWE4DbOyJ1wlTzu3Qrfzy9gwVhIJitt+3oBokCSSlXsz8WLMyAai3qlh6+Z0hzmSlgDlE
 KkFwnLJetIZyFLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B8F49593A7;
 Fri,  8 May 2026 09:17:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XbKgKS+q/WnsCAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 08 May 2026 09:17:35 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 08 May 2026 11:17:33 +0200
Message-Id: <20260508-cve-2026-43284-v1-0-bf2549d2430d@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAC2q/WkC/x3MQQqAIBBA0avErBsw05KuEi1smmo2FQoSSHfPW
 r7F/xkiB+EIQ5UhcJIo51HQ1BXQ7o+NUZZi0Ep3yiqHlBg/oGm1M2h6S64j8pZmKNEVeJX7H47
 T87wVY9GZYAAAAA==
X-Change-ID: 20260508-cve-2026-43284-475c86cca5cb
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778231855; l=730;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=3MVVYiwqnvf3uQvBdchJp6EuMQkc0HBcmJMj1baXV8o=;
 b=Sq/+Q+0i7Of7dFiyfW2gItKkuTucLFqySNp/ZfM/osk8a8fzHEueq5eNCBLZN7vNI9ouTQZ9G
 1IaqFqEtHQuBuCGNrwOnllzybJwEbq7VPc0HV0NxFMvEprU/MblEKrA
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.com:mid]; 
 TO_DN_ALL(0.00)[]; FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/3] cve-2026-43284 reproducer
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

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Andrea Cervesato (3):
      lapi: fallback SPLICE_F_MORE
      lapi: fallback UDP_ENCAP and UDP_ENCAP_ESPINUDP
      network/sockets: Add xfrm ESP page cache corruption test

 include/lapi/splice.h                |   4 +
 include/lapi/udp.h                   |   8 ++
 runtest/cve                          |   1 +
 testcases/network/sockets/.gitignore |   1 +
 testcases/network/sockets/xfrm01.c   | 246 +++++++++++++++++++++++++++++++++++
 5 files changed, 260 insertions(+)
---
base-commit: d8554ef84261ad7e76a86d8a47cfe7807676e74f
change-id: 20260508-cve-2026-43284-475c86cca5cb

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
