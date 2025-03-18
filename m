Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF291C282EC
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 04:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742271658; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=H956dJigzvIWMpvjuUgPHBS+M8Gxiy7S54laihqvFHU=;
 b=I9v6gKslnbOcw6BeBZZqDNGKkWtKva0tYwdSorgwNOjfDpRE5ToKjc6wbgSoHaZzDAE2y
 vahmEpxMee0OXK7/omSWDk0k878DYU5zM2CvPz4vSamytGsX/6hS/yb4do1fTh6m6ISr5hJ
 QR7ocbcuaxBmBDXTz40NMhwgHLsrrDY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B9CA3CAB94
	for <ltp@archiver.kernel.org>; Tue, 18 Mar 2025 05:20:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 353153C9FBB
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 05:20:35 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 58A8D600944
 for <ltp@lists.linux.it>; Tue, 18 Mar 2025 05:20:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742271631;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j3q9Ei8bYF9j0htJvDHLvBpd8P1P4bBk2wol4LQ6RuQ=;
 b=P0yElLZmyyJTlpWtf/UgDd7WBb8idL4/7p9A89wD+iP6SVpBIUJNtcFyKfC2CXHjvEPiHR
 gGBGPzGpwnlwjw/XXdOhjC4mCgW/NYuktAgAEpWKsc2Zd6FZt6dY9Wx8jhzdiPstpKJz/i
 GGa6EIqTUCNMfCJgKkqTrOCQ5bUNy+E=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-HYFc1FnVOGu2JkzayhFGYQ-1; Tue, 18 Mar 2025 00:20:29 -0400
X-MC-Unique: HYFc1FnVOGu2JkzayhFGYQ-1
X-Mimecast-MFC-AGG-ID: HYFc1FnVOGu2JkzayhFGYQ_1742271628
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2fec3e38c2dso7625836a91.2
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 21:20:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742271628; x=1742876428;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=j3q9Ei8bYF9j0htJvDHLvBpd8P1P4bBk2wol4LQ6RuQ=;
 b=NOWFS2bF9BwnulF5YNAouFU3GBdwtq/o8H4QOcwpKyO1lbWx2tm6Sm5yqLkef3SalA
 +Je73HvqjjI7O4mwd5rTbxO79V+iMg2W83yN+6IA3A/FciCu9iLILiHftonL6GkaCKMj
 ia6upVhMHHcKqihyACidOvsynrrITZ7uuj3JbL25Iv3xdYlBD7we7n9xUHhmsOGTENxg
 4i7z0lVARS72A2l+R0YJv32MJSd7jLrH5yaLaIYMjVUMFh2+OT0kDF2ziqc8AXdG7BXf
 2hoCBb1/arqkr6EcqU8egl6IK2okiUGPzqZ7pwEo2PflxuORupVD3K34FofbAsow/slB
 7DTA==
X-Gm-Message-State: AOJu0YxphKYYUEStSN+QMXnamTVjE9z41e0/OGdp0VopFS+t9hOX85zp
 ocuN9mhgq/y8nsIwpRcanHXc6Iko6JT5CzPvHF/sCYr5HcszfG9Q7zPmfs21Pnvtdb6vfsjnT+c
 /usmy8wNwK9qOUv65/TPtbZs+m+nUxbWzDPI/bLbfPMSvGOtnLClUzmnpxEw/6uuL9M9GMR3FlG
 DQ3OTZRzzZjHHVOWx18aeldfc=
X-Gm-Gg: ASbGncty8oMIFnYNTe1zoHgzKJNvKQocJg6WZmiYYB5WM1/xLFXhHJzhaRGXKB5J0Hp
 GR0g7FT8XYrrT2e2lDpK5kV4ksAzv9+5q3Q03bOKI/h519jtMP/mspwfCF/fEst76tvrU1tSI2A
 ==
X-Received: by 2002:a17:90b:1b47:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-301a5b14c80mr1210261a91.12.1742271628062; 
 Mon, 17 Mar 2025 21:20:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4tkjIyTmF4SdBJEdvjfaH47QHgWqxWhGf5a8S+WymdO4v32u3LsjTH/bHusr/G/ETDHSgP2Bp4BiJ+yGjl2k=
X-Received: by 2002:a17:90b:1b47:b0:2ee:8ea0:6b9c with SMTP id
 98e67ed59e1d1-301a5b14c80mr1210225a91.12.1742271627550; Mon, 17 Mar 2025
 21:20:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250314124242.459072-1-pvorel@suse.cz>
