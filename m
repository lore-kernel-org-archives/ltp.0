Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339B0CA0FFF
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 16:19:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BBA73CD33E
	for <ltp@archiver.kernel.org>; Mon,  1 Sep 2025 18:19:43 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 874773CD1C1
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 18:19:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EA7AE1000434
 for <ltp@lists.linux.it>; Mon,  1 Sep 2025 18:19:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 52595211AA;
 Mon,  1 Sep 2025 16:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756743565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jOnwOPU0DlL5M1uBS3IQzF/LIi3HkIPSCXh548MrEXk=;
 b=rnsFFOFxh3SgTvGJkBt3mKcP02NPJ5aa9yaY5zhnQxH0ZSgxPwEmWuEF+LBFpOd1XIyNLr
 Vjvm/PKDF/yQIbzl8A10QpEW1nzNdapQsITNk5C5nOvhX1gd3rRR+TgFFmD/CnTeCwT+kz
 L3q/5nz+kZbNaz5umaB2haFRDjcIeHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756743565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jOnwOPU0DlL5M1uBS3IQzF/LIi3HkIPSCXh548MrEXk=;
 b=6ZIFpdIM0ZlpFwkQeEi1dBIFelM9cSL8LTfsmvlmF3XUFQC5PwsTL2bOr5m0P5x6QmxiU2
 0582KidcStarTSCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756743565; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jOnwOPU0DlL5M1uBS3IQzF/LIi3HkIPSCXh548MrEXk=;
 b=rnsFFOFxh3SgTvGJkBt3mKcP02NPJ5aa9yaY5zhnQxH0ZSgxPwEmWuEF+LBFpOd1XIyNLr
 Vjvm/PKDF/yQIbzl8A10QpEW1nzNdapQsITNk5C5nOvhX1gd3rRR+TgFFmD/CnTeCwT+kz
 L3q/5nz+kZbNaz5umaB2haFRDjcIeHw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756743565;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jOnwOPU0DlL5M1uBS3IQzF/LIi3HkIPSCXh548MrEXk=;
 b=6ZIFpdIM0ZlpFwkQeEi1dBIFelM9cSL8LTfsmvlmF3XUFQC5PwsTL2bOr5m0P5x6QmxiU2
 0582KidcStarTSCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47375136ED;
 Mon,  1 Sep 2025 16:19:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id tNn/EI3HtWjqcwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 01 Sep 2025 16:19:25 +0000
