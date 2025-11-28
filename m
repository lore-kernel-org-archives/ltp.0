Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1187DCFD376
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 03:26:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764300411; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ya//B/oaqTrYfML+CvUpNrY1F1CDAdCLG94nF/BQxPI=;
 b=VEyhZypfw3oD4VpaS8n/7s+6I2B1jueZC4hhJQYE7cOcYaM9WQ3VCAlTQWk3ndLG3/KgP
 QsCYkV+Vdk243XueLrcjSyUpjbsZZ2MsqeVjlMARY+ZQYGEh8xQCwNtfY3d2l899jTgH8bK
 z9OBv75IktP9e/8l07TZSojw5pnDpkc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 020D23CDE3A
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 04:26:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 863343C782A
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 04:26:28 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A347C6009D0
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 04:26:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764300385;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5dOpO8bgNnY+z6E7WA5MaQSkpL7Adj7WsIOfRKVA9/M=;
 b=GjuMGmzwQGIljUDU8CiG98L0VAy7PwhuR/FK1Tr8VElZDjt0z/ZXduszjYEb731MtL5cz4
 fe5reQUg0HZSstR5uI7NxZCVsx63kJEHO9VmfRRlflXlWT6BwG4WtaHHeWo9QikbKfS5ek
 uuzzy9w8y53F8Bul6VYIfkrFPgEa9fI=
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-542-FaMlZZ-aOXmWzNCS0LApSg-1; Thu, 27 Nov 2025 22:26:21 -0500
X-MC-Unique: FaMlZZ-aOXmWzNCS0LApSg-1
X-Mimecast-MFC-AGG-ID: FaMlZZ-aOXmWzNCS0LApSg_1764300380
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2a45fea6efbso2925596eec.0
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 19:26:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764300380; x=1764905180;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5dOpO8bgNnY+z6E7WA5MaQSkpL7Adj7WsIOfRKVA9/M=;
 b=waxWrr09W18VEOTuD9WoL9LSusNXbL20P2wsRyQEg9vjjFWtLGhtffkTuC0wykr5rQ
 6ACbWTb4MyRNNGs6kOVgwho9A013mVY885JceQVKqJRF2K1t4p4kl14KbIw4lii4vDTl
 olyW5G5DxoMSofNpez2ONCbno3rT7OzboyBb6/Fen/QJ2wBeUn6sK1OAY7zXX8C3GgJ7
 peC4Xegz99f+bDgFFVKzUinsP+zwavCKBeRkD6UhxRyejNabQLRgTiQQlokFC67ZnA7J
 eYtdERrxuy24n3XMyOjgKSdqmQIQPX0VA7x1GSgLt48xN7cobp29IlGgT+e30jTJ06ms
 b9MQ==
X-Gm-Message-State: AOJu0Yz5FsdU4DvIBHHl2TmeztuE6IDqt2/8UdD14yAUdW6xuIMOaRKJ
 zAAWUNBxmHzNj69Jvm/oBmcx3WFpUBqClPXm+880cmRChnMowWteqV6FRqM7IjMzxFqXyddXmyz
 uCbx28Sr5cy7tW+k2n4bqcxehxB/6WsYofNjNhqSTzayl/TdWJkMHPjhwUYIoWR2a2JRZVZ2l3f
 PHWICftg89ujiw5iiV/i+D/uh+NA8=
X-Gm-Gg: ASbGncuBTY+v5zLF6Zadh9Mot1wE1CNj1VZzMnSYoD3iX2dRfyhd23Z9+qYCgKQ13JC
 ERj44paRRHx8vmgqQGNdDmMerE/g9ruTZjCOsdppW1Q0oFcnlhOZKhejZtsmL7mCfvId2hO52lc
 kiDovcdcUACXHULFE6EfC4zvEelZtVEzgh/GxdPcfNnwYUS1on3PB3PksI9mka8O7VjAU=
X-Received: by 2002:a05:7301:2224:b0:2a4:4b26:137a with SMTP id
 5a478bee46e88-2a6ff55f3f9mr13275891eec.6.1764300380215; 
 Thu, 27 Nov 2025 19:26:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH5bmvxqrYifFkDBFOTTPGtRrSpJSwQjc6JYFN1X3daTdy9XvRWGgL2/5Seq+vwspHJ/S7ppGXqTpNsfhV+6sw=
X-Received: by 2002:a05:7301:2224:b0:2a4:4b26:137a with SMTP id
 5a478bee46e88-2a6ff55f3f9mr13275873eec.6.1764300379731; Thu, 27 Nov 2025
 19:26:19 -0800 (PST)
