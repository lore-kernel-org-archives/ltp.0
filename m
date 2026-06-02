Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A97CD6E4A
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 07:46:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1780386386; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=54KxnG9d4ItVG5wXzyv8O3R2sDhVGSLDmnvYNFCwsGQ=;
 b=FN/iwQCexmGEMUeqhh4Vtb+8DHwUq0FHGlWQ7qfmPB087O+JNCIuGG8tFe5cgeyzJEMys
 uYDZ1QYg1e7hD2iqK9ShCgWp81HA5NjekvJ6ePdOYWaf9GKx49HMmM6RdpzglzSiNZS+TNY
 H5MLp7GnWEOgdd4JllZ4gqZWWZdKSgk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95CB03E30BC
	for <ltp@archiver.kernel.org>; Tue,  2 Jun 2026 09:46:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94E263E23F2
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 09:46:04 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 045721402FAF
 for <ltp@lists.linux.it>; Tue,  2 Jun 2026 09:46:03 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4903f7a90d1so99017865e9.2
 for <ltp@lists.linux.it>; Tue, 02 Jun 2026 00:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1780386363; x=1780991163; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zaZp8RSXpiepr6rNcqzoVbsRR8vTLeUf30w7pJGsjNQ=;
 b=YwOLsPv63ErZPnT8hwTi9NPXkvQ6h2+jik+ChEdkezqRxTadePDGATeEek6ip9+6Kn
 P8gkh2UOY/P+2GG0e2cdBtgjoyB52Wn/7jva2vXoof8YTi91nj/RoiQDEaT0Usahjpl6
 5EozEC235OFcsJBEV09X/VQfSPuqemkrDN63VnO8a8yINhznRbwXaRD4FhTIkbKcaMwA
 jWLmRy3obwY7BuFMZl1cT1ozDVK9S9/6i9b2CE956nqJ17/Je4IcYxnnb0NxwEZ8/7MV
 k4mcNGqRr2zoFpfz/yYGz59vVq3RgfMHg8ZOXONr7sDl5IlrtetC4r7fx/61eHBJL9y3
 lSMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780386363; x=1780991163;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zaZp8RSXpiepr6rNcqzoVbsRR8vTLeUf30w7pJGsjNQ=;
 b=Ku38NQfYiR+qW/g52qepbIhO88d/CzFrQ5T1DMvgiuvuWulc+pnvLzmMz0kVRrkEEM
 pN1A7yfYo72DbRIxYGhkVYZCNPFzlLGrj2PPcmJN7Cs8QKBmBAfzEw22IMGgDPc8ouhT
 tfzUbrtEALWkQOrQkH9Y7tsiNBPeYrNiJ5y7zBPBMWsSFwwRfZdj0WkleL4n2apbGKun
 de8kNh23oY/XskpCy6MFtiyhdGUD1sgrytvEAaGRiLq7qpWLLnbGc2Kd6mtf2fxrCN/L
 NnIZcTVjRIr1ChI+JmrBTZtA7aHvQaDsIIjM2FrTJLr3kW+alOMV5A+0Fg7DL7MHGxrd
 /BLA==
X-Gm-Message-State: AOJu0YwoS4aYp5TFnW012mOpJOvZxTFa3RzmBfrJz3HrjSjCRWbSdU6i
 XdiSL3HhspEh2GZI6PqxtnXoOoH9Hg59filmgCzF6snNSjiNcuHUanCna+oyrdjY4Y4dP6lDLhU
 rmyc=
X-Gm-Gg: Acq92OHLVzWAJ+KlvGz3Z7YGQWGh+86PUjzaeGj97qD4Z16LnvVUDfM7OTuJmgdytHB
 DhWB/wmFtvXe8r/st2jN6xqyGKzgpNDS/JDS2lOLrK8xiB+N9r+AucRjwnF5w90Xt6ksz/Xtg23
 LsB9y6xjWfKXkqjUXorO4Gxsjp8EMC92YaxR73hYkVCwiiFvLNQ3jHaFoXM/sQiR/sdD6ed8vF8
 3ZsHCRcozkFgKrIulPGuRbT1P+KkMyzm1CS4TDIPoGNhhBHIktyDVOmYzXIf2ulST/GyOMHQxL/
 u8cY7WD+i8kIQTkVF8RcPf+smG2+fzNSjsEvY9F7YIXcw2sI6OE71T0r1UQy2pyqhxb9l0Ym8Zf
 eeFYJOI7cxdLvM63eu+VjMlVrn5JdorvzbBctPlZeL6l88unftc8uMgMfWAPApcO2b6djP/t3d8
 oXhNDHcpKp3zYYKLVMZ5tqLu60FkeuFNKeYZPOBA6/wUn6u+kob5A=
