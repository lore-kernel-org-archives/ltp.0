Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A0ADC02180
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 08:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1737015380; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=8TDtH+eLxCjAo0aMAI0KkA1Ycv1n8IvqGrjn48BjdkE=;
 b=hm2tbs813xPkiorDGwhTehGHcplui/1C0sMJz1To8NGpY+AkFBJtWox3NrdfbLdV6+1/u
 cOsB/8tsuXXLLf3ckfb8t9HKs9xNVTRg1/mjYW4huYWr51oIzoVHd2cDrBZY9oD2U4spT4m
 Eogbc6LuXsQsMicL9FrT6c6pQunjhLY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D8CAE3C7704
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 09:16:20 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B321D3C4FB5
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:16:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=ruansy.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DDB7D6023B0
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 09:15:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1737015360; x=1768551360;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=XZaxvKYk+2vFmq088+i5hjvqeaXC8qFpcQGLxERT6Wo=;
 b=Ko0HKmZLH8TFn3hgStk4qtfC3tQDcoKD6FtLAwdcH2cuxpqRBW1KvAil
 1HCysdORyFhPxWBvmJs97+x7Cm9Z8FhOsUPx49pKISCsp8/6sJQR4acpc
 1AvXLTKShi6SZwuqso8rtVegyHm97mv+jMH1se5cY8hxN+t3Kd9qFDx5u
 gSpl8wV4l/tZ8L1m/EYzeksokKJ/61cJHXTpSX5hsGngyLEvYW2qhGnhc
 wzxA+USsG4n/gyJ3f0DuOUarMSNIQR24ot1+de5HPHSffWumIOJhkz95a
 8he0xIlXVxGlKKL096DxzFLiOIbXsAWyDBpPG5RZUIRDivc+LBINZVY5W A==;
X-CSE-ConnectionGUID: 0+JyHXkKT9SiDUAeaZYg2w==
X-CSE-MsgGUID: ExaJcej4QsKKJH/wdNkl3g==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="186704702"
X-IronPort-AV: E=Sophos;i="6.13,208,1732546800"; d="scan'208";a="186704702"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jan 2025 17:15:57 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com
 [192.168.87.61])
 by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 48A41D4C80
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:15:55 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com
 [192.51.206.22])
 by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 1DB12D4BF1
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:15:55 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 9CFC96B9AB
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 17:15:54 +0900 (JST)
Received: from [192.168.22.105] (unknown [10.167.135.81])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id 0CE1B1A0073;
 Thu, 16 Jan 2025 16:15:53 +0800 (CST)
Message-ID: <4793c0db-61f9-4297-9ae9-2683f2c393df@fujitsu.com>
Date: Thu, 16 Jan 2025 16:15:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, "Ricardo B. Marliere" <rbm@suse.com>
References: <20250115103813.3584089-1-ruansy.fnst@fujitsu.com>
 <2i72vxn22otybddbjyhmsqyxyw2a7jgsswjpbkjccv75ei3n3j@robwkpf3zef6>
 <20250115124513.GC648257@pevik>
In-Reply-To: <20250115124513.GC648257@pevik>
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28926.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28926.005
X-TMASE-Result: 10--12.522300-10.000000
X-TMASE-MatchedRID: AvuQOGDihJqPvrMjLFD6eHchRkqzj/bEC/ExpXrHizyRrCyUgzqHvyzy
 bVqWyY2NF40HISqSK6q12HagvbwDji/7QU2czuUN194/5X9VfCwEa8g1x8eqFxG3US/I5cDRGG5
 W0AapShXJDvFr4liuHDcp6NN2JBt5mcUNCy5hvn9f2SdIdby5dcnlJe2gk8vIZopoopCRD0SjxY
 yRBa/qJaEwgORH8p/AtwKUvHHyXGXdB/CxWTRRu25FeHtsUoHuPxFZcDdbxSlZo2kUZvdlZEZfk
 IdSdzOixRqh+436kFYchXTZ3Wukbw==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] posix_fadvise: Convert docs to docparse
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
From: Shiyang Ruan via ltp <ltp@lists.linux.it>
Reply-To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: ltp@lists.linux.it
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

