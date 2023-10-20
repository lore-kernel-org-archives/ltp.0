Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43B2CDB474
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 08:55:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8FC813CD00E
	for <ltp@archiver.kernel.org>; Fri, 20 Oct 2023 10:55:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C74F3C849A
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 10:55:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CF84460103D
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 10:55:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HDqGZijD/CJFfm6lPQ2lbt9K8+C1XJMmUTuYA3A8AL0=;
 b=Jds2IFTyeHmBPwQN5FbStSbFOC6mx10ZJf97Oa525j1KPZ66qgnnA06b4Tdb1AXU2F2UDL
 mwPyHT9owoZZBXuGCRd5+nt2lSj3dmt7L1vv0BGALHLyBzA/aDTJ0c6P1uqFfb7l/W2gKo
 2W5CvWNLAet+92zL1UsGUpL/ImldYfo=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-Z68XVwWEOYeiH3oiVSJEDg-1; Fri, 20 Oct 2023 04:54:51 -0400
X-MC-Unique: Z68XVwWEOYeiH3oiVSJEDg-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-507c5327cabso1015879e87.1
 for <ltp@lists.linux.it>; Fri, 20 Oct 2023 01:54:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697792088; x=1698396888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HDqGZijD/CJFfm6lPQ2lbt9K8+C1XJMmUTuYA3A8AL0=;
 b=orDDznKJIHQ/abVDUjhvpmRg/wfbaEtJuPlk09+TStyObyLJie5l6bpoh7rSnPnix0
 VBNSJUe87JnOSyKzwG7QoGePBhZRKwEgEq1hVLarxZ9jYkHYZou9ofbu/pinD6olnrx4
 wocc9SR41Gi4ZWb4RoNKoy0J2dT6NVzdHV/owU+mMA8u5SNFZz1SB/hX8zh8zaAw2rc8
 SBUwgGqVI14POXrm0J+iCSqXxcGAWe8lLxe6p1IDZNr0J6gUz6gXyW5c4r9BrP0fT5EB
 rGiaGTTxjIaDxJJA/oNF6zHT8ibijXNSkB3I0/3vE5IPPsTHs0N0ZslTLYQ9r1v6j/2D
 +1Bw==
X-Gm-Message-State: AOJu0Yx+b1XAPUYktMfXLDtaAi8tnI0LR5RePYXILYTFwo3euCDhY0+U
 XuXB6Y1oPMO1FqMXrvL0KCLmGu64WVMvtgU1l7mTR6QvZCrwQgPnrNui0fnJQbpU6WJ/9RzgrOc
 7+ic4aGLPljTAIaUMiF/PUABbtaLrW78Ag74MpqbT/OY=
X-Received: by 2002:a05:6512:238a:b0:500:943f:11c9 with SMTP id
 c10-20020a056512238a00b00500943f11c9mr1488095lfv.3.1697792088617; 
 Fri, 20 Oct 2023 01:54:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsM6MELizKSW5r+Op2AoArGl6XXyywk8YmVYvYIwdVOnJvtVxZ8IFoOZYkX29LqR3nZdlJTpfKKbtQHE9nYo8=
X-Received: by 2002:a05:6512:238a:b0:500:943f:11c9 with SMTP id
 c10-20020a056512238a00b00500943f11c9mr1488090lfv.3.1697792088191; Fri, 20 Oct
 2023 01:54:48 -0700 (PDT)
