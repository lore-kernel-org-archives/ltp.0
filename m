Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3360C47422
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 10:41:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 425D83D00E8
	for <ltp@archiver.kernel.org>; Fri, 26 Jan 2024 11:41:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12D833C0362
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:40:46 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E0E9C1A00155
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 11:40:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706265644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JNR7g3UVdLig1MA3eUScQf3k9LRhfAlZaHvYdLyzvNE=;
 b=HpnThaiX47tgKjPn9jj8BelP1kngjno17rftCkCZvPYIx4uQJlLVsH5SIPShdP2CJ6MK9R
 c1H/55sC0Fa8FgXluibLbZ0nmHxr3xJ3y+e6idlDIBNs/iLUlIWPs1YyAvZ4x0pKnZMD+C
 0bo42lLVG8eb2wKmZdICdikGKj/WCW4=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-655-9b476ymXNGWAA7GS8HbRPg-1; Fri, 26 Jan 2024 05:40:42 -0500
X-MC-Unique: 9b476ymXNGWAA7GS8HbRPg-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6dde06c6ab0so434141b3a.1
 for <ltp@lists.linux.it>; Fri, 26 Jan 2024 02:40:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706265640; x=1706870440;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JNR7g3UVdLig1MA3eUScQf3k9LRhfAlZaHvYdLyzvNE=;
 b=ZFbit9i21SlHBCXs7BgYrbDTJozeKvR8Z9Hus4MykHChr9iUwnnkrnKEAGZBvbZR4X
 MXLOxwPH8QjMMWTbSUirk9OZavhg9sCMy+QmQ+aJ1PqJ4XjGHP4VBkrYc4u1h/gy75Tt
 Oike3T5B3sqM6J5L3Dq+FREe1Z9SOZ2eZYTAe6tDnZwkNPPepw8fdLFIZgGWD9NooVES
 KxEKnuVUnNSj/QtlQtoN1soCu9zw+ZPrtnrPHvi65sVoB3k5dt7v5kAQnLMqlNmEHCcG
 sgJvQkx5tu01UqBCQsHGDA0WEtFaEv7Y8CbVlaBe+zsvTbdp4DTXtZrMTvzAjtsWtGXd
 PC9w==
X-Gm-Message-State: AOJu0YzZ4RWqbyulPnZnIhSwfm7WnLMevsO46nmb5mtv7WxlTJCPEqKW
 8O6OWb6AV6k5uUWz98GAKefzazN1vCgAsekoA8IalmQfdjA5Nj90wKd93jJDXBNYMBZBRhCD4jO
 A7LiELdq7tc4/2C1vJ4whdRaP/fe+dyjn84Ksv1N7mlX+k+FZdVyTinTmY+ZFvDtbjGvydSeAOY
 4IJLJf/G90Nr6xi8yQjC1DzhkGINqe2HpXsmpq
X-Received: by 2002:a62:cd4b:0:b0:6dd:da40:9493 with SMTP id
 o72-20020a62cd4b000000b006ddda409493mr834194pfg.29.1706265640430; 
 Fri, 26 Jan 2024 02:40:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJtxMvzvPAlz6AJDWdmmbetEAB0QJrXb61Xx5m/rTYqUNc1+pnibkRK+dU/3Knfrz2qmn94rtXGqrfHKumPmo=
X-Received: by 2002:a62:cd4b:0:b0:6dd:da40:9493 with SMTP id
 o72-20020a62cd4b000000b006ddda409493mr834192pfg.29.1706265639961; Fri, 26 Jan
 2024 02:40:39 -0800 (PST)
MIME-Version: 1.0
References: <ZZQHPkwg-W2R1ejJ@yuki> <Zak5QdHCUyUmJ5x4@yuki>
 <CAEemH2dZrhc_1G+PY5s89tQMhQ-F-mVbjBz+_CdbjBYm9CG_Ow@mail.gmail.com>
 <ZbJAKJTVqP9_o2c5@yuki>
