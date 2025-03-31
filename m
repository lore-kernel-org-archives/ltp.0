Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F571C36011
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 08:16:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 337173CAB50
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:16:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AC6B3C1D37
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:16:07 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 31F2A600CE2
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:16:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE941211D7;
 Mon, 31 Mar 2025 08:16:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743408964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wF/xzxcX8O0v4TzOFFSy+LRZSFPqSJxoK5Op1E/gMgs=;
 b=sVYj6RMbFDOE+axeXM1DYZk+vRW2v9kVE+gXpa6hTrPwnsW5mYyBXgYoQrPsFR0KeG81zz
 1JY3ttjDBME4MfEfeT7/GccM51r6kX00FOsOtTaa30QIfayD5yr+wWI9QQ6LaVJQdx+naM
 IaGygYSUbtzUja5VDORROkCQ6bkEC20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743408964;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wF/xzxcX8O0v4TzOFFSy+LRZSFPqSJxoK5Op1E/gMgs=;
 b=H1hVpV+LxIevPNBbw2Zs1jnpk2a9zlF8mjo1Rbwv81BwJRJnm1ZKI2owWf6TgLCfcMWoxE
 EayJeUaw/y5uSUCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743408963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wF/xzxcX8O0v4TzOFFSy+LRZSFPqSJxoK5Op1E/gMgs=;
 b=DOU0PYgFEnkBHyY390Vov/9U5+MyENGZA11/Nj4+NOzzZ0p0xo9wHf0m716vo6ctORTjvT
 NL8/9dT4hA07Q5ymYVehI09IZE0T6ifCsAnWhDjHI+Ns8xs7K0ufqSbV7P4u6CgaJwrylY
 ZtARzBZ2zhO0FnLMgPfaTS5Qwj0ePJM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743408963;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wF/xzxcX8O0v4TzOFFSy+LRZSFPqSJxoK5Op1E/gMgs=;
 b=S+RK7stA9lqsnRz+766li1ciDoxOT6uCNIkAIwE8zR9z8YKdH29lnCZB9Xzpw1uJV6DPlX
 l6RuQH23GGfScrAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7EDF6139A1;
 Mon, 31 Mar 2025 08:16:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Y79oEkNP6md9OAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 31 Mar 2025 08:16:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Mon, 31 Mar 2025 10:15:59 +0200
MIME-Version: 1.0
Message-Id: <20250331-fix_fanotify_i586-v1-1-4f9edd380d00@suse.com>
X-B4-Tracking: v=1; b=H4sIAD5P6mcC/x2MWwqAIBAAryL7neAD7XGVCIlaa38sNKKI7t7S5
 8DMPFAwExboxAMZTyq0JQZdCZjWMS0oaWYGo4xT1moZ6QpxTNtB8Q7kGi+x9Yh2Vt7UDrjbM7L
 0P/vhfT/JmnTFYwAAAA==
X-Change-ID: 20250331-fix_fanotify_i586-e96ee3d06275
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1743408963; l=1330;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=QCQCIqQOwe3cr3XzOaIAH7S54Tn0MKMuyWd6FtdVqZo=;
 b=//vxCL6Pk7Ldznlgu4WFDmrflH/xmtzI92PcasbWitXtzZzaSTKdrRhF6NM+uTfC0REOHeGRq
 WxuO5XzdT2xBvYZ35j+k8iQsyBo6NEsrSBlK2du4tvGz65NMEqtFMkt
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, opensuse.org:url,
 suse.com:mid, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fanotify: fix missing fallback for FAN_RESPONSE_ERRNO
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

RnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KCkZpeCB0
aGUgZm9sbG93aW5nIGJ1aWxkIGVycm9yIG9uIGk1ODY6CgpmYW5vdGlmeTI0LmM6IEluIGZ1bmN0
aW9uIOKAmGV4cGVjdGVkX2Vycm5v4oCZOgouLgogIDE3MyB8ICAgICAgICAgICAgICAgICByZXR1
cm4gRkFOX1JFU1BPTlNFX0VSUk5PKHJlc3BvbnNlKTsKICAgICAgfCAgICAgICAgICAgICAgICAg
ICAgICAgIF5+fn5+fn5+fn5+fn5+fn5+fgogICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAg
RkFOX0RFTllfRVJSTk8KbWFrZVs0XTogKioqIFsuLi8uLi8uLi8uLi9pbmNsdWRlL21rL3J1bGVz
Lm1rOjQ4OiBmYW5vdGlmeTI0XSBFcnJvciAxCgpTaWduZWQtb2ZmLWJ5OiBBbmRyZWEgQ2VydmVz
YXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgotLS0KVGhlIHJlYXNvbiBvZiB0aGUgZmFp
bCBpcyByZWxhdGVkIHRvIHRoZSBGQU5fUkVTUE9OU0VfRVJSTk8KZGVmaW5pdGlvbiwgd2hpY2gg
aXMgc2tpcHBlZCBpbiB0aGUgZmFsbGJhY2sgaGVhZGVyIGZpbGUuCgpodHRwczovL29wZW5xYS5v
cGVuc3VzZS5vcmcvdGVzdHMvNDk2MTE2MyNzdGVwL2luc3RhbGxfbHRwLzgyCi0tLQogaW5jbHVk
ZS9sYXBpL2Zhbm90aWZ5LmggfCAzICsrKwogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KQoKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9mYW5vdGlmeS5oIGIvaW5jbHVkZS9sYXBpL2Zh
bm90aWZ5LmgKaW5kZXggNzY5MDdlYTVmMjE5ODljNTE4NTQ3OGQzZDRmNTU3N2Q5NDAzZTUxOS4u
OGQwNGM4ZjI4OTY5ZDBiM2Q1ZmVjNzE4MjRkNTY5YjAxYzllYzA1NCAxMDA2NDQKLS0tIGEvaW5j
bHVkZS9sYXBpL2Zhbm90aWZ5LmgKKysrIGIvaW5jbHVkZS9sYXBpL2Zhbm90aWZ5LmgKQEAgLTEy
OCw2ICsxMjgsOSBAQAogI2lmbmRlZiBGQU5fREVOWV9FUlJOTwogI2RlZmluZSBGQU5fRVJSTk8o
ZXJyKSAoKCgoKF9fdTMyKShlcnIpKSAmIDB4ZmYpIDw8IDI0KSkKICNkZWZpbmUgRkFOX0RFTllf
RVJSTk8oZXJyKSAoRkFOX0RFTlkgfCBGQU5fRVJSTk8oZXJyKSkKKyNlbmRpZgorCisjaWZuZGVm
IEZBTl9SRVNQT05TRV9FUlJOTwogI2RlZmluZSBGQU5fUkVTUE9OU0VfRVJSTk8ocmVzKSAoKGlu
dCkoKHJlcykgPj4gMjQpKQogI2VuZGlmCiAKCi0tLQpiYXNlLWNvbW1pdDogMWFjYTI5NzkzOGM4
NWI0MWU0MWM5MTNkNGZmYzBlY2MzNDVkMDJkNApjaGFuZ2UtaWQ6IDIwMjUwMzMxLWZpeF9mYW5v
dGlmeV9pNTg2LWU5NmVlM2QwNjI3NQoKQmVzdCByZWdhcmRzLAotLSAKQW5kcmVhIENlcnZlc2F0
byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0
dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
