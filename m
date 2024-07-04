Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07D3AC3065C
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 07:13:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7816F3D3CF5
	for <ltp@archiver.kernel.org>; Thu,  4 Jul 2024 09:13:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CF783D3CC4
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:13:04 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AF460617639
 for <ltp@lists.linux.it>; Thu,  4 Jul 2024 09:13:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720077182;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqPIUy9kYLYuHx3kFVnXzMJJuKvgrFQnp02+khH2o7s=;
 b=GXSmee3XkhJTACTwuQjR1xCCy6B319HyRQPEP8PBVbza8g5IrzWb8ZrOTn08JVvwnb+hrG
 MB2JJcHTW2/PX9a9MTGoJQyVELjfueD5egd8FPxoB59oVsI9JTCRmqpCK0KlYczuR0BHFr
 ets2YvvAcxt9AP1lY39rcNMzVgvNHcA=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-jIIMhD1-PJ6r-HN3AFzRlg-1; Thu, 04 Jul 2024 03:12:59 -0400
X-MC-Unique: jIIMhD1-PJ6r-HN3AFzRlg-1
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-6fd42bf4316so184508a12.2
 for <ltp@lists.linux.it>; Thu, 04 Jul 2024 00:12:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077178; x=1720681978;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xqPIUy9kYLYuHx3kFVnXzMJJuKvgrFQnp02+khH2o7s=;
 b=CFZfhagEr66DAn8xBC2TBgQXe7rw8nuxp8GPeasnjp+MZvQ3oOTpuJFkXpnEjdSynU
 PmST3VRAfq8p1z7wkNAW+2wTVQBEenPClBHXhaMsx79m/Y7R+h1k3U7ZMjkTIplAPHQA
 LbNWOV7tl/nwozIuvygLQERbRucebYPfvCXfo+FsF6TEC/BQG5PxdhdbYgmpx6ALKHml
 V4FWi6Znmtgh1YaACFD8s/uQBL7QEyXdbDwfnhXas9Cjh9+q5h1SIpYV+2y6BHofgjWB
 pVJsF/YAhsnvv6CMZWDvwGBndCEBQhH3O9XDVETvsArkyepql0IRzJnL6/AwKqMvdwdS
 FGaQ==
X-Gm-Message-State: AOJu0Yy1+wz8PZ/NDo3+1NIjIaNbHoBKq4R6udyGyJ95BJ+z6+rPRxgH
 OW8vO8I51EZYXxiPemE7IeAaEost67XjfbzAF062ynFrhex6rFYiA2rBWV11EMDoe6n8dCl4LX2
 vCqY2fpLfyK6HjBiiyS5pXzkDT1H+p+mAeW4Xt1R9V2bInfLX25SdlxGxxC51doG2ntRsj79oUb
 TxG5CSAUbaA49kL7j87bFPv7U=
X-Received: by 2002:a05:6a20:8401:b0:1be:ccea:41ea with SMTP id
 adf61e73a8af0-1c0cc8baaf5mr672842637.49.1720077178242; 
 Thu, 04 Jul 2024 00:12:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEOfT+98b7Rb8rd5N79wSwICH4Y/De6ITovRGmCZof6Q3EL9EdKQqm3LkMlxbg3PGyc99Enj60qENTxFekHdHY=
X-Received: by 2002:a05:6a20:8401:b0:1be:ccea:41ea with SMTP id
 adf61e73a8af0-1c0cc8baaf5mr672831637.49.1720077177853; Thu, 04 Jul 2024
 00:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240702-stat04-v1-0-e27d9953210d@suse.com>
 <20240702-stat04-v1-4-e27d9953210d@suse.com>
In-Reply-To: <20240702-stat04-v1-4-e27d9953210d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 4 Jul 2024 15:12:46 +0800
Message-ID: <CAEemH2epWS2OO3b+H_A=SHLnWp_yS_xpbh+rvW1v0vNBXu2VAw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/5] Add chmod08 test
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

