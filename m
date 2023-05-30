Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF1CC7EE23
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 12:56:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEE4A3CCF9A
	for <ltp@archiver.kernel.org>; Tue, 30 May 2023 14:56:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0041F3C9971
 for <ltp@lists.linux.it>; Tue, 30 May 2023 14:56:26 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C1E3E6008D5
 for <ltp@lists.linux.it>; Tue, 30 May 2023 14:56:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685451384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C8fm1ggaTP9rD68u+z1otJxNNf54EAwraCSo9q94Rmc=;
 b=hanl+hu1hLTwZhQsogXQSr3B5+j+R3sp0kncFBU1u0eW6ECjxiEICRddDzSfbzwuezfTI9
 hyM5c9mZz09bTHSCtHsrqpiyP5Y2+yIXFetuPNME1c2WQ52QebPWRj4j6S1aLdIyCxw648
 io3kdtXwCb57rnPEyK33zdK/wNR37wY=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-gGLIdmQFMF-0gLGpmi8_5Q-1; Tue, 30 May 2023 08:56:23 -0400
X-MC-Unique: gGLIdmQFMF-0gLGpmi8_5Q-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af8a985ab2so20739421fa.0
 for <ltp@lists.linux.it>; Tue, 30 May 2023 05:56:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685451380; x=1688043380;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=C8fm1ggaTP9rD68u+z1otJxNNf54EAwraCSo9q94Rmc=;
 b=eXLqq8OPbVHxDPdBCWJBhglrzHibm1YZC1gupavr8R5w6XExV+0Z8Ny2yulWVBNN5y
 3aaAZPALn06enkabTL2+Mz/Achx1LmR8pjKHlpe1JmCAipjlFoVZDYlAJMzl1EFHALlF
 FQxDf3ycgIGefEaGRQM55u53G3lDICBq3U4RhLrgKPHXKTUUKnHKrTrghFhNsZl5mObX
 E2hnp0U/Dd9goikOKqFSDFH2Z0PIiZ27U5CMRt1g/fK17HlhdVEvKaah/zjqEg36B7Jp
 +gCbBtCgkEaWt/PI4K8A+dqTW8Cxcs5/FxfYolqyk0H0t1O3yXzF4reKxrirGMkQv5Ws
 vKZQ==
X-Gm-Message-State: AC+VfDzFxPNBX3FYrDdcLAl/EZsYof1L81BI/xM/JZ25CnMGMC4emC1Q
 O7IxZoeWtDsLvFBStRIMlticSp73KKYUGzzAlG7vyisU+bmWWGhiB1tT0tg5mRIUZDUwDRlD2sU
 wVMInN2lJ1dVBzOo0Ofl7kvkVM8Y=
X-Received: by 2002:a2e:9bd9:0:b0:2ad:d9bd:1d2 with SMTP id
 w25-20020a2e9bd9000000b002add9bd01d2mr727826ljj.16.1685451380326; 
 Tue, 30 May 2023 05:56:20 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5GMoRZIiBOMurizPL9GeLrtiUX6wJQpUVgET4svIne5Gjzc+YuyC+UAvR5OLw25sKERDnZOhclTNn99k2sgdk=
X-Received: by 2002:a2e:9bd9:0:b0:2ad:d9bd:1d2 with SMTP id
 w25-20020a2e9bd9000000b002add9bd01d2mr727809ljj.16.1685451379928; Tue, 30 May
 2023 05:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230530093012.35470-1-liwang@redhat.com>
 <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
