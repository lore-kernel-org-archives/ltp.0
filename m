Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 794E6C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 08:54:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDEA83CC29C
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 10:54:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1FCE3CC17D
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:53:56 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 33CC5600682
 for <ltp@lists.linux.it>; Mon, 12 May 2025 10:53:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 993381F387;
 Mon, 12 May 2025 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747040031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7H0RRXJRDVdaf29d35Mt74yU7tMvsCJqNycHASFfmNI=;
 b=aUVWWJIAjK7hrkcQKJCVR8sA5FZ5Xa9Yhrhc9T6TV5ehrnSK2WhMcZo29T1biZLvZ2Djx9
 r+AvBKAn1sud/wh24O619GY/El3EpFhDSYKJLjJqPGtvniExDBZ7SMvoqP4wzxH/FiPIYP
 d852D1JydR/WG6MdWC4QIsOgyOWEZks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747040031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7H0RRXJRDVdaf29d35Mt74yU7tMvsCJqNycHASFfmNI=;
 b=zZxJ8ZMQY6sVdHYjJtveVYMQb68GNDDRun3QNL8FusL6gXdQouFaQGAKf1x3ZiQJF/gz4q
 m0ezCeyLNzLpcZBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747040031; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7H0RRXJRDVdaf29d35Mt74yU7tMvsCJqNycHASFfmNI=;
 b=aUVWWJIAjK7hrkcQKJCVR8sA5FZ5Xa9Yhrhc9T6TV5ehrnSK2WhMcZo29T1biZLvZ2Djx9
 r+AvBKAn1sud/wh24O619GY/El3EpFhDSYKJLjJqPGtvniExDBZ7SMvoqP4wzxH/FiPIYP
 d852D1JydR/WG6MdWC4QIsOgyOWEZks=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747040031;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7H0RRXJRDVdaf29d35Mt74yU7tMvsCJqNycHASFfmNI=;
 b=zZxJ8ZMQY6sVdHYjJtveVYMQb68GNDDRun3QNL8FusL6gXdQouFaQGAKf1x3ZiQJF/gz4q
 m0ezCeyLNzLpcZBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88FD8137D2;
 Mon, 12 May 2025 08:53:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id nr20IB+3IWjkJwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 12 May 2025 08:53:51 +0000
