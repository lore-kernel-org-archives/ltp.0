Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AB9C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 12:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750681438; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mUkhaIIZg6WEuZIq84U4Enu2n82llNSE1DEHxl6EMHA=;
 b=cLtH1jA0GCR7rS9xs/olb7Fm01R9JjtVymn1/yJJnS8Zx5UlQ3ldItk8tueuKAw5p5pie
 kn/BHHGlVLQS3oND+GdbnF576K9lXI+DvhalajbTax6hKKtt3z8SP2bk6H4hd943dnf6kCv
 vkrvJVJVL90JlVo9WBQfKwSXKjREiOw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E47C3CCA6D
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 14:23:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 289493CC52B
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 14:23:38 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EEB8160081B
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 14:23:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750681415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3XlMFbFZ9NDmwmeQeamZKeADTxJFvBhESGOX2s/xGPg=;
 b=Wq1UfmxIiEPJYk2U8U+bRhkRDdIAs03F/X5iTIZU2wQ03beeG+YfuFElEayRkVwGWsBLpU
 XbZmHFi/k27lTTH8aQ7Xr4HsKRJdb+eRNMHFL6seo7bZ6axgK6/0uXO6P+MwBmX1efNN81
 mzlJjv9xkqPNLBRXhWeEFSwxfdFxOEo=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-dXKTLwCaM9qISLoU0nhPng-1; Mon, 23 Jun 2025 08:10:26 -0400
X-MC-Unique: dXKTLwCaM9qISLoU0nhPng-1
X-Mimecast-MFC-AGG-ID: dXKTLwCaM9qISLoU0nhPng_1750680625
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3141a9a6888so3837201a91.3
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 05:10:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750680625; x=1751285425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3XlMFbFZ9NDmwmeQeamZKeADTxJFvBhESGOX2s/xGPg=;
 b=lNL80FqKBdVvOzI+VhF+2oI62nnF25gAoeCIwaTvZFbgVxdKl1u90nBuuGcIwSEU7P
 fQTHTEDc1TIv8aRsU9RM8NVIIdPquPnoWWWbxcM6xJ7f4KAj6LSF+88czmt5JfBcEN3i
 fKkdvyjACskSJiRAE3n8g7Wg5Gc4fEFNOp/SzATsciqB+6U17pRORauswDjtP0Hhmk1k
 Xzi6ErWYniD+l+ywb4lkiPTwh7GvnAgo5imzWfNytJ+xt/ph76bYHKskKziRo+zzEjJW
 HOq95rQIdpA26ZUVvICrkEvGUp2OewcxgYgssxFFLwN5b2FSe/M9WAxzqn1iFPaVNrFt
 l0nw==
X-Gm-Message-State: AOJu0YzPVJrKHrVd0Ir7VJi9234vbLvKj4ovKvrcrkJ9Mgi76IcpK/yy
 7Lh2f/+ZzIEchVf8XcFN86kennY3tYTVe8BsbLCvYCFXC0FHmfAhq+0cHWO9Kg9jPeHXeD2uTYx
 EhPeJ7CHlSaXazxCfV8QOezU1I+XhmR9qnEZML/XkLQm+LPBAKG+XxoK5A4rQZZc42qkB2K563y
 UomluysFeXc5GEDO+adS8kxFK+mKhQ+XR/CxO3QA==
X-Gm-Gg: ASbGnctOWD0TacZH3EdA7B6qvkZ2QSHokMpkQrvcRmxE9BZRNte7Ni6Qa4rX19seQi4
 zPm22Ahwub96Vx22nLQOEyJwk4kM4cwipSxla7b00nq7a4NqeA5fgCgehSL1mRxbsnUDXzOILih
 b5g3Fx
X-Received: by 2002:a17:90b:5826:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-3159d64432cmr18985047a91.8.1750680624613; 
 Mon, 23 Jun 2025 05:10:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPrIuw3jxRVuklJZYFv9hdhWPqgfSe6OYpZbTj2dsaMit6u/HE1jBVw/buSOPOkT2m60LmXK1TxkFMRFovyl8=
X-Received: by 2002:a17:90b:5826:b0:2fe:e9c6:689e with SMTP id
 98e67ed59e1d1-3159d64432cmr18985003a91.8.1750680624162; Mon, 23 Jun 2025
 05:10:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250620073000.514444-1-liwang@redhat.com>
 <20250623091223.19583-1-liwang@redhat.com>
 <af88e5ca-5c77-49ad-8992-0a69ce36bf82@suse.cz>
