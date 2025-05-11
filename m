Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13857C3ABC3
	for <ltp@archiver.kernel.org>; Sun, 11 May 2025 07:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746948892; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+vxdFFcOYt1wOS/o+UknBD8xGFil3Q9/61hXFSfuUxg=;
 b=I8w/DoeTBOchDelm6+mPHOfyWMUTMzrdumggKpiYEkW39AQYufMUdJA1IWaU+YKnRusjE
 v/Vl6EiHHdQ6k4ypc0d9hr0tre8teEzDpotgjL/RpN/hGGtfzc0w2su4UpYOmB9yYN6dODf
 4y57DS5BnEgw45KBrE+yYzOYzPr61Mc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455583CC249
	for <ltp@archiver.kernel.org>; Sun, 11 May 2025 09:34:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C1D8A3CAC91
 for <ltp@lists.linux.it>; Sun, 11 May 2025 09:34:30 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D57A420075C
 for <ltp@lists.linux.it>; Sun, 11 May 2025 09:34:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746948867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EO9CiDXbWSINuSsmmS8h/N+6yRobFbRc7bhwkn62ExE=;
 b=CsdMkOSuA7MZ8qgDE8fmGfbfTQQ0QeTBXYndH7CRS/XUIIhNZbp6SvKfcp/TJ2RhBNmsER
 oQE8qfw//kQBvNsVsxj8nN6PK8zXaNUCUaKLCYbHhp1RuQjZM0QF5h1Svj2akOCwFfiFyz
 OkkbY68/EWLASHGVturrbYB1eKGODXs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-8jS5HmQSM_quZoNt5K5ZDQ-1; Sun, 11 May 2025 03:34:24 -0400
X-MC-Unique: 8jS5HmQSM_quZoNt5K5ZDQ-1
X-Mimecast-MFC-AGG-ID: 8jS5HmQSM_quZoNt5K5ZDQ_1746948863
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22fad174900so26322325ad.1
 for <ltp@lists.linux.it>; Sun, 11 May 2025 00:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746948863; x=1747553663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EO9CiDXbWSINuSsmmS8h/N+6yRobFbRc7bhwkn62ExE=;
 b=PBM+ZRKhg/1sFHHpGV677vdkT+BWUdDV0oUNXcUUpurdSOgpwt6wNTuOUAF47458lW
 F9haa9C1NoAYC+EBmL3hPGq8yr2fwT84mfkyvVbf+2nmduknh2zbL8E6+viYfGnxPzZl
 O6gPdMF9SBrICXQI0dOt/KFRZRt/f5lKDxL/chUAPlBIxeB2qpxA9E7jMGNAdeJhqYbo
 6qNM/p3rOvFJw7rohy7V/okpSHxdYbyMgf21H4skYEAsYwQMe9OnZFZPTumQNC2jlR5e
 tLSzR1xSWiyTn0n9KmpOBMLOKiSSIhkTTh3Qjg7cRahQ7xxC6CvSYfaJkAv/zDi/Ap1y
 wT9g==
X-Gm-Message-State: AOJu0Yxall4U4ym2neAgXFqgUXgiFDUfEGMBQnlg9qqfcCe4FdOMD7MY
 rAgnETug2zBdSFHhevOrVR74ljV+u3+ixk3MF1uEWMNZ70RGBRmjf/64JNT3CGdbfspg+PMMDWf
 jS5aejJHh7QnTh10RE3qRNHl9/guK6Q/chUnWtvjkrcLmqoP81QUM7buIvPt5V3jlYwDouiW07b
 aFOEucTxNXDOpfVSaIOf14pFI=
X-Gm-Gg: ASbGncsYoBORzPJJwWE9DHCaz5BboBF9W4T689tBxPv7npW7ak5UU5/1Qksn7VXX6Rj
 av2fRH+pnkMHbzqSqBGg99WgouSRuPKp19Osll0Bvn+0a/mDzUz6F6rlPLnI1HFK40GXjVg==
X-Received: by 2002:a17:902:c946:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-22fc92f41d6mr144145275ad.5.1746948863178; 
 Sun, 11 May 2025 00:34:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGeZCM6s5iLfyy1nSU8MULsTM6/x8z0O5PvhEJAM9yPSDunEQZ8cfk9OGXXKXQcOW7EnEV+nkN3V9uBRcGPfZY=
X-Received: by 2002:a17:902:c946:b0:21f:2e:4e4e with SMTP id
 d9443c01a7336-22fc92f41d6mr144145005ad.5.1746948862752; Sun, 11 May 2025
 00:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20250510205326.1353857-1-wegao@suse.com>
