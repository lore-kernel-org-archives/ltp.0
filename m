Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A7ED5E133
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:27:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1607E3D035E
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:27:33 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A7D63CEC45
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:27:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0F38C1A0088E
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:27:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 011B733695;
 Tue, 16 Dec 2025 11:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765884431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9SsNTqo9uk9RInCDHyLOx7ZDE0rQOM5MGb8gEPGo34=;
 b=2a2/RCf352w7daDxgnSsRwKbMUxrWKqY5UW5zuZqK8+HFsfmCTcXu/pJo9CuCioMiCTgFT
 IfVcwUDj7ckY3FoMoA0+KK8lJKXMomeMMuG4uRUCuVtc//H8xax4FtpTgXIZVMhTLe2GZy
 bwtCTdq7UUBhPpIN01Vtxoa5UwBh068=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765884431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9SsNTqo9uk9RInCDHyLOx7ZDE0rQOM5MGb8gEPGo34=;
 b=lOKKM8tS5OHa1KEfO/WA9/hrau5rohhXAIwKkmzZQk55373UOt9Y7UnZs754Kq4Gc0o96Z
 Rczbh3zeI+sDwzDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765884431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9SsNTqo9uk9RInCDHyLOx7ZDE0rQOM5MGb8gEPGo34=;
 b=2a2/RCf352w7daDxgnSsRwKbMUxrWKqY5UW5zuZqK8+HFsfmCTcXu/pJo9CuCioMiCTgFT
 IfVcwUDj7ckY3FoMoA0+KK8lJKXMomeMMuG4uRUCuVtc//H8xax4FtpTgXIZVMhTLe2GZy
 bwtCTdq7UUBhPpIN01Vtxoa5UwBh068=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765884431;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L9SsNTqo9uk9RInCDHyLOx7ZDE0rQOM5MGb8gEPGo34=;
 b=lOKKM8tS5OHa1KEfO/WA9/hrau5rohhXAIwKkmzZQk55373UOt9Y7UnZs754Kq4Gc0o96Z
 Rczbh3zeI+sDwzDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE4B43EA63;
 Tue, 16 Dec 2025 11:27:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id HLs3NQ5CQWnqJAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Dec 2025 11:27:10 +0000
