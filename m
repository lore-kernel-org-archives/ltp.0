Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9566CE7B09
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 07:44:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0B28C3CDBF7
	for <ltp@archiver.kernel.org>; Thu, 28 Sep 2023 09:44:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 147093C01D0
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:44:28 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E6A28200C96
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 09:44:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695887065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yCPxmJJzP9qu58oNKk0HrE7KxcRVCwDr2OP6AJT3m40=;
 b=E0sYwKDUxisUirXTsevWOU8mldP7nX8xgQF+EPCEYi0H+1ZmAuJeyYY36yK9YdEB9VHkeB
 m0I8Un8HAs+1e9aOd+Qeg1Z7l+z3vNIcCBxt1ypMCzoLXsITIHLl5uaq4ffinj2Nh5C2R1
 LGcHI+0h+dfxWXR/A+Vd+ZntepuVfWU=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-x5W0K_p1MEew93iT6Vm8Ww-1; Thu, 28 Sep 2023 03:44:22 -0400
X-MC-Unique: x5W0K_p1MEew93iT6Vm8Ww-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-5043353efbdso17898815e87.0
 for <ltp@lists.linux.it>; Thu, 28 Sep 2023 00:44:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695887061; x=1696491861;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yCPxmJJzP9qu58oNKk0HrE7KxcRVCwDr2OP6AJT3m40=;
 b=GoPLK4avnLi4ldaclKxrohPmVWlUDgkxBGGBrA+UjEQx6b6Xn+CVL8b36J12lEVeuw
 Egk9qW/1vFGaofp0GWljwBOGL4dXreoGshMEqUqbbeICvyeEomQSBp8J5MOKoqp/Br73
 /TbEu+AicW2mU9AztAm3Yae28g29+7H7GtDAhOZbAuusFV88iBAkFzakIAIw6D7TO6Gj
 QleUQsL5eG3s1lHUmrSNmPU49ehhCv29uXplSFEsubTwsSYgOUy6pTIPYn7xZAfi7ZLB
 qcuOk65tBOiQdAvAIOGTtGG2L5nma49X6kAdvEO2u7XUeQEwlq28M0UdvuqFXy/GBFEf
 9tmg==
X-Gm-Message-State: AOJu0YxgTdL8bFrXBvnJBTFRJigKhM9sOzlAOVpimqeM2Iy4LBOZ2ko7
 SyA9NKoNr0g8aSnnooUlEcduxNOFfNAjnL+JG7dRNKy8kpx8zd2ybg44H8qrWkHisWSTcfkEzee
 bevGz2nSnpg12Aa6rulcx+yBjh+s=
X-Received: by 2002:a05:6512:2807:b0:4fd:fc36:68a2 with SMTP id
 cf7-20020a056512280700b004fdfc3668a2mr528172lfb.1.1695887061084; 
 Thu, 28 Sep 2023 00:44:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdzAN0uZ1XrTW6vLWORyaePIWWouACru1FFhdLfJvlBx62AwAk95pix6a+rgQDIpcV9rvTiSt3g0knPi+ET8Q=
X-Received: by 2002:a05:6512:2807:b0:4fd:fc36:68a2 with SMTP id
 cf7-20020a056512280700b004fdfc3668a2mr528160lfb.1.1695887060717; Thu, 28 Sep
 2023 00:44:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZQF5J0UJ25_QLwcQ@yuki> <20230926105011.GA133737@pevik>
In-Reply-To: <20230926105011.GA133737@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 28 Sep 2023 15:44:08 +0800
Message-ID: <CAEemH2cb-asn5VSnpSCusS-Rb187T_mjOrBqH722_c3KaAF=LQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFR1ZSwgU2VwIDI2LCAyMDIzIGF0IDY6NTDigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IEhpIHRlc3RpbmcgY29tbXVuaXR5LAo+Cj4gPiBIaSEK
PiA+IEFzIHVzdWFsbCB3ZSBhcmUgc3VwcG9zZWQgdGhlIHJlbGVhc2UgTFRQIGF0IHRoZSBlbmQg
b2YgdGhlIG1vbnRoLiBJbgo+ID4gb3JkZXIgdG8gZ2V0IGF0IGxlYXN0IHR3byB3ZWVrcyBvZiBw
cmUtcmVsZWFzZSB0ZXN0aW5nIEkgd291bGQgbGlrZSB0bwo+ID4gZnJlZXplIHRoZSBnaXQgc3Rh
cnRpbmcgbmV4dCB3ZWVrLiBJIHdpbGwgdHJ5IHRvIHJldmlldyBhbmQgbWVyZ2UgYXMKPiA+IG11
Y2ggYXMgcG9zc2libGUgdGlsbCB0aGUgZW5kIG9mIHRoaXMgd2Vlay4gSWYgdGhlcmUgaXMgYW55
dGhpbmcgdGhhdAo+ID4geW91IHRoaW5rIHNob3VsZCBnbyBpbnRvIHRoZSByZWxlYXNlIGxldCBt
ZSBrbm93IHNvIHRoYXQgSSBjYW4gaGF2ZSBhCj4gPiBsb29rLgo+Cj4gRllJIHdlIHBsYW4gdG8g
cmVsZWFzZSBMVFAgdGhpcyB3ZWVrIG9uIEZyaWRheS4gSXQncyBub3QgbXVjaCB0aW1lIGxlZnQs
Cj4gYnV0IGlmCj4geW91IGhhdmUgdGltZSwgcGxlYXNlIHRyeSB0byBkbyBzb21lIExUUCBwcmUt
cmVsZWFzZSB0ZXN0aW5nIG9uIHlvdXIKPiBmYXZvdXJpdGUKPiBkaXN0cm8uCj4KCkFDSy4KCk15
IHByZS1yZWxlYXNlIHRlc3QgcmVzdWx0IGxvb2tzIGdvb2Qgb24gb3VyIFJIRUw4LzkuIEp1c3Qg
c29tZSBtaW5vcgplcnJvci90aW1lZG91dCBpc3N1ZSB3aGljaCBoYXZlIGFscmVhZHkgYmVlbiB0
cmFja2VkLgoKKFRoYW5rcyBmb3IgeW91ciB3b3JrIG9uIHRoZSByZWxlYXNlLCBJJ20gYWxyZWFk
eSBvbiB2YWNhdGlvbiB0aGlzIHdlZWssCnNwZWNpYWxseSBjb21lIHRvIHJlcGx5IHRvIHlvdSBm
b3IgYWRkaW5nIGNvbmZpZGVuY2UgaW4gdGhlIG5ldyBwYWNrYWdlOikuCgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
