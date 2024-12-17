Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26447E77183
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 03:47:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFE5B3EC6F8
	for <ltp@archiver.kernel.org>; Tue, 17 Dec 2024 04:46:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 968CE3EC6AC
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 04:46:43 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 85606141CA01
 for <ltp@lists.linux.it>; Tue, 17 Dec 2024 04:46:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734407200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WP/0mMC2omDPFpkNn4KSm1nldwiWocfPRrG9Uol/Ul0=;
 b=IQoA6V7+U1udCIyPVnyA7QcAughUsQ2zC/91l0eHlkUXoGBsHQqYVpvoiopTXfXASeeBMD
 TFcLuTyLwR8r4KL3ooU+c+1esv8L9XN8+AyBTpeLsIGimgV3BnjzCWqhYEiiHA2dxKdnLM
 ltCF8fxANZwrjU6urgJKLfYC5cZO2aY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-WpHk8PnROtmj6QI6jaPVLw-1; Mon, 16 Dec 2024 22:46:36 -0500
X-MC-Unique: WpHk8PnROtmj6QI6jaPVLw-1
X-Mimecast-MFC-AGG-ID: WpHk8PnROtmj6QI6jaPVLw
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2eebfd6d065so6588118a91.3
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 19:46:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734407195; x=1735011995;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WP/0mMC2omDPFpkNn4KSm1nldwiWocfPRrG9Uol/Ul0=;
 b=QYE1osS5uNmOA6c8T7FqbAXpEPE6ex7tg2ZYlow2Pg9DB/NVcBxO7+SVVDIdnpqg4/
 vBvYGX7sY0x7HiZ/hQIr/+xQctDnwYSjXjMyouSy4pev6Ni7xkjfpFzjxtTkGv7Ow5fx
 z4ISvDySYhFQ3PmLg9IkU7w2uKmmGXtJfLUr8/CcRhAhj87plZ2/0PSae4RgC2pxh9xL
 hqhgtuJYRXJxzKGJ1mcDww9dXJKQLqu86w5CVlVyd+Ar0xHvAddNiTHvkoFvZnw2IeYv
 BFkPgGottklmuh1T5PuRt06t8/RfoGljOeGxw05977VST8F3xbq5n0GL3hvDUzOEy/LR
 sYdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV5zWUKm+JYpZwB4IjeSlJfrfmiVh8pKSq6P867bYfij4dYJyljwLaKtHqRQibIDnOAdFk=@lists.linux.it
X-Gm-Message-State: AOJu0YzuZzxvK3N5N84+wKoaqpX7d99RsXnoGKOVWVE4Z05w1VyX4qJm
 z0Nm1jzleTPXA81L/KXii1ygFd4FcIKSaEg8g2aL70n52Jwy0mA2/vYU6laaEbgXtyK8X2ODtNI
 99O/yZ73un3NrPQeG3F2pPkTzAXStOfhbRC+HNq6ZPiOWO2Sr6SxQF+hfK7q8SzDUreOvW4SsoZ
 Nn55VIxZq5F+4rLL5XGDspJp0=
X-Gm-Gg: ASbGncuVqj250U2p8Qjh5+AewEGzvblwtYKOnyB5tLCaYVKfLymaF6rdoup/MHifS4/
 yd+1MS+0qOoL4rDB2v9pfKIPEYaZvl4XYgr88b7E=
X-Received: by 2002:a17:90b:2807:b0:2ee:6263:cc0c with SMTP id
 98e67ed59e1d1-2f2901b7d57mr22572465a91.37.1734407195666; 
 Mon, 16 Dec 2024 19:46:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF4jiObOVm7jUIAlEv5a+51cCxCxsQVMgRozozZKUF2KZHmuaq+tsjEQy/qGTStBB9WIxc5WNneuFC1MQvkc9A=
X-Received: by 2002:a17:90b:2807:b0:2ee:6263:cc0c with SMTP id
 98e67ed59e1d1-2f2901b7d57mr22572445a91.37.1734407195287; Mon, 16 Dec 2024
 19:46:35 -0800 (PST)
MIME-Version: 1.0
References: <20241212060448.204158-1-liwang@redhat.com>
 <20241213224041.GB1577592@pevik> <Z2AkZabEU12gomtZ@yuki.lan>
In-Reply-To: <Z2AkZabEU12gomtZ@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Dec 2024 11:46:22 +0800
Message-ID: <CAEemH2fSDPUS0OtXOWhSq=waVqp4GWgb7EKOoZXxvbLywnqhGA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nWo9wx3UEZdiURPaWoj9iX_P-3r4G0-2MrC3l1mSKT8_1734407196
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: multiply the max_runtime if detect slow
 kconfigs
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