In-Reply-To: <8d3e09cc-3d3b-aa8f-1369-28476183b3c9@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 30 May 2023 20:56:08 +0800
Message-ID: <CAEemH2e5eH7Xko=7UDLb_5qK_Bc4fzW6KHo4ERcR+kaKy8o99g@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] shmget02: reduce the shmmax test value in compat
 mode
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 Manfred Spraul <manfred@colorfullife.com>, Arnd Bergmann <arnd@arndb.de>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXkgMzAsIDIwMjMgYXQgODo0NuKAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IEhpLAo+Cj4gT24gMzAuIDA1LiAyMyAxMTozMCwgTGkgV2FuZyB3
cm90ZToKPiA+IEFzIEFybmQgQmVyZ21hbm4gcG9pbnRlZCBvdXQgdGhhdCBTSE1NQVggYmVpbmcg
ZGVmaW5lZCBhcwo+ID4gKFVMT05HX01BWCAtICgxVUwgPDwgMjQpKSwgc28gdGhlIGtlcm5lbCB3
b3VsZCBsaWtlbHkgdXNlCj4gPiBhIGxhcmdlIDY0LWJpdCB2YWx1ZSwgd2hpbGUgdGhlIDMyLWJp
dCB1c2VyIHNwYWNlIHVzZXMgYQo+ID4gbXVjaCBzbWFsbGVyIGxpbWl0Lgo+ID4KPiA+IEl0IGZp
bmFsbHkgcmVzdWx0cyBpbiBFTk9NRU0gZmFpbHVyZToKPiA+ICAgIHNobWdldDAyLmM6OTU6IFRG
QUlMOiBzaG1nZXQoMTY0NDE5OTgyNiwgNDI3ODE5MDA4MCwgMTUzNikKPiA+ICAgICAgICAgICAg
ICAgICAgIGV4cGVjdGVkIEVJTlZBTDogRU5PTUVNICgxMikKPiA+Cj4gPiBXaXRoIHN1Z2dlc3Qg
YnkgTWFuZnJlZCBTcHJhdWwgd2UgY291bGQgcmVkdWNlIHRoZSB2YWx1ZQo+ID4gb2YgJy9wcm9j
L3N5cy9rZXJuZWwvc2htbWF4JyBpbiBjb21wYXQgbW9kZSBhbmQgb25seSB0ZXN0Cj4gPiB0aGUg
b3ZlcmZsb3cgYmVoYXZpb3Igd2l0aCBkZWZhdWx0KzEuCj4gPgo+ID4gUmVwb3J0ZWQtYnk6IExp
bnV4IEtlcm5lbCBGdW5jdGlvbmFsIFRlc3RpbmcgPGxrZnRAbGluYXJvLm9yZz4KPiA+IFNpZ25l
ZC1vZmYtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgo+ID4gQ2M6IE5hcmVzaCBLYW1i
b2p1IDxuYXJlc2gua2FtYm9qdUBsaW5hcm8ub3JnPgo+ID4gQ2M6IEFybmQgQmVyZ21hbm4gPGFy
bmRAYXJuZGIuZGU+Cj4gPiBDYzogTWFuZnJlZCBTcHJhdWwgPG1hbmZyZWRAY29sb3JmdWxsaWZl
LmNvbT4KPiA+IC0tLQo+ID4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1nZXQv
c2htZ2V0MDIuYyB8IDEwICsrKysrKysrKysKPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEwIGluc2Vy
dGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
cGMvc2htZ2V0L3NobWdldDAyLmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3No
bWdldC9zaG1nZXQwMi5jCj4gPiBpbmRleCA3OTg5ZWYzM2UuLmZhZjYzM2FkNCAxMDA2NDQKPiA+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvaXBjL3NobWdldC9zaG1nZXQwMi5jCj4g
PiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9zaG1nZXQvc2htZ2V0MDIuYwo+
ID4gQEAgLTU2LDcgKzU2LDExIEBAIHN0YXRpYyBzdHJ1Y3QgdGNhc2Ugewo+ID4gICAgICAgeyZz
aG1rZXkxLCBTSE1fU0laRSwgSVBDX0VYQ0wsIDAsIDAsIEVOT0VOVH0sCj4gPiAgICAgICB7JnNo
bWtleSwgU0hNX1NJWkUsIElQQ19DUkVBVCB8IElQQ19FWENMLCAwLCAwLCBFRVhJU1R9LAo+ID4g
ICAgICAgeyZzaG1rZXkxLCBTSE1NSU4gLSAxLCBJUENfQ1JFQVQgfCBJUENfRVhDTCwgMCwgMCwg
RUlOVkFMfSwKPiA+ICsjaWZkZWYgVFNUX0FCSTMyCj4gPiArICAgICB7JnNobWtleTEsIDgxOTIg
KyAxLCBJUENfQ1JFQVQgfCBJUENfRVhDTCwgMCwgMCwgRUlOVkFMfSwKPiA+ICsjZWxzZQo+ID4g
ICAgICAgeyZzaG1rZXkxLCBTSE1NQVggKyAxLCBJUENfQ1JFQVQgfCBJUENfRVhDTCwgMCwgMCwg
RUlOVkFMfSwKPiA+ICsjZW5kaWYKPiA+ICAgICAgIHsmc2hta2V5LCBTSE1fU0laRSAqIDIsIElQ
Q19FWENMLCAwLCAwLCBFSU5WQUx9LAo+ID4gICAgICAgeyZzaG1rZXksIFNITV9TSVpFLCBTSE1f
UkQsIDEsIDAsIEVBQ0NFU30sCj4gPiAgICAgICB7JnNobWtleTEsIFNITV9TSVpFLCBJUENfQ1JF
QVQgfCBTSE1fSFVHRVRMQiwgMCwgMSwgRVBFUk19LAo+ID4gQEAgLTE0OSw0ICsxNTMsMTAgQEAg
c3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gICAgICAgLnRlc3QgPSBkb190ZXN0
LAo+ID4gICAgICAgLnRjbnQgPSBBUlJBWV9TSVpFKHRjYXNlcyksCj4gPiAgICAgICAuaHVnZXBh
Z2VzID0ge1RTVF9OT19IVUdFUEFHRVN9LAo+ID4gKyNpZmRlZiBUU1RfQUJJMzIKPiA+ICsgICAg
IC5zYXZlX3Jlc3RvcmUgPSAoY29uc3Qgc3RydWN0IHRzdF9wYXRoX3ZhbFtdKSB7Cj4gPiArICAg
ICAgICAgICAgIHsiL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXgiLCAiODE5MiIsIFRTVF9TUl9UQlJP
S30sCj4gPiArICAgICAgICAgICAgIHt9Cj4gPiArICAgICB9LAo+ID4gKyNlbmRpZgo+ID4gICB9
Owo+Cj4gQ291bGQgdGhpcyBiZSBkb25lIHdpdGhvdXQgdGhlIGNvbmRpdGlvbmFsIGNvbXBpbGF0
aW9uPyBGb3IgZXhhbXBsZQo+IGNoYW5nZSB0aGUgdGVzdGNhc2UgdG8gY3VzdG9tIHNobW1heCBs
aW1pdCB1bmNvbmRpdGlvbmFsbHkgb3IgcmVhZCB0aGUKPiBhY3R1YWwga2VybmVsIGxpbWl0IGZy
b20gL3Byb2Mvc3lzL2tlcm5lbC9zaG1tYXggaW4gc2V0dXAoKS4KPgoKVGhhdCBjb3VsZCB3b3Jr
IGFzIHdlbGwsIGJ1dCBJIHRob3VnaHQgdGhhdCBtaWdodCBhIGJpdCBjb21wbGljYXRlZAp0byBy
ZWFzc2lnbiBhIG5ldyB2YWx1ZSB0byB0aGUgdHdvLWxldmVsIHBvaW50ZXIgJ3RjLT5zaXplJy4K
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