In-Reply-To: <ZbJAKJTVqP9_o2c5@yuki>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Jan 2024 18:40:27 +0800
Message-ID: <CAEemH2eb-uEsR0FKSBT-3mcnYO7WecL4sqQMZayitd6QSyFYbA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgNzowNOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUZXN0IGJhc2VkIG9uIHRoZSBsYXRlc3QgTFRQICht
YWluLWJyYW5jaCArIGxpYnN3YXAtcGF0Y2hzZXQpIHJlc3VsdHMgYXM6Cj4KPiBUaGFua3MgYSBs
b3QhCj4KPiA+IHNwbGljZTA3OiByaGVsOS4zICsga2VybmVsLTYuNy4wLCBhbGwtYXJjaGVzCj4g
Pgo+ID4gICAgIDg2ICAgICAgICBzcGxpY2UwNy5jOjYyOiBUSU5GTzogL2Rldi96ZXJvIC0+IC4u
Lgo+ID4gICAgIDg3ICAgICAgICBzcGxpY2UwNy5jOjU0OiBUUEFTUzogc3BsaWNlKCkgb24gL2Rl
di96ZXJvIC0+IGZpbGUgOgo+IEVJTlZBTCAoMjIpCj4gPiAgICAgODggICAgICAgIHNwbGljZTA3
LmM6NTQ6IFRQQVNTOiBzcGxpY2UoKSBvbiAvZGV2L3plcm8gLT4gT19QQVRIIGZpbGUKPiA6IEVC
QURGICg5KQo+ID4gICAgIDg5ICAgICAgICBzcGxpY2UwNy5jOjU0OiBUUEFTUzogc3BsaWNlKCkg
b24gL2Rldi96ZXJvIC0+IGRpcmVjdG9yeSA6Cj4gRUJBREYgKDkpCj4gPiAgICAgOTAgICAgICAg
IHNwbGljZTA3LmM6NTQ6IFRQQVNTOiBzcGxpY2UoKSBvbiAvZGV2L3plcm8gLT4gL2Rldi96ZXJv
IDoKPiBFQkFERiAoOSkKPiA+ICAgICA5MSAgICAgICAgc3BsaWNlMDcuYzo1NDogVFBBU1M6IHNw
bGljZSgpIG9uIC9kZXYvemVybyAtPgo+IC9wcm9jL3NlbGYvbWFwcwo+ID4gOiBFQkFERiAoOSkK
PiA+ICAgICA5MiAgICAgICAgc3BsaWNlMDcuYzo1NDogVFBBU1M6IHNwbGljZSgpIG9uIC9kZXYv
emVybyAtPiBwaXBlIHJlYWQKPiBlbmQgOiBFQkFERiAoOSkKPiA+ICAgICA5MyAgICAgICAgc3Bs
aWNlMDcuYzo1NDogVEZBSUw6IHNwbGljZSgpIG9uIC9kZXYvemVybyAtPiBwaXBlIHdyaXRlCj4g
ZW5kIHN1Y2NlZWRlZAo+Cj4gV2Ugc2VlIHRoYXQgb25lIHRvbywgb24gYSByYW5kb20gc2V0IG9m
IGtlcm5lbHMgdGhlIHNwbGljZSBmcm9tIHplcm8gdG8KPiBwaXBlIHN1Y2NlZWRzLiBXZSBhcmUg
dHJ5aW5nIHRvIGludmVzdGlnYXRlLgo+Cj4gPiAgICAgOTQgICAgICAgIHNwbGljZTA3LmM6NTQ6
IFRQQVNTOiBzcGxpY2UoKSBvbiAvZGV2L3plcm8gLT4gdW5peCBzb2NrZXQKPiA6IEVJTlZBTCAo
MjIpCj4gPiAgICAgOTUgICAgICAgIHNwbGljZTA3LmM6NTQ6IFRQQVNTOiBzcGxpY2UoKSBvbiAv
ZGV2L3plcm8gLT4gaW5ldCBzb2NrZXQKPiA6IEVJTlZBTCAoMjIpCj4gPgo+ID4KPiA+IHByb2Nf
c2NoZWRfcnQwMTogcmhlbC05LjMoNS4xNC4wLTM2Mi44LjEuZWw5XzMpLCBhbGwtYXJjaGVzCj4g
Pgo+ID4gICAgIDEwICAgICAgICBwcm9jX3NjaGVkX3J0MDEuYzo0NTogVEZBSUw6IEV4cGVjdDog
dGltZXNsaWNlX21zID4gMCBhZnRlcgo+ID4gcmVzZXQgdG8gZGVmYXVsdAo+ID4gICAgIDExICAg
ICAgICBwcm9jX3NjaGVkX3J0MDEuYzo1MTogVFBBU1M6IGVjaG8gMCA+Cj4gPiAvcHJvYy9zeXMv
a2VybmVsL3NjaGVkX3J0X3BlcmlvZF91cyA6IEVJTlZBTCAoMjIpCj4gPiAgICAgMTIgICAgICAg
IHByb2Nfc2NoZWRfcnQwMS5jOjUzOiBURkFJTDogZWNobyAtMSA+Cj4gPiAvcHJvYy9zeXMva2Vy
bmVsL3NjaGVkX3J0X3BlcmlvZF91cyBpbnZhbGlkIHJldHZhbCAyOiBTVUNDRVNTICgwKQo+ID4g
ICAgIDEzICAgICAgICBwcm9jX3NjaGVkX3J0MDEuYzo1OTogVFBBU1M6IGVjaG8gLTIgPgo+ID4g
L3Byb2Mvc3lzL2tlcm5lbC9zY2hlZF9ydF9ydW50aW1lX3VzIDogRUlOVkFMICgyMikKPiA+ICAg
ICAxNCAgICAgICAgcHJvY19zY2hlZF9ydDAxLmM6NzI6IFRGQUlMOiBlY2hvIHJ0X3BlcmlvZF91
cysxID4KPiA+IC9wcm9jL3N5cy9rZXJuZWwvc2NoZWRfcnRfcnVudGltZV91cyBpbnZhbGlkIHJl
dHZhbCAxOiBTVUNDRVNTICgwKQo+ID4KPiA+Cj4gPiBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMTog
cmhlbC05LjMoNS4xNC4wLTM2Mi44LjEuZWw5XzMpLCBhbGwtYXJjaGVzCj4gPgo+ID4gICAgICA5
ICAgICAgICBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMS5jOjQ0OiBUSU5GTzogVGVzdGluZyB2YXJp
YW50OiB2RFNPCj4gb3IKPiA+IHN5c2NhbGwgd2l0aCBsaWJjIHNwZWMKPiA+ICAgICAxMCAgICAg
ICAgc2NoZWRfcnJfZ2V0X2ludGVydmFsMDEuYzo2MTogVFBBU1M6Cj4gc2NoZWRfcnJfZ2V0X2lu
dGVydmFsKCkgcGFzc2VkCj4gPiAgICAgMTEgICAgICAgIHNjaGVkX3JyX2dldF9pbnRlcnZhbDAx
LmM6Njg6IFRQQVNTOiBUaW1lIHF1YW50dW0gMHMKPiAxMDAwMDAwMDBucwo+ID4gICAgIDEyICAg
ICAgICBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMS5jOjc2OiBURkFJTDoKPiA+IC9wcm9jL3N5cy9r
ZXJuZWwvc2NoZWRfcnJfdGltZXNsaWNlX21zICE9IDEwMCBnb3QgLTEKPiA+ICAgICAxMyAgICAg
ICAgc2NoZWRfcnJfZ2V0X2ludGVydmFsMDEuYzo0NDogVElORk86IFRlc3RpbmcgdmFyaWFudDoK
PiBzeXNjYWxsCj4gPiB3aXRoIG9sZCBrZXJuZWwgc3BlYwo+ID4gICAgIDE0ICAgICAgICBzY2hl
ZF9ycl9nZXRfaW50ZXJ2YWwwMS5jOjYxOiBUUEFTUzoKPiBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwo
KSBwYXNzZWQKPiA+ICAgICAxNSAgICAgICAgc2NoZWRfcnJfZ2V0X2ludGVydmFsMDEuYzo2ODog
VFBBU1M6IFRpbWUgcXVhbnR1bSAwcwo+IDEwMDAwMDAwMG5zCj4gPiAgICAgMTYgICAgICAgIHNj
aGVkX3JyX2dldF9pbnRlcnZhbDAxLmM6NzY6IFRGQUlMOgo+ID4gL3Byb2Mvc3lzL2tlcm5lbC9z
Y2hlZF9ycl90aW1lc2xpY2VfbXMgIT0gMTAwIGdvdCAtMQo+Cj4gVGhlc2UgYXJlIG1vc3QgbGlr
ZWx5IG1pc3NpbmcgYmFjcG9ydHMgZm9yIHRoZSBzeXNjdGwgZml4ZXMuCj4KCllvdSdyZSByaWdo
dCwgaXQgbGFja3MgdGhlIHR3byBrZXJuZWwgcGF0Y2hlcyB5b3Ugc3VibWl0dGVkOgoKaHR0cHM6
Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXgu
Z2l0L2NvbW1pdC8/aWQ9YzFmYzY0ODRlMWZiCmh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPTA3OWJlOGZj
NjMwOQoKCgo+Cj4gPiBzY2hlZF9nZXRhdHRyMDE6IHJoZWwtOS4zKDUuMTQuMC0zNjIuOC4xLmVs
OV8zKSwgYWxsLWFyY2hlcwo+ID4KPiA+ICAgICAgNyAgICAgICAgc2NoZWRfZ2V0YXR0cjAxICAg
IDEgIFRGQUlMICA6ICBzY2hlZF9nZXRhdHRyMDEuYzo1NzoKPiA+IHNjaGVkX3NldGF0dHIoKSBm
YWlsZWQ6IGVycm5vPUVQRVJNKDEpOiBPcGVyYXRpb24gbm90IHBlcm1pdHRlZAo+Cj4gRG9lcyB0
aGlzIG9uZSBzdGlsbCBmYWlsIG9uIGEgZnJlc2hseSByZWJvb3RlZCBtYWNoaW5lPyBNeSBndWVz
cyBpcyB0aGF0Cj4gaWYgd2Ugc3VjY2VlZCB0byBzZXQgaW52YWxpZCB2YWx1ZXMgaW4gdGhlIHBy
b2Nfc2NoZWRfcnQwMSBpdCBtYXkKPiBjb25mdXNlIHRoZSBrZXJuZWwgZW5vdWdoIHRvIGZhaWwg
dGhpcyB0ZXN0IGFzIHdlbGwuCj4KClRoYW5rcywgSSBjb25maXJtZWQgdGhhdCB0aGUgZmFpbHVy
ZSBpcyBnb25lIGFmdGVyIGEgZnJlc2ggcmVib290LgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
