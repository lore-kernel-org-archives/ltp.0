Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8828C44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:39:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23EBA3E569A
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:39:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 560143E1766
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:39:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A550E1000521
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:39:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F08FB3DF5;
 Wed, 15 Jul 2026 11:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784115571; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krafxN6wUXr3WLHe3l+zOozsElMJtmQb7uJz2fhGBSQ=;
 b=SWxRtAaosGsZb4O0CyKDNz8wbzAXbZOKIXor1B87uDvI6wKkCYm4ReB+khrf4klBi6j1u3
 UYWpMfmqZlFJGa9ZM+/ZfmcRNbL/vIwt9s8FbQyF+JnJyPaoVLP3NiHm3YP+ffhjcmlu0F
 07m7q42kAhSDNkxsq+eZ/HsYNvOUDW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784115571;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krafxN6wUXr3WLHe3l+zOozsElMJtmQb7uJz2fhGBSQ=;
 b=WYl76D1qe8IQq4DqltJq0bb2H04A3kpg+6o4isTvhsrQnxsMghc/+hwhPb5RrwEVZiK3ND
 Mtk99gpdUFUViVDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Kz2NhQFh;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ddgWPuzw
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1784115570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krafxN6wUXr3WLHe3l+zOozsElMJtmQb7uJz2fhGBSQ=;
 b=Kz2NhQFhLW+5910mELgc0/cnumr1mrsdPMAc9IO5xN8ARBlXiHAXDANUC2KS8Tt0f5RrWG
 HBWeEaJendL5CDbzB9NmIgZ2B5QN5lf+iPRH2Q7Xfn2UuvOrqkaiAbkmLXMxfTD/AMpYiF
 OkW+4KuUse30faUr/k15l36QTqkufBE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1784115570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=krafxN6wUXr3WLHe3l+zOozsElMJtmQb7uJz2fhGBSQ=;
 b=ddgWPuzwBeevfOTdlzXhz3nnJWnQH8PI4FkorgQ+sVwwizohkp9HYM0QQ+pQ9t3QkCqqgi
 oMTOUoE2UewHEyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5172779AD;
 Wed, 15 Jul 2026 11:39:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LJxUMnJxV2qHIgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 15 Jul 2026 11:39:30 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 15 Jul 2026 13:39:25 +0200
Message-Id: <20260715-hugemmap35-v1-0-1d5911d1f2cf@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAG1xV2oC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDc0NT3YzS9NTc3MQCY1PdtJRkEwuT1FSTpKQ0JaCGgqLUtMwKsGHRsbW
 1AM1lbJNcAAAA
X-Change-ID: 20260715-hugemmap35-fdc484ee4bbf
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784115570; l=656;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=WqyxKnUXPXihAx5Qj4JL1L4YMklDGXao6txcJOPiGH4=;
 b=wWQRWEX1z7K1goaZHyBLBwQFfbbLWbJtANvfwI5T7tSbv+uZcM9Z9SsuniOfwCM0H+6wygTwW
 n1QPD0zr5g7C+mqeP4ho3cPCfWrvw4v0wwPmNNMvW/BRpw7HK9W8we5
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: F08FB3DF5
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Regression test for 49ccf2c3cafb
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
Andrea Cervesato (2):
      lapi: add PROT_MTE fallback
      hugemmap35: add regression test for 49ccf2c3cafb

 include/lapi/mman.h                                |   4 +
 runtest/hugetlb                                    |   1 +
 testcases/kernel/mem/.gitignore                    |   1 +
 testcases/kernel/mem/hugetlb/hugemmap/hugemmap35.c | 105 +++++++++++++++++++++
 4 files changed, 111 insertions(+)
---
base-commit: d139524b04d360c4dabaee61a6066a9a52b0e454
change-id: 20260715-hugemmap35-fdc484ee4bbf

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
