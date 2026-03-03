Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA4D5EC0495
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 10:10:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 880B73D9EA0
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 11:10:51 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26B3D3D900A
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:10:32 +0100 (CET)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF61810007A6
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:10:31 +0100 (CET)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-65f9a875eabso9978586a12.0
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 02:10:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772532631; cv=none;
 d=google.com; s=arc-20240605;
 b=Ug46sf5wMUgIudiPqs4Vtz1lhNtYeUMHvn1qgs0GszgaxdZjCXHqdfdGVxy4x/RNzJ
 yX1i76ZmmTarhhqwU6fG4d6KTUdYahYajMgYMnd6g55nEoMa4Zkb1XrMK12GmR3D124E
 jns0jUJ2a0CMzCr8ydcjoZIl6IlRITr+Y+gBkhPi9I9lHIYLt0SJkqv0MeruI2knVSsV
 tcwTuoOU6CJQJSJvbqv1RqTYOvwRP5+LZNJyc3o+2ReMsvi4FLTiHVfjXD6HusHH4YkE
 5iLGXWm/oLDX66Nw6pKDsifbUercB+dGeCaLvXQ+CqgV5Sc+oiUhZUAgMLHo3d6rivmp
 CDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Rm03Jy6M2tmnvB6/fsswZW1tKSncH04Pd6CwT1i3jwE=;
 fh=9gnLKwsvpnzU/YlEFOSZYde33imiNn4rWlg4Yym04fw=;
 b=G5uW+giZUI2Hp/NpU8Zq6jOWL5t+SVoGE/akpQoN7D8qGjxAM5TKZ1YFWa1q2W3Xxy
 mDGdiIvpKnzwD8p+/fXv88mZ2eZqBfIBfcGbxQqOzYB8KqKbXN81CNeu0mhdgejc6dPK
 3jpLDcS3QEZWOEbuysLUaRhOvRDw5Zwfpyq2YHcbYpNWq4ml1P4dVp4bKpZFu/UGdrFQ
 1Umqy3+AbiM7uTNst2+tE95tDGD1/NyLGCrsuh70pn+ix7PTYR3kncCZ+ebRauMhGQXt
 lPE1Ay/Lv0GHkZFw/Cxhc7N8xbF/LGoXJmTC2AOgO+6edRRu9kAey6Y3Hv4CkyJ7IpAu
 xj3g==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772532631; x=1773137431; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Rm03Jy6M2tmnvB6/fsswZW1tKSncH04Pd6CwT1i3jwE=;
 b=Mm0O/TIEJqk4KnldjQLXin9E/rFDtztXXAjLCQISJgerhMxQ3gYpzaio6H5KcDaOIL
 7glgGxFIpKrUZNyjcNTfFXsAcj6nn2sPdH9IM2KXDeF4xozeBZSIMOPQiLYMQhTsh7Kw
 iKh/4nif0B7RiDawvSOVTqsM9PfaYPLl8WMQEVOtf5WZnu2ah7Ptmzkssltc6uQtmO+8
 WaUf5rCu/MmwwqXaNR9da5ropnBunEugfGG+e2jkzeF1j6DGfVcZwbcPPt//zZ2MFu8y
 s+ktm8F89fT8KxveMNseVHO466Yp2vJ/uHeSpOzDAh3YYEiqX3mJRWT+xprO9NoT+tgQ
 HA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772532631; x=1773137431;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Rm03Jy6M2tmnvB6/fsswZW1tKSncH04Pd6CwT1i3jwE=;
 b=gGnQAesUHWM6a1Cq9XinkpgvteOgjihglaJBh5Cws4W4IGO4NTtCgBz5a+4ILkbajb
 zMkjzPKJgX8n/m/UiJwxP1antuCf2UB2emnG/h1LtDOkacaZytg60fbPcBmJvpouzfpM
 RYeYVafz32Zrlb70UpUysYOHz3+rfK1NiSB7i+z8DNaz+e+hep9Q/IFTzUqjKCwMHlX7
 uxipAwRXabyjtMYpZ1L9ilwLB/Vsp97XbZi0sd3dVXeGP9Pne0SgCetT950f1EIqsF1B
 t7W9mfmuB6U9Pad9n/IUrRWWx+U8YZpOMqdczXyjJAhikfGI5vhZnQFJEEFWg1JB3RlR
 DrKA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8P0swwTmrCd//nzhnP4dkh/hviKjeQqcwZhff3h8Yux1gqzTlOJBIPZ1J4lUzye97y3o=@lists.linux.it
X-Gm-Message-State: AOJu0Yzg2kiCLf+6VRH3ST5D4mWvBl48CSVRQw1PzO1aGozB8bIM8W3K
 y6mf2fpwS8Sx8oeJGhvO1ZrqSslpYPAa+8vOppgebwAmtI40mV4bXoEWFxRiK0K5NFz5G2JXza1
 XIHJExgZdy34H0EAau12LoouIRAxOWGw=
X-Gm-Gg: ATEYQzy4LXkQsGmxSxSXSbCo67+Aj3CANY1ZRZFwQAZu70fUrcYgUOa4U/yMkSp/esI
 ntKv2wwCuNJA0RTGbE3gogmV6FPEuA8oKdCqODRrt9H+MF4fsuTR4L8/AJWS/VDemcThUMPmcTn
 vnW8uGB6GVvsA46WHAyeIShf77XkbE9mBTTqdN9JOctILj5E8T4jFdCejdURZVngk1QjCoTSbfo
 oleC1fbhWxMgQ990c04B2EL96rXGDqpt5CGXHBNFfcRTcnnQVA6PcPR039cYUAp4giI5ZohCc3h
 873UILsTIDEqxbrdyb1ow+0YSIce7/Uhw05CmewP
