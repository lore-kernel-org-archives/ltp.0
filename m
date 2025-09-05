Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48910CA1012
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 00:55:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757033717; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6JXk7RUYsOvNIYTHQD0AjZO8g3U6cPDczSPMaIL19vU=;
 b=G+unbM9FumTCmwEyvSziKqqzxKX029ouD69TatUB7G5mSaGppVz5wKQUo8n6DlijMz1YK
 MDgx1h5dIi2VwZ4JaDTkhBCz0jMEzX8oSzMYf99ORuTDpgkYAn6VxAM9PyrCyQpJ35mTswy
 hw2q+ADWfSw5XMXqzzLkQsgafdwT+Yc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DAA93CD4CD
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 02:55:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27F7F3C59AC
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 02:54:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E7D3260091E
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 02:54:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757033691;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oKpfRT7mB+IoW0t2QYM6V1sETjnSHh249wSWQn/ZCDE=;
 b=ATLV859oPYNVCD6mhKxv7pAJlNHqnKkWxMo3j6D931mHhR/cz1Nq7efRje/ifMwE48MbfJ
 LSjpgxu1uzSqNjR1U71GzXqB86+n1Luv2+D4PJRR9lZx3dAtEgBekLAsAzk1JiHvDxp9Vi
 1oDrb8g1hZPzKdBJ+l6ZYsnyCp9VKuk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-ZUgWaiLaO5C0NyH4XwNV9Q-1; Thu, 04 Sep 2025 20:54:49 -0400
X-MC-Unique: ZUgWaiLaO5C0NyH4XwNV9Q-1
X-Mimecast-MFC-AGG-ID: ZUgWaiLaO5C0NyH4XwNV9Q_1757033686
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-24a9de13b7eso20733705ad.0
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 17:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757033686; x=1757638486;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oKpfRT7mB+IoW0t2QYM6V1sETjnSHh249wSWQn/ZCDE=;
 b=cxktw5E1ca1VMYOLzGnff9wpBzD2ykvN26tninLMdzLorhgCJceukOX1mQJ4UANaVu
 RX4W1ITZap1LlQX9vp4e00PEm980lqFxAElP6QoIeZRuf7PXG+XKZ/Mq0ZfAIJzmuiVB
 8e36vO3fCFrobRTTKOV8w/jvB/uINN576OhTFadkYgcCS22IjZWY3jVaA3+kNR5iB1b7
 DIljA1x2AMocw/UWHpQ0TLVwCqSyG60k1G6W9HFtb0I2WHI/EXUaB5mbzPhvexb+JYka
 nh7Q7g023HVnReuMeuj3xmRvSPLhwpOEGSnxY/v6Pa6Mf11K37JEMqkux8Cw9H44crhH
 b14A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXh0fRek5P2sGKFHyHYUEnuxAhjpoDYaAPjoOXDECavJhNWUgluqJ92MrW8mQ7C0RGR+wI=@lists.linux.it
X-Gm-Message-State: AOJu0YzXuJtWXoLe7DtGtUImW097f20HpCxYvhzv6KRVeZiemdW3RR0o
 PiraB1kXtqSdzMhswVcjRiigbzxgR+t66uu8OT/R951LLqjE1yL0ensYLL44twfV47UMApEYIUW
 9zA/FIrNyG/p+vKzh/Nvbo1XUjkzXKZXItXfTdNYFSfL5HE8DXxVIOBgybfgqeO/qp1N79XQJtP
 H7azgRcDTd7MqqwiK2xMT6AAr1bpM=
X-Gm-Gg: ASbGncvjE8egBL/SyrGicvgcUc4Q2OfMQixGK89XH3mpAhINmNBWVQTPWBt39JM3WUw
 NZa72/a6z+EE7CVo1dHoP53uGkKCoJyNuO43ldLm24zd9Ujr04lRrw9QD0rohkquRspUtEGGXPr
 RknqRZ46dCfQPkqz/DDdUv4w==
