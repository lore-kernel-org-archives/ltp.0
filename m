Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7375BCD5BD5
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 14:58:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 052AE3CB964
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 16:58:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9D01A3C58CC
 for <ltp@lists.linux.it>; Wed, 27 May 2026 16:57:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C58EC10004A4
 for <ltp@lists.linux.it>; Wed, 27 May 2026 16:57:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 330DB672AF
 for <ltp@lists.linux.it>; Wed, 27 May 2026 14:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779893865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=acsgIogdyAjegXZ0wVX9DSo1LAKwdgbzrpQI0UYAuNQ=;
 b=03K0lJBe2sd1lRv8BuzrtJgAzHcabKk/wxvCZI19tmbERtuA7GPTGTP5An8//GRGWxxA+Z
 kjrq4x/gB86/scaSReDvUKddVmBOSQ98c38+1Ezq63VVGQuBhpH8Yt+mvXnTX3sUUhnSuA
 /deajg98I4FxlgvUYSa0y9Jz/JU3fLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779893865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=acsgIogdyAjegXZ0wVX9DSo1LAKwdgbzrpQI0UYAuNQ=;
 b=d9YCHMxSrdwoTcWYvy9AK3bYPLuU9RSaqOmaWIvDTZCuhLRCIUa6C3NSQvVqmunVvqvwYG
 qtYL7/9z5KPXv2CQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1779893865; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=acsgIogdyAjegXZ0wVX9DSo1LAKwdgbzrpQI0UYAuNQ=;
 b=03K0lJBe2sd1lRv8BuzrtJgAzHcabKk/wxvCZI19tmbERtuA7GPTGTP5An8//GRGWxxA+Z
 kjrq4x/gB86/scaSReDvUKddVmBOSQ98c38+1Ezq63VVGQuBhpH8Yt+mvXnTX3sUUhnSuA
 /deajg98I4FxlgvUYSa0y9Jz/JU3fLU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1779893865;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=acsgIogdyAjegXZ0wVX9DSo1LAKwdgbzrpQI0UYAuNQ=;
 b=d9YCHMxSrdwoTcWYvy9AK3bYPLuU9RSaqOmaWIvDTZCuhLRCIUa6C3NSQvVqmunVvqvwYG
 qtYL7/9z5KPXv2CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2AE6C5A8AF
 for <ltp@lists.linux.it>; Wed, 27 May 2026 14:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RIsSCmkGF2oUAwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 27 May 2026 14:57:45 +0000
Message-ID: <341cd021-1121-42e8-92ae-292f0d895ade@suse.cz>
Date: Wed, 27 May 2026 16:57:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LTP List <ltp@lists.linux.it>
References: <20260527114708.16896-1-mdoucha@suse.cz>
 <20260527130426.4026-1-linuxtestproject.agent@gmail.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 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 ag==
In-Reply-To: <20260527130426.4026-1-linuxtestproject.agent@gmail.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, suse.cz:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/xfrm.h: Include system XFRM header and force kernel
 IPv6 definition
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