MIME-Version: 1.0
References: <345e84821f2319d24ce8b9b84f5e038d53a2c9d5.1697715265.git.jstancek@redhat.com>
In-Reply-To: <345e84821f2319d24ce8b9b84f5e038d53a2c9d5.1697715265.git.jstancek@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 20 Oct 2023 16:54:36 +0800
Message-ID: <CAEemH2fkj49Z-NQVSewZAgm6z8agC-Z_PoBrqRhFvGbu8uRAZg@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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
IiwgdGhlIGxvb3AgY2FuCj4gYWxyZWFkeSBtb3ZlIG9uIGFuZCBpbmNyZW1lbnQgImkiLgo+Cj4g
QWxzbywgcG90ZW50aWFsbHkgc3RhcnRpbmcgYW5kIHdhaXRpbmcgZm9yIGVhY2ggdGhyZWFkIGNv
dWxkIGJlIGFuIGlzc3VlLAo+IHNpbmNlIGtlcm5lbCBpcwo+IGZyZWUgdG8gcmUtdXNlIHRpZCBm
b3IgYWxyZWFkeSBmaW5pc2hlZCB0aHJlYWRzLgo+CgpNYWtlIHNlbnNlIQoKUmV2aWV3ZWQtYnk6
IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKCgoKPgo+IEluc3RlYWQgb2YgcGFzc2luZyB0
aWQgdmlhIHB0aHJlYWRfam9pbiwganVzdCB1c2UgYWxyZWFkeSBhdmFpbGFibGUgZ2xvYmFsCj4g
YXJyYXkgInRpZHMiLgo+IE1ha2Ugc3VyZSB0aGUgYXJndW1lbnQgdG8gcHRocmVhZF9jcmVhdGUg
ZG9lc24ndCBjaGFuZ2UsIGJ5IGNyZWF0aW5nIGFuCj4gYXJncyBhcnJheS4KPiBTdGFydCBhbGwg
dGhyZWFkcyBiZWZvcmUgd2Ugam9pbiBhbnkuCj4gQW5kIGFsc28gcHJpbnQgdGhlIHZhbHVlIG9m
IFRJRCBpbiBjYXNlcyB3aGVyZSB0ZXN0IGRldGVjdHMgdHdvIHRocmVhZHMKPiB1c2Ugc2FtZSBv
bmUuCj4KPiBTaWduZWQtb2ZmLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4K
PiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXR0aWQvZ2V0dGlkMDIuYyB8IDE3
ICsrKysrKysrKystLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA3
IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
Z2V0dGlkL2dldHRpZDAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0dGlkL2dl
dHRpZDAyLmMKPiBpbmRleCA2MWYxMTVmYzllN2MuLmVmNDQ3NjFjNDFkZSAxMDA2NDQKPiAtLS0g
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldHRpZC9nZXR0aWQwMi5jCj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXR0aWQvZ2V0dGlkMDIuYwo+IEBAIC0xNiw3ICsxNiw3
IEBACj4KPiAgI2RlZmluZSBUSFJFQURTX05VTSAxMAo+Cj4gLXN0YXRpYyBwaWRfdCB0aWRzW1RI
UkVBRFNfTlVNXTsKPiArc3RhdGljIHZvbGF0aWxlIHBpZF90IHRpZHNbVEhSRUFEU19OVU1dOwo+
Cj4gIHN0YXRpYyB2b2lkICp0aHJlYWRlZCh2b2lkICphcmcpCj4gIHsKPiBAQCAtMjksMjQgKzI5
LDI3IEBAIHN0YXRpYyB2b2lkICp0aHJlYWRlZCh2b2lkICphcmcpCj4gICAgICAgICBUU1RfRVhQ
X0VYUFIocGlkICE9IHRpZCwKPiAgICAgICAgICAgICAgICAgInBhcmVudCBJRCAoJWQpIGRpZmZl
cnMgZnJvbSB0aHJlYWRbJWRdIElEICglZCkiLAo+ICAgICAgICAgICAgICAgICBwaWQsIGksIHRp
ZCk7Cj4gLQo+IC0gICAgICAgcmV0dXJuICh2b2lkICopdHN0X3N5c2NhbGwoX19OUl9nZXR0aWQp
Owo+ICsgICAgICAgdGlkc1tpXSA9IHRpZDsKPiArICAgICAgIHJldHVybiBOVUxMOwo+ICB9Cj4K
PiAgc3RhdGljIHZvaWQgcnVuKHZvaWQpCj4gIHsKPiAtICAgICAgIHB0aHJlYWRfdCB0aHJlYWQ7
Cj4gKyAgICAgICBwdGhyZWFkX3QgdGhyZWFkW1RIUkVBRFNfTlVNXTsKPiArICAgICAgIGludCBh
cmdzW1RIUkVBRFNfTlVNXTsKPiAgICAgICAgIGludCBlcnJvciA9IDA7Cj4KPiAgICAgICAgIGZv
ciAoaW50IGkgPSAwOyBpIDwgVEhSRUFEU19OVU07IGkrKykgewo+IC0gICAgICAgICAgICAgICBT
QUZFX1BUSFJFQURfQ1JFQVRFKCZ0aHJlYWQsIE5VTEwsIHRocmVhZGVkLCAmaSk7Cj4gLSAgICAg
ICAgICAgICAgIFNBRkVfUFRIUkVBRF9KT0lOKHRocmVhZCwgKHZvaWQgKiopJnRpZHNbaV0pOwo+
ICsgICAgICAgICAgICAgICBhcmdzW2ldID0gaTsKPiArICAgICAgICAgICAgICAgU0FGRV9QVEhS
RUFEX0NSRUFURSgmdGhyZWFkW2ldLCBOVUxMLCB0aHJlYWRlZCwgJmFyZ3NbaV0pOwo+ICAgICAg
ICAgfQo+ICsgICAgICAgZm9yIChpbnQgaSA9IDA7IGkgPCBUSFJFQURTX05VTTsgaSsrKQo+ICsg
ICAgICAgICAgICAgICBTQUZFX1BUSFJFQURfSk9JTih0aHJlYWRbaV0sIE5VTEwpOwo+Cj4gICAg
ICAgICBmb3IgKGludCBpID0gMDsgaSA8IFRIUkVBRFNfTlVNOyBpKyspIHsKPiAgICAgICAgICAg
ICAgICAgZm9yIChpbnQgaiA9IGkgKyAxOyBqIDwgVEhSRUFEU19OVU07IGorKykgewo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGlmICh0aWRzW2ldID09IHRpZHNbal0pIHsKPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJ0aHJlYWRbJWRdIGFuZCB0aHJl
YWRbJWRdCj4gaGF2ZSB0aGUgc2FtZSBJRCIsIGksIGopOwo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHN0X3JlcyhUSU5GTywgInRocmVhZFslZF0gYW5kIHRocmVhZFslZF0KPiBo
YXZlIHRoZSBzYW1lIElEICVkIiwgaSwgaiwgdGlkc1tpXSk7Cj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBlcnJvciA9IDE7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgfQo+ICAg
ICAgICAgICAgICAgICB9Cj4gLS0KPiAyLjMxLjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywK
TGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
