Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF38ACE7A88
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 05:56:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C0F33CDDFD
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 07:56:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0785E3C9E51
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 07:56:40 +0200 (CEST)
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com
 [IPv6:2607:f8b0:4864:20::f30])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6926E600BB5
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 07:56:40 +0200 (CEST)
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-65af18cac71so5948126d6.1
 for <ltp@lists.linux.it>; Fri, 22 Sep 2023 22:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695448599; x=1696053399; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FYWvm/4SgJ1DnOwyE8GnR0KsTumSCWlYc7xSynW0xVM=;
 b=ERMGjmDlZJv2WmfTvmJZUozOjoqhOJOM/LF+VgQ1HaTFrKn0+BPBxJ/KUGvx8HAGdi
 SYc3BDC+l1bHWwJpJqPIcQWG9T+xdvqy9ACMHjomBad32O++NiHpHYZJLDRoxcJdQ6md
 muIZHvwIxRKnYGG5ClHhXnqPkMawUV5Z7xMhPNCF88+e3nSUgqY/lST5/RSGnP7ZNAAu
 e8BYsadZGlpo8o/0QHmRfG5JSZKEG+Ap886cZQkCLKvNyoCmZUgVE76X3qDT2KwXVFyw
 mrlFRixOihRL3xc3XHfe1N6EL8Otk2ryQsSNCMyFB0Nrqqp2WMG4yE59oDg5BtGuoq0z
 sNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695448599; x=1696053399;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FYWvm/4SgJ1DnOwyE8GnR0KsTumSCWlYc7xSynW0xVM=;
 b=o1JypSSWD3kpyHFOoT5C/8t9i4Ynn5HMGshziA6QVqXv8lJrvTFQgkz+iyOxwd+JS9
 g/PeCK/mLrZIrC6T1thZW3PSm1gSPeTinkp6t677VTsQ6JUjnxsItaVkQ2FF1UwZkUs9
 AGT3+CcBpjNfpABS0yDSpmXWuf4BEX4Z3LLryzf3LevHszkWaZNYtscQwdvFAC8dQyBX
 syihBaykxt7d+xn2PbHE748jS/s27Hwa6ySvIn5Eu0ZGXBxtf2aUPqyeP4831gRzOK57
 kp5sH8SqgXIN/15zN7Xq/Vnl84QmhJjAxkfCAgcj1dOysm0lifASvx3FZArry0ATD2c1
 O9bQ==
X-Gm-Message-State: AOJu0YyjPomOk8rueQ4eq4EMUVWa9OyEGqpqCVb46mDb/D/46ZWTqfV1
 21ry0gknNSwKC7z0VWhzSp3m/XCGS0LNqLTyMiE=
X-Google-Smtp-Source: AGHT+IESwen9eFjqESJ1fXAsIxvoYG12qJbJ3e7iD8TUFnc0sKdccyFfxBxcSZoyX985pCpTNSBBQUk4P+HLUNlq+mw=
X-Received: by 2002:a0c:b253:0:b0:656:4af7:ab with SMTP id
 k19-20020a0cb253000000b006564af700abmr1238352qve.7.1695448599177; 
 Fri, 22 Sep 2023 22:56:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
In-Reply-To: <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Sep 2023 08:56:28 +0300
Message-ID: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com, willy@infradead.org,
 oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTE6MjnigK9QTSBSZXViZW4gSGF3a2lucyA8cmV1YmVu
