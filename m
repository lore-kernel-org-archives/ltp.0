Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45083C28B20
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 04:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743135203; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Y+FezzP7dBLAHfK+Gzy1jb2QxQv/7uvqhQKs7B/CEaY=;
 b=f4Njxvp9WJZrNwBvaTbPh38B0ib3VcMFfTgDMxPRASmi59LKfAljD3qLg61p7fFNoHMsd
 ksoD4sLreFnVnvwwdUW38V1DVV2OzVmJ4P6wBIYJ/hugxaQLRXHhkj2091+koZ+CZuAkLc9
 4fA+/wM8Tn7kk/+DUUDFxNfweV+X3EA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2788F3CA20B
	for <ltp@archiver.kernel.org>; Fri, 28 Mar 2025 05:13:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EC583CA081
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 05:13:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 56A9E6022DF
 for <ltp@lists.linux.it>; Fri, 28 Mar 2025 05:12:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743135178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ISVgNfmnmDFLuaa5TDMbs1kyyoepwkiH0BPrkr2c6X0=;
 b=KTUxgN6cazbM4HLYzuyZccNsK6FV3tOoZnJIEHi2P24Otsv158rjPSur47UQa/ZCG9LgXA
 tEuDut9uK91kOMVUu5EcfJQAPZpppOu5QoQKjq+8m0kqSV8IYScq7anMghUxmSkUyC+UzA
 fmSzEHTWICXjanKSCiDgC0mtU0bOp7U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-kytRCKtjO7uV81vqmwVShQ-1; Fri, 28 Mar 2025 00:12:55 -0400
X-MC-Unique: kytRCKtjO7uV81vqmwVShQ-1
X-Mimecast-MFC-AGG-ID: kytRCKtjO7uV81vqmwVShQ_1743135174
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-5e6136633b1so1520582a12.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 21:12:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743135174; x=1743739974;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ISVgNfmnmDFLuaa5TDMbs1kyyoepwkiH0BPrkr2c6X0=;
 b=qonV+xCxmtWfXwUB57FlPHpW2ChZ8nXiLMYYaMd4Y51uUj/E9osb3Emipg8bd0iu+M
 WN+9MHFCp5dXyBpCIPu/IIqIHq2Lryh5ZXCp5+jq1ggGwNGAIu6u05M6+zNGSaQtvT4l
 VViNzSOzZj4Ew9UgNIAryfBHSeP8bI/dJ7QoaeZpuH17bXlDr1LJ/gYxWlnVyiGoDGle
 TTmn4eKExUcOw/YevgOETjzz1QshJyFhfXIquopFaJfWGGPn4GoNUHWFmbaLeLE6L3eQ
 El+Fzx/GdcVO8MVO7PYEkmtTIAnphaKxMzRF9LqonZ85P8zDoUBiKIpxDW07V0IMr7TO
 5NZg==
X-Gm-Message-State: AOJu0Yz42EcpIA/2gZY5Qbb09Iz8xV/tp11XQbYkff/GglfuRtdFQK1Y
 D1KNHjygTyEdEZZklnR8saBVTXoDbNQEMpZGxa8gzhhMifLJ8K8HDlkoBdvpaSJsfmbzl28yCkd
 89ZMzThpJ5yb7k7aWF5HVG/eSCcUH5aE2hMyc1VJUkLJrF9DX3CJa/uH+9HoTGCzVNCL3fWrSkl
 XCJbZZpKbXzpYh++vA0X6pDcI=
X-Gm-Gg: ASbGncvy8grB1/ZljdHqhPpAOfRaAk6gOuGcWZDQLXpPejcnEOY/QOzQsGC7u0lTUEv
 XfVAXNeJ9VFXXrmmrz8EBZtXnTVlgRhGFGgIPdVaGiMsi9F0UR2syqRgAmBvzKiUTRTl6UdYwGw
 ==
X-Received: by 2002:a17:907:9692:b0:ac4:4d6:ea0a with SMTP id
 a640c23a62f3a-ac6faeedcc1mr548293366b.27.1743135174044; 
 Thu, 27 Mar 2025 21:12:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGI9MFJNU/P0XD5A+5lZ7lDTW1jsbIYv25kHh3p4tRha1NXbD7VvmN2iHTurXX7TD/QNgHD1frLKIJ8v8Ksg68=
X-Received: by 2002:a17:907:9692:b0:ac4:4d6:ea0a with SMTP id
 a640c23a62f3a-ac6faeedcc1mr548291566b.27.1743135173489; Thu, 27 Mar 2025
 21:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <20250327200044.4104125-1-tjmercier@google.com>
