Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB328C4450A
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 13:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784208700; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=x/DMBnYx23WwMWjxiMtM0N8m0wneqi+R4T7liFbtD9I=;
 b=kcBlk8xTWnGMPkldrDPcJNxfwbWzcohM1dbx2Z0nOsHeibG42LaWSWIEmEYXIv8XM14JJ
 6kogfFDs4blb92AK5B9lnCvjCHV7cSNbTa1mPCsGwrUB5ZYX32Nv+Hiv77hDY/TpvI0kqxo
 gPuh7A+Ozrg06YbdvNAnsg71F7fl8Rk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4E8263E565F
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 15:31:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFAFC3E2580
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:31:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2FDD91400C78
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 15:31:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784208677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s+1chXq+4uoWQSBFR+KCRAKYhkJhD8AxfMNGLnU6MM8=;
 b=IN/v5XxTs79jHmcNlD610e3rtbe7mP+/BW8yJRVPzjyIzWbremCMDUlISdIL8QBkTv4fqo
 E69SeydaGhk/TgisDrNYin71uJYw7HND2jxh0WzAp5yygaqB+EG2IsEjTbh9HikSMWzQR6
 UVHJWvvUS3DEyhYXtY7goeDtlbY7+TA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-81-cF2PvffOOImfjP16qk9FVQ-1; Thu, 16 Jul 2026 09:31:15 -0400
X-MC-Unique: cF2PvffOOImfjP16qk9FVQ-1
X-Mimecast-MFC-AGG-ID: cF2PvffOOImfjP16qk9FVQ_1784208673
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-46fb9079a04so3331595f8f.3
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 06:31:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784208673; x=1784813473;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=s+1chXq+4uoWQSBFR+KCRAKYhkJhD8AxfMNGLnU6MM8=;
 b=nCWO5WwhsaGu1nkVYGht1YoCHJaX7jHRTeQB9CXB0Dc8URbUtV5QSk/8XvHaQuKPpj
 d+vyHQ9Oes9gEFMRgB18nq6OaHv+A9p5ikdEU1UVBwdqDSdBnToD2ZgcG/1WLlWxqSGV
 4zWsBe2A69iGljeTLnwWBLy9fE+VIQsj+GMFxczNR3iOpgaUKaQTIGcQxWIfp2GwiDDd
 2/IF104axbnxdNdOArwV3JQiwM+3vCJ9bsxj6+Gxko7o6ejVDPn7MDmd7ufso+O3lXm2
 S/cWhcQCzH7dh8PiBZI3xEDCU5xR0M428Ph/IeM0cbnDMHOGCgY4ZVH5f6ErS3FIA+Us
 /KKw==
X-Gm-Message-State: AOJu0YwegZRHwJnVWwo5Z5ziMI75TRhkE4ylyQPJ0KgqGBKen6teEM+8
 bbx0m4aczmH2OE/6YXHsiBzTr4H1FldxUkb8aT63TnqcxdLfeaI+IiAxKzON4s6LFXuWQEAeZ5B
 KjVDmX0ICz+n0LFc62NTYbAfVqG5bff/GDP0WNoBVLjRiFTePv5aJdJXdRwIJfuoWlgKjffCMli
 d0I61dvETSadBeXMxeKL2TTQCxd2q64NghHBt5
X-Gm-Gg: AfdE7cl0YPiatbWpC4nM/JkurzdjI44DPMHHiWaXp21+UPrjDPtycyACV4ON7hlg8bY
 0jPEHUtX/ul/IHAFPTHh6jO8ATQkoVIpe/fc8mCUUcgL2giZGjqJ7sIG1KLtdKzNHSWA2XmBXGu
 bSRnMJF6QGCuaZSqUcWyEPbZHObP6SinLNewinlGHDuYZItz7BNiS3+t5/CKKeR2aacQsGM5I3B
 R/bdzQgFPR889a226MBZ1E7mvf59ROMfBKHowD5Zku2kh2OOpQeWbhdCnO7nh6qFLNIohuKZpiG
 kxwwfri4m/DsvLgD5J1GDPhCY7ytHp+WlacBaXrKR3FKdXcrrz9r+Sc8kH9wn0VyXU86F5hq5Rg
 Pu5yVGknnRhVJ2/gtNKU8eDnZVA0NghwN4bpRXsEtWeiRMc5CIw==
