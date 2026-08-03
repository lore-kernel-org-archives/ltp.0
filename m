Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 031C9C55175
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 08:10:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10A393E29A8
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:10:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 370113E1524
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:10:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C0A4D2001DB
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 10:10:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEA6B43FF;
 Mon,  3 Aug 2026 08:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785744610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqNbuzJefmF9viG/uAjQ1DXIr5Zs4g1T6ceYZbhmQgI=;
 b=adMqKfEGrpbafmabVr/78SJjSz+XiGZDFlCdpZ2rbOKaPLSFsfuggALX3XhJsQK69zDhDT
 hunGWnv2aTtcb21RgecNYyiKbR0BTMJL/3BNJgD3bX4WcVv7S/bt3xWuhJAHpLCboQjhvj
 8UQt8tYKbCp1dOpRczBW4mG1LB37SNY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785744610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqNbuzJefmF9viG/uAjQ1DXIr5Zs4g1T6ceYZbhmQgI=;
 b=41iUwzFedw+1XZvtXGdvGvkvqmiJ17YUEbFL33SgpfkjC0nlB13wxgJ2m0ZLpRvC0gV8SZ
 zap+6W50XRcnF8Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=XOoG1Of7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=oCleYbwl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1785744605; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqNbuzJefmF9viG/uAjQ1DXIr5Zs4g1T6ceYZbhmQgI=;
 b=XOoG1Of7SD4N5gbFacAwvQ0zIBdCiGx/G8mqKOQASs7TelcbhwTABuyWtGMJxRYtW+GKeq
 RHyzzlqI/UeVQK/4jVo1gBqFijOj0rRptyRk6tVVPgRrK1T/HJDGcFZeZYbiT9X/4mWOQg
 OqwrktogxoceNpG7nqvK+bohaKFdZ2s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1785744605;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TqNbuzJefmF9viG/uAjQ1DXIr5Zs4g1T6ceYZbhmQgI=;
 b=oCleYbwlDyl8eDz14xrQHZCa2H3rbAtXLp73c1qY/NSbkhH1T5G6Rt8V2E49WtLKlSvn6m
 i8TcfpjxTJHgE8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3F34779D3;
 Mon,  3 Aug 2026 08:10:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UprVMd1McGpJTQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 03 Aug 2026 08:10:05 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 03 Aug 2026 10:10:03 +0200
Message-Id: <20260803-cve-ghostlock-v2-0-b60588853140@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIANtMcGoC/3XMQQrCMBCF4auUWTuSBElTV95DutB00gxqI5kal
 NK7G7t3+T943wJCmUng2CyQqbBwmmqYXQM+XqaRkIfaYJSxyimNvhCOMcl8T/6GluhwNcF2YbB
 QP89Mgd+bd+5rR5Y55c/GF/1b/0lFo0Ldumq50LXKnOQltPfpAf26rl9CVSVDqQAAAA==
X-Change-ID: 20260801-cve-ghostlock-6ee4b2f69fd6
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785744605; l=1322;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=73OUzX+J1py3AjxKYIKB6UfjpESJWzMNSB2QSbi1O94=;
 b=tGbOhXzymUr9EFSQMMRX3F+ti1e4BKqvzvh7b6KHNoul8r57WGSz9iIhl15o+Ztbi4pH86p3H
 GdMDfAHM6EsALcaKhuWgVCyL5So85GL4dtRzU+TpShm0lnYx0m8Im9j
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: EEA6B43FF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim]; ARC_NA(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 URIBL_BLOCKED(0.00)[nebusec.ai:url,suse.com:email,suse.com:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] Reproducer for ghostlock
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

Test for CVE-2026-43499 (GhostLock), a stack use-after-free in the
rtmutex PI code, fixed in kernel v7.1:
3bfdc63936dd ("rtmutex: Use waiter::task instead of current in remove_waiter()")

Reproducer based on the Nebula Security writeup and open-sourced PoC
(https://nebusec.ai/research/ionstack-part-2/, https://github.com/NebuSec/CyberMeowfia).
Beware, this test will crash the system on a vulnerable kernel.

Assisted by Kimi K3 for the analysis and written mostly with Gemini Pro
3.1 Max.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- fix build
- fix 32bit run
- Link to v1: https://lore.kernel.org/20260801-cve-ghostlock-v1-0-178f698f9702@suse.com

---
Andrea Cervesato (2):
      lapi/prctl: add more fallback definitions
      cve: add CVE-2026-43499 reproducer

 configure.ac              |   2 +
 include/lapi/prctl.h      |  25 +++++
 runtest/cve               |   1 +
 testcases/cve/.gitignore  |   1 +
 testcases/cve/Makefile    |   2 +-
 testcases/cve/ghostlock.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 282 insertions(+), 1 deletion(-)
---
base-commit: 6891f922f21a56238d3225c9a83e08f4f7c1765b
change-id: 20260801-cve-ghostlock-6ee4b2f69fd6

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
