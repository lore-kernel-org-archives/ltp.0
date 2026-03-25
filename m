Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0471093168
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 14:20:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96CDC3E2FFE
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:20:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E8BC3E5ABE
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:19:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E5B19600352
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 15:19:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 130FD4D247;
 Wed, 25 Mar 2026 14:19:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774448353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qd9USSaLwKw8JBY+BUp/EnC6PBG415vIiz0uu2gCUdQ=;
 b=lb6PEE+eYX8FdLoIv1q/9NuAtYq4+URYtq85oz74aNBVh4ZgOnjrYGjDshrjB5N4zYJtdk
 nulPcgY7OFiWlJF3lk4fUa5v5UfGD7AgBG07LJaOVa0LGRgp7CVCM+6yhH++qLQhW/wxfu
 q7OlnIMJafzcezRtk5rwSzXBq+rUg+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774448353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qd9USSaLwKw8JBY+BUp/EnC6PBG415vIiz0uu2gCUdQ=;
 b=t543PEtcX+MSRplX+YF7o7XB8v9/6YMkWinlKCqBkS2rXQgxEF96aWrWZcq9l/Ozca9erx
 ixxfXI0S7CHjn4CQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GuqB1fBm;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ImPyhavq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1774448352; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qd9USSaLwKw8JBY+BUp/EnC6PBG415vIiz0uu2gCUdQ=;
 b=GuqB1fBm+/r5ebtnrux86q9McRqTVEV7+OipRS9ULrrLRXPoeG/OIjDPFHYNQZbMwpNFjr
 24Goq0I0hi4YeHwJ8woQI7S1YmGY9oxs3w29RP8AIj2l1wcIUHZZGhLEwn5SgjNEETe6GG
 2cfiK2AjtRCBLY1d2XGyBpeVBsAOoS4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1774448352;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qd9USSaLwKw8JBY+BUp/EnC6PBG415vIiz0uu2gCUdQ=;
 b=ImPyhavqhcLm5lWGeEUpUB6Weo5S6Z+g2wjOlhqG197iIShs6Iw6uKYn6q1jz48T0P+2Ag
 6C61LY2v19KvNpAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB84E4443C;
 Wed, 25 Mar 2026 14:19:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iqjCN9/uw2nQPQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 25 Mar 2026 14:19:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 25 Mar 2026 15:19:09 +0100
Message-Id: <20260325-ioctl_getlbmd01-v1-0-00dc526e326f@suse.com>
MIME-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAN3uw2kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDYyNT3cz85JKc+PTUkpyk3BQDQ10zoyTTxCQz0xQz4zQloK6CotS0zAq
 widGxtbUA5FTgRWEAAAA=
X-Change-ID: 20260325-ioctl_getlbmd01-62b5ab65d63f
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774448351; l=718;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=KRAEU2r7IjFL63qvy/8UY+nufaD788yTRrA8X9fODOY=;
 b=6XDUQTl3fW287l/gjw+9z0Yagr9jx1B5RXG0uItddeqgJYT31AsJuX4bhEk6MQxb0DURfZA9P
 IeHRcqMNfOFC0NdmfqO2OMq/x/8R7dYKRVzJks/2Bgyxp8E/qqbMk//
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 URIBL_BLOCKED(0.00)[configure.ac:url,suse.de:dkim,suse.com:mid,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:mid, suse.com:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 130FD4D247
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] New test for ioctl(FS_IOC_GETLBMD_CAP) feature
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
      Add logical_block_metadata_cap struct fallback
      Add new test ioctl_getlbmd01

 configure.ac                                      |  2 +
 include/lapi/fs.h                                 | 21 ++++++
 runtest/syscalls                                  |  2 +
 testcases/kernel/syscalls/ioctl/.gitignore        |  1 +
 testcases/kernel/syscalls/ioctl/ioctl_getlbmd01.c | 84 +++++++++++++++++++++++
 5 files changed, 110 insertions(+)
---
base-commit: b874b6a264cf4f343c17d543ebe4ff91fbb89042
change-id: 20260325-ioctl_getlbmd01-62b5ab65d63f

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
