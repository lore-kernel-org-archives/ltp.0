Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D603AC2BD09
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 06:15:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 891A43D3929
	for <ltp@archiver.kernel.org>; Tue,  9 Jul 2024 08:15:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 430C53D3907
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 08:15:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EE19C600793
 for <ltp@lists.linux.it>; Tue,  9 Jul 2024 08:15:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 825FA1F7A0;
 Tue,  9 Jul 2024 06:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720505700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxHHp6tpb/EjYG1GRykCB33tE2wEGA1DpSqOKApgoN0=;
 b=MFAQII1T7BJ98HIcQh+2GZDLagd0kb5NMOk+OVGXH4LP/zISkhCEVWezVwEnaz54nVwy6e
 fuYw/4himpl2QUsx5vFY4m1FUraqdLyQpCRFrPzT76f1ZvXBLFMail955Q+GQJI0dHnKIu
 MARl1iy9vu3UuJvyKVPBF6XiUxzsSgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720505700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxHHp6tpb/EjYG1GRykCB33tE2wEGA1DpSqOKApgoN0=;
 b=P5rb6cOZcwCt6gzrGe5v306NtQDaictPo+yzN+xPN1HSmQNBlKJMN61dg2S1V4TbwP7NQP
 GhmknVtlbiy7ZOBQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1720505700; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxHHp6tpb/EjYG1GRykCB33tE2wEGA1DpSqOKApgoN0=;
 b=MFAQII1T7BJ98HIcQh+2GZDLagd0kb5NMOk+OVGXH4LP/zISkhCEVWezVwEnaz54nVwy6e
 fuYw/4himpl2QUsx5vFY4m1FUraqdLyQpCRFrPzT76f1ZvXBLFMail955Q+GQJI0dHnKIu
 MARl1iy9vu3UuJvyKVPBF6XiUxzsSgY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1720505700;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxHHp6tpb/EjYG1GRykCB33tE2wEGA1DpSqOKApgoN0=;
 b=P5rb6cOZcwCt6gzrGe5v306NtQDaictPo+yzN+xPN1HSmQNBlKJMN61dg2S1V4TbwP7NQP
 GhmknVtlbiy7ZOBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F0071369A;
 Tue,  9 Jul 2024 06:15:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id n5gKGmTVjGZYfgAAD6G6ig
 (envelope-from <akumar@suse.de>); Tue, 09 Jul 2024 06:15:00 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 09 Jul 2024 08:15:00 +0200
