Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F19D6E77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 08:52:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 778203C2032
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 09:52:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 328733C1D6B
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 09:51:50 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 56FD41BBF4BA
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 09:51:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736412707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/cjnnPjKdzpQKvRYW0aXVaoeKzR4Fzlz1lBvZygRCgQ=;
 b=PPvN98c7pH+85zhiB0HbPOm7ACOmWd1pT/RXyaxkiVdlDvaOh95NV1p43cTjOk2PkqFeDF
 8DtB4USl3XXNB/RFp6+Z7ZnVGrzjSicPKK9rAE4tOG2BQHut5Pf93+RnG3unBGbkLjAls7
 1uCftma1j9kVVlEtu4PW4LeO4XTZlrM=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-zdx4zlHzPwK91lVpxQcgJw-1; Thu, 09 Jan 2025 03:51:45 -0500
X-MC-Unique: zdx4zlHzPwK91lVpxQcgJw-1
X-Mimecast-MFC-AGG-ID: zdx4zlHzPwK91lVpxQcgJw
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-aa67f18cb95so66741266b.1
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 00:51:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736412704; x=1737017504;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/cjnnPjKdzpQKvRYW0aXVaoeKzR4Fzlz1lBvZygRCgQ=;
 b=YCqYgEDxtQDJEZIupCQ3zqbG9FXiFiKxDHOWNZCHiZunuLb8pWSUIxusfeKKJvlfIz
 VQ9PelVl0F7OEgeSaUB+n9bJ+u7LIjup6K6L4JSfnBKna3kiPx5mj/CebH/0x0Ecny6J
 ZLtxuiVuft6P8kpq/Zhl89qyuqg2bX8t42eLEVvHAypS9kFLuFyP/yf6IoVyaZzDl0bV
 vd0mxvXYveb1t/dO5T4j8g194evvJJePsqaKf97WUJ3pz7JC/MLmD2r/ARx/e5BbRhCY
 cQtQodR4t3f13e6yXRdPaylhMkv5ZhGIYRVlWdiupdFAC3ZYoXT4Y3dvIRbo0erfsN8U
 ibNg==
X-Gm-Message-State: AOJu0Yzaq1mb26tIowyiq7rhnCuA+V2WMeenguRj3m0tIphTyxhjjiEp
 +T+x6ufiJkATZaz3k5PnTdDP8CBFCQ6I2g3QVVpp2V3SE+fOzglyo62sOZMemUevBkzk6yWzsPD
 9sm3S44cdE1RmQGubLg9WY6+KulEcZtcVytX1vzvZurYwS1AkhWSeyXaMtemao2rupnGZcUz0OT
 9M0E4bgBvqjxeoSnb4Mdr5++Y=
X-Gm-Gg: ASbGncsF50btOnp/QDSK3+Dv3FhKmWl1rDOBAddn9vXi2e8G1Jr0MStUhV5QHwG0l+7
 SUf42oRyAxtk1xrDI3V+o6i+9EggjJd+efTYPRsc=
X-Received: by 2002:a17:907:9d18:b0:ab2:c0c8:383f with SMTP id
 a640c23a62f3a-ab2c0c83980mr256711366b.1.1736412704431; 
 Thu, 09 Jan 2025 00:51:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEEsX49CNIYcQVlnS/n45Uv/a7FZoQ074n3HcUG/IizevMV+19HZrVfFC5k9nhtc5cXKMqhhCqJGU0j3Iudq7w=
X-Received: by 2002:a17:907:9d18:b0:ab2:c0c8:383f with SMTP id
 a640c23a62f3a-ab2c0c83980mr256708566b.1.1736412704012; Thu, 09 Jan 2025
 00:51:44 -0800 (PST)
MIME-Version: 1.0
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
 <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
 <Z35wmODIV_vuYBOA@rei>
 <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
 <Z39_3BKj3d3nbfau@rei.lan>
 <CAEemH2c0ur5W=ntte7mamqMSC_GtH4Lb3W=cob-h8OPMYU=o1w@mail.gmail.com>
