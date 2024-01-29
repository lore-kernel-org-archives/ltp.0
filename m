Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5ACC47DB3
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 17:47:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DEA23CF9CA
	for <ltp@archiver.kernel.org>; Mon, 29 Jan 2024 18:47:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 334683CA76F
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 18:46:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D84A9600EA3
 for <ltp@lists.linux.it>; Mon, 29 Jan 2024 18:46:53 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DFB521F7F8;
 Mon, 29 Jan 2024 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706550412; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KtkTSsnWfBVKQ8GVFmZAtsxGjYrHvHXW/Nwm/Hpbcj8=;
 b=YSTEixJu1QbNZd1+dz5GeX25DBl0sBMiLu5W7I9M4M8ASzDRToL/OKjzjmvAuBaEPX4nsS
 HH648A6FHx97sob9NkIqq9Xb4TDQokF56bXqW+B5Bfdll097P8xckaYabNwdhFsM3tDBb7
 jHLb+uLzlSBiHHrf52HvbTm0xr9QGNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706550412;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KtkTSsnWfBVKQ8GVFmZAtsxGjYrHvHXW/Nwm/Hpbcj8=;
 b=g8atCoxq4SP01HcJDPdlnHP5Cca2QU6Kw8rntv8SzJrKE7bf3z1xxvEYDcNRPcwS4R36xf
 CrRAyhF/bEGZoOCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706550410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KtkTSsnWfBVKQ8GVFmZAtsxGjYrHvHXW/Nwm/Hpbcj8=;
 b=iT/Uri1BAKKK2nCtpT9wmUqQah8uAc6nLelL4qq8E0zCJDQMFfTRVNBb2RwYzT8QO2gimU
 d5lHvRU5C9ASm4re3qMe+K2Fb9o/HMWqmvp0bK0YJyG9S0kkuBhQBZJKu0P2EIARQMceB7
 cEwXHB3mMdZpWLgBfuHhdl4uslAtQYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706550410;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KtkTSsnWfBVKQ8GVFmZAtsxGjYrHvHXW/Nwm/Hpbcj8=;
 b=iXzuxcs4Ih8J5WvzKxsshdIq1wDpR9F12duRh4PasG16orFzjrsd27Y4gkHk4rOcWYpCA4
 T3jXmndoQn1W2dBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B11EF13911;
 Mon, 29 Jan 2024 17:46:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id oB8YJorkt2ULOwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jan 2024 17:46:50 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 29 Jan 2024 18:46:47 +0100
Message-ID: <20240129174647.635944-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="iT/Uri1B";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=iXzuxcs4
X-Spamd-Result: default: False [4.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MID_CONTAINS_FROM(1.00)[]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url,opensuse.org:url,readme.md:url,suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[16.16%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: DFB521F7F8
X-Spamd-Bar: ++++
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] README: Mention -f param for strace
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

probably obvious, but it does not harm to mention it.
Hopefully users will find it.

Kind regards,
Petr

 README.md | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/README.md b/README.md
index 6147c5f6f..abbea8f4f 100644
--- a/README.md
+++ b/README.md
@@ -215,12 +215,13 @@ SUSE also publishes a
 [smaller LTP container](https://registry.opensuse.org/cgi-bin/cooverview?srch_term=project%3D%5Ebenchmark+container%3D.*)
 that is not based on the Containerfile.
 
-Debugging with gdb
-==================
+Debugging with gdb and strace
+=============================
 
 The new test library runs the actual test, i.e. the `test()` function in a
 forked process. To get stack trace of a crashing test in gdb it's needed to
 [`set follow-fork-mode child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html).
+To trace test with strace use `-f`.
 
 Developers corner
 =================
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
