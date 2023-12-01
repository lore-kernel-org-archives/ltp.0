Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DFABC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 20:12:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2F1C3CF611
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 21:12:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6F9403CD933
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 21:12:09 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CBC7A1000D54
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 21:12:08 +0100 (CET)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.nyi.internal (Postfix) with ESMTP id 478415C00A7;
 Fri,  1 Dec 2023 15:12:07 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute1.internal (MEProxy); Fri, 01 Dec 2023 15:12:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1701461527; x=1701547927; bh=uNlaI4JCStz3sD0HE7ynUAiBzfHPAB12FHe
 Yeu2w9c0=; b=NuYZmYrXpcacbHuvsjavqq+v9JcyFV2PVg5AUwyY3wuER7TXlp9
 AWPstw4Bw0C4iGcL5sEb9ulOz4iY6bVt1/ZaNStYI0JfSwGfm6K5tDVIBZJyDl2l
 myWaG3u6ikGZUgyc+LzPAg+mCaDBuWmit3IXOtBRtDrR7UrbPf7N59HT8lRIJ/54
 Jot4TjyCWSH7V78fm+dL3bNLjd+ul1xPXhVnJqHkoCBuaU+0kr2rmGX6kyyzm3y7
 YrHxJz220Tz2Sh0YquPyeEK+p92C+CmmPdckNeEAZQnb4ouIy8exNdv8HAkBifCO
 9i3nIYCXrUNOgXM+GD5s8vBWlekg6rAd3BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1701461527; x=1701547927; bh=uNlaI4JCStz3sD0HE7ynUAiBzfHPAB12FHe
 Yeu2w9c0=; b=1Lo6RGkKTpIYetcCyH6NSbU8YdLH2mw2LY9a0l+0XHtFVO4pfZA
 AB9dmGD1yJC6trfPwSYhA0MdSTHvWAzZlpi3nXD8yHoisv6TLVmE47uczvIshlag
 Ak7E3IB8rO1bP6dSbkgNjDKtUgHuB9YGvm5U1leQvMv3qbH9vQVJOqQkvj8Owg9l
 F/YD6FWC5k2otAQm/cGdkbWM1/l0dm+Ft7+nKmvVZnpq6qNodwZlw+9afMcduBOo
 z/vY+MKcNrej92XtQA1L820HxA/tlC/7JZchtmPye/OKp5RV0HoXmpy1/A7JHOru
 tupieMVWaUdT1jGiBMXRDikpQiVgbaQzc4A==
X-ME-Sender: <xms:Fj5qZZImdb5rnS94SdrgT-gdAYlfZ2DJb_QOZ1eVbIf27VRxsqiOxA>
 <xme:Fj5qZVK0FstVnmpxaSJnmnojbz0yaAvCofvVVJrj425clFuztQxdQBVM5RZMwxQCu
 5QvOmmGHsl_vJzM35U>
X-ME-Received: <xmr:Fj5qZRvLpC0Ddyn_skWUMqWjl4vcJBxVlI20hranlvpo-wBUB0YOaCjt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudefgecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpehffgfhvfevufffjgfkgggtgfesthhqredttderjeenucfhrhhomhepufht
 vghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrf
 grthhtvghrnhepfedtjefhheeileevhfehheeutdekleduueejteffvddtfedtfffhleek
 geekgfdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhes
 uggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:Fz5qZaYobGkrxAeVPEVQAGVscw3Zld_QHdGdj91zQy28vRkAwTCMvQ>
 <xmx:Fz5qZQY33riMBbKjeOwlH8X8q5jVynFSlvuN-lHOFsigFFGuZb2CMA>
 <xmx:Fz5qZeBte8qdjVcXcpet8i2Og0l9_OdIV_qUuiG-o_tp_QFKJrFp-g>
 <xmx:Fz5qZfwYojzFt_T0Lx6-pkhBjz7vkLHmgj66IA9cpkrzE7DJYdtXxQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:12:04 -0500 (EST)
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
 <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
 <20231128165132.GA406520@pevik>
 <CAEemH2fqamX720diM1N+iN9a8HM30_5sHg8V0EMHgHdrh3iZPw@mail.gmail.com>
 <20231129101010.GA535399@pevik>