In-Reply-To: <af88e5ca-5c77-49ad-8992-0a69ce36bf82@suse.cz>
Date: Mon, 23 Jun 2025 20:10:12 +0800
X-Gm-Features: Ac12FXx0ySl_jH7zDxvUxh6r1vIQG58O7jQUwiHGED3DAZA5B_P7HggqKAgbWDc
Message-ID: <CAEemH2fO5+Hyr=--6oVB0L0cX7tOd1yAJ62i1N7W8Wh7o_TRtA@mail.gmail.com>
To: Martin Doucha <mdoucha@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Sugm4uwbX505HN4iyG7_Rm88aom4EDWaQMyXANQ0whg_1750680625
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] tst_test: Add flags to control runtime
 scaling in timing sensitive tests
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBKdW4gMjMsIDIwMjUgYXQgNzo0M+KAr1BNIE1hcnRpbiBEb3VjaGEgPG1kb3VjaGFA
c3VzZS5jej4gd3JvdGU6Cgo+IE9uIDIzLiAwNi4gMjUgMTE6MTIsIExpIFdhbmcgdmlhIGx0cCB3
cm90ZToKPiA+IFNvbWUgdGVzdHMsIHN1Y2ggYXMgdGhvc2UgdXNpbmcgZnV6enkgc3luY2hyb25p
emF0aW9uIG9yIHByb2JhYmlsaXN0aWMKPiB0cmlnZ2Vycwo+ID4gKGUuZy4gcHJlYWR2MjAzKSwg
cmVxdWlyZSBzdWZmaWNpZW50IHJ1bnRpbWUgdG8gY29sbGVjdCBtZWFuaW5nZnVsCj4gcmVzdWx0
cy4KPiA+IFRoZXNlIHRlc3RzIG9mdGVuIHJlbHkgb24gdGhyZXNob2xkcyBsaWtlIGBmenN5bmNf
cGFpci5taW5fc2FtcGxlc2AsCj4gd2hpY2ggbXVzdAo+ID4gYmUgbWV0IGR1cmluZyB0aGUgcnVu
dGltZSB3aW5kb3cuCj4gPgo+ID4gV2hlbiBMVFBfUlVOVElNRV9NVUwgaXMgc2V0IHRvIGEgdmFs
dWUgPCAxLjAgKGNvbW1vbmx5IGluIENJCj4gZW52aXJvbm1lbnRzKSwKPiA+IHRlc3RzIG1heSBy
dW4gZm9yIHRvbyBzaG9ydCBhIHRpbWUsIGZhaWxpbmcgdG8gZ2F0aGVyIGVub3VnaCBzYW1wbGVz
IGFuZAo+ID4gc2lsZW50bHkgcHJvZHVjaW5nIGZhbHNlIG5lZ2F0aXZlcyBvciB1bnN0YWJsZSBy
ZXN1bHRzLgo+ID4KPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyB0aGUgZm9sbG93aW5nIHRlc3Qg
ZmxhZ3MgaW4gYGVudW0gdHN0X2ZsYWdgIHRvCj4gcHJvdmlkZQo+ID4gZmluZS1ncmFpbmVkIGNv
bnRyb2wgb3ZlciBydW50aW1lIGFuZCB0aW1lb3V0IHNjYWxpbmc6Cj4gPgo+ID4gICAgLSBUU1Rf
Tk9fUlVOVElNRV9NVUw6Cj4gPiAgICAgICAgSWdub3JlIExUUF9SVU5USU1FX01VTCBhbmQgdXNl
IHRoZSBvcmlnaW5hbCAucnVudGltZSB2YWx1ZS4KPiA+Cj4gPiAgICAtIFRTVF9OT19USU1FT1VU
X01VTDoKPiA+ICAgICAgICBJZ25vcmUgTFRQX1RJTUVPVVRfTVVMIGFuZCB1c2UgdGhlIG9yaWdp
bmFsIC50aW1lb3V0IHZhbHVlLgo+ID4KPiA+ICAgIC0gVFNUX05PX0ZSQUNUSU9OQUxfUlVOVElN
RV9NVUw6Cj4gPiAgICAgICAgSWYgTFRQX1JVTlRJTUVfTVVMIGlzIGxlc3MgdGhhbiAxLjAsIHJv
dW5kIGl0IHVwIHRvIDEuMCB0bwo+IHByZXNlcnZlCj4gPiAgICAgICAgaW50ZW5kZWQgdGVzdCBk
dXJhdGlvbi4KPgo+IEkgdGhpbmsgaXQnZCBtYWtlIG1vcmUgc2Vuc2UgdG8gZGVmaW5lIGEgbWlu
aW1hbCBydW50aW1lIGluIHRoZSBMVFAKPiBsaWJyYXJ5IChlLmcuIDEgc2Vjb25kKSBhbmQgYWxs
b3cgdGVzdHMgdG8gb3ZlcnJpZGUgdGhlIHZhbHVlIHdpdGgKPiB0c3RfdGVzdC5taW5fcnVudGlt
ZS4gVGhlbiB5b3UgY2FuIGFwcGx5IGZyYWN0aW9uYWwgTFRQX1JVTlRJTUVfTVVMCj4gc2FmZWx5
IHRvIGFueSB0ZXN0Lgo+CgpUaGF0IGhhcyBiZWVuIGFjaGlldmVkIGluCmh0dHBzOi8vbGlzdHMu
bGludXguaXQvcGlwZXJtYWlsL2x0cC8yMDI1LUp1bmUvMDQzOTYwLmh0bWwuCndoaWNoIGF2b2lk
cyAucnVudGltZSBiZWluZyByb3VuZGVkIHRvIHplcm8gd2l0aCBmcmFjdGlvbmFsIExUUF9SVU5U
SU1FX01VTC4KClRoaXMgcGF0Y2ggaW50cm9kdWNlcyBUU1RfTk9fRlJBQ1RJT05BTF9SVU5USU1F
X01VTCwgbWFpbmx5IHRvCnNvbHZlIHRoZSBwcm9ibGVtIHRoYXQgc29tZSBzcGVjaWFsIHRlc3Rz
IChlLmcuIGZ1enp5LWxpYiwgcHJlYWR2MjAzKSBzaG91bGQKbm90IHJlZHVjZSB0aGUgcnVudGlt
ZSBkdXJpbmcgZXhlY3V0aW9uLiBTZXR0aW5nIGEgbWluaW11bSBydW50aW1lIChlLmcuIDEKc2Vj
b25kKQpkb2VzIG5vdCBtZWV0IHRoZSByZXF1aXJlbWVudHMuCgoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
