Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50AF0C4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 20:08:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 818533CF5FF
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 21:08:04 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 815F13CD933
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 21:07:53 +0100 (CET)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 85516201DA3
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 21:07:52 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id 4DCE85C0067;
 Fri,  1 Dec 2023 15:07:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
 by compute2.internal (MEProxy); Fri, 01 Dec 2023 15:07:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=devkernel.io; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
 1701461271; x=1701547671; bh=9XhUjlfuIkMoL0ZK2dbxU2EbPZYrR3D6b5V
 4nJScxA0=; b=DbgqfbasQCH4jGJilFGg4FnNZCcKGNexB9nay9zWq+xbyA0Th0I
 R6hGJSXlK1RCKSTvwP62S1yZdY608P0fZUNRXuQAuATiddmwsIdYQNaMGZ9cg4Sm
 5hEQ0fEuPBYAe4W1MzIX+9MmTSBO+1d0RHxXCYW4KKQUkLx2Q1WKeU/3gBkzwvfx
 Z8O4nyf4GtjB6sfcSt9vR1Ab/vBBYYmwRQYlIoLHoXH0tRRUnV443J9giqW1GEc+
 sxupo6CMQ8xcG3G1dUtXakh+L3Lc6vzGt80bWcJr/SQOYgxF5lSLTj+/yUJfFUVu
 lGpmFGJS+e+2h4LtO5I6I65X1H2AiWqikLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:sender:subject:subject:to:to:x-me-proxy
 :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
 1701461271; x=1701547671; bh=9XhUjlfuIkMoL0ZK2dbxU2EbPZYrR3D6b5V
 4nJScxA0=; b=yaDGWL2zVejOsKhQSQcyXUU9DEk+Sw4MWBPTxgqMHPsa8oyg88Z
 7pz/CE+QwCwS9B8WumDbbEMjkhdM2Z5S/RMrztbGy4EwMO3X5poK0KAUWXsyhiMB
 qREzYTjlHHsIg6XQLPZIN7F62UCXyEHYUhpbuGzF6b6Y4i/UG7P0g8mo9LeIJX1S
 gSghPA3qJWXpgPcIeoIeKeLoF1nIkjulPC2U4jhMx9lqke2dJcgFbIaw48ySXuqO
 2+4D9UMuy969MFIJNYKaSL08UtBgOeS6ItJ5XAr8XWnBrMsa/MpH6UyqlG8kc5+0
 szZg1M8EwiIwu5zgn3BDLphEOO/2ci+8jPA==
X-ME-Sender: <xms:Fz1qZf41w1ZG7i3bciI0gLyw5RYljM02Rt_nOQhVtwm7b-hj4g4JlQ>
 <xme:Fz1qZU5NvqVK9-PFipEFPycztvD4jb7mSxhsMFC8I79RzpngBCdC0kCVE-puYRKWz
 1gF0arWGA-l3Uo0fIU>
X-ME-Received: <xmr:Fz1qZWdWw2rLZLg-47DhVIZrR4bze6j-8T_w7i1dvUiFFrKzLreWKjmJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudeffecutefuodetggdotefrod
 ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
 necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
 enucfjughrpehffgfhvfevufffjgfkgggtgfesthhqredttderjeenucfhrhhomhepufht
 vghfrghnucftohgvshgthhcuoehshhhrseguvghvkhgvrhhnvghlrdhioheqnecuggftrf
 grthhtvghrnhepfedtjefhheeileevhfehheeutdekleduueejteffvddtfedtfffhleek
 geekgfdunecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhithhhuhgsrdgtohhmne
 cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhhrhes
 uggvvhhkvghrnhgvlhdrihho
X-ME-Proxy: <xmx:Fz1qZQLAozJuTiZfgmlIoZLpqjPQuVwyLzEImNUkOPwIODsxH0WmdQ>
 <xmx:Fz1qZTJRVqiixIoO_s--nyx3xM4DB3QEfWKXJg0slWsZ4DdcJ4mYOQ>
 <xmx:Fz1qZZwasvDLJlbGjKo9SeqyDM2XAY0J6G3BrfoRLi-NtDV6a_JoOg>
 <xmx:Fz1qZZjRYCcTD2-mrTcnF-VVVUd6HLrnU3cQCg6VYHUj4XVzaAQnvQ>
Feedback-ID: i84614614:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:07:49 -0500 (EST)
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
 <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