Message-ID: <122624a6-0a36-4cd0-bd63-b9d6a3bcfdb9@suse.cz>
Date: Mon, 12 May 2025 10:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250507-fixes-modify_ldt-v1-1-70a2694cfddc@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20250507-fixes-modify_ldt-v1-1-70a2694cfddc@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[]; TO_DN_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 MID_RHS_MATCH_FROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ldt.h: Add workaround for x86_64
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCm9uZSBpc3N1ZSBiZWxvdy4KCk9uIDA4LiAwNS4gMjUgMTozNywgUmljYXJkbyBCLiBNYXJs
acOocmUgd3JvdGU6Cj4gRnJvbTogUmljYXJkbyBCLiBNYXJsacOocmUgPHJibUBzdXNlLmNvbT4K
PiAKPiBUaGUgY29tbWl0IGJlMGFhY2EyZjc0MiAoInN5c2NhbGxzL21vZGlmeV9sZHQ6IEFkZCBs
YXBpL2xkdC5oIikgbGVmdCBiZWhpbmQKPiBhbiBpbXBvcnRhbnQgZmFjdG9yIG9mIG1vZGlmeV9s
ZHQoKTogdGhlIGtlcm5lbCBpbnRlbnRpb25hbGx5IGNhc3RzIHRoZQo+IHJldHVybiB2YWx1ZSB0
byB1bnNpZ25lZCBpbnQuIFRoaXMgd2FzIGhhbmRsZWQgaW4KPiB0ZXN0Y2FzZXMvY3ZlL2N2ZS0y
MDE1LTMyOTAuYyBidXQgd2FzIHJlbW92ZWQuIEFkZCBpdCBiYWNrIHRvIHRoZSByZWxldmFudAo+
IGZpbGUuCj4gCj4gUmVwb3J0ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFAc3VzZS5jej4K
PiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgo+IC0t
LQo+ICAgaW5jbHVkZS9sYXBpL2xkdC5oICAgICAgICAgICAgfCAyMiArKysrKysrKysrKysrKysr
KysrKystCj4gICB0ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYyB8ICA2ICsrKysrLQo+ICAg
MiBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvbGR0LmggYi9pbmNsdWRlL2xhcGkvbGR0LmgKPiBpbmRl
eCA2YjVhMmQ1OWNiNDFiZmMyNGViNWFjMjZjM2Q0N2Q0OWZiOGZmNzhmLi4xNzMzMjFkZDlhYzM0
YmE4N2VmZjBlZWU5NjA2MzVmMzBkODc4OTkxIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGFwaS9s
ZHQuaAo+ICsrKyBiL2luY2x1ZGUvbGFwaS9sZHQuaAo+IEBAIC0zMSw3ICszMSwyNyBAQCBzdHJ1
Y3QgdXNlcl9kZXNjIHsKPiAgIHN0YXRpYyBpbmxpbmUgaW50IG1vZGlmeV9sZHQoaW50IGZ1bmMs
IGNvbnN0IHN0cnVjdCB1c2VyX2Rlc2MgKnB0ciwKPiAgIAkJCSAgICAgdW5zaWduZWQgbG9uZyBi
eXRlY291bnQpCj4gICB7Cj4gLQlyZXR1cm4gdHN0X3N5c2NhbGwoX19OUl9tb2RpZnlfbGR0LCBm
dW5jLCBwdHIsIGJ5dGVjb3VudCk7Cj4gKwlsb25nIHJ2YWw7Cj4gKwo+ICsJZXJybm8gPSAwOwo+
ICsJcnZhbCA9IHRzdF9zeXNjYWxsKF9fTlJfbW9kaWZ5X2xkdCwgZnVuYywgcHRyLCBieXRlY291
bnQpOwo+ICsKPiArI2lmZGVmIF9feDg2XzY0X18KPiArCS8qCj4gKwkgKiBUaGUga2VybmVsIGlu
dGVudGlvbmFsbHkgY2FzdHMgbW9kaWZ5X2xkdCgpIHJldHVybiB2YWx1ZQo+ICsJICogdG8gdW5z
aWduZWQgaW50IHRvIHByZXZlbnQgc2lnbiBleHRlbnNpb24gdG8gNjQgYml0cy4gVGhpcyBtYXkK
PiArCSAqIHJlc3VsdCBpbiBzeXNjYWxsKCkgcmV0dXJuaW5nIHRoZSB2YWx1ZSBhcyBpcyBpbnN0
ZWFkIG9mIHNldHRpbmcKPiArCSAqIGVycm5vIGFuZCByZXR1cm5pbmcgLTEuCj4gKwkgKi8KPiAr
CWlmIChydmFsID4gMCAmJiAoaW50KXJ2YWwgPCAwKSB7Cj4gKwkJdHN0X3JlcyhUSU5GTywKPiAr
CQkJIldBUk5JTkc6IExpYmMgbWlzaGFuZGxlZCBtb2RpZnlfbGR0KCkgcmV0dXJuIHZhbHVlIik7
Cj4gKwkJZXJybm8gPSAtKGludCllcnJubzsKPiArCQlydmFsID0gLTE7Cj4gKwl9Cj4gKyNlbmRp
ZiAvKiBfX3g4Nl82NF9fICovCj4gKwo+ICsJcmV0dXJuIHJ2YWw7Cj4gICB9Cj4gICAKPiAgIHN0
YXRpYyBpbmxpbmUgaW50IHNhZmVfbW9kaWZ5X2xkdChjb25zdCBjaGFyICpmaWxlLCBjb25zdCBp
bnQgbGluZW5vLCBpbnQgZnVuYywKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAx
NS0zMjkwLmMgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+IGluZGV4IDhlYzFkNTNi
YmI1YTlmM2U3NzYxZDM5ODU1ZDM0ZjU5M2UxMThhMjguLjZhYTA2NGJhYjMwYTAzOWQyNjhiMmU5
ZjE3MjU4NTY0ZWRhODA2N2MgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2N2ZS9jdmUtMjAxNS0z
MjkwLmMKPiArKysgYi90ZXN0Y2FzZXMvY3ZlL2N2ZS0yMDE1LTMyOTAuYwo+IEBAIC0xOTcsNyAr
MTk3LDExIEBAIHN0YXRpYyB2b2lkIHNldF9sZHQodm9pZCkKPiAgIAkJLnVzZWFibGUJID0gMAo+
ICAgCX07Cj4gICAKPiAtCVNBRkVfTU9ESUZZX0xEVCgxLCAmZGF0YV9kZXNjLCBzaXplb2YoZGF0
YV9kZXNjKSk7Cj4gKwlURVNUKG1vZGlmeV9sZHQoMSwgJmRhdGFfZGVzYywgc2l6ZW9mKGRhdGFf
ZGVzYykpKTsKPiArCWlmIChUU1RfUkVUID09IC0xICYmIFRTVF9FUlIgPT0gRUlOVkFMKSB7Cj4g
KwkJdHN0X2JyayhUQ09ORiB8IFRURVJSTk8sCj4gKwkJCSJtb2RpZnlfbGR0OiAxNi1iaXQgZGF0
YSBzZWdtZW50cyBhcmUgcHJvYmFibHkgZGlzYWJsZWQiKTsKPiArCX0KClRoaXMgcGFydCBpcyBj
b3JyZWN0LCBidXQgYW55IG90aGVyIG5vbi16ZXJvIHJldHVybiB2YWx1ZSBpcyBhbiBlcnJvciAK
dGhhdCBzaG91bGQgdHJpZ2dlciBUQlJPSy4gU2VlIHRoZSBvbGQgdGVzdCBjb2RlIGJlZm9yZSBy
ZWZhY3RvcmluZy4KCj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2b2lkIHRyeV9jb3JydXB0X3N0YWNr
KHVuc2lnbmVkIHNob3J0ICpvcmlnX3NzKQo+IAo+IC0tLQo+IGJhc2UtY29tbWl0OiBiMDcwYTU2
OTJlMDM1ZWMxMmMzZDNjN2E3ZTllOTdjMjcwZmQ0ZDdkCj4gY2hhbmdlLWlkOiAyMDI1MDUwNy1m
aXhlcy1tb2RpZnlfbGR0LWViY2ZkZDJhN2QzMAo+IAo+IEJlc3QgcmVnYXJkcywKCgotLSAKTWFy
dGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpTVyBRdWFsaXR5IEVuZ2luZWVyClNVU0UgTElO
VVgsIHMuci5vLgpDT1JTTyBJSWEKS3Jpemlrb3ZhIDE0OC8zNAoxODYgMDAgUHJhZ3VlIDgKQ3pl
Y2ggUmVwdWJsaWMKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
