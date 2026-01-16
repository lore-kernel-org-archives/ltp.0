Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5A9D4A5E4
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 01:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768527949; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=51N4WxsP+qlymX0wg5wf2bFhVIkVYK8AXqfLw/YSEz8=;
 b=KP0Zve0Gt6EHrxBVY0UFUfwSY9KRT0DQz/EUnaZjtqNuewq65KHiPvEy7XaRNOnf590db
 HM09yIU/CPt/v3grO3XLpAS/7nbm7LXs2+xPA5sRUpJWWpV1yiIT9fcCXgptyiaYopZ1U74
 jJbvx6ne7VxqPop3vTyf4t6Vj9PJnh0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCFFF3CA4F8
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 02:45:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DBBB83C9A5F
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 02:45:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 74DD66019BC
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 02:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768527922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7GTMLtxq7u2iQcXEO2HiGBgtzd5f9cKh/whOKWBfpGU=;
 b=DWVEB1aI96Xgv7NfXSP2NzylMGLXWbMbp0asoxTBTXIuff2ULiEMVqi1EZtOLOy8+8qumW
 HkwIVz4QQ4LWpCSCRToqqmPf+fq8+qpFnVkXUy9hXbHoRBwBGPhITImSqqD3O8uyuP9NMt
 aMmTwu3hE4kqcc7a5bnhTWaNpmxwYW8=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-303-GpDD3rMpNAK16gHhLjWTSw-1; Thu, 15 Jan 2026 20:45:21 -0500
X-MC-Unique: GpDD3rMpNAK16gHhLjWTSw-1
X-Mimecast-MFC-AGG-ID: GpDD3rMpNAK16gHhLjWTSw_1768527920
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2b21d136010so2565557eec.1
 for <ltp@lists.linux.it>; Thu, 15 Jan 2026 17:45:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768527919; x=1769132719;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7GTMLtxq7u2iQcXEO2HiGBgtzd5f9cKh/whOKWBfpGU=;
 b=gu36VZ+u1Q6d1hgvxJ0mWNuLFEVlAzEx2IjPpHlPS2hsPAqvgU1geYeSMszlVT+Lqi
 SchWVw2cvR1V+WIpyksQnYubVCu0XpBDMprRHOJwF0V+QBJ8FB+N6Yr43JdDJJISqlDw
 l0NZTma3IcGOiL5XxnQ9xwq+n4+oA5F5XKBjQmEDpy3+gXXzvXUsZ1Q1RnJ9sSx+09Yf
 yDX4uDONIui/gnQIGKZrSVFFQSl2IlUmxI2jppzgEy5HKD4IIr+w1JFc1s0BTG+NHAZA
 H3gDUA1Ug0HiUOVEzzjaw1Ay80z7dlu8TfYpNNDdGm924IvY24Z/LK7rczvqRwbQ+7J0
 3V9A==
X-Gm-Message-State: AOJu0YzqaBebeUkAwlhiDkPH187CnpBRlddRA7YBRrlr+nYm0lMqQloU
 zSWgjGj4y35rf6esO8Zt6LRIgCUe2be1CGMqtRw3U8EGFvR3N8yqYCBl59x9yDHwbpiVaLq+ExD
 Ltp2WOJHCjsqTXtdch6BLWvsvIYKCTKwo8az/2/khf957UEul4lafzwZopmYCghmJOOcs9gY59q
 0LuKlB9Ycwwir75kZAeL1bOY218hC/23ZzJvI=
X-Gm-Gg: AY/fxX6R8Q/XvkOHLPk6J8cVzGKoWqkFCKXPSo2dinJKosGEl/KI/PxFTZjCINyOjGh
 EBNhgkeYgNMqJ80v/ihA3B+ZYgCwcujP7w+KEGsYMPb3PnJUZyyPjHidaKCSXmvVrn3mxCWTuTz
 7/xPnRVYzzNgTmajpqRx/B5n24yDLBUDKmSSyyeUG4xN82EGY4/5kp7uRPV6Ka9xvM9GI=
X-Received: by 2002:a05:7300:3246:b0:2b4:700b:3d8b with SMTP id
 5a478bee46e88-2b6b40f4c86mr1490193eec.37.1768527919610; 
 Thu, 15 Jan 2026 17:45:19 -0800 (PST)
X-Received: by 2002:a05:7300:3246:b0:2b4:700b:3d8b with SMTP id
 5a478bee46e88-2b6b40f4c86mr1490181eec.37.1768527919134; Thu, 15 Jan 2026
 17:45:19 -0800 (PST)
MIME-Version: 1.0
References: <aWjZX0fsrTJMqq49@yuki.lan>
 <CAEemH2f_56EZUi74x-K5a5Pe231qjU14NTsZjWt+=aTdAJcLkA@mail.gmail.com>
 <aWjxFQOl3M1xV5Ep@yuki.lan>
In-Reply-To: <aWjxFQOl3M1xV5Ep@yuki.lan>
Date: Fri, 16 Jan 2026 09:45:07 +0800
X-Gm-Features: AZwV_QjT2Rpglnwu9rcPak74aHmHEEpRbVJ2MnOD4hBAx1kZ9PrIzT9EXVy7dKY
Message-ID: <CAEemH2cv7MuDtxCCCv3-WYyWp7VV6nZS1WGJG+ZZFtvgA=ySNQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zzTWXjuTTt1Ctpvyu-jcNEMMEyxgj7JIwHn_DoZTb2c_1768527920
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preprations
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

SGkgQ3lyaWwsCgp0c2VfIGFuZCB0c29fIHNvdW5kIGdvb2QuIFNob3J0IGFuZCBkaXN0aW5jdCBl
bm91Z2guCkkgd2lsbCBzdGFydCB0byBwcmVwYXJlIG15IHBhdGNoIFYyIGJhc2VkIG9uIHRoaXMu
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKT24gVGh1LCBKYW4gMTUsIDIwMjYgYXQgOTo1MeKAr1BN
IEN5cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gICB0c3Rf
OiBjb3JlIExUUCBBUEkgKGxpYi8pCj4gPiAgIGV0c3RfOiBub27igJFjb3JlIGV4dGVuZGVkIGxp
YnJhcnkgaW4gKGxpYnMvKQo+ID4gICBvdHN0XzogbGVnYWN5L2NvbXBhdCBsaWJyYXJ5IChubyBu
ZXcgZmVhdHVyZXMpCj4gPgo+ID4gQnV0IG5vdywgSSdtIGFsc28gY29uc2lkZXJpbmcgdXNpbmcg
dHN0XyosIGVzdF8qLCBhbmQgb3N0XyogZGlyZWN0bHkuCj4KPiBNYXliZSB0c2VfICh0ZXN0IGV4
dGVuZGVkKSBhbmQgdHNvXyAodGVzdCBvbGQpLgo+Cj4gPiBUaGF0IHdvdWxkIGdyZWF0IGlmIHdl
IGNhbiBmaW5hbGl6ZSB0aGlzIGJlZm9yZSB0aGlzIHJlbGVhc2UuCj4KPiBJIGRvIG5vdCBoYXZl
IGEgc3Ryb25nIG9waW5pb24gaGVyZSwgd2hhdGV2ZXIgaXMgc2hvcnQgZW5vdWdoIHdvdWxkIGRv
Lgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApSZWdhcmRz
LApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
