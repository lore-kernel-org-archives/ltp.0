Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EC7C47258
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 04:22:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3E3C3CF298
	for <ltp@archiver.kernel.org>; Sat, 20 Jan 2024 05:22:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6D203CB172
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 05:22:08 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F2CDA1A027DF
 for <ltp@lists.linux.it>; Sat, 20 Jan 2024 05:22:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705724526;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tbRi5zh4FLzyDzLBD30oMI3ZZXvLPrBk89En8uu/vzY=;
 b=DZowIyTrRp4LdKzenZmKfSJnxNATNANJU5QikhXMmA1rsN7XAnSSzAJdxQBjGQYTkpxAnU
 K/TOT/5G2bgo+R4ROC0iNieCJLPNK876kbnRfvu2ExY/TjYI6Y9g/Iff+WELuzsajhyYkk
 737iHl7id5wcraAgl+K+RIVqdW/wdB4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-417-jb9mAMPEPc2he9raKTTj-w-1; Fri, 19 Jan 2024 23:22:03 -0500
X-MC-Unique: jb9mAMPEPc2he9raKTTj-w-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-28c183f8205so1592702a91.3
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 20:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705724522; x=1706329322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tbRi5zh4FLzyDzLBD30oMI3ZZXvLPrBk89En8uu/vzY=;
 b=GQRtDJUkHo4iPUm1jB1towxoG5G53vcpfgQv/RGGJ2HGsIXcBq1re6xDXchr242cuH
 f1OuNsHG3MvqbH6KF1Yiwer/bWHGa2ERt6DBRNca3gvHVLGFONIOHoBpYbkTDYQMITcv
 MKArrCQP9ybvWGmSUxU26hmOGaD8q+tS6E/3y9L7+mFPT/GAtZOy7xEEFvafwLQ/6htk
 hWPiH7vJR7ccm2alnk6Cu126/UsA7IQ44l+PReAY5qGhPEE7lG1cEdW5U+sBpkHhutGr
 5nMSVfIAkQCYEeTvWOpOXmSRey4m8slUfE7fqtmxlBMXhMhK14+f1vSzdMFrucSWUFmd
 xPGQ==
X-Gm-Message-State: AOJu0Yz5XJRTu15UvoERqjxuNhocPTq7IDLYg7eDVJ0MVwDTXZ96UvEl
 +7DpdrgHbJoYCKtj/0MvzYZJvTiliHal1PYAg5LpiY0KS3T5H5M1nA8jWJWeIEEC1pkSzV+cicv
 9/bW0TA5yXCTxi79RxFzGa/oqZ7VNtW2a9jffdK1QbDSAYDz0XDdyeHd7G1UDpzXnQ5KPsr2SD2
 4XHbgyv7IceyAYEJBBdH65YbM=
X-Received: by 2002:a17:902:eb49:b0:1d7:15f1:bf7e with SMTP id
 i9-20020a170902eb4900b001d715f1bf7emr1066783pli.81.1705724522592; 
 Fri, 19 Jan 2024 20:22:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOol5RE8Nh+sotsTtD3iwvbH1OmZ9l+1T6tavXYrlHTUwkBFEEZV+0hf9VAophYcGBoVT4b9wVHvf/6Y/GR4Y=
X-Received: by 2002:a17:902:eb49:b0:1d7:15f1:bf7e with SMTP id
 i9-20020a170902eb4900b001d715f1bf7emr1066773pli.81.1705724522255; Fri, 19 Jan
 2024 20:22:02 -0800 (PST)
MIME-Version: 1.0
References: <20240119144322.41928-1-pvorel@suse.cz>
In-Reply-To: <20240119144322.41928-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Sat, 20 Jan 2024 12:21:50 +0800
Message-ID: <CAEemH2ceuoj+a2PK2pNStXYnsBcXM+g8JWkdd3Jj077xi+nm3A@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] swapon01: Test on all filesystems
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

