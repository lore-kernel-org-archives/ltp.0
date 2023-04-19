Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D13C77B73
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 06:48:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3B1EF3CC02B
	for <ltp@archiver.kernel.org>; Wed, 19 Apr 2023 08:47:58 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB9703CB34A
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 08:47:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE77B1000926
 for <ltp@lists.linux.it>; Wed, 19 Apr 2023 08:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681886865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3OhGPbkdXe5aVLZLYeTNVzn9F5Hu/b16q0ktKcr0NEk=;
 b=dxNisRKXFepdoHS0cr8S5+uxIacbWoBzix4vlkMfoFVCMLM37K7AMrE6WJyvfQ8iz/U6r1
 GV/EpSwH4bXx4sr8cOuQinNCCY0rd5wQtFjye0lxHA7nawfTUv2UPsuTW68vAlKkaojv4M
 fVD6jo1WZjYSyUl0Y0UwVhjEwo7OTPQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-qOp8VA8xPnejuBDf2gjNcQ-1; Wed, 19 Apr 2023 02:47:43 -0400
X-MC-Unique: qOp8VA8xPnejuBDf2gjNcQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3f08900cad7so13049925e9.3
 for <ltp@lists.linux.it>; Tue, 18 Apr 2023 23:47:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681886862; x=1684478862;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3OhGPbkdXe5aVLZLYeTNVzn9F5Hu/b16q0ktKcr0NEk=;
 b=P6yOmr7hH1D6JO+CQM6ZO40yIn0lvxZMe7xUrsdxvtik4rCbIc8oCVcuuDu+e9F/X/
 nlAM7IMd1lf40NJWcdF4GrsacsVaRjHAgfU11PKL+EV8XyJ8eJMJ1vvn1D7xaKjmiPTA
 3EbfaYj+jAD7fXczZwjWmsJG588PA7wz5UJDiW+YLxUCBGnoc2NPiBuseGA5xiAaTvHM
 gtr/VqbJi/kl613lpdc+r5smE7hDMTenGASqhh1v/D2d9kDwVoDKbc+tPBzgoOqPckfO
 Vd2S7pjiMsA+d9sM/sr09DhZ07BuzcNHw9gn2AG0/WBqKAYdZVlAsVpCwqS5afow0G8H
 sFHQ==
X-Gm-Message-State: AAQBX9dpHdpvHaImvh/sSUNJEe+ZgT3AjTOmG2/6x69zOR2oR6A2xq+0
 lmc37mInDvaCRlYwhIkO0LOQGeBcvt5eqv9/JEzfXYKM1ZkX/1dOFOJZvPE8xBwXxtdqk9Jr+Sw
 0DWYeadkXTcTrIyMhTxuAs+3UE9o=
X-Received: by 2002:a5d:45c1:0:b0:2f6:e127:1cbe with SMTP id
 b1-20020a5d45c1000000b002f6e1271cbemr3541623wrs.67.1681886862138; 
 Tue, 18 Apr 2023 23:47:42 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZHVpTGkW+BkoNZd6lspz/3EJA684u/hqW0iDysb5/cMDjswUHxJo4kSfd4FOJHNTMwune/9ZrSWzXKoDBSMCg=
X-Received: by 2002:a5d:45c1:0:b0:2f6:e127:1cbe with SMTP id
 b1-20020a5d45c1000000b002f6e1271cbemr3541605wrs.67.1681886861823; Tue, 18 Apr
 2023 23:47:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230413111434.2103422-1-pvorel@suse.cz>