User-agent: mu4e 1.10.3; emacs 29.1
From: Stefan Roesch <shr@devkernel.io>
To: Petr Vorel <pvorel@suse.cz>
Date: Fri, 01 Dec 2023 12:11:38 -0800
In-reply-to: <20231129101010.GA535399@pevik>
Message-ID: <87zfyt4r8t.fsf@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mem: disable KSM smart scan for ksm tests
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
Cc: david@redhat.com, linux-mm@kvack.org, oliver.sang@intel.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

ClBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cml0ZXM6Cgo+PiBPbiBXZWQsIE5vdiAyOSwg
MjAyMyBhdCAxMjo1MeKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKPgo+
PiA+IEhpIFN0ZWZhbiwgTGksCj4KPj4gPiA+IEhpIFN0ZWZhbiwgUGV0ciwKPgo+PiA+ID4gT24g
VHVlLCBOb3YgMjgsIDIwMjMgYXQgMzo0NuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6
PiB3cm90ZToKPgo+PiA+ID4gPiBIaSBTdGVmYW4sCj4KPj4gPiA+ID4gPiBUaGlzIGRpc2FibGVz
IHRoZSAic21hcnQgc2NhbiIgS1NNIGZlYXR1cmUgdG8gbWFrZSBzdXJlIHRoYXQgdGhlCj4+ID4g
dm9sYXRpbGUKPj4gPiA+ID4gPiBjb3VudCByZW1haW5zIGF0IDAuCj4KPj4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW4gUm9lc2NoIDxkZXZrZXJuZWwuaW8+Cj4+ID4gPiA+IG5pdDogeW91
IGZvcmdvdCAnc2hyQCcKPj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFuIFJvZXNjaCA8c2hy
QGRldmtlcm5lbC5pbz4KPgo+PiA+ID4gPiA+IFJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2Jv
dCA8b2xpdmVyLnNhbmdAaW50ZWwuY29tPgo+PiA+ID4gPiA+IENsb3NlczoKPgo+PiA+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDIzMTExNjExMzIuMTNkOGNlNWEtb2xpdmVyLnNh
bmdAaW50ZWwuY29tCj4+ID4gPiA+ID4gLS0tCj4+ID4gPiA+ID4gIHRlc3RjYXNlcy9rZXJuZWwv
bWVtL2xpYi9tZW0uYyB8IDQgKysrKwo+PiA+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspCj4KPj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0v
bGliL21lbS5jCj4+ID4gPiA+IGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jCj4+ID4g
PiA+ID4gaW5kZXggZmJmZWVmMDI2Li5lZjI3NGEzYWMgMTAwNjQ0Cj4+ID4gPiA+ID4gLS0tIGEv
dGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jCj4+ID4gPiA+ID4gKysrIGIvdGVzdGNhc2Vz
L2tlcm5lbC9tZW0vbGliL21lbS5jCj4+ID4gPiA+ID4gQEAgLTQ1NCw2ICs0NTQsOSBAQCB2b2lk
IGNyZWF0ZV9zYW1lX21lbW9yeShpbnQgc2l6ZSwgaW50IG51bSwgaW50Cj4+ID4gdW5pdCkKPj4g
PiA+ID4gPiAgICAgICAgICAgICAgeydhJywgc2l6ZSpNQn0sIHsnYScsIHNpemUqTUJ9LCB7J2Qn
LCBzaXplKk1CfSwgeydkJywKPj4gPiA+ID4gc2l6ZSpNQn0sCj4+ID4gPiA+ID4gICAgICAgfTsK
Pgo+PiA+ID4gPiA+ICsgIC8qIERpc2FibGUgc21hcnQgc2NhbiBmb3IgY29ycmVjdCB2b2xhdGls
ZSBjb3VudHMuICovCj4+ID4gPiA+ID4gKyAgU0FGRV9GSUxFX1BSSU5URihQQVRIX0tTTSAic21h
cnRfc2NhbiIsICIwIik7Cj4+ID4gPiA+IE5PVEUsIHRoaXMgZmFpbHMgb24gdGhlIHN5c3RlbXMg
d2l0aG91dCAvc3lzL2tlcm5lbC9tbS9rc20vc21hcnRfc2NhbjoKPgo+PiA+ID4gPiBtZW0uYzo0
NTg6IFRCUk9LOiBGYWlsZWQgdG8gb3BlbiBGSUxFICcvc3lzL2tlcm5lbC9tbS9rc20vc21hcnRf
c2NhbicKPj4gPiBmb3IKPj4gPiA+ID4gd3JpdGluZzogRUFDQ0VTICgxMykKPgo+PiA+ID4gPiBO
T1RFLCB3ZSBub3JtYWxseSBoYW5kbGUgdGhlIHNldHVwIGxpa2UgdGhpcyBpbiB0ZXN0IHNldHVw
IGZ1bmN0aW9uLgo+Cj4+ID4gPiA+IEJ1dCBuZXcgQVBJIGhhcyAuc2F2ZV9yZXN0b3JlIHdoaWNo
IGlzIG1vcmUgcm9idXN0IGZvciB0YXNrcyAgbGlrZQo+PiA+IHRoaXMuCj4+ID4gPiA+IEl0J3Mg
YWxyZWFkeSB1c2VkIGluIGtzbTAxLmMsIHlvdSBuZWVkIGp1c3QgdG8gYWRkIHRoaXMgbGluZToK
Pj4gPiA+ID4gICAgICAgICB7Ii9zeXMva2VybmVsL21tL2tzbS9zbWFydF9zY2FuIiwgIjAiLCBU
U1RfU1JfU0tJUH0sCj4KPgo+PiA+ID4gSSBndWVzcyB3ZSBuZWVkIHRvIHNldCAnVFNUX1NSX1NL
SVBfTUlTU0lORyB8IFRTVF9TUl9UQlJPS19STycKPj4gPiA+IGFzIHRoZSBsYXN0IGZpZWxkLiBC
ZWNhdXNlIFRTVF9TUl9TS0lQIHdpbGwgY29udGludWUgdGhlIHRlc3Qgd2l0aG91dAo+PiA+ID4g
d3JpdGluZyAnMCcgdG8gdGhlIHNtYXJ0X3NjYW4gZmlsZSwgdGhhdCdzIG5vdCBjb3JyZWN0IGlm
IHRoZSBmaWxlCj4+ID4gZXhpc3RzLgo+PiA+ID4gSXQgd2lsbAo+PiA+ID4gaWdub3JlIGEga2Vy
bmVsIGJ1ZyAoc21hcnRfc2NhbiBjYW4ndCBiZSB3cml0dGVuKSBieSB0aGF0IGNvbmZpZy4KPgo+
PiA+ID4gUGVyIHRoZSBEb2MgUGV0ciBwb2ludGVkIGJlbG93Ogo+PiA+ID4gICBUU1RfU1JfU0tJ
UF9NSVNTSU5HIOKAkyBDb250aW51ZSB3aXRob3V0IHNhdmluZyB0aGUgZmlsZSBpZiBpdCBkb2Vz
IG5vdAo+PiA+ID4gZXhpc3QKPj4gPiA+ICAgVFNUX1NSX1RCUk9LX1JPIOKAkyBFbmQgdGVzdCB3
aXRoIFRCUk9LIGlmIHRoZSBmaWxlIGlzIHJlYWQtb25seQo+PiA+ID4gICBUU1RfU1JfU0tJUF9S
TyDigJMgQ29udGludWUgd2l0aG91dCBzYXZpbmcgdGhlIGZpbGUgaWYgaXQgaXMgcmVhZC1vbmx5
Cj4+ID4gPiAgIFRTVF9TUl9TS0lQIOKAkyBFcXVpdmFsZW50IHRvICdUU1RfU1JfU0tJUF9NSVNT
SU5HIHwgVFNUX1NSX1NLSVBfUk8nCj4KPgo+Cj4+ID4gPiA+IChpbnN0ZWFkIG9mIGJvdGggU0FG
RV9GSUxFX1BSSU5URikKPgo+PiA+ID4gPiBTZWU6Cj4KPgo+PiA+IGh0dHBzOi8vZ2l0aHViLmNv
bS9saW51eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0LUFQSSMxMjctc2F2aW5nLS1yZXN0
b3JpbmctcHJvY3N5cy12YWx1ZXMKPgo+PiA+ID4gPiBJIHdvbmRlciBpZiBrc20wMS5jIGlzIHRo
ZSBvbmx5IGtzbSB0ZXN0IHdoaWNoIG5lZWRzIHRvIGRpc2FibGUgdGhpcy4KPgo+Cj4+ID4gPiBJ
IHRoaW5rIGFsbCBvZiB0aGUga3NtMCouYyB0ZXN0cyBzaG91bGQgZGlzYWJsZSBpdCBieSB0aGUg
Y29uZmlnLiBUaGUKPj4gPiA+IHNtYXJ0X3NjYW4KPj4gPiA+IHdpbGwgaW1wYWN0IGFsbCB0aGUg
dGVzdHMgd2l0aCBpbnZva2Uga2V5IGZ1bmN0aW9uIGNyZWF0ZV9zYW1lX21lbW9yeSgpLgo+Cj4+
ID4ga3NtMDUuYyBhbmQga3NtMDYuYyBkb2VzIG5vdCB1c2UgY3JlYXRlX3NhbWVfbWVtb3J5KCku
IE9yIGRpZCBJIG92ZXJsb29rCj4+ID4gc29tZXRoaW5nPwo+Cj4KPj4gR29vZCBjYXRjaCwgSSBs
b29rZWQgaW50byB0aGVzZSB0ZXN0cywgc2VlbXMgb25seSBrc20wNSBpcyBkZWJhdGFibGUKPj4g
Zm9yIGRpc2FibGluZyBzbWFydF9zY2FuLCBhcyBhIHNpbXBsZSByZWdyZXNzaW9uLCBpdCBzdWdn
ZXN0cyBkaXNhYmxpbmcKPj4ga3NtIGRhZW1vbiB0byBhdm9pZCBkaXN0dXJiIGFjY29yZGluZyB0
byBzb21lIHdvcmtsb2FkLgo+PiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0
L2x0cC9ibG9iL21hc3Rlci90ZXN0Y2FzZXMva2VybmVsL21lbS9rc20va3NtMDUuYyNMMzAKPgo+
PiBrc20wNiBpcyBkZWZpbml0ZWx5IG5lZWQgZGlzYWJsZSBzbWFydF9zY2FuLCBpdCB0ZXN0cyBL
U00gaW4gZGlmZmVyZW50Cj4+ICdydW4nIHN0YXRlIGZvciBtZXJnZV9hY2Nyb3Nfbm9kZXMuCj4K
PiBUaGFua3MgZm9yIGhhdmluZyBhIGxvb2suCj4KPj4gVG8gYmUgb24gdGhlIHNhZmUgc2lkZSwg
SSB3b3VsZCBzdWdnZXN0IGFwcGx5aW5nIHRoZSBwYXRjaCB0byBhbGwga3NtKgo+PiB0ZXN0cywK
Pj4gYW5kIHdyaXRlIGEgbmV3IHNpbmdsZSBmb3Igc21hcnRfc2NhbiBpZiBuZWVkZWQuCj4KPiBB
Z3JlZS4gSSB2b3RlIGZvciBuZXcgc2luZ2xlIGZvciBzbWFydF9zY2FuIHJlbGF0ZWQgdGVzdC4K
PgoKSSdsbCBhZGQgYSBuZXcgdGVzdC4KCj4gS2luZCByZWdhcmRzLAo+IFBldHIKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
