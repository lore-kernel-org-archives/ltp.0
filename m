Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5621CE7A88
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 06:46:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D3403CDDD0
	for <ltp@archiver.kernel.org>; Sun, 24 Sep 2023 08:46:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 363093C9AAC
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 08:46:16 +0200 (CEST)
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com
 [IPv6:2607:f8b0:4864:20::835])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 47BD11000EC4
 for <ltp@lists.linux.it>; Sun, 24 Sep 2023 08:46:16 +0200 (CEST)
Received: by mail-qt1-x835.google.com with SMTP id
 d75a77b69052e-41810cfc569so6616961cf.2
 for <ltp@lists.linux.it>; Sat, 23 Sep 2023 23:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695537975; x=1696142775; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Sw83IUfQOP3EPzhuJykvexUS/eQ7Pw6APXqp0soyYmc=;
 b=WGnoGRleLaOKAWvtkCnKBGXU2z03TXiECUTTuCn7cbQCjcZaahFG/Pz1tanWHYO7U+
 LbABFmSr8sPpuq153CC3kG99SuwY2+d+fHAIX6GaoLTO0IJFkbjbThtP2SYJOwrFnNLD
 CnDRGIUMxnVLIPrg+23OsMopEeHG6mQ3ac8kFNLFqwX/26fwHIYZcmXGUFFJwmsDJ4eY
 KZMPTLgWh6lcM8vOmePftcuGgL/I95uaZnYuI/GyU5Ai+dsU0ubHAZBobzU7bUTtiABK
 wX7FqEjiss85PNizF445+0PyFLhLHH7GwWKDd/RbGzhVZNTh2T2m6HWuKcu5pTsk8ogO
 KGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695537975; x=1696142775;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Sw83IUfQOP3EPzhuJykvexUS/eQ7Pw6APXqp0soyYmc=;
 b=slII3f11x0cKkGWAiIFtHoT9ibNLPqMmx9uxYt6ArFcWXToBGWSYkHswrkk+IOec5h
 jqfUiP4PSs19l176/iUgH4yI5fcwugtaf5kgA/u8ztDQ6Sj1faI3pq2Grc0QTl4Z9vV7
 U7FEKXgIDpfrzn2Ko/PffGneYEPWgsDs3WweKp7j2gNYgMGYaeG+u7NKtqxUhVyK4ssg
 6xiWEqmaPeCKw7+ekfFE3ehEgWM0gPChKKsvbajKcjZgskq/woTBto99pr4UxbUVyAI+
 LjGjHVMkIzDCCXhTyqckc1adVa6mt1qeFQoW4uHTnxVTYyWlb6A6RtoQwzyKtUaXGpAr
 XaXQ==
X-Gm-Message-State: AOJu0Yyr4exk44tWaOSqtlP77REELyP/ajYEHDLTxQn/ZtN/06FULjrN
 N3+aVF2sZv3Z8+iCYq+aIQ4OlnMCsVWCUbaJDVw=
X-Google-Smtp-Source: AGHT+IHfPeicL1opYbA37mRkfqAkFJLmBHj9gEA7b/4KXA1o0GERRH7w24kfchkbmVnzPNkQ+7WtAl5KhdO8aWuibfk=
X-Received: by 2002:a05:620a:22b:b0:774:131c:854d with SMTP id
 u11-20020a05620a022b00b00774131c854dmr4099448qkm.72.1695537974912; Sat, 23
 Sep 2023 23:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20230909043806.3539-1-reubenhwk@gmail.com>
 <202309191018.68ec87d7-oliver.sang@intel.com>
 <CAOQ4uxhc8q=GAuL9OPRVOr=mARDL3TExPY0Zipij1geVKknkkQ@mail.gmail.com>
 <CAD_8n+TpZF2GoE1HUeBLs0vmpSna0yR9b+hsd-VC1ZurTe41LQ@mail.gmail.com>
 <ZQ1Z_JHMPE3hrzv5@yuki>
 <CAD_8n+ShV=HJuk5v-JeYU1f+MAq1nDz9GqVmbfK9NpNThRjzSg@mail.gmail.com>
 <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org>
 <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
In-Reply-To: <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 24 Sep 2023 09:46:03 +0300
Message-ID: <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
To: Reuben Hawkins <reubenhwk@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 lkp@intel.com, Matthew Wilcox <willy@infradead.org>, oe-lkp@lists.linux.dev,
 kernel test robot <oliver.sang@intel.com>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU3VuLCBTZXAgMjQsIDIwMjMgYXQgNjo0OOKAr0FNIFJldWJlbiBIYXdraW5zIDxyZXViZW5o
