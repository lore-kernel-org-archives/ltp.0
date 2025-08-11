Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A10FCA0EC0
	for <ltp@archiver.kernel.org>; Mon, 11 Aug 2025 08:04:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE5383CAE75
	for <ltp@archiver.kernel.org>; Mon, 11 Aug 2025 10:04:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E3B1F3C2CC2
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 10:04:00 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E0A6C60079E
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 10:03:59 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-458bdde7dedso26835005e9.0
 for <ltp@lists.linux.it>; Mon, 11 Aug 2025 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754899439; x=1755504239; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qrJxQM0q95V4mxGTNMDlO1NYGQVXH5lUEtKacKr08MI=;
 b=bnLefPHLe/qZEqABwhYUJ9UwCujGNAKLnVr5qwSBWZTgiTZSrzc+SjRXA2gCSYcrlo
 mz1x2n4hiirMlqZYNa9vwISm/g3/GBFfM4ZPpoGYQjEsbBl26d8yV4eGIRIa6HxTJjbX
 B/5BbklQ+brDaz8ht2v/uSTRT/dQTTcJpuw6azK6qMsZbrfNN0gK7T8cZdDn/klptnYd
 H+YJyd4Xkpm0ct2fjaQ6LVGwpKrg9viIIisu4CTl438VmRmXTgryDReZDjuMKsMzIkX6
 i+gGoNVgyvQOLiA1w2hrCkPkrJYp2N6aruTo8Bgx+Lq6g37HHn2rgLe7alCwIPXf1wOg
 bcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754899439; x=1755504239;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qrJxQM0q95V4mxGTNMDlO1NYGQVXH5lUEtKacKr08MI=;
 b=v2iRg+2Nu67zW/3y9kcvp4AhIm/0jMHHgrAikM0+XZZkUmhEFcibIpHyGS79C0Uf5v
 yjiWjDSKaDe6pnPtNOYsAse5HMAB2UgISd97RNHVTFFQEYN0h1n9lWjwa/BrLqZucACe
 tEGPJZGbBS60fFZwQHHu9crrbizAVe5TCRWeySR8vYFMS+dn/zA0DExrr/rHx0zGfiPt
 iQ/C4H47IorhBMWL6r5oPgDgqHuolxk45YpfiaAFAcpodi5OoTHF8lZezR65XUsjpR38
 MZrA7RoR3bVFyLLcH0KO+qpATIdKkjoWgEuJY7Bf09LEHp2/srX/3KERUU/je6764NAJ
 zpOQ==
X-Gm-Message-State: AOJu0Yz3x/rfHHkGBC42jNf77T/aEeM3Z8d0dHsANbydbV2XW5YnIxRt
 BlLHZaf6JEIhyHuW8zx7IKwOfbsL45jDbr8xyj+D/sNKuPu8UW9Z77Va8eLFEBGhOa0=
X-Gm-Gg: ASbGnctYaSrxKgGCAVfcXL6kiU6AdJcfmAQs8Rna2UWTfg/wIe1w/bh1EFGSmEfctxb
 Sh3bDckEbMz1eDQo3oL/K304mRKFNDKUWB+j7AtNKrvYj8Dmi0RkuwROG9DTdF6PYu01U8E2iWx
 39Ido41T4WYOTINAwOkH7i2ygumiUYqGydTJWIHpFVKumME64Bdvs1q+bINIG1nJNXiNG17j7XN
 /uh6adrsOWxPsRZpaTAIhj5oQu44lPhjgih3kbaQ1j2TyTH64Z2TZlmk3A7yJwZzl3w4ax0OPaW
 baRkAFjr7ApF4/tSXKxShmIzBq66Lz415gyq9z1KuKzr1mtFh+uJ6SWsNydRpTSkrZ4Ifd4B0Fh
 AYGVrcWQU2gd+JDr09i2WHYmJ2sU=
X-Google-Smtp-Source: AGHT+IFOBJHADNMfWlN64TcnWWcCAdYPvMUxPCgavuDGdPDuptiES/Nxr3wdmawi6562rnncvbZxEA==
X-Received: by 2002:a05:600c:46c7:b0:456:1a41:f932 with SMTP id
 5b1f17b1804b1-459f4f048d7mr91998415e9.22.1754899439229; 
 Mon, 11 Aug 2025 01:03:59 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-459e5862be7sm256642295e9.15.2025.08.11.01.03.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Aug 2025 01:03:57 -0700 (PDT)