T24gVHVlLCBKdWwgMiwgMjAyNCBhdCAxMDoxNeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBUaGlzIHRlc3QgaGFzIGJlZW4gZXh0cmFjdGVk
IGZyb20gc3ltbGluazAxIGFuZCBpdCB2ZXJpZmllcyB0aGF0Cj4gY2htb2QoKSBpcyB3b3JraW5n
IGNvcnJlY3RseSBvbiBzeW1saW5rKCkgZ2VuZXJhdGVkIGZpbGVzLgo+Cj4gU2lnbmVkLW9mZi1i
eTogQW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgoKUmV2aWV3
ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0tCj4gIHJ1bnRlc3Qvc3lzY2Fs
bHMgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsKPiAgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9jaG1vZC8uZ2l0aWdub3JlIHwgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2NobW9kL2NobW9kMDguYyAgfCA0NQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kwo+ICAzIGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9y
dW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwo+IGluZGV4IGQ3OGI2ODIyYi4uOTI4
ZTc1ZjliIDEwMDY0NAo+IC0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMKPiArKysgYi9ydW50ZXN0L3N5
c2NhbGxzCj4gQEAgLTcyLDYgKzcyLDcgQEAgY2htb2QwMyBjaG1vZDAzCj4gIGNobW9kMDUgY2ht
b2QwNQo+ICBjaG1vZDA2IGNobW9kMDYKPiAgY2htb2QwNyBjaG1vZDA3Cj4gK2NobW9kMDggY2ht
b2QwOAo+Cj4gIGNob3duMDEgY2hvd24wMQo+ICBjaG93bjAxXzE2IGNob3duMDFfMTYKPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jaG1vZC8uZ2l0aWdub3JlCj4gYi90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NobW9kLy5naXRpZ25vcmUKPiBpbmRleCAyN2RkZmNl
MTYuLmYyOTVmNGRjYiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2No
bW9kLy5naXRpZ25vcmUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NobW9kLy5n
aXRpZ25vcmUKPiBAQCAtMywzICszLDQgQEAKPiAgL2NobW9kMDUKPiAgL2NobW9kMDYKPiAgL2No
bW9kMDcKPiArL2NobW9kMDgKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9jaG1vZC9jaG1vZDA4LmMKPiBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2htb2QvY2ht
b2QwOC5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLjdlZjM5NjM0
OAo+IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2NobW9k
L2NobW9kMDguYwo+IEBAIC0wLDAgKzEsNDUgQEAKPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IEdQTC0yLjAtb3ItbGF0ZXIKPiArLyoKPiArICogQ29weXJpZ2h0IChjKSAyMDAwIFNpbGlj
b24gR3JhcGhpY3MsIEluYy4gIEFsbCBSaWdodHMgUmVzZXJ2ZWQuCj4gKyAqICAgIEF1dGhvcjog
RGF2aWQgRmVubmVyCj4gKyAqICAgIENvcGlsb3Q6IEpvbiBIZW5kcmlja3Nvbgo+ICsgKiBDb3B5
cmlnaHQgKEMpIDIwMjQgQW5kcmVhIENlcnZlc2F0byBhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29t
Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqIFtEZXNjcmlwdGlvbl0KPiArICoKPiArICogVGhpcyB0
ZXN0IHZlcmlmaWVzIHRoYXQgY2htb2QoKSBpcyB3b3JraW5nIGNvcnJlY3RseSBvbiBzeW1saW5r
KCkKPiArICogZ2VuZXJhdGVkIGZpbGVzLgo+ICsgKi8KPiArCj4gKyNpbmNsdWRlICJ0c3RfdGVz
dC5oIgo+ICsKPiArI2RlZmluZSBQRVJNUyAwMTc3Nwo+ICsjZGVmaW5lIFRFU1RGSUxFICJteW9i
amVjdCIKPiArCj4gK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICt7Cj4gKyAgICAgICBjaGFyICpz
eW1uYW1lID0gIm15X3N5bWxpbmswIjsKPiArICAgICAgIHN0cnVjdCBzdGF0IG9sZHN5bV9zdGF0
Owo+ICsgICAgICAgc3RydWN0IHN0YXQgbmV3c3ltX3N0YXQ7Cj4gKwo+ICsgICAgICAgU0FGRV9U
T1VDSChURVNURklMRSwgMDY0NCwgTlVMTCk7Cj4gKyAgICAgICBTQUZFX1NZTUxJTksoVEVTVEZJ
TEUsIHN5bW5hbWUpOwo+ICsgICAgICAgU0FGRV9TVEFUKHN5bW5hbWUsICZvbGRzeW1fc3RhdCk7
Cj4gKwo+ICsgICAgICAgVFNUX0VYUF9QQVNTKGNobW9kKHN5bW5hbWUsIFBFUk1TKSk7Cj4gKyAg
ICAgICBTQUZFX1NUQVQoc3ltbmFtZSwgJm5ld3N5bV9zdGF0KTsKPiArCj4gKyAgICAgICBUU1Rf
RVhQX0VRX0xJKG5ld3N5bV9zdGF0LnN0X21vZGUgJiBQRVJNUywgUEVSTVMpOwo+ICsgICAgICAg
VFNUX0VYUF9FWFBSKG9sZHN5bV9zdGF0LnN0X21vZGUgIT0gbmV3c3ltX3N0YXQuc3RfbW9kZSwK
PiArICAgICAgICAgICAgICAgImZpbGUgbW9kZSBoYXMgY2hhbmdlZCIpOwo+ICsKPiArICAgICAg
IFNBRkVfVU5MSU5LKHN5bW5hbWUpOwo+ICsgICAgICAgU0FGRV9VTkxJTksoVEVTVEZJTEUpOwo+
ICt9Cj4gKwo+ICtzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gKyAgICAgICAudGVz
dF9hbGwgPSBydW4sCj4gKyAgICAgICAubmVlZHNfdG1wZGlyID0gMSwKPiArfTsKPgo+IC0tCj4g
Mi40My4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
