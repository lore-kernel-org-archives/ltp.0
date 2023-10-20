Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8948DCDB47E
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 09:23:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B8743CD025
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 11:23:22 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 767DF3C8498
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:23:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 02E1220472A
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 11:23:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697793788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mz34lNn+llJu0ppJHNd7Q7D9YbcJJg6EXfLunjpwM18=;
 b=GM7xKMqJ0P9G8qPZEB7W9pFbZQEen680003k0vro8KwHF1V6iRdFSk1KPegKFu4u5SF9n9
 v3rhkOHnpTV8M+dFZvLEG1NKlunQlgRc0PkLVRw5THBlJytAq20DdiVytquLaj4dbE/hP5
 D91mv1zN17iaDNIBGqdT3HoXpvpl0Tw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-sKnt_WUyMZKK113i9GlVpA-1; Fri, 20 Oct 2023 05:23:05 -0400
X-MC-Unique: sKnt_WUyMZKK113i9GlVpA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c53c85e482so5599681fa.1
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 02:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697793784; x=1698398584;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Mz34lNn+llJu0ppJHNd7Q7D9YbcJJg6EXfLunjpwM18=;
 b=bJOmNYt30NkUMj/KIDmXEuihdjeA2sB8LhU5mLcbwES4efw2KgqRVUKfizBErhgHP8
 YW9RGSK2QBq89mVc4pE9xuZxXRNvCERkDFRaeogeqiZqVnJPvwpypQZxcGyGVtVZ0Y7m
 EvXI0Aj35lQ3vcfkynOoKl5yBfLdop73d3W6F/jYUh9jRf7iFP1m8o+k6IfKB3rnBgmg
 lYc6LLxhytzbqabG96hDPR6p+ZMDT0kLcMXUC9cHM+thzatT7BxXNPboyuPd4z9pRXYB
 A3Y1pZ7u6vWmgSlDZfYSSLDx3VwZflcG7oiPiCozuT09tgGqJXG8ZpGQsiOPy7iNjJIl
 uJvg==
X-Gm-Message-State: AOJu0YwN+dDw92KddyagiWbP5LwnX1W0hccyQ54y2zPVrZjyGINwe/Sd
 MZG1Nbd7iqskM9zXTKX64kju3+4/MFDv+KOUfJg2wdD6dmj73+aZT8IBaSOt3vzmIMZeUR9qFRN
 CY2M5of9+gGpjmOykG5+FVvvUFtc=
X-Received: by 2002:a2e:b896:0:b0:2c5:488c:aedf with SMTP id
 r22-20020a2eb896000000b002c5488caedfmr1055766ljp.37.1697793783857; 
 Fri, 20 Oct 2023 02:23:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF5IajPUxQSufjtpGSV0U2dTanY9wYpJGLaTiCr2e/yKwQ4EtJhJaoby4dZ5CkAMUoEw1UF6wtFyrU5ZFV+NAM=
X-Received: by 2002:a2e:b896:0:b0:2c5:488c:aedf with SMTP id
 r22-20020a2eb896000000b002c5488caedfmr1055755ljp.37.1697793783501; Fri, 20
 Oct 2023 02:23:03 -0700 (PDT)
MIME-Version: 1.0
References: <345e84821f2319d24ce8b9b84f5e038d53a2c9d5.1697715265.git.jstancek@redhat.com>
In-Reply-To: <345e84821f2319d24ce8b9b84f5e038d53a2c9d5.1697715265.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Oct 2023 17:22:51 +0800
Message-ID: <CAEemH2eehMwAHfwAPOhqmixwwdM2=8XsjqNP1Mkw28yjHjRpwA@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls/gettid02: fix s390x and couple races
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

