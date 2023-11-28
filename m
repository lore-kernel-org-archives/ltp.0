Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74730C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 10:44:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 717D53CD994
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 11:44:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D73E63CD98B
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:43:55 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B945C1B6106B
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 11:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701168180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MGDngZLKlDsQjQrSJHak5OGWCZyvqh7MuixsAkos8I=;
 b=Wsyuu1v+EJxal86t5vyeu3phvTvzs/6mKUNRIcQxKy8HJEY1fZpA8SIPi81NTEhqft+zl0
 zuNclIHj6J0zXSRcuzg5Uk1GFteFF+v1TBnSbMDWGvvxmGljJ7ETluw8xPQwNhT89jP3Fn
 M8SbnE0nuo/jBiSBikKG/nqD5cU7TVY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-qWL4OoygPY-e3P3UDxdOaw-1; Tue, 28 Nov 2023 05:35:58 -0500
X-MC-Unique: qWL4OoygPY-e3P3UDxdOaw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5079630993dso5428622e87.1
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 02:35:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701167756; x=1701772556;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0MGDngZLKlDsQjQrSJHak5OGWCZyvqh7MuixsAkos8I=;
 b=c2XISFgEV8oOICNAMllWAUXFHghaChfbkhp4tddkVabdRvWcLre2tV2O5cjIXTJVB5
 5zJYvHrfaMV5sHtgIjEEs2yVHJHmI6A9Lmfx2swMUzjnOsjP1EaoRSw5rqMTqEpXzEgC
 pi+oZjzWFtaFv2RfJGyfPoa2KLmA72Wo/gqYaDZ5QbeOIMKwkATZ/LFN80l9zAydpdVE
 Fl1cMMS33cWXbO8KFRyZ9BXBIS3PAv/vtoJL+V240aNvAgYn1J6j9xvpXWyvKcwQhPv0
 f+C6cfBzY6qzykeI34RHA8Qx5FYjWoNl2FHEGIY5/XzFNEdGGSgYAa0iOweAnR0MAQpu
 MAkQ==
X-Gm-Message-State: AOJu0YzP/xv2mLomROl2oGTS5IccRwtlV4cwIM+C+nDdmnnZAC0SVEpr
 BxhWamuwp37L5X5CgO+Knar2vK9PvH582BoKy80cowwNd8SdM0VYAQbB7MSoZDLfQ1AplpeTCmI
 I3AVXh0ve2SRvUtXyJ1p3F7vm3Sw=
X-Received: by 2002:a05:6512:2389:b0:506:899d:1994 with SMTP id
 c9-20020a056512238900b00506899d1994mr9806311lfv.52.1701167756430; 
 Tue, 28 Nov 2023 02:35:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEocTDZwjJMWN3mQ9/kvyJs6aEp7nBueYV3BRD/eViWTB22hQLexDkGzjhI9LoYLJRr1/h0wWeR2NHOnJ/UAdk=
X-Received: by 2002:a05:6512:2389:b0:506:899d:1994 with SMTP id
 c9-20020a056512238900b00506899d1994mr9806299lfv.52.1701167756059; Tue, 28 Nov
 2023 02:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20231127174517.2369593-1-shr@devkernel.io>
 <20231128074626.GA298624@pevik>
In-Reply-To: <20231128074626.GA298624@pevik>
From: Li Wang <liwang@redhat.com>
Date: Tue, 28 Nov 2023 18:35:43 +0800
Message-ID: <CAEemH2dQDVg+nLD4cTjgReoUaZ+FU7TFEsg=Vc8h6sdV-VqLpg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
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
Cc: david@redhat.com, Stefan Roesch <shr@devkernel.io>, linux-mm@kvack.org,
 oliver.sang@intel.com, kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgU3RlZmFuLCBQZXRyLAoKT24gVHVlLCBOb3YgMjgsIDIwMjMgYXQgMzo0NuKAr1BNIFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgU3RlZmFuLAo+Cj4gPiBUaGlzIGRp