aHdrQGdtYWlsLmNvbT4gd3JvdGU6Cj4KPgo+Cj4gT24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgNDow
OeKAr0FNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPj4KPj4gSGkhCj4+
ID4gYWNrLiAgV2lsbCB0cnkgdG8gdGVzdC4gIE15IFVidW50dSAyMi4wNCBzeXN0ZW0gd2Fzbid0
IGFibGUgdG8gZmluZAo+PiA+IHBhY2thZ2VzIGNhbGxlZAo+PiA+IGZvciBieSB0aGUgdGVzdCBj
YXNlLCBzbyBpdCdsbCB0YWtlIG1lIGEgbGl0dGxlIHdoaWxlIHRvIGZpZ3VyZSBvdXQgaG93IHRv
Cj4+ID4gZ2V0IHRoZQo+PiA+IHRlc3QgY2FzZSB3b3JraW5nLi4uCj4+Cj4+IEh1aD8gVGhlIHRl
c3QgaXMgYSBzaW1wbGUgQyBiaW5hcnkgeW91IHNob3VsZG4ndCBuZWVkIGFueXRoaW5nIG1vcmUK
Pj4gdGhhbjoKPj4KPj4gJCBnaXQgY2xvbmUgaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAuZ2l0Cj4+ICQgY2QgbHRwCj4+ICQgbWFrZSBhdXRvdG9vbHMKPj4gJCAuL2Nv
bmZpZ3VyZQo+Pgo+PiAkIGNkIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkCj4+
ICQgbWFrZQo+PiAkIC4vcmVhZGFoZWFkMDEKPj4KPj4gQW5kIHRoaXMgaXMgd2VsbCBkZXNjcmli
ZWQgaW4gdGhlIHJlYWRtZSBhdDoKPj4KPj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAvCj4+Cj4+IEFuZCB0aGUgcGFja2FnZXMgcmVxdWlyZWQgZm9yIHRoZSBjb21w
aWxhdGlvbiBhcmUgbWFrZSwgQyBjb21waWxlciBhbmQKPj4gYXV0b3Rvb2xzIG5vdGhpbmcgZXh0
cmFvcmRpbmFyeS4KPj4KPiBBd2Vzb21lLiAgVGhhdCB3YXMgc2ltcGxlciB0aGFuIHdoYXRldmVy
IGl0IHdhcyBJIHdhcyB0cnlpbmcuICBJJ3ZlCj4gcmVwcm9kdWNlZCB0aGUgZmFpbGVkIHRlc3Qg
YW5kIHdpbGwgdHJ5IGEgZmV3IHZhcmlhdGlvbnMgb24gdGhlIHBhdGNoLgoKQ29vbC4KCkZvciBw
ZW9wbGUgdGhhdCB3ZXJlIG5vdCBmb2xsb3dpbmcgdGhlIHBhdGNoIHJldmlldywKdGhlIGdvYWwg
aXMgbm90IHRvIHBhc3MgdGhlIGV4aXN0aW5nIHRlc3QuCgpXZSBkZWNpZGVkIHRvIGRlbGliZXJh
dGVseSB0cnkgdGhlIGNoYW5nZSBvZiBiZWhhdmlvcgpmcm9tIEVJTlZBTCB0byBFU1BJUEUsIHRv
IGFsaWduIHdpdGggZmFkdmlzZSBiZWhhdmlvciwKc28gZXZlbnR1YWxseSB0aGUgTFRQIHRlc3Qg
c2hvdWxkIGJlIGNoYW5nZWQgdG8gYWxsb3cgYm90aC4KCkl0IHdhcyB0aGUgdGVzdCBmYWlsdXJl
IG9uIHRoZSBzb2NrZXQgdGhhdCBhbGFybWVkIG1lLgpIb3dldmVyLCBpZiB3ZSB3aWxsIGhhdmUg
dG8gc3BlY2lhbCBjYXNlIHNvY2tldCBpbgpyZWFkYWhlYWQoKSBhZnRlciBhbGwsIHdlIG1heSBh
cyB3ZWxsIGFsc28gc3BlY2lhbCBjYXNlCnBpcGUgd2l0aCBpdCBhbmQgcmV0YWluIHRoZSBFSU5W
QUwgYmVoYXZpb3IgLSBsZXQncyBzZWUKd2hhdCB5b3VyIGZpbmRpbmdzIGFyZSBhbmQgZGVjaWRl
LgoKVGhhbmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