Date: Tue, 16 Dec 2025 12:27:09 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251216112709.GC307257@pevik>
References: <20251215124404.16395-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251215124404.16395-1-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] doc: Document process_state
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4KPiAtLS0KPiAg
ZG9jL2RldmVsb3BlcnMvYXBpX2NfdGVzdHMucnN0IHwgIDUgKysrKwo+ICBpbmNsdWRlL3RzdF9w
cm9jZXNzX3N0YXRlLmggICAgfCA1NSArKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0t
Cj4gIDIgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMjAgZGVsZXRpb25zKC0pCgo+
IE5ldyBpbiB2Mi4KCj4gZGlmZiAtLWdpdCBhL2RvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3RzLnJz
dCBiL2RvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3RzLnJzdAo+IGluZGV4IDJjYTBmMDQ2NC4uMTNm
Yzg2NTFiIDEwMDY0NAo+IC0tLSBhL2RvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3RzLnJzdAo+ICsr
KyBiL2RvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3RzLnJzdAo+IEBAIC00Myw2ICs0MywxMSBAQCBL
ZXJuZWwKPiAgLi4ga2VybmVsLWRvYzo6IC4uLy4uL2luY2x1ZGUvdHN0X2tlcm5lbC5oCj4gIC4u
IGtlcm5lbC1kb2M6OiAuLi8uLi9pbmNsdWRlL3RzdF9rdmVyY21wLmgKCj4gK1Byb2Nlc3Mgc3Rh
dGUKPiArLS0tLS0tLS0tLS0tLQo+ICsKPiArLi4ga2VybmVsLWRvYzo6IC4uLy4uL2luY2x1ZGUv
dHN0X3Byb2Nlc3Nfc3RhdGUuaAo+ICsKPiAgTlVNQQo+ICAtLS0tCj4gIC4uIGtlcm5lbC1kb2M6
OiAuLi8uLi9pbmNsdWRlL3RzdF9udW1hLmgKPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS90c3RfcHJv
Y2Vzc19zdGF0ZS5oIGIvaW5jbHVkZS90c3RfcHJvY2Vzc19zdGF0ZS5oCj4gaW5kZXggYjFkODNl
MTA5Li4zNjkxYmJhN2EgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3RfcHJvY2Vzc19zdGF0ZS5o
Cj4gKysrIGIvaW5jbHVkZS90c3RfcHJvY2Vzc19zdGF0ZS5oCj4gQEAgLTE1LDM5ICsxNSw1NCBA
QAoKPiAgI2lmZGVmIFRTVF9URVNUX0hfXwoKPiAtLyoKPiAtICogV2FpdHMgZm9yIHByb2Nlc3Mg
c3RhdGUgY2hhbmdlLgo+ICsvKioKPiArICogVFNUX1BST0NFU1NfU1RBVEVfV0FJVCgpIC0gV2Fp
dHMgZm9yIGEgcHJvY2VzcyBzdGF0ZSBjaGFuZ2UuCj4gKyAqCj4gKyAqIFBvbGxzIGAvcHJvYy8k
UElEL3N0YXRlYCBmb3IgYSBwcm9jZXNzIHN0YXRlIGNoYW5nZXMuCj4gICAqCj4gLSAqIFRoZSBz
dGF0ZSBpcyBvbmUgb2YgdGhlIGZvbGxvd2luZzoKPiArICogQHBpZDogQSBwcm9jZXNzIHBpZC4K
PiArICogQHN0YXRlOiBBIHN0YXRlIHRvIHdhaXQgZm9yLgo+ICsgKiBAbXNlY190aW1lb3V0OiBB
IHRpbWVvdXQgZm9yIHRoZSB3YWl0Lgo+ICAgKgo+IC0gKiBSIC0gcHJvY2VzcyBpcyBydW5uaW5n
Cj4gLSAqIFMgLSBwcm9jZXNzIGlzIHNsZWVwaW5nCj4gLSAqIEQgLSBwcm9jZXNzIHNsZWVwaW5n
IHVuaW50ZXJydXB0aWJseQo+IC0gKiBaIC0gem9tYmllIHByb2Nlc3MKPiAtICogVCAtIHByb2Nl
c3MgaXMgdHJhY2VkCj4gKyAqIFBvc3NpYmxlIHByb2Nlc3Mgc3RhdGVzOgpNYXliZTogdXNlIGxp
bmsgdG8gaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuMS9wcy4xLmh0bWwgPwoK
LSogUG9zc2libGUgcHJvY2VzcyBzdGF0ZXM6CisqIFBvc3NpYmxlIHByb2Nlc3Mgc3RhdGVzIChz
ZWUgOm1hbjE6YHBzYCk6Cgo+ICsgKgo+ICsgKiAtICoqUioqIFByb2Nlc3MgaXMgcnVubmluZy4K
PiArICogLSAqKlMqKiBQcm9jZXNzIGlzIHNsZWVwaW5nLgo+ICsgKiAtICoqRCoqIFByb2Nlc3Mg
c2xlZXBpbmcgdW5pbnRlcnJ1cHRpYmx5Lgo+ICsgKiAtICoqWioqIFpvbWJpZSBwcm9jZXNzLgo+
ICsgKiAtICoqVCoqIFByb2Nlc3MgaXMgdHJhY2VkLgo+ICsgKiAtICoqdCoqIFRyYWNpbmcgc3Rv
cHBlZC4KPiArICogLSAqKlgqKiBQcm9jZXNzIGlkIGRlYWQuCgpQcm9jZXNzIHN0YXRlIGlzIG91
dGRhdGVkLCBtYW4gcHMoMSkgbGlzdHM6CgogICAgICAgICAgICAgICBEICAgIHVuaW50ZXJydXB0
aWJsZSBzbGVlcCAodXN1YWxseSBJL08pCiAgICAgICAgICAgICAgIEkgICAgaWRsZSBrZXJuZWwg
dGhyZWFkCiAgICAgICAgICAgICAgIFIgICAgcnVubmluZyBvciBydW5uYWJsZSAob24gcnVuIHF1
ZXVlKQogICAgICAgICAgICAgICBTICAgIGludGVycnVwdGlibGUgc2xlZXAgKHdhaXRpbmcgZm9y
IGFuCiAgICAgICAgICAgICAgICAgICAgZXZlbnQgdG8gY29tcGxldGUpCiAgICAgICAgICAgICAg
IFQgICAgc3RvcHBlZCBieSBqb2IgY29udHJvbCBzaWduYWwKICAgICAgICAgICAgICAgdCAgICBz
dG9wcGVkIGJ5IGRlYnVnZ2VyIGR1cmluZyB0aGUgdHJhY2luZwogICAgICAgICAgICAgICBXICAg
IHBhZ2luZyAobm90IHZhbGlkIHNpbmNlIExpbnV4IDIuNikKICAgICAgICAgICAgICAgWCAgICBk
ZWFkIChzaG91bGQgbmV2ZXIgYmUgc2VlbikKICAgICAgICAgICAgICAgWiAgICBkZWZ1bmN0ICji
gJx6b21iaWXigJ0pIHByb2Nlc3MsIHRlcm1pbmF0ZWQKICAgICAgICAgICAgICAgICAgICBidXQg
bm90IHJlYXBlZCBieSBpdHMgcGFyZW50CgpXZSBtaXNzOgoqIEkgKGZyb20ga2VybmVsIDQuMiwg
bWF5YmUgbm90IHJlbGV2YW50IHdoZW4gd2UgdXNlIGl0IGZvciBhIGNoaWxkIHdoaWNoCmlzIHVz
ZXJzcGFjZSkKKiBXIChpcnJlbGV2YW50IGFzIGl0IGlzIG5vdCB2YWxpZCkKKiBaCgpBbHNvLCBk
byB3ZSB3YW50IHNwZWNpZnkgdGhlIHByb2Nlc3Mgc3RhdGVzIGluIGJvdGggVFNUX1BST0NFU1Nf
U1RBVEVfV0FJVCgpIGFuZApUU1RfVEhSRUFEX1NUQVRFX1dBSVQoKSwgb3IganVzdCBzcGVjaWZ5
IGl0IGluIG9uZSBhbmQgbWVudGlvbiBpbiB0aGUgb3RoZXIgdGhhdAp0aGV5IHNwZWNpZnkgaXQ/
ICh2aWEgOnJlZjogb3IgYzpmdW5jOikuCgpPdGhlcndpc2UgTEdUTS4KUmV2aWV3ZWQtYnk6IFBl
dHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
