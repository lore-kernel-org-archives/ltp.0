Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8602EB64DB
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 08:54:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36023CB125
	for <ltp@archiver.kernel.org>; Thu, 22 Jun 2023 10:53:58 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E2C23C9A35
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 10:53:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 609441A00E1C
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 10:53:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687424024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cnzt/WglkTXPYlFQqa1fx2Jz/X3cAqfLVrC7E+jc80s=;
 b=dhQfj9c6A2U4Cuw8CkI+iht4onfWeC8+XIX+7U7P2jO2H9tTY2Y5HIlvlnEB1vqtDkXvTv
 crGq+ZOLR6fzhE5ZKPiO1ZyYHIjU8pjzvbQ1c20fvUcx8nnPiIMUZdNmtJellDoXe4+5y8
 9vPEmdy64wS2Kv/oZjgh3GLX27ZCBx8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-399-NtMy_l4gPay9nG1hv0wKrw-1; Thu, 22 Jun 2023 04:53:43 -0400
X-MC-Unique: NtMy_l4gPay9nG1hv0wKrw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b479d12b31so39055131fa.3
 for <ltp@lists.linux.it>; Thu, 22 Jun 2023 01:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687424020; x=1690016020;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Cnzt/WglkTXPYlFQqa1fx2Jz/X3cAqfLVrC7E+jc80s=;
 b=cQQeQ1Hmui52hwgaa/Z0HX1ytRG/XZiFToW7wx/5BNCd+o6EnH4rXNPm5s/3yVY2sG
 IriVXhk9Afb78auhdVVKMkXEgPIuDeSKfT2hj0l+m3Ez0Qa/LFo5gp9OnOVgPFJkvUOF
 12DtEZyOYQrU1KLGNT0cSNgq/EEOHQOdD6w/eZCtP+ej/mWJ5u+k1+q5fwh/vwxLFZCp
 B5XdQttxkN2519sHG+PrNCfWJi4YkMPgBUAt15M+RDgzTZEcDDqPuXiXMjNUzGtcYMdS
 XUJ31XwhGTbt8raSTpaF9qBuAK1YvC1O2/NHaRuTslvIoJocKg5iNXg9ZVlOz3L6f4Cs
 d9eg==
X-Gm-Message-State: AC+VfDziY5X/eA1m1Rwov3TiqhTu6CDdyARGc3jV56cCeuhSqcqnKlZg
 0heDWWL+yd3fQjkIvlFEct9ZYvWRolzSDhH9Rlrz7CJJVdE9esoMgYlYJyW+EGogMpR1kyipo1I
 afHai5ZPKM059dBShc3rsV4BiL3baJGiEl5HSFnT6
X-Received: by 2002:a2e:9e44:0:b0:2b3:4cff:60ce with SMTP id
 g4-20020a2e9e44000000b002b34cff60cemr10366117ljk.0.1687424020202; 
 Thu, 22 Jun 2023 01:53:40 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7Efxv78Xgjdil5k2klX9nntjQi11E3xhFTjLVw0HDl0jFmbU9XCrPrcxvKxDUC3zcMw0AuqKgKI4m8hal3TOk=
X-Received: by 2002:a2e:9e44:0:b0:2b3:4cff:60ce with SMTP id
 g4-20020a2e9e44000000b002b34cff60cemr10366106ljk.0.1687424019878; Thu, 22 Jun
 2023 01:53:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230601105127.55155-1-liwang@redhat.com>
 <20230621083506.GC361973@pevik>
In-Reply-To: <20230621083506.GC361973@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 22 Jun 2023 16:53:27 +0800
Message-ID: <CAEemH2dQwL10cg3M8Pe3e=Q6X8nmVKtkpSZdv7X6ZFh4gFUNgQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mem: make use of save_restore to simplify code
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

