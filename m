Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F81DC54E60
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 01:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710466251; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Sien5IwEyiIngQoPokhyRnOT6777EiB4/hJg/PPlI/s=;
 b=l6+e06Lp8ihSvUuKPQWIkAWZ4A4zF6xC9LRmHq/7OWsT60S2d5YvmiSKk1WG7r96ZMge2
 8gpkW2e2DMUXC6gFVMGV0rxG/k5pMdZ8UcKQuFbSwSV6Dt3i0vaNN8wQt00+iRkF7HI5Fvm
 ML4dLJW5TB0PH6/z4tpSv+TDHNkg94I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 50DB33D0A32
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 02:30:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F88D3CF38F
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 02:30:29 +0100 (CET)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com
 [IPv6:2a00:1450:4864:20::62d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A063E600842
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 02:30:28 +0100 (CET)
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-a46805cd977so53736566b.0
 for <ltp@lists.linux.it>; Thu, 14 Mar 2024 18:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710466228; x=1711071028; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Ln9xkz1/v5eXvYQe62SBiwJ6U2YXm0AcOcpot3zajHw=;
 b=MnYvagrpPdJSQttqajnlrMPS70sX8/W8W920zZgWPBW3/ka2KmBp1QH3fEc6y8guyt
 OE0840fekuhQqup71Sy5blp9X+X8OKNyuiSCEI35pyxGbTLs6hlUDCwT/BpFANtpDblm
 uvOlqewtp8ziQfR7mTnJFt7z6WSQpwBGICebQnTnrk6s0gOO7vxtnl1rwWaxlkPRjHB9
 mP5LDKQuZha58R9SDOZjrqWWfpkMxs0GITOO1lxA1WxDysPy93Yw7XsCTgaIlqjIJqXu
 l90+I1QGhz6nbassHf2GTXtjgBWXez/drxvigAIuXjEzn7/keZQWtSwuJkXEfDkm3U3J
 M1iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710466228; x=1711071028;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ln9xkz1/v5eXvYQe62SBiwJ6U2YXm0AcOcpot3zajHw=;
 b=GQmFTPDR1+fZkxydxi81VNkd4NVZSe0QwZmWcUXL4nK56mX0Z1RBs/f3ANc0CeLdLE
 V3e5LX/r9rRMXc6zMo+Gciw3ffStZF4uk0iq81mmr+eop/04SYWISMfG3rS9x5pmi2SN
 25aNZ+hLvqoqb8M6bJjqu0jEtRfw4YKfjGMGWkgE/GI34ko23KCj6tpPcdJGh8wiZE4O
 qfsaKWHNV59Ddv5QuIvGzKYAKk86Rsjmx87GtKnaDI4wWyoLAd7X/S34Oiefi1QyirN+
 RYWQHjbGdTtdqVf85TaRm+PanS/gqOFAOtH6Z1N5mxcRZWdyzHVeLjVhQc0LBkuY6xYa
 TrYg==
X-Gm-Message-State: AOJu0Yz7/rxBmh//MCN7kLzGe5JS1iBXDEDF06v9BLnleiwvak06sQFa
 3es5MFrInHHsdVPAFT5aJdL9QIzN7eNKGBNbQz4lxLhLAueFPDjl8aCrn4MRcQ==
X-Google-Smtp-Source: AGHT+IHtI+m6VyHMb24/87UoVedakHQn/BYoAxgywT3SEPNe2HtQ2v4P4xETYUDKdorv+JghsmSsqA==
X-Received: by 2002:a17:906:f190:b0:a46:74f0:6380 with SMTP id
 gs16-20020a170906f19000b00a4674f06380mr878140ejb.3.1710466227938; 
 Thu, 14 Mar 2024 18:30:27 -0700 (PDT)
Received: from wegao.68.199.193 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 go34-20020a1709070da200b00a44180ab871sm1195791ejc.50.2024.03.14.18.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Mar 2024 18:30:27 -0700 (PDT)
Date: Thu, 14 Mar 2024 21:30:21 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZfOkrcg5Kt9l59Ss@wegao.68.199.193>
References: <20240314013320.5536-1-wegao@suse.com>
 <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dn7zRijqq-ZmxsS7CSh2__dzVzpP9ZsPh3APmYWvu=mg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] swapon01.c: Apply a margin to avoid oom
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