T24gNS8yNy8yNiAxNTowNCwgbGludXh0ZXN0cHJvamVjdC5hZ2VudEBnbWFpbC5jb20gd3JvdGU6
Cj4gSGkgTWFydGluLAo+IAo+IE9uIFdlZCwgMjcgTWF5IDIwMjYsIE1hcnRpbiBEb3VjaGEgd3Jv
dGU6Cj4+IFtQQVRDSCAxLzZdIGxhcGkveGZybS5oOiBJbmNsdWRlIHN5c3RlbSBYRlJNIGhlYWRl
ciBhbmQgZm9yY2Uga2VybmVsIElQdjYgZGVmaW5pdGlvbgo+IAo+IFRoZSBjb21taXQgc3ViamVj
dCBhbmQgdGhlIGluLWNvZGUgY29tbWVudCBjb250cmFkaWN0IHdoYXQgdGhlIGNvZGUgYWN0dWFs
bHkKPiBkb2VzLiAjZGVmaW5lIF9VQVBJX0lQVjZfSCBzYXRpc2ZpZXMgdGhlIGluY2x1ZGUgZ3Vh
cmQgb2YgbGludXgvaXB2Ni5oLAo+IHByZXZlbnRpbmcgdGhhdCBoZWFkZXIgZnJvbSBiZWluZyBw
dWxsZWQgaW4g4oCUIGl0IGRvZXMgbm90ICJmb3JjZSIga2VybmVsIElQdjYKPiBkZWZpbml0aW9u
cy4gQm90aCB0aGUgc3ViamVjdCBhbmQgY29tbWVudCBzaG91bGQgYmUgY29ycmVjdGVkLgo+IAo+
PiArLyogRm9yY2UgdXNlIG9mIGtlcm5lbCBJUHY2IGRlZmluaXRpb25zIHRvIGF2b2lkIHJlZGVm
aW5pdGlvbiBlcnJvcnMgKi8KPj4gKyNkZWZpbmUgX1VBUElfSVBWNl9ICj4+ICsjaW5jbHVkZSA8
bGludXgveGZybS5oPgoKVGhlIGluY2x1ZGUgZ3VhcmQgZm9yIDxsaW51eC9pcHY2Lmg+IGlzIF9J
UFY2X0ggc28gdGhlIGxhcGkgI2RlZmluZSB3aWxsIApub3QgcHJldmVudCBpdCBmcm9tIGJlaW5n
IGluY2x1ZGVkLiBJdCB3aWxsLCBob3dldmVyLCBwcmV2ZW50IApyZWRlZmluaXRpb24gb2Ygc3Ry
dWN0IGluNl9hZGRyIGluIDxuZXRpbmV0L2luLmg+IGFzIGludGVuZGVkLgoKVGhlIF9VQVBJX0lQ
VjZfSCBpcyB1c2VkIGluIHRoZSBpbnRlcm5hbCBrZXJuZWwgaGVhZGVyIAoidWFwaS9saW51eC9p
cHY2LmgiIHdoaWNoIGlzIG5vdCB1c2VkIGJ5IHRoZSB0ZXN0LgoKPiBBbHNvIG5lZWRzIGEgY29t
bWl0IGJvZHkgZXhwbGFpbmluZyB3aGF0IHNwZWNpZmljIHJlZGVmaW5pdGlvbiBlcnJvciB0aGlz
Cj4gZml4ZXMuIGxpbnV4L2lwdjYuaCBjb250YWlucyBzdHJ1Y3QgaXB2NmhkciBhbmQgZnJpZW5k
czsgdGhlIHN0cnVjdCBpbjZfYWRkcgo+IHJlZGVmaW5pdGlvbiB0aGF0IHR5cGljYWxseSBiaXRl
cyB3aGVuIG1peGluZyB1c2Vyc3BhY2UgYW5kIGtlcm5lbCBJUHY2IGhlYWRlcnMKPiBjb21lcyBm
cm9tIGxpbnV4L2luNi5oIChpbmNsdWRlIGd1YXJkOiBfVUFQSV9MSU5VWF9JTjZfSCkuIFBsZWFz
ZSBjb25maXJtCj4gdGhhdCBibG9ja2luZyBsaW51eC9pcHY2LmggaXMgc3VmZmljaWVudCBhbmQg
dGhhdCB0aGUgcmVhbCBjb25mbGljdCBpcyBub3QKPiBjb21pbmcgZnJvbSBsaW51eC9pbjYuaCwg
YW5kIGRvY3VtZW50IHRoZSByZWFzb25pbmcgaW4gdGhlIGNvbW1pdCBtZXNzYWdlLgoKVGhlIGNv
bmZsaWN0IGV4aXN0cyBvbmx5IG9uIG9sZGVyIHN5c3RlbXMuIFRoZSBjb21taXQgbWVzc2FnZSBp
cyAKc3VmZmljaWVudCBhcyBpcy4KCj4gLS0tIFtQQVRDSCA1LzZdIHhmcm0wMjogQ29uZmlndXJl
IHhmcm0gdXNpbmcgZGlyZWN0IG5ldGxpbmsgcmVxdWVzdCAtLS0KPiAKPj4gLQlyZXQgPSB0c3Rf
Y21kKHhmcm1fY21kLCBOVUxMLCBOVUxMLCBUU1RfQ01EX1BBU1NfUkVUVkFMKTsKPj4gLQlpZiAo
cmV0KQo+PiAtCQl0c3RfYnJrKFRCUk9LLCAiRmFpbGVkIHRvIGluc3RhbGwgeGZybSBFU1AtaW4t
VENQIHN0YXRlIik7Cj4+ICsJY3R4ID0gTkVUTElOS19DUkVBVEVfQ09OVEVYVChORVRMSU5LX1hG
Uk0pOwo+IAo+IFRoZSBwYXRjaCBjb3JyZWN0bHkgcmVtb3ZlcyAubmVlZHNfY21kcyBmcm9tIHhm
cm0wMSBhZnRlciBkcm9wcGluZyB0aGUgaXAoOCkKPiBjYWxsLCBidXQgdGhlIGVxdWl2YWxlbnQg
cmVtb3ZhbCBpcyBtaXNzaW5nIGZyb20geGZybTAyOgo+IAo+IAkubmVlZHNfY21kcyA9IChzdHJ1
Y3QgdHN0X2NtZFtdKSB7Cj4gCQl7LmNtZCA9ICJpcCJ9LAo+IAkJe30KPiAJfSwKPiAKPiBpcCg4
KSBpcyBubyBsb25nZXIgaW52b2tlZDsgZHJvcCAubmVlZHNfY21kcyBoZXJlIHRvby4KPiAKPiBO
byBsaW51eC1naXQgdGFnIGZvciBDVkUtMjAyNi00NjMwMC4gSWYgYSBrZXJuZWwgZml4IGNvbW1p
dCBleGlzdHMsIGFkZCBvbmUuCj4gCj4gLS0tIFtQQVRDSCA2LzZdIHhmcm0wMzogQ29uZmlndXJl
IHhmcm0gdXNpbmcgZGlyZWN0IG5ldGxpbmsgcmVxdWVzdCAtLS0KPiAKPiBTYW1lIHN0YWxlIC5u
ZWVkc19jbWRzIGFzIHBhdGNoIDUvNiDigJQgeGZybTAzIHN0aWxsIHJlcXVpcmVzIGlwKDgpIGlu
IHRoZQo+IHRlc3QgZGVzY3JpcHRvciBldmVuIHRob3VnaCBpdCBpcyBubyBsb25nZXIgY2FsbGVk
LgoKWWVzLCBJIGZvcmdvdCB0byBkcm9wIC5uZWVkc19jbWRzIGluIHBhdGNoIDUgYW5kIDYuIEkg
Y2FuIHNlbmQgdjIgYWZ0ZXIgCnRoZSBwcmVjZWRpbmcgcGF0Y2hlcyBnZXQgbWVyZ2VkLgoKLS0g
Ck1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oKU1cgUXVhbGl0eSBFbmdpbmVlcgpTVVNF
IExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXppa292YSAxNDgvMzQKMTg2IDAwIFByYWd1ZSA4
CkN6ZWNoIFJlcHVibGljCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
