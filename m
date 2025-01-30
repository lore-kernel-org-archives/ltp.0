Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D8B1C0218A
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 12:07:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C7193C799D
	for <ltp@archiver.kernel.org>; Thu, 30 Jan 2025 13:07:53 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BEF253C6E57
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 08:40:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gaisler.com (client-ip=94.231.106.210; helo=smtp-out3.simply.com;
 envelope-from=andreas@gaisler.com; receiver=lists.linux.it)
Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 84548655CB5
 for <ltp@lists.linux.it>; Thu, 30 Jan 2025 08:39:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by smtp.simply.com (Simply.com) with ESMTP id 4Yk9sV3lT8z1DHYg;
 Thu, 30 Jan 2025 08:39:58 +0100 (CET)
Received: from [192.168.0.25] (h-98-128-223-123.NA.cust.bahnhof.se
 [98.128.223.123])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by smtp.simply.com (Simply.com) with ESMTPSA id 4Yk9sV1xJJz1DHYN;
 Thu, 30 Jan 2025 08:39:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
 s=unoeuro; t=1738222798;
 bh=F7bUHXRk5k4/l7b72dZ1zNsdITh5AVlOZge71JzQHPI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=fLjE/jMrCCZQwrXCG05EfWvPQQBmcpFrPfZJqIiwqawnE4JyLV5aid1Egn9Nnxgfx
 3MKrYD9G2QFa5wk7rhbs/5z14WupKi6LnaZoTYMvmZTNyizTVDNMZFGhDwWsl/fQEY
 VEQd9gI/5nUark6FLWNr1jz4bu1VVlFlZs+YzTCA=
Message-ID: <d834befe-ea59-40a8-94b2-58e992e4afdf@gaisler.com>
Date: Thu, 30 Jan 2025 08:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <petr.vorel@gmail.com>, buildroot@buildroot.org
References: <20240226155137.25523-1-mdoucha@suse.cz>
 <20250129214219.GA447474@pevik>
Content-Language: en-US
From: Andreas Larsson <andreas@gaisler.com>
In-Reply-To: <20250129214219.GA447474@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 30 Jan 2025 13:07:19 +0100
Subject: Re: [LTP] [PATCH] ioctl02: Use correct termios structure
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
Cc: James Hilliard <james.hilliard1@gmail.com>,
 Mike Gilbert <floppym@gentoo.org>, ltp@lists.linux.it,
 sparclinux@vger.kernel.org, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjAyNS0wMS0yOSAyMjo0MiwgUGV0ciBWb3JlbCB3cm90ZToKPiBIaSBhbGwsCj4gCj4gRllJ
