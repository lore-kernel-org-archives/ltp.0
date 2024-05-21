Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFAACC25B77
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 01:03:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 863E73CFF76
	for <ltp@archiver.kernel.org>; Tue, 21 May 2024 03:03:17 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E4823C07A6
 for <ltp@lists.linux.it>; Tue, 21 May 2024 03:03:01 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A5ECC1A00889
 for <ltp@lists.linux.it>; Tue, 21 May 2024 03:03:00 +0200 (CEST)
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-de45dba15feso3137859276.3
 for <ltp@lists.linux.it>; Mon, 20 May 2024 18:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716253379; x=1716858179; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BMFKdFgnVZPGLlTfiCW/6obi4h0tM1WRKCe9jBUZOBc=;
 b=nEoyFHTFQm5rEcKG0kPj7LFvVT8iVpBnSZVQ6ulskM/K91iWkw+GQa7Pk+ALQnRpDB
 bf3aiGgbVZq48xM3qBHuEXxfD2tBta9Y5r2S7fmz5uLDkwQG5LZZlDbMXEmvsgr1chLN
 bD3TpQ9gdtVcSBsZBHkHxlSPaGw3GCyoi/4fMPZ89aHR013fCFEsR8Jc0T+KkGENuIZY
 cjuf3Yk4Q5VzCiZWpAHVSeudRxE6Kg4KSoN0GPTy/zfvE75YquAgsGOrCC947Ugyds+e
 mEmh/JzTn0fodUm7DAPq7v7rqkhFlwON55MuFPGERxtahAhlkhGXgV3tQ5qWlKkAdikt
 rxeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716253379; x=1716858179;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=BMFKdFgnVZPGLlTfiCW/6obi4h0tM1WRKCe9jBUZOBc=;
 b=DBoS+XwnExYrDVvx6+WRegMWB3oJy1f7w86a3jRVZ6/Hgr3sNa4pP08+MQA0qcCd5q
 inY0PguvTsYtc1pddW4H5JFfOIyxq47AzzqyikThAF7wIXjk0OsMRKjBTBD56RzmZs0E
 Dss5lO8oTsSgwUqBSRAtkvVuO2sO/qIds/vZhamMQQraO+INYLUdor+0BBc6HlMjx6cR
 DgcNDHq2cSXsssVWKoUSg+KbjnzCac3HjvLrM98OtIO1PLlizChayQECD6h8CWi18S53
 JCBn1+PfQ7booFIYt7DLb5OvMXPZhPfVimm7e37iBcJgTkkt06aTZ3KAgxuLk8vkF1oU
 ZwDA==
X-Gm-Message-State: AOJu0YwYpq8DjZKcVHUudcvOuiZUa+SYKCqO4ypdy2sqaWoC1CiNcfJZ
 8kMVw4saHav5LBW3i2ce1Sap5hNdUvHVEpt9xh8CzYnUDZXaD0gX1pBuYhVuk8vp25ORK5MsLW9
 cgBaEBhyEw8iuSItKEPOkpWGZH8c=
X-Google-Smtp-Source: AGHT+IEdtVGO9ARuNq3lMlKAQWsvHv/ZCayM3N+h7zNEBVORDfMzVE5YdaGVJ0kVish7A23+9bycnOfLmXYfqkZ+7bg=
X-Received: by 2002:a05:6902:1b8f:b0:df4:a2e7:dd6 with SMTP id
 3f1490d57ef6-df4a2e70f8bmr5827126276.0.1716253379262; Mon, 20 May 2024
 18:02:59 -0700 (PDT)
MIME-Version: 1.0
References: <CADJHv_v7BZORM+E6fMBD_TX_+uym7GuykqbpAaLqmCvqymOgCQ@mail.gmail.com>
 <CAOQ4uxhxeihXm_AsztvZ4v3bw=y8aQWpGvhEO1ONOXNM03pwdw@mail.gmail.com>
