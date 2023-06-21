Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5C45EB64D7
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 01:32:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 88AEB3CC6C2
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 03:32:50 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD8AC3CB8DB
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 03:32:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id ADBE82002B5
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 03:32:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687311156;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q87gw53DFxZ1E969UrpGsrCZ7yiXy43KqX/pfEYsCZs=;
 b=irL3z51ucYe6r6pYAEtfW6L9VIKHxF1TpX04ry0DVvTSpDKaDcrxbnY4sdtz0PSZNEwQlc
 5Qa6Wmf9XJSDN2NqOxx50gZ8utqSNmSA0nmDw+3YSSGTJUf3p3rzr76y4w3DmuBGHiiqjJ
 UWIGU7zMN1PS0KNjAMazB0M6gyXeH0k=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-7AT0BFakM_KU5rAwrWdUPA-1; Tue, 20 Jun 2023 21:32:22 -0400
X-MC-Unique: 7AT0BFakM_KU5rAwrWdUPA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b45bf52675so37352971fa.3
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 18:32:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687311141; x=1689903141;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q87gw53DFxZ1E969UrpGsrCZ7yiXy43KqX/pfEYsCZs=;
 b=fgcffYwz7jFbrdJ8HFIlrfnYXClFpEueNv6MlRCZUPvKsYi02sv/UtjWBnLUSuhZ72
 9epxoLOtCb/+nJJzkgDlsz8uvOBbOxwXyg07dTOGS3xVnbrfXrQzz+al5wbyV2WxFDOB
 SlcDHtPsX1x3FiBzBycxBJOiHnpNCZcVmM3sYvncKBVpD3+C0O5r/dfJQtgiWC8J8Qkc
 EpG/KVa3+BboLEVU+KOwIXwsVAbSmoyLeOxgyLtWnpEKvzVTXZ+sjTGCBQHuuhD7B6tt
 smwuoPA76kzEJ8uZl/8tuL6/OHjv0DWCsQ0ZMxfWK2dZ3bmFq6apNNoFVNkVyseOrRkZ
 ftOw==
X-Gm-Message-State: AC+VfDzoFM4wc7TEFLUsJS3ZfHY5uL/ti0V3rMIdhcSBDwSEBYhHZn8Y
 BMolzBFWsBR+AEtSri3QxGyqJi3U/w3IVY4BWk3WNicPM0f+ynuFHi191FFwWEULRypUotG30PU
 Wy6X3Lcm4w2/JszjoljtnEys3uwg=
X-Received: by 2002:a2e:9a8f:0:b0:2b4:4c22:fccb with SMTP id
 p15-20020a2e9a8f000000b002b44c22fccbmr8433266lji.52.1687311141095; 
 Tue, 20 Jun 2023 18:32:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ79Gs2QhA08N1s04xu6vz5y4F1IbWaSZJmOoiniE4/otYPxkodOn2ggYSEwmeZvmNvb3+AO2xe4XbiKjzJDWp4=
X-Received: by 2002:a2e:9a8f:0:b0:2b4:4c22:fccb with SMTP id
 p15-20020a2e9a8f000000b002b44c22fccbmr8433258lji.52.1687311140751; Tue, 20
 Jun 2023 18:32:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230615075307.157688-1-liwang@redhat.com>
 <CADJHv_uHkMiWf3kgp0A4tM2VYNH3-N9xcvCjjQEk1M18zo2Now@mail.gmail.com>
In-Reply-To: <CADJHv_uHkMiWf3kgp0A4tM2VYNH3-N9xcvCjjQEk1M18zo2Now@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Jun 2023 09:32:09 +0800
Message-ID: <CAEemH2d15gu+ivQ2k0KkNRgBe74-Kk1tvgs41uOMKhETME+TiA@mail.gmail.com>
To: Murphy Zhou <jencce.kernel@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_fill_fs: drop safe_macro from fill_flat_vec
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
Cc: Shizhao Chen <shichen@redhat.com>,
 Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it,
 Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBKdW4gMTYsIDIwMjMgYXQgODozMOKAr1BNIE11cnBoeSBaaG91IDxqZW5jY2Uua2Vy