T24gVGh1LCBPY3QgMTksIDIwMjMgYXQgNzo0MOKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gczM5MHggaXMgYmlnIGVuZGlhbiB3aGVyZSBzaXplb2YoaW50
KSA9PSA0IGFuZCBzaXplb2Yodm9pZCAqKSA9PSA4Lgo+IFRoaXMgdGVzdCBjdXJyZW50bHkgZmFp
bHMgb24gczM5MHggYmVjYXVzZSBpbiBwdGhyZWFkX2pvaW4sICImdGlkc1tpXSIKPiBpcyB0cmVh
dGVkIGFzICJ2b2lkKioiIGFuZCBkdWUgdG8gZGlmZmVyZW50IHR5cGUgc2l6ZSBpdCB3cml0ZXMg
b3Zlcgo+IDIgZW50cmllcyBvZiB0aWRzW10gYXJyYXkuIFNvIGZvciBzbWFsbCB0aWQgdmFsdWVz
IHRlc3QgcmVwb3J0czoKPiAgICAgICAgIGdldHRpZDAyLmM6Mjk6IFRQQVNTOiBFeHBlY3Q6IHBh
cmVudCBJRCAoMTQwNDgpIGRpZmZlcnMgZnJvbQo+IHRocmVhZFswXSBJRCAoMTQwNDkpCj4gICAg
ICAgICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZm
ZXJzIGZyb20KPiB0aHJlYWRbMV0gSUQgKDE0MDUwKQo+ICAgICAgICAgZ2V0dGlkMDIuYzoyOTog
VFBBU1M6IEV4cGVjdDogcGFyZW50IElEICgxNDA0OCkgZGlmZmVycyBmcm9tCj4gdGhyZWFkWzJd
IElEICgxNDA1MSkKPiAgICAgICAgIGdldHRpZDAyLmM6Mjk6IFRQQVNTOiBFeHBlY3Q6IHBhcmVu
dCBJRCAoMTQwNDgpIGRpZmZlcnMgZnJvbQo+IHRocmVhZFszXSBJRCAoMTQwNTIpCj4gICAgICAg
ICBnZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJz
IGZyb20KPiB0aHJlYWRbNF0gSUQgKDE0MDUzKQo+ICAgICAgICAgZ2V0dGlkMDIuYzoyOTogVFBB
U1M6IEV4cGVjdDogcGFyZW50IElEICgxNDA0OCkgZGlmZmVycyBmcm9tCj4gdGhyZWFkWzVdIElE
ICgxNDA1NCkKPiAgICAgICAgIGdldHRpZDAyLmM6Mjk6IFRQQVNTOiBFeHBlY3Q6IHBhcmVudCBJ
RCAoMTQwNDgpIGRpZmZlcnMgZnJvbQo+IHRocmVhZFs2XSBJRCAoMTQwNTUpCj4gICAgICAgICBn
ZXR0aWQwMi5jOjI5OiBUUEFTUzogRXhwZWN0OiBwYXJlbnQgSUQgKDE0MDQ4KSBkaWZmZXJzIGZy
b20KPiB0aHJlYWRbN10gSUQgKDE0MDU2KQo+ICAgICAgICAgZ2V0dGlkMDIuYzoyOTogVFBBU1M6
IEV4cGVjdDogcGFyZW50IElEICgxNDA0OCkgZGlmZmVycyBmcm9tCj4gdGhyZWFkWzhdIElEICgx
NDA1NykKPiAgICAgICAgIGdldHRpZDAyLmM6Mjk6IFRQQVNTOiBFeHBlY3Q6IHBhcmVudCBJRCAo
MTQwNDgpIGRpZmZlcnMgZnJvbQo+IHRocmVhZFs5XSBJRCAoMTQwNTgpCj4gICAgICAgICBnZXR0
aWQwMi5jOjQ5OiBUSU5GTzogdGhyZWFkWzBdIGFuZCB0aHJlYWRbMV0gaGF2ZSB0aGUgc2FtZSBJ
RAo+ICAgICAgICAgZ2V0dGlkMDIuYzo0OTogVElORk86IHRocmVhZFswXSBhbmQgdGhyZWFkWzJd
IGhhdmUgdGhlIHNhbWUgSUQKPiAgICAgICAgIGdldHRpZDAyLmM6NDk6IFRJTkZPOiB0aHJlYWRb
MF0gYW5kIHRocmVhZFszXSBoYXZlIHRoZSBzYW1lIElECj4gICAgICAgICAuLi4KPiB3aGljaCBp
cyBjbGVhcmx5IHdyb25nLCBzaW5jZSBlYWNoIHRocmVhZCBhYm92ZSBwcmludGVkIGRpZmZlcmVu
dCBJRC4KPgo+IFRoaXMgY29uc3RydWN0IGlzIHJhY2UteSBvbiBzbG93ZXIgczM5MHggc3lzdGVt
czoKPiAgICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgVEhSRUFEU19OVU07IGkrKykKPiAgICAg
ICAgICAgICAgICAgU0FGRV9QVEhSRUFEX0NSRUFURSgmdGhyZWFkLCBOVUxMLCB0aHJlYWRlZCwg
JmkpOwo+IGJlY2F1c2UgYnkgdGhlIHRpbWUgdGhyZWFkIHN0YXJ0cyBhbmQgbG9va3MgYXQgIiZp
IiwgdGhlIGxvb3AgY2FuCj4gYWxyZWFkeSBtb3ZlIG9uIGFuZCBpbmNyZW1lbnQgImkiLgo+CgpT
b3JyeSwganVzdCBjb21lIHVwIG9uZSBtb3JlIHF1ZXN0aW9uLCBwdGhyZWFkX2pvaW4gd2lsbCBz
dGF5IHRoZXJlCnVudGlsIHRoZSB0aHJlYWQgcmV2b2tlcyBmaW5pc2gsIHNvIHdoeSB0aGUgbG9v
cCBjYW4gbW92ZSBvbiBhbmQgaW5jcmVhc2UgaT8KCgoKPgo+IEFsc28sIHBvdGVudGlhbGx5IHN0
YXJ0aW5nIGFuZCB3YWl0aW5nIGZvciBlYWNoIHRocmVhZCBjb3VsZCBiZSBhbiBpc3N1ZSwKPiBz
aW5jZSBrZXJuZWwgaXMKPiBmcmVlIHRvIHJlLXVzZSB0aWQgZm9yIGFscmVhZHkgZmluaXNoZWQg
dGhyZWFkcy4KPgo+IEluc3RlYWQgb2YgcGFzc2luZyB0aWQgdmlhIHB0aHJlYWRfam9pbiwganVz
dCB1c2UgYWxyZWFkeSBhdmFpbGFibGUgZ2xvYmFsCj4gYXJyYXkgInRpZHMiLgo+IE1ha2Ugc3Vy
ZSB0aGUgYXJndW1lbnQgdG8gcHRocmVhZF9jcmVhdGUgZG9lc24ndCBjaGFuZ2UsIGJ5IGNyZWF0
aW5nIGFuCj4gYXJncyBhcnJheS4KPiBTdGFydCBhbGwgdGhyZWFkcyBiZWZvcmUgd2Ugam9pbiBh
bnkuCj4gQW5kIGFsc28gcHJpbnQgdGhlIHZhbHVlIG9mIFRJRCBpbiBjYXNlcyB3aGVyZSB0ZXN0
IGRldGVjdHMgdHdvIHRocmVhZHMKPiB1c2Ugc2FtZSBvbmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBK
YW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9nZXR0aWQvZ2V0dGlkMDIuYyB8IDE3ICsrKysrKysrKystLS0tLS0tCj4gIDEg
ZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAt
LWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0dGlkL2dldHRpZDAyLmMKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0dGlkL2dldHRpZDAyLmMKPiBpbmRleCA2MWYxMTVm
YzllN2MuLmVmNDQ3NjFjNDFkZSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2dldHRpZC9nZXR0aWQwMi5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9n
ZXR0aWQvZ2V0dGlkMDIuYwo+IEBAIC0xNiw3ICsxNiw3IEBACj4KPiAgI2RlZmluZSBUSFJFQURT
X05VTSAxMAo+Cj4gLXN0YXRpYyBwaWRfdCB0aWRzW1RIUkVBRFNfTlVNXTsKPiArc3RhdGljIHZv
bGF0aWxlIHBpZF90IHRpZHNbVEhSRUFEU19OVU1dOwo+Cj4gIHN0YXRpYyB2b2lkICp0aHJlYWRl
ZCh2b2lkICphcmcpCj4gIHsKPiBAQCAtMjksMjQgKzI5LDI3IEBAIHN0YXRpYyB2b2lkICp0aHJl
YWRlZCh2b2lkICphcmcpCj4gICAgICAgICBUU1RfRVhQX0VYUFIocGlkICE9IHRpZCwKPiAgICAg
ICAgICAgICAgICAgInBhcmVudCBJRCAoJWQpIGRpZmZlcnMgZnJvbSB0aHJlYWRbJWRdIElEICgl
ZCkiLAo+ICAgICAgICAgICAgICAgICBwaWQsIGksIHRpZCk7Cj4gLQo+IC0gICAgICAgcmV0dXJu
ICh2b2lkICopdHN0X3N5c2NhbGwoX19OUl9nZXR0aWQpOwo+ICsgICAgICAgdGlkc1tpXSA9IHRp
ZDsKPiArICAgICAgIHJldHVybiBOVUxMOwo+ICB9Cj4KPiAgc3RhdGljIHZvaWQgcnVuKHZvaWQp
Cj4gIHsKPiAtICAgICAgIHB0aHJlYWRfdCB0aHJlYWQ7Cj4gKyAgICAgICBwdGhyZWFkX3QgdGhy
ZWFkW1RIUkVBRFNfTlVNXTsKPiArICAgICAgIGludCBhcmdzW1RIUkVBRFNfTlVNXTsKPiAgICAg
ICAgIGludCBlcnJvciA9IDA7Cj4KPiAgICAgICAgIGZvciAoaW50IGkgPSAwOyBpIDwgVEhSRUFE
U19OVU07IGkrKykgewo+IC0gICAgICAgICAgICAgICBTQUZFX1BUSFJFQURfQ1JFQVRFKCZ0aHJl
YWQsIE5VTEwsIHRocmVhZGVkLCAmaSk7Cj4gLSAgICAgICAgICAgICAgIFNBRkVfUFRIUkVBRF9K
T0lOKHRocmVhZCwgKHZvaWQgKiopJnRpZHNbaV0pOwo+ICsgICAgICAgICAgICAgICBhcmdzW2ld
ID0gaTsKPiArICAgICAgICAgICAgICAgU0FGRV9QVEhSRUFEX0NSRUFURSgmdGhyZWFkW2ldLCBO
VUxMLCB0aHJlYWRlZCwgJmFyZ3NbaV0pOwo+ICAgICAgICAgfQo+ICsgICAgICAgZm9yIChpbnQg
aSA9IDA7IGkgPCBUSFJFQURTX05VTTsgaSsrKQo+ICsgICAgICAgICAgICAgICBTQUZFX1BUSFJF
QURfSk9JTih0aHJlYWRbaV0sIE5VTEwpOwo+Cj4gICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8
IFRIUkVBRFNfTlVNOyBpKyspIHsKPiAgICAgICAgICAgICAgICAgZm9yIChpbnQgaiA9IGkgKyAx
OyBqIDwgVEhSRUFEU19OVU07IGorKykgewo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh0
aWRzW2ldID09IHRpZHNbal0pIHsKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRz
dF9yZXMoVElORk8sICJ0aHJlYWRbJWRdIGFuZCB0aHJlYWRbJWRdCj4gaGF2ZSB0aGUgc2FtZSBJ
RCIsIGksIGopOwo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdHN0X3JlcyhUSU5G
TywgInRocmVhZFslZF0gYW5kIHRocmVhZFslZF0KPiBoYXZlIHRoZSBzYW1lIElEICVkIiwgaSwg
aiwgdGlkc1tpXSk7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBlcnJvciA9IDE7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAgICAgICAgICAgICAgICB9Cj4gLS0KPiAy
LjMxLjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
