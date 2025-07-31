Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 376D4C87FCA
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 14:36:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 006523CC155
	for <ltp@archiver.kernel.org>; Thu, 31 Jul 2025 16:36:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 277C63C9F61
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:35:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9790F1A001CB
 for <ltp@lists.linux.it>; Thu, 31 Jul 2025 16:35:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67D4221BAD;
 Thu, 31 Jul 2025 14:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753972553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VNpcQ+sqe+riIqC9A23I7RUiD3Uf0VyQMNHvvJib4XE=;
 b=H5Ifxo0AlQo8eK9WUVWLPBOi82N9VNaa7blbEDEGaXQE+ggu3uCSO8ciic3Kwrz9e3nj1F
 /xqv/fwCxMbPqiIYnpMCUjM08SypFhHCgT+LtvIEfiAPDgFyZmjf0y5GRFJQ0Ad+sGPWqO
 ib37dcar6HylLaySx4YDkLxD2p07qb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753972553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VNpcQ+sqe+riIqC9A23I7RUiD3Uf0VyQMNHvvJib4XE=;
 b=VAkcIo5cX7pw6Kv5IHp1REpATEDC+QSXrjBQIel+or7h5L+4yMSOTK6FyfjodRp81T/qFe
 krbcHCMbdMlTCuDg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=H5Ifxo0A;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VAkcIo5c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1753972553; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VNpcQ+sqe+riIqC9A23I7RUiD3Uf0VyQMNHvvJib4XE=;
 b=H5Ifxo0AlQo8eK9WUVWLPBOi82N9VNaa7blbEDEGaXQE+ggu3uCSO8ciic3Kwrz9e3nj1F
 /xqv/fwCxMbPqiIYnpMCUjM08SypFhHCgT+LtvIEfiAPDgFyZmjf0y5GRFJQ0Ad+sGPWqO
 ib37dcar6HylLaySx4YDkLxD2p07qb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1753972553;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VNpcQ+sqe+riIqC9A23I7RUiD3Uf0VyQMNHvvJib4XE=;
 b=VAkcIo5cX7pw6Kv5IHp1REpATEDC+QSXrjBQIel+or7h5L+4yMSOTK6FyfjodRp81T/qFe
 krbcHCMbdMlTCuDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F2C113876;
 Thu, 31 Jul 2025 14:35:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Tx4yCkl/i2jQAwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 31 Jul 2025 14:35:53 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 31 Jul 2025 16:35:50 +0200
Message-ID: <20250731143550.777289-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 67D4221BAD
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] munmap04: Fix 'base' overflow
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
Cc: =?UTF-8?q?Ricardo=20B=20=2E=20Marli=C3=A8re?= <rbm@suse.com>,
 Andrea Cervesato <andrea.cervesato@mailbox.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

TG93ZXIgZG93biBhIGJhc2UgdG8gZml4IG92ZXJmbG93IG9uIDMyIGJpdDoKCm11bm1hcDA0LmM6
MTg6MjU6IHdhcm5pbmc6IGNvbnZlcnNpb24gZnJvbSDigJhsb25nIGxvbmcgdW5zaWduZWQgaW50
4oCZIHRvCuKAmHVpbnRwdHJfdOKAmSB7YWthIOKAmHVuc2lnbmVkIGludOKAmX0gY2hhbmdlcyB2
YWx1ZSBmcm9tIOKAmDQyOTQ5NjcyOTbigJkgdG8g4oCYMOKAmSBbLVdvdmVyZmxvd10KICAgMTgg
fCBzdGF0aWMgdWludHB0cl90IGJhc2UgPSAweDEwMDAwMDAwMFVMOwogICAgICB8ICAgICAgICAg
ICAgICAgICAgICAgICAgIF5+fn5+fn5+fn5+fn4KCkZpeGVzOiAxZTJjOThlM2FmICgiQWRkIG11
bm1hcDA0IHRvIGNoZWNrIEVOT01FTSIpClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PgotLS0KSGksCgpJJ20gbm90IHN1cmUgaG93IHRoaXMgaW5mbHVlbmNlcyByZWNl
bnQgZml4ZXMuIEFuZCBob3cgdGhlIGJhc2UgYWRkcmVzcwp3YXMgYWN0dWFsbHkgY2hvc2VuIChq
dXN0IHJhbmRvbSBtZW1vcnkgbG9jYXRpb24/KS4KCktpbmQgcmVnYXJkcywKUGV0cgoKIHRlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMgfCAyICstCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS90ZXN0Y2Fz
ZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tdW5tYXAvbXVubWFwMDQuYwppbmRleCA5ODdhN2M3ZTdhLi5lMWI2N2FlZWUzIDEw
MDY0NAotLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL211bm1hcC9tdW5tYXAwNC5jCisr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXVubWFwL211bm1hcDA0LmMKQEAgLTE1LDcg
KzE1LDcgQEAKICNkZWZpbmUgTUVNU0laRSAzCiAjZGVmaW5lIE1BUF9NQVhfQ09VTlQgNjU1MzAK
IAotc3RhdGljIHVpbnRwdHJfdCBiYXNlID0gMHgxMDAwMDAwMDBVTDsKK3N0YXRpYyB1aW50cHRy
X3QgYmFzZSA9IDB4MTAwMDAwMDBVTDsKIHN0YXRpYyBzaXplX3QgcGFnZV9zejsKIHN0YXRpYyB1
bnNpZ25lZCBsb25nIHZtYV9zaXplOwogc3RhdGljIGludCBtYXBfY291bnQ7Ci0tIAoyLjUwLjEK
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
