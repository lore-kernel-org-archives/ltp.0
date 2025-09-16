Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A789CAC598
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 07:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758007184; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=QSJgYuSU7e8IzWM8xPzqFUZRM+uVF5KJ12LYXs4DiVw=;
 b=NEgdRGXvtyfeeEQzhDcnivsWDcydGU2ryVLZAQoGpxT27XLRtfP2SH2ZezoiPxYB7tw4E
 Lhk7kl0Dj/naOc1t/3C4KR+i/Fe5ouNgI5fhYPpfuGeAaJFBLDG2u3vKYpCxcYdjle33CuO
 QxltE2UTPPZW+Vvsmj1RcXoctue3yJA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF9483CDAD4
	for <ltp@archiver.kernel.org>; Tue, 16 Sep 2025 09:19:43 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 893673C073D
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:19:23 +0200 (CEST)
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com
 [IPv6:2a00:1450:4864:20::531])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DD040200AF5
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 09:19:21 +0200 (CEST)
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-62f0702ef0dso5345472a12.1
 for <ltp@lists.linux.it>; Tue, 16 Sep 2025 00:19:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1758007161; x=1758611961; darn=lists.linux.it;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x4W88mQhsjh7nnuT00dXXGYZYxfD2caLtMaAilSAF30=;
 b=TwvLGAAOE3oDps99Qcs0i6dUQQI6DulJUwX2UKeJcOJP8Ssv66Mmss/aKkWnIU2Sms
 sZ5Iman49TSxWD1yDa1wI516QB6W6PTCBCppHWS/7L2xFH1/VB+cThamIH03dupcQtYO
 gPiuf06atbN6ApkZWt8MBl3Bb9brZx9l+QVCYbk6kISZdxVAV3G/YQd6Bp0yrz/CcRzV
 UdLj93ln6cfaRy/IBAZ1Lz57ENW7vOUGzKL53Vh9tO/QRY2DFIzFSMp7T+yu0oJrG3u3
 gDd/XQ3OPVzrA3xvYU01upus/YBU6CDxEg//Dh1jSTL8V/sfn6HT7GuSY6/GwzwcI6Uu
 pnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758007161; x=1758611961;
 h=in-reply-to:from:content-language:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=x4W88mQhsjh7nnuT00dXXGYZYxfD2caLtMaAilSAF30=;
 b=pM51hO1Vg57sTJ2OQwMA3k9YrMqwamUT90f/m1sEKcXbqaVqJTfHzFxFh1X/w+8HwV
 dJzsZxhdZeSR+irfJarVJhM5MpxORodVRbiAeZkmleT7B56lf+RGt3XsS+YPSUxf5Hjx
 hC1aXJo9UIr1sh1ex+f0f+QR9UTsdYVJidnrS0Z5cXFoWvk/9dMmjDWIoRRHzGvszqKN
 Is0VM3p28uTTIB4rzFPl5nZkeip1N3/EkhmKHgs6R+6CiY1dPcnQ4NhBW08HAoGIEHO/
 J0C8xZDdqS6ag2QKC0/M7JFbAJJ1AQi9gx/dUaNAw9JR6wchYULRUPxKOHBu2PGGAZ2E
 F7VQ==
X-Gm-Message-State: AOJu0YwwFTVI0ssLvyKO8KJKGDTzyXTgtmLbnxlHoxAhy68hna+33hoz
 SXpVZGoKRHHngKKad501/RELJylyVaLt6cq6GqlOmc7cEiGRn8wIpOcfyw8mE6/hydQ=
X-Gm-Gg: ASbGnct3gOzuO+prc1wFiIUUPr/uxmHg+HumW0VwV6A7BKkjOJp67mCR7bRVChoEV/r
 HniHO0QSiesvsAUfrb7cLcT13UXeIpa+uBZ9OUNJTHV7bzPAJUrjUfRZ/kNr6HGXQtD1AQHgSP8
 Cn4SiPnNpsbOzjmuOM54DX5HPSwhLSDw+6idWVeK+EHfSRsAI+zdTFc0xe+xj09+EI9glOB4+X5
 4CEM/Go8/qpa3XkNLPDA1NgMXJBYOamC8Ypq/Pdapbixfav0o8l0BJkIXSPRmlbbK0oHjDC6jo1
 xEXLzdKNH1x5GUaC9TY3cWiStomAlmLEFCrnhfrYEwryySq9xefd1doT5zmXU/IMxI02gGCvcMV
 nyXAW/HNLDeF3IkTMHtbA/aNK8rXVapJlalB29RkFTFg40avLKJBKAA7Rb7Ye6Urb8F62JZzzt6
 U2wsQgVW8ISNDH2Xdr9eZjQzSQRAovisAkUy48jW2MAE7FEN7WrVtUBB3VjAWZ0g==
