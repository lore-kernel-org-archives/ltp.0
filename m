Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C2FC77B7C
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 14:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A8733CCA98
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 16:45:36 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B29E3CBDD2
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:45:20 +0200 (CEST)
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk
 [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C8BA81A007E8
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:45:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:
 Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
 bh=2IvLCpHXXheOeCjVvL++yTFINi93KRNQKXrT18+/OaI=; b=ikd3nPjet3xR2jf2aLk/wbAbzb
 362R1jVjxeFpBXnxs11CsQhWkTnTQiZOrq0Kont4nI+ekwDqRdzug0hb6ESg6MX0MBlgu4TxxVidp
 yyXzcJnMjlvPS/Dr1Q15kHYQvFVkGW70jSg2BkEGshEHOtYfKfDKcAHfb4bJBpNRwD0nFKvqOtt5H
 fG3IEC3DmEw6P013mRQ5IcfMVvHAqfWyKTbRYWbOlfkHOy9HO1+DFvUVoVcofMkeGXKGFBzyaahV8
 8W/Qpwci0NWRLGNv3ZZboBBK0N+0tSjzIM7jp+w+vjEqNp7DfzzckhPRFCXXjDMOqXoYSfDCpMhtL
 Q08zJrTw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat
 Linux)) id 1uTiQ7-0000000CuJt-36YE; Mon, 23 Jun 2025 14:45:15 +0000
Date: Mon, 23 Jun 2025 15:45:15 +0100
From: Al Viro <viro@zeniv.linux.org.uk>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20250623144515.GB1880847@ZenIV>
References: <20250622215140.GX1880847@ZenIV>
 <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxioVpa3u3MKwFBibs2X0TWiqwY=uGTZnjDoPSB01kk=yQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] interesting breakage in ltp fanotify10
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
Cc: linux-fsdevel@vger.kernel.org, LTP List <ltp@lists.linux.it>,
 Eric Biggers <ebiggers@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMjMsIDIwMjUgYXQgMDk6MjQ6MjJBTSArMDIwMCwgQW1pciBHb2xkc3RlaW4g