X-Received: by 2002:a05:6000:2990:10b0:462:ce05:c5e4 with SMTP id
 ffacd0b85a97d-47f46373ed7mr11159547f8f.37.1784208672686; 
 Thu, 16 Jul 2026 06:31:12 -0700 (PDT)
X-Received: by 2002:a05:6000:2990:10b0:462:ce05:c5e4 with SMTP id
 ffacd0b85a97d-47f46373ed7mr11159476f8f.37.1784208672056; 
 Thu, 16 Jul 2026 06:31:12 -0700 (PDT)
Received: from fedora.redhat.com (85.64.193.120.dynamic.barak-online.net.
 [85.64.193.120]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f4635c86csm24900918f8f.16.2026.07.16.06.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 06:31:11 -0700 (PDT)
To: ltp@lists.linux.it
Date: Thu, 16 Jul 2026 16:31:06 +0300
Message-ID: <20260716133108.13003-1-mmenashe@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZnlWdJI7RD1zi4etnqYRei-TT8W2LNDL-l5IPQKhAPU_1784208673
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v17 0/2] futex: Add EFAULT error coverage tests
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClRoYW5rcyBmb3IgdGhlIHJldmlldy4gSGVyZSBpcyB2MTcgYWRkcmVzc2luZyB5
b3VyIGZlZWRiYWNrLgoKZnV0ZXhfd2FpdDA2IGFuZCBmdXRleF93YWl0MDcgd2VyZSBhbHJlYWR5
IG1lcmdlZC4gVGhpcyBzZXJpZXMgY29udGFpbnMKdGhlIHJlbWFpbmluZyB0d28gcGF0Y2hlcy4K
CmZ1dGV4X2NtcF9yZXF1ZXVlMDM6CiAgQXBwbGllZCB5b3VyIG5pdCDigJQgcmVtb3ZlZCB0aGUg
ZXhwX2Vycm5vIGZpZWxkIGZyb20gdGhlIHRlc3RjYXNlIHN0cnVjdAogIGFuZCB1c2VkIEVGQVVM
VCBkaXJlY3RseSBpbiBUU1RfRVhQX0ZBSUwoKS4KCmZ1dGV4X3dha2UwNToKICBBcHBsaWVkIGJv
dGggbml0cyAobGlzdCBjb21tZW50IGZvcm1hdCwgRUZBVUxUIGRpcmVjdGx5KS4gRm9yIHRoZQog
IGtlcm5lbC1zcGFjZSBhZGRyZXNzIGNhc2U6IHlvdSB3ZXJlIHJpZ2h0IHRvIHF1ZXN0aW9uIGl0
LiBJIGNvdWxkbid0CiAgY29uZmlybSBjb25zaXN0ZW50IEVGQVVMVCBhY3Jvc3Mga2VybmVscywg
c28gSSBsb29rZWQgZm9yIGEgYmV0dGVyCiAgcmVwbGFjZW1lbnQuCgogIEkgdXNlZCBBSSBhc3Np
c3RhbmNlIHRvIHJlc2VhcmNoIHRoZSBrZXJuZWwncyBnZXRfdXNlcl9wYWdlcygpIGNvZGUKICBw
YXRocyBhbmQgY3Jvc3MtcmVmZXJlbmNlZCBleGlzdGluZyBMVFAgbW1hcCB0ZXN0cyB0byB2ZXJp
ZnkgdGhlCiAgYXBwcm9hY2guIFRoZSByZXBsYWNlbWVudCBJIGxhbmRlZCBvbiBpcyBhIHNoYXJl
ZCBmaWxlLWJhY2tlZCBtYXBwaW5nCiAgd2hlcmUgdGhlIGZpbGUgaXMgdHJ1bmNhdGVkIHRvIDAg
YWZ0ZXIgbW1hcCgpLgoKICBUaGUgdGhyZWUgY2FzZXMgbm93IGV4ZXJjaXNlIGdlbnVpbmVseSBk
aWZmZXJlbnQgY29kZSBwYXRoczoKCiAgLSB1bm1hcHBlZCBtZW1vcnkgZmFpbHMgYXQgZmluZF92
bWEoKSAobm8gVk1BIGV4aXN0cykKICAtIFBST1RfTk9ORSBtZW1vcnkgZmFpbHMgYXQgZ2V0X3Vz
ZXJfcGFnZXNfZmFzdCgpIChWTUEgZXhpc3RzIGJ1dAogICAgcGFnZSBpcyBpbmFjY2Vzc2libGUp
CiAgLSB0aGUgdHJ1bmNhdGVkIGZpbGUgbWFwcGluZyB0cmlnZ2VycyBWTV9GQVVMVF9TSUdCVVMg
aW5zaWRlIHRoZSBwYWdlCiAgICBmYXVsdCBoYW5kbGVyIChmaWxlbWFwX2ZhdWx0KCkgc2VlcyBv
ZmZzZXQgYmV5b25kIEVPRiksIHdoaWNoCiAgICBnZXRfdXNlcl9wYWdlcygpIHByb3BhZ2F0ZXMg
YXMgRUZBVUxUCgogIFRoZSBTSUdCVVMgaXMgbmV2ZXIgZGVsaXZlcmVkIHRvIHVzZXIgc3BhY2Ug
4oCUIGdldF91c2VyX3BhZ2VzKCkgY29udmVydHMKICBWTV9GQVVMVF9TSUdCVVMgdG8gLUVGQVVM
VCBpbnRlcm5hbGx5LiBUaGlzIGJlaGF2aW9yIGhhcyBiZWVuIHN0YWJsZQogIHNpbmNlIGJlZm9y
ZSBrZXJuZWwgMi42IGFuZCB3b3JrcyByZWxpYWJseSBvbiBhbGwgYXJjaGl0ZWN0dXJlcyBhbmQK
ICBib3RoIDMyLzY0LWJpdC4gVGhlIHRlc3QgdXNlcyAubmVlZHNfdG1wZGlyID0gMS4KCkNoYW5n
ZXMgc2luY2UgdjE2OgotIGZ1dGV4X3dha2UwNTogcmVwbGFjZSBrZXJuZWwtc3BhY2UgYWRkcmVz
cyBjYXNlIHdpdGggdHJ1bmNhdGVkCiAgZmlsZS1iYWNrZWQgbWFwcGluZywgZml4IGNvbW1lbnQg
dG8gbGlzdCBmb3JtYXQsIHVzZSBFRkFVTFQgZGlyZWN0bHkKICBpbiBUU1RfRVhQX0ZBSUwoKSwg
YWRkIC5uZWVkc190bXBkaXIKLSBmdXRleF9jbXBfcmVxdWV1ZTAzOiB1c2UgRUZBVUxUIGRpcmVj
dGx5IGluIFRTVF9FWFBfRkFJTCgpCgpNaWNoYWVsIE1lbmFzaGVyb3YgKDIpOgogIGZ1dGV4X3dh
a2UwNTogQWRkIEVGQVVMVCBlcnJvciBjb3ZlcmFnZSB0ZXN0CiAgZnV0ZXhfY21wX3JlcXVldWUw
MzogQWRkIEVGQVVMVCBlcnJvciBjb3ZlcmFnZSB0ZXN0CgogcnVudGVzdC9zeXNjYWxscyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICsKIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvZnV0ZXgvLmdpdGlnbm9yZSAgICB8ICAgMiArCiAuLi4vc3lzY2FsbHMvZnV0ZXgvZnV0ZXhf
Y21wX3JlcXVldWUwMy5jICAgICAgfCAxMDMgKysrKysrKysrKysrKysrKwogLi4uL2tlcm5lbC9z
eXNjYWxscy9mdXRleC9mdXRleF93YWtlMDUuYyAgICAgIHwgMTEzICsrKysrKysrKysrKysrKysr
KwogNCBmaWxlcyBjaGFuZ2VkLCAyMjAgaW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnV0ZXgvZnV0ZXhfY21wX3JlcXVldWUwMy5jCiBj
cmVhdGUgbW9kZSAxMDA2NDQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mdXRleC9mdXRleF93
YWtlMDUuYwoKLS0gCjIuNTUuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
