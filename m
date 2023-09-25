Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4445CE7A95
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 15:36:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E5633CE28D
	for <ltp@archiver.kernel.org>; Mon, 25 Sep 2023 17:36:55 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F03CA3C01D0
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:36:44 +0200 (CEST)
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com
 [IPv6:2607:f8b0:4864:20::a34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8B2A22005F3
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 17:36:43 +0200 (CEST)
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-495d06ec90bso690952e0c.1
 for <ltp@lists.linux.it>; Mon, 25 Sep 2023 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695656202; x=1696261002; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZOcHogZoYlcQB9bI17nIkPAkTBc9AxFvOOG1Ao7uoGU=;
 b=U/zLJ28aKRwNFk8x69QAX98rO4HkRfzzm75/9i+Et/Pgx3+PztM2vzwraKmX5h/Shn
 uEBKYLWSvoIn9HyYjLjGCW4qECuHuDnCFrnJn2c44d/KUp26Yw0ZrjO58VnQGyQnujtr
 2NkubzYpsLnimCK9P0LopBTH1EvZmSwhWgl+MKc/FXLzvk1brrRgkwY3cTmUwiTX/Pgf
 mNgeusaZ/sIjXuP/yUJynPILoVmvx50D9iIn6pWS/XsBt6Q0qkDCM7eZv4juggx5UFJE
 vvX/Yw/ACW4mQm7zxAUANcrXWHHTJjDbfzzfSShbUSxrwo3urAFgmTW9/xNT43rEGqOb
 b55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695656202; x=1696261002;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZOcHogZoYlcQB9bI17nIkPAkTBc9AxFvOOG1Ao7uoGU=;
 b=uS7Tf1o7UDmx82SKpZxWDGdtzfxtEYcFWVFHeWkefpyiz6aPgfXjJrEihgQ4+QclFt
 r0LGEwvH7QJ7GnrHm9bVQg33EExM0wLqn1WEEHos1S4ZzN6M27/Tf1IP3nltDJ67j2gv
 WUnXJMkuOnELPrSQ1y9jvceH2Kct3Py92sBq+CnvIusFu+w92nKM8yf/SYjVA1B4fxTf
 G6VAyKRD+KlUohr5qn9unkir3l00Y9AFHZEy5yKYbFVT0vTKVoswEvTFCwQ06WMUHvVY
 G3MJ8Gs9pe82mAEjNjhCpscWvW2gDF7HvTe8omdmpxsA6ghXY/ei5Xs7hFoA5Hiv7LaB
 i1rA==
X-Gm-Message-State: AOJu0Ywa+6opNEz2qRMmK4RP/jg40KGBv2lg1CBhwE8hqV5sRm/1Wb9c
 yWP2bgTWKPb6nt9EKkC/xBSC9uzFgsXKODUb1Dw=
X-Google-Smtp-Source: AGHT+IE67Emyw9g/kQIWDHbSUALxGhjRy/GDshsDz7S3HLam3iUQedBO10ILgWBqa/6FH0Kg6PdchmeiVhTDv92evec=
X-Received: by 2002:a05:6122:3647:b0:48f:d0ca:b4a3 with SMTP id
 dv7-20020a056122364700b0048fd0cab4a3mr1901943vkb.1.1695656202306; Mon, 25 Sep
 2023 08:36:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org>
 <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org>
 <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org>
 <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
In-Reply-To: <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
From: Reuben Hawkins <reubenhwk@gmail.com>
Date: Mon, 25 Sep 2023 10:36:30 -0500
Message-ID: <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMjUsIDIwMjMgYXQgNDo0M+KAr0FNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+IHdyb3RlOgoKPiBPbiBNb24sIFNlcCAyNSwgMjAyMyBhdCA5OjQy4oCvQU0g
TWF0dGhldyBXaWxjb3ggPHdpbGx5QGluZnJhZGVhZC5vcmc+Cj4gd3JvdGU6Cj4gPgo+ID4gT24g
U3VuLCBTZXAgMjQsIDIwMjMgYXQgMTE6MzU6NDhQTSAtMDUwMCwgUmV1YmVuIEhhd2tpbnMgd3Jv
dGU6Cj4gPiA+IFRoZSB2MiBwYXRjaCBkb2VzIE5PVCByZXR1cm4gRVNQSVBFIG9uIGEgc29ja2V0
LiAgSXQgc3VjY2VlZHMuCj4gPiA+Cj4gPiA+IHJlYWRhaGVhZDAxLmM6NTQ6IFRJTkZPOiB0ZXN0
X2ludmFsaWRfZmQgcGlwZQo+ID4gPiByZWFkYWhlYWQwMS5jOjU2OiBURkFJTDogcmVhZGFoZWFk
KGZkWzBdLCAwLCBnZXRwYWdlc2l6ZSgpKSBleHBlY3RlZAo+ID4gPiBFSU5WQUw6IEVTUElQRSAo
MjkpCj4gPiA+IHJlYWRhaGVhZDAxLmM6NjA6IFRJTkZPOiB0ZXN0X2ludmFsaWRfZmQgc29ja2V0
Cj4gPiA+IHJlYWRhaGVhZDAxLmM6NjI6IFRGQUlMOiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBh
Z2VzaXplKCkpIHN1Y2NlZWRlZAo+ID4gPiA8LS0tLS0tLWhlcmUKPiA+Cj4gPiBUaGFua3MhICBJ
IGFtIG9mIHRoZSB2aWV3IHRoYXQgdGhpcyBpcyB3cm9uZyAoYWx0aG91Z2ggcHJvYmFibHkKPiA+
IGhhcm1sZXNzKS4gIEkgc3VzcGVjdCB3aGF0IGhhcHBlbnMgaXMgdGhhdCB3ZSB0YWtlIHRoZQo+
ID4gJ2JkaSA9PSAmbm9vcF9iYWNraW5nX2Rldl9pbmZvJyBjb25kaXRpb24gaW4gZ2VuZXJpY19m
YWR2aXNlKCkKPiA+IChzaW5jZSBJIGRvbid0IHNlZSBhbnl3aGVyZSBpbiBuZXQvIHNldHRpbmcg
Zl9vcC0+ZmFkdmlzZSkgYW5kIHNvCj4gPiByZXR1cm4gMCB3aXRob3V0IGRvaW5nIGFueSB3b3Jr
Lgo+ID4KPiA+IFRoZSBjb3JyZWN0IHNvbHV0aW9uIGlzIHByb2JhYmx5IHlvdXIgdjIsIGNvbWJp
bmVkIHdpdGg6Cj4gPgo+ID4gICAgICAgICBpbm9kZSA9IGZpbGVfaW5vZGUoZmlsZSk7Cj4gPiAt
ICAgICAgIGlmIChTX0lTRklGTyhpbm9kZS0+aV9tb2RlKSkKPiA+ICsgICAgICAgaWYgKFNfSVNG
SUZPKGlub2RlLT5pX21vZGUpIHx8IFNfSVNTT0NLKGlub2RlLT5pX21vZGUpKQo+ID4gICAgICAg
ICAgICAgICAgIHJldHVybiAtRVNQSVBFOwo+ID4KPiA+IGluIGdlbmVyaWNfZmFkdmlzZSgpLCBi
dXQgdGhhdCB0aGVuIGNoYW5nZXMgdGhlIHJldHVybiB2YWx1ZSBmcm9tCj4gPiBwb3NpeF9mYWR2
aXNlKCksIGFzIEkgb3V0bGluZWQgaW4gbXkgcHJldmlvdXMgZW1haWwuICBBbmQgSSdtIE9LIHdp
dGgKPiA+IHRoYXQsIGJlY2F1c2UgSSB0aGluayBpdCdzIHdoYXQgUE9TSVggaW50ZW5kZWQuICBB
bWlyIG1heSB3ZWxsIGRpc2FncmVlCj4gPiA7LSkKPgo+IEkgcmVhbGx5IGhhdmUgbm8gcHJvYmxl
bSB3aXRoIHRoYXQgY2hhbmdlIHRvIHBvc2l4X2ZhZHZpc2UoKS4KPiBJIG9ubHkgbWVhbnQgdG8g
c2F5IHRoYXQgd2UgYXJlIG5vdCBnb2luZyB0byBhc2sgUmV1YmVuIHRvIHRhbGsgdG8KPiB0aGUg
c3RhbmRhcmQgY29tbWl0dGVlLCBidXQgdGhhdCdzIG9idmlvdXMgOy0pCj4gQSBwYXRjaCB0byBt
YW4tcGFnZXMsIHRoYXQgSSB3b3VsZCByZWNvbW1lbmQgYXMgYSBmb2xsb3cgdXAuCj4KPiBGV0lX
LCBJIGNoZWNrZWQgYW5kIHRoZXJlIGlzIGN1cnJlbnRseSBubyB0ZXN0IGZvcgo+IHBvc2l4X2Zh
ZHZpc2UoKSBvbiBzb2NrZXQgaW4gTFRQIEFGQUlLLgo+IE1heWJlIEN5cmlsIHdpbGwgZm9sbG93
IHlvdXIgc3VnZ2VzdGlvbiBhbmQgdGhpcyB3aWxsIGFkZCB0ZXN0Cj4gY292ZXJhZ2UgZm9yIHNv
Y2tldCBpbiBwb3NpeF9mYWR2aXNlKCkuCj4KPiBSZXViZW4sCj4KPiBUaGUgYWN0aW9uYWJsZSBp
dGVtLCBpZiBhbGwgYWdyZWUgd2l0aCBNYXR0aGV3J3MgcHJvcG9zYWwsIGlzCj4gbm90IHRvIGNo
YW5nZSB0aGUgdjIgcGF0Y2ggdG8gcmVhZGFoZWFkKCksIGJ1dCB0byBzZW5kIGEgbmV3Cj4gcGF0
Y2ggZm9yIGdlbmVyaWNfZmFkdmlzZSgpLgo+Cj4gV2hlbiB5b3Ugc2VuZCB0aGUgcGF0Y2ggdG8g
Q2hyaXN0aWFuLCB5b3Ugc2hvdWxkIHNwZWNpZnkKPiB0aGUgZGVwZW5kZW5jeSAtIGl0IG5lZWRz
IHRvIGJlIGFwcGxpZWQgYmVmb3JlIHRoZSByZWFkYWhlYWQKPiBwYXRjaC4KPgoKSSdtIGhhdmlu
ZyBhIGJpdCBvZiBhIHRpbWUgY29taW5nIHVwIHdpdGggYSBjb21taXQgbWVzc2FnZSBmb3IgdGhp
cwpjaGFuZ2UgdG8gZmFkdmlzZS4uLkl0IGp1c3QgZG9lc24ndCBzb3VuZCBsaWtlIHNvbWV0aGlu
ZyBJIHdvdWxkIHdhbnQKdG8gbWVyZ2UuLi4KCiJDaGFuZ2UgZmFkdmlzZSB0byByZXR1cm4gLUVT
UElQRSBmb3Igc29ja2V0cy4gIFRoaXMgaXMgYSBuZXcgZmFpbHVyZQptb2RlIHRoYXQgZGlkbid0
IHByZXZpb3VzbHkgZXhpc3QuICBBcHBsaWNhdGlvbnMgX21heV8gaGF2ZSB0byBhZGQgbmV3CmVy
cm9yIGhhbmRsaW5nIGxvZ2ljIHRvIGFjY29tbW9kYXRlIHRoZSBuZXcgcmV0dXJuIHZhbHVlLiAg
SXQgbmVlZHMgdG8KYmUgZml4ZWQgaW4gZmFkdmlzZSBzbyB0aGF0IHJlYWRhaGVhZCB3aWxsIGFs
c28gcmV0dXJuIG5ldy91bmV4cGVjdGVkCmVycm9yIGNvZGVzLiIKCkl0IGp1c3QgZG9lc24ndCBm
ZWVsIHJpZ2h0LiAgTm9uZXRoZWxlc3MsIGhlcmUncyB0aGUgdGVzdCByZXN1bHRzIHdpdGgKdGhl
IGZhZHZpc2UgY2hhbmdlICsgdGhlIHYyIHJlYWRhaGVhZCBwYXRjaC4uLgoKcmVhZGFoZWFkMDEu
Yzo1NDogVElORk86IHRlc3RfaW52YWxpZF9mZCBwaXBlCnJlYWRhaGVhZDAxLmM6NTY6IFRGQUlM
OiByZWFkYWhlYWQoZmRbMF0sIDAsIGdldHBhZ2VzaXplKCkpIGV4cGVjdGVkCkVJTlZBTDogRVNQ
SVBFICgyOSkKcmVhZGFoZWFkMDEuYzo2MDogVElORk86IHRlc3RfaW52YWxpZF9mZCBzb2NrZXQK
cmVhZGFoZWFkMDEuYzo2MjogVEZBSUw6IHJlYWRhaGVhZChmZFswXSwgMCwgZ2V0cGFnZXNpemUo
KSkgZXhwZWN0ZWQKRUlOVkFMOiBFU1BJUEUgKDI5KQoKSXQgc2VlbXMgdG8gbWUgbGlrZSBJIGZp
eGVkIHNvbWV0aGluZyBpbiByZWFkYWhlYWQgdGhhdCBvbmNlIHdvcmtlZCwKcmVhZGFoZWFkIG9u
IGJsb2NrIGRldmljZXMsIGFuZCBJJ20gbm93IGV4Y2hhbmdpbmcgdGhhdCBvbmNlIHdvcmtpbmcK
YmVoYXZpb3IgdG8gYSBuZXcgZmFpbHVyZSB0byBzb2NrZXQsIHdoaWNoIHByZXZpb3VzbHkgc3Vj
Y2VlZGVkLi4uZXZlbgppZiBpdCBkaWRuJ3QgZG8gYW55dGhpbmcuCgpTaG91bGQgSSBpbnN0ZWFk
IGp1c3QgY2hlY2sgZm9yIFNfSVNTT0NLIGluIHJlYWRhaGVhZCBzbyB0aGF0IGJvdGggcGlwZXMK
YW5kIHNvY2tldHMgd2lsbCByZXR1cm4gRUlOVkFMIGluIHJlYWRhaGVhZCwgYW5kIGxlYXZlIGZh
ZHZpc2UgYXMgaXM/CgoKPgo+IElmIHRoZSByZWFkYWhlYWQgcGF0Y2ggd2FzIG5vdCBhbHJlYWR5
IGluIHRoZSB2ZnMgdHJlZSwgeW91Cj4gd291bGQgaGF2ZSBuZWVkZWQgdG8gc2VuZCBhIHBhdGNo
IHNlcmllcyB3aXRoIGEgY292ZXIgbGV0dGVyLAo+IHdoZXJlIHlvdSB3b3VsZCBsZWF2ZSB0aGUg
UmV2aWV3ZWQtYnkgb24gdGhlIHVuY2hhbmdlZAo+IFsyLzJdIHJlYWRhaGVhZCBwYXRjaC4KPgo+
IFNlbmRpbmcgYSBwYXRjaCBzZXJpZXMgaXMgYSBnb29kIHRoaW5nIHRvIHByYWN0aWNlLCBidXQg
aXQgaXMKPiBub3Qgc3RyaWN0bHkgbmVlZGVkIGluIHRoaXMgY2FzZSwgc28gSSdsbCBsZWF2ZSBp
dCB1cCB0byB5b3UgdG8gZGVjaWRlLgo+Cj4gVGhhbmtzLAo+IEFtaXIuCj4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
