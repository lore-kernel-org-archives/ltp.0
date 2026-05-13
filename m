Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DC8CD4851
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 13:50:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A6F5A3E5CF8
	for <ltp@archiver.kernel.org>; Wed, 13 May 2026 15:50:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 799CD3E2948
 for <ltp@lists.linux.it>; Wed, 13 May 2026 15:49:55 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D6DF76008A0
 for <ltp@lists.linux.it>; Wed, 13 May 2026 15:49:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A8DA5D230;
 Wed, 13 May 2026 13:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778680193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GKfycxfQ8luV0j08M9ILctm8VQDH63V65x6eNrOk76E=;
 b=Y3p6eQ7i/cAKjkq9PBE0BhZK23nn9fz3vJ975ZwEP8/Avdlh9e2yZ/y2LdTx6G99PH9Vrm
 ISK6JqKSCtu6b4mZOi6zNIYxxgSMkPF68BsIxELVkIJAaYtktdnQ6jX+MWrpcrZRg2jtf+
 g189wrdatVONGnhN/8RNTLE2bG0XWoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778680193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GKfycxfQ8luV0j08M9ILctm8VQDH63V65x6eNrOk76E=;
 b=XAo9Dua9CWv36bccbdiJs9I8XWEhKH/3ve9yu11xyfvvk258iaBk+ul4cdzOEqQiQodbqn
 Y66lwV8D3giUe5AA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Y3p6eQ7i;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=XAo9Dua9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778680193; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GKfycxfQ8luV0j08M9ILctm8VQDH63V65x6eNrOk76E=;
 b=Y3p6eQ7i/cAKjkq9PBE0BhZK23nn9fz3vJ975ZwEP8/Avdlh9e2yZ/y2LdTx6G99PH9Vrm
 ISK6JqKSCtu6b4mZOi6zNIYxxgSMkPF68BsIxELVkIJAaYtktdnQ6jX+MWrpcrZRg2jtf+
 g189wrdatVONGnhN/8RNTLE2bG0XWoo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778680193;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=GKfycxfQ8luV0j08M9ILctm8VQDH63V65x6eNrOk76E=;
 b=XAo9Dua9CWv36bccbdiJs9I8XWEhKH/3ve9yu11xyfvvk258iaBk+ul4cdzOEqQiQodbqn
 Y66lwV8D3giUe5AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB953593A9;
 Wed, 13 May 2026 13:49:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O/SvNICBBGpOdAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 May 2026 13:49:52 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 13 May 2026 15:49:48 +0200
Message-ID: <20260513134948.77923-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.cz:email, suse.cz:dkim, suse.cz:mid]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6A8DA5D230
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] checkpatch: Pass git root
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