IHRoaXMgTFRQIGNvbW1pdCBtZXJnZWQgYXMgNjk3YTA2YTgyNyBbMV0gd2hpY2ggaXMgbmVlZGVk
IHRvIGZpeCBpb2N0bDAyLmMKPiB0ZXN0IG9uIHBwYzY0bGUgb24gYWxsIGtlcm5lbCB2ZXJzaW9u
cyBicmVha3MgY29tcGlsYXRpb24gb24gQnVpbGRyb290Cj4gYm9vdGxpbi1zcGFyYzY0LWdsaWJj
IHRvb2xjaGFpbiAoZ2NjOiAxMy4zLjAsIGtlcm5lbCBoZWFkZXJzOiA0LjE5LjI1NSwgZ2xpYmM6
IDIuMzkpOgo+IAo+IAlJbiBmaWxlIGluY2x1ZGVkIGZyb20gYnItdGVzdC1wa2cvYm9vdGxpbi1z
cGFyYzY0LWdsaWJjL2hvc3Qvc3BhcmM2NC1idWlsZHJvb3QtbGludXgtZ251L3N5c3Jvb3QvdXNy
L2luY2x1ZGUvc3lzL2lvY3RsLmg6MjksCj4gCQkJCQkgZnJvbSAuLi8uLi8uLi8uLi9pbmNsdWRl
L2xhcGkvaW9jdGwuaDoxMSwKPiAJCQkJCSBmcm9tIGlvY3RsMDIuYzozMToKPiAJYnItdGVzdC1w
a2cvYm9vdGxpbi1zcGFyYzY0LWdsaWJjL2hvc3Qvc3BhcmM2NC1idWlsZHJvb3QtbGludXgtZ251
L3N5c3Jvb3QvdXNyL2luY2x1ZGUvYml0cy9pb2N0bC10eXBlcy5oOjM2Ojg6IGVycm9yOiByZWRl
ZmluaXRpb24gb2Yg4oCYc3RydWN0IHRlcm1pb+KAmQo+IAkgICAzNiB8IHN0cnVjdCB0ZXJtaW8K
PiAJCSAgfCAgICAgICAgXn5+fn5+Cj4gCUluIGZpbGUgaW5jbHVkZWQgZnJvbSBpb2N0bDAyLmM6
Mjk6Cj4gCWJyLXRlc3QtcGtnL2Jvb3RsaW4tc3BhcmM2NC1nbGliYy9ob3N0L3NwYXJjNjQtYnVp
bGRyb290LWxpbnV4LWdudS9zeXNyb290L3Vzci9pbmNsdWRlL2FzbS90ZXJtYml0cy5oOjE3Ojg6
IG5vdGU6IG9yaWdpbmFsbHkgZGVmaW5lZCBoZXJlCj4gCSAgIDE3IHwgc3RydWN0IHRlcm1pbyB7
Cj4gCj4gVGhlIHByb2JsZW0gaXMgd2l0aCBrZXJuZWwgPGFzbS90ZXJtYml0cy5oPiBpbmNvbXBh
dGliaWxpdHkgd2l0aCBnbGliYwo+IDxiaXRzL2lvY3RsLXR5cGVzLmg+IGluY2x1ZGVkIHZpYSA8
c3lzL2lvY3RsLmg+IHdoaWNoIGlzIG5lZWRlZCBieSBpb2N0bDAyLmMKPiBhbmQgYWxzbyBieSBM
VFAgbGlicmFyeSBpbmNsdWRlL3NhZmVfbWFjcm9zX2ZuLmguCj4gCj4gVGhpcyBwcm9ibGVtIHdh
cyBmaXhlZCBhIHllYXIgYWdvIGluIGtlcm5lbCB2Ni4xMC1yYzEgaW4gY29tbWl0IGMzMmQxOGU3
OTQyZAo+ICgic3BhcmM6IG1vdmUgc3RydWN0IHRlcm1pbyB0byBhc20vdGVybWlvcy5oIikgWzJd
Lgo+IAo+IEJlY2F1c2Ugbm9ib2R5IG5vdGljZWQgdGhpcyBjaGFuZ2UgSSBzdXBwb3NlIG5vYm9k
eSB1c2VzIExUUCBvbiBzcGFyYzY0Cj4gb3IgcGVvcGxlIGNvbXBpbGUgTFRQIG9uIHNwYXJjNjQg
d2l0aCBuZXcga2VybmVsIGhlYWRlcnMuCj4gCj4gQEN5cmlsIEBNYXJ0aW4gRllJIGFub3RoZXIg
ZXhhbXBsZSBvZiBjb25mbGljdGluZyBnbGliYyBhbmQga2VybmVsIGhlYWRlcnMgKG5vdAo+IGxp
c3RlZCBpbiBbM10pLiBJTUhPIG5vdGhpbmcgdG8gYmUgZG9uZSBvbiBMVFAgc2lkZSB1bmxlc3Mg
d2UgY2FuIG1hZ2ljYWxseSBwdXQKPiBiYWNrIDx0ZXJtaW9zLmg+IGFuZCBoYXZlIHBwYzY0bGUg
d29ya2luZyB3aXRoIGl0Lgo+IAo+IEBCdWlsZHJvb3QgQXMgSSB3cm90ZSwgYmVjYXVzZSBMVFAg
bmVlZHMgdGhpcyBmaXggZm9yIHBwYzY0bGUgKGFyY2ggYWN0dWFsbHkKPiB0ZXN0ZWQgYnkgTFRQ
IGRldmVsb3BlcnMpLCB0aGUgb25seSBzb2x1dGlvbiBmb3IgQnVpbGRyb290IGlzIHRvIHJlcXVp
cmUKPiB0b29sY2hhaW4gYmFzZWQgb24gdjYuMTAga2VybmVsIGhlYWRlcnMgZm9yIHNwYXJjNjQg
KHF1aXRlIGEgYmlnIGxpbWl0YXRpb24gZm9yCj4gc2V2ZXJhbCBjcm9zcyBjb21waWxhdGlvbiB0
b29sY2hhaW4sIHNvbWUgYXJlIGJhc2VkIG9uIDQuMTkga2VybmVsIGhlYWRlcnMsCj4gNS4xMSBy
ZXF1aXJlbWVudCBmb3IgbXVzbCBlZmZlY3RpdmVseSBkaXNhYmxlcyBMVFAgb24gQnVpbGRyb290
IG9uIG11c2wpLgo+IAo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4gCj4gWzFdIGh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2NvbW1pdC82OTdhMDZhODI3OTc4ODg3ZTRj
ODg3MTBkYzdkMzFkNmYzZWU4MTZhCj4gWzJdIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQvP2lkPWMzMmQxOGU3
OTQyZDc1ODliNjJlMzAxZWI0MjZiMzI2MjMzNjY1NjUKPiBbM10gaHR0cHM6Ly9zb3VyY2V3YXJl
Lm9yZy9nbGliYy93aWtpL1N5bmNocm9uaXppbmdfSGVhZGVycwoKVGhlIHBhdGNoIGluIFsyXSB3
YXMgYWxzbyBhcHBsaWVkIHRvIHN0YWJsZSBicmFuY2hlcywgc28gaXQgaXMgYWxzbwppbmNsdWRl
ZCBpbiB2Ni42Ljc0LCB2Ni4xLjEyNywgdjUuMTUuMTc3LCB2NS4xMC4yMzMsIGFuZCB2NS40LjI4
OSAKa2VybmVsIHZlcnNpb25zIHRoYXQgYXJlIGN1cnJlbnRseSB1c2VkIGJ5IEJ1aWxkcm9vdCBt
YXN0ZXIuCgpGb3IgdGhlIDQuMTkga2VybmVsIGl0IGlzIGluIHBsYWNlIHNpbmNlIHY0LjE5LjMx
Ni4KCkNoZWVycywKQW5kcmVhcwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