Message-ID: <cf84786a-8796-4843-835f-e9b7499802c4@suse.cz>
Date: Mon, 1 Sep 2025 18:19:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <20250822135702.23337-1-mdoucha@suse.cz>
 <CAEemH2eGMFOns37ho9sfpXKJhua0Vd+zWdohG_y9BY++=A9OUw@mail.gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <CAEemH2eGMFOns37ho9sfpXKJhua0Vd+zWdohG_y9BY++=A9OUw@mail.gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] aio_cancel_7-1: Write into a socket
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjUuIDA4LiAyNSA1OjA3LCBMaSBXYW5nIHdyb3RlOgo+IFdlIG5lZWQgdG8gdXBkYXRlIHRo
ZSBjb2RlIGNvbW1lbnRzIGFzIHdlbGw6Cj4gCj4gLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6
IEdQTC0yLjAtb3ItbGF0ZXIKPiAvKgo+ICDCoCogQ29weXJpZ2h0IChjKSAyMDA0LCBCdWxsIFNB
LiBBbGwgcmlnaHRzIHJlc2VydmVkLgo+ICDCoCogQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFBy
b2plY3QsIDIwMjUKPiAgwqAqLwo+IAo+IC8qCj4gIMKgKiBBc3NlcnRpb246Cj4gIMKgKiDCoCDC
oGFpb19jYW5jZWwoKSBzaGFsbCByZXR1cm4gQUlPX05PVENBTkNFTEVEIGlmIGF0IGxlYXN0IG9u
ZSByZXF1ZXN0ZWQKPiAgwqAqIMKgIMKgb3BlcmF0aW9uIGNhbm5vdCBiZSBjYW5jZWxlZCBiZWNh
dXNlIGl0IGlzIGFscmVhZHkgaW4gcHJvZ3Jlc3MuCj4gIMKgKgo+ICDCoCogTWV0aG9kOgo+ICDC
oCogwqAgwqAxLiBRdWV1ZSBtdWx0aXBsZSBhaW9fd3JpdGUoKSByZXF1ZXN0cyB0byBhIGdpdmVu
IGZpbGUgZGVzY3JpcHRvci4KPiAgwqAqIMKgIMKgMi4gQ2FsbCBhaW9fY2FuY2VsKCkgdG8gYXR0
ZW1wdCBjYW5jZWxpbmcgYWxsIG9wZXJhdGlvbnMuCj4gIMKgKiDCoCDCoDMuIENoZWNrIGVhY2gg
b3BlcmF0aW9uJ3MgcmVzdWx0IHVzaW5nIGFpb19lcnJvcigpOgo+ICDCoCogwqAgwqAgwqAgLSBJ
ZiBhaW9fZXJyb3IoKSByZXR1cm5zIEVJTlBST0dSRVNTIGJ1dCBhaW9fY2FuY2VsKCkgZGlkIG5v
dCAKPiByZXR1cm4KPiAgwqAqIMKgIMKgIMKgIMKgIEFJT19OT1RDQU5DRUxFRCwgdGhlIHRlc3Qg
RkFJTFMuCj4gIMKgKiDCoCDCoCDCoCAtIElmIGFpb19lcnJvcigpIHJldHVybnMgMCAoc3VjY2Vz
cykgYW5kIGFpb19jYW5jZWwoKSByZXR1cm5lZAo+ICDCoCogwqAgwqAgwqAgwqAgQUlPX05PVENB
TkNFTEVELCB0aGUgdGVzdCBQQVNTRVMuCj4gIMKgKiDCoCDCoCDCoCAtIE90aGVyd2lzZSwgdGhl
IHRlc3QgcmVzdWx0IGlzIFVOUkVTT0xWRUQuCj4gIMKgKi8KCkhtbSwgeWVzLiBCdXQgbm93IHRo
YXQgSSByZWFkIHRoZSB0ZXN0IGRlc2NyaXB0aW9uIGFnYWluLCBJIG5vdGljZSB0aGF0IAp0aGUg
YWRkaXRpb25hbCBjaGVjayBmb3IgYWlvX2Vycm9yKCkgPT0gRUNBTkNFTEVEIGRvZXMgbm90IGZp
dCB0aGUgCmludGVuZGVkIHNjZW5hcmlvLiBUaGUgdGVzdCBzaG91bGQgd2FpdCB1bnRpbCBhaW9j
YlsyXSBlbnRlcnMgdGhlIApFSU5QUk9HUkVTUyBzdGF0ZSBiZWZvcmUgYmVmb3JlIGNhbGxpbmcg
YWlvX2NhbmNlbCgpLiBJJ2xsIHJld3JpdGUgdGhhdCAKYW5kIHNlbmQgdjQuCgo+ICAgICArc3Rh
dGljIHZvaWQgY2xlYW51cCh2b2lkKQo+ICAgICArewo+ICAgICArwqAgwqAgwqAgwqBpbnQgaTsK
PiAgICAgKwo+ICAgICArwqAgwqAgwqAgwqBjbG9zZShmZHNbMV0pOwo+ICAgICArwqAgwqAgwqAg
wqBjbG9zZShmZHNbMF0pOwo+ICAgICArCj4gICAgICvCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkg
PCBCVUZfTkI7IGkrKykKPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZnJlZSgodm9pZCAq
KWFpb2NiW2ldLT5haW9fYnVmKTsKPiAKPiAKPiBBZ3JlZSwgYW5kIG1heWJlIGRvIHNvbWV0aGlu
ZyBmdXJ0aGVyOgo+IAo+IGZvciAoaSA9IDA7IGkgPCBCVUZfTkI7IGkrKykgewo+ICDCoCDCoCDC
oCDCoCBpZiAoYWlvY2JbaV0pIHsKPiAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaWYgKGFpb2Ni
W2ldLT5haW9fYnVmKQo+ICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBmcmVl
KCh2b2lkICopYWlvY2JbaV0tPmFpb19idWYpOwo+ICDCoCDCoCDCoCDCoMKgwqAgwqAgwqAgwqDC
oGZyZWUoYWlvY2JbaV0pOwo+ICDCoCDCoCDCoCDCoMKgwqAgwqAgwqAgwqDCoGFpb2NiW2ldID0g
TlVMTDsKPiAgwqAgwqAgwqAgwqDCoH0KPiB9Cj4gCgpJIGZvcmdvdCBhYm91dCB0aGUgdGhlIGFp
b2NicyBiZWluZyBkeW5hbWljYWxseSBhbGxvY2F0ZWQgYXMgd2VsbCB3aGlsZSAKd3JpdGluZyB0
aGUgY2xlYW51cCgpIGZ1bmN0aW9uLiBCdXQgdGhlIGJldHRlciBzb2x1dGlvbiB3b3VsZCBiZSB0
byAKcmVtb3ZlIHRoZSBjYWxsb2MoKXMgZW50aXJlbHkgYW5kIGhhdmUgdGhlIGFpb2NiIGFycmF5
IHN0YXRpY2FsbHkgYWxsb2NhdGVkLgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2Uu
Y3oKU1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXpp
a292YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