bmVsQGdtYWlsLmNvbT4gd3JvdGU6Cgo+IE9uIFRodSwgSnVuIDE1LCAyMDIzIGF0IDM6NTPigK9Q
TSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gTFRQIGZzX2ZpbGwg
aXMgdHJ5aW5nIHRvIHNwYXduIG5DUFVTIHRocmVhZCB0byBjcmVhdGUgY29ycmVzcG9uZGluZwo+
ID4gc3ViZGlyZWN0b3JpZXMgYW5kIGNvbXBsZXRlbHkgZmlsbCB0aGVtLiBCdXQgaW4gdGhlIGlu
dm9rZSBmdW5jdGlvbgo+ID4gdHN0X2ZpbGxfZnMoLCBUU1RfRklMTF9CTE9DS1MpIC0+IGZpbGxf
ZmxhdF92ZWMoKSB3aGljaCBoYXMgU0FGRV9NQUNST3MKPiA+IHRvIGJyZWFrIHRoZSBvcGVuIGJl
aGF2aW9yIG9uY2UgZnMgaXMgZmlsbGVkIHdpdGggRU5PU1BDIHJldHVybi4KPiA+Cj4gPiBUaGUg
ZmFpbHVyZSBsaWtlIHRoZXJlIGFyZW4ndCBlbm91Z2ggZnJlZSBpbm9kZXMgaW4gdGhlIGZpbGVz
eXN0ZW0gZm9yCj4gPiB0aGUgdHN0X2ZzX2ZpbGwgdGVzdCBwcm9ncmFtIHRvIGNyZWF0ZSBpdCdz
IHNldCBvZiAiQU9GIiBkYXRhIGZpbGVzLgo+ID4KPiA+ICAgNDEwOCAgdHN0X3Rlc3QuYzoxNjM0
OiBUSU5GTzogPT09IFRlc3Rpbmcgb24geGZzID09PQo+ID4gICA0MTA5ICB0c3RfdGVzdC5jOjEw
OTQ6IFRJTkZPOiBGb3JtYXR0aW5nIC9kZXYvbG9vcDAgd2l0aCB4ZnMgb3B0cz0nJwo+IGV4dHJh
IG9wdHM9JycKPiA+ICAgNDExMCAgZnNfZmlsbC5jOjEwODogVElORk86IFJ1bm5pbmcgOTggd3Jp
dGVyIHRocmVhZHMKPiA+ICAgNDExMSAgdHN0X2ZpbGxfZnMuYzo3NzogVEJST0s6Cj4gb3BlbmF0
KDg5PC9tbnQvdGVzdGFyZWEvbHRwLXdHZzBYTlNIY3IvTFRQX2ZzX1hMeHJMaC9tbnRwb2ludC90
aHJlYWQ4ND4sCj4gJ0FPRicsIDEwMSwgNjAwKTogRU5PU1BDICgyOCkKPiA+ICAgNDExMiAgdHN0
X2ZpbGxfZnMuYzo3NzogVEJST0s6Cj4gb3BlbmF0KDg3PC9tbnQvdGVzdGFyZWEvbHRwLXdHZzBY
TlNIY3IvTFRQX2ZzX1hMeHJMaC9tbnRwb2ludC90aHJlYWQ4Mz4sCj4gJ0FPRicsIDEwMSwgNjAw
KTogRU5PU1BDICgyOCkKPiA+ICAgNDExMyAgdHN0X2ZpbGxfZnMuYzo3NzogVFdBUk46Cj4gb3Bl
bmF0KDg1PC9tbnQvdGVzdGFyZWEvbHRwLXdHZzBYTlNIY3IvTFRQX2ZzX1hMeHJMaC9tbnRwb2lu
dC90aHJlYWQ4Mj4sCj4gJ0FPRicsIDEwMSwgNjAwKTogRU5PU1BDICgyOCkKPiA+ICAgNDExNCAg
dHN0X2ZpbGxfZnMuYzo3NzogVFdBUk46Cj4gb3BlbmF0KDM8L21udC90ZXN0YXJlYS9sdHAtd0dn
MFhOU0hjci9MVFBfZnNfWEx4ckxoL21udHBvaW50L3RocmVhZDgxPiwKPiAnQU9GJywgMTAxLCA2
MDApOiBFTk9TUEMgKDI4KQo+ID4KPiA+IFRoaXMgcGF0Y2ggaXMganVzdCB0byBjb252ZXJ0IHRo
ZSBmaWxsX2ZsYXRfdmVjKCkgdG8gaWdub3JlIEVOT1NQQyBsaWtlCj4gPiBmaWxsX3JhbmRvbWUo
KSBpbiBvcGVuaW5nIHN1YmRpcmVjdG9yaWVzLgo+Cj4gTG9va3MgZ29vZCB0byBtZS4gVGhhbmtz
IGZvciBmaXhpbmcgaXQhCj4KClBhdGNoIGFwcGxpZWQsIHRoYW5rcyBmb3IgeW91ciByZXZpZXcu
CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