Date: Mon, 11 Aug 2025 11:03:54 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Li Wang <liwang@redhat.com>
Message-ID: <aJmj6kmNvgzbd1Zi@stanley.mountain>
References: <aJYBSmcQpbHUvOqW@stanley.mountain>
 <CAEemH2cBH+usbwMsHnDW=QM-qDKOCg2wp063O=1gtrRdqNFpug@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cBH+usbwMsHnDW=QM-qDKOCg2wp063O=1gtrRdqNFpug@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03.c is broken for 32bit compat mode
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
Cc: Theodore Grey <theodore.grey@linaro.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU3VuLCBBdWcgMTAsIDIwMjUgYXQgMTE6NDY6MzJBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBIaSBEYW4sCj4gCj4gT24gRnJpLCBBdWcgOCwgMjAyNSBhdCA5OjUz4oCvUE0gRGFuIENhcnBl
bnRlciA8ZGFuLmNhcnBlbnRlckBsaW5hcm8ub3JnPgo+IHdyb3RlOgo+IAo+ID4gSW4gMzJiaXQg
Y29tcGF0IG1vZGUgdGhlIHNobWN0bDAzLmMgdGVzdCB3aWxsIGFsd2F5cyBmYWlsOgo+ID4KPiA+
IHNobWN0bDAzLmM6MzM6IFRGQUlMOiAvcHJvYy9zeXMva2VybmVsL3NobW1heCAhPSAyMTQ3NDgz
NjQ3IGdvdCA0Mjk0OTY3Mjk1Cj4gPiBzaG1jdGwwMy5jOjM0OiBUUEFTUzogL3Byb2Mvc3lzL2tl
cm5lbC9zaG1tbmkgPSA0MDk2Cj4gPiBzaG1jdGwwMy5jOjM1OiBURkFJTDogL3Byb2Mvc3lzL2tl
cm5lbC9zaG1hbGwgIT0gNDI3ODE5MDA3OSBnb3QgNDI5NDk2NzI5NQo+ID4KPiA+IFRoZSB0ZXN0
IGJhc2ljYWxseSBkb2VzIHRoaXM6Cj4gPiAvLyA9PT0gPT09ID09PQo+ID4gI2RlZmluZSBfR05V
X1NPVVJDRQo+ID4gI2luY2x1ZGUgPHN5cy9zaG0uaD4KPiA+ICNpbmNsdWRlIDxzdGRpby5oPgo+
ID4KPiA+IGludCBtYWluKHZvaWQpCj4gPiB7Cj4gPiAgICAgICAgIHN0cnVjdCBzaG1pbmZvIGlu
Zm87Cj4gPgo+ID4gICAgICAgICBzaG1jdGwoMCwgSVBDX0lORk8sIChzdHJ1Y3Qgc2htaWRfZHMg
KikmaW5mbyk7Cj4gPgo+ID4gICAgICAgICBwcmludGYoInNobW1heCA9ICVsdVxuIiwgaW5mby5z
aG1tYXgpOwo+ID4gICAgICAgICBwcmludGYoInNobW1uaSA9ICVsdVxuIiwgaW5mby5zaG1tbmkp
Owo+ID4gICAgICAgICBwcmludGYoInNobWFsbCA9ICVsdVxuIiwgaW5mby5zaG1hbGwpOwo+ID4K
PiA+ICAgICAgICAgcmV0dXJuIDA7Cj4gPiB9Cj4gPiAvLyA9PT0gPT09ID09PQo+ID4KPiA+IEl0
IGNvbXBhcmVzIHRoYXQgb3V0cHV0IHdpdGggd2hhdCB3ZSByZWFkIGZyb20gdGhlIGZpbGUuICBZ
b3UgY2FuIHJ1bgo+ID4gImdjYyAtbTMyIHRlc3QuYyAmJiAuL2Eub3V0IiB0byBzZWUgdGhlIGlz
c3VlLgo+ID4KPiA+IEluIHRoZSBmaXJzdCBsaW5lIHNobW1heCBpcyBub3QgdGhlIHZhbHVlIHRo
YXQgd2UgcmVhZCBmcm9tIHRoZSBmaWxlCj4gPiBiZWNhdXNlIGl0IHdhcyBjYXBwZWQgYXQgSU5U
X01BWCBieSB0aGUga2VybmVsIGluIGNvbW1pdCBhZjdjNjkzZjE0NjAKPiA+ICgiQ2FwIHNobW1h
eCBhdCBJTlRfTUFYIGluIGNvbXBhdCBzaG1pbmZvIikuCj4gPiBodHRwczovL2VsaXhpci5ib290
bGluLmNvbS9saW51eC92Ni4xNi9zb3VyY2UvaXBjL3NobS5jI0wxMzQ3Cj4gPgo+ID4gV2l0aCB0
aGUgbGFzdCBsaW5lIHdlJ3JlIHRyeWluZyB0byBzdG9yZSBhIHU2NCB2YWx1ZSBpbnRvIGEgdTMy
LiAgV2UncmUKPiA+IGdvaW5nIHRvIGxvc2Ugc29tZXRoaW5nIHNvIGl0J3Mgbm90IGdvaW5nIHRv
IGJlIGFjY3VyYXRlLiAgVGhlIGRpZmZlcmVuY2UKPiA+IGlzIGhvdyBzY2FuZigpIHRydW5jYXRl
cyBpdC4gIElmIHlvdSBoYXZlIDMyYml0IGxvbmdzIHRoZW4gaXQgd2lsbCBnaXZlCj4gPiB5b3Ug
dGhlIGZpcnN0IHUzMiBidXQgaWYgeW91IGFzc2lnbiBhIHU2NCB0byBhIHUzMiBsaWtlIHRoZSBy
ZXN0IG9mIHRoZQo+ID4gY29kZSBkb2VzIHRoZW4geW91J2xsIGdldCB0aGUgbGFzdCAzMiBiaXRz
Lgo+ID4KPiA+IFdoYXQncyB0aGUgcmlnaHQgd2F5IHRvIGdvIGFib3V0IGZpeGluZyB0aGlzPwo+
ID4KPiAKPiBNYXliZSB3ZSBjYW4gc2ltcGx5IHNwbGl0IHRoZSBjb21wYXJpc29uIHBhcnQgaW50
byB0d286Cj4gCj4gICAjaWZkZWYgVFNUX0FCSTY0OiBnbyB3aXRoIHRoZSBvcmlnaW5hbCB3YXku
Cj4gCj4gICAjaWZkZWYgVFNUX0FCSTMyOgoKV2lsbCB0aGlzIGFmZmVjdCByZWFsIDMyYml0IHN5
c3RlbXM/ICBUaGUgcHJvYmxlbSBpcyBvbmx5IHdoZW4gd2UncmUKZW11bGF0aW5nIGEgMzJiaXQg
c3lzdGVtIG9uIGEgNjRiaXQgc3lzdGVtIHVzaW5nIHRoZSBDT01QQVQgY29kZS4KCj4gICAgICAg
J3NobW1heCcgZXhwZWN0cyBJTlRfTUFYIGZyb20gc2htY3RsKDAsIElQQ19JTkZPLCAuLi4pLCBl
dmVuIGlmICcKPiAvcHJvYy9zeXMva2VybmVsL3NobW1heCcgaXMgaGlnaGVyLgo+ICAgICAgICdz
aG1hbGwnIGNvbXBhcmVzIHRoZSBsb3dlciAzMiBiaXRzIG9mIHRoZSB2YWx1ZSAoZXhwZWN0X3No
bWFsbCA9Cj4gc2htYWxsICYgMHhGRkZGRkZGRjspCj4gCgpUbyBiZSBob25lc3QsIHRoZSBjb3Jy
ZWN0IHRoaW5nIHdpdGggcmVnYXJkcyB0byBzaG1hbGwgaXMgdG8gY2FwIGl0IGF0CklOVF9NQVgg
aW4gdGhlIGtlcm5lbCBhcyB3ZWxsLiAgSSBkaWRuJ3Qgd2FudCB0byBzdWdnZXN0IHRoaXMgYmVj
YXVzZSBpdAp3YXMgRnJpZGF5IGFmdGVybm9vbi4gIFJlcG9ydGluZyB3aGF0ZXZlciBpcyBpbiB0
aGUgbG93IDMyYml0cyBpcyBzb3J0Cm9mIHJhbmRvbS4gIEJ1dCB0aGF0IHdvdWxkIG1ha2UgaXQg
ZXZlbiBtb3JlIHRyaWNreSB0byBoYW5kbGUgaW4gTFRQLgoKcmVnYXJkcywKZGFuIGNhcnBlbnRl
cgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