c2FibGVzIHRoZSAic21hcnQgc2NhbiIgS1NNIGZlYXR1cmUgdG8gbWFrZSBzdXJlIHRoYXQgdGhl
IHZvbGF0aWxlCj4gPiBjb3VudCByZW1haW5zIGF0IDAuCj4KPiA+IFNpZ25lZC1vZmYtYnk6IFN0
ZWZhbiBSb2VzY2ggPGRldmtlcm5lbC5pbz4KPiBuaXQ6IHlvdSBmb3Jnb3QgJ3NockAnCj4gU2ln
bmVkLW9mZi1ieTogU3RlZmFuIFJvZXNjaCA8c2hyQGRldmtlcm5lbC5pbz4KPgo+ID4gUmVwb3J0
ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+Cj4gPiBDbG9z
ZXM6Cj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvb2UtbGtwLzIwMjMxMTE2MTEzMi4xM2Q4Y2U1
YS1vbGl2ZXIuc2FuZ0BpbnRlbC5jb20KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9rZXJuZWwvbWVt
L2xpYi9tZW0uYyB8IDQgKysrKwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykK
Pgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+IGIvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jCj4gPiBpbmRleCBmYmZlZWYwMjYuLmVmMjc0YTNh
YyAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2xpYi9tZW0uYwo+ID4gKysr
IGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vbGliL21lbS5jCj4gPiBAQCAtNDU0LDYgKzQ1NCw5IEBA
IHZvaWQgY3JlYXRlX3NhbWVfbWVtb3J5KGludCBzaXplLCBpbnQgbnVtLCBpbnQgdW5pdCkKPiA+
ICAgICAgICAgICAgICB7J2EnLCBzaXplKk1CfSwgeydhJywgc2l6ZSpNQn0sIHsnZCcsIHNpemUq
TUJ9LCB7J2QnLAo+IHNpemUqTUJ9LAo+ID4gICAgICAgfTsKPgo+ID4gKyAgLyogRGlzYWJsZSBz
bWFydCBzY2FuIGZvciBjb3JyZWN0IHZvbGF0aWxlIGNvdW50cy4gKi8KPiA+ICsgIFNBRkVfRklM
RV9QUklOVEYoUEFUSF9LU00gInNtYXJ0X3NjYW4iLCAiMCIpOwo+IE5PVEUsIHRoaXMgZmFpbHMg
b24gdGhlIHN5c3RlbXMgd2l0aG91dCAvc3lzL2tlcm5lbC9tbS9rc20vc21hcnRfc2NhbjoKPgo+
IG1lbS5jOjQ1ODogVEJST0s6IEZhaWxlZCB0byBvcGVuIEZJTEUgJy9zeXMva2VybmVsL21tL2tz
bS9zbWFydF9zY2FuJyBmb3IKPiB3cml0aW5nOiBFQUNDRVMgKDEzKQo+Cj4gTk9URSwgd2Ugbm9y
bWFsbHkgaGFuZGxlIHRoZSBzZXR1cCBsaWtlIHRoaXMgaW4gdGVzdCBzZXR1cCBmdW5jdGlvbi4K
Pgo+IEJ1dCBuZXcgQVBJIGhhcyAuc2F2ZV9yZXN0b3JlIHdoaWNoIGlzIG1vcmUgcm9idXN0IGZv
ciB0YXNrcyAgbGlrZSB0aGlzLgo+IEl0J3MgYWxyZWFkeSB1c2VkIGluIGtzbTAxLmMsIHlvdSBu
ZWVkIGp1c3QgdG8gYWRkIHRoaXMgbGluZToKPiAgICAgICAgIHsiL3N5cy9rZXJuZWwvbW0va3Nt
L3NtYXJ0X3NjYW4iLCAiMCIsIFRTVF9TUl9TS0lQfSwKPgoKSSBndWVzcyB3ZSBuZWVkIHRvIHNl
dCAnVFNUX1NSX1NLSVBfTUlTU0lORyB8IFRTVF9TUl9UQlJPS19STycKYXMgdGhlIGxhc3QgZmll
bGQuIEJlY2F1c2UgVFNUX1NSX1NLSVAgd2lsbCBjb250aW51ZSB0aGUgdGVzdCB3aXRob3V0Cndy
aXRpbmcgJzAnIHRvIHRoZSBzbWFydF9zY2FuIGZpbGUsIHRoYXQncyBub3QgY29ycmVjdCBpZiB0
aGUgZmlsZSBleGlzdHMuCkl0IHdpbGwKaWdub3JlIGEga2VybmVsIGJ1ZyAoc21hcnRfc2NhbiBj
YW4ndCBiZSB3cml0dGVuKSBieSB0aGF0IGNvbmZpZy4KClBlciB0aGUgRG9jIFBldHIgcG9pbnRl
ZCBiZWxvdzoKICBUU1RfU1JfU0tJUF9NSVNTSU5HIOKAkyBDb250aW51ZSB3aXRob3V0IHNhdmlu
ZyB0aGUgZmlsZSBpZiBpdCBkb2VzIG5vdApleGlzdAogIFRTVF9TUl9UQlJPS19STyDigJMgRW5k
IHRlc3Qgd2l0aCBUQlJPSyBpZiB0aGUgZmlsZSBpcyByZWFkLW9ubHkKICBUU1RfU1JfU0tJUF9S
TyDigJMgQ29udGludWUgd2l0aG91dCBzYXZpbmcgdGhlIGZpbGUgaWYgaXQgaXMgcmVhZC1vbmx5
CiAgVFNUX1NSX1NLSVAg4oCTIEVxdWl2YWxlbnQgdG8gJ1RTVF9TUl9TS0lQX01JU1NJTkcgfCBU
U1RfU1JfU0tJUF9STycKCgoKPiAoaW5zdGVhZCBvZiBib3RoIFNBRkVfRklMRV9QUklOVEYpCj4K
PiBTZWU6Cj4KPiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC93aWtp
L0MtVGVzdC1BUEkjMTI3LXNhdmluZy0tcmVzdG9yaW5nLXByb2NzeXMtdmFsdWVzCj4KPiBJIHdv
bmRlciBpZiBrc20wMS5jIGlzIHRoZSBvbmx5IGtzbSB0ZXN0IHdoaWNoIG5lZWRzIHRvIGRpc2Fi
bGUgdGhpcy4KPgoKSSB0aGluayBhbGwgb2YgdGhlIGtzbTAqLmMgdGVzdHMgc2hvdWxkIGRpc2Fi
bGUgaXQgYnkgdGhlIGNvbmZpZy4gVGhlCnNtYXJ0X3NjYW4Kd2lsbCBpbXBhY3QgYWxsIHRoZSB0
ZXN0cyB3aXRoIGludm9rZSBrZXkgZnVuY3Rpb24gY3JlYXRlX3NhbWVfbWVtb3J5KCkuCgoKCj4K
PiBhbHNvIG5pdDogdGhlcmUgaXMgYSB3cm9uZyBpbmRlbnQgKHNwYWNlcyBpbnN0ZWFkIG9mIHRh
YnMpLCBwbGVhc2UgYmUKPiBjb25zaXN0ZW50Cj4gd2l0aCB0aGUgZmlsZSBjb250ZW50Lgo+Cj4g
Tk9URTogd2hpbGUgdGhpcyBmaXhlcyBwcm9ibGVtIG9uIDYuNy4wLXJjMS0yLmc4NmU0NmMyLWRl
ZmF1bHQgKG9wZW5TVVNFKSwKPiBpdCBkb2VzIG5vdCBmaXhlcyBvdGhlciBwcm9ibGVtIG9uIDYu
NS4xMCBvbiBEZWJpYW4gKDE2IGVycm9ycyBsaWtlIHRoZXNlCj4gYmVsb3cpOgo+Cj4gbWVtLmM6
MjUyOiBURkFJTDogcGFnZXNfc2hhcmVkIGlzIG5vdCAyIGJ1dCA1MDM4Lgo+IG1lbS5jOjI1Mjog
VEZBSUw6IHBhZ2VzX3NoYXJpbmcgaXMgbm90IDk4MzAyIGJ1dCA1OTM2MjkuCj4gbWVtLmM6MjUy
OiBURkFJTDogcGFnZXNfdm9sYXRpbGUgaXMgbm90IDAgYnV0IDM5MS4KPiBtZW0uYzoyNTI6IFRG
QUlMOiBwYWdlc191bnNoYXJlZCBpcyBub3QgMCBidXQgMTQ5MTU3Lgo+Cj4gSSBoYXZlIG5vIGlk
ZWEgaWYgdGhpcyBpcyBhIHJlYWwgYnVnIHdoaWNoIG5lZWRzIHRvIGJlIGZpeGVkIG9yIHRlc3Qg
ZmFsc2UKPiBwb3NpdGl2ZSB0byBiZSBmaXhlZCwgb3Igd2hldGhlciB0aGUgcHJvYmxlbSBoYXMg
YWxyZWFkeSBiZWVuIGZpeGVkIGluCj4gbmV3ZXIKPiBrZXJuZWxzLgo+CgpJdCBpcyBtb3JlIGxp
a2UgYSByZWFsIGJ1ZywgdGhlIERlYmFpbiBrZXJuZWwtNi41LjEwIGRvZXMgbm90IGNvbnRhaW4K
dGhpcyBzbWFydF9zY2FuIGZlYXR1cmUuIE9yIHlvdSBtYXkgdHJ5IHRvIGJ1aWxkIHRoZSBsYXRl
c3Qga2VybmVsCm9uIHlvdXIgcGxhdGZvcm0gdG8gc2VlIGlmIGl0IGNhbiBiZSByZXByb2R1Y2Vk
IGFzIHdlbGwuCgoKCj4KPiA+ICsKPiA+ICAgICAgIHBzID0gc3lzY29uZihfU0NfUEFHRV9TSVpF
KTsKPiA+ICAgICAgIHBhZ2VzID0gTUIgLyBwczsKPgo+ID4gQEAgLTUyNiw2ICs1MjksNyBAQCB2
b2lkIGNyZWF0ZV9zYW1lX21lbW9yeShpbnQgc2l6ZSwgaW50IG51bSwgaW50IHVuaXQpCj4KPiA+
ICAgICAgIHRzdF9yZXMoVElORk8sICJzdG9wIEtTTS4iKTsKPiA+ICAgICAgIFNBRkVfRklMRV9Q
UklOVEYoUEFUSF9LU00gInJ1biIsICIwIik7Cj4gPiArICBTQUZFX0ZJTEVfUFJJTlRGKFBBVEhf
S1NNICJzbWFydF9zY2FuIiwgIjEiKTsKPiBuaXQ6IEFnYWluLCB3cm9uZyBpbmRlbnQuIFlvdSBj
b3VsZCBoYXZlIHNlZW4gaXQgYWxzbyBpbiB0aGUgZ2VuZXJhdGVkCj4gcGF0Y2guCj4KPiBLaW5k
IHJlZ2FyZHMsCj4gUGV0cgo+Cj4gPiAgICAgICBmaW5hbF9ncm91cF9jaGVjaygwLCAwLCAwLCAw
LCAwLCAwLCBzaXplICogcGFnZXMgKiBudW0pOwo+Cj4gPiAgICAgICB3aGlsZSAod2FpdHBpZCgt
MSwgJnN0YXR1cywgMCkgPiAwKQo+Cj4gPiBiYXNlLWNvbW1pdDogOGM4OWVmM2Q0NTEwODdlZDZl
MTg3NTBiZDVlZWRkMTBlNWFiM2QyZQo+Cj4KCk9uZSBtb3JlIGNvbW1lbnQgbm90IHJlbGF0ZWQg
dG8gdGhpcyBwYXRjaDoKCkBTdGVmYW4sIGRvIHlvdSBoYXZlIGEgdGVzdCAob3IgcGxhbiB0bykg
dmVyaWZ5IHRoZSAnc21hcnRfc2NhbicgZmV0dXJlCndvcmtzPwpBcyB3ZSBkbyBkaXNhYmxlcyBp
dCBmb3IgYWxsIGtzbSogdGVzdHMgaW4gTFRQLCBzbywgaXQgd291bGQgYmUgZ3JlYXQgdG8KaGF2
ZSBvbmUKZm9yIHRlc3RpbmcgaW4gZW5hYmxlIG1vZGUuIFdoYXQgZG8geW91IHRoaW5rPwoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
