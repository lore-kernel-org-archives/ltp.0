Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19C9CCD6E5D
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 03:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780456083; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=aTd2QKs2czxiNn1wK3ZXhgAYTFYP/nedHKulvTn8dAk=;
 b=P27FGqhJF4fcSB+E5SE4LrHdd0XX2jC3Fc1+RzqAab68Md5GjKfSjy+sT/B9lpLRcdfsB
 BtOaC93XqoLGbHO7CD8WZ/3AieRFsb3uXoZBo3eg0GiaycnIikUxx2Ac328cOuA7eYRf1Qm
 5QLf7smPSNynogEnLG24ym4V8e7VbOA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F36E3E7226
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 05:08:03 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A9A43E61AE
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 05:07:42 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AC5DB200221
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 05:07:36 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49050ff7cbdso112719895e9.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780456056; x=1781060856; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ja4G6whZRQBOptU5wO6+Cp3X1o/HlqUVvoKQUV93mPM=;
 b=dsA/h1GBKI1kag+ZqReNVJHMG5kBcbiyeGzvbIt77xcKiedAhqokndvSLJmcIISWc3
 /kGXAOyYzDaTol0kOuv5Kh6nKZy5m8gqCSp1Oe+hwDrpubo0m+LGf1UMnnrY1ipCbgX4
 UtUrxOOcT+BrjcgrUCL3vttDK7ZYu2PqMekV4pjBk8q8BBNr2jWg70gk3vSH7LBlsuxw
 T2+JiIVVf9wcNuRkQU0jC7r9RU5Eb8LwUNs48V5ZoQScKuPCMp4Gpb2RvM3Pklgc/x8b
 HwWEGTZ7vY5+mA875FWHevy30TkrLZxS76yyKjUFzq+TlAIm80M1G/wGFdeGBp48hLJb
 H9CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780456056; x=1781060856;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ja4G6whZRQBOptU5wO6+Cp3X1o/HlqUVvoKQUV93mPM=;
 b=Ws0fcrW9pPhCmXGDaO1S7XTuLIByxjxdfc9LHHKubur7tlLPR/s91Z7jc+w7ki1MqQ
 w6hxi3N8WDdgdCtoO2UF7RHWCbBRBFB6OHOTdmOi3W44r/Wv/63KjuoyTtKJ3YikmlXD
 96lL+p+huvSkyB/8fGRRS8E0yL/9Y4mkY9UlvNeQHa2xDAjbDEnbAQFxqY5RHN8h2l88
 v0qPzwyM/DUIH36fMPXrJsTQ6xiEv/9z8hlF4cbszZ8ZDdxIcC2ZYtEBvwy2q5609ibm
 8J9LiPyepBkYF+L/d36XR8goAXW2JspU3k4BJ85Cqj5JpKXp2NWw0NCo11wYQ1MDua8W
 E5GA==
X-Gm-Message-State: AOJu0YweKnzAH2TeRkwhiCEgmpMfl93FAKhqXVk+clyNvK8/8K7wTVTX
 ovbyNVbtAYQAGBQig799VHnpCIGMw2t3RIaEaxllwWuwa7XVwf/Ke/nzhky2YISu8w==
X-Gm-Gg: Acq92OFFFel3DjEZ2ElK/gw3tXvGXydGZ7LzbT0tNFfHOvR3O7E2PeVtvhTT56ywnxz
 iYOce9F+JxHrbr0BRb49S+eLhivVDu0AVl9ywK6GxDK1EVhRf4jYQvDDpucbBjNx//DQ5thVW2w
 vX9eAyRbaFcSpAM6zpJ2X3rvwYx0W1KAr+hRyRlMTLvxbdJIiVZUZ9ZxAZHXuStBiX7ywOhzeEI
 UJRrxbQTnIjjrwhstqMAMP9Rt1GSFD1D+o5w5aXpHAja1GSJyRpH30K0oHp3cUOwdMr0u6/h6oX
 3JoV7D6InNwc0+VXSSNF0bYCBJhR+9QMQ8ZwPFGYYqFFr0M5Q1ugVCygohNW/6xa9NhJlXNUe5M
 MME8YbI0UZqkNXuCX08LUY+I5ypSii/UVsOMzrSQhLofWtNWE/IpYG9AT0oyxTjKLoEzMMCmWtY
 CsOVfYH6b1TQah+f09isE7NJ63yEpFT0NJxK4jJp6rPbuSBuGMmBaS3qX7o6Kj9Q==