T24gTW9uLCBEZWMgMTYsIDIwMjQgYXQgOTowMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+ICsgICBUU1RfS0NPTkZJR19JTklUKCJDT05GSUdf
S0FTQU4iKSwKPiA+ID4gKyAgIFRTVF9LQ09ORklHX0lOSVQoIkNPTkZJR19TTFVCX1JDVV9ERUJV
RyIpLAo+ID4gPiArICAgVFNUX0tDT05GSUdfSU5JVCgiQ09ORklHX1RSQUNFX0lSUUZMQUdTIiks
Cj4gPiA+ICsgICBUU1RfS0NPTkZJR19JTklUKCJDT05GSUdfTEFURU5DWVRPUCIpLAo+ID4gPiAr
ICAgVFNUX0tDT05GSUdfSU5JVCgiQ09ORklHX0RFQlVHX05FVCIpLAo+ID4gPiArICAgVFNUX0tD
T05GSUdfSU5JVCgiQ09ORklHX0VYVDRfREVCVUciKSwKPiA+ID4gKyAgIFRTVF9LQ09ORklHX0lO
SVQoIkNPTkZJR19RVU9UQV9ERUJVRyIpLAo+ID4gPiArICAgVFNUX0tDT05GSUdfSU5JVCgiQ09O
RklHX0ZBVUxUX0lOSkVDVElPTiIpLAo+ID4gPiArICAgVFNUX0tDT05GSUdfSU5JVCgiQ09ORklH
X0RFQlVHX09CSkVDVFMiKQo+ID4gPiArfTsKPiA+ID4gKwo+ID4gPiAraW50IHRzdF9oYXNfc2xv
d19rY29uZmlnKHZvaWQpCj4gPiA+ICt7Cj4gPiA+ICsgICB1bnNpZ25lZCBpbnQgaTsKPiA+ID4g
Kwo+ID4gPiArICAgdHN0X2tjb25maWdfcmVhZChzbG93X2tjb25maWdzLCBBUlJBWV9TSVpFKHNs
b3dfa2NvbmZpZ3MpKTsKPiA+ID4gKwo+ID4gTWF5YmUgaGVyZSBUSU5GTyBtZXNzYWdlICJjaGVj
a2luZyBmb3Igb3B0aW9ucyB3aGljaCBzbG93IHRoZSBleGVjdXRpb24/Cj4gPiBPciBwcmludCBp
dCAob25jZSkgb25seSBpZiBvcHRpb24gZGV0ZWN0ZWQ/IEJlY2F1c2UgaXQncyBub3Qgb2J2aW91
cyB3aHkKPiB3ZSBhcmUKPiA+IGRldGVjdGluZyBpdC4gT3IgYWZ0ZXIgc2VhcmNoaW5nIHByaW50
IHdoYXQgd2UgZGlkICg0eCBwcm9sb25nZWQKPiBydW50aW1lKS4KPiA+Cj4gPiA+ICsgICBmb3Ig
KGkgPSAwOyBpIDwgQVJSQVlfU0laRShzbG93X2tjb25maWdzKTsgaSsrKSB7Cj4gPiA+ICsgICAg
ICAgICAgIGlmIChzbG93X2tjb25maWdzW2ldLmNob2ljZSA9PSAneScpIHsKPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLAo+ID4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIiVzIGtlcm5lbCBvcHRpb24gZGV0ZWN0ZWQiLAo+ID4gPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgc2xvd19rY29uZmlnc1tpXS5pZCk7Cj4gPiA+ICsgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIDE7Cj4gPiA+ICsgICAgICAgICAgIH0KPiA+ID4gKyAgIH0KPiA+ID4gKwo+ID4g
PiArICAgcmV0dXJuIDA7Cj4gPiA+ICt9Cj4gPiA+IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3Qu
YyBiL2xpYi90c3RfdGVzdC5jCj4gPiA+IGluZGV4IDhkYjU1NGRlYS4uZjRlNjY3MjQwIDEwMDY0
NAo+ID4gPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+ID4gPiArKysgYi9saWIvdHN0X3Rlc3QuYwo+
ID4gPiBAQCAtNTU1LDYgKzU1NSw5IEBAIHN0YXRpYyBpbnQgbXVsdGlwbHlfcnVudGltZShpbnQg
bWF4X3J1bnRpbWUpCj4gPgo+ID4gPiAgICAgcGFyc2VfbXVsKCZydW50aW1lX211bCwgIkxUUF9S
VU5USU1FX01VTCIsIDAuMDA5OSwgMTAwKTsKPiA+Cj4gPiA+ICsgICBpZiAodHN0X2hhc19zbG93
X2tjb25maWcoKSkKPiA+ID4gKyAgICAgICAgICAgbWF4X3J1bnRpbWUgKj0gNDsKPiA+IE1heWJl
IG5vdGUgaGVyZSB3aGF0IHdlIGRvPyAoVElORk8pCj4KPiBUaGF0IHJlYWxseSBkZXBlbmRzIG9u
IGhvdyB2ZXJib3NlIHdlIHdhbnQgdG8gYmUsIHdlIGFscmVhZHkgcHJpbnQgdGhlCj4gb3ZlcmFs
bCB0ZXN0IHRpbWVvdXQgd2hpY2ggaXMgdGltZW91dCArIHJ1bnRpbWUuIFNvIGl0J3Mgc29tZWhv
dyB2aXNpYmxlCj4gaW4gdGhlIHRlc3QgcnVudGltZSBoYXMgYmVlbiBpbmNyZWFzZWQuIE1heWJl
IHdlIHNob3VsZCBtYWtlIHRoZSBpbmZvCj4gbWVzc2FnZSBpbiBzZXRfdGltZW91dCgpIGJldHRl
ciBieSBwcmludGluZyB0aGUgcnVudGltZSBzZXBhcmF0ZWx5IHRoZXJlCj4gaWYgbm9uLXplcm8u
Cj4KCllvdSBtZWFuIHdlIGFkZCBvbmUgbGluZSBwcmludCBmb3IgdGhlIG1heF9ydW50aW1lIHNl
cGFyYXRlbHk/ClRoYXQgbWlnaHQgYmUgc28gdmVyYm9zZSB0aGF0IHNvbWV0aW1lcyB0aGUgdGVz
dCBpbnZva2VzCnRzdF9zZXRfbWF4X3J1bnRpbWUoKWl0IHdpbGwgcHJpbnQgdHdpY2UgaW4gdGhl
IGxvZ3MuCgojIC4vc3RhcnZhdGlvbgp0c3RfdG1wZGlyLmM6MzE2OiBUSU5GTzogVXNpbmcgL3Rt
cC9MVFBfc3RhVm9OVDRhIGFzIHRtcGRpciAoeGZzIGZpbGVzeXN0ZW0pCnRzdF90ZXN0LmM6MTg5
NjogVElORk86IExUUCB2ZXJzaW9uOiAyMDI0MDkzMAp0c3RfdGVzdC5jOjE5MDA6IFRJTkZPOiBU
ZXN0ZWQga2VybmVsOgo1LjE0LjAtNTM5LjU4MTJfMTU4MDY0Mzg2My5lbDkueDg2XzY0ICMxIFNN
UCBQUkVFTVBUX0RZTkFNSUMgTW9uIERlYyA5CjE4OjAzOjI2IFVUQyAyMDI0IHg4Nl82NAp0c3Rf
dGVzdC5jOjE3MzE6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcwpzdGFydmF0
aW9uLmM6OTg6IFRJTkZPOiBTZXR0aW5nIGFmZmluaXR5IHRvIENQVSAwCnN0YXJ2YXRpb24uYzo1
MjogVElORk86IENQVSBkaWQgMTIwMDAwMDAwIGxvb3BzIGluIDc1MjkydXMKdHN0X2tjb25maWcu
Yzo4ODogVElORk86IFBhcnNpbmcga2VybmVsIGNvbmZpZwonL2xpYi9tb2R1bGVzLzUuMTQuMC01
MzkuNTgxMl8xNTgwNjQzODYzLmVsOS54ODZfNjQvYnVpbGQvLmNvbmZpZycKdHN0X3Rlc3QuYzox
NzM5OiBUSU5GTzogVXBkYXRpbmcgbWF4IHJ1bnRpbWUgdG8gMGggMDFtIDE1cwp0c3RfdGVzdC5j
OjE3Mjk6IFRJTkZPOiBNYXhfcnVudGltZSBpcyBzZXQgdG8gNzUgc2Vjb25kcwp0c3RfdGVzdC5j
OjE3MzE6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMgMGggMDFtIDQ1cwpzdGFydmF0aW9uLmM6
MTUwOiBUUEFTUzogSGF2ZW4ndCByZXByb2R1Y2VkIHNjaGVkdWxsZXIgc3RhcnZhdGlvbi4KClN1
bW1hcnk6CnBhc3NlZCAgIDEKZmFpbGVkICAgMApicm9rZW4gICAwCnNraXBwZWQgIDAKd2Fybmlu
Z3MgMAoKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