In-Reply-To: <20230413111434.2103422-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Apr 2023 14:47:30 +0800
Message-ID: <CAEemH2fZU=b60mSD8PoZoQiJ7WQ+rhWiOqPO4XGyhS9aB2QDcA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_tmpdir: Remove possible double/trailing
 slashes from TMPDIR
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFRodSwgQXByIDEzLCAyMDIzIGF0IDc6MTTigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IFNpbWlsYXJseSB0byBwcmV2aW91cyBjb21taXQsIHdo
aWNoIG5vcm1hbGl6ZWQgVE1QRElSIGZvciBzaGVsbCBBUEksCj4gZG8gdGhlIHNhbWUgZm9yIEMg
QVBJLgo+Cj4gVW5saWtlIGZvciBzaGVsbCBBUEksIGhlcmUgd2UgbW9kaWZ5ICRUTVBESVIgZGly
ZWN0bHksIGJlY2F1c2UKPiB0c3RfZ2V0X3RtcGRpcl9yb290KCkgaXMgdXNlZCBvIG1vcmUgcGxh
Y2VzLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0t
Cj4gRm9sbG93IHVwIG9mIHRoZSBzYW1lIGNoYW5nZSBpbiBzaGVsbCBBUEk6Cj4gaHR0cHM6Ly9s
b3JlLmtlcm5lbC5vcmcvbHRwLzIwMjMwNDEyMDczOTUzLjE5ODM4NTctMS1wdm9yZWxAc3VzZS5j
ei8KPgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiAgbGliL3RzdF90bXBkaXIuYyB8IDE2ICsr
KysrKysrKysrKysrLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvbGliL3RzdF90bXBkaXIuYyBiL2xpYi90c3RfdG1w
ZGlyLmMKPiBpbmRleCBiNzNiNWM2NmYuLjhkYjVjNDdlOCAxMDA2NDQKPiAtLS0gYS9saWIvdHN0
X3RtcGRpci5jCj4gKysrIGIvbGliL3RzdF90bXBkaXIuYwo+IEBAIC0xMjQsMTYgKzEyNCwyOCBA
QCBjaGFyICp0c3RfZ2V0X3RtcGRpcih2b2lkKQo+Cj4gIGNvbnN0IGNoYXIgKnRzdF9nZXRfdG1w
ZGlyX3Jvb3Qodm9pZCkKPiAgewo+IC0gICAgICAgY29uc3QgY2hhciAqZW52X3RtcGRpciA9IGdl
dGVudigiVE1QRElSIik7Cj4gKyAgICAgICBjaGFyICplbnZfdG1wZGlyID0gZ2V0ZW52KCJUTVBE
SVIiKTsKPgoKSXQgc2VlbXMgdGhhdCBtb2RpZnlpbmcgdGhlIGVudmlyb25tZW50IHZhcmlhYmxl
cyBpcyBnZW5lcmFsbHkKbm90IGEgZ29vZCBwcmFjdGljZS4KClRoZSBnZXRlbnYoKSBmdW5jdGlv
biByZXR1cm5zIGEgcG9pbnRlciB0byB0aGUgdmFsdWUgb2YgYW4KZW52aXJvbm1lbnQgdmFyaWFi
bGUsIHdoaWNoIGlzIHN0b3JlZCBpbiB0aGUgbWVtb3J5IG1hbmFnZWQKYnkgdGhlIHN5c3RlbS4g
QW55IGF0dGVtcHQgdG8gbW9kaWZ5IHRoaXMgbWVtb3J5IGRpcmVjdGx5IGNhbgpjYXVzZSB1bmV4
cGVjdGVkIGJlaGF2aW9yIG9yIGV2ZW4gY3Jhc2ggdGhlIHByb2dyYW0uCgpJbnN0ZWFkIG9mIG1v
ZGlmeWluZyB0aGUgcmV0dXJuIHZhbHVlIG9mIGdldGVudigpLCBpdCBpcyByZWNvbW1lbmRlZAp0
byBjcmVhdGUgYSBjb3B5IG9mIHRoZSB2YWx1ZSBhbmQgbW9kaWZ5IHRoZSBjb3B5IGluc3RlYWQu
CgpPciwgdGhlIHNpbXBsZXN0IHdheSBJIGd1ZXNzIGlzIGp1c3QgVEJST0sgYW5kIHRlbGwgdXNl
cnMgd2h5CnRoaXMgVE1QRElSIGlzIHVudXNhYmxlLgoKCgo+IC0gICAgICAgaWYgKCFlbnZfdG1w
ZGlyKQo+ICsgICAgICAgaWYgKGVudl90bXBkaXIpIHsKPiArICAgICAgICAgICAgICAgLyogcmVt
b3ZlIGR1cGxpY2F0ZSBzbGFzaGVzICovCj4gKyAgICAgICAgICAgICAgIGZvciAoY2hhciAqcCA9
IGVudl90bXBkaXIsICpxID0gZW52X3RtcGRpcjsgKnE7KSB7Cj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKCorK3EgIT0gJy8nIHx8ICpwICE9ICcvJykKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICorK3AgPSAqcTsKPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAg
ICAgICAvKiBSZW1vdmUgc2xhc2ggb24gdGhlIGxhc3QgcGxhY2UgICovCj4gKyAgICAgICAgICAg
ICAgIHNpemVfdCBsYXN0ID0gc3RybGVuKGVudl90bXBkaXIpLTE7Cj4gKyAgICAgICAgICAgICAg
IGlmIChlbnZfdG1wZGlyW2xhc3RdID09ICcvJykKPiArICAgICAgICAgICAgICAgICAgICAgICBl
bnZfdG1wZGlyW2xhc3RdID0gJ1wwJzsKPiArICAgICAgIH0gZWxzZSB7Cj4gICAgICAgICAgICAg
ICAgIGVudl90bXBkaXIgPSBURU1QRElSOwo+ICsgICAgICAgfQo+Cj4gICAgICAgICBpZiAoZW52
X3RtcGRpclswXSAhPSAnLycpIHsKPiAgICAgICAgICAgICAgICAgdHN0X2Jya20oVEJST0ssIE5V
TEwsICJZb3UgbXVzdCBzcGVjaWZ5IGFuIGFic29sdXRlICIKPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJwYXRobmFtZSBmb3IgZW52aXJvbm1lbnQgdmFyaWFibGUKPiBUTVBESVIi
KTsKPiAgICAgICAgICAgICAgICAgcmV0dXJuIE5VTEw7Cj4gICAgICAgICB9Cj4gKwo+ICAgICAg
ICAgcmV0dXJuIGVudl90bXBkaXI7Cj4gIH0KPgo+IC0tCj4gMi40MC4wCj4KPgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