SGkgUGV0ciwgQ3lyaWwsCgpPbiBGcmksIEphbiAxOSwgMjAyNCBhdCAxMDo0M+KAr1BNIFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gVGVzdCBvbiBhbGwgZmlsZXN5c3RlbXMg
dG8gaW5jcmVhc2UgY292ZXJhZ2UuCj4gU2tpcCBmaWxlc3lzdGVtcyB3aGljaCBkb2VzIG5vdCBz
dXBwb3J0IHN3YXAgKGN1cnJlbnRseSBiY2FjaGVmcywgYnRyZnMKPiBhbmQgdG1wZnMpLgo+Cj4g
VGVzdGVkIG9uIDUuMTAsIDYuNiBhbmQgNi43Lgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3Jl
bCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gSGkgTGksIEN5cmlsLAo+Cj4gZmVlbCBmcmVlIHRv
IHBvc3Rwb25lIHRoaXMgYWZ0ZXIgdGhlIHJlbGVhc2UuCj4gSWYgd2UgYXJlIGZvciBhZGRpbmcg
dGhpcywgSSdsbCByZXRlc3Qgb24gTW9uZGF5IG9sZGVyIGZpbGVzeXN0ZW1zLgo+Cj4gbWFuIHN3
YXBvbig4KSBtZW50aW9uczoKPgo+ICAgIEJ0cmZzCj4gICAgICAgIFN3YXAgZmlsZXMgb24gQnRy
ZnMgYXJlIHN1cHBvcnRlZCBzaW5jZSBMaW51eCA1LjAgb24gZmlsZXMgd2l0aAo+IG5vY293Cj4g
ICAgICAgIGF0dHJpYnV0ZS4gU2VlIHRoZSBidHJmcyg1KSBtYW51YWwgcGFnZSBmb3IgbW9yZSBk
ZXRhaWxzLgo+Cj4gPT4gQ2FuIHdlIHBhc3MgIm5vY293IiBqdXN0IHRvIGJ0cmZzPyBPciBzaG91
bGQgaXQgYmUgYWRkZWQgdG8gc2luZ2xlCj4gdGVzdCwgd2hpY2ggdXNlcyBqdXN0IGJ0cmZzIHdp
dGggbm9jb3c/Cj4KPiAgICBORlMKPiAgICAgICAgU3dhcCBvdmVyIE5GUyBtYXkgbm90IHdvcmsu
Cj4KPiA9PiBJIGd1ZXNzIHRoaXMgaXMgbm90IGltcG9ydGFudCBmb3IgdXMsIGFzIE5GUyBpcyBu
b3QgcGFydCBvZgo+IGZpbGVzeXN0ZW1zIGluIC5hbGxfZmlsZXN5c3RlbXMsIGJ1dCBtYXliZSB3
ZSBzaG91bGQgc3RpbGwgYWRkIGl0IHRvIHRoZQo+IHdoaXRlbGlzdD8KPgo+IEtpbmQgcmVnYXJk
cywKPiBQZXRyCj4KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEu
YyB8IDIxICsrKysrKysrKysrKysrKy0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgMTUgaW5zZXJ0
aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3N3YXBvbi9zd2Fwb24wMS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L3N3YXBvbi9zd2Fwb24wMS5jCj4gaW5kZXggZTU5ZmIyMGExLi5lZjRlYmZkY2YgMTAwNjQ0Cj4g
LS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zd2Fwb24vc3dhcG9uMDEuYwo+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc3dhcG9uL3N3YXBvbjAxLmMKPiBAQCAtOCw2ICs4
LDcgQEAKPiAgICogW0Rlc2NyaXB0aW9uXQo+ICAgKgo+ICAgKiBDaGVja3MgdGhhdCBzd2Fwb24o
KSBzdWNjZWRzIHdpdGggc3dhcGZpbGUuCj4gKyAqIFRlc3Rpbmcgb24gYWxsIGZpbGVzeXN0ZW1z
IHdoaWNoIHN1cHBvcnQgc3dhcCBmaWxlLgo+ICAgKi8KPgo+ICAjaW5jbHVkZSA8dW5pc3RkLmg+
Cj4gQEAgLTE3LDEzICsxOCwxNCBAQAo+ICAjaW5jbHVkZSAibGFwaS9zeXNjYWxscy5oIgo+ICAj
aW5jbHVkZSAibGlic3dhcC5oIgo+Cj4gLSNkZWZpbmUgU1dBUF9GSUxFICJzd2FwZmlsZTAxIgo+
ICsjZGVmaW5lIE1OVFBPSU5UICAgICAgICJtbnRwb2ludCIKPiArI2RlZmluZSBTV0FQX0ZJTEUg
ICAgICBNTlRQT0lOVCIvc3dhcGZpbGUwMSIKPgo+ICBzdGF0aWMgdm9pZCB2ZXJpZnlfc3dhcG9u
KHZvaWQpCj4gIHsKPiAgICAgICAgIFRTVF9FWFBfUEFTUyh0c3Rfc3lzY2FsbChfX05SX3N3YXBv
biwgU1dBUF9GSUxFLCAwKSk7Cj4KPiAtICAgICAgIGlmIChUU1RfUEFTUyAmJiB0c3Rfc3lzY2Fs
bChfX05SX3N3YXBvZmYsIFNXQVBfRklMRSkgIT0gMCkgewo+ICsgICAgICAgaWYgKHRzdF9zeXNj
YWxsKF9fTlJfc3dhcG9mZiwgU1dBUF9GSUxFKSAhPSAwKSB7Cj4gICAgICAgICAgICAgICAgIHRz
dF9icmsoVEJST0sgfCBURVJSTk8sCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAi
RmFpbGVkIHRvIHR1cm4gb2ZmIHN3YXBmaWxlLCBzeXN0ZW0KPiByZWJvb3QgcmVjb21tZW5kZWQi
KTsKPiAgICAgICAgIH0KPiBAQCAtMzEsMTMgKzMzLDIwIEBAIHN0YXRpYyB2b2lkIHZlcmlmeV9z
d2Fwb24odm9pZCkKPgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICB7Cj4gLSAgICAgICBp
c19zd2FwX3N1cHBvcnRlZChTV0FQX0ZJTEUpOwo+ICAgICAgICAgbWFrZV9zd2FwZmlsZShTV0FQ
X0ZJTEUsIDApOwo+ICB9Cj4KPiAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+IC0g
ICAgICAgLm5lZWRzX3Jvb3QgPSAxLAo+IC0gICAgICAgLm5lZWRzX3RtcGRpciA9IDEsCj4gKyAg
ICAgICAubW50cG9pbnQgPSBNTlRQT0lOVCwKPiArICAgICAgIC5tb3VudF9kZXZpY2UgPSAxLAo+
ICsgICAgICAgLm5lZWRzX3Jvb3QgPSAxLCAvKiBmb3Igc3dhcG9uKCkgKi8KPiArICAgICAgIC5h
bGxfZmlsZXN5c3RlbXMgPSAxLAo+ICAgICAgICAgLnRlc3RfYWxsID0gdmVyaWZ5X3N3YXBvbiwK
PiAtICAgICAgIC5zZXR1cCA9IHNldHVwCj4gKyAgICAgICAuc2V0dXAgPSBzZXR1cCwKPiArICAg
ICAgIC5za2lwX2ZpbGVzeXN0ZW1zID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4gKyAgICAgICAgICAg
ICAgICJiY2FjaGVmcyIsCj4gKyAgICAgICAgICAgICAgICJidHJmcyIsCj4gKyAgICAgICAgICAg
ICAgICJ0bXBmcyIsCj4gKyAgICAgICAgICAgICAgIE5VTEwKPiArICAgICAgIH0sCj4KCgpJTUhP
LCBJIGhhdGUgdG8gYWRkIHRoZSBza2lwX2ZpbGVzeXN0ZW0gaW4gdGhpcyB0ZXN0LCBiZWNhdXNl
IGlmIHdlIGRvLAp0aGVuIHdlIGhhdmUgdG8gYWRkIHRvIGFsbCBvZiB0aGUgcmVsYXRlZCBzd2Fw
IHRlc3RzIHRoYXQsIGl0IGFkZCBtb3JlCnRlZGlvdXMgd29yayB0byBwZW9wbGUuCgpTbywgaWYg
d2UgZGVjaWRlIHRvIHBvc3Rwb25lIHRoaXMgcGF0Y2ggdG8gcmVsZWFzZSwgd2UgY2FuIGp1c3Qg
cmVmYWN0b3IKdGhlIGlzX3N3YXBfc3VwcG9ydGVkKCkgZnVuY3Rpb24gdG8gbWFrZSB0aGluZ3Mg
ZWFzaWVyLiBJIHdpbGwgc2VuZCBhbiBSRkMKcGF0Y2ggdG8gc2hvdyBzb21ldGhpbmcgaW4gbXkg
bWluZCwgd2hhdCB3ZSBuZWVkIHRvIGRvIGxhdGVyIGlzIGp1c3QKdG8gZmluYWxpemUgdGhlIHN3
YXBfc3VwcG9ydGVkX2ZzW10gc3RydWN0IGxpc3QuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
