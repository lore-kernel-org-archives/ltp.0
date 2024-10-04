Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A1E6CFA773
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 12:32:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8B853C62BF
	for <ltp@archiver.kernel.org>; Fri,  4 Oct 2024 14:32:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB5D3C61B5
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 14:32:21 +0200 (CEST)
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com
 [IPv6:2001:4860:4864:20::2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3635A600ED6
 for <ltp@lists.linux.it>; Fri,  4 Oct 2024 14:32:20 +0200 (CEST)
Received: by mail-oa1-x2b.google.com with SMTP id
 586e51a60fabf-277dd761926so1340453fac.2
 for <ltp@lists.linux.it>; Fri, 04 Oct 2024 05:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728045139; x=1728649939; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iKC3ZzOfY1vnMThrPX5eHTYnINaF5X9h9PqNHEL1Mb4=;
 b=EV6EdCTXPYPadcSatWq5NeIXdL8CQFWxCzpNSKgEcDZ1vv++agt4k5LlmYdk/7nVKM
 OoOlpOsOtrsz9RZk3qF6pyrZSe6pH71zL/KKjHAn4CzAP6wHrQMtRTi+eZmtVOExJCx/
 DHNelmOvy5HGzGHHAYlooevhOGUkiTCMxuj54e+s+cz3h2BGHMF8Yq1ahyadEhfP5b9I
 ltSjEGDyO/fiRy2ET1mAgpMLIyWDb6DvY6wmU5vSuJpccihpSFDOIF3XrKfxrNrWfX0G
 dMoPCCE7+XoHThJGSEw2F5TniUnCIMJJtsGLGrnEn2QCz3mnH8M+aUb4mirwbRdvyT95
 DDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728045139; x=1728649939;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iKC3ZzOfY1vnMThrPX5eHTYnINaF5X9h9PqNHEL1Mb4=;
 b=QWYXsts4c/3F7PTlhJrhUsaTlRaszMRJaBrUCozjsIPYdFvYoeaS9FQUh6YVBOg3fh
 26jzBSGRIZgj38XU2NTfpzncDgs2CjOBr5HFIgQNM+4EXxUaWQwLZoUBhx9rRdR/ZSRT
 Uyqa35QRBG9JcZPbq8EjMB580rTNxem8gQmKYlEKbPhRVpIwO0McNEexICnqA7XERbtd
 ZpAqcjjm5qHaCprhdyBDD06LkDzmbJllwGKbl2acXdcg4KPfFBWujRrz6lY+DXBSkYPy
 d5xJEHE5aIOi8/0VJ/KBaYWzL2hzoYREAFpPNEVcBf6yHl4gLplfK9T5UmKMzLBc9PCg
 YO5w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVOIMZs9GFWt9aRHMhOzox0wVl8IMkSLn7Z+CVowOkC+NmYUyZvLfZy3s1TRrPybUwXzlM=@lists.linux.it
X-Gm-Message-State: AOJu0YwtAijdnPpblfyqxLzGzVw635lhwMQYvfLBPDel1Ltx/Nd3cy0o
 MxXtAl9bqOnf7dti429xLChC9f9aCim/cwG05XbUAxWjwFkoPVQhwo8XLuXkYdhhJwbyMQSw63n
 M6m0bKkB0/R46b2Jq1PDaXyLmWcU=
X-Google-Smtp-Source: AGHT+IEni/Z/X/VHL065Ks4eUduiUbArksCcx/51P+E3Jkb5Q1CZodXv4yzVi9r8mymwk3BCnRIQlRXgZsjprXeDFg4=
X-Received: by 2002:a05:6870:f151:b0:254:bd24:de83 with SMTP id
 586e51a60fabf-287c1da64efmr1616401fac.12.1728045138732; Fri, 04 Oct 2024
 05:32:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240805201241.27286-1-jack@suse.cz> <Zvp6L+oFnfASaoHl@t14s>
 <20240930113434.hhkro4bofhvapwm7@quack3>
In-Reply-To: <20240930113434.hhkro4bofhvapwm7@quack3>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 4 Oct 2024 14:32:07 +0200
Message-ID: <CAOQ4uxjXE7Tyz39wLUcuSTijy37vgUjYxvGL21E32cxStAgQpQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ext4: don't set SB_RDONLY after filesystem errors
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
Cc: Christian Brauner <brauner@kernel.org>, Ted Tso <tytso@mit.edu>,
 Gabriel Krisman Bertazi <gabriel@krisman.be>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBTZXAgMzAsIDIwMjQgYXQgMTozNOKAr1BNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gT24gTW9uIDMwLTA5LTI0IDEyOjE1OjExLCBKYW4gU3RhbmNlayB3cm90ZToK
PiA+IE9uIE1vbiwgQXVnIDA1LCAyMDI0IGF0IDEwOjEyOjQxUE0gKzAyMDAsIEphbiBLYXJhIHdy
b3RlOgo+ID4gPiBXaGVuIHRoZSBmaWxlc3lzdGVtIGlzIG1vdW50ZWQgd2l0aCBlcnJvcnM9cmVt
b3VudC1ybywgd2Ugd2VyZSBzZXR0aW5nCj4gPiA+IFNCX1JET05MWSBmbGFnIHRvIHN0b3AgYWxs
IGZpbGVzeXN0ZW0gbW9kaWZpY2F0aW9ucy4gV2Uga25ldyB0aGlzIG1pc3Nlcwo+ID4gPiBwcm9w
ZXIgbG9ja2luZyAoc2ItPnNfdW1vdW50KSBhbmQgZG9lcyBub3QgZ28gdGhyb3VnaCBwcm9wZXIg
ZmlsZXN5c3RlbQo+ID4gPiByZW1vdW50IHByb2NlZHVyZSBidXQgaXQgaGFzIGJlZW4gdGhlIHdh
eSB0aGlzIHdvcmtlZCBzaW5jZSBlYXJseSBleHQyCj4gPiA+IGRheXMgYW5kIGl0IHdhcyBnb29k
IGVub3VnaCBmb3IgY2F0YXN0cm9waGljIHNpdHVhdGlvbiBkYW1hZ2UKPiA+ID4gbWl0aWdhdGlv
bi4gUmVjZW50bHksIHN5emJvdCBoYXMgZm91bmQgYSB3YXkgKHNlZSBsaW5rKSB0byB0cmlnZ2Vy
Cj4gPiA+IHdhcm5pbmdzIGluIGZpbGVzeXN0ZW0gZnJlZXppbmcgYmVjYXVzZSB0aGUgY29kZSBn
b3QgY29uZnVzZWQgYnkKPiA+ID4gU0JfUkRPTkxZIGNoYW5naW5nIHVuZGVyIGl0cyBoYW5kcy4g
U2luY2UgdGhlc2UgZGF5cyB3ZSBzZXQKPiA+ID4gRVhUNF9GTEFHU19TSFVURE9XTiBvbiB0aGUg
c3VwZXJibG9jayB3aGljaCBpcyBlbm91Z2ggdG8gc3RvcCBhbGwKPiA+ID4gZmlsZXN5c3RlbSBt
b2RpZmljYXRpb25zLCBtb2RpZnlpbmcgU0JfUkRPTkxZIHNob3VsZG4ndCBiZSBuZWVkZWQuIFNv
Cj4gPiA+IHN0b3AgZG9pbmcgdGhhdC4KPiA+ID4KPiA+ID4gTGluazogaHR0cHM6Ly9sb3JlLmtl
cm5lbC5vcmcvYWxsLzAwMDAwMDAwMDAwMGI5MGE4ZTA2MWUyMWQxMmZAZ29vZ2xlLmNvbQo+ID4g
PiBSZXBvcnRlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgPGJyYXVuZXJAa2VybmVsLm9yZz4KPiA+
ID4gU2lnbmVkLW9mZi1ieTogSmFuIEthcmEgPGphY2tAc3VzZS5jej4KPiA+ID4gLS0tCj4gPiA+
IGZzL2V4dDQvc3VwZXIuYyB8IDkgKysrKystLS0tCj4gPiA+IDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4gPiA+Cj4gPiA+IE5vdGUgdGhhdCB0aGlzIHBh
dGNoIGludHJvZHVjZXMgZnN0ZXN0cyBmYWlsdXJlIHdpdGggZ2VuZXJpYy80NTkgdGVzdCBiZWNh
dXNlCj4gPiA+IGl0IGFzc3VtZXMgdGhhdCBlaXRoZXIgZnJlZXppbmcgc3VjY2VlZHMgb3IgJ3Jv
JyBpcyBhbW9uZyBtb3VudCBvcHRpb25zLiBCdXQKPiA+ID4gd2UgZmFpbCB0aGUgZnJlZXplIHdp
dGggRUZTQ09SUlVQVEVELiBUaGlzIG5lZWRzIGZpeGluZyBpbiB0aGUgdGVzdCBidXQgYXQgdGhp
cwo+ID4gPiBwb2ludCBJJ20gbm90IHN1cmUgaG93IGV4YWN0bHkuCj4gPiA+Cj4gPiA+IGRpZmYg
LS1naXQgYS9mcy9leHQ0L3N1cGVyLmMgYi9mcy9leHQ0L3N1cGVyLmMKPiA+ID4gaW5kZXggZTcy
MTQ1YzRhZTVhLi45M2MwMTZiMTg2YzAgMTAwNjQ0Cj4gPiA+IC0tLSBhL2ZzL2V4dDQvc3VwZXIu
Ywo+ID4gPiArKysgYi9mcy9leHQ0L3N1cGVyLmMKPiA+ID4gQEAgLTczNSwxMSArNzM1LDEyIEBA
IHN0YXRpYyB2b2lkIGV4dDRfaGFuZGxlX2Vycm9yKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGJv
b2wgZm9yY2Vfcm8sIGludCBlcnJvciwKPiA+ID4KPiA+ID4gICAgIGV4dDRfbXNnKHNiLCBLRVJO
X0NSSVQsICJSZW1vdW50aW5nIGZpbGVzeXN0ZW0gcmVhZC1vbmx5Iik7Cj4gPiA+ICAgICAvKgo+
ID4gPiAtICAgICogTWFrZSBzdXJlIHVwZGF0ZWQgdmFsdWUgb2YgLT5zX21vdW50X2ZsYWdzIHdp
bGwgYmUgdmlzaWJsZSBiZWZvcmUKPiA+ID4gLSAgICAqIC0+c19mbGFncyB1cGRhdGUKPiA+ID4g
KyAgICAqIEVYVDRfRkxBR1NfU0hVVERPV04gd2FzIHNldCB3aGljaCBzdG9wcyBhbGwgZmlsZXN5
c3RlbQo+ID4gPiArICAgICogbW9kaWZpY2F0aW9ucy4gV2UgZG9uJ3Qgc2V0IFNCX1JET05MWSBi
ZWNhdXNlIHRoYXQgcmVxdWlyZXMKPiA+ID4gKyAgICAqIHNiLT5zX3Vtb3VudCBzZW1hcGhvcmUg
YW5kIHNldHRpbmcgaXQgd2l0aG91dCBwcm9wZXIgcmVtb3VudAo+ID4gPiArICAgICogcHJvY2Vk
dXJlIGlzIGNvbmZ1c2luZyBjb2RlIHN1Y2ggYXMgZnJlZXplX3N1cGVyKCkgbGVhZGluZyB0bwo+
ID4gPiArICAgICogZGVhZGxvY2tzIGFuZCBvdGhlciBwcm9ibGVtcy4KPiA+ID4gICAgICAqLwo+
ID4gPiAtICAgc21wX3dtYigpOwo+ID4gPiAtICAgc2ItPnNfZmxhZ3MgfD0gU0JfUkRPTkxZOwo+
ID4KPiA+IEhpLAo+ID4KPiA+IHNob3VsZG4ndCB0aGUgU0JfUkRPTkxZIHN0aWxsIGJlIHNldCAo
aW4gX19leHQ0X3JlbW91bnQoKSkgZm9yIHRoZSBjYXNlCj4gPiB3aGVuIHVzZXIgdHJpZ2dlcnMg
dGhlIGFib3J0IHdpdGggbW91bnQoLi4sICJhYm9ydCIpPyBCZWNhdXNlIG5vdyB3ZSBzZWVtCj4g
PiB0byBhbHdheXMgaGl0IHRoZSBjb25kaXRpb24gdGhhdCByZXR1cm5zIEVST0ZTIHRvIHVzZXIt
c3BhY2UuCj4KPiBUaGFua3MgZm9yIHJlcG9ydCEgSSBhZ3JlZSByZXR1cm5pbmcgRVJPRlMgZnJv
bSB0aGUgbW91bnQgYWx0aG91Z2gKPiAnYWJvcnRpbmcnIHN1Y2NlZWRlZCBpcyBjb25mdXNpbmcg
YW5kIGlzIG1vc3RseSBhbiB1bmludGVuZGVkIHNpZGUgZWZmZWN0Cj4gdGhhdCBhZnRlciBhYm9y
dGluZyB0aGUgZnMgZnVydGhlciBjaGFuZ2VzIHRvIG1vdW50IHN0YXRlIGFyZSBmb3JiaWRkZW4g
YnV0Cj4gdGhlIHRlc3RjYXNlIGFkZGl0aW9uYWxseSB3YW50cyB0byByZW1vdW50IHRoZSBmcyBy
ZWFkLW9ubHkuCgpSZWdhcmRsZXNzIG9mIHdoYXQgaXMgcmlnaHQgb3Igd3JvbmcgdG8gZG8gaW4g
ZXh0NCwgSSBkb24ndCB0aGluayB0aGF0IHRoZSB0ZXN0CnJlYWxseSBjYXJlcyBhYm91dCByZW1v
dW50IHJlYWQtb25seS4KSSBkb24ndCBzZWUgYW55dGhpbmcgaW4gdGhlIHRlc3QgdGhhdCByZXF1
aXJlcyBpdC4gR2FicmllbD8KSWYgSSByZW1vdmUgTVNfUkRPTkxZIGZyb20gdGhlIHRlc3QgaXQg
d29ya3MganVzdCBmaW5lLgoKQW55IG9iamVjdGlvbiBmb3IgTFRQIG1haW50YWluZXJzIHRvIGFw
cGx5IHRoaXMgc2ltcGxlIHRlc3QgZml4PwoKVGhhbmtzLApBbWlyLgoKLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKKysrIGIvdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIyLmMKQEAgLTU3LDcgKzU3LDcgQEAgc3Rh
dGljIHN0cnVjdCBmYW5vdGlmeV9maWRfdCBiYWRfbGlua19maWQ7CiBzdGF0aWMgdm9pZCB0cmln
Z2VyX2ZzX2Fib3J0KHZvaWQpCiB7CiAgICAgICAgU0FGRV9NT1VOVCh0c3RfZGV2aWNlLT5kZXYs
IE1PVU5UX1BBVEgsIHRzdF9kZXZpY2UtPmZzX3R5cGUsCi0gICAgICAgICAgICAgICAgICBNU19S
RU1PVU5UfE1TX1JET05MWSwgImFib3J0Iik7CisgICAgICAgICAgICAgICAgICBNU19SRU1PVU5U
LCAiYWJvcnQiKTsKIH0KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
