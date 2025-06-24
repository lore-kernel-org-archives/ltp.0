Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2EA1C77B7F
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 10:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750760270; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=KzXixO1CHTxa4+Q/TnnOFdEk0uNN4VSyOPwuE+6jKOY=;
 b=D88p19R/ImAgDtl+6sSlJY5AHGKtuKVbbMJqRj4ULt0fCVEmRg32CiKfleFU1113+RY7R
 /hen5lTGXGjDNP8XOhiKTHGd+dB1ZCHov79Sp8cH/w56xsvmbtUHLC4+TLwGr6ISyxHgO6L
 +B8HmSs1J95/uVfDyTRy1Kg7Kr0Dg3I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 22D313CCAB0
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 12:17:50 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8B9C93CCA79
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 12:17:27 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E22F51400E40
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 12:17:25 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a50fc819f2so218118f8f.2
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1750760245; x=1751365045; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=OLkn6X7IgNlZ+NHTTfCqICy8cdo1Hvpf+kDNicFWcw0=;
 b=XVo2BnNAvMwdaTVE0yrBGmZST09eE/y9QQjUdW8rd2hlCkIq7O2mYfEl/ffhtKbBAI
 b88ZRRLk85bHRT5jCSJxlD0+BxAoikhKAjmUgkOuNrhSSs19aj/jLL42LsUJjSgBD+S2
 EfL7HDknpalYsbgc64dI+NP4BM8ENvGSKx4EfYYmclP8RkDDaTLizlrV+lHc2WhV9Lam
 sB6DuwWjQyF9pY38gOexsh89rKXcM4m/E47kfZnCg5/kdaCRzU71O/ujl2oM2TQbZ1iO
 YJQgYokyYVXhLR783Ls70cz4mmtIG6OaVDzbsWjC6y7gQDsFXP+bxzEIBQzFwYSkX3s4
 Y8Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750760245; x=1751365045;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OLkn6X7IgNlZ+NHTTfCqICy8cdo1Hvpf+kDNicFWcw0=;
 b=OagxkEE5kC4B/LMEUB2IEhYSfmuDDFjX5FV3qnFnPbsPWkNzdbXJUr2eZYb1eWthWK
 kXZO/Wh9e7Xm5QDq2AX9gkYdqWkg+rhBv0z67/EAPg061gpaJ8IalivDgDrsr9sR08IS
 2L/QPnUmpeMaPK6CklwpPxWT/Zgdq+xgDMVagspr85QeNE41Huz6i7SlAhV3y20n1Grr
 IeGBSguQg+r0ajLTN7XBlQrVbmNLWqJ+Kt/EFoR5qgwNI0+fD1HzUPXPnS7jbwFXuScx
 jus9KwHA2L6vqK4id7Z82WV11kPLg+lvbWO0fKeVzPZAztItvYhMuLOZEm39L7M/PDPK
 2+Ag==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBO5CoSuaQjgwlFPguQqhxFLFg6bc/Keh+1qXbmFDvJLzC5Wrs61ht8En07+mE2BOYMms=@lists.linux.it
X-Gm-Message-State: AOJu0Yyws0lH5HXS1lc0LwPW1+zVaFfD54/OEONEgCAxLj/0TorhEKtn
 6f36AyaO9aoWEFUThAKBw1GtlKZr7HFxVrotwiNbaTACEqugrC+aFbEZ04CArLYluODQklBToWQ
 6zKBpNkM=
X-Gm-Gg: ASbGncvPvDzc39X1Qn65w8mV7SXT2oa24NNeIfNT/7CDvGEh9XdDj0ZHBIqbYV77HN7
 /7fa8kugoNJqfZTbsYblpoTeox6PHrATtW7qaoKCMZP0o5U3kyvrLw4ME2F9t2eNxKqzOjg1PKX
 vMsNwwkNmAMaPureLek6+kSJ7nE76nDZy5GHrAxb2bQ1kEmbsRuU7xR1smNHSp1gFgfHDONZGZX
 rhmk8WyrRQuTqi1z7AJ+R5i7Hnd/3e6kFfOhLeanu+1SFHvcAen4G0lHfKOvWSZ30v+QA5WxUGa
 z3RBmnRFa9bwnKqqIZRNh9q+TG8pJz3QbARSqeWCSNFUrdkCAX6IbK/o1myayElylwFUFJmNxer
 qZXFa9+O9GA83LCo/xKEmEnkPpGW0QBblaLmSB69iN17QyOLEEKomo21pzrgS+dWgtk2SHoXR2K
 iaRkxiCsCEJmvPCni7hR+1MaA/tw==