d2tAZ21haWwuY29tPiB3cm90ZToKPgo+Cj4KPiBPbiBTYXQsIFNlcCAyMywgMjAyMyBhdCAxMDo0
OOKAr0FNIEFtaXIgR29sZHN0ZWluIDxhbWlyNzNpbEBnbWFpbC5jb20+IHdyb3RlOgo+Pgo+PiBP
biBTYXQsIFNlcCAyMywgMjAyMyBhdCA1OjQx4oCvUE0gTWF0dGhldyBXaWxjb3ggPHdpbGx5QGlu
ZnJhZGVhZC5vcmc+IHdyb3RlOgo+PiA+Cj4+ID4gT24gU2F0LCBTZXAgMjMsIDIwMjMgYXQgMDg6
NTY6MjhBTSArMDMwMCwgQW1pciBHb2xkc3RlaW4gd3JvdGU6Cj4+ID4gPiBXZSBkZWNpZGVkIHRv
IGRlbGliZXJhdGVseSB0cnkgdGhlIGNoYW5nZSBvZiBiZWhhdmlvcgo+PiA+ID4gZnJvbSBFSU5W
QUwgdG8gRVNQSVBFLCB0byBhbGlnbiB3aXRoIGZhZHZpc2UgYmVoYXZpb3IsCj4+ID4gPiBzbyBl
dmVudHVhbGx5IHRoZSBMVFAgdGVzdCBzaG91bGQgYmUgY2hhbmdlZCB0byBhbGxvdyBib3RoLgo+
PiA+ID4KPj4gPiA+IEl0IHdhcyB0aGUgdGVzdCBmYWlsdXJlIG9uIHRoZSBzb2NrZXQgdGhhdCBh
bGFybWVkIG1lLgo+PiA+ID4gSG93ZXZlciwgaWYgd2Ugd2lsbCBoYXZlIHRvIHNwZWNpYWwgY2Fz
ZSBzb2NrZXQgaW4KPj4gPiA+IHJlYWRhaGVhZCgpIGFmdGVyIGFsbCwgd2UgbWF5IGFzIHdlbGwg
YWxzbyBzcGVjaWFsIGNhc2UKPj4gPiA+IHBpcGUgd2l0aCBpdCBhbmQgcmV0YWluIHRoZSBFSU5W
QUwgYmVoYXZpb3IgLSBsZXQncyBzZWUKPj4gPiA+IHdoYXQgeW91ciBmaW5kaW5ncyBhcmUgYW5k
IGRlY2lkZS4KPj4gPgo+PiA+IElmIEkgcmVhZCBpdCBjb3JyZWN0bHksIExUUCBpcyByZXBvcnRp
bmcgdGhhdCByZWFkaGFlYWQoKSBvbiBhIHNvY2tldAo+PiA+IHJldHVybmVkIHN1Y2Nlc3MgaW5z
dGVhZCBvZiBhbiBlcnJvci4gIFNvY2tldHMgZG8gaGF2ZSBhX29wcywgcmlnaHQ/Cj4+ID4gSXQn
cyBzZXQgdG8gZW1wdHlfYW9wcyBpbiBpbm9kZV9pbml0X2Fsd2F5cywgSSB0aGluay4KPj4gPgo+
Pgo+PiBZZWgsIHlvdSBhcmUgcmlnaHQuCj4+IEkgZ3Vlc3MgdGhlIGNoZWNrICFmLmZpbGUtPmZf
bWFwcGluZy0+YV9vcHMgaXMgY29tcGxldGVseSBmdXRpbGUKPj4gaW4gdGhhdCBjb2RlLiBJdCdz
IHRoZSBvbmx5IHBsYWNlIEkgY291bGQgZmluZCB0aGlzIHNvcnQgb2YgY2hlY2sKPj4gZXhjZXB0
IGZvciBwbGFjZXMgbGlrZToKPj4gaWYgKGYtPmZfbWFwcGluZy0+YV9vcHMgJiYgZi0+Zl9tYXBw
aW5nLT5hX29wcy0+ZGlyZWN0X0lPKQo+PiB3aGljaCBqdXN0IGxvb2tzIGxpa2UgYSBjb2Rpbmcg
aGFiaXQuCj4+Cj4+ID4gSXQgd291bGQgYmUgbmljZSBpZiB3ZSBkb2N1bWVudGVkIHNvbWV3aGVy
ZSB3aGljaCBwb2ludGVycyBzaG91bGQgYmUKPj4gPiBjaGVja2VkIGZvciBOVUxMIGZvciB3aGlj
aCBjYXNlcyAuLi4gaXQgZG9lc24ndCByZWFsbHkgbWFrZSBzZW5zZSBmb3IKPj4gPiBhIHNvY2tl
dCBpbm9kZSB0byBoYXZlIGFuIGlfbWFwcGluZyBzaW5jZSBpdCBkb2Vzbid0IGhhdmUgcGFnZWNh
Y2hlLgo+PiA+IEJ1dCBtYXliZSB3ZSByZWx5IG9uIGlfbWFwcGluZyBhbHdheXMgYmVpbmcgc2V0
Lgo+PiA+Cj4+Cj4+IEkgY2FuJ3QgaW1hZ2luZSB0aGF0IGEgc29ja2V0IGhhcyBmX21hcHBpbmcu
Cj4+IFRoZXJlIG11c3QgaGF2ZSBiZWVuIHNvbWV0aGluZyBvZmYgd2l0aCB0aGlzIHNwZWNpZmlj
IGJ1ZyByZXBvcnQsCj4+IGJlY2F1c2UgaXQgd2FzIHJlcG9ydGVkIG9uIGEgV0lQIHBhdGNoLgo+
Pgo+PiA+IElycml0YXRpbmdseSwgUE9TSVggc3BlY2lmaWVzIEVTUElQRSBmb3IgcGlwZXMsIGJ1
dCBkb2VzIG5vdCBzcGVjaWZ5Cj4+ID4gd2hhdCB0byBkbyB3aXRoIHNvY2tldHMuICBJdCdzIGtp
bmQgb2YgYSBtZWFuaW5nbGVzcyBzeXNjYWxsIGZvcgo+PiA+IGFueSBraW5kIG9mIG5vbi1zZWVr
YWJsZSBmZC4gIGxzZWVrKCkgcmV0dXJucyBFU1BJUEUgZm9yIHNvY2tldHMKPj4gPiBhcyB3ZWxs
IGFzIHBpcGVzLCBzbyBJJ2Qgc2VlIHRoaXMgYXMgYW4gb3ZlcnNpZ2h0Lgo+PiA+IGh0dHBzOi8v
cHVicy5vcGVuZ3JvdXAub3JnL29ubGluZXB1YnMvOTY5OTkxOTc5OS9mdW5jdGlvbnMvcG9zaXhf
ZmFkdmlzZS5odG1sCj4+ID4gaHR0cHM6Ly9wdWJzLm9wZW5ncm91cC5vcmcvb25saW5lcHVicy85
Njk5OTE5Nzk5L2Z1bmN0aW9ucy9sc2Vlay5odG1sCj4+ID4KPj4KPj4gSW5kZWVkLCB3ZSB0aG91
Z2h0IGl0IHdvdWxkbid0IGJlIHRvbyBiYWQgdG8gYWxpZ24gdGhlCj4+IHJlYWRhaGVhZCBlcnJv
cnMgd2l0aCB0aG9zZSBvZiBwb3NpeF9mYWR2aXNlLgo+PiBUaGF0J3Mgd2h5IHdlIGFza2VkIHRv
IHJlbW92ZSB0aGUgU19JU0ZJRk8gY2hlY2sgZm9yIHYyLgo+PiBCdXQgbG9va2luZyBhZ2Fpbiwg
cGlwZSB3aWxsIGdldCBFSU5WQUwgZm9yICFmX21hcHBpbmcsIHNvIHRoZQo+PiBVQVBJIHdhc24n
dCBjaGFuZ2VkIGF0IGFsbCBhbmQgd2Ugd2VyZSBqdXN0IHRhbGtpbmcgQlMgYWxsIGFsb25nLgo+
PiBMZXQncyBsZWF2ZSB0aGUgVUFQSSBhcyBpcy4KPj4KPj4gPiBPZiBjb3Vyc2UgcmVhZGFoZWFk
KCkgaXMgYSBMaW51eC1zcGVjaWZpYyBzeXNjYWxsLCBzbyB3ZSBjYW4gZG8gd2hhdGV2ZXIKPj4g
PiB3ZSB3YW50IGhlcmUsIGJ1dCBJJ20gcmVhbGx5IHRlbXB0ZWQgdG8ganVzdCBhbGxvdyByZWFk
YWhlYWQoKSBmb3IKPj4gPiByZWd1bGFyIGZpbGVzIGFuZCBibG9jayBkZXZpY2VzLiAgSG1tLiAg
Q2FuIHdlIGNoZWNrIEZNT0RFX0xTRUVLCj4+ID4gaW5zdGVhZCBvZiAoU19JU0ZJTEUgfHwgU19J
U0JMSyk/Cj4+Cj4+IEkgdGhpbmsgdGhlIGZfbWFwcGluZyBjaGVjayBzaG91bGQgYmUgZ29vZC4K
Pj4gUmV1YmVuIGFscmVhZHkgc2FpZCBoZSBjb3VsZCBub3QgcmVwcm9kdWNlIHRoZSBMVFAgZmFp
bHVyZSB3aXRoCj4+IHYyIHRoYXQgaXMgb24gQ2hyaXN0aWFuJ3MgdmZzLm1pc2MgYnJhbmNoLgo+
Pgo+PiBUaGUgU19JU1JFRyBjaGVjayBJIHB1dCBpbiB0aGUgRml4ZXMgY29tbWl0IHdhcyBjb21w
bGV0ZWx5Cj4+IHVuZXhwbGFpbmVkIGluIHRoZSBjb21taXQgbWVzc2FnZSBhbmQgY29tcGxldGVs
eSB1bm5lZWRlZC4KPj4gSnVzdCByZW1vdmluZyBpdCBhcyB3YXMgZG9uZSBpbiB2MiBpcyBlbm91
Z2guCj4+Cj4+IEhvd2V2ZXIsIHYyIGhhcyB0aGlzIHdyb25nIGNvbW1lbnQgaW4gdGhlIGNvbW1p
dCBtZXNzYWdlOgo+PiAiVGhlIGNoYW5nZSBhbHNvIG1lYW5zIHRoYXQgcmVhZGFoZWFkIHdpbGwg
cmV0dXJuIC1FU1BJUEUKPj4gICBvbiBGSUZPIGZpbGVzIGluc3RlYWQgb2YgLUVJTlZBTC4iCj4+
Cj4+IFdlIG5lZWQgdG8gcmVtb3ZlIHRoaXMgY29tbWVudAo+PiBhbmQgY291bGQgYWxzbyByZW1v
dmUgdGhlIHVubmVlZGVkICFmLmZpbGUtPmZfbWFwcGluZy0+YV9vcHMKPj4gY2hlY2sgd2hpbGUg
YXQgaXQuCj4+Cj4+IFRoYW5rcywKPj4gQW1pci4KPgo+Cj4gSXQgbG9va3MgdG8gbWUgbGlrZSB0
aGUgZm9sbG93aW5nIHdpbGwgZml4IHRoZSBwcm9ibGVtIHdpdGhvdXQgYnJlYWtpbmcgdGhlIHRl
c3RzLi4uCj4KPiAtIGlmICghZi5maWxlLT5mX21hcHBpbmcgfHwgIWYuZmlsZS0+Zl9tYXBwaW5n
LT5hX29wcyB8fAo+IC0gICAgIVNfSVNSRUcoZmlsZV9pbm9kZShmLmZpbGUpLT5pX21vZGUpKQo+
ICsgaWYgKCEoZi5maWxlLT5mX21vZGUgJiBGTU9ERV9MU0VFSykpCj4KPiAuLi5JJ2xsIHB1dCB0
aGlzIGluIGEgdjMgcGF0Y2ggc29vbiB1bmxlc3Mgc29tZWJvZHkgY2FuIHNwb3QgYW55IHJlYXNv
bnMgd2h5Cj4gdGhpcyBpcyBubyBnb29kLgoKSSBhbSBjb25mdXNlZC4KSSB0aG91Z2h0IHlvdSB3
cm90ZSB0aGF0IHYyIGRpZCBub3QgYnJlYWsgdGhlIHRlc3QuCldoeSB0aGVuIGlzIHRoaXMgY2hh
bmdlIHRvIHVzZSBGTU9ERV9MU0VFSyBuZWVkZWQ/CldoeSBpcyBpdCBub3QgZW5vdWdoIHRvIGxl
YXZlIGp1c3QKICAgaWYgKCFmLmZpbGUtPmZfbWFwcGluZykKClBlcmhhcHMgbXkgY29tbWVudCB0
byByZW1vdmUgdGhlIHVubmVlZGVkCiAhZi5maWxlLT5mX21hcHBpbmctPmFfb3BzIHdhcyBtaXN1
bmRlcnN0b29kPwoKQWxzbywgaW4gcGF0Y2ggdjMsIHlvdSBhZGRlZCBSVkIgb2YgSmFuLCBidXQg
dGhpcyBpcyBub3QgdGhlCnZlcnNpb24gdGhhdCBKYW4gaGFzIHJldmlld2VkLgoKVGhhbmtzLApB
bWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