In-Reply-To: <20250510205326.1353857-1-wegao@suse.com>
Date: Sun, 11 May 2025 15:34:10 +0800
X-Gm-Features: AX0GCFsydqkUOroAcN4y5nNd_C5Ji1N5s6vGXglapyok63uL3tUvbGRHnUNkzqw
Message-ID: <CAEemH2cJHz3aLRi0HeSvJWy=XvPMfJ_nv0F7=L7P2ubn8-zv5A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AukQ65MRbwTyPm1ojBKURv0DYOf961xqTCW8-4L76D4_1746948863
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Fix: dirtyc0w_shmem child process exit with
 error due to uninitialized lib_pid
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

T24gU2F0LCBNYXkgMTAsIDIwMjUgYXQgNDo1NOKAr1BNIFdlaSBHYW8gdmlhIGx0cCA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKPgo+IFRoZSBkaXJ0eWMwd19zaG1lbSB0ZXN0IHNwYXducyBh
IGNoaWxkIHByb2Nlc3MgdXNpbmcgZXhlY2xwLiBUaGlzIGNoaWxkIHByb2Nlc3MgdGhlbiBjYWxs
cyB0c3RfYnJrKCksIHdoaWNoIGV4aXRzIGVhcmx5Cj4gd2l0aCBhIG5vbi16ZXJvIHN0YXR1cyBi
ZWNhdXNlIGV4ZWNscCBkb2VzIG5vdCBpbmhlcml0IHRoZSBwYXJlbnQncyBsaWJfcGlkIHZhcmlh
YmxlLiBDb25zZXF1ZW50bHksIHRoZSBwYXJlbnQgcHJvY2Vzcwo+IGluY29ycmVjdGx5IHJlcG9y
dHMgYW4gIkludmFsaWQgY2hpbGQgZXhpdCB2YWx1ZSIuCj4KPiBUaGlzIGNvbW1pdCBhZGRyZXNz
ZXMgdGhpcyBieSBlbnN1cmluZyB0aGUgY2hpbGQgcHJvY2VzcyBoYXMgYWNjZXNzIHRvIHRoZSBu
ZWNlc3NhcnkgbGliX3BpZCBhbmQgbWFpbl9waWQgYnkgcGFzc2luZwo+IHRoZW0gdGhyb3VnaCBh
IHNoYXJlZCByZXN1bHRzIHN0cnVjdHVyZS4gVGhpcyBwcmV2ZW50cyB0aGUgcHJlbWF0dXJlIGV4
aXQgaW4gdGhlIGNoaWxkIGFuZCB0aGUgc3Vic2VxdWVudCBlcnJvciByZXBvcnQKPiBpbiB0aGUg
cGFyZW50Lgo+Cj4gUmVsYXRlZCBjb21taXQ6Cj4gY29tbWl0IGExZjgyNzA0YzI4ZDllMDI3Y2E4
OTlmNWNhMjg0MWU3ZmU0OWRlNzIKPiBsaWIvdHN0X3Rlc3QuYzogRml4IHRzdF9icmsoKSBoYW5k
bGluZwo+Cj4gRGV0YWlsIGZhaWx1cmUgbG9nOgo+IHRzdF90bXBkaXIuYzozMTc6IFRJTkZPOiBV
c2luZyAvdG1wL0xUUF9kaXJTT0dWQkMgYXMgdG1wZGlyIChidHJmcyBmaWxlc3lzdGVtKQo+IHRz
dF90ZXN0LmM6MTkzODogVElORk86IExUUCB2ZXJzaW9uOiAyMDI1MDUwNy40YTBlM2E4ZmEKPiB0
c3RfdGVzdC5jOjE5NDI6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA2LjQuMC0xNTA3MDAuNTEtZGVm
YXVsdCAjMSBTTVAgV2VkIEFwciAzMCAyMTozNTo0MyBVVEMgMjAyNSAoNjkzMDYxMSkgczM5MHgK
PiB0c3Rfa2NvbmZpZy5jOjg4OiBUSU5GTzogUGFyc2luZyBrZXJuZWwgY29uZmlnICcvcHJvYy9j
b25maWcuZ3onCj4gdHN0X2tjb25maWcuYzo2Nzg6IFRJTkZPOiBDT05GSUdfRkFVTFRfSU5KRUNU
SU9OIGtlcm5lbCBvcHRpb24gZGV0ZWN0ZWQgd2hpY2ggbWlnaHQgc2xvdyB0aGUgZXhlY3V0aW9u
Cj4gdHN0X3Rlc3QuYzoxNzYwOiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGgg
MDRtIDAwcwo+IGRpcnR5YzB3X3NobWVtLmM6NTQ6IFRJTkZPOiBNb3VudGluZyB0bXBfZGlydHlj
MHdfc2htZW0gdG8gL3RtcC9MVFBfZGlyU09HVkJDL3RtcF9kaXJ0eWMwd19zaG1lbSBmc3R5cD10
bXBmcyBmbGFncz0wCj4gZGlydHljMHdfc2htZW1fY2hpbGQuYzoxNjA6IFRDT05GOiBTeXN0ZW0g
ZG9lcyBub3QgaGF2ZSB1c2VyZmF1bHRmZCBtaW5vciBmYXVsdCBzdXBwb3J0IGZvciBzaG1lbSA8
PDw8PDw8PDw8IDEKPiB0c3RfdGVzdC5jOjQ4MTogVEJST0s6IEludmFsaWQgY2hpbGQgKDgxNjMp
IGV4aXQgdmFsdWUgMzIgPDw8PDw8PDwgMgo+IGRpcnR5YzB3X3NobWVtLmM6MTAyOiBUSU5GTzog
VW1vdW50aW5nIC90bXAvTFRQX2RpclNPR1ZCQy90bXBfZGlydHljMHdfc2htZW0KPgo+IHRtcF9k
aXJ0eWMwd19zaG1lbS5jIGNhbGwgZXhlY2xwIHRvIGNyZWF0ZSBuZXcgcHJvY2VzcyBydW4gZGly
dHljMHdfc2htZW1fY2hpbGQgYmluLgo+Cj4gU0FGRV9FWEVDTFAoImRpcnR5YzB3X3NobWVtX2No
aWxkIiwgImRpcnR5YzB3X3NobWVtX2NoaWxkIiwgTlVMTCkKPgo+IFdpdGhpbiBkaXJ0eWMwd19z
aG1lbV9jaGlsZC5jIHRyaWdnZXIKPgo+IHRzdF9icmsoVENPTkYsICJTeXN0ZW0gZG9lcyBub3Qg
aGF2ZSB1c2VyZmF1bHRmZCBtaW5vciBmYXVsdCBzdXBwb3J0IGZvciBzaG1lbSIpCj4KPiBTaW5j
ZSBleGVjbHAgZG9lcyBub3QgaW5oZXJpdCB0aGUgcGFyZW50IHByb2Nlc3MncyB2YXJpYWJsZXMg
bGliX3BpZCwgc28gaXQgd2lsbCByZXR1cm4gVENPTkYoMzIpIGRpcmVjdGx5Lgo+Cj4gdm9pZCB0
c3RfdmJya18oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50IGxpbmVubywgaW50IHR0eXBlLCBj
b25zdCBjaGFyICpmbXQsCj4gICAgICAgICAgICAgICAgdmFfbGlzdCB2YSkKPiB7Cj4gLi4uCj4g
ICAgICAgICBpZiAoIWxpYl9waWQpCj4gICAgICAgICAgICAgICAgIGV4aXQoVFRZUEVfUkVTVUxU
KHR0eXBlKSk7ICAgPDw8PDwKPiAuLi4KPiB9Cj4KPiBTbyBmaW5hbGx5IGNhcHR1cmVkIGJ5IGNo
ZWNrX2NoaWxkX3N0YXR1cyByZXBvcnQgYW4gZXJyb3IuCj4KPiBzdGF0aWMgdm9pZCBjaGVja19j
aGlsZF9zdGF0dXMocGlkX3QgcGlkLCBpbnQgc3RhdHVzKQo+IHsKPiAuLi4KPiAgICAgICAgIGlm
IChXRVhJVFNUQVRVUyhzdGF0dXMpKQo+ICAgICAgICAgICAgICAgICB0c3RfYnJrKFRCUk9LLCAi
SW52YWxpZCBjaGlsZCAoJWkpIGV4aXQgdmFsdWUgJWkiLCBwaWQsIFdFWElUU1RBVFVTKHN0YXR1
cykpOyAgPDw8PAo+IH0KPgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
Pgo+IC0tLQo+ICBsaWIvdHN0X3Rlc3QuYyB8IDI1ICsrKysrKysrKysrKysrLS0tLS0tLS0tLS0K
PiAgMSBmaWxlIGNoYW5nZWQsIDE0IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Cj4g
ZGlmZiAtLWdpdCBhL2xpYi90c3RfdGVzdC5jIGIvbGliL3RzdF90ZXN0LmMKPiBpbmRleCAyYmI0
NTE5ZGQuLmI2NjY3MTViOSAxMDA2NDQKPiAtLS0gYS9saWIvdHN0X3Rlc3QuYwo+ICsrKyBiL2xp
Yi90c3RfdGVzdC5jCj4gQEAgLTU5LDcgKzU5LDcgQEAgc3RhdGljIGNvbnN0IGNoYXIgKnRpZDsK
PiAgc3RhdGljIGludCBpdGVyYXRpb25zID0gMTsKPiAgc3RhdGljIGZsb2F0IGR1cmF0aW9uID0g
LTE7Cj4gIHN0YXRpYyBmbG9hdCB0aW1lb3V0X211bCA9IC0xOwo+IC1zdGF0aWMgcGlkX3QgbWFp
bl9waWQsIGxpYl9waWQ7Cj4gK3N0YXRpYyBwaWRfdCBsaWJfcGlkOwo+ICBzdGF0aWMgaW50IG1u
dHBvaW50X21vdW50ZWQ7Cj4gIHN0YXRpYyBpbnQgb3ZsX21vdW50ZWQ7Cj4gIHN0YXRpYyBzdHJ1
Y3QgdGltZXNwZWMgdHN0X3N0YXJ0X3RpbWU7IC8qIHZhbGlkIG9ubHkgZm9yIHRlc3QgcGlkICov
Cj4gQEAgLTc4LDYgKzc4LDggQEAgc3RydWN0IHJlc3VsdHMgewo+ICAgICAgICAgaW50IGFib3J0
X2ZsYWc7Cj4gICAgICAgICB1bnNpZ25lZCBpbnQgcnVudGltZTsKPiAgICAgICAgIHVuc2lnbmVk
IGludCBvdmVyYWxsX3RpbWU7Cj4gKyAgICAgICBwaWRfdCBsaWJfcGlkOwo+ICsgICAgICAgcGlk
X3QgbWFpbl9waWQ7Cj4gIH07CgpDYW4gd2UgYXZvaWQgcG9sbHV0aW5nIHRoZSBzdHJ1Y3QgcmVz
dWx0cyB3aXRoIG1haW5fcGlkIGFuZCBsaWJfcGlkPwpGcm9tIGEgZGVzaWduIHNlcGFyYXRpb24g
c3RhbmRwb2ludCwgcmVzdWx0cyBzaG91bGQgb25seSBzdG9yZSB0ZXN0Cm91dGNvbWUgZGF0YSwg
bm90IHRlc3QgaW5mcmFzdHJ1Y3R1cmUgc3RhdGUuCgpBcyBMVFAgbGlicmFyeSBhbHJlYWR5IHBy
b3ZpZGVzIGEgdHN0X3JlaW5pdCgpIGZ1bmN0aW9uIGZvciBjaGlsZCBwcm9jZXNzZXMKc3Bhd25l
ZCB2aWEgZXhlYygpL2V4ZWNscCgpIHRvIHJlc3RvcmUgdGhlaXIgdGVzdCBjb250ZXh0LgoKV2Ug
Y291bGQgY29uc2lkZXIgdHdvIGFwcHJvYWNoZXM6CgoxLiBDcmVhdGUgYSBzZXBhcmF0ZSBJUEMg
cmVnaW9uIHRvIHN0b3JlIGluZnJhc3RydWN0dXJlIHN0YXRlKGUuZy4sCm1haW5fcGlkLCBsaWJf
cGlkKQppbiBhIG5ldyBzdHJ1Y3QgdHN0X21ldGFfaW5mby4gVGhlIGNoaWxkIGNhbiB0aGVuIGFj
Y2VzcyB0aGlzIGRhdGEgdmlhCnRzdF9yZWluaXQoKQp3aXRob3V0IG1vZGlmeWluZyB0aGUgc3Ry
dWN0IHJlc3VsdHMuCgoyLiBTaW1wbHkgcGFzcyBtYWluX3BpZCBhbmQgbGliX3BpZCB0aHJvdWdo
IGVudmlyb25tZW50IHZhcmlhYmxlcyBpbiB0aGUKbHRwIGxpYnJhcnksIGFuZCByZXRyaWV2ZSB0
aGVtIGZyb20gdHN0X3JlaW5pdCgpIGluIHRoZSBjaGlsZC4KCk9yLCBtYXliZSBvdGhlcnMgaGF2
ZSBzaW1wbGVyIG9wdGlvbnMuIENjJ2luZyB0aGVtLgoKSW4gZWl0aGVyIGNhc2UsIHdlIHNob3Vs
ZCBzZXQgJ3RzdF90ZXN0LT5jaGlsZF9uZWVkX3JlaW5pdCcgaW4gdGhlIHBhcmVudC4KCkBDeXJp
bCwgQFBldHIsIEkgc3VwcG9ydCBtZXJnaW5nIHRoaXMgZml4IGJlZm9yZSB0aGUgTWF5IHJlbGVh
c2UsIGFzIEnigJl2ZSBhbHNvCmVuY291bnRlcmVkIHRoZSBzYW1lIGZhaWx1cmUgZHVyaW5nIG15
IHByZS1yZWxlYXNlIHRlc3RpbmcuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