X-Google-Smtp-Source: AGHT+IFqZighREZlDN8BrGyxLoNVizJ2JWU5BN3I2JZCQJT/9l8D53HH6zHMXNxnK1XMzYOs+tCSKA==
X-Received: by 2002:a5d:64e6:0:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3a6d12c1f0bmr14383570f8f.13.1750760245133; 
 Tue, 24 Jun 2025 03:17:25 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f2e:9a00:8d36:debd:d407:5caf?
 (p200300ef2f2e9a008d36debdd4075caf.dip0.t-ipconnect.de.
 [2003:ef:2f2e:9a00:8d36:debd:d407:5caf])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34aabc3842sm28431a12.50.2025.06.24.03.17.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Jun 2025 03:17:24 -0700 (PDT)
Message-ID: <f3ba096d-a724-4e15-a241-28c25ae71c58@suse.com>
Date: Tue, 24 Jun 2025 12:17:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it
References: <20250611-crash02_rewrite-v1-1-1becd9dc163d@suse.com>
 <62f31420-ad63-4c03-a42f-2cc0f7c2722e@suse.cz>
 <2f75ea2e-4d1a-4165-89cf-11e67c1d947c@suse.com>
 <7c62d451-71c2-47a8-9ea1-080d612391d9@suse.cz>
