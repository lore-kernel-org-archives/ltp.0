Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D00BD6ED2A
	for <ltp@archiver.kernel.org>; Thu, 21 Nov 2024 13:18:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 560753D9645
	for <ltp@archiver.kernel.org>; Thu, 21 Nov 2024 14:18:42 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28D9E3D9640
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 14:18:27 +0100 (CET)
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com
 [IPv6:2607:f8b0:4864:20::a2a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A0C4250C72
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 14:18:26 +0100 (CET)
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-50d525be53eso411618e0c.0
 for <ltp@lists.linux.it>; Thu, 21 Nov 2024 05:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732195105; x=1732799905; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jHGeqfcDNyJM+bhXkIg1Ll6hPVXA7GHLELf0rCkyDuw=;
 b=lffQol4Y6T0L56g0gnBRyEJOyS5uYtVFNujL10OlweM5s7s1PnKwoLUq7WGybFzQFe
 ZohaqA+Ncu0negAD3SJv6UMRRgmZMCVOpbqulNXcGi3nZwN3iuFZllvU60tx0hRKLFqr
 18Z9LkZpr9Ml38xxd/sxd/3jirM7Gg6j8CT1iESpMF/3uNhO/pqWTT2nigAUeVpAS5tY
 CyLnC5fG3zZFk2Rvcec42MIGBi80cJWUDxzDeBwFYJtLejl+3Z6FBG7jkvGfT47AaYS/
 BGuuW7PYQvWGvkbwrLpVVQvAWinimyiFnnRdsqCyk5JmYzebnJlG5MS8VsnEvsB7FPlR
 CHgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732195105; x=1732799905;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jHGeqfcDNyJM+bhXkIg1Ll6hPVXA7GHLELf0rCkyDuw=;
 b=P1y6MskJa9xFSh/q7JEaIoFlMIcVqm3didSKz3Zmip2lRQ7DzGfgTUvzV1PxVdXmlo
 XWpP0KaSpoctipTugpR7/jyP7y/wpoz0jrjaNSTPYlVUXTHm0jQ2g89tVTaOGzeg3KWx
 PyoMY1sp2fTp5wPxH7ZpSRKh1Sez/8dQ0FnT7fV1bG6TMmh2jT1ukeADfyAwo9ypk/Q4
 ypulsAiVbbRpPBbeVmX/knHPm/oca/ZTtVCFC8zctWDjFK2fJ2E+WiuNRpq4TAn7mJnX
 Y/6Jm2KnazX/qEzVN7lVdnHNSpG3rGDAeITuljq7LEnXfyc43awdgHxop4xau6dkYa5W
 s8Kw==
X-Gm-Message-State: AOJu0YwLxVu6sdNrXw3z3XTC37Ztl5OV74B+Vh27NzKvH8zNaSAY3cJD
 A0Qk//ShZPtkrJuCOafUdviUyF9dKNNIY3t7/TIRglaIPbeqVItbcmbMwbkmpcPsSz2/ChqwOTv
 U8J4f03DNrnttcu/GwGadYQIM5zU=
X-Gm-Gg: ASbGnctZfMYVUTDZZJCirt9K15OTo8GCeaD5YNhiDjQWFgVIWEJzFPRYKpVp9Kd18pq
 M4g07uWdWxHd6WWG9cw4tBDv10d53nw5BBaVquX3sRqpwKg7YgfK/4AdVIkSFAG1g
X-Google-Smtp-Source: AGHT+IHJ0cxrUOr2oGtMS8SqtDB5arBJXWwDcCt+vf1MN9bnMqbRO5jsG9Ug9YEOCkjGnQJR6YFRu+eqMpWpXcDmJd0=
X-Received: by 2002:a05:6122:a2a:b0:50d:3ec1:154b with SMTP id
 71dfb90a1353d-514cf8885f9mr8653609e0c.3.1732195104883; Thu, 21 Nov 2024
 05:18:24 -0800 (PST)
MIME-Version: 1.0
References: <eb40aae4-1b25-43a7-a592-cf03690edeb8.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSAN9kYUvmRF7ooox3koJjFf+6o73kfEWZ9oiYU2eLDjA@mail.gmail.com>
 <CA+B+MYQPoqtKrnTiVsqyJEvo1_=r3-EJqCQT+RxqfaSG0xXgYw@mail.gmail.com>
 <50668c09-1d9f-4f12-a485-2fa0ff93be35@suse.com>
In-Reply-To: <50668c09-1d9f-4f12-a485-2fa0ff93be35@suse.com>
From: Jin Guojie <guojie.jin@gmail.com>
Date: Thu, 21 Nov 2024 21:18:13 +0800
Message-ID: <CA+B+MYRF=DTNOOqsryusrVRKtay4gy6Gcr5n7zep2uauNZYm2A@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcg/memcontrol04: Fix the judgment error in
 test_memcg_low()
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

V2hlbiBJIHZpc2l0IGh0dHBzOi8vYnVnemlsbGEuc3VzZS5jb20vc2hvd19idWcuY2dpP2lkPTEx
OTYyOTgsIGFuCmVycm9yIG9jY3VycyBzaG93aW5nIHRoYXQKCiJZb3UgYXJlIG5vdCBhdXRob3Jp
emVkIHRvIGFjY2VzcyBidWcgIzExOTYyOTguIgoKSSB0cmllZCB0byByZWdpc3RlciBhbiBhY2Nv
dW50IGJ5IG15c2VsZiwgYnV0IHRoZSBlcnJvciBkaWQgbm90IGNoYW5nZS4KClNvIGZhciwgSSBz
dGlsbCBjYW4ndCB2aWV3IHRoZSBsaW5rLgoKUGxlYXNlIHNlZSBpZiB0aGVyZSBpcyBhIHdheSB0
byBnaXZlIG1lIHBlcm1pc3Npb24gdG8gdmlldyB0aGlzIGJ1Zy4KCk9yLCBjb3VsZCB5b3UgcGxl
YXNlIHByb3ZpZGUgbWUgdGhlIGV4cGxhbmF0aW9uIG9mIHRoaXMgYnVnIGluIHRoZSBlbWFpbO+8
nwoKT24gVGh1LCBOb3YgMjEsIDIwMjQgYXQgNTo0NOKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8KPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGkhCj4KPiBUaGFua3MgZm9yIGNo
ZWNraW5nIHRoaXMgdGVzdCwgYnV0IGRpZCB5b3UgdGFrZSBhIGxvb2sgYXQgdGhlCj4gZXhwbGFu
YXRpb24gZ2l2ZW4gaW4gdGhlIHRlc3QgInRhZ3MiID8gLT4KPiBodHRwczovL2J1Z3ppbGxhLnN1
c2UuY29tL3Nob3dfYnVnLmNnaT9pZD0xMTk2Mjk4Cj4KPiBSZWdhcmRzLAo+IEFuZHJlYQo+Cj4g
T24gMTEvMjEvMjQgMDQ6MDUsIEppbiBHdW9qaWUgd3JvdGU6Cj4gPiBXaGVuIHJ1bm5pbmcgbWVt
Y29udHJvbDA0LCBURkFJTCByZXN1bHRzIHdpbGwgYXBwZWFyIG9uIHZhcmlvdXMgTGludXgKPiA+
IGRpc3RyaWJ1dGlvbnMsIGtlcm5lbCB2ZXJzaW9ucywgYW5kIENQVXM6Cj4gPgo+ID4gKDEpIFRl
c3QgcGxhdGZvcm0KPiA+Cj4gPiAqIExpbnV4IGRpc3RyaWJ1dGlvbjogVWJ1bnR1IDI0LjEwCj4g
PiAqIENQVTogWDg2XzY0LCBBcm02NAo+ID4gKiBLZXJuZWw6IDYuNiBsb25ndGVybQo+ID4gKiBn
bGliYzogIDIuNDAKPiA+ICogTFRQIHZlcnNpb246ICBjb21taXQgZWM0MTYxMTg2ZTUsIE9jdCAy
NCAxMjoxODoxNyAyMDI0Cj4gPgo+ID4gKDIpIEVycm9yIGxvZ3MKPiA+Cj4gPiBEdXJpbmcgdGhl
IG9wZXJhdGlvbiBvZiBtZW1jb250cm9sMDQsIGZpbGUgc3lzdGVtcyBzdWNoIGFzIGV4dDIsIGV4
dDMsCj4gPiBleHQ0LCB4ZnMsIG50ZnMsIGFuZCB2ZmF0IHdpbGwgYmUgdGVzdGVkLgo+ID4gRm9y
IGFueSBvZiB0aGUgZmlsZSBzeXN0ZW0sIHRoZSBzYW1lIFRGQUlMIHJlc3VsdCB3aWxsIGFwcGVh
cjoKPiA+Cj4gPiByb290QHZtOn4vbHRwL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVt
Y2cjIC4vbWVtY29udHJvbDA0Cj4gPgo+ID4gdHN0X3Rlc3QuYzoxODIzOiBUSU5GTzogPT09IFRl
c3Rpbmcgb24gZXh0MiA9PT0KPiA+IG1lbWNvbnRyb2wwNC5jOjIwODogVFBBU1M6IEV4cGVjdDog
KEMgb29tIGV2ZW50cz0wKSA9PSAwCj4gPiBtZW1jb250cm9sMDQuYzoyMTE6IFRQQVNTOiBFeHBl
Y3Q6IChDIGxvdyBldmVudHM9NDM3KSA+IDAKPiA+IG1lbWNvbnRyb2wwNC5jOjIwODogVFBBU1M6
IEV4cGVjdDogKEQgb29tIGV2ZW50cz0wKSA9PSAwCj4gPiBtZW1jb250cm9sMDQuYzoyMTE6IFRQ
QVNTOiBFeHBlY3Q6IChEIGxvdyBldmVudHM9NDM3KSA+IDAKPiA+IG1lbWNvbnRyb2wwNC5jOjIw
ODogVFBBU1M6IEV4cGVjdDogKEUgb29tIGV2ZW50cz0wKSA9PSAwCj4gPiBtZW1jb250cm9sMDQu
YzoyMTQ6IFRQQVNTOiBFeHBlY3Q6IChFIGxvdyBldmVudHM9MCkgPT0gMAo+ID4gbWVtY29udHJv
bDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoRiBvb20gZXZlbnRzPTApID09IDAKPiA+IG1lbWNv
bnRyb2wwNC5jOjIxNDogVEZBSUw6IEV4cGVjdDogKEYgbG93IGV2ZW50cz00MTIpID09IDAKPiA+
Cj4gPiB0c3RfdGVzdC5jOjE4MjM6IFRJTkZPOiA9PT0gVGVzdGluZyBvbiBleHQzID09PQo+ID4g
bWVtY29udHJvbDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoQyBvb20gZXZlbnRzPTApID09IDAK
PiA+IG1lbWNvbnRyb2wwNC5jOjIxMTogVFBBU1M6IEV4cGVjdDogKEMgbG93IGV2ZW50cz00Mzcp
ID4gMAo+ID4gbWVtY29udHJvbDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoRCBvb20gZXZlbnRz
PTApID09IDAKPiA+IG1lbWNvbnRyb2wwNC5jOjIxMTogVFBBU1M6IEV4cGVjdDogKEQgbG93IGV2
ZW50cz00MzcpID4gMAo+ID4gbWVtY29udHJvbDA0LmM6MjA4OiBUUEFTUzogRXhwZWN0OiAoRSBv
b20gZXZlbnRzPTApID09IDAKPiA+IG1lbWNvbnRyb2wwNC5jOjIxNDogVFBBU1M6IEV4cGVjdDog
KEUgbG93IGV2ZW50cz0wKSA9PSAwCj4gPiBtZW1jb250cm9sMDQuYzoyMDg6IFRQQVNTOiBFeHBl
Y3Q6IChGIG9vbSBldmVudHM9MCkgPT0gMAo+ID4gbWVtY29udHJvbDA0LmM6MjE0OiBURkFJTDog
RXhwZWN0OiAoRiBsb3cgZXZlbnRzPTQxMSkgPT0gMAo+ID4KPiA+IC4uLi4uLgo+ID4KPiA+IFN1
bW1hcnk6Cj4gPiBwYXNzZWQgICA1NQo+ID4gZmFpbGVkICAgNQo+ID4gYnJva2VuICAgMAo+ID4g
c2tpcHBlZCAgMAo+ID4gd2FybmluZ3MgMAo+ID4KPiA+IEl0IGxvb2tzIGxpa2UgdGhlcmUgaXMg
YW4gZXJyb3IgaW4gdGhlIHByb2Nlc3NpbmcgbG9naWMgb2YgY2dyb3VwIEYuCj4gPgo+ID4gKDMp
IENhdXNlIGFuYWx5c2lzCj4gPgo+ID4gSW4gdGhlIHRlc3RfbWVtY2dfbG93KCkgZnVuY3Rpb24s
IDQgc3ViZ3JvdXBzIChDLCBELCBFLCBGKSBhcmUgY3JlYXRlZCB1bmRlciBCLAo+ID4gYW5kIDUw
TUIgcGFnZWNhY2hlIGlzIGFsbG9jYXRlZCBpbiBDLCBELCBhbmQgRi4gVGhlcmVmb3JlLCB3aGVu
IGNoZWNraW5nIHdoZXRoZXIKPiA+IGl0IGlzIHN1Y2Nlc3NmdWwgYXQgdGhlIGVuZCwgb25seSBF
IHNob3VsZCBiZSBqdWRnZWQgdG8gaGF2ZSBsb3dfZXZlbnRzPT0wLAo+ID4gYW5kIHRoZSBqdWRn
bWVudCBjb25kaXRpb25zIGZvciBhbGwgb3RoZXIgc3ViZ3JvdXBzIHNob3VsZCBiZSBsb3dfZXZl
bnRzID4gMC4KPiA+Cj4gPiAoNCkgRml4IGlzc3VyZQo+ID4KPiA+ICMxMjA5Cj4gPiBodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9pc3N1ZXMvMTIwOQo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IEppbiBHdW9qaWUgPGd1b2ppZS5qaW5AZ21haWwuY29tPgo+ID4KPiA+IC0t
LQo+ID4gICB0ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL21lbWNvbnRyb2wwNC5j
IHwgMiArLQo+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24o
LSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9jb250cm9sbGVycy9tZW1j
Zy9tZW1jb250cm9sMDQuYwo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNn
L21lbWNvbnRyb2wwNC5jCj4gPiBpbmRleCAxYjhkMTE1ZjguLjBkZGRiNzQ0OSAxMDA2NDQKPiA+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0LmMK
PiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvbWVtY29udHJvbDA0
LmMKPiA+IEBAIC0yMDcsNyArMjA3LDcgQEAgc3RhdGljIHZvaWQgdGVzdF9tZW1jZ19sb3codm9p
ZCkKPiA+Cj4gPiAgICAgICAgICAgICAgICAgIFRTVF9FWFBfRVhQUihvb20gPT0gMCwgIiglYyBv
b20gZXZlbnRzPSVsZCkgPT0gMCIsIGlkLCBvb20pOwo+ID4KPiA+IC0gICAgICAgICAgICAgICBp
ZiAoaSA8IEUpIHsKPiA+ICsgICAgICAgICAgICAgICBpZiAoaSAhPSBFKSB7Cj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgVFNUX0VYUF9FWFBSKGxvdyA+IDAsCj4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICIoJWMgbG93IGV2ZW50cz0lbGQpID4gMCIsIGlkLCBs
b3cpOwo+ID4gICAgICAgICAgICAgICAgICB9IGVsc2Ugewo+ID4gLS0KPiA+IDIuNDUuMgo+ID4K
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