X-Google-Smtp-Source: AGHT+IGtpm+E0B8QBOwKHo6Tc4gJFTbeQRzKle2ndXf0dOofnnz8DDIE3/4CPbIHOkxhLIh5PedCCQ==
X-Received: by 2002:a17:907:2d24:b0:b07:88f9:22fa with SMTP id
 a640c23a62f3a-b167f4277a4mr148086366b.10.1758007160842; 
 Tue, 16 Sep 2025 00:19:20 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f17:6d00:961b:d261:4569:b9c8?
 (p200300ef2f176d00961bd2614569b9c8.dip0.t-ipconnect.de.
 [2003:ef:2f17:6d00:961b:d261:4569:b9c8])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07b333437bsm1086020366b.95.2025.09.16.00.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Sep 2025 00:19:20 -0700 (PDT)
Message-ID: <3f256fea-0add-413b-939e-b2d252415bfa@suse.com>
Date: Tue, 16 Sep 2025 09:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Wang <liwang@redhat.com>
References: <CAEemH2e0TUFeWS7mjfz5FVW_Jb6Pv76YiEXLHY+ojwfGpvfWWw@mail.gmail.com>
 <CAEemH2cTiKAhn2hjr71Qn1-CRHBoFm_FH4Xp3BPQm1arrxUVTA@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAEemH2cTiKAhn2hjr71Qn1-CRHBoFm_FH4Xp3BPQm1arrxUVTA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] kirk cannot handle env variable correctly
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiA5LzE2LzI1IDY6MzUgQU0sIExpIFdhbmcgd3JvdGU6Cj4KPiBBZnRlciBsb29raW5n
IGF0IHRoZSBsdHAucHksIGl0IG92ZXJyaWRlcyB0aGUgdXNlci1zZXQgTFRQX1RJTUVPVVRfTVVM
IAo+IGVudiB2YXJpYWJsZS4KPiBTbyBtYXliZSB3ZSBuZWVkIHRvIGVuYWJsZSB0aGF0IHRvIGNv
bmZpZyBieSAtLWVudiwgd2hhdCBkbyB5b3XCoHRoaW5rPwoKSW5kZWVkLCB0aGlzIGlzIGEgZmVh
dHVyZSB0aGF0IGRvZXNuJ3QgbWFrZSBtdWNoIHNlbnNlIGFueW1vcmUuIFdlIApzaG91bGQgZmV0
Y2ggZW52IHZhcmlhYmxlcyBmcm9tIHRoZSBjb21tYW5kIGxpbmUgYW5kIG5vdCBmcm9tIHRoZSAt
LWVudiAKb3B0aW9uLiBUaGlzIHdhcyBhZGRlZCB3aGVuIEZyYW1ld29yayBBUEkgd2FzIGEgcGx1
Z2luIGFuZCB3ZSBjb3VsZCAKaW1wbGVtZW50IG11bHRpcGxlIGZyYW1ld29ya3MsIGJ1dCBub3cg
d2Ugb25seSBzdXBwb3J0IExUUC4KCkknbSBjdXJyZW50bHkgd29ya2luZyBvbiBhIG5ldyBraXJr
IHZlcnNpb24sIHdoZXJlIG11bHRpcGxlIApjb21tdW5pY2F0aW9uIGNoYW5uZWxzIGFuZCBTVVQg
Y2FuIGJlIGltcGxlbWVudGVkIHNlcGFyYXRlbHkgaW4gb3JkZXIgdG8gCmNyZWF0ZSBjb21wbGV4
IHNjZW5hcmlvcy4gTXkgaWRlYSBpcyB0byByZW1vdmUgRnJhbWV3b3JrIEFQSSBhbmQgLS1lbnYg
CnZhcmlhYmxlIG5leHQgdG8gdGhhdC4gRm9yIG5vdyB3ZSBjYW4gbWVyZ2UgdGhpcyBwYXRjaC4K
Ci0gQW5kcmVhCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