MIME-Version: 1.0
References: <20251127143959.9416-1-wegao@suse.com>
In-Reply-To: <20251127143959.9416-1-wegao@suse.com>
Date: Fri, 28 Nov 2025 11:26:07 +0800
X-Gm-Features: AWmQ_bmNRts-qdq8I2Rm73uE8foR0U4CYsAnxR7EavJmAjXKbAFt95S5L_IUXWU
Message-ID: <CAEemH2c648sBs9LJmQBGRi-OY6s6p-ju-nAzHLGL2uzoiJTiag@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mjshtRzLljul07u7qc4TLokDpDCDf9qZ-aT7zLSQKRs_1764300380
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgV2VpLAoKCk9uIFRodSwgTm92IDI3LCAyMDI1IGF0IDk6NDHigK9BTSBXZWkgR2FvIHZpYSBs
dHAgPGx0cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IE5ldyBrZXJuZWwgY29tbWl0IGxlYWQg
dGVzdCBjYXNlIGZhaWx1cmUgd2l0aCBmb2xsb3dpbmcgZXJyb3IgbWVzc2FnZToKPiBsaXN0bW91
bnQwNC5jOjEyODogVEZBSUw6IGludmFsaWQgbW50X2lkX3JlcS5zcGFyZSBleHBlY3RlZCBFSU5W
QUw6IEVCQURGCj4gKDkpCj4KPiBEZXRhaWwgb2YgbmV3IGtlcm5lbCBjb21taXQ6Cj4gY29tbWl0
OiA3OGYwZTMzY2Q2YzkzOWE1NTVhYTgwZGJlZDJmZWM2YjMzM2E3NjYwCj4gZnMvbmFtZXNwYWNl
OiBjb3JyZWN0bHkgaGFuZGxlIGVycm9ycyByZXR1cm5lZCBieSBncmFiX3JlcXVlc3RlZF9tbnRf
bnMKPgo+IFNpZ25lZC1vZmYtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IC0tLQo+ICBj
b25maWd1cmUuYWMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDEgKwo+ICAu
Li4va2VybmVsL3N5c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jICAgIHwgMTggKysrKysr
KysrKysrLS0tLS0tCj4gIDIgZmlsZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxl
dGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBp
bmRleCAwNDgwZjQ2Y2EuLmZjZmY5MDc5OSAxMDA2NDQKPiAtLS0gYS9jb25maWd1cmUuYWMKPiAr
KysgYi9jb25maWd1cmUuYWMKPiBAQCAtMjYzLDYgKzI2Myw3IEBAIEFDX0NIRUNLX1RZUEVTKFtz
dHJ1Y3QgY2FjaGVzdGF0XSwsLFsjaW5jbHVkZQo+IDxzeXMvbW1hbi5oPl0pCj4KPiAgIyBEZWZp
bmVkIGluIDxsaW51eC9tb3VudC5oPiwgYnV0IGluY2x1ZGUvbGFwaS9tb3VudC5oIGluY2x1ZGVz
Cj4gPHN5cy9tb3VudC5oPiAqLwo+ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IG1udF9pZF9yZXFd
LCwsWyNpbmNsdWRlIDxzeXMvbW91bnQuaD5dKQo+ICtBQ19DSEVDS19NRU1CRVJTKFtzdHJ1Y3Qg
bW50X2lkX3JlcS5tbnRfbnNfZmRdLCwsWyNpbmNsdWRlIDxzeXMvbW91bnQuaD5dKQo+ICBBQ19D
SEVDS19UWVBFUyhbc3RydWN0IHN0YXRtb3VudF0sLCxbI2luY2x1ZGUgPHN5cy9tb3VudC5oPl0p
Cj4gIEFDX0NIRUNLX01FTUJFUlMoW3N0cnVjdCBzdGF0bW91bnQubW50X25zX2lkXSwsLFsjaW5j
bHVkZSA8dW5pc3RkLmg+Cj4gICNpbmNsdWRlIDxsaW51eC9tb3VudC5oPl0pCj4gZGlmZiAtLWdp
dCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGlzdG1vdW50L2xpc3Rtb3VudDA0LmMKPiBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGlzdG1vdW50L2xpc3Rtb3VudDA0LmMKPiBpbmRl
eCBhNTJiYWQwNjQuLjNiZTNiZTRmMiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5
c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91bnQwNC5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9saXN0bW91bnQvbGlzdG1vdW50MDQuYwo+IEBAIC0xOCw2ICsxOCw3IEBACj4gICNp
bmNsdWRlICJsYXBpL21vdW50LmgiCj4gICNpbmNsdWRlICJsYXBpL3N5c2NhbGxzLmgiCj4KPiAr
I2lmZGVmIEhBVkVfU1RSVUNUX01OVF9JRF9SRVFfTU5UX05TX0ZECj4gICNkZWZpbmUgTU5UX1NJ
WkUgMzIKPgo+ICBzdGF0aWMgc3RydWN0IG1udF9pZF9yZXEgKnJlcXVlc3Q7Cj4gQEAgLTI2LDcg
KzI3LDcgQEAgc3RhdGljIHVpbnQ2NF90IG1udF9pZHNbTU5UX1NJWkVdOwo+ICBzdGF0aWMgc3Ry
dWN0IHRjYXNlIHsKPiAgICAgICAgIGludCByZXFfdXNhZ2U7Cj4gICAgICAgICB1aW50MzJfdCBz
aXplOwo+IC0gICAgICAgdWludDMyX3Qgc3BhcmU7Cj4gKyAgICAgICB1aW50MzJfdCBtbnRfbnNf
ZmQ7Cj4gICAgICAgICB1aW50NjRfdCBtbnRfaWQ7Cj4gICAgICAgICB1aW50NjRfdCBwYXJhbTsK
PiAgICAgICAgIHVpbnQ2NF90ICptbnRfaWRzOwo+IEBAIC03MywxMiArNzQsMTIgQEAgc3RhdGlj
IHN0cnVjdCB0Y2FzZSB7Cj4gICAgICAgICB7Cj4gICAgICAgICAgICAgICAgIC5yZXFfdXNhZ2Ug
PSAxLAo+ICAgICAgICAgICAgICAgICAuc2l6ZSA9IE1OVF9JRF9SRVFfU0laRV9WRVIwLAo+IC0g
ICAgICAgICAgICAgICAuc3BhcmUgPSAtMSwKPiArICAgICAgICAgICAgICAgLm1udF9uc19mZCA9
IC0xLAo+ICAgICAgICAgICAgICAgICAubW50X2lkID0gTFNNVF9ST09ULAo+ICAgICAgICAgICAg
ICAgICAubW50X2lkcyA9IG1udF9pZHMsCj4gICAgICAgICAgICAgICAgIC5ucl9tbnRfaWRzID0g
TU5UX1NJWkUsCj4gLSAgICAgICAgICAgICAgIC5leHBfZXJybm8gPSBFSU5WQUwsCj4gLSAgICAg
ICAgICAgICAgIC5tc2cgPSAiaW52YWxpZCBtbnRfaWRfcmVxLnNwYXJlIiwKPiArICAgICAgICAg
ICAgICAgLmV4cF9lcnJubyA9IEVCQURGLAo+ICsgICAgICAgICAgICAgICAubXNnID0gImludmFs
aWQgbW50X2lkX3JlcS5tbnRfbnNfZmQgYmFkIGZpbGUgZGVzY3JpcHRvciIsCj4gICAgICAgICB9
LAo+ICAgICAgICAgewo+ICAgICAgICAgICAgICAgICAucmVxX3VzYWdlID0gMSwKPiBAQCAtMTIy
LDcgKzEyMyw3IEBAIHN0YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKPiAgICAgICAgICAg
ICAgICAgcmVxLT5tbnRfaWQgPSB0Yy0+bW50X2lkOwo+ICAgICAgICAgICAgICAgICByZXEtPnBh
cmFtID0gdGMtPnBhcmFtOwo+ICAgICAgICAgICAgICAgICByZXEtPnNpemUgPSB0Yy0+c2l6ZTsK
PiAtICAgICAgICAgICAgICAgcmVxLT5zcGFyZSA9IHRjLT5zcGFyZTsKPiArICAgICAgICAgICAg
ICAgcmVxLT5tbnRfbnNfZmQgPSB0Yy0+bW50X25zX2ZkOwo+ICAgICAgICAgfQo+Cj4gICAgICAg
ICBUU1RfRVhQX0ZBSUwodHN0X3N5c2NhbGwoX19OUl9saXN0bW91bnQsIHJlcSwgdGMtPm1udF9p
ZHMsCj4gQEAgLTEzMyw5ICsxMzQsMTQgQEAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBu
KQo+ICBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3QgPSB7Cj4gICAgICAgICAudGVzdCA9IHJ1
biwKPiAgICAgICAgIC50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+IC0gICAgICAgLm1pbl9r
dmVyID0gIjYuOCIsCj4gKyAgICAgICAubWluX2t2ZXIgPSAiNi4xOCIsCj4KClJldmlld2VkLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KClRoaXMgcGF0Y2ggbG9va3MgZ29vZCwgSSBo
YXZlIG9uZSBxdWVzdGlvbiBkbyB3ZSBuZWVkIHRvIGNvdmVyIHRoZSAnc3BhcmUnCmZpZWxkIHRl
c3QgZm9yIGtlcm5lbHMgYmV0d2VlbiA2LjggdG8gNi4xOD8KCgogICAgICAgIC5idWZzID0gKHN0
cnVjdCB0c3RfYnVmZmVycyBbXSkgewo+ICAgICAgICAgICAgICAgICB7ICZyZXF1ZXN0LCAuc2l6
ZSA9IE1OVF9JRF9SRVFfU0laRV9WRVIwIH0sCj4gICAgICAgICAgICAgICAgIHt9LAo+ICAgICAg
ICAgfSwKPiAgfTsKPiArCj4gKyNlbHNlCj4gKyAgICAgICBUU1RfVEVTVF9UQ09ORigKPiArICAg
ICAgICAgICAgICAgIlRoaXMgc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgbW50X2lkX3JlcS5tbnRf
bnNfZmQuIik7Cj4gKyNlbmRpZiAvKiBIQVZFX1NUUlVDVF9NTlRfSURfUkVRX01OVF9OU19GRCAq
Lwo+IC0tCj4gMi41MS4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
