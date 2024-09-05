Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AA6BCD5BC7
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 14:13:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C4EA3C242F
	for <ltp@archiver.kernel.org>; Thu,  5 Sep 2024 16:13:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A6CFA3C23D0
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 16:12:50 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E40AB100115B
 for <ltp@lists.linux.it>; Thu,  5 Sep 2024 16:12:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 01BFA1F7D4;
 Thu,  5 Sep 2024 14:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725545569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sB3ybHIgMypcCew0hjgAFTlSNYqssPdE4whM1jKTJMM=;
 b=zKbzlAuMSW9d3PG4KNHXzdPfUqVfl0SKlZCq6BjoX7DKhnGrl9KiTszhC27N20lCjbIV3g
 QzTeY8+Ox+ipw0Ha32IJjB/L9iE6MSwaZrmW2h8T4UdU5dHtdKkFWTXJhRNxQu5QTY7sc/
 js1tWmIfeAD6dt0KU/HjDg0z9QnKrH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725545569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sB3ybHIgMypcCew0hjgAFTlSNYqssPdE4whM1jKTJMM=;
 b=Y0Djg+pUVeMhzMjrTeFMlRZhiEgY/6ktO2gWDke1O+xpCnayud2Ht7ddB90q3F3XSAWn2Z
 mOoB4kU0flQM6ZCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1725545569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sB3ybHIgMypcCew0hjgAFTlSNYqssPdE4whM1jKTJMM=;
 b=zKbzlAuMSW9d3PG4KNHXzdPfUqVfl0SKlZCq6BjoX7DKhnGrl9KiTszhC27N20lCjbIV3g
 QzTeY8+Ox+ipw0Ha32IJjB/L9iE6MSwaZrmW2h8T4UdU5dHtdKkFWTXJhRNxQu5QTY7sc/
 js1tWmIfeAD6dt0KU/HjDg0z9QnKrH0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1725545569;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sB3ybHIgMypcCew0hjgAFTlSNYqssPdE4whM1jKTJMM=;
 b=Y0Djg+pUVeMhzMjrTeFMlRZhiEgY/6ktO2gWDke1O+xpCnayud2Ht7ddB90q3F3XSAWn2Z
 mOoB4kU0flQM6ZCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB3081395F;
 Thu,  5 Sep 2024 14:12:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vwQFOWC82WZaFQAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 05 Sep 2024 14:12:48 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 05 Sep 2024 16:12:33 +0200
Message-ID: <4917672.OV4Wx5bFTl@localhost>
Organization: SUSE
In-Reply-To: <20240904123604.875639-1-pvorel@suse.cz>
References: <20240904123604.875639-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 HAS_ORG_HEADER(0.00)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.de:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] fanotify09: Skip testing e730558adffb on SLE
 < 5.19 kernel
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCgpSZXZpZXdlZC1ieTogQXZpbmVzaCBLdW1hciA8YWt1bWFyQHN1c2UuZGU+CgpPbiBXZWRu
ZXNkYXksIFNlcHRlbWJlciA0LCAyMDI0IDI6MzY6MDTigK9QTSBHTVQrMiBQZXRyIFZvcmVsIHdy
b3RlOgo+IEtlcm5lbCBjb21taXQgZTczMDU1OGFkZmZiICgiZnNub3RpZnk6IGNvbnNpc3RlbnQg
YmVoYXZpb3IgZm9yIHBhcmVudAo+IG5vdCB3YXRjaGluZyBjaGlsZHJlbiIpIHdpbGwgbm90IGJl
IGJhY2twb3J0ZWQgdG8gU0xFMTUtU1BbNDVdIHY1LjE0Cj4gYmFzZWQga2VybmVsLCB0aGVyZWZv
cmUgc2tpcCBpdCBmb3Iga2VybmVsIDwgNS4xOSAodGhlIG9yaWdpbmFsIG1haW5saW5lCj4ga2Vy
bmVsIHdoaWNoIGJyb3VnaHQgdGhlIGZ1bmN0aW9uYWxpdHkuCj4gCj4gU2lnbmVkLW9mZi1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lz
Y2FsbHMvZmFub3RpZnkvZmFub3RpZnkwOS5jIHwgNyArKysrKystCj4gIDEgZmlsZSBjaGFuZ2Vk
LCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTA5LmMgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDkuYwo+IGluZGV4IDQ4YjE5OGI5NDEuLjcy
ZTkyMzk4OTcgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlm
eS9mYW5vdGlmeTA5LmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5
L2Zhbm90aWZ5MDkuYwo+IEBAIC0zNzksNyArMzc5LDEyIEBAIHN0YXRpYyB2b2lkIHRlc3RfZmFu
b3RpZnkodW5zaWduZWQgaW50IG4pCj4gIAkJcmV0dXJuOwo+ICAJfQo+ICAKPiAtCWlmICh0Yy0+
aWdub3JlICYmIHRzdF9rdmVyY21wKDUsIDEwLCAwKSA8IDApIHsKPiArCXN0YXRpYyBzdHJ1Y3Qg
dHN0X2tlcm5fZXh2IGt2ZXJzW10gPSB7Cj4gKwkJeyJTTEVTIiwgIjUuMTkifSwKPiArCQl7TlVM
TCwgTlVMTH0KPiArCX07Cj4gKwo+ICsJaWYgKHRjLT5pZ25vcmUgJiYgdHN0X2t2ZXJjbXAyKDUs
IDEwLCAwLCBrdmVycykgPCAwKSB7Cj4gIAkJdHN0X3JlcyhUQ09ORiwgImlnbm9yZWQgbWFzayBv
biBwYXJlbnQgZGlyIGhhcyB1bmRlZmluZWQgIgo+ICAJCQkJImJlaGF2aW9yIG9uIGtlcm5lbCA8
IDUuMTAiKTsKPiAgCQlyZXR1cm47Cj4gCgpSZWdhcmRzLApBdmluZXNoCgoKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