In-Reply-To: <20250327200044.4104125-1-tjmercier@google.com>
Date: Fri, 28 Mar 2025 12:12:34 +0800
X-Gm-Features: AQ5f1Jo_jPiLuYKfQb8kl_aeov4d59Ba76TTvgcnCPP_wgK0OHuJYUVSQMfDgTM
Message-ID: <CAEemH2czhNJmDykDTGenBNjdnNsOPkCLDCZRHHWcvG_=jBMRQw@mail.gmail.com>
To: "T.J. Mercier" <tjmercier@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MjkROIPmkDTh74afv5KTkQsnj-m0H8hYBL4xOdpHDb4_1743135174
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] memcg_control_test: Disable swapping in test
 cgroup for v2
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: mkoutny@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgMjgsIDIwMjUgYXQgNDowMeKAr0FNIFQuSi4gTWVyY2llciB2aWEgbHRwIDxs
dHBAbGlzdHMubGludXguaXQ+Cndyb3RlOgoKPiBtZW1jZ19jb250cm9sX3Rlc3RfMSBzZXRzIGJv
dGggYSBtZW1vcnkgbGltaXQgYW5kIGEgbWVtc3cvc3dhcCBsaW1pdCB0bwo+IGEgc2luZ2xlIHBh
Z2UsIGFuZCB0aGVuIGFza3MgbWVtX3Byb2Nlc3MgdG8gYWxsb2NhdGUgMiBwYWdlcyBpbiBhbgo+
IGF0dGVtcHQgdG8gY2F1c2UgYSBtZW1jZyBPT00ga2lsbC4gSG93ZXZlciwgaWYgc3dhcHBpbmcg
aXMgZW5hYmxlZCB0aGUKPiBmaXJzdCBwYWdlIGNhbiBiZSBzd2FwcGVkIGJlZm9yZSB0aGUgc2Vj
b25kIGlzIGFsbG9jYXRlZCBjYXVzaW5nIG5laXRoZXIKPiBsaW1pdCB0byBiZSBleGNlZWRlZCBp
biB2MiBzaW5jZSB0aGVyZSBpcyBubyBjb21iaW5lZCBtZW1zdyBjb3VudGVyIGluCj4gdjIuIElu
IHRoaXMgY2FzZSBubyBPT00ga2lsbCB3aWxsIG9jY3VyIHdoaWNoIHJlc3VsdHMgaW4gYSB0ZXN0
IGZhaWx1cmUuCj4gRml4IHRoaXMgYnkgZGlzYWJsaW5nIHN3YXAgaW4gdGhlIHRlc3QgY2dyb3Vw
IGZvciB2MiBpZiBzd2FwIGlzIGVuYWJsZWQsCj4gY2F1c2luZyBib3RoIHBhZ2VzIHRvIGFsd2F5
cyBiZSBhY2NvdW50ZWQgdW5kZXIgdGhlIHNhbWUgY291bnRlciBzdWNoCj4gdGhhdCBtZW1vcnku
bWF4IGNhdXNlcyBhbiBPT00ga2lsbC4KPgo+IEZpeGVzOiBjMGI4MTU3MzYgKCJOZXcgdGVzdGNh
c2UgYWRkZWQgYnkgTmF1ZmFsLiIpCj4gU2lnbmVkLW9mZi1ieTogVC5KLiBNZXJjaWVyIDx0am1l
cmNpZXJAZ29vZ2xlLmNvbT4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPgoKLS0tCj4gIC4uLi9tZW1jZy9jb250cm9sL21lbWNnX2NvbnRyb2xfdGVzdC5zaCAgICAg
ICAgICAgIHwgMTQgKysrKysrKysrKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0Cj4gYS90ZXN0Y2FzZXMva2VybmVs
L2NvbnRyb2xsZXJzL21lbWNnL2NvbnRyb2wvbWVtY2dfY29udHJvbF90ZXN0LnNoCj4gYi90ZXN0
Y2FzZXMva2VybmVsL2NvbnRyb2xsZXJzL21lbWNnL2NvbnRyb2wvbWVtY2dfY29udHJvbF90ZXN0
LnNoCj4gaW5kZXggNjgyODdhNzBjLi43OWIzYTAyYTkgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2Vz
L2tlcm5lbC9jb250cm9sbGVycy9tZW1jZy9jb250cm9sL21lbWNnX2NvbnRyb2xfdGVzdC5zaAo+
ICsrKyBiL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvY29udHJvbC9tZW1jZ19j
b250cm9sX3Rlc3Quc2gKPiBAQCAtMTIsNyArMTIsNiBAQCBUU1RfTkVFRFNfVE1QRElSPTEKPgo+
ICBQQUdFX1NJWkU9JCh0c3RfZ2V0Y29uZiBQQUdFU0laRSkKPgo+IC1UT1RfTUVNX0xJTUlUPSRQ
QUdFX1NJWkUKPiAgQUNUSVZFX01FTV9MSU1JVD0kUEFHRV9TSVpFCj4gIFBST0NfTUVNPSQoKFBB
R0VfU0laRSAqIDIpKQo+Cj4gQEAgLTUwLDEzICs0OSwyMiBAQCB0ZXN0MSgpCj4KPiAgICAgICAg
ICMgSWYgdGhlIGtlcm5lbCBpcyBidWlsdCB3aXRob3V0IHN3YXAsIHRoZSAkbWVtc3dfbWVtb3J5
X2xpbWl0Cj4gZmlsZSBpcyBtaXNzaW5nCj4gICAgICAgICBpZiBbIC1lICIkdGVzdF9kaXIvJG1l
bXN3X21lbW9yeV9saW1pdCIgXTsgdGhlbgo+IC0gICAgICAgICAgICAgICBST0QgZWNobyAiJFRP
VF9NRU1fTElNSVQiIFw+Cj4gIiR0ZXN0X2Rpci8kbWVtc3dfbWVtb3J5X2xpbWl0Igo+ICsgICAg
ICAgICAgICAgICBpZiBbICIkY2dyb3VwX3ZlcnNpb24iID0gIjIiIF07IHRoZW4KPiArICAgICAg
ICAgICAgICAgICAgICAgICAjIHYyIGRvZXMgbm90IGhhdmUgYSBjb21iaW5lZCBtZW1zdyBsaW1p
dCBsaWtlIHYxLgo+ICsgICAgICAgICAgICAgICAgICAgICAgICMgRGlzYWJsZSBzd2FwcGluZyBp
biB2MiBzbyBhbGwgcGFnZXMgZ2V0Cj4gYWNjY291bnRlZCB0byB0aGUgbm9uLXN3YXAgY291bnRl
ci4KPiArICAgICAgICAgICAgICAgICAgICAgICBTV0FQX0xJTUlUPTAKPiArICAgICAgICAgICAg
ICAgZWxzZQo+ICsgICAgICAgICAgICAgICAgICAgICAgICMgU3dhcHBpbmcgY2Fubm90IGJlIGRp
c2FibGVkIHZpYQo+IG1lbXN3LmxpbWl0X2luX2J5dGVzIGluIHYxLgo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICMgQXBwbHkgYSBtZW1zdyBsaW1pdCBpbiB2MSB0byBjYXB0dXJlIGFueSBzd2Fw
cGVkCj4gcGFnZXMKPiArICAgICAgICAgICAgICAgICAgICAgICBTV0FQX0xJTUlUPSRBQ1RJVkVf
TUVNX0xJTUlUCj4gKyAgICAgICAgICAgICAgIGZpCj4gKyAgICAgICAgICAgICAgIFJPRCBlY2hv
ICIkU1dBUF9MSU1JVCIgXD4gIiR0ZXN0X2Rpci8kbWVtc3dfbWVtb3J5X2xpbWl0Igo+ICAgICAg
ICAgZmkKPgo+ICAgICAgICAgS0lMTEVEX0NOVD0wCj4gICAgICAgICB0ZXN0X3Byb2Nfa2lsbAo+
Cj4gLSAgICAgICBpZiBbICRQUk9DX01FTSAtZ3QgJFRPVF9NRU1fTElNSVQgXSAmJiBbICRLSUxM
RURfQ05UIC1lcSAwIF07IHRoZW4KPiArICAgICAgIGlmIFsgJEtJTExFRF9DTlQgLWVxIDAgXTsg
dGhlbgo+ICAgICAgICAgICAgICAgICB0c3RfcmVzIFRGQUlMICJUZXN0ICMxOiBmYWlsZWQiCj4g
ICAgICAgICBlbHNlCj4gICAgICAgICAgICAgICAgIHRzdF9yZXMgVFBBU1MgIlRlc3QgIzE6IHBh
c3NlZCIKPiAtLQo+IDIuNDkuMC40NzIuZ2U5NDE1NWE5ZWMtZ29vZwo+Cj4KPiAtLQo+IE1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