X-Received: by 2002:a17:906:fe01:b0:b87:965:9079 with SMTP id
 a640c23a62f3a-b937637a66amr830937566b.3.1772532630732; Tue, 03 Mar 2026
 02:10:30 -0800 (PST)
MIME-Version: 1.0
References: <20260302144446.1291724-1-amir73il@gmail.com>
 <aaWvOIlfyIDH7J8A@yuki.lan>
 <CAOQ4uxhpcC76cpj21Dv-279FnVgHLSjCXmYKxu526jV-Uo7G_w@mail.gmail.com>
 <10488dc1-a369-4ad1-b26b-23118f6c9801@suse.cz>
 <CAOQ4uxhqubq4wy8Y5TkOVgtU0VgTcztJnrbycVC=idO_-XbKww@mail.gmail.com>
 <65ea5139-5b0b-41c0-9262-403b9a75fe35@suse.cz>
In-Reply-To: <65ea5139-5b0b-41c0-9262-403b9a75fe35@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 3 Mar 2026 11:10:19 +0100
X-Gm-Features: AaiRm53gQGDhsO-3dzmOXVyn5GVXpHVfmagApaV7emYX-cNIfQODAqclyUW4kyQ
Message-ID: <CAOQ4uxgpzhh3a4sDk5LVHP5MC+vPVRWTFNa551xYYu6pCsdSGg@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: fix test failure on kernel with
 CONFIG_MODULES=n
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBNYXIgMywgMjAyNiBhdCAxMDo1OeKAr0FNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cj4KPiBPbiAzLzMvMjYgMTA6NTQsIEFtaXIgR29sZHN0ZWluIHdyb3Rl
Ogo+ID4gT24gVHVlLCBNYXIgMywgMjAyNiBhdCAxMDo0OeKAr0FNIE1hcnRpbiBEb3VjaGEgPG1k
b3VjaGFAc3VzZS5jej4gd3JvdGU6Cj4gPj4KPiA+PiBIaSwKPiA+PiBob3cgYWJvdXQgb29tX2tp
bGxfcHJvY2VzcygpPyBUaGF0IG9uZSdzIHVuY29uZGl0aW9uYWxseSBhdmFpbGFibGUgYW5kCj4g
Pj4gc2hvdWxkbid0IGdldCBjYWxsZWQgdmVyeSBvZnRlbiBpbiBhIHJlYXNvbmFibGUgdGVzdCBl
bnZpcm9ubWVudCBlaXRoZXIuCj4gPgo+ID4gV2h5IGRvZXMgaXQgbWF0dGVyIGhvdyBtdWNoIHRo
ZSBmdW5jdGlvbiBnZXRzIGNhbGxlZD8KPiA+IElzbid0IHRoYXQgaXJyZWxldmFudCBmb3IgdGhl
IHRlc3Q/Cj4KPiBJJ3ZlIHdyaXR0ZW4gdGhlIHRlc3QgdG8gdGVzdCBhIHNwZWNpZmljIGZhbm90
aWZ5IHJlZ3Jlc3Npb24uIFRyYWNpbmcgYQo+IHN5c2NhbGwgdGhhdCBnZXRzIGNhbGxlZCB0b28g
b2Z0ZW4gY291bGQgaW5jcmVhc2Ugc3lzdGVtIGxvYWQgYW5kIGNoYW5nZQo+IHRpbWluZyBvZiB0
aGUgcmFjZSB3aGljaCBJJ20gdHJ5aW5nIHRvIHRyaWdnZXIgd2l0aCBpdC4KPgoKV2hpY2ggZmFu
b3RpZnkgcmVncmVzc2lvbj8KQXMgYSByZXZpZXdlciwgSSBnb3Qgbm8gaW5kaWNhdGlvbiBpbiB0
aGUgY29tbWl0IG1lc3NhZ2UsClRlc3QgZGVzY3JpcHRpb24sIG5vciBpbiBMVFAgdHN0X3Rlc3Qg
dGFncyB0aGF0IHRoaXMgaXMgYSB0ZXN0IGZvciBhIHJlZ3Jlc3Npb24uCgpJIGhhdmUgbm8gb2Jq
ZWN0aW9uIHdoYXRzb2V2ZXIgdG8gdXNpbmcgYW55IG90aGVyIHN5bWJvbCBhdmFpbGFibGUKaW4g
bW9zdCBvZiB0aGUgY29tbW9uIGJ1aWxkcy4KQWx0ZXJuYXRpdmVseSwgdGhlIHRlc3QgY291bGQg
dGVzdCBmb3IgdGhlIGRlc2lyZWQgY29uZmlndXJhdGlvbi4KCkJ1dCBpZiB0aGUgdGVzdCBpcyBt
ZWFudCB0byB0cmFjayBhIHJlZ3Jlc3Npb24sIHRoZW4gKnBsZWFzZSogZG9jdW1lbnQKdGhlIHJl
Z3Jlc3Npb24gaW4gdGhlIHRlc3QgZGVzY3JpcHRpb24gYW5kIHRoZSBmaXggY29tbWl0IGlmIHN1
Y2ggZml4CmV4aXN0cyBpbiBMVFAgdHN0X3Rlc3QgdGFncy4KClRoYW5rcywKQW1pci4KCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