Y2hlY2twYXRjaC5wbCAtLXN0cmljdCBwYXJhbWV0ZXIgYWRkZWQgaW4gMTkwOGNkNzdjMiBleHBl
Y3RzIC0tcm9vdApwYXJhbWV0ZXIgd2hlbiBydW5uaW5nIHdpdGggLS1uby10cmVlIGR1ZSBzZWFy
Y2hpbmcgaW4gJHJvb3QvaW5jbHVkZS8KZGlyZWN0b3J5LgoKVGhpcyBmaXhlcyB3YXJuaW5nIG9u
IGZpbGVzIHdpdGggQ0FNRUxDQVNFIGNoZWNrIChjb3JuZXIgY2FzZSk6CgogICAgJCBjZCB0ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3N0YXR4OyBtYWtlIGNoZWNrLXN0YXR4MDIKICAgIENIRUNL
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3RhdHgvc3RhdHgwMi5jCiAgICBVc2Ugb2YgdW5p
bml0aWFsaXplZCB2YWx1ZSAkcm9vdCBpbiBjb25jYXRlbmF0aW9uICguKSBvciBzdHJpbmcgYXQK
ICAgIHNjcmlwdHMvY2hlY2twYXRjaC5wbCBsaW5lIDEyMTMuCiAgICBmaW5kOiDigJgvaW5jbHVk
ZeKAmTogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQogICAgc3RhdHgwMi5jOjUyOiBDSEVDSzog
QXZvaWQgQ2FtZWxDYXNlOiA8UFJJdTY0PgogICAgLi4uCgpGaXhlczogMTkwOGNkNzdjMiAoIm1h
a2UgY2hlY2s6IGI0OiBVc2UgLS1zdHJpY3Qgd2hlbiBydW4gY2hlY2twYXRjaC5wbCIpClNpZ25l
ZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgotLS0KTk9URTogSSdsbCB2ZXJp
ZnkgdGhlIHVzYWdlIHdpdGgga2VybmVsIGNoZWNrcGF0Y2gucGwgbWFpbnRhaW5lcnMuCgpLaW5k
IHJlZ2FyZHMsClBldHIKCiBpbmNsdWRlL21rL2Vudl9wb3N0Lm1rIHwgMiArLQogMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9tay9lbnZfcG9zdC5tayBiL2luY2x1ZGUvbWsvZW52X3Bvc3QubWsKaW5kZXggMWIwZDNhMmE4
ZS4uNzI2YjlhOWU3NSAxMDA2NDQKLS0tIGEvaW5jbHVkZS9tay9lbnZfcG9zdC5taworKysgYi9p
bmNsdWRlL21rL2Vudl9wb3N0Lm1rCkBAIC03Myw3ICs3Myw3IEBAIENIRUNLX1RBUkdFVFMJCQk/
PSAkKGFkZHByZWZpeCBjaGVjay0sJChub3RkaXIgJChwYXRzdWJzdCAlLmMsJSwkKHNvcnQgJCh3
aWxkY2FyCiBDSEVDS19UQVJHRVRTCQkJOj0gJChmaWx0ZXItb3V0ICQoYWRkcHJlZml4IGNoZWNr
LSwgJChGSUxURVJfT1VUX01BS0VfVEFSR0VUUykpLCAkKENIRUNLX1RBUkdFVFMpKQogQ0hFQ0tf
SEVBREVSX1RBUkdFVFMJCT89ICQoYWRkcHJlZml4IGNoZWNrLSwkKG5vdGRpciAkKHNvcnQgJCh3
aWxkY2FyZCAkKGFic19zcmNkaXIpLyouaCkpKSkKIENIRUNLCQkJCT89ICQoYWJzX3RvcF9zcmNk
aXIpL3Rvb2xzL3NwYXJzZS9zcGFyc2UtbHRwCi1DSEVDS19OT0ZMQUdTCQkJPz0gQ0hFQ0tQQVRD
SF9DT05GSUdfRElSPSIkKGFic190b3Bfc3JjZGlyKSIgJChhYnNfdG9wX3NyY2Rpcikvc2NyaXB0
cy9jaGVja3BhdGNoLnBsIC1mCitDSEVDS19OT0ZMQUdTCQkJPz0gQ0hFQ0tQQVRDSF9DT05GSUdf
RElSPSIkKGFic190b3Bfc3JjZGlyKSIgJChhYnNfdG9wX3NyY2Rpcikvc2NyaXB0cy9jaGVja3Bh
dGNoLnBsIC1mIC0tcm9vdCAkKGFic190b3Bfc3JjZGlyKQogU0hFTExfQ0hFQ0sJCQk/PSAkKGFi
c190b3Bfc3JjZGlyKS9zY3JpcHRzL2NoZWNrYmFzaGlzbXMucGwgLS1mb3JjZSAtLWV4dHJhCiBT
SEVMTF9DSEVDS19UQVJHRVRTCQk/PSAkKGFkZHByZWZpeCBjaGVjay0sJChub3RkaXIgJChzb3J0
ICQod2lsZGNhcmQgJChhYnNfc3JjZGlyKS8qLnNoKSkpKQogCi0tIAoyLjU0LjAKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