Content-Language: en-US
In-Reply-To: <7c62d451-71c2-47a8-9ea1-080d612391d9@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] misc: rewrite crash02 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Ck9uIDYvMjMvMjUgMTo0MCBQTSwgTWFydGluIERvdWNoYSB3cm90ZToKPiBPbiAyMy4gMDYuIDI1
IDEwOjE1LCBBbmRyZWEgQ2VydmVzYXRvIHdyb3RlOgo+Pj4+IMKgIC3CoMKgwqAgaWYgKGxfb3B0
KQo+Pj4+IC3CoMKgwqDCoMKgwqDCoCBzeXNub19tYXggPSBhdG9pKGxfY29wdCk7Cj4+Pj4gK8Kg
wqDCoCBudW0gPSAoYnVmZlswXSA8PCAyNCkgfCAoYnVmZlsxXSA8PCAxNikgfCAoYnVmZlsyXSA8
PCA4KSB8IAo+Pj4+IGJ1ZmZbM107Cj4+Pj4gK8KgwqDCoCBpZiAobnVtIDwgMCkKPj4+PiArwqDC
oMKgwqDCoMKgwqAgbnVtICo9IC0xOwo+Pj4+ICvCoMKgwqAgbnVtID0gKG51bSAlIE1BWF9TWVND
QUxMUykgLSAxOwo+Pj4KPj4+IFdoeSBkbyB5b3Ugc3VidHJhY3Qgb24gdGhlIGxhc3QgbGluZSBh
Ym92ZT8gCj4+IFNvbWUgc3lzY2FsbHMgbmVlZCB0byBzZXQgdGhlaXIgYXJndW1lbnQgdG8gLTEg
c29tZXRpbWVzLgo+Cj4gT0ssIHdlIHNob3VsZCB0ZXN0IHRoZSB3aG9sZSB2YWx1ZSByYW5nZSwg
dGhvdWdoLiBPdGhlciBuZWdhdGl2ZSAKPiB2YWx1ZXMgbWlnaHQgdHJpZ2dlciBjb3JuZXIgY2Fz
ZXMgd2UncmUgc3RpbGwgaW50ZXJlc3RlZCBpbi4KV2hhdCBpcyBub3QgY29udmluY2luZyBtZSBh
Ym91dCB0aGlzIGFwcHJvYWNoIGlzIHRoYXQgd2UgbWlnaHQgc3R1Y2sgCmludG8gbmVnYXRpdmUg
dmFsdWVzIGJ5IGdlbmVyYXRpbmcgcmFuZG9tIG51bWJlcnMuClRoZSB0ZXN0IHNob3VsZCBydW4g
Zm9yIG1hbnkgaG91cnMgb3IgZXZlbiBkYXlzLiBBbmQgdGhhdCdzIHNvbWV0aGluZyB3ZSAKYWxy
ZWFkeSBoYXZlIGZvciBzeXprYWxsZXIgKG5vdCB1c2VkIGJ5IFNVU0UgYnV0IGJ5IG1hbnkgb3Ro
ZXIgY29tcGFuaWVzKS4KPgo+Pj4gQWxzbywgdGhpcyB3b3VsZCBiZSBtdWNoIHNpbXBsZXIgYW5k
IHRoZSB0cnVuY2F0aW9uIHRvIE1BWF9TWVNDQUxMUyAKPj4+IHNob3VsZCBiZSBkb25lIGJ5IGNh
bGxlciB3aGVuIG5lZWRlZC4KPj4+Cj4+PiBzdGF0aWMgaW5saW5lIGxvbmcgcmFuZF9sb25nKHZv
aWQpCj4+PiB7Cj4+PiDCoMKgwqDCoGxvbmcgcmV0Owo+Pj4KPj4+IMKgwqDCoMKgaWYgKGdldHJh
bmRvbSgmcmV0LCBzaXplb2YocmV0KSwgMCkgPCAwKQo+Pj4gwqDCoMKgwqDCoMKgwqAgdHN0X2Jy
ayguLi4pOwo+Pj4KPj4+IMKgwqDCoMKgcmV0dXJuIHJldDsKPj4+IH0KPj4+Cj4+PiBBbHRob3Vn
aCBpdCdzIGJlIGdyZWF0IHRvIHN1cHBvcnQgc2V0dGluZyByYW5kb20gc2VlZCBsaWtlIGluIHRo
ZSAKPj4+IG9yaWdpbmFsIHRlc3Qgc28gdGhhdCBjcmFzaGVzIGNhbiBiZSByZXByb2R1Y2VkLgo+
Pgo+PiBJIGRvbid0IHRoaW5rIEkgdW5kZXJzdGFuZCB0aGlzIHNlbnRlbmNlLiBUaGlzIGNvZGUg
aXMgdGFraW5nIGludG8gCj4+IGFjY291bnQgdGhlIHNwZWNpZmljIG51bWVyaWMgYXJjaCBzaXpl
LCBieSBjYXN0aW5nIGEgNjRiaXQgbnVtYmVyIHRvIAo+PiAibG9uZyIgdHlwZS4gbG9uZyBoYXMg
dmFyaWFibGUgYnl0ZXMgYW5kIGl0J3MgZXZlbnR1YWxseSBjdXQgZHVyaW5nIAo+PiB0aGUgY2Fz
dC4KPj4KPj4gVGhlIGNyYXNoIGNhbiBiZSByZXByb2R1Y2VkIGJlY2F1c2Ugd2UgYXJlIFRERUJV
RyB0aGUgZnVsbCBzeXNjYWxsIAo+PiBhZGRyZXNzIGFuZCBhcmd1bWVudHMgd2hpY2ggYXJlIGdp
dmVuIHRvIGl0Lgo+Cj4gU29tZSBjcmFzaGVzIG1heSBuZWVkIG11bHRpcGxlIHN5c2NhbGxzIHRv
IHNldCB1cC4gUnVubmluZwo+IGNyYXNoMDIgLXMgJHJuZF9zZWVkCj4gYWxsb3dzIGZvciBlYXNp
ZXIgcmVwcm9kdWN0aW9uIHRoYW4gY29weS1wYXN0aW5nIHRoZSBlbnRpcmUgY2FsbCBsb2cgCj4g
aW50byBhIG5ldyB0ZXN0LgpPayBub3cgSSB1bmRlcnN0b29kLiBZZXMsIEkgY2FuIGFkZCB0aGF0
Lgo+Cj4+Pj4gK8KgwqDCoCBkbyB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGludmFsaWQgPSAwOwo+
Pj4+ICvCoMKgwqDCoMKgwqDCoCBzeXNubyA9IHJhbmRfbnVtYmVyKCkgJSBNQVhfU1lTQ0FMTFM7
Cj4+Pj4gKwo+Pj4+ICvCoMKgwqDCoMKgwqDCoCBmb3IgKHNpemVfdCBpID0gMDsgaSA8IEFSUkFZ
X1NJWkUoYmxhY2tsaXN0KTsgaSsrKSB7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGJsYWNrbGlzdFtpXSA9PSBzeXNubykgewo+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgaW52YWxpZCA9IDE7Cj4+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBi
cmVhazsKPj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4+Pj4gwqDCoMKgwqDCoMKgwqDC
oMKgIH0KPj4+Cj4+PiBUaGUgb3JpZ2luYWwgYXBwcm9hY2ggd2l0aCBpbl9ibGFja2xpc3QoKSBo
ZWxwZXIgZnVuY3Rpb24gd2FzIAo+Pj4gY2xlYW5lci4gQWxzbyBub3RlIHRoYXQgYm90aCB5b3Vy
IHJhbmRfbnVtYmVyKCkgYW5kIG15IHJhbmRfbG9uZygpIAo+Pj4gY2FuIHJldHVybiBuZWdhdGl2
ZSB2YWx1ZXMuCj4+IFRoZXkgY2FuIHJldHVybiAtMSBvbmx5LiBBbGwgdGhlIG5lZ2F0aXZlIHZh
bHVlcyBiZWxvdyB0aGlzIHZhbHVlIGFyZSAKPj4gY29udmVydGVkIHRvIHBvc2l0aXZlIG51bWJl
cnMuCj4KPiBSZXR1cm5pbmcgLTEgbWlnaHQgYmUgZW5vdWdoIHRvIGNhdXNlIHRyb3VibGUgaGVy
ZS4gV2hpbGUgeW91IGRpZCBhZGQgCj4gX19MVFBfX05SX0lOVkFMSURfU1lTQ0FMTCB0byB0aGUg
YmxhY2tsaXN0LCBpZiB0aGUgY29uc3RhbnQgY2hhbmdlcywgCj4geW91J2xsIGVuZCB1cCBjYWxs
aW5nIHN5c2NhbGwoLTEsIC4uLikgb24gc29tZSBhcmNocyBhbmQgCj4gc3lzY2FsbChNQVhfU1lT
Q0FMTFMtMSwgLi4uKSBvbiBvdGhlcnMuIFRoZSBDIHN0YW5kYXJkIGRvZXNuJ3QgZGVmaW5lIAo+
IHdoaWNoIG9mIHRoZXNlIHZhbHVlcyBpcyB0aGUgY29ycmVjdCByZXN1bHQgb2YgbW9kdWxvIG9w
ZXJhdGlvbiB3aXRoIGEgCj4gbmVnYXRpdmUgbGVmdCBvcGVyYW5kLgo+CkkgY2FuIHNldCB0byBf
X0xUUF9OUl9JTlZBTElEX1NZU0NBTEwgYWxsIHRoZSB0aW1lcyBJIG9idGFpbiBhIG5lZ2F0aXZl
IAp2YWx1ZS4gVGhlIGxvb3Agd2lsbCByZXN0YXJ0LCB0aGUgc3lzY2FsbCB3aWxsIGJlIHZhbGlk
LiBCdXQgb25seSBmb3IgCnN5c2NhbGxzLiBGb3IgYXJndW1lbnRzIHdlIG5lZWQgdG8gZGVjaWRl
ZCBpZiBpdCdzIHRoZSBjYXNlIHRvIHJ1biB3aXRoIApldmVyeSBwb3NzaWJsZSBuZWdhdGl2ZSB2
YWx1ZSAoZGlzY3Vzc2lvbmUgYWJvdmUpLgoKLSBBbmRyZWEKCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