In-Reply-To: <20250314124242.459072-1-pvorel@suse.cz>
Date: Tue, 18 Mar 2025 12:20:14 +0800
X-Gm-Features: AQ5f1JrOuh9xZjAaf4wkrNLeuE9otdnKdr-20Gsw3PIBJs_B670dBtr3US_MP80
Message-ID: <CAEemH2ejo61V9v=BXRt+cVL-roNLFuyKpY2MC_dYW+iJJ3ZrAQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gukqEclvYDms-qNf0cyOqlKSODtvg6FSUVSIAaA2cXk_1742271628
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] ima_violations.sh: Fix condition evaluation
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMTQsIDIwMjUgYXQgODo0M+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gRXZhbHVhdGlvbiAiLWd0IDAiIG5lZWRzIHRvIGJlIHRvZ2V0aGVyIHdp
dGggZXhwZWN0YXRpb24gb2YgZW1wdHkKPiAkZXhwZWN0ZWRfdmlvbGF0aW9ucy4gVGhlcmVmb3Jl
IHVzZSBbIC4uLiAtYSAuLi4gXSBjb21wYXJhdG9yIHRvIGF2b2lkCj4gLWVxIGNvbXBhcmlzb24g
YWdhaW5zdCBlbXB0eSAkZXhwZWN0ZWRfdmlvbGF0aW9ucy4KPgo+ICAgICAjIExUUFJPT1Q9L29w
dC9sdHAgUEFUSD0iL29wdC9sdHAvdGVzdGNhc2VzL2JpbjokUEFUSCIKPiBMVFBfSU1BX0xPQURf
UE9MSUNZPTEgaW1hX2tleXMuc2gKPiAgICAgaW1hX2tleXMgMSBUSU5GTzogL3Byb2MvY21kbGlu
ZToKPiBCT09UX0lNQUdFPS9ib290L3ZtbGludXotNi4xNC4wLXJjMy0xLmdiNmI0MTAyLWRlZmF1
bHQgc2VjdXJpdHk9YXBwYXJtb3IKPiBpZ25vcmVfbG9nbGV2ZWwgaW1hX3BvbGljeT10Y2IKPgo+
ICAgICAjIExUUFJPT1Q9L29wdC9sdHAgUEFUSD0iL29wdC9sdHAvdGVzdGNhc2VzL2JpbjokUEFU
SCIKPiBpbWFfdmlvbGF0aW9ucy5zaAo+ICAgICAuLi4KPiAgICAgL29wdC9sdHAvdGVzdGNhc2Vz
L2Jpbi9pbWFfdmlvbGF0aW9ucy5zaDogbGluZSA5NTogWzogMDogdW5hcnkKPiBvcGVyYXRvciBl
eHBlY3RlZAo+ICAgICBpbWFfdmlvbGF0aW9ucyAxIFRGQUlMOiBvcGVuX3dyaXRlcnMgdmlvbGF0
aW9uIG5vdCBhZGRlZAo+ICAgICBpbWFfdmlvbGF0aW9ucyAyIFRJTkZPOiB2ZXJpZnkgVG9NVG9V
IHZpb2xhdGlvbgo+ICAgICAvb3B0L2x0cC90ZXN0Y2FzZXMvYmluL2ltYV92aW9sYXRpb25zLnNo
OiBsaW5lIDk1OiBbOiAwOiB1bmFyeQo+IG9wZXJhdG9yIGV4cGVjdGVkCj4gICAgIGltYV92aW9s
YXRpb25zIDIgVEZBSUw6IFRvTVRvVSB2aW9sYXRpb24gbm90IGFkZGVkCj4gICAgIGltYV92aW9s
YXRpb25zIDMgVElORk86IHZlcmlmeSBvcGVuX3dyaXRlcnMgdXNpbmcgbW1hcHBlZCBmaWxlcwo+
ICAgICB0c3RfdGVzdC5jOjE5MDA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNTAxMzAtMjItZ2Nk
MjIxNTcwMmYKPiAgICAgdHN0X3Rlc3QuYzoxOTA0OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi4x
NC4wLXJjMy0xLmdiNmI0MTAyLWRlZmF1bHQKPiAjMSBTTVAgUFJFRU1QVF9EWU5BTUlDIFRodSBG
ZWIgMjAgMTI6MjY6NTUgVVRDIDIwMjUgKGI2YjQxMDIpIHg4Nl82NAo+ICAgICB0c3Rfa2NvbmZp
Zy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9jb25maWcuZ3onCj4g
ICAgIHRzdF9rY29uZmlnLmM6Njc2OiBUSU5GTzogQ09ORklHX0ZBVUxUX0lOSkVDVElPTiBrZXJu
ZWwgb3B0aW9uCj4gZGV0ZWN0ZWQgd2hpY2ggbWlnaHQgc2xvdyB0aGUgZXhlY3V0aW9uCj4gICAg
IHRzdF90ZXN0LmM6MTcyMjogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBoIDAy
bSAwMHMKPiAgICAgaW1hX21tYXAuYzozODogVElORk86IHNsZWVwIDNzCj4gICAgIC9vcHQvbHRw
L3Rlc3RjYXNlcy9iaW4vaW1hX3Zpb2xhdGlvbnMuc2g6IGxpbmUgOTU6IFs6IDA6IHVuYXJ5Cj4g
b3BlcmF0b3IgZXhwZWN0ZWQKPiAgICAgaW1hX3Zpb2xhdGlvbnMgMyBURkFJTDogb3Blbl93cml0
ZXJzIHZpb2xhdGlvbiBub3QgYWRkZWQKPgo+IE5PVEU6IFRoaXMgZG9lcyBub3QgZml4IGltYV92
aW9sYXRpb25zLnNoIGZhaWxzIGFmdGVyIGNhdXNlZCBieSB1c2VyCj4gZGVmaW5lZCBwb2xpY3kg
bG9hZGVkIGJ5IGltYV9rZXlzLnNoICh2aWEgTFRQX0lNQV9MT0FEX1BPTElDWT0xKS4KPgo+IEZp
eGVzOiA3MjZlZDcxOTA1ICgiaW1hX3Zpb2xhdGlvbnMuc2g6IFVwZGF0ZSB2YWxpZGF0ZSgpIHRv
IHN1cHBvcnQKPiBtdWx0aXBsZSB2aW9sYXRpb25zIikKPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZv
cmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRo
YXQuY29tPgoKLS0tCj4gIC4uLi9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9p
bWFfdmlvbGF0aW9ucy5zaCAgICAgIHwgMyArLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0
aW9uKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdAo+IGEvdGVzdGNhc2VzL2tlcm5l
bC9zZWN1cml0eS9pbnRlZ3JpdHkvaW1hL3Rlc3RzL2ltYV92aW9sYXRpb25zLnNoCj4gYi90ZXN0
Y2FzZXMva2VybmVsL3NlY3VyaXR5L2ludGVncml0eS9pbWEvdGVzdHMvaW1hX3Zpb2xhdGlvbnMu
c2gKPiBpbmRleCA2MzM0NmU5NDg5Li5jNmI5MjlhMjMzIDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNl
cy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFfdmlvbGF0aW9ucy5zaAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc2VjdXJpdHkvaW50ZWdyaXR5L2ltYS90ZXN0cy9pbWFf
dmlvbGF0aW9ucy5zaAo+IEBAIC05MCw4ICs5MCw3IEBAIHZhbGlkYXRlKCkKPiAgICAgICAgIGZv
ciBpIGluICQoc2VxIDEgJG1heF9hdHRlbXB0KTsgZG8KPiAgICAgICAgICAgICAgICAgcmVhZCBu
dW1fdmlvbGF0aW9uc19uZXcgPCAkSU1BX1ZJT0xBVElPTlMKPiAgICAgICAgICAgICAgICAgY291
bnQyPSIkKGdldF9jb3VudCAkc2VhcmNoKSIKPiAtICAgICAgICAgICAgICAgaWYgWyAteiAiJGV4
cGVjdGVkX3Zpb2xhdGlvbnMiIF0gJiYgXAo+IC0gICAgICAgICAgICAgICAgICBbICQoKCRudW1f
dmlvbGF0aW9uc19uZXcgLSAkbnVtX3Zpb2xhdGlvbnMpKSAtZ3QgMCBdIHx8Cj4gXAo+ICsgICAg
ICAgICAgICAgICBpZiBbIC16ICIkZXhwZWN0ZWRfdmlvbGF0aW9ucyIgLWEgJCgoJG51bV92aW9s
YXRpb25zX25ldyAtCj4gJG51bV92aW9sYXRpb25zKSkgLWd0IDAgXSB8fCBcCj4gICAgICAgICAg
ICAgICAgICAgIFsgJCgoJG51bV92aW9sYXRpb25zX25ldyAtICRudW1fdmlvbGF0aW9ucykpIC1l
cQo+ICRleHBlY3RlZF92aW9sYXRpb25zIF07IHRoZW4KPiAgICAgICAgICAgICAgICAgICAgICAg
ICBbIC16ICIkZXhwZWN0ZWRfdmlvbGF0aW9ucyIgXSAmJgo+IGV4cGVjdGVkX3Zpb2xhdGlvbnM9
MQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmIFsgJGNvdW50MiAtZ3QgJGNvdW50IF07IHRo
ZW4KPiAtLQo+IDIuNDcuMgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