User-agent: mu4e 1.10.3; emacs 29.1
From: Stefan Roesch <shr@devkernel.io>
To: Li Wang <liwang@redhat.com>
Date: Fri, 01 Dec 2023 12:06:38 -0800
In-reply-to: <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
Message-ID: <874jh1660d.fsf@devkernel.io>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
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

CkxpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPiB3cml0ZXM6Cgo+IEhpIFN0ZWZhbiwgUGV0ciwK
Pgo+IE9uIFR1ZSwgTm92IDI4LCAyMDIzIGF0IDM6NDbigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxA
c3VzZS5jej4gd3JvdGU6Cj4KPiAgSGkgU3RlZmFuLAo+Cj4gID4gVGhpcyBkaXNhYmxlcyB0aGUg
InNtYXJ0IHNjYW4iIEtTTSBmZWF0dXJlIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZSB2b2xhdGlsZQo+
ICA+IGNvdW50IHJlbWFpbnMgYXQgMC4KPgo+ICA+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbiBSb2Vz
Y2ggPGRldmtlcm5lbC5pbz4KPiAgbml0OiB5b3UgZm9yZ290ICdzaHJAJwo+ICBTaWduZWQtb2Zm
LWJ5OiBTdGVmYW4gUm9lc2NoIDxzaHJAZGV2a2VybmVsLmlvPgo+Cj4gID4gUmVwb3J0ZWQtYnk6
IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+Cj4gID4gQ2xvc2VzOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1sa3AvMjAyMzExMTYxMTMyLjEzZDhjZTVhLW9saXZl
ci5zYW5nQGludGVsLmNvbQo+ICA+IC0tLQo+ICA+ICB0ZXN0Y2FzZXMva2VybmVsL21lbS9saWIv
bWVtLmMgfCA0ICsrKysKPiAgPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQo+Cj4g
ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYyBiL3Rlc3RjYXNl
cy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ICA+IGluZGV4IGZiZmVlZjAyNi4uZWYyNzRhM2FjIDEw
MDY0NAo+ICA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ICA+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ICA+IEBAIC00NTQsNiArNDU0LDkgQEAg
dm9pZCBjcmVhdGVfc2FtZV9tZW1vcnkoaW50IHNpemUsIGludCBudW0sIGludCB1bml0KQo+ICA+
ICAgICAgICAgICAgICB7J2EnLCBzaXplKk1CfSwgeydhJywgc2l6ZSpNQn0sIHsnZCcsIHNpemUq
TUJ9LCB7J2QnLCBzaXplKk1CfSwKPiAgPiAgICAgICB9Owo+Cj4gID4gKyAgLyogRGlzYWJsZSBz
bWFydCBzY2FuIGZvciBjb3JyZWN0IHZvbGF0aWxlIGNvdW50cy4gKi8KPiAgPiArICBTQUZFX0ZJ
TEVfUFJJTlRGKFBBVEhfS1NNICJzbWFydF9zY2FuIiwgIjAiKTsKPiAgTk9URSwgdGhpcyBmYWls
cyBvbiB0aGUgc3lzdGVtcyB3aXRob3V0IC9zeXMva2VybmVsL21tL2tzbS9zbWFydF9zY2FuOgo+
Cj4gIG1lbS5jOjQ1ODogVEJST0s6IEZhaWxlZCB0byBvcGVuIEZJTEUgJy9zeXMva2VybmVsL21t
L2tzbS9zbWFydF9zY2FuJyBmb3Igd3JpdGluZzogRUFDQ0VTICgxMykKPgo+ICBOT1RFLCB3ZSBu
b3JtYWxseSBoYW5kbGUgdGhlIHNldHVwIGxpa2UgdGhpcyBpbiB0ZXN0IHNldHVwIGZ1bmN0aW9u
Lgo+Cj4gIEJ1dCBuZXcgQVBJIGhhcyAuc2F2ZV9yZXN0b3JlIHdoaWNoIGlzIG1vcmUgcm9idXN0
IGZvciB0YXNrcyAgbGlrZSB0aGlzLgo+ICBJdCdzIGFscmVhZHkgdXNlZCBpbiBrc20wMS5jLCB5
b3UgbmVlZCBqdXN0IHRvIGFkZCB0aGlzIGxpbmU6Cj4gICAgICAgICAgeyIvc3lzL2tlcm5lbC9t
bS9rc20vc21hcnRfc2NhbiIsICIwIiwgVFNUX1NSX1NLSVB9LAo+Cj4gSSBndWVzcyB3ZSBuZWVk
IHRvIHNldCAnVFNUX1NSX1NLSVBfTUlTU0lORyB8IFRTVF9TUl9UQlJPS19STycKPiBhcyB0aGUg
bGFzdCBmaWVsZC4gQmVjYXVzZSBUU1RfU1JfU0tJUCB3aWxsIGNvbnRpbnVlIHRoZSB0ZXN0IHdp
dGhvdXQKPiB3cml0aW5nICcwJyB0byB0aGUgc21hcnRfc2NhbiBmaWxlLCB0aGF0J3Mgbm90IGNv
cnJlY3QgaWYgdGhlIGZpbGUgZXhpc3RzLiBJdCB3aWxsCj4gaWdub3JlIGEga2VybmVsIGJ1ZyAo
c21hcnRfc2NhbiBjYW4ndCBiZSB3cml0dGVuKSBieSB0aGF0IGNvbmZpZy4KPgo+IFBlciB0aGUg
RG9jIFBldHIgcG9pbnRlZCBiZWxvdzoKPiAgIFRTVF9TUl9TS0lQX01JU1NJTkcg4oCTIENvbnRp
bnVlIHdpdGhvdXQgc2F2aW5nIHRoZSBmaWxlIGlmIGl0IGRvZXMgbm90IGV4aXN0Cj4gICBUU1Rf
U1JfVEJST0tfUk8g4oCTIEVuZCB0ZXN0IHdpdGggVEJST0sgaWYgdGhlIGZpbGUgaXMgcmVhZC1v
bmx5Cj4gICBUU1RfU1JfU0tJUF9STyDigJMgQ29udGludWUgd2l0aG91dCBzYXZpbmcgdGhlIGZp
bGUgaWYgaXQgaXMgcmVhZC1vbmx5Cj4gICBUU1RfU1JfU0tJUCDigJMgRXF1aXZhbGVudCB0byAn
VFNUX1NSX1NLSVBfTUlTU0lORyB8IFRTVF9TUl9TS0lQX1JPJwo+Cj4gIChpbnN0ZWFkIG9mIGJv
dGggU0FGRV9GSUxFX1BSSU5URikKPgo+ICBTZWU6Cj4gIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51
eC10ZXN0LXByb2plY3QvbHRwL3dpa2kvQy1UZXN0LUFQSSMxMjctc2F2aW5nLS1yZXN0b3Jpbmct
cHJvY3N5cy12YWx1ZXMKPgo+ICBJIHdvbmRlciBpZiBrc20wMS5jIGlzIHRoZSBvbmx5IGtzbSB0
ZXN0IHdoaWNoIG5lZWRzIHRvIGRpc2FibGUgdGhpcy4KPgo+IEkgdGhpbmsgYWxsIG9mIHRoZSBr
c20wKi5jIHRlc3RzIHNob3VsZCBkaXNhYmxlIGl0IGJ5IHRoZSBjb25maWcuIFRoZSBzbWFydF9z
Y2FuCj4gd2lsbCBpbXBhY3QgYWxsIHRoZSB0ZXN0cyB3aXRoIGludm9rZSBrZXkgZnVuY3Rpb24g
Y3JlYXRlX3NhbWVfbWVtb3J5KCkuCj4KPgo+Cj4gIGFsc28gbml0OiB0aGVyZSBpcyBhIHdyb25n
IGluZGVudCAoc3BhY2VzIGluc3RlYWQgb2YgdGFicyksIHBsZWFzZSBiZSBjb25zaXN0ZW50Cj4g
IHdpdGggdGhlIGZpbGUgY29udGVudC4KPgo+ICBOT1RFOiB3aGlsZSB0aGlzIGZpeGVzIHByb2Js
ZW0gb24gNi43LjAtcmMxLTIuZzg2ZTQ2YzItZGVmYXVsdCAob3BlblNVU0UpLAo+ICBpdCBkb2Vz
IG5vdCBmaXhlcyBvdGhlciBwcm9ibGVtIG9uIDYuNS4xMCBvbiBEZWJpYW4gKDE2IGVycm9ycyBs
aWtlIHRoZXNlIGJlbG93KToKPgo+ICBtZW0uYzoyNTI6IFRGQUlMOiBwYWdlc19zaGFyZWQgaXMg
bm90IDIgYnV0IDUwMzguCj4gIG1lbS5jOjI1MjogVEZBSUw6IHBhZ2VzX3NoYXJpbmcgaXMgbm90
IDk4MzAyIGJ1dCA1OTM2MjkuCj4gIG1lbS5jOjI1MjogVEZBSUw6IHBhZ2VzX3ZvbGF0aWxlIGlz
IG5vdCAwIGJ1dCAzOTEuCj4gIG1lbS5jOjI1MjogVEZBSUw6IHBhZ2VzX3Vuc2hhcmVkIGlzIG5v
dCAwIGJ1dCAxNDkxNTcuCj4KPiAgSSBoYXZlIG5vIGlkZWEgaWYgdGhpcyBpcyBhIHJlYWwgYnVn
IHdoaWNoIG5lZWRzIHRvIGJlIGZpeGVkIG9yIHRlc3QgZmFsc2UKPiAgcG9zaXRpdmUgdG8gYmUg
Zml4ZWQsIG9yIHdoZXRoZXIgdGhlIHByb2JsZW0gaGFzIGFscmVhZHkgYmVlbiBmaXhlZCBpbiBu
ZXdlcgo+ICBrZXJuZWxzLgo+Cj4gSXQgaXMgbW9yZSBsaWtlIGEgcmVhbCBidWcsIHRoZSBEZWJh
aW4ga2VybmVsLTYuNS4xMCBkb2VzIG5vdCBjb250YWluCj4gdGhpcyBzbWFydF9zY2FuIGZlYXR1
cmUuIE9yIHlvdSBtYXkgdHJ5IHRvIGJ1aWxkIHRoZSBsYXRlc3Qga2VybmVsCj4gb24geW91ciBw
bGF0Zm9ybSB0byBzZWUgaWYgaXQgY2FuIGJlIHJlcHJvZHVjZWQgYXMgd2VsbC4KPgo+Cj4KPiAg
PiArCj4gID4gICAgICAgcHMgPSBzeXNjb25mKF9TQ19QQUdFX1NJWkUpOwo+ICA+ICAgICAgIHBh
Z2VzID0gTUIgLyBwczsKPgo+ICA+IEBAIC01MjYsNiArNTI5LDcgQEAgdm9pZCBjcmVhdGVfc2Ft
ZV9tZW1vcnkoaW50IHNpemUsIGludCBudW0sIGludCB1bml0KQo+Cj4gID4gICAgICAgdHN0X3Jl
cyhUSU5GTywgInN0b3AgS1NNLiIpOwo+ICA+ICAgICAgIFNBRkVfRklMRV9QUklOVEYoUEFUSF9L
U00gInJ1biIsICIwIik7Cj4gID4gKyAgU0FGRV9GSUxFX1BSSU5URihQQVRIX0tTTSAic21hcnRf
c2NhbiIsICIxIik7Cj4gIG5pdDogQWdhaW4sIHdyb25nIGluZGVudC4gWW91IGNvdWxkIGhhdmUg
c2VlbiBpdCBhbHNvIGluIHRoZSBnZW5lcmF0ZWQgcGF0Y2guCj4KPiAgS2luZCByZWdhcmRzLAo+
ICBQZXRyCj4KPiAgPiAgICAgICBmaW5hbF9ncm91cF9jaGVjaygwLCAwLCAwLCAwLCAwLCAwLCBz
aXplICogcGFnZXMgKiBudW0pOwo+Cj4gID4gICAgICAgd2hpbGUgKHdhaXRwaWQoLTEsICZzdGF0
dXMsIDApID4gMCkKPgo+ICA+IGJhc2UtY29tbWl0OiA4Yzg5ZWYzZDQ1MTA4N2VkNmUxODc1MGJk
NWVlZGQxMGU1YWIzZDJlCj4KPiBPbmUgbW9yZSBjb21tZW50IG5vdCByZWxhdGVkIHRvIHRoaXMg
cGF0Y2g6Cj4KPiBAU3RlZmFuLCBkbyB5b3UgaGF2ZSBhIHRlc3QgKG9yIHBsYW4gdG8pIHZlcmlm
eSB0aGUgJ3NtYXJ0X3NjYW4nIGZldHVyZSB3b3Jrcz8KPiBBcyB3ZSBkbyBkaXNhYmxlcyBpdCBm
b3IgYWxsIGtzbSogdGVzdHMgaW4gTFRQLCBzbywgaXQgd291bGQgYmUgZ3JlYXQgdG8gaGF2ZSBv
bmUKPiBmb3IgdGVzdGluZyBpbiBlbmFibGUgbW9kZS4gV2hhdCBkbyB5b3UgdGhpbms/Cj4KCklu
IHRoZSBuZXh0IHZlcnNpb24gb2YgdGhlIHBhdGNoIEknbGwgYWRkIGEgbmV3IHRlc3QgY2FzZSBz
cGVjaWZpY2FsbHkKdG8gdGVzdCBzbWFydCBzY2FuLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