T24gV2VkLCBKdW4gMjEsIDIwMjMgYXQgNDozNeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiB2ZXJ5IG5pY2UgY2xlYW51cCwgdGhhbmtzIQo+Cj4g
Li4uCj4gPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS90dW5hYmxlL292ZXJjb21taXRfbWVt
b3J5LmMKPiA+IEBAIC03MCw3ICs3MCw2IEBACj4gPiAgI2RlZmluZSBFWFBFQ1RfRkFJTCAgICAg
ICAgICAxCj4KPiA+ICBzdGF0aWMgY2hhciAqUl9vcHQ7Cj4gPiAtc3RhdGljIGxvbmcgb2xkX292
ZXJjb21taXRfbWVtb3J5ID0gLTE7Cj4gPiAgc3RhdGljIGxvbmcgb2xkX292ZXJjb21taXRfcmF0
aW8gPSAtMTsKPiA+ICBzdGF0aWMgbG9uZyBvdmVyY29tbWl0X3JhdGlvOwo+ID4gIHN0YXRpYyBs
b25nIHN1bV90b3RhbDsKPiA+IEBAIC05MCwxNiArODksMTEgQEAgc3RhdGljIHZvaWQgc2V0dXAo
dm9pZCkKPiA+ICAgICAgIGxvbmcgbWVtX3RvdGFsLCBzd2FwX3RvdGFsOwo+ID4gICAgICAgc3Ry
dWN0IHJsaW1pdCBsaW07Cj4KPiA+IC0gICAgIGlmIChhY2Nlc3MoUEFUSF9TWVNWTSAib3ZlcmNv
bW1pdF9tZW1vcnkiLCBGX09LKSA9PSAtMSB8fAo+ID4gLSAgICAgICAgIGFjY2VzcyhQQVRIX1NZ
U1ZNICJvdmVyY29tbWl0X3JhdGlvIiwgRl9PSykgPT0gLTEpCj4gPiAtICAgICAgICAgICAgIHRz
dF9icmsoVENPTkYsICJzeXN0ZW0gZG9lc24ndCBzdXBwb3J0Cj4gb3ZlcmNvbW1pdF9tZW1vcnki
KTsKCgoKPiBIZXJlIGlzIHVzZWQgVENPTkYgaW5zdGVhZCBvZiBUQlJPSy4KCgoKPiA+IC0KPiA+
ICAgICAgIGlmIChSX29wdCkKPiA+ICAgICAgICAgICAgICAgb3ZlcmNvbW1pdF9yYXRpbyA9IFNB
RkVfU1RSVE9MKFJfb3B0LCAwLCBMT05HX01BWCk7Cj4gPiAgICAgICBlbHNlCj4gPiAgICAgICAg
ICAgICAgIG92ZXJjb21taXRfcmF0aW8gPSBERUZBVUxUX09WRVJfUkFUSU87Cj4KPiA+IC0gICAg
IG9sZF9vdmVyY29tbWl0X21lbW9yeSA9IGdldF9zeXNfdHVuZSgib3ZlcmNvbW1pdF9tZW1vcnki
KTsKPiA+ICAgICAgIG9sZF9vdmVyY29tbWl0X3JhdGlvID0gZ2V0X3N5c190dW5lKCJvdmVyY29t
bWl0X3JhdGlvIik7Cj4KPiA+ICAgICAgIG1lbV90b3RhbCA9IFNBRkVfUkVBRF9NRU1JTkZPKCJN
ZW1Ub3RhbDoiKTsKPiA+IEBAIC0xMjgsMTQgKzEyMiw2IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZv
aWQpCj4gPiAgICAgICB0c3RfcmVzKFRJTkZPLCAiVG90YWxCYXRjaFNpemUgaXMgJWxkIGtCIiwg
dG90YWxfYmF0Y2hfc2l6ZSk7Cj4gPiAgfQo+Cj4gPiAtc3RhdGljIHZvaWQgY2xlYW51cCh2b2lk
KQo+ID4gLXsKPiA+IC0gICAgIGlmIChvbGRfb3ZlcmNvbW1pdF9tZW1vcnkgIT0gLTEpCj4gPiAt
ICAgICAgICAgICAgIHNldF9zeXNfdHVuZSgib3ZlcmNvbW1pdF9tZW1vcnkiLCBvbGRfb3ZlcmNv
bW1pdF9tZW1vcnksCj4gMCk7Cj4KCgo+IEFsc28gdGhpcmQgcGFyYW1ldGVyIG9mIHNldF9zeXNf
dHVuZSgpIChjaGVjaykgaXMgMC4KPgoKVGhlIGNoZWNrcyBpbnNpZGUgc2V0X3N5c190dWVuKCkg
Y2FuIE5PVCBndWFyYW50ZWUgdGhlCiJvdmVyY29tbWl0X21lbW9yeSIga25vYiBpcyBleGlzdCBv
ciBub3QsIGl0IG9ubHkgZXhhbWluZXMgaWYgdGhlCnZhbHVlIHdhcyBiZWluZyBzZXQgY29ycmVj
dGx5LCBiZWNhdXNlIHNldF9zeXNfdHVuZSBoYXMgZmlyc3QgdXNlClNBRkVfRklMRV9QUklOVEYg
d2hpY2ggd2lsbCBUQlJPSyBkaXJlY3RseSB3aGVuIHRoZSBrbm9iIG5vbi1leGlzdC4KCgo+Cj4g
PiAtICAgICBpZiAob2xkX292ZXJjb21taXRfcmF0aW8gIT0gLTEpCj4gPiAtICAgICAgICAgICAg
IHNldF9zeXNfdHVuZSgib3ZlcmNvbW1pdF9yYXRpbyIsIG9sZF9vdmVyY29tbWl0X3JhdGlvLCAw
KTsKPiA+IC19Cj4gPiAtCj4gPiAgc3RhdGljIHZvaWQgb3ZlcmNvbW1pdF9tZW1vcnlfdGVzdCh2
b2lkKQo+ID4gIHsKPgo+ID4gQEAgLTI2OSw2ICsyNTUsMTAgQEAgc3RhdGljIHN0cnVjdCB0c3Rf
dGVzdCB0ZXN0ID0gewo+ID4gICAgICAgICAgICAgICB7fQo+ID4gICAgICAgfSwKPiA+ICAgICAg
IC5zZXR1cCA9IHNldHVwLAo+ID4gLSAgICAgLmNsZWFudXAgPSBjbGVhbnVwLAo+ID4gICAgICAg
LnRlc3RfYWxsID0gb3ZlcmNvbW1pdF9tZW1vcnlfdGVzdCwKPiA+ICsgICAgIC5zYXZlX3Jlc3Rv
cmUgPSAoY29uc3Qgc3RydWN0IHRzdF9wYXRoX3ZhbFtdKSB7Cj4gPiArICAgICAgICAgICAgIHsi
L3Byb2Mvc3lzL3ZtL292ZXJjb21taXRfbWVtb3J5IiwgTlVMTCwgVFNUX1NSX1RCUk9LfSwKPiA+
ICsgICAgICAgICAgICAgeyIvcHJvYy9zeXMvdm0vb3ZlcmNvbW1pdF9yYXRpbyIsIE5VTEwsIFRT
VF9TUl9UQlJPS30sCj4gPT4gc2hvdWxkbid0IGJlIGhlcmUgVFNUX1NSX1RDT05GIGluc3RlYWQg
b2YgVFNUX1NSX1RCUk9LPwoKCkl0IGRvZXNuJ3QgbWF0dGVyLCBJIGluZGVlZCBjb25zaWRlciB0
aGlzIGJlZm9yZSwgYnV0IGFmdGVyIGxvb2tpbmcKdGhyb3VnaCB0aGUgcmVzdCBtbSB0ZXN0cyB0
aGV5IGFsbCB1c2UgdGhlIGZ1bmN0aW9uIGdldHxzZXRfc3lzX3R1bmUoKQp3aGljaCBjaGVja3Mg
dGhlIGtub2IgbWFuZGF0b3JpbHkgYW5kIHJ1biBzbW9vdGhseSBmb3IgcGFzdAptYW55IHllYXJz
IGFuZCBub2JvZHkgZXZlciBjb21wbGFpbnMgYWJvdXQgdGhhdC4KClNvIEkgdGhpbmsgaXQncyBz
YWZlIHRvIGNvbnZlcnQgdGhpcyBvbmUgdXNpbmcgVEJST0sgdG9vLCBpdCBlc3NlbnRpYWxseQpo
YXMgbm8gZGlmZmVyZW5jZSBmcm9tIG90aGVyIG9vbS10ZXN0cy4gJ292ZXJjb21taXRfcmF0aW8n
IGFuZAonb3ZlcmNvbW1pdF9tZW1vcnknIGFyZSBxdWl0ZSBiYXNpYyBvbiBMaW51eCBkaXN0cmli
dXRpb24uCgoKCj4KPiBJIGFsc28gd29uZGVyIGlmIHRlc3RjYXNlcy9rZXJuZWwvbWVtL3R1bmFi
bGUvbWF4X21hcF9jb3VudC5jCj4gY2FuIHJlcGxhY2Ugb2xkX21heF9tYXBfY291bnQgd2l0aCAu
c2F2ZV9yZXN0b3JlICh3aXRoIFRTVF9TUl9UQ09ORikuCj4KCisxCgo+Cj4gQWxzbyB0ZXN0Y2Fz
ZXMva2VybmVsL21lbS90dW5hYmxlL21pbl9mcmVlX2tieXRlcy5jIGNvdWxkIHVzZQo+IC5zYXZl
X3Jlc3RvcmUgb24gcGFuaWNfb25fb29tIGFuZCBtaW5fZnJlZV9rYnl0ZXMsIHJpZ2h0Pwo+CgpO
bywgJ3BhbmljX29uX29vbScgaXMgYSBkaWZmZXJlbnQgc2NlbmFyaW8sIG1pbl9mcmVlX2tieXRl
cy5jIHRlc3QKanVzdCBjaGVja3MgaWYgdGhhdCB3YXMgYmVpbmcgc2V0IHRvIDEsIGlmIHllcywg
d2UgaGF2ZSB0byBza2lwIHRoZSB3aG9sZQp0ZXN0IHVuY29uZGl0aW9uYWxseSBpbiBjYXNlIG9m
IHRoZSBzeXN0ZW0gb2NjdXJzIHBhbmljLgoKCgo+Cj4gQnV0IHRoZXNlIHR3byBjYW4gYmUgZG9u
ZSBhcyBhIHNlcGFyYXRlIGVmZm9ydC4KPgoKWWVzLCB0aGUgcmVzdCB0d28gc3VnZ2VzdGlvbnMg
c291bmQgZ29vZC4KCj4KPiBPdGhlcndpc2UgTEdUTS4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4KClRoYW5rcyEKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
