Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58930C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 10:24:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCFB73CE1F1
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 11:24:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D67233C8964
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:23:48 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93B1A103AAE7
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 11:23:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706178226;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LotqoVtCd9VZkDnf4U5xkpJpLgYw1ptQFyhL47C8fZs=;
 b=Vvprt/2WURdZMYnfkU/LxWT0w8539z1J9K0CGJHUVNGzVM5daEhu9ORblEDVGhqUSDVqg0
 PLEKRCXjF1O+0e7d45k5h3JFZZLYmskaaXaiTy3FJqR8sHxNWNz62JtM6O3x+S7A9NPVV8
 Fbs7Xtx6LL1voDNeSAB7CE9WA3cnSoA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-211-WagDQUfNPvSPGzkMXnh4fw-1; Thu, 25 Jan 2024 05:23:44 -0500
X-MC-Unique: WagDQUfNPvSPGzkMXnh4fw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2905ee6b25eso6301933a91.0
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 02:23:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706178222; x=1706783022;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LotqoVtCd9VZkDnf4U5xkpJpLgYw1ptQFyhL47C8fZs=;
 b=a/tWG7BiABwy1/CchZbM5M93CyaXEjd2uU6eMoArWu6YJooX96kcSa/ljQAZjjNe5H
 3Vt6/8l92hI3pu8KxiEvVmsxSPhZXGseq/nTvnQ93dsT2SxqsETMOLCCbCLBFflXHVT0
 Anw2OtwW5SluHq+i0hCqeBCPku/CRpVyhU19An7L5+QsV1D+v4TYLafdK6JMalQehUsy
 +gtEkKqaBVP7WLf87pyk7rE/xasSmEkH0ZgulU7J3KSuHqJTkwow6PnN0NGTF4MMTyfP
 MSVurlsd1XdjNRUCZ6FxA/pZwjCPnrApbyyDTbd+zE2pEzmUBYtc7MM3M2HfbqX4jrn7
 r8/A==
X-Gm-Message-State: AOJu0Yx++8T7FxGpacn+AIpoCGKFxN+lxDP2HKgGqiQjLZMPETrdTp5i
 9ROm0aTk/b6jH0jCeGSni6Kjcmj2CaECYIHseG+sqN9jhELIgmZAJxp6HVd77bIH2AP/NYhTuYx
 keRkdPTIu2r9/eEEDzlwImvHfvBajHGSugFvZ0Doj8pPOEFuIqdowCe41Z5hnTum7rBby7U1EWU
 7DFb2olnGPgL7jHW2wH71qrTIPMDmwVTlKCA==
X-Received: by 2002:a17:90a:9205:b0:28c:4b8c:9729 with SMTP id
 m5-20020a17090a920500b0028c4b8c9729mr588999pjo.2.1706178221799; 
 Thu, 25 Jan 2024 02:23:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEA0LPp9EDzRanXQJ9x4UHQdNHjYYPB4tbHtZa2kg3U9Xyq0K6w45DTZXglD5dSAKT+fE/spTa5Pe8mHuLKHW4=
X-Received: by 2002:a17:90a:9205:b0:28c:4b8c:9729 with SMTP id
 m5-20020a17090a920500b0028c4b8c9729mr588993pjo.2.1706178221536; Thu, 25 Jan
 2024 02:23:41 -0800 (PST)
MIME-Version: 1.0
References: <20240124044548.2652626-1-liwang@redhat.com>
 <20240124192251.GB333483@pevik>
In-Reply-To: <20240124192251.GB333483@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 25 Jan 2024 18:23:29 +0800
Message-ID: <CAEemH2furScb5PPAFEK+Vq0xyF21B6OekqT-infZDByKUnUe3Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V4 0/6] improvement work on libswap library
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

T24gVGh1LCBKYW4gMjUsIDIwMjQgYXQgMzoyMuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4KPiBUZXN0ZWQtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+IE9u
IFR1bWJsZXdlZWQgNi42IGFuZCA2Ljcga2VybmVsIGFuZCB2YXJpb3VzIFNMRVMgdmVyc2lvbnMg
c3RhcnRpbmcgd2l0aAo+IDQuMTIKPiBhbmQgbmV3ZXIga2VybmVscy4KPgo+IHRoYW5rcyBmb3Ig
eW91ciB3b3JrLCBJIGd1ZXNzIHdlIGNhbiBtZXJnZSBpdC4KPgoKVGhhbmtzIGZvciB0ZXN0aW5n
LgoKCj4gPiBWMy0tPlY0Cj4gPiAgICAgICAqIGNyZWF0ZSBhIGNvbnRpZ3VvdXMgc3dhcGZpbGUg
aW4gc3dhcG9mZjAxLmMKPiA+ICAgICAgICogZml4aW5nIG9sZC1YRlMgcmVxdWlyZXMgaW5pdGlh
bGl6ZSBzd2FwZmlsZSBpc3N1ZQo+Cj4gPiBUb2RvOgo+ID4gICAgICAgKiByZXBsYWNlIHRoZSB0
c3RfYnJrIHdpdGggdHN0X3JlcytyZXR1cm4gaW4gaXNfc3VwcG9ydF9zd2FwCj4gPiAgICAgICAq
IGN1c3RvbWlzemUgc3dhcGZpbGUgc2l6ZSBpZiBuZWVkZWQKPiBPSyB0byBwb3N0cG9uZSB0aGlz
LiBJIGxpa2UgdGhlIGV4dGVuZGVkIHN1cHBvcnQuCj4KPiBJIGFsc28gd29uZGVyIGlmIHdlIHNo
b3VsZCBwb3J0IGFmdGVyIHRoZSByZWxlYXNlIGFsc28gc3dhcG9uMFsyM10uYwo+IGFuZCBldmVu
IHN3YXBvZmYwWzIzXS5jIHRvIGFsbF9maWxlc3lzdGVtcy4KPgoKWWVzLCBJIGNhbiBkbyBhbGwg
b2YgdGhhdCBhZnRlciByZWxlYXNlLgoKQEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiBD
YW4gSSBtZXJnZSB0aGlzIHBhdGNoIHNldCBiZWZvcmUgcmVsZWFzZSwKaXQncyBiZWVuIGdldHRp
bmcgdGVzdGVkIGJ5IFBldHIgYW5kIG1lIGFjcm9zcyBkaXN0cmlidXRpb25zLgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