d3JvdGU6Cj4gT24gU3VuLCBKdW4gMjIsIDIwMjUgYXQgMTE6NTHigK9QTSBBbCBWaXJvIDx2aXJv
QHplbml2LmxpbnV4Lm9yZy51az4gd3JvdGU6Cj4gPgo+ID4gICAgICAgICBMVFAgNjc2M2EzNjUw
NzM0ICJzeXNjYWxscy9mYW5vdGlmeTEwOiBBZGQgdGVzdCBjYXNlcyBmb3IgZXZpY3RhYmxlCj4g
PiBpZ25vcmUgbWFyayIgaGFzIGFuIGludGVyZXN0aW5nIGVmZmVjdCBvbiBib3hlbiB3aGVyZSBG
QU5PVElGWSBpcyBub3QKPiA+IGVuYWJsZWQuICBUaGUgdGhpbmcgaXMsIHRzdF9icmsoKSBlbmRz
IHVwIGNhbGxpbmcgLT5jbGVhbnVwKCkuICBTZWUgdGhlCj4gPiBwcm9ibGVtPwo+ID4gICAgICAg
ICBTQUZFX0ZJTEVfUFJJTlRGKENBQ0hFX1BSRVNTVVJFX0ZJTEUsICIlZCIsIG9sZF9jYWNoZV9w
cmVzc3VyZSk7Cj4gPiBpcyBleGVjdXRlZCwgZXZlbiB0aG91Z2gKPiA+ICAgICAgICAgU0FGRV9G
SUxFX1NDQU5GKENBQ0hFX1BSRVNTVVJFX0ZJTEUsICIlZCIsICZvbGRfY2FjaGVfcHJlc3N1cmUp
Owo+ID4gICAgICAgICAvKiBTZXQgaGlnaCBwcmlvcml0eSBmb3IgZXZpY3RpbmcgaW5vZGVzICov
Cj4gPiAgICAgICAgIFNBRkVfRklMRV9QUklOVEYoQ0FDSEVfUFJFU1NVUkVfRklMRSwgIjUwMCIp
Owo+ID4gaGFkbid0IGJlZW4uCj4gPgo+ID4gICAgICAgICBSZXN1bHQ6IGZhbm90aWZ5MTAgb24g
c3VjaCBrZXJuZWwgY29uZmlncyBlbmRzIHVwIHplcm9pbmcKPiA+IC9wcm9jL3N5cy92bS92ZnNf
Y2FjaGVfcHJlc3N1cmUuCj4gCj4gb29wcy4KPiBzdHJhbmdlIGVub3VnaCwgSSBjYW5ub3QgcmVw
cm9kdWNlIGl0IGFzIHNvbWV0aGluZyBpcyBwcmV2ZW50aW5nCj4gemVyb2luZyB2ZnNfY2FjaGVf
cHJlc3N1cmU6Cj4gCj4gZmFub3RpZnkyMy5jOjIzMjogVENPTkY6IGZhbm90aWZ5IG5vdCBjb25m
aWd1cmVkIGluIGtlcm5lbAo+IGZhbm90aWZ5MjMuYzoyNDk6IFRXQVJOOiBGYWlsZWQgdG8gY2xv
c2UgRklMRQo+ICcvcHJvYy9zeXMvdm0vdmZzX2NhY2hlX3ByZXNzdXJlJzogRUlOVkFMICgyMikK
CkhvdyBvbGQgaXMgeW91ciBsdHAgdHJlZT8gIE1pbmUgd2FzIGZyb20gbGF0ZSBNYXkgKDgxZDQ2
MGJhNjczNyAib3ZlcmNvbW1pdF9tZW1vcnk6CkRpc2FibGUgb3B0aW1pemF0aW9uIGZvciBtYWxs
b2MgdG8gcHJldmVudCBmYWxzZSBwb3NpdGl2ZXMiKSBhbmQgSSdtIGRlZmluaXRlbHkgCnNlZWlu
ZyB0aGF0IGJlaGF2aW91ciB3aXRoIGZhbm90aWZ5MjMgYXMgd2VsbC4gIE5vIFRXQVJOLCB0aG91
Z2ggLQpjbWRsaW5lPSJmYW5vdGlmeTIzIgpjb250YWN0cz0iIgphbmFseXNpcz1leGl0Cjw8PHRl
c3Rfb3V0cHV0Pj4+CnRzdF90bXBkaXIuYzozMTY6IFRJTkZPOiBVc2luZyAvdG1wL2x0cC1zSUcx
cmJaTWNRL0xUUF9mYW43UXczR0MgYXMgdG1wZGlyIChleHQyL2V4dDMvZXh0NCBmaWxlc3lzdGVt
KQp0c3RfZGV2aWNlLmM6OTg6IFRJTkZPOiBGb3VuZCBmcmVlIGRldmljZSAwICcvZGV2L2xvb3Aw
Jwp0c3RfdGVzdC5jOjEyMTY6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCBleHQy
IG9wdHM9JycgZXh0cmEgb3B0cz0nJwpta2UyZnMgMS40Ny4yICgxLUphbi0yMDI1KQp0c3RfdGVz
dC5jOjEyMjg6IFRJTkZPOiBNb3VudGluZyAvZGV2L2xvb3AwIHRvIC90bXAvbHRwLXNJRzFyYlpN
Y1EvTFRQX2ZhbjdRdzNHQy9mc19tbnQgZnN0eXA9ZXh0MiBmbGFncz0wCnRzdF90ZXN0LmM6MTk1
MjogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDEzMC0yNzQtZzgxZDQ2MGJhNgp0c3RfdGVzdC5j
OjE5NTU6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjE2LjAtcmMzKyAjMzIgU01QIFBSRUVNUFRf
RFlOQU1JQyBTdW4gSnVuIDIyIDE5OjA2OjU3IEVEVCAyMDI1IHg4Nl82NAp0c3Rfa2NvbmZpZy5j
Ojg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvYm9vdC9jb25maWctNi4xNi4wLXJj
MysnCnRzdF90ZXN0LmM6MTc3MzogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlzIDBo
IDAwbSAzMHMKZmFub3RpZnkuaDoxNzU6IFRDT05GOiBmYW5vdGlmeSBub3QgY29uZmlndXJlZCBp
biBrZXJuZWwKClN1bW1hcnk6CnBhc3NlZCAgIDAKZmFpbGVkICAgMApicm9rZW4gICAwCnNraXBw
ZWQgIDEKd2FybmluZ3MgMAppbmNyZW1lbnRpbmcgc3RvcAo8PDxleGVjdXRpb25fc3RhdHVzPj4+
CmluaXRpYXRpb25fc3RhdHVzPSJvayIKZHVyYXRpb249MSB0ZXJtaW5hdGlvbl90eXBlPWV4aXRl
ZCB0ZXJtaW5hdGlvbl9pZD0zMiBjb3JlZmlsZT1ubwpjdXRpbWU9MCBjc3RpbWU9MQo8PDx0ZXN0
X2VuZD4+PgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xp
c3RpbmZvL2x0cAo=