Message-ID: <4718826.vXUDI8C0e8@localhost>
Organization: SUSE
In-Reply-To: <20240516-listmount_statmount-v3-1-2ff4ba29bba7@suse.com>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
 <20240516-listmount_statmount-v3-1-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; HAS_ORG_HEADER(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 01/11] Add SAFE_STATX macro
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CgpPbiBUaHVy
c2RheSwgTWF5IDE2LCAyMDI0IDI6Mjk6MDnigK9QTSBHTVQrMiBBbmRyZWEgQ2VydmVzYXRvIHdy
b3RlOgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+
Cj4gCj4gLS0tCj4gIGluY2x1ZGUvdHN0X3NhZmVfbWFjcm9zLmggfCAgNyArKysrKysrCj4gIGxp
Yi90c3Rfc2FmZV9tYWNyb3MuYyAgICAgfCAyMiArKysrKysrKysrKysrKysrKysrKysrCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMjkgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3RzdF9zYWZlX21hY3Jvcy5oIGIvaW5jbHVkZS90c3Rfc2FmZV9tYWNyb3MuaAo+IGluZGV4IDhk
ZThlZjEwNi4uNDNmZjUwYTMzIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvdHN0X3NhZmVfbWFjcm9z
LmgKPiArKysgYi9pbmNsdWRlL3RzdF9zYWZlX21hY3Jvcy5oCj4gQEAgLTUwMyw0ICs1MDMsMTEg
QEAgaW50IHNhZmVfc3NjYW5mKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8sIGNv
bnN0IGNoYXIgKnJlc3RyaWN0IGJ1ZmZlciwKPiAgI2RlZmluZSBTQUZFX1NTQ0FORihidWZmZXIs
IGZvcm1hdCwgLi4uKSBcCj4gIAlzYWZlX3NzY2FuZihfX0ZJTEVfXywgX19MSU5FX18sIChidWZm
ZXIpLCAoZm9ybWF0KSwJIyNfX1ZBX0FSR1NfXykKPiAgCj4gK3N0cnVjdCBzdGF0eDsKPiAraW50
IHNhZmVfc3RhdHgoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiArCWludCBk
aXJmZCwgY29uc3QgY2hhciAqcGF0aG5hbWUsIGludCBmbGFncywgdW5zaWduZWQgaW50IG1hc2ss
Cj4gKwlzdHJ1Y3Qgc3RhdHggKmJ1Zik7Cj4gKyNkZWZpbmUgU0FGRV9TVEFUWChkaXJmZCwgcGF0
aG5hbWUsIGZsYWdzLCBtYXNrLCBidWYpIFwKPiArCXNhZmVfc3RhdHgoX19GSUxFX18sIF9fTElO
RV9fLCAoZGlyZmQpLCAocGF0aG5hbWUpLCAoZmxhZ3MpLCAobWFzayksIChidWYpKQo+ICsKPiAg
I2VuZGlmIC8qIFRTVF9TQUZFX01BQ1JPU19IX18gKi8KPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF9z
YWZlX21hY3Jvcy5jIGIvbGliL3RzdF9zYWZlX21hY3Jvcy5jCj4gaW5kZXggMzliOGNjOTI0Li5m
NTBhN2JjYzIgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9zYWZlX21hY3Jvcy5jCj4gKysrIGIvbGli
L3RzdF9zYWZlX21hY3Jvcy5jCj4gQEAgLTIwLDYgKzIwLDcgQEAKPiAgI2luY2x1ZGUgInRzdF9z
YWZlX21hY3Jvcy5oIgo+ICAjaW5jbHVkZSAibGFwaS9wZXJzb25hbGl0eS5oIgo+ICAjaW5jbHVk
ZSAibGFwaS9waWRmZC5oIgo+ICsjaW5jbHVkZSAibGFwaS9zdGF0LmgiCj4gIAo+ICBpbnQgc2Fm
ZV9hY2Nlc3MoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiAgCSAgICBjb25z
dCBjaGFyICpwYXRobmFtZSwgaW50IG1vZGUpCj4gQEAgLTcxMCwzICs3MTEsMjQgQEAgaW50IHNh
ZmVfbXByb3RlY3QoY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywKPiAgCj4gIAly
ZXR1cm4gcnZhbDsKPiAgfQo+ICsKPiAraW50IHNhZmVfc3RhdHgoY29uc3QgY2hhciAqZmlsZSwg
Y29uc3QgaW50IGxpbmVubywKPiArCWludCBkaXJmZCwgY29uc3QgY2hhciAqcGF0aG5hbWUsIGlu
dCBmbGFncywgdW5zaWduZWQgaW50IG1hc2ssCj4gKwlzdHJ1Y3Qgc3RhdHggKmJ1ZikKPiArewo+
ICsJaW50IHJ2YWw7Cj4gKwo+ICsJcnZhbCA9IHN0YXR4KGRpcmZkLCBwYXRobmFtZSwgZmxhZ3Ms
IG1hc2ssIGJ1Zik7Cj4gKwo+ICsJaWYgKHJ2YWwgPT0gLTEpIHsKPiArCQl0c3RfYnJrXyhmaWxl
LCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+ICsJCQkic3RhdHgoJWQsJXMsJWQsJXUsJXApIGZh
aWxlZCIsIGRpcmZkLCBwYXRobmFtZSwgZmxhZ3MsIG1hc2ssIGJ1Zik7Cj4gKwl9IGVsc2UgaWYg
KHJ2YWwpIHsKPiArCQl0c3RfYnJrXyhmaWxlLCBsaW5lbm8sIFRCUk9LIHwgVEVSUk5PLAo+ICsJ
CQkiSW52YWxpZCBzdGF0eCglZCwlcywlZCwldSwlcCkgcmV0dXJuIHZhbHVlICVkIiwKPiArCQkJ
ZGlyZmQsIHBhdGhuYW1lLCBmbGFncywgbWFzaywgYnVmLAo+ICsJCQlydmFsKTsKPiArCX0KPiAr
Cj4gKwlyZXR1cm4gcnZhbDsKPiArfQo+IAo+IAoKUmVnYXJkcywKQXZpbmVzaAoKCgotLSAKTWFp
bGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