X-Received: by 2002:a17:903:240a:b0:24c:b3b5:303e with SMTP id
 d9443c01a7336-24cb3b53071mr83382825ad.25.1757033685944; 
 Thu, 04 Sep 2025 17:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsclwd/4rbT0wUhqcbsJywOzDrv8F5D45JsRnjmKC8mGjKvCqxSiQh4MJSNKqC0KH6bGcd6HCaUsEAto3dmIk=
X-Received: by 2002:a17:903:240a:b0:24c:b3b5:303e with SMTP id
 d9443c01a7336-24cb3b53071mr83382665ad.25.1757033685515; Thu, 04 Sep 2025
 17:54:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
In-Reply-To: <aLmwLn9RDo2qmk7K@yuki.lan>
Date: Fri, 5 Sep 2025 08:54:32 +0800
X-Gm-Features: Ac12FXwUHZY69Og3Djmn__LPmz1yWpkhpeZXqFcXYdaQeTpWAkg-P6l2-c1p8KE
Message-ID: <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RuCFkMkN9ww8u7lvshCnHsvq0EMnizGMPPMpdriUpHQ_1757033686
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBTZXAgNCwgMjAyNSBhdCAxMToyOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+ID4gPiAgc3RhdGljIHZvaWQgZG9fc2V0dXAodm9p
ZCkKPiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiArICAgaWYgKCF0c3RfY2hlY2tfcHJlZW1wdF9ydCgp
KQo+ID4gPiA+ID4gKyAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlRlc3QgcmVxdWlyZXMgcmVh
bC10aW1lIGtlcm5lbCIpOwo+ID4gPiA+Cj4gPiA+ID4gSSB1bmRlcnN0b29kIEN5cmlsIGlzIHJl
YWxseSBzdWdnZXN0aW5nIHRvIGtlZXAgaXQgWzFdLiBJIHdvdWxkIGFsc28KPiA+ID4gdm90ZSB0
bwo+ID4gPiA+IGtlZXAgaXQgKHdlIHN0aWxsIGhhdmUgc29tZSB0aW1lIHRvIHNlZSBpZiBpdCBn
b3QgZml4ZWQgYmVmb3JlCj4gcmVsZWFzZSkuCj4gPiA+ID4KPiA+ID4gPiBJIGtub3cgd2UgaGFk
IHRoaXMgZGlzY3Vzc2lvbiBpbiB0aGUgcGFzdCAoc29tZSBvZiB5b3VyIGNvbGxlYWd1ZQo+ID4g
PiBzdWdnZXN0aW5nIGl0Cj4gPiA+ID4gc2hvdWxkIG5vdCBiZSBydW4gb24gbm9uLVJUIGtlcm5l
bCksIHNvIEknbSBub3QgcHVzaGluZyBmb3IgaXQuCj4gPiA+Cj4gPiA+IEkgc3RpbCBkbyBub3Qg
dW5kZXJzdGFuZCByZWFzb25zIGZvciBkaXNhYmxpbmcgdGhlIHRlc3QuIFRoZSBQT1NJWAo+ID4g
PiByZWFsdGltZSBzY2hlZHVsbGluZyBjbGFzc2VzIGhhdmUgdG8gd29yayBwcm9wZXJseSByZWdh
cmRsZXNzIG9mIHRoZQo+ID4gPiBrZXJuZWwgZmxhdm9yLiBXaHkgc2hvdWxkIHdlIHR1cm4gdGhl
IHRlc3Qgb2ZmIG9uIG5vbi1ydCBrZXJuZWwgdGhlbj8KPiA+ID4KPiA+Cj4gPiBObyBzcGVjaWFs
IHJlYXNvbnMuIEkgc3RpbGwgY2FuIHNwb3JhZGljYWxseSBjYXRjaCB0aGUgZmFpbHVyZSBvbiBu
b24tUlQKPiA+IGtlcm5lbCB3aXRoIGV2ZW4gc2xlZXAgMiBzZWNvbmRzLgo+Cj4gVGhhdCBpcyB2
ZXJ5IHN0cmFuZ2UuIFRoZSBTQ0hFRF9GSUZPIHRocmVhZHMgc2hvdWxkIHByZWVtcHR5IGFueSBs
b3dlcgo+IHByaW8gdGhyZWFkIGFzIGxvbmcgYXMgdGhleSBiZWNvbWUgcnVuYWJsZSBhbmQgc2hv
dWxkIHN0YXkgcnVubmluZyB1bnRpbAo+IHRoZXkgZmluaXNoIG9yIHlpZWxkLiBUd28gc2Vjb25k
cyBzaG91bGQgYmUgbW9yZSB0aGFuIGVub3VnaCBmb3IgdGhhdCB0bwo+IGhhcHBlbi4KPgo+ID4g
VGh1cywgSSB0b29rIHRoaXMgdmVyeSBleHRyZW1lIGFwcHJvYWNoLCBiZWNhdXNlIG9uIG5vbi1S
VCBrZXJuZWwsIHNsZWVwCj4gPiBtYXkgbm90IGhhdmUgYSBwYXJ0aWN1bGFybHkgcGVyZmVjdCBl
ZmZlY3QsIEkgZ3Vlc3MgdGhlIHN0b2NrIGtlcm5lbCB3aXRoCj4gPiBzY2hlZF9zZXRzY2hlZHVs
ZXIoLCBTQ0hFRF9GSUZPLCApIGlzIHN0aWxsIGhhcyBzY2hlZHVsaW5nIHNrZXcgd2l0aAo+ID4g
d29ya2xvYWQuCj4KPiBEb2VzIHRoaXMgaGFwcGVuIG9uIHZhbmlsbGEgTGludXggYXMgd2VsbCBv
ciBvbmx5IG9uIFJlZEhhdCBrZXJuZWxzPwo+CgpZZXMsIGJvdGggdmFuaWxsYSBMaW51eCBhbmQg
Q2VudE9TIGtlcm5lbHMuCgptb3JlIENJIHRlc3QgaGlzdG9yeSBmb3Igc2NoZWRfZm9vdGJhbGw6
CgogICBXaXRob3V0IGJhcnJpZXIgcGF0Y2g6CiAgICAgICAgICAgRmFpbHMgb24gYm90aCBSVCBh
bmQgbm9uLVJUIENlbnRPUyBTdHJlYW0gOS8xMCBrZXJuZWxzCiAgICAgICAgICAgRmFpbHMgb24g
bm9uLVJUIG1haW5saW5lIHY2LjE3LXJjNCBrZXJuZWxzLiAobm90IGJ1aWxkIHY2LjE3IFJUCmtl
cm5lbCkKCiAgKF4gdGhhdCdzIHdoeSB3ZSBzdGFydGVkIHRvIGxvb2sgaW50byB0aGUgZmFpbHVy
ZSBhbmQgc3VibWl0IHRoZSBjb21taXQKZTUyM2JhODhkZDliKQoKICAgV2l0aCBiYXJyaWVyIHBh
dGNoOgogICAgICAgICAgIEZhaWxzIG9uIGJvdGggUlQgYW5kIG5vbi1SVCBDZW50T1Mga2VybmVs
cywgYnV0IHRoZSBmaW5hbCBiYWxsCnBvc2l0aW9uIGlzIG5vdGljZWFibHkgbG93ZXIuCiAgICAg
ICAgICAgRmFpbHMgb24gbm9uLVJUIG1haW5saW5lIHY2LjE3LXJjNCBrZXJuZWxzLiAobm90IGJ1
aWxkIHY2LjE3IFJUCmtlcm5lbCkKCiAgIFdpdGggYmFycmllciBwYXRjaCArIGtpY2tvZmYgZmxh
ZyBlbmhhbmNlbWVudDoKICAgICAgICAgICBGYWlscyBvbiB0aGUgbm9uLVJUIENlbnRPUyBTdHJl
YW0gMTAga2VybmVsCiAgICAgICAgICAgRmFpbHMgb24gbm9uLVJUIG1haW5saW5lIHY2LjE3LXJj
NCBrZXJuZWwuIChub3QgYnVpbGQgdjYuMTcKUlQta2VybmVsKQogICAgICAgICAgIFBhc3NlZCBv
biBSVCBDZW50T1Mgc3RyZWFtIGtlcm5lbAoKKF4gaGVyZSBJIHN0YXJ0ZWQgdG8gc3VzcGVjdCB0
aGUgU0NIRURfRklGTyB0aHJlYWRzIGNhbiBub3QgcGVyZm9ybSB3ZWxsCmxpa2UgUlQta2VybmVs
KQoKCltyb290QGRlbGwtcGVyNzYyNS0wMSBzY2hlZF9mb290YmFsbF0jIHVuYW1lIC1yCjYuMTcu
MC1yYzQubGl3YW5nCgpbcm9vdEBkZWxsLXBlcjc2MjUtMDEgc2NoZWRfZm9vdGJhbGxdIyAuL3Nj
aGVkX2Zvb3RiYWxsCnRzdF90ZXN0LmM6MjAwNDogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDUz
MAp0c3RfdGVzdC5jOjIwMDc6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE3LjAtcmM0Lmxpd2Fu
ZyAjMSBTTVAKUFJFRU1QVF9EWU5BTUlDIFRodSBTZXAgIDQgMjA6MDc6MjAgRURUIDIwMjUgeDg2
XzY0CnRzdF9rY29uZmlnLmM6ODg6IFRJTkZPOiBQYXJzaW5nIGtlcm5lbCBjb25maWcKJy9saWIv
bW9kdWxlcy82LjE3LjAtcmM0Lmxpd2FuZy9idWlsZC8uY29uZmlnJwp0c3Rfa2NvbmZpZy5jOjY3
NjogVElORk86IENPTkZJR19GQVVMVF9JTkpFQ1RJT04ga2VybmVsIG9wdGlvbiBkZXRlY3RlZAp3
aGljaCBtaWdodCBzbG93IHRoZSBleGVjdXRpb24KdHN0X3Rlc3QuYzoxODI1OiBUSU5GTzogT3Zl
cmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDJtIDAwcwpzY2hlZF9mb290YmFsbC5jOjE2Mjog
VElORk86IHBsYXllcnNfcGVyX3RlYW06IDMyIGdhbWVfbGVuZ3RoOiA1CnNjaGVkX2Zvb3RiYWxs
LmM6MTc4OiBUSU5GTzogU3RhcnRpbmcgMzIgb2ZmZW5zZSB0aHJlYWRzIGF0IHByaW9yaXR5IDE1
CnNjaGVkX2Zvb3RiYWxsLmM6MTg1OiBUSU5GTzogU3RhcnRpbmcgMzIgZGVmZW5zZSB0aHJlYWRz
IGF0IHByaW9yaXR5IDMwCnNjaGVkX2Zvb3RiYWxsLmM6MTkyOiBUSU5GTzogU3RhcnRpbmcgNjQg
Y3JhenktZmFuIHRocmVhZHMgYXQgcHJpb3JpdHkgNTAKc2NoZWRfZm9vdGJhbGwuYzoxMTg6IFRJ
TkZPOiBTdGFydGluZyByZWZlcmVlIHRocmVhZApzY2hlZF9mb290YmFsbC5jOjEyMTogVElORk86
IFN0YXJ0aW5nIHRoZSBnYW1lICg1IHNlYykKc2NoZWRfZm9vdGJhbGwuYzoxNDQ6IFRJTkZPOiBG
aW5hbCBiYWxsIHBvc2l0aW9uOiAyMDIwNQpzY2hlZF9mb290YmFsbC5jOjE1MDogVEZBSUw6IEV4
cGVjdDogZmluYWxfYmFsbCA9PSAwCgpTdW1tYXJ5OgpwYXNzZWQgICAwCmZhaWxlZCAgIDEKYnJv
a2VuICAgMApza2lwcGVkICAwCndhcm5pbmdzIDAKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