X-Received: by 2002:a05:600c:1d27:b0:490:48e2:5618 with SMTP id
 5b1f17b1804b1-490b5ebbd18mr22457575e9.22.1780456055980; 
 Tue, 02 Jun 2026 20:07:35 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f35ee64sm4632128f8f.30.2026.06.02.20.07.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 20:07:35 -0700 (PDT)
Date: Wed, 3 Jun 2026 03:07:33 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ah-addBCDNf0e7qc@autotest-wegao.qe.prg2.suse.org>
References: <ah6KOWY2Xcb-grLr@autotest-wegao.qe.prg2.suse.org>
 <6a1effa6.5e46ca1c.1e45c8.7955@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a1effa6.5e46ca1c.1e45c8.7955@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] min_free_kbytes: Handle transient memory drops in
 check_monitor
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Wei Gao via ltp <ltp@lists.linux.it>, linuxtestproject.agent@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMDIsIDIwMjYgYXQgMDQ6MDc6MDJQTSArMDAwMCwgQW5kcmVhIENlcnZlc2F0
byB2aWEgbHRwIHdyb3RlOgo+IEhpIFdlaSwKPiAKPiA+ID4gPiBJbnRyb2R1Y2UgYSAxMCUgdG9s
ZXJhbmNlICg5MCUgdGhyZXNob2xkKSBmb3IgdGhlIE1lbUZyZWUgY2hlY2suIE15Cj4gPiA+ID4g
bWVhc3VyZW1lbnRzIHNob3dlZCB0aGF0IHVuZGVyIGV4dHJlbWUgcHJlc3N1cmUsIE1lbUZyZWUg
Y2FuIGRpcCBhcyBsb3cKPiA+ID4gPiBhcyB+NTAlIHRvIH43MCUgb2YgdGhlIHRhcmdldC4gV2hp
bGUgaXQgdHlwaWNhbGx5IHJlY292ZXJzIGFib3ZlIDkwJQo+ID4gPiA+IHdpdGhpbiBvbmUgc2Vj
b25kLCBoaXR0aW5nIHRoZSBleGFjdCAxMDAlIHdhdGVybWFyayBzb21ldGltZXMgY2FuIHRha2UK
PiA+ID4gPiBzaWduaWZpY2FudGx5IGxvbmdlci4gVGhpcyB0b2xlcmFuY2UgcHJldmVudHMgZmFs
c2UgcG9zaXRpdmVzIGR1cmluZyB0aGUKPiA+ID4gPiBzbG93IHJlY292ZXJ5IHRhaWwgd2hpbGUg
c3RpbGwgZW5zdXJpbmcgbWVtb3J5IGlzIG1haW50YWluZWQgbmVhciB0aGUKPiA+ID4gPiByZXF1
aXJlZCBsZXZlbC4KPiA+ID4gCj4gPiA+IFBsZWFzZSByZXdyaXRlIGluIGltcGVyc29uYWwgZm9y
bSwgZS5nLjoKPiA+ID4gICAiTWVhc3VyZW1lbnRzIHVuZGVyIGV4dHJlbWUgcHJlc3N1cmUgc2hv
dyBNZW1GcmVlIGNhbiBkaXAgYXMgbG93IGFzCj4gPiA+ICAgIH41MCUgdG8gfjcwJSBvZiB0aGUg
dGFyZ2V0LiIKPiA+ID4gCj4gPiA+IENvbW1pdCBtZXNzYWdlcyBiZWNvbWUgYSBwZXJtYW5lbnQg
cGFydCBvZiB0aGUgcHJvamVjdCBoaXN0b3J5IGFuZAo+ID4gPiBzaG91bGQgYXZvaWQgZmlyc3Qt
cGVyc29uIGxhbmd1YWdlLgo+ID4gVGhlIG1lYXN1cmVtZW50IHJlc3VsdCBpcyBxdWl0ZSByZWxh
dGVkIHdpdGggbXkgbG9jYWwgZW52LCBhbHNvIGlzIHRoZXJlIGFueSBsdHAKPiA+IHJ1bGUgZm9y
YmlkcyB0aGUgdXNlIG9mICJNeSI/Cj4gCj4gWWVhaCwgdGhpcyBpcyBxdWl0ZSBjb21tb24gaW4g
dGhlIGNvbW1pdCBtZXNzYWdlcywgYnV0IGl0J3Mgbm90IGEgc3RyaWN0Cj4gcnVsZSBkb24ndCB3
b3JyeSBhYm91dCBpdC4KPiAKPiA+ID4gCj4gPiA+ID4gLXVuc2lnbmVkIGxvbmcgdHVuZTsKPiA+
ID4gPiAtdW5zaWduZWQgbG9uZyBtZW1mcmVlOwo+ID4gPiA+ICt1bnNpZ25lZCBsb25nIHR1bmUs
IHRocmVzaG9sZDsKPiA+ID4gPiArdW5zaWduZWQgbG9uZyBtZW1mcmVlLCBtaW5fbWVtZnJlZTsK
PiA+ID4gPiAraW50IGk7Cj4gPiA+ID4KPiA+ID4gPiAgd2hpbGUgKCFlbmQpIHsKPiA+ID4gPiAg
bWVtZnJlZSA9IFNBRkVfUkVBRF9NRU1JTkZPKCJNZW1GcmVlOiIpOwo+ID4gPiA+ICB0dW5lID0g
VFNUX1NZU19DT05GX0xPTkdfR0VUKE1JTl9GUkVFX0tCWVRFUyk7Cj4gPiA+ID4gKy8qCj4gPiA+
ID4gKyAqIEFsbG93IDEwJSB0b2xlcmFuY2UgdG8gYWNjb3VudCBmb3IgdHJhbnNpZW50IHN0YXRl
cy4KPiA+ID4gPiArICovCj4gPiA+ID4gK3RocmVzaG9sZCA9IHR1bmUgKiA5IC8gMTA7Cj4gPiA+
ID4KPiA+ID4gPiAgaWYgKG1lbWZyZWUgPCB0dW5lKSB7Cj4gPiA+ID4gLXRzdF9yZXMoVElORk8s
ICJNZW1GcmVlIGlzICVsdSBrQiwgIgo+ID4gPiA+IC0gIm1pbl9mcmVlX2tieXRlcyBpcyAlbHUg
a0IiLCBtZW1mcmVlLCB0dW5lKTsKPiA+ID4gPiAtdHN0X3JlcyhURkFJTCwgIk1lbUZyZWUgPCBt
aW5fZnJlZV9rYnl0ZXMiKTsKPiA+ID4gPiArbWluX21lbWZyZWUgPSBtZW1mcmVlOwo+ID4gPiA+
ICsvKgo+ID4gPiA+ICsgKiBHaXZlIGl0IHNvbWUgdGltZSB0byByZWNsYWltLiBUaGUga2VybmVs
IHNob3VsZCBrZWVwCj4gPiA+ID4gKyAqIE1lbUZyZWUgYWJvdmUgbWluX2ZyZWVfa2J5dGVzLCBi
dXQgdHJhbnNpZW50IGRyb3BzCj4gPiA+ID4gKyAqIGFyZSBwb3NzaWJsZSB1bmRlciBoaWdoIHBy
ZXNzdXJlLgo+ID4gPiA+ICsgKiBDaGVjayBldmVyeSAxMG1zIGZvciB1cCB0byAyIHNlY29uZHMg
Zm9yIGhpZ2ggYWNjdXJhY3kuCj4gPiA+ID4gKyAqLwo+ID4gPiA+ICtmb3IgKGkgPSAxMDsgaSA8
PSAyMDAwOyBpICs9IDEwKSB7Cj4gPiA+ID4gK3VzbGVlcCgxMDAwMCk7Cj4gPiA+ID4gK21lbWZy
ZWUgPSBTQUZFX1JFQURfTUVNSU5GTygiTWVtRnJlZToiKTsKPiA+ID4gPiAraWYgKG1lbWZyZWUg
PCBtaW5fbWVtZnJlZSkKPiA+ID4gPiArbWluX21lbWZyZWUgPSBtZW1mcmVlOwo+ID4gPiA+ICsK
PiA+ID4gPiAraWYgKG1lbWZyZWUgPj0gdHVuZSkKPiA+ID4gPiArYnJlYWs7Cj4gPiA+ID4gK30K
PiA+ID4gCj4gPiA+IFRoZSBpbm5lciBwb2xsaW5nIGxvb3AgZG9lcyBub3QgY2hlY2sgdGhlICdl
bmQnIGZsYWcsIHdoaWNoIGlzIHNldCB0byAxCj4gPiA+IGJ5IHRoZSBTSUdVU1IxIGhhbmRsZXIg
d2hlbiB0aGUgcGFyZW50IGZpbmlzaGVzLiBJbiB0aGUgb3JpZ2luYWwgY29kZSwKPiA+ID4gdGhl
IHNpbmdsZSBzbGVlcCgyKSBhdCB0aGUgYm90dG9tIG9mIHRoZSBvdXRlciBsb29wIHdhcyBpbnRl
cnJ1cHRlZCBieQo+ID4gPiB0aGUgc2lnbmFsICh1c2xlZXAvc2xlZXAgcmV0dXJuIEVJTlRSKSwg
c28gdGhlIG91dGVyIHdoaWxlICghZW5kKSBjaGVjawo+ID4gPiBmaXJlZCBwcm9tcHRseS4gV2l0
aCB0aGUgbmV3IGdyYWNlIHBlcmlvZCBsb29wLCB0aGUgc2lnbmFsIGNhbiBmaXJlCj4gPiA+IHdo
aWxlIHdlIGFyZSBpbiBhbnkgb2YgdGhlIDIwMCBpbm5lciB1c2xlZXAoMTAwMDApIGNhbGxzOyB0
aGUgc2xlZXAKPiA+ID4gcmV0dXJucyBlYXJseSBidXQgdGhlIGxvb3AgYm9keSBjb250aW51ZXMs
IGFuZCB0aGUgb3V0ZXIgd2hpbGUgKCFlbmQpCj4gPiA+IGNhbm5vdCBiZSByZWFjaGVkIHVudGls
IHRoZSBmdWxsIH4yIHNlY29uZHMgZWxhcHNlLgo+ID4gPiAKPiA+ID4gUGxlYXNlIGFkZCBhbiBl
YXJseSBleGl0Ogo+ID4gPiAKPiA+ID4gICBmb3IgKGkgPSAxMDsgaSA8PSAyMDAwOyBpICs9IDEw
KSB7Cj4gPiA+ICAgICAgIGlmIChlbmQpCj4gPiA+ICAgICAgICAgICByZXR1cm47Cj4gPiA+ICAg
ICAgIHVzbGVlcCgxMDAwMCk7Cj4gPiA+ICAgICAgIG1lbWZyZWUgPSBTQUZFX1JFQURfTUVNSU5G
TygiTWVtRnJlZToiKTsKPiA+ID4gICAgICAgaWYgKG1lbWZyZWUgPCBtaW5fbWVtZnJlZSkKPiA+
ID4gICAgICAgICAgIG1pbl9tZW1mcmVlID0gbWVtZnJlZTsKPiA+ID4gICAgICAgaWYgKG1lbWZy
ZWUgPj0gdHVuZSkKPiA+ID4gICAgICAgICAgIGJyZWFrOwo+ID4gPiAgIH0KPiA+ID4gCj4gPiA+
IEFsdGVybmF0aXZlbHkgYSBgYnJlYWtgIGlzIHN1ZmZpY2llbnQgaWYgdGhlIG91dGVyIGxvb3Ag
Y2hlY2sgaXMKPiA+ID4gcmVhY2hlZCBxdWlja2x5LCBidXQgYHJldHVybmAgaXMgY2xlYW5lciBn
aXZlbiB0aGUgZnVuY3Rpb24gb25seSBoYXMKPiA+ID4gb25lIGV4aXQgcG9pbnQgYW55d2F5Lgo+
ID4gQ29tcGxldGVuZXNzIGlzIG1vcmUgaW1wb3J0YW50IHRoYW4gc2F2aW5nIDIgc2Vjb25kcyBv
ZiB0ZXN0IHRpbWUsIGVzcGVjaWFsbHkgCj4gPiBmb3IgdGhlIGZpbmFsIHN1Yi10ZXN0LiBJZiB3
ZSBqdW1wIG91dCBlYXJseSwgd2UgbWlnaHQgbWlzcyB0aGUgZmluYWwgcmVzdWx0IG9mIHRoZSB0
ZXN0Lgo+IAo+IEknbSBub3Qgc3VyZSBhYm91dCB0aGlzIG9uZS4gSW4gZ2VuZXJhbCwgb25jZSB3
ZSBoYXZlIGEgcmVzdWx0IHdlCj4gc2hvdWxkIHJldHVybiBhcyBmYXN0IGFzIHBvc3NpYmxlLCBz
byB3ZSBjYW4gc2F2ZSB0aW1lIHdoaWxlIHJ1bm5pbmcKPiBvdGhlciB0ZXN0cy4gMiBzZWNvbmRz
IG1pZ2h0IG5vdCBzZWVtIGVub3VnaCwgYnV0IHdoZW4gd2Ugc3VtIHVwCj4gdmFyaW91cyB0ZXN0
cyB3aXRoIHRoZSBzYW1lIGxvZ2ljLCB3ZSBtaWdodCBoYXZlIGEgYmlnIGRlbGF5LgoKU2luY2Ug
ZW5kIGlzIG9ubHkgc2V0IHRvIDEgYnkgU0lHVVNSMSBhdCB0aGUgdmVyeSBlbmQgb2YgdGhlIGVu
dGlyZSBwcm9ncmFtLCAKYWRkaW5nIGVuZCBjaGVjayB0byB0aGUgaW5uZXIgbG9vcCB3b3VsZCBv
bmx5IHNhdmUgdGltZSBkdXJpbmcgdGhlIGZpbmFsIHRlYXJkb3duLCAKdGhlIG1heGltdW0gcG9z
c2libGUgdGltZSBzYXZlZCBpcyBqdXN0IDIgc2Vjb25kcywgYWxzbyB3ZSBzdGFydCB0YWtlIGEg
cmVhbCByaXNrOiAKSWYgYSBtZW1vcnkgZHJvcCBpcyBhY3RpdmUgYXQgdGhlIHZlcnkgZW5kIG9m
IHRoZSB0ZXN0LCBhbmQgd2UgZXhpdCBlYXJseSBiZWNhdXNlIAplbmQgPT0gMSwgd2UgbWlzcyB0
aGUgZmluYWwgcmVzdWx0IChjb21wbGV0ZW5lc3MpLgoKPiAKPiA+ID4gCj4gPiA+ID4gK2lmICht
ZW1mcmVlIDwgdGhyZXNob2xkKSB7Cj4gPiA+ID4gK3RzdF9yZXMoVEZBSUwsICJNZW1GcmVlICVs
dSA8IDkwJSUgb2YgbWluX2ZyZWVfa2J5dGVzICVsdSAoTWluU2VlbjogJWx1JSUpIGFmdGVyIDJz
IiwKPiA+ID4gPiArbWVtZnJlZSwgdHVuZSwgKG1pbl9tZW1mcmVlICogMTAwIC8gdHVuZSkpOwo+
ID4gPiA+ICt9IGVsc2UgaWYgKG1lbWZyZWUgPCB0dW5lKSB7Cj4gPiA+ID4gK3RzdF9yZXMoVElO
Rk8sICJNZW1GcmVlICglbHUpIHN0YXllZCB3aXRoaW4gMTAlJSB0b2xlcmFuY2UgKG1pbiAlbHUl
JSkgYWZ0ZXIgfjJzIiwKPiA+ID4gPiArbWVtZnJlZSwgKG1pbl9tZW1mcmVlICogMTAwIC8gdHVu
ZSkpOwo+ID4gPiA+ICt9IGVsc2Ugewo+ID4gPiA+ICt0c3RfcmVzKFRJTkZPLCAiTWVtRnJlZSBy
ZWNvdmVyZWQgdG8gJWx1IChtaW4gJWx1JSUpIGFmdGVyICVkIG1zIiwKPiA+ID4gPiArbWVtZnJl
ZSwgKG1pbl9tZW1mcmVlICogMTAwIC8gdHVuZSksIGkpOwo+ID4gPiA+ICt9Cj4gPiA+IAo+ID4g
PiBNaW5vcjogdGhlIFRJTkZPIG1lc3NhZ2VzIG1peCBrQiB2YWx1ZXMgYW5kIHBlcmNlbnRhZ2Ug
dmFsdWVzIHVzaW5nIHRoZQo+ID4gPiBzYW1lIGZvcm1hdCBzcGVjaWZpZXIgJWx1LCB3aGljaCBj
YW4gYmUgY29uZnVzaW5nIGluIHRoZSBvdXRwdXQuIFRoZQo+ID4gPiBURkFJTCBsaW5lIHByaW50
cyBNZW1GcmVlIGFuZCB0dW5lIGFzIHJhdyBrQiB2YWx1ZXMgYnV0IGxhYmVscyB0aGUgdGhpcmQK
PiA+ID4gYXJndW1lbnQgIihNaW5TZWVuOiBOJSkiIOKAlCB0aGUgaW50ZW50IGlzIGNsZWFyIGJ1
dCBhZGRpbmcgImtCIiB1bml0cyB0bwo+ID4gPiB0aGUgZmlyc3QgdHdvIHZhbHVlcyB3b3VsZCBi
ZSBtb3JlIGNvbnNpc3RlbnQ6Cj4gPiA+IAo+ID4gPiAgICJNZW1GcmVlICVsdSBrQiA8IDkwJSUg
b2YgbWluX2ZyZWVfa2J5dGVzICVsdSBrQiAoTWluU2VlbjogJWx1JSUpIGFmdGVyIDJzIgo+ID4g
PiAKPiA+ID4gU2ltaWxhcmx5IGZvciB0aGUgVElORk8gbGluZXMuCj4gPiBOYW1lIGlzIG1pbl9m
cmVlX2tieXRlcyBhbmQgdGhlIHRlc3QgY29udGV4dCBpcyB2ZXJ5IGNsZWFyLgo+ID4gCj4gPiBV
bmxlc3MgdGhlcmUncyBhIGxvZ2ljYWwgZXJyb3Igb3IgYW4gTFRQIHJ1bGUgdmlvbGF0aW9uLCBJ
IHdvbid0IGJlIHNlbmRpbmcgYW5vdGhlciBwYXRjaC4KPiAKPiBJIHRoaW5rIHRoZSBhZ2VudCBj
b21wbGFpbnMgdGhhdCB0aGUgb3V0cHV0IG1lc3NhZ2UgaXMgbm90IGVhc3kKPiB0byBkZWJ1Zzog
d2UgYXJlIHByaW50aW5nIHZhbHVlcyB3aXRob3V0IHRoZSB1bml0cy4gSSB3b3VsZCBqdXN0Cj4g
YWRkIE1lbUZyZWUgdW5pdCBga0JgIGluIHRoaXMgY2FzZS4gVGhlIHJlc3Qgb2YgdGhlIG1lc3Nh
Z2UgbG9va3MKPiBvay4KPiAKPiBSZWdhcmRzLAo+IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+IFNV
U0UgUUUgQXV0b21hdGlvbiBFbmdpbmVlciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5j
b20KPiAKPiAtLSAKPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