In-Reply-To: <CAOQ4uxhxeihXm_AsztvZ4v3bw=y8aQWpGvhEO1ONOXNM03pwdw@mail.gmail.com>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Tue, 21 May 2024 09:02:48 +0800
Message-ID: <CADJHv_t_tSqeUqhgbS-LxH72EwuKZhTgdVCzo0AmqppJPJ-Bfg@mail.gmail.com>
To: Amir Goldstein <amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP/fanotify01 corner case
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXkgMTUsIDIwMjQgYXQgMjozN+KAr0FNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNp
bEBnbWFpbC5jb20+IHdyb3RlOgoKPiBPbiBUdWUsIE1heSAxNCwgMjAyNCBhdCAxOjIx4oCvQU0g
TXVycGh5IFpob3UgPGplbmNjZS5rZXJuZWxAZ21haWwuY29tPgo+IHdyb3RlOgo+ID4KPiA+IEhp
IEFtaXIsCj4gPgo+ID4gV2hlbiBUTVBESVIgaXMgb24gTkZTLCBmYW5vdGlmeTAxIGdldCBFTk9E
RVYgd2hlbiB0ZXN0aW5nIGlmIGl0IHN1cHBvcnRzCj4gcmVwb3J0aW5nIGV2ZW50cyB3aXRoIGZp
ZCBmcm9tIG11bHRpIGZzIGluIHNldHVwKCk6Cj4gPgo+ID4+ICAgICAgICAgaWYgKGZhbm90aWZ5
X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyhGQU5fUkVQT1JUX0ZJRCwKPiBGQU5fTUFSS19NT1VOVCwg
RkFOX09QRU4sICIuIikpIHsKPiA+PiAgICAgICAgICAgICAgICAgaW5vZGVfbWFya19maWRfeGRl
diA9IGVycm5vOwo+ID4+ICAgICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiVE1QRElSIGRv
ZXMgbm90IHN1cHBvcnQgcmVwb3J0aW5nCj4gZXZlbnRzIHdpdGggZmlkIGZyb20gbXVsdGkgZnMi
KTsKPiA+PiAgICAgICAgIH0KPiA+Cj4gPgo+ID4gbGF0ZXIgaW4gdGVzdF9mYW5vdGlmeSgpLCBm
ZF9ub3RpZnkgZmlyc3RseSBnZXRzIGFkZGVkIGEgbWFyayBmb3IgdGhlIGZzCj4gbW91bnRlZCB3
aXRoaW4gdGhlIE5GUyBUTVBESVIsCj4gPgo+ID4gYW5kIHRoZW4gYXQgdGhlIGVuZCBvZiB0ZXN0
X2Zhbm90aWZ5KCksIGFkZGVkIGFub3RoZXIgbWFyayBmb3IgdGhlCj4gVE1QRElSIHdoaWNoIGlz
IE5GUyBpbiB0aGlzIGNhc2UsIGFuZCBjaGVjayBvbiB0aGUgZXJybm86Cj4gPgo+ID4+ICAgICAg
ICAgcmV0ID0gcmVwb3J0X2ZpZCA/IGlub2RlX21hcmtfZmlkX3hkZXYgOiAwOwo+ID4+ICAgICAg
ICAgVFNUX0VYUF9GRF9PUl9GQUlMKGZhbm90aWZ5X21hcmsoZmRfbm90aWZ5LCBGQU5fTUFSS19B
REQsCj4gRkFOX0NMT1NFX1dSSVRFLAo+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQVRfRkRDV0QsICIuIiksIHJldCk7Cj4gPgo+ID4KPiA+Cj4gPiBJdCB3b3Jr
ZWQgZmluZSB0aWxsCj4gPgo+ID4+IGNvbW1pdCAzMGFkMTkzODMyNmJmOTMwM2NhMzgwOTAzMzlk
OTQ4OTc1YTYyNmY1Cj4gPj4gQXV0aG9yOiBBbWlyIEdvbGRzdGVpbiA8YW1pcjczaWxAZ21haWwu
Y29tPgo+ID4+IERhdGU6ICAgVGh1IE5vdiAzMCAxODo1NjoxOSAyMDIzICswMjAwCj4gPj4KPiA+
PiAgICAgZmFub3RpZnk6IGFsbG93ICJ3ZWFrIiBmc2lkIHdoZW4gd2F0Y2hpbmcgYSBzaW5nbGUg
ZmlsZXN5c3RlbQo+ID4KPiA+Cj4gPiBBZnRlciB0aGlzIGNvbW1pdCB3YXMgbWVyZ2VkLCB0aGUg
Zmlyc3QgY2hlY2sgZ290IEVOT0RFViBhbmQgdGhlIHNlY29uZAo+IGNoZWNrIGdvdCBFWERFVi4K
PiA+Cj4gPiBUaGUgYm90aCB2YWx1ZXMgbWFrZSBzZW5zZSBpbiB0aGVpciBzaXR1YXRpb24sIGJ1
dCBpdCBzZWVtcyBsaWtlIHVzaW5nCj4gb25lIHZhbHVlIGFzIGV4cGVjdGVkIHZhbHVlIGZvciBh
bm90aGVyIHNlZW1zIG5vdCBhY2N1cmF0ZSBoZXJlIGZvciBtZS4gSQo+IGRvbid0IGtub3cgbXVj
aCBoZXJlLCB5b3VyIGhlbHAgaXMgbXVjaCBhcHByZWNpYXRlZC4KPgo+IFlvdXIgYW5hbHlzaXMg
aXMgZXhhY3QgYW5kIGNvcnJlY3QuCj4KPiBUaGUgY29tbWl0IGFib3ZlIGNhdXNlZCBhIGJlaGF2
aW9yIGNoYW5nZSBpbiB0aGF0IGNhc2UgbW92aW5nIGZyb20gb25lCj4gZXJyb3IgdGhhdCBtYWtl
cyBzZW5zZSB0byBhbm90aGVyIGVycm9yIHRoYXQgbWFrZXMgc2Vuc2UgYW5kIHRoZSB0ZXN0Cj4g
c2hvdWxkIGNvcGUgd2l0aCB0aGF0Lgo+Cj4gVGhlIGVhc2llc3Qgd291bGQgYmUgdG8gb3BlbiBj
b2RlIFRTVF9FWFBfRkRfT1JfRkFJTCgpCj4gaGVscGVyIGFuZCBjaGVjayBmb3IgZWl0aGVyCj4g
ZXJybm8gPT0gaW5vZGVfbWFya19maWRfeGRldiB8fCBlcnJubyA9PSBFWERFVi4KPiBub3Qgc3Vy
ZSBpZiB0aGVyZSBpcyBhbiBMVFAgaGVscGVyIGZvciB0aGlzIHBhdHRlcm4uCj4KClRoYW5rcyBm
b3IgdGhlIGNvbmZpcm1hdGlvbiBhbmQgc3VnZ2VzdGlvbiEKCgo+IFRoYW5rcywKPiBBbWlyLgo+
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
