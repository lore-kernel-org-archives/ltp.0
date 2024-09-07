Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CA86E6FE49
	for <ltp@archiver.kernel.org>; Sat,  7 Sep 2024 02:06:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF8013C053B
	for <ltp@archiver.kernel.org>; Sat,  7 Sep 2024 04:06:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4BF773C0214
 for <ltp@lists.linux.it>; Sat,  7 Sep 2024 04:05:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id EEFAC60078E
 for <ltp@lists.linux.it>; Sat,  7 Sep 2024 04:05:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725674753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xrsZ3exl04rPXgRvWcB3d8p4+pb+WS7uMsPZ5jLiE7E=;
 b=HwillCJigW/J1YCJUqPbnplAyauFF1w6zJitCwUPyVl82wggnYoz/xa6MGdcy5a908NgkE
 nMDpb//jZo2pQyCUr769ZiqKUh1cfMFEW6VzFAFl1KrdaHTlqlFgTz3iQH0EE0SfP1Nncl
 DmizSIyBVdfQrCaIL+zrNPC0gXNEBnw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-P5c_LbkjPqaLB2xaM4-2Kg-1; Fri, 06 Sep 2024 22:05:52 -0400
X-MC-Unique: P5c_LbkjPqaLB2xaM4-2Kg-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2d8759255d4so3139455a91.3
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 19:05:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725674751; x=1726279551;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=F1yybrZQ6i9SnDVlXkWk/r5awpckzhCrHaf/ySJ4gQ4=;
 b=Rwuk59Y1zs7kS3sYbjv90qBRzNI2d1SSd68CpG8vUo3MbqdlLkNYm7OOe6iJdKtBZh
 2xsxg/+LBzu4CeRchrdEAF9KDj9JUat0CSBUbpHRbH+ehNPyKH+H0kAkNBw65Je1yeI3
 Y36/zeWANLlD1lT48oqunS2kEVDkFFbz690vXxa9+E61pZTnIlEJyvUIEGm4LtEJmCeQ
 xw0xWz47L9sDo/O3zzoYO61t4Phtih5VdVzxCJ9GRUe3t0EDpND0M2X1xRMMiTzPdhVg
 ftnU3v6o6f4FW31WcfiaROyCdIvW40EujlPIk76+usSRAnoQVRGSNYtyRoVrIgDeAUQ7
 tF6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtOUomgk4uQovnt/xXo6Ivb5Yc3pyHv06d3y/dLfYqlibEXlsxf0uJsYebbUSsD/TCtn4=@lists.linux.it
X-Gm-Message-State: AOJu0Yz7u8GHV6bGQR+rwetB62GTy0R9ya8yKd/dFlhP6CqeFaX2AN3M
 ks39sdvp1Cy0HVaygCVu+QnvtvXocwvs8V+TvLfhhmdIlxKJ7IKNVmgCPdyKEY8yjFOE2H/JxZB
 nagIC0nACQx5sTPcoscuLGur82daLblABIvv4oEcYt1we2Z4YoR+s5TV7fSn9Fu5DL5X9iBUEuJ
 Z6+XcDWP5uVA+YKgqud9Rtjkc=
X-Received: by 2002:a17:90b:a51:b0:2da:5028:cfb9 with SMTP id
 98e67ed59e1d1-2dad4ddb880mr5659743a91.4.1725674751088; 
 Fri, 06 Sep 2024 19:05:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOHAslfMOfBtK1y0hf0+C/DYNg4H2FnowZJRFZfDl6lqJmW8FqB8zNQlHbMjgfKS7pO1UX1REX9mw61qVt3WI=
X-Received: by 2002:a17:90b:a51:b0:2da:5028:cfb9 with SMTP id
 98e67ed59e1d1-2dad4ddb880mr5659725a91.4.1725674750681; Fri, 06 Sep 2024
 19:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240903140326.773060-1-pvorel@suse.cz>
 <ZtcoDmsWrMu8Qaze@yuki.lan>
 <20240904053157.GA836933@pevik> <Ztgfu4bTVyw7hvdP@yuki.lan>
 <CAEemH2edp0xmW=LQzvGPeukqh=NXai6N-3J7fgLcOm5eTkvO+Q@mail.gmail.com>
 <ZthnmE5TB3Ji44lN@yuki.lan>
In-Reply-To: <ZthnmE5TB3Ji44lN@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Sat, 7 Sep 2024 10:05:38 +0800
Message-ID: <CAEemH2cW0AZBnspm3jwWe7C6-MRYwJNk6ZgNdDr1tBYnhFkzhg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/1] swapoff01: Define max_runtime 45s
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