T24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgMDI6NDA6NDBQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBIaSBXZWksCj4gCj4gT24gVGh1LCBNYXIgMTQsIDIwMjQgYXQgOTozM+KAr0FNIFdlaSBHYW8g
dmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiAKPiA+IER1cmluZyBvdXIgdGVz
dCBpIGZpbmQgYSBvb20gZXJyb3IgZHVyaW5nIHRlc3Qgd2hpY2ggdHJpZ2dlcmVkIGJ5Cj4gPiB0
c3RfcG9sbHV0ZV9tZW1vcnkuCj4gPgo+ID4ga2VybmVsOgo+ID4gb29tLWtpbGw6Y29uc3RyYWlu
dD1DT05TVFJBSU5UX01FTUNHLG5vZGVtYXNrPShudWxsKSxjcHVzZXQ9LyxtZW1zX2FsbG93ZWQ9
MC0xLG9vbV9tZW1jZz0vbHRwL3Rlc3QtOTU1Mix0YXNrX21lbWNnPS9sdHAvdGVzdC05NTUyMAo+
ID4ga2VybmVsOiBNZW1vcnkgY2dyb3VwIG91dCBvZiBtZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDk1
NzUgKHN3YXBvbjAxKQo+ID4gdG90YWwtdm06MTA1MTQ4NGtCLCBhbm9uLXJzczoxMDQ2NTcya0Is
IGZpbGUtcnNzOjEyODBrQiwgc2htZW0tcnNzOjBrMAo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFdl
aSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+ID4gLS0tCj4gPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9zd2Fwb24vc3dhcG9uMDEuYyB8IDQgKysrLQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ID4gYi90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gPiBpbmRleCBkNDA2ZTRiZDkuLjM1Nzk5MjUy
NSAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBv
bjAxLmMKPiA+ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAx
LmMKPiA+IEBAIC00MSw3ICs0MSw5IEBAIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCj4gPiAgICAg
ICAgIG1ha2Vfc3dhcGZpbGUoU1dBUF9GSUxFLCAxMCwgMCk7Cj4gPgo+ID4gICAgICAgICBTQUZF
X0NHX1BSSU5URih0c3RfY2csICJjZ3JvdXAucHJvY3MiLCAiJWQiLCBnZXRwaWQoKSk7Cj4gPiAt
ICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9jZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1F
TSk7Cj4gPiArCj4gPiArICAgICAgIC8qIEFwcGx5IGEgbWFyZ2luIHRvIGF2b2lkIG9vbSBkdXJp
bmcgdHN0X3BvbGx1dGVfbWVtb3J5ICovCj4gPiArICAgICAgIFNBRkVfQ0dfUFJJTlRGKHRzdF9j
ZywgIm1lbW9yeS5tYXgiLCAiJWx1IiwgVEVTVE1FTSArIFRFU1RNRU0vMTAwKTsKPiA+Cj4gCj4g
RXZlbiB3aXRoIGEgYml0IG9mIG1hcmdpbiBhZGRlZCB0aGVyZSBpcyBzdGlsbCBub3QgZ3VhcmFu
dGVlIHRvIGF2b2lkIE9PTQo+IGNvbXBsZXRlbHkuCj4gCj4gQXMgdGhlIENncm91cCBWMSBhbmQg
VjIgdHJhY2sgbWVtb3J5IGFuZCBzd2FwIGluIHR3byB3YXlzLCBpZiB0aGUgbWFyZ2luIGlzCj4g
dG9vIGxhcmdlIHRoYXQgbWlnaHQgbm90IG1ha2UgdGhlIHN3YXAgaGFwcGVuIHdoaWNoIGlzIG5v
dCBvdXIgZXhwZWN0YXRpb24uCj4gCj4gU28gb3RoZXIgbWV0aG9kIEkgY2FuIHRoaW5rIG9mIGlz
IHRvIGRpc2FibGUgdGhlIE9PTSBpbiBDZ291cCwKPiAgICAgZWNobyAxID4gbWVtb3J5Lm9vbV9j
b250cm9sClRoaXMgb3B0aW9uIG5vdCBleGlzdCBpbiBjZ3JvdXB2MiwgaXQgc2VlbXMgbm8gZGly
ZWN0IG9vbSBjb250cm9sIGZvciBjZ3JvdXB2Mgo+IG9yLCBzZXQgYG92ZXJjb21taXRfbWVtb3J5
YCB0byAyIHRvIHByZXZlbnQgdGhlIE9PTSBmcm9tIG9jY3VycmluZy4KPiAgICAgZWNobyAyID4g
L3Byb2Mvc3lzL3ZtL292ZXJjb21taXRfbWVtb3J5CkkgaGF2ZSB0cmllZCB0aGlzIG9wdGlvbiwg
b29tIHN0aWxsIGhhcHBlbi4KPiAKPiAKPiAKPiAKPiA+ICB9Cj4gPgo+ID4gIHN0YXRpYyBzdHJ1
Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+IC0tCj4gPiAyLjM1LjMKPiA+Cj4gPgo+ID4gLS0KPiA+
IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+
ID4KPiA+Cj4gCj4gLS0gCj4gUmVnYXJkcywKPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