In-Reply-To: <CAEemH2c0ur5W=ntte7mamqMSC_GtH4Lb3W=cob-h8OPMYU=o1w@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 16:51:28 +0800
X-Gm-Features: AbW1kvZpdxEssuRevNkBl_gkFoGbjZ5VCA5sCwCC4D7MPU-AzZJnPoNEqrqqbHY
Message-ID: <CAEemH2epi7XZiPXP=NOQpV0rLpOT7dxt8eoadZg5RR3r5c=mwA@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dhHF-Rz39_FUIn3quF3_r_eh_mWVGrrY3sYyXdmk0ww_1736412704
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gOSwgMjAyNSBhdCA0OjQy4oCvUE0gTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+IHdyb3RlOgoKPgo+Cj4gT24gVGh1LCBKYW4gOSwgMjAyNSBhdCAzOjQ24oCvUE0gQ3lyaWwg
SHJ1YmlzIDxjaHJ1YmlzQHN1c2UuY3o+IHdyb3RlOgo+Cj4+IEhpIQo+PiA+IEkgaGF2ZSBhIGRp
ZmZlcmVudCB2aWV3IG9uIHRoZSByZWFkYWhlYWQwMiB0ZXN0LCBiZWNhdXNlIHRoZSBydW50aW1l
Cj4+ID4gcmVzZXR0aW5nIGlzIGJhc2VkIG9uIHBpZWNlcyBvZiBlYWNoIElPIHRlc3QgZWxhcHNl
ZCB0aW1lLCB0aGVuIHJlc2V0Cj4+ID4gcnVudGltZSBmb3IgbmV4dCB0aW1lLiBUaGlzIGFwcGxp
ZXMgdG8gYW55IGtlcm5lbHMsIG5vIG1hdHRlciB0aGUgZmFzdGVyCj4+ID4gb3Igc2xvd2VyLCB0
aGUgZWxhcHNlZCB0aW1lIHdpbGwgYmUgZW5vdWdoIGZvciB0aGUgbmV4dCB0Y2FzZXNbXS4KPj4g
Pgo+PiA+IElmIHdlIHB1dCB0aGUgd29yc3QtY2FzZSBydW50aW1lIGludG8gLnRpbWVvdXQgYW5k
IHJlc2V0IGZvciB0aGUgbmV4dAo+PiA+IHRjYXNlc1tdLCB3aGljaCB3aWxsIGJlIG11bHRpcGxp
ZWQgYWdhaW4gb24gZGVidWcga2VybmVsLCBhY3R1YWxseSB3ZQo+PiA+IGRvbid0IG5lZWQgdGhh
dCBzaW5jZSB0aGUgZHluYW1pYyBydW50aW1lIGNvbWVzIGZyb20gYSByZWFsIHRlc3QuCj4+Cj4+
IEkgZG8gbm90IGdldCB3aHkgd2UgbmVlZCB0byByZXNldCBhbnl0aGluZy4gVGhlIHRlc3QgbGli
cmFyeSBkb2VzIHJlc2V0Cj4+IHRoZSB0aW1lb3V0IGFmdGVyIGVhY2ggdGVzdCBpdGVyYXRpb246
Cj4+Cj4+ICAgICAgICBmb3IgKGkgPSAwOyBpIDwgdHN0X3Rlc3QtPnRjbnQ7IGkrKykgewo+PiAg
ICAgICAgICAgICAgICAgc2F2ZWRfcmVzdWx0cyA9ICpyZXN1bHRzOwo+PiAgICAgICAgICAgICAg
ICAgaGVhcnRiZWF0KCk7Cj4+ICAgICAgICAgICAgICAgICBeCj4+ICAgICAgICAgICAgICAgICB0
aGlzIHJlc2V0cyB0aGUgdGltZW91dCB0aW1lciBzbyBlYWNoIGl0ZXJhdGlvbiBydW5zCj4+ICAg
ICAgICAgICAgICAgICB3aXRoIHRoZSB3aG9sZSB0aW1lb3V0Cj4+Cj4+ICAgICAgICAgICAgICAg
ICB0c3RfdGVzdC0+dGVzdChpKTsKPj4KPj4gICAgICAgICAgICAgICAgIGlmICh0c3RfZ2V0cGlk
KCkgIT0gbWFpbl9waWQpCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIGV4aXQoMCk7Cj4+Cj4+
ICAgICAgICAgICAgICAgICB0c3RfcmVhcF9jaGlsZHJlbigpOwo+Pgo+PiAgICAgICAgICAgICAg
ICAgaWYgKHJlc3VsdHNfZXF1YWwoJnNhdmVkX3Jlc3VsdHMsIHJlc3VsdHMpKQo+PiAgICAgICAg
ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAiVGVzdCAlaSBoYXZlbid0IHJlcG9ydGVk
Cj4+IHJlc3VsdHMhIiwgaSk7Cj4+ICAgICAgICAgfQo+Pgo+Cj4gWWVzLCB0aGF0J3MgcmlnaHQu
Cj4KPgo+PiA+IE1heWJlIEkgbWlzc2VkIHNvbWV0aGluZyBpbiB0aGUgdGVzdCwgYnV0IHdlIGNh
biB0cmVhdCByZWFkYWhlYWQwMgo+PiA+IGluIGEgc2VwYXJhdGUgd29yay4gVGhlIG5ldyBwYXRj
aCA0LzQgc2hvdWxkIGJlIG1vZGlmaWVkIHVzaW5nIC5ydW50aW1lCj4+ID4gaW5zdGVhZCBvZiAu
dGltZW91dC4gRmVlbCBmcmVlIHRvIGNvbW1lbnQgeW91ciB0aG91Z2h0cyB0aGVyZS4KPj4KPj4g
V2h5IGlzIHJlYWRhaGVhZDAyIHNvIHNwZWNpYWwgdGhhdCB3ZSBuZWVkIHRvIGRvIG1vcmUgdGhh
biB0aGUgdXN1YWxsPwo+Pgo+PiBUaGF0IGlzOgo+Pgo+PiAtIG1lYXN1cmUgaG93IGxvbmcgb25l
IHRlc3RzIGl0ZXJhdGlvbiB0YWtlcyBvbiBzbG93ZXIgaGFyZHdhcmUKPj4gLSBtdWx0aXBseSB0
aGF0IGJ5IHR3byBhbmQgc2V0IHRoYXQgYXMgYSAudGltZW91dAo+Pgo+Cj4gSSBhZG1pdCB0aGF0
IHRoaXMgaXMgdGhlIHJlY29tbWVuZGVkL3N0YW5kYXJkIHdheSB0byB1c2UgLnRpbWVvdXQKPiBi
YXNlZCBvbiB0aGUgbmV3IHRpbWUgbG9naWMgZGVzaWduLgo+Cj4gUC5zLgo+Cj4gVGhlIHJlYXNv
biBmb3IgY2FsbGluZyB0c3Rfc2V0X3J1bnRpbWUoKSBpbiBlYWNoIGl0ZXJhdGlvbiBpcyB0aGF0
IHdlIGNhbgo+IGRpcmVjdGx5IHV0aWxpemUgdGhlIHJlYWwgZWxhcHNlZCB0aW1lIGFzIHJ1bnRp
bWUgYW5kIGRvbid0IG5lZWQgdG8gZG8KPiBhZGRpdGlvbmFsIG1lYXN1cmVtZW50cy4KPgoKRm9y
Z290IHRvIHNheSwgdGhhdCBlYWNoIGl0ZXJhdGlvbiBoYXMgZm91ciBzdWItdGNhc2VzIHRvIGFj
Y29tcGxpc2guClRoZSByZWNvbW1lbmRlZCB3YXkgKHlvdSBnYXZlIGFib3ZlKSBpcyB0byByZWdh
cmQgdGhlbSBhcyBvbmUKYmlnIHRlc3QgYW5kIHJlc2V0IHRpbWVvdXQgYnkgaGVhcnRiZWF0KCkg
aW4gdHN0X3Rlc3QtPnRjbnQuIElmIHRoaXMgdmFsdWUKaXMgYmlnIGVub3VnaCwgdGhhdCdzIGZp
bmUuIEJ1dCBJIGZlYXIgdGhhdCB2YWx1ZSAoY29tZSBmcm9tIG1lYXN1cmVtZW50KQppcyBzdGls
bCBub3QgY292ZXJlZCBhbGwgc2l0dWF0aW9ucy4KCgoKPgo+IFRoYXQgdmFsdWUgKHdoaWNoIGNv
bWVzIGZyb20gYSByZWFsIHRlc3QpIGlzIG1vcmUgcHJlY2lzZSB0aGFuICh3aGF0IHdlCj4gZ2V0
IG9uKSBhbnkgb3RoZXIgc2xvd2VyIGhhcmR3YXJlLiBBbmQgdGhlIGRpc2FkdmFudGFnZSBhcyB5
b3UgcG9pbnRlZAo+IGl0IGluY3JlYXNlcyB0aGUgdGltZW91dCBmb3IgZWFjaCBpdGVyYXRpb24u
Cj4KPiBJIGNhbiBnaXZlIHVwIHRoaXMgdXNhZ2UgYW5kIGZvbGxvdyB5b3VyIHN1Z2dlc3Rpb24s
IGJ1dCBJIHN0aWxsIGZlbGwKPiB0aGF0IHdlIGNvdWxkIGhhdmUgb25lIG1vcmUgd2F5IG9uIC5y
dW50aW1lLgo+Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gTGkgV2FuZwo+CgoKLS0gClJlZ2FyZHMsCkxp
IFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0
aW5mby9sdHAK