T24gV2VkLCBTZXAgNCwgMjAyNCBhdCAxMDowMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJJ20gd29uZGVyaW5nIHdoaWNoIGRpc3RyaWJ1dGlv
biAoYW5kIGtlcm5lbCB2ZXJzaW9uKSBkaWQgeW91IHVzZSBvbgo+IHJhc3BpLTA/Cj4KPiBUaGUg
ZGVmYXVsdCByYXNwYmlhbi4gVGhlIGRpZmZlcmVuY2UgSSBndWVzcyBpcyB0aGF0IFJQaSBaZXJv
IGlzIGEKPiBzaW5nbGUgQVJNdjYgaWYgSSdtIGxvb2tpbmcgcmlnaHQgaXQncyB0aGUgc2FtZSBD
UFUgYXMgb24gdGhlIG9yaWdpbmFsCj4gUlBpLiBUaGF0J3Mgd2F5IHNsb3dlciB0aGFuIHF1YWQg
Q29ydGV4LUE3MiBvbiBSUGkgNC4KPgo+ID4gTXkgcmFzcGk0KHVidW50dS0yNCwgNi44LjAtMTAx
MCwgQ29ydGV4LUE3MikgdGFrZXMgYSBsaXR0bGUgZmFzdGVyLgo+ID4KPiA+IGV4dDI6IDEycwo+
ID4gZXh0MzogMTJzCj4gPiBleHQ0OiAwLjRzCj4gPiBudGZzOiA0NnMKPiA+IGV4ZmF0OiBza2lw
Cj4KPiBJIHN1cHBvc2UgdGhhdCB0aGlzIGlzIHN0aWwgc2xvdyBvbiBSUGkgNCBiZWNhdXNlIHRo
ZSByb290ZnMgaXMgb24gYSBTRAo+IGNhcmQsIHNpbmNlIHRoZSBDUFUgb24gUlBpIDQgaXMgd2F5
IGZhc3RlciB0aGFuIFJQaSBaZXJvLgo+CgpZZXMsIGV4YWN0bHkuCgpAUGV0ciwgaWYgeW91IHBs
YW5uaW5nIHRvIHNlbmQgb3V0IFYzLCBJIHRoaW5rIGl0IGlzIGJldHRlciB0byBzZXQgYSBwcm9w
ZXIKdmFsdWUKZm9yIG1heF9ydW50aW1lIGluIHN3YXBvbjAxIHNpbXVsdGFuZW91c2x5LiBTaW5j
ZSBvdXIgQ0kgam9icyBjYXRjaCB0aGF0IG9uZQp0aW1lb3V0IG91dCBzcG9yYWRpY2FsbHkgdG9v
LgoKICAgICA3CXRzdF9kZXZpY2UuYzo5NjogVElORk86IEZvdW5kIGZyZWUgZGV2aWNlIDAgJy9k
ZXYvbG9vcDAnCiAgICAgOAl0c3RfdGVzdC5jOjE3MzM6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAy
NDA1MjQKCiAgICAgOQl0c3RfdGVzdC5jOjE2MTc6IFRJTkZPOiBUaW1lb3V0IHBlciBydW4gaXMg
MGggMDFtIDAwcwoKICAgIDEwCXRzdF9zdXBwb3J0ZWRfZnNfdHlwZXMuYzo5NjogVElORk86IEtl
cm5lbCBzdXBwb3J0cyBleHQyCiAgICAxMQl0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NjE6IFRJ
TkZPOiBta2ZzLmV4dDIgZG9lcyBleGlzdAoKCiAgICA2MQl0c3RfdGVzdC5jOjE2OTM6IFRJTkZP
OiA9PT0gVGVzdGluZyBvbiB2ZmF0ID09PQogICAgNjIJdHN0X3Rlc3QuYzoxMTA2OiBUSU5GTzog
Rm9ybWF0dGluZyAvZGV2L2xvb3AwIHdpdGggdmZhdCBvcHRzPScnCmV4dHJhIG9wdHM9JycKICAg
IDYzCXRzdF90ZXN0LmM6MTEyMDogVElORk86IE1vdW50aW5nIC9kZXYvbG9vcDAgdG8KL21udC90
ZXN0YXJlYS9sdHAtdWtLN1gwbmhjcy9MVFBfc3dha0NkNDYyL21udHBvaW50IGZzdHlwPXZmYXQg
ZmxhZ3M9MAogICAgNjQJbGlic3dhcC5jOjE5ODogVElORk86IGNyZWF0ZSBhIHN3YXBmaWxlIHNp
emUgb2YgMSBtZWdhYnl0ZXMgKE1CKQogICAgNjUJdHN0X2lvY3RsLmM6MjY6IFRJTkZPOiBGSUJN
QVAgaW9jdGwgaXMgc3VwcG9ydGVkCiAgICA2Nglzd2Fwb24wMS5jOjQxOiBUSU5GTzogY3JlYXRl
IGEgc3dhcGZpbGUgc2l6ZSBvZiAxMjggbWVnYWJ5dGVzIChNQikKICAgIDY3CXN3YXBvbjAxLmM6
Mjc6IFRQQVNTOiB0c3Rfc3lzY2FsbChfX05SX3N3YXBvbiwgU1dBUF9GSUxFLCAwKSBwYXNzZWQK
ICAgIDY4CXRzdF90ZXN0LmM6MTY3MTogVElORk86IElmIHlvdSBhcmUgcnVubmluZyBvbiBzbG93
IG1hY2hpbmUsIHRyeQpleHBvcnRpbmcgTFRQX1RJTUVPVVRfTVVMID4gMQogICAgNjkJdHN0X3Rl
c3QuYzoxNjczOiBUQlJPSzogVGVzdCBraWxsZWQhICh0aW1lb3V0PykKCgoKLS0gClJlZ2FyZHMs
CkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