CgrlnKggMjAyNS8xLzE1IDIwOjQ1LCBQZXRyIFZvcmVsIOWGmemBkzoKPiBIaSBSaWNhcmRvLCBT
aGl5YW5nIFJ1YW4sCj4gCj4+IE9uIFdlZCwgSmFuIDE1LCAyMDI1IGF0IDA2OjM4OjEzUE0gKzA4
MDAsIFNoaXlhbmcgUnVhbiB2aWEgbHRwIHdyb3RlOgo+Pj4gU2lnbmVkLW9mZi1ieTogU2hpeWFu
ZyBSdWFuIDxydWFuc3kuZm5zdEBmdWppdHN1LmNvbT4KPj4+IC0tLQo+Pj4gICAuLi4va2VybmVs
L3N5c2NhbGxzL2ZhZHZpc2UvcG9zaXhfZmFkdmlzZTAxLmMgIHwgMTcgKysrLS0tLS0tLS0tLS0t
LS0KPj4+ICAgLi4uL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZpc2UwMi5jICB8
IDE3ICsrKy0tLS0tLS0tLS0tLS0tCj4+PiAgIC4uLi9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9w
b3NpeF9mYWR2aXNlMDMuYyAgfCAxOCArKysrLS0tLS0tLS0tLS0tLS0KPj4+ICAgLi4uL2tlcm5l
bC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZpc2UwNC5jICB8IDE3ICsrKy0tLS0tLS0tLS0t
LS0tCj4+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNTYgZGVsZXRpb25z
KC0pCj4gCj4+PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNl
L3Bvc2l4X2ZhZHZpc2UwMS5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bv
c2l4X2ZhZHZpc2UwMS5jCj4+PiBpbmRleCA3MWU2NDU0ZDguLjY1MDQ1OTQ1NSAxMDA2NDQKPj4+
IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFkdmlzZS9wb3NpeF9mYWR2aXNlMDEu
Ywo+Pj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYWR2aXNlL3Bvc2l4X2ZhZHZp
c2UwMS5jCj4+PiBAQCAtMywyMSArMywxMCBAQAo+Pj4gICAgKiBDb3B5cmlnaHQgKGMpIFJlZCBI
YXQgSW5jLiwgMjAwNwo+Pj4gICAgKi8KPiAKPj4+IC0vKgo+Pj4gLSAqIE5BTUUKPj4+IC0gKglw
b3NpeF9mYWR2aXNlMDEuYwo+Pj4gLSAqCj4+PiAtICogREVTQ1JJUFRJT04KPj4+IC0gKglDaGVj
ayB0aGUgdmFsdWUgdGhhdCBwb3NpeF9mYWR2aXNlIHJldHVybnMgZm9yIHdyb25nIEFEVklTRSB2
YWx1ZS4KPj4+IC0gKgo+Pj4gLSAqIFVTQUdFCj4+PiAtICoJcG9zaXhfZmFkdmlzZTAxCj4+PiAt
ICoKPj4+IC0gKiBISVNUT1JZCj4+PiAtICoJMTEvMjAwNyBJbml0aWFsIHZlcnNpb24gYnkgTWFz
YXRha2UgWUFNQVRPIDx5YW1hdG9AcmVkaGF0LmNvbT4KPiAKPj4gSU1ITywgeW91IGNvdWxkIGtl
ZXAgdGhlc2UgJ0hJU1RPUlknIGxpbmVzIGJlbG93IHRoZSBjb3B5cmlnaHQuCj4gCj4gSU1ITyB3
ZSBzaG91bGQga2VlcCBuYW1lcyBvciB3aGF0ZXZlciBpbmZvIGlzIHRoZXJlLiBCdXQgZG9uJ3Qg
aGF2ZSB0byBrZWVwCj4gbWVzc3kgZm9ybWF0dGluZyBvciBvcmlnaW5hbCBjb21tZW50cy4gSSB3
b3VsZCBwZXJzb25hbGx5IGtlZXAgaGVyZSBvbmx5Ogo+IAo+ICAgKiBBdXRob3I6IE1hc2F0YWtl
IFlBTUFUTyA8eWFtYXRvQHJlZGhhdC5jb20+Cj4gKGl0J3Mgb2J2aW91cyBpdCB3YXMgaW5pdGlh
bCB2ZXJzaW9uIGFuZCBSZWQgSGF0IGNvcHlyaWdodCAyMDA3KQo+IAo+IG9yIG1vcmUgY29uc2Vy
dmF0aXZlOgo+ICAgKiBJbml0aWFsIHZlcnNpb24gYnkgTWFzYXRha2UgWUFNQVRPIDx5YW1hdG9A
cmVkaGF0LmNvbT4KPiAKCkdvdCBpdC4gIFRoYW5rcy4KCi0tClJ1YW4uCgo+IEtpbmQgcmVnYXJk
cywKPiBQZXRyCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