X-Received: by 2002:a05:600c:a305:b0:490:7227:100 with SMTP id
 5b1f17b1804b1-490a2933b22mr204899325e9.18.1780386363358; 
 Tue, 02 Jun 2026 00:46:03 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef3559645sm29702819f8f.26.2026.06.02.00.46.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 00:46:03 -0700 (PDT)
Date: Tue, 2 Jun 2026 07:46:01 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <ah6KOWY2Xcb-grLr@autotest-wegao.qe.prg2.suse.org>
References: <20260602010137.27226-1-wegao@suse.com>
 <20260602040255.3991-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260602040255.3991-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMDIsIDIwMjYgYXQgMDQ6MDI6NTVBTSArMDAwMCwgbGludXh0ZXN0cHJvamVj
dC5hZ2VudEBnbWFpbC5jb20gd3JvdGU6Cj4gSGkgV2VpLAo+IAo+IFRoYW5rcyBmb3IgdGhlIHBh
dGNoLiBBIGZldyBjb21tZW50cyBiZWxvdy4KPiAKPiA+IG1pbl9mcmVlX2tieXRlczogSGFuZGxl
IHRyYW5zaWVudCBtZW1vcnkgZHJvcHMgaW4gY2hlY2tfbW9uaXRvcgo+ID4KPiA+IEhpZ2ggbWVt
b3J5IHByZXNzdXJlIGNhbiBjYXVzZSBNZW1GcmVlIHRvIHRlbXBvcmFyaWx5IGRyb3AgYmVsb3cg
dGhlCj4gPiBtaW5fZnJlZV9rYnl0ZXMgdGhyZXNob2xkIGJlZm9yZSB0aGUga2VybmVsIHJlY2xh
aW1lciBjYW4gY2F0Y2ggdXAuCj4gPiBUaGlzIHJlc3VsdHMgaW4gaW50ZXJtaXR0ZW50IHRlc3Qg
ZmFpbHVyZXMsIG9ic2VydmVkIG9uIG9wZW5RQSBhYXJjaDY0Cj4gPiB2aXJ0dWFsIG1hY2hpbmVz
Lgo+ID4KPiA+IEltcGxlbWVudCBhIDItc2Vjb25kIGdyYWNlIHBlcmlvZCB3aXRoIGhpZ2gtYWNj
dXJhY3kgMTBtcyBmaXhlZCBwb2xsaW5nCj4gPiBpbiBjaGVja19tb25pdG9yKCkgdG8gYWxsb3cg
dGhlIGtlcm5lbCB0aW1lIHRvIHJlY2xhaW0gbWVtb3J5Lgo+ID4KPiA+IEludHJvZHVjZSBhIDEw
JSB0b2xlcmFuY2UgKDkwJSB0aHJlc2hvbGQpIGZvciB0aGUgTWVtRnJlZSBjaGVjay4gTXkKPiA+
IG1lYXN1cmVtZW50cyBzaG93ZWQgdGhhdCB1bmRlciBleHRyZW1lIHByZXNzdXJlLCBNZW1GcmVl
IGNhbiBkaXAgYXMgbG93Cj4gPiBhcyB+NTAlIHRvIH43MCUgb2YgdGhlIHRhcmdldC4gV2hpbGUg
aXQgdHlwaWNhbGx5IHJlY292ZXJzIGFib3ZlIDkwJQo+ID4gd2l0aGluIG9uZSBzZWNvbmQsIGhp
dHRpbmcgdGhlIGV4YWN0IDEwMCUgd2F0ZXJtYXJrIHNvbWV0aW1lcyBjYW4gdGFrZQo+ID4gc2ln
bmlmaWNhbnRseSBsb25nZXIuIFRoaXMgdG9sZXJhbmNlIHByZXZlbnRzIGZhbHNlIHBvc2l0aXZl
cyBkdXJpbmcgdGhlCj4gPiBzbG93IHJlY292ZXJ5IHRhaWwgd2hpbGUgc3RpbGwgZW5zdXJpbmcg
bWVtb3J5IGlzIG1haW50YWluZWQgbmVhciB0aGUKPiA+IHJlcXVpcmVkIGxldmVsLgo+IAo+IFBs
ZWFzZSByZXdyaXRlIGluIGltcGVyc29uYWwgZm9ybSwgZS5nLjoKPiAgICJNZWFzdXJlbWVudHMg
dW5kZXIgZXh0cmVtZSBwcmVzc3VyZSBzaG93IE1lbUZyZWUgY2FuIGRpcCBhcyBsb3cgYXMKPiAg
ICB+NTAlIHRvIH43MCUgb2YgdGhlIHRhcmdldC4iCj4gCj4gQ29tbWl0IG1lc3NhZ2VzIGJlY29t
ZSBhIHBlcm1hbmVudCBwYXJ0IG9mIHRoZSBwcm9qZWN0IGhpc3RvcnkgYW5kCj4gc2hvdWxkIGF2
b2lkIGZpcnN0LXBlcnNvbiBsYW5ndWFnZS4KVGhlIG1lYXN1cmVtZW50IHJlc3VsdCBpcyBxdWl0
ZSByZWxhdGVkIHdpdGggbXkgbG9jYWwgZW52LCBhbHNvIGlzIHRoZXJlIGFueSBsdHAKcnVsZSBm
b3JiaWRzIHRoZSB1c2Ugb2YgIk15Ij8KPiAKPiA+IC11bnNpZ25lZCBsb25nIHR1bmU7Cj4gPiAt
dW5zaWduZWQgbG9uZyBtZW1mcmVlOwo+ID4gK3Vuc2lnbmVkIGxvbmcgdHVuZSwgdGhyZXNob2xk
Owo+ID4gK3Vuc2lnbmVkIGxvbmcgbWVtZnJlZSwgbWluX21lbWZyZWU7Cj4gPiAraW50IGk7Cj4g
Pgo+ID4gIHdoaWxlICghZW5kKSB7Cj4gPiAgbWVtZnJlZSA9IFNBRkVfUkVBRF9NRU1JTkZPKCJN
ZW1GcmVlOiIpOwo+ID4gIHR1bmUgPSBUU1RfU1lTX0NPTkZfTE9OR19HRVQoTUlOX0ZSRUVfS0JZ
VEVTKTsKPiA+ICsvKgo+ID4gKyAqIEFsbG93IDEwJSB0b2xlcmFuY2UgdG8gYWNjb3VudCBmb3Ig
dHJhbnNpZW50IHN0YXRlcy4KPiA+ICsgKi8KPiA+ICt0aHJlc2hvbGQgPSB0dW5lICogOSAvIDEw
Owo+ID4KPiA+ICBpZiAobWVtZnJlZSA8IHR1bmUpIHsKPiA+IC10c3RfcmVzKFRJTkZPLCAiTWVt
RnJlZSBpcyAlbHUga0IsICIKPiA+IC0gIm1pbl9mcmVlX2tieXRlcyBpcyAlbHUga0IiLCBtZW1m
cmVlLCB0dW5lKTsKPiA+IC10c3RfcmVzKFRGQUlMLCAiTWVtRnJlZSA8IG1pbl9mcmVlX2tieXRl
cyIpOwo+ID4gK21pbl9tZW1mcmVlID0gbWVtZnJlZTsKPiA+ICsvKgo+ID4gKyAqIEdpdmUgaXQg
c29tZSB0aW1lIHRvIHJlY2xhaW0uIFRoZSBrZXJuZWwgc2hvdWxkIGtlZXAKPiA+ICsgKiBNZW1G
cmVlIGFib3ZlIG1pbl9mcmVlX2tieXRlcywgYnV0IHRyYW5zaWVudCBkcm9wcwo+ID4gKyAqIGFy
ZSBwb3NzaWJsZSB1bmRlciBoaWdoIHByZXNzdXJlLgo+ID4gKyAqIENoZWNrIGV2ZXJ5IDEwbXMg
Zm9yIHVwIHRvIDIgc2Vjb25kcyBmb3IgaGlnaCBhY2N1cmFjeS4KPiA+ICsgKi8KPiA+ICtmb3Ig
KGkgPSAxMDsgaSA8PSAyMDAwOyBpICs9IDEwKSB7Cj4gPiArdXNsZWVwKDEwMDAwKTsKPiA+ICtt
ZW1mcmVlID0gU0FGRV9SRUFEX01FTUlORk8oIk1lbUZyZWU6Iik7Cj4gPiAraWYgKG1lbWZyZWUg
PCBtaW5fbWVtZnJlZSkKPiA+ICttaW5fbWVtZnJlZSA9IG1lbWZyZWU7Cj4gPiArCj4gPiAraWYg
KG1lbWZyZWUgPj0gdHVuZSkKPiA+ICticmVhazsKPiA+ICt9Cj4gCj4gVGhlIGlubmVyIHBvbGxp
bmcgbG9vcCBkb2VzIG5vdCBjaGVjayB0aGUgJ2VuZCcgZmxhZywgd2hpY2ggaXMgc2V0IHRvIDEK
PiBieSB0aGUgU0lHVVNSMSBoYW5kbGVyIHdoZW4gdGhlIHBhcmVudCBmaW5pc2hlcy4gSW4gdGhl
IG9yaWdpbmFsIGNvZGUsCj4gdGhlIHNpbmdsZSBzbGVlcCgyKSBhdCB0aGUgYm90dG9tIG9mIHRo
ZSBvdXRlciBsb29wIHdhcyBpbnRlcnJ1cHRlZCBieQo+IHRoZSBzaWduYWwgKHVzbGVlcC9zbGVl
cCByZXR1cm4gRUlOVFIpLCBzbyB0aGUgb3V0ZXIgd2hpbGUgKCFlbmQpIGNoZWNrCj4gZmlyZWQg
cHJvbXB0bHkuIFdpdGggdGhlIG5ldyBncmFjZSBwZXJpb2QgbG9vcCwgdGhlIHNpZ25hbCBjYW4g
ZmlyZQo+IHdoaWxlIHdlIGFyZSBpbiBhbnkgb2YgdGhlIDIwMCBpbm5lciB1c2xlZXAoMTAwMDAp
IGNhbGxzOyB0aGUgc2xlZXAKPiByZXR1cm5zIGVhcmx5IGJ1dCB0aGUgbG9vcCBib2R5IGNvbnRp
bnVlcywgYW5kIHRoZSBvdXRlciB3aGlsZSAoIWVuZCkKPiBjYW5ub3QgYmUgcmVhY2hlZCB1bnRp
bCB0aGUgZnVsbCB+MiBzZWNvbmRzIGVsYXBzZS4KPiAKPiBQbGVhc2UgYWRkIGFuIGVhcmx5IGV4
aXQ6Cj4gCj4gICBmb3IgKGkgPSAxMDsgaSA8PSAyMDAwOyBpICs9IDEwKSB7Cj4gICAgICAgaWYg
KGVuZCkKPiAgICAgICAgICAgcmV0dXJuOwo+ICAgICAgIHVzbGVlcCgxMDAwMCk7Cj4gICAgICAg
bWVtZnJlZSA9IFNBRkVfUkVBRF9NRU1JTkZPKCJNZW1GcmVlOiIpOwo+ICAgICAgIGlmIChtZW1m
cmVlIDwgbWluX21lbWZyZWUpCj4gICAgICAgICAgIG1pbl9tZW1mcmVlID0gbWVtZnJlZTsKPiAg
ICAgICBpZiAobWVtZnJlZSA+PSB0dW5lKQo+ICAgICAgICAgICBicmVhazsKPiAgIH0KPiAKPiBB
bHRlcm5hdGl2ZWx5IGEgYGJyZWFrYCBpcyBzdWZmaWNpZW50IGlmIHRoZSBvdXRlciBsb29wIGNo
ZWNrIGlzCj4gcmVhY2hlZCBxdWlja2x5LCBidXQgYHJldHVybmAgaXMgY2xlYW5lciBnaXZlbiB0
aGUgZnVuY3Rpb24gb25seSBoYXMKPiBvbmUgZXhpdCBwb2ludCBhbnl3YXkuCkNvbXBsZXRlbmVz
cyBpcyBtb3JlIGltcG9ydGFudCB0aGFuIHNhdmluZyAyIHNlY29uZHMgb2YgdGVzdCB0aW1lLCBl
c3BlY2lhbGx5IApmb3IgdGhlIGZpbmFsIHN1Yi10ZXN0LiBJZiB3ZSBqdW1wIG91dCBlYXJseSwg
d2UgbWlnaHQgbWlzcyB0aGUgZmluYWwgcmVzdWx0IG9mIHRoZSB0ZXN0Lgo+IAo+ID4gK2lmICht
ZW1mcmVlIDwgdGhyZXNob2xkKSB7Cj4gPiArdHN0X3JlcyhURkFJTCwgIk1lbUZyZWUgJWx1IDwg
OTAlJSBvZiBtaW5fZnJlZV9rYnl0ZXMgJWx1IChNaW5TZWVuOiAlbHUlJSkgYWZ0ZXIgMnMiLAo+
ID4gK21lbWZyZWUsIHR1bmUsIChtaW5fbWVtZnJlZSAqIDEwMCAvIHR1bmUpKTsKPiA+ICt9IGVs
c2UgaWYgKG1lbWZyZWUgPCB0dW5lKSB7Cj4gPiArdHN0X3JlcyhUSU5GTywgIk1lbUZyZWUgKCVs
dSkgc3RheWVkIHdpdGhpbiAxMCUlIHRvbGVyYW5jZSAobWluICVsdSUlKSBhZnRlciB+MnMiLAo+
ID4gK21lbWZyZWUsIChtaW5fbWVtZnJlZSAqIDEwMCAvIHR1bmUpKTsKPiA+ICt9IGVsc2Ugewo+
ID4gK3RzdF9yZXMoVElORk8sICJNZW1GcmVlIHJlY292ZXJlZCB0byAlbHUgKG1pbiAlbHUlJSkg
YWZ0ZXIgJWQgbXMiLAo+ID4gK21lbWZyZWUsIChtaW5fbWVtZnJlZSAqIDEwMCAvIHR1bmUpLCBp
KTsKPiA+ICt9Cj4gCj4gTWlub3I6IHRoZSBUSU5GTyBtZXNzYWdlcyBtaXgga0IgdmFsdWVzIGFu
ZCBwZXJjZW50YWdlIHZhbHVlcyB1c2luZyB0aGUKPiBzYW1lIGZvcm1hdCBzcGVjaWZpZXIgJWx1
LCB3aGljaCBjYW4gYmUgY29uZnVzaW5nIGluIHRoZSBvdXRwdXQuIFRoZQo+IFRGQUlMIGxpbmUg
cHJpbnRzIE1lbUZyZWUgYW5kIHR1bmUgYXMgcmF3IGtCIHZhbHVlcyBidXQgbGFiZWxzIHRoZSB0
aGlyZAo+IGFyZ3VtZW50ICIoTWluU2VlbjogTiUpIiDigJQgdGhlIGludGVudCBpcyBjbGVhciBi
dXQgYWRkaW5nICJrQiIgdW5pdHMgdG8KPiB0aGUgZmlyc3QgdHdvIHZhbHVlcyB3b3VsZCBiZSBt
b3JlIGNvbnNpc3RlbnQ6Cj4gCj4gICAiTWVtRnJlZSAlbHUga0IgPCA5MCUlIG9mIG1pbl9mcmVl
X2tieXRlcyAlbHUga0IgKE1pblNlZW46ICVsdSUlKSBhZnRlciAycyIKPiAKPiBTaW1pbGFybHkg
Zm9yIHRoZSBUSU5GTyBsaW5lcy4KTmFtZSBpcyBtaW5fZnJlZV9rYnl0ZXMgYW5kIHRoZSB0ZXN0
IGNvbnRleHQgaXMgdmVyeSBjbGVhci4KClVubGVzcyB0aGVyZSdzIGEgbG9naWNhbCBlcnJvciBv
ciBhbiBMVFAgcnVsZSB2aW9sYXRpb24sIEkgd29uJ3QgYmUgc2VuZGluZyBhbm90aGVyIHBhdGNo
Lgo+IAo+IC0tLQo+IAo+IFZlcmRpY3Q6IE5lZWRzIHJldmlzaW9uCj4gCj4gVGhlIG1pc3Npbmcg
J2VuZCcgY2hlY2sgaW4gdGhlIGlubmVyIHBvbGxpbmcgbG9vcCBpcyBhIHJlZ3Jlc3Npb246IGl0
Cj4gcmVtb3ZlcyB0aGUgcHJvbXB0IHRlcm1pbmF0aW9uIGJlaGF2aW91ciBvZiB0aGUgb3JpZ2lu
YWwgc2xlZXAoMikgYW5kCj4gY2FuIGRlbGF5IHRoZSB0ZXN0IGV4aXQgYnkgdXAgdG8gMiBzZWNv
bmRzIGFmdGVyIFNJR1VTUjEgaXMgcmVjZWl2ZWQuCj4gUGxlYXNlIGZpeCBiZWZvcmUgbWVyZ2lu
Zy4gVGhlIGNvbW1pdCBtZXNzYWdlIGZpcnN0LXBlcnNvbiB3b3JkaW5nIGFuZAo+IHRoZSBtaXNz
aW5nIGtCIHVuaXQgbGFiZWxzIGFyZSBtaW5vciBhbmQgY2FuIGJlIGFkZHJlc3NlZCBpbiB0aGUg
c2FtZQo+IHJlc3Bpbi4KPiAKPiBMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
