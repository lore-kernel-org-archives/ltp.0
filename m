Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3692ACE7A88
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 15:48:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 859CB3CBDF0
	for <ltp@archiver.kernel.org>; Sat, 23 Sep 2023 17:48:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCE953C9E51
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 17:48:18 +0200 (CEST)
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com
 [IPv6:2607:f8b0:4864:20::92a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1F60F1A0BC3A
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 17:48:18 +0200 (CEST)
Received: by mail-ua1-x92a.google.com with SMTP id
 a1e0cc1a2514c-7aae07e7ba4so1452695241.1
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 08:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695484097; x=1696088897; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LPBk6Sis4taxUhhwxWpjAuEIr4KdgqIKqoVHvpXBx/k=;
 b=Z3ftws9awcu1JXkkIRVyYBVlpdaS69O2mmgzYoL67wqOfX1ia2P3xz+Iq3da/wb48f
 Xhqu6YqimSFMhOuPQHsNNszvKVch0AYnuacjIi+ZkFLv+EnKasSGdmKUOQa3p5KldLum
 2qxXZh2/gjs8xjMYesnSPOhnDI/RP13s/kriRQJNwzoGFEzSBS56Iy7JkRaqhaDJ0AfW
 hVb2kwf6zEfqlh7tvAYKsjRwMHS9IHsQRUUYYxRZ53vZyA7VEA4cW/+67QmC+w8HWTLQ
 +Xg+1EfiObav4+ot7zS2a+f5kr24/Uuo86SCXIDwvulOJz5BmR8YxiLZPJFNnceouVrg
 aq3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695484097; x=1696088897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LPBk6Sis4taxUhhwxWpjAuEIr4KdgqIKqoVHvpXBx/k=;
 b=Q4MhkEWbcO1d5xfWz8BxDM6mCM63z0w97zwlaOAajmXCVKX8wdSbTkDwBfUSKGUDSa
 EiFFFpmbU/PfMPs/heoouZ1k+i21WbaIqbINzHk9tg3cirOKatsKenEOOLpVotgdu/cv
 SvVHhtd4ZLqPh/M9WFLCo03XRv1Kr/RP2cj/UU6jVkyEcq3tkCAHW7oIaCm1mzO5uOMK
 VXiuIhcx7A5S+PQcmbJi9cGFe4CtiIOIqo1btAoHJXYVsMc0yZ9cHeKCHYB+EWu06l3M
 TSrOTXK7UlTrKivD6YPoLjjzF5/4gHFYWFIXeaKx5LEd3YVW21qy2sAANZd0eNH2DpfV
 qfiA==
X-Gm-Message-State: AOJu0Yx2WypaatqvqL3CU31rRjdRLIafuLAngOLYss/clZ7euSjuE48T
 vWQ0SmOAvIxX3ioQnfEC7pl+TtwBJXQsubB2AUc=
X-Google-Smtp-Source: AGHT+IEGP5VDrb+FQUow/x0fBVHOAzOLagR5lzNYnZapYUV+4VDn7OxyQSCA+S/54Vsz8iectYUUJTWdw0K53EAOg3g=
X-Received: by 2002:a67:fd09:0:b0:451:73bb:9fa0 with SMTP id
 f9-20020a67fd09000000b0045173bb9fa0mr1579093vsr.34.1695484096842; Sat, 23 Sep
 2023 08:48:16 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
In-Reply-To: <ZQ75JynY8Y2DqaHD@casper.infradead.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 23 Sep 2023 18:48:05 +0300
Message-ID: <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
To: Matthew Wilcox <willy@infradead.org>, Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
Cc: mszeredi@redhat.com, brauner@kernel.org, lkp@intel.com,
 oe-lkp@lists.linux.dev, kernel test robot <oliver.sang@intel.com>,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgNTo0MeKAr1BNIE1hdHRoZXcgV2lsY294IDx3aWxseUBp
bmZyYWRlYWQub3JnPiB3cm90ZToKPgo+IE9uIFNhdCwgU2VwIDIzLCAyMDIzIGF0IDA4OjU2OjI4
QU0gKzAzMDAsIEFtaXIgR29sZHN0ZWluIHdyb3RlOgo+ID4gV2UgZGVjaWRlZCB0byBkZWxpYmVy
YXRlbHkgdHJ5IHRoZSBjaGFuZ2Ugb2YgYmVoYXZpb3IKPiA+IGZyb20gRUlOVkFMIHRvIEVTUElQ
RSwgdG8gYWxpZ24gd2l0aCBmYWR2aXNlIGJlaGF2aW9yLAo+ID4gc28gZXZlbnR1YWxseSB0aGUg
TFRQIHRlc3Qgc2hvdWxkIGJlIGNoYW5nZWQgdG8gYWxsb3cgYm90aC4KPiA+Cj4gPiBJdCB3YXMg
dGhlIHRlc3QgZmFpbHVyZSBvbiB0aGUgc29ja2V0IHRoYXQgYWxhcm1lZCBtZS4KPiA+IEhvd2V2
ZXIsIGlmIHdlIHdpbGwgaGF2ZSB0byBzcGVjaWFsIGNhc2Ugc29ja2V0IGluCj4gPiByZWFkYWhl
YWQoKSBhZnRlciBhbGwsIHdlIG1heSBhcyB3ZWxsIGFsc28gc3BlY2lhbCBjYXNlCj4gPiBwaXBl
IHdpdGggaXQgYW5kIHJldGFpbiB0aGUgRUlOVkFMIGJlaGF2aW9yIC0gbGV0J3Mgc2VlCj4gPiB3
aGF0IHlvdXIgZmluZGluZ3MgYXJlIGFuZCBkZWNpZGUuCj4KPiBJZiBJIHJlYWQgaXQgY29ycmVj
dGx5LCBMVFAgaXMgcmVwb3J0aW5nIHRoYXQgcmVhZGhhZWFkKCkgb24gYSBzb2NrZXQKPiByZXR1
cm5lZCBzdWNjZXNzIGluc3RlYWQgb2YgYW4gZXJyb3IuICBTb2NrZXRzIGRvIGhhdmUgYV9vcHMs
IHJpZ2h0Pwo+IEl0J3Mgc2V0IHRvIGVtcHR5X2FvcHMgaW4gaW5vZGVfaW5pdF9hbHdheXMsIEkg
dGhpbmsuCj4KClllaCwgeW91IGFyZSByaWdodC4KSSBndWVzcyB0aGUgY2hlY2sgIWYuZmlsZS0+
Zl9tYXBwaW5nLT5hX29wcyBpcyBjb21wbGV0ZWx5IGZ1dGlsZQppbiB0aGF0IGNvZGUuIEl0J3Mg
dGhlIG9ubHkgcGxhY2UgSSBjb3VsZCBmaW5kIHRoaXMgc29ydCBvZiBjaGVjawpleGNlcHQgZm9y
IHBsYWNlcyBsaWtlOgppZiAoZi0+Zl9tYXBwaW5nLT5hX29wcyAmJiBmLT5mX21hcHBpbmctPmFf
b3BzLT5kaXJlY3RfSU8pCndoaWNoIGp1c3QgbG9va3MgbGlrZSBhIGNvZGluZyBoYWJpdC4KCj4g
SXQgd291bGQgYmUgbmljZSBpZiB3ZSBkb2N1bWVudGVkIHNvbWV3aGVyZSB3aGljaCBwb2ludGVy
cyBzaG91bGQgYmUKPiBjaGVja2VkIGZvciBOVUxMIGZvciB3aGljaCBjYXNlcyAuLi4gaXQgZG9l
c24ndCByZWFsbHkgbWFrZSBzZW5zZSBmb3IKPiBhIHNvY2tldCBpbm9kZSB0byBoYXZlIGFuIGlf
bWFwcGluZyBzaW5jZSBpdCBkb2Vzbid0IGhhdmUgcGFnZWNhY2hlLgo+IEJ1dCBtYXliZSB3ZSBy
ZWx5IG9uIGlfbWFwcGluZyBhbHdheXMgYmVpbmcgc2V0Lgo+CgpJIGNhbid0IGltYWdpbmUgdGhh
dCBhIHNvY2tldCBoYXMgZl9tYXBwaW5nLgpUaGVyZSBtdXN0IGhhdmUgYmVlbiBzb21ldGhpbmcg
b2ZmIHdpdGggdGhpcyBzcGVjaWZpYyBidWcgcmVwb3J0LApiZWNhdXNlIGl0IHdhcyByZXBvcnRl
ZCBvbiBhIFdJUCBwYXRjaC4KCj4gSXJyaXRhdGluZ2x5LCBQT1NJWCBzcGVjaWZpZXMgRVNQSVBF
IGZvciBwaXBlcywgYnV0IGRvZXMgbm90IHNwZWNpZnkKPiB3aGF0IHRvIGRvIHdpdGggc29ja2V0
cy4gIEl0J3Mga2luZCBvZiBhIG1lYW5pbmdsZXNzIHN5c2NhbGwgZm9yCj4gYW55IGtpbmQgb2Yg
bm9uLXNlZWthYmxlIGZkLiAgbHNlZWsoKSByZXR1cm5zIEVTUElQRSBmb3Igc29ja2V0cwo+IGFz
IHdlbGwgYXMgcGlwZXMsIHNvIEknZCBzZWUgdGhpcyBhcyBhbiBvdmVyc2lnaHQuCj4gaHR0cHM6
Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy85Njk5OTE5Nzk5L2Z1bmN0aW9ucy9wb3Np
eF9mYWR2aXNlLmh0bWwKPiBodHRwczovL3B1YnMub3Blbmdyb3VwLm9yZy9vbmxpbmVwdWJzLzk2
OTk5MTk3OTkvZnVuY3Rpb25zL2xzZWVrLmh0bWwKPgoKSW5kZWVkLCB3ZSB0aG91Z2h0IGl0IHdv
dWxkbid0IGJlIHRvbyBiYWQgdG8gYWxpZ24gdGhlCnJlYWRhaGVhZCBlcnJvcnMgd2l0aCB0aG9z
ZSBvZiBwb3NpeF9mYWR2aXNlLgpUaGF0J3Mgd2h5IHdlIGFza2VkIHRvIHJlbW92ZSB0aGUgU19J
U0ZJRk8gY2hlY2sgZm9yIHYyLgpCdXQgbG9va2luZyBhZ2FpbiwgcGlwZSB3aWxsIGdldCBFSU5W
QUwgZm9yICFmX21hcHBpbmcsIHNvIHRoZQpVQVBJIHdhc24ndCBjaGFuZ2VkIGF0IGFsbCBhbmQg
d2Ugd2VyZSBqdXN0IHRhbGtpbmcgQlMgYWxsIGFsb25nLgpMZXQncyBsZWF2ZSB0aGUgVUFQSSBh
cyBpcy4KCj4gT2YgY291cnNlIHJlYWRhaGVhZCgpIGlzIGEgTGludXgtc3BlY2lmaWMgc3lzY2Fs
bCwgc28gd2UgY2FuIGRvIHdoYXRldmVyCj4gd2Ugd2FudCBoZXJlLCBidXQgSSdtIHJlYWxseSB0
ZW1wdGVkIHRvIGp1c3QgYWxsb3cgcmVhZGFoZWFkKCkgZm9yCj4gcmVndWxhciBmaWxlcyBhbmQg
YmxvY2sgZGV2aWNlcy4gIEhtbS4gIENhbiB3ZSBjaGVjayBGTU9ERV9MU0VFSwo+IGluc3RlYWQg
b2YgKFNfSVNGSUxFIHx8IFNfSVNCTEspPwoKSSB0aGluayB0aGUgZl9tYXBwaW5nIGNoZWNrIHNo
b3VsZCBiZSBnb29kLgpSZXViZW4gYWxyZWFkeSBzYWlkIGhlIGNvdWxkIG5vdCByZXByb2R1Y2Ug
dGhlIExUUCBmYWlsdXJlIHdpdGgKdjIgdGhhdCBpcyBvbiBDaHJpc3RpYW4ncyB2ZnMubWlzYyBi
cmFuY2guCgpUaGUgU19JU1JFRyBjaGVjayBJIHB1dCBpbiB0aGUgRml4ZXMgY29tbWl0IHdhcyBj
b21wbGV0ZWx5CnVuZXhwbGFpbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgY29tcGxldGVs
eSB1bm5lZWRlZC4KSnVzdCByZW1vdmluZyBpdCBhcyB3YXMgZG9uZSBpbiB2MiBpcyBlbm91Z2gu
CgpIb3dldmVyLCB2MiBoYXMgdGhpcyB3cm9uZyBjb21tZW50IGluIHRoZSBjb21taXQgbWVzc2Fn
ZToKIlRoZSBjaGFuZ2UgYWxzbyBtZWFucyB0aGF0IHJlYWRhaGVhZCB3aWxsIHJldHVybiAtRVNQ
SVBFCiAgb24gRklGTyBmaWxlcyBpbnN0ZWFkIG9mIC1FSU5WQUwuIgoKV2UgbmVlZCB0byByZW1v
dmUgdGhpcyBjb21tZW50CmFuZCBjb3VsZCBhbHNvIHJlbW92ZSB0aGUgdW5uZWVkZWQgIWYuZmls
ZS0+Zl9tYXBwaW5nLT5hX29wcwpjaGVjayB3aGlsZSBhdCBpdC4KClRoYW5rcywKQW1pci4KCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
