Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 011E4C2BD09
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 07:32:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DCA683D3DB9
	for <ltp@archiver.kernel.org>; Wed,  3 Jul 2024 09:32:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D62B3D0879
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 09:32:20 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 28CED602352
 for <ltp@lists.linux.it>; Wed,  3 Jul 2024 09:32:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719991937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0MLsYgD5lnot7AOuZ19OU89nd4sR3b7sTPPOy/X1Z4Y=;
 b=JynGZAYmiYzQt9mmET9tgutwBOlQirpGGpKmfztOtDqmYlisUNG132IQzpKkW7T3lRfdlO
 IeQPL8eJVCw8tJtUJDGjaZk45fI0x4O9liTyAsHyGf0Jjyav08QPdYwOnsRS2vXST97nfM
 GxkTAt2wS3seWmeeqE6ixaUoeETscjk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-382-7Dm8BKJjNliHxcYmJV6l7Q-1; Wed, 03 Jul 2024 03:32:14 -0400
X-MC-Unique: 7Dm8BKJjNliHxcYmJV6l7Q-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c924a5eda9so3683650a91.0
 for <ltp@lists.linux.it>; Wed, 03 Jul 2024 00:32:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719991934; x=1720596734;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0MLsYgD5lnot7AOuZ19OU89nd4sR3b7sTPPOy/X1Z4Y=;
 b=MaUU30jM22ScrlI3/GBwfIsc4Yti8k2mZc8AWhBDF4+qG6toR7CiV0pPUO2rjqubb8
 GilvZkjnSJFlwe0Fo5N+dR7KnMMuAQrDPAYnO1Y2vIiBtTb4OgulkA42qxPNrA17K/bu
 ZjcRew6srUgB9tpG+fwJEtyaZH5knQtNguE47vemek+aQeozIPxM8fx9LSsM19VlkhVw
 rst5TJF6tLZl1Ms7q78tMhV3QFEjK480QbOfQt02pzzKlKfZeg0aQ9eUdgx1WlsQcyHo
 sngGWiXJP9xDgVSrA9Ai0k3TOSrM+h0D8j77YZg3lb3prKXR5tnp3Y8QKJGTOORqWD9r
 xbyw==
X-Gm-Message-State: AOJu0YwOlvhXzP9kP/50SfWE31/1A/vqORcYUjC41J9/6zcq54fyOJFm
 XfRk2OSj0o9ukIHyUX5c2JRZLGQ+r0Ux9hmUGCkghJ0SMiZHhO4HrJg2AhhnR9Kp/cND8Oa2t5I
 DALrn5fnVhbVp66doc1Pono6+pW1GpSYOJj2npLOVOw1Yk2w1Hhp1SwDLCcvkN14znprXPH+1IP
 N90SI6haHz1XhsrQwvJNpLWws=
X-Received: by 2002:a17:90b:354f:b0:2c7:ec6d:8dd with SMTP id
 98e67ed59e1d1-2c93d6edae9mr6699130a91.7.1719991933743; 
 Wed, 03 Jul 2024 00:32:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlug4MnVz6H6ttuTgNxRj+486qi9mbdNHkaiHnlCGWMRhbNrbA5OeBtEUaBGavuaX39xB4zst3zQmDhWNTbDw=
X-Received: by 2002:a17:90b:354f:b0:2c7:ec6d:8dd with SMTP id
 98e67ed59e1d1-2c93d6edae9mr6699120a91.7.1719991933179; Wed, 03 Jul 2024
 00:32:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-9-58e9af649a72@suse.com>
In-Reply-To: <20240701-landlock-v1-9-58e9af649a72@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 3 Jul 2024 15:32:01 +0800
Message-ID: <CAEemH2dWxNg317Fx+pvRM=3v6Ddh2mHWLe-1_VKPO9DFpGcuoA@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 09/10] Add landlock05 test
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

T24gTW9uLCBKdWwgMSwgMjAyNCBhdCAxMTo0NeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5kZT4Kd3JvdGU6Cgo+IEZyb206IEFuZHJlYSBDZXJ2ZXNhdG8gPGFu
ZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KPiBUaGlzIHRlc3QgdmVyaWZpZXMgTEFORExPQ0tf
QUNDRVNTX0ZTX1JFRkVSIGFjY2VzcyBpbiB0aGUKPiBsYW5kbG9jayBzYW5kYm94LiBUaGUgZmVh
dHVyZSBpcyBhdmFpbGFibGUgc2luY2Uga2VybmVsIDUuMTkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBB
bmRyZWEgQ2VydmVzYXRvIDxhbmRyZWEuY2VydmVzYXRvQHN1c2UuY29tPgo+CgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgcnVudGVzdC9zeXNjYWxscyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKwo+ICB0ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL2xhbmRsb2NrLy5naXRpZ25vcmUgICB8ICAgMSArCj4gIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxvY2swNS5jIHwgMTEzCj4gKysrKysrKysrKysrKysr
KysrKysrKysrCj4gIDMgZmlsZXMgY2hhbmdlZCwgMTE1IGluc2VydGlvbnMoKykKPgo+IGRpZmYg
LS1naXQgYS9ydW50ZXN0L3N5c2NhbGxzIGIvcnVudGVzdC9zeXNjYWxscwo+IGluZGV4IDlhY2Rh
Zjc2MC4uYTNhZGU2ZGMxIDEwMDY0NAo+IC0tLSBhL3J1bnRlc3Qvc3lzY2FsbHMKPiArKysgYi9y
dW50ZXN0L3N5c2NhbGxzCj4gQEAgLTY4OCw2ICs2ODgsNyBAQCBsYW5kbG9jazAxIGxhbmRsb2Nr
MDEKPiAgbGFuZGxvY2swMiBsYW5kbG9jazAyCj4gIGxhbmRsb2NrMDMgbGFuZGxvY2swMwo+ICBs
YW5kbG9jazA0IGxhbmRsb2NrMDQKPiArbGFuZGxvY2swNSBsYW5kbG9jazA1Cj4KPiAgbGNob3du
MDEgbGNob3duMDEKPiAgbGNob3duMDFfMTYgbGNob3duMDFfMTYKPiBkaWZmIC0tZ2l0IGEvdGVz
dGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay8uZ2l0aWdub3JlCj4gYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrLy5naXRpZ25vcmUKPiBpbmRleCA0ZmU4ZDdjYmEuLmE3
ZWE2YmUyZSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2Nr
Ly5naXRpZ25vcmUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrLy5n
aXRpZ25vcmUKPiBAQCAtMywzICszLDQgQEAgbGFuZGxvY2swMQo+ICBsYW5kbG9jazAyCj4gIGxh
bmRsb2NrMDMKPiAgbGFuZGxvY2swNAo+ICtsYW5kbG9jazA1Cj4gZGlmZiAtLWdpdCBhL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvbGFuZGxvY2svbGFuZGxvY2swNS5jCj4gYi90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2xhbmRsb2NrL2xhbmRsb2NrMDUuYwo+IG5ldyBmaWxlIG1vZGUgMTAw
NjQ0Cj4gaW5kZXggMDAwMDAwMDAwLi41N2VkNjdlOWYKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9sYW5kbG9jay9sYW5kbG9jazA1LmMKPiBAQCAtMCww
ICsxLDExMyBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMC1vci1sYXRl
cgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQgKEMpIDIwMjQgU1VTRSBMTEMgQW5kcmVhIENlcnZlc2F0
byA8Cj4gYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPiArICovCj4gKwo+ICsvKlwKPiArICog
W0Rlc2NyaXB0aW9uXQo+ICsgKgo+ICsgKiBUaGlzIHRlc3QgdmVyaWZpZXMgTEFORExPQ0tfQUND
RVNTX0ZTX1JFRkVSIGFjY2VzcyBpbiB0aGUKPiArICogbGFuZGxvY2sgc2FuZGJveC4KPiArICoK
PiArICogW0FsZ29yaXRobV0KPiArICoKPiArICogLSBhcHBseSBMQU5ETE9DS19BQ0NFU1NfRlNf
UkVGRVIgaW4gdGhlIGZvbGRlcjEKPiArICogLSBhcHBseSBMQU5ETE9DS19BQ0NFU1NfRlNfUkVG
RVIgaW4gdGhlIGZvbGRlcjIKPiArICogLSBjcmVhdGUgZm9sZGVyMwo+ICsgKiAtIHZlcmlmeSB0
aGF0IGZpbGUgY2FuIGJlIG1vdmVkIGZyb20gZm9sZGVyMSB0byBmb2xkZXIyCj4gKyAqIC0gdmVy
aWZ5IHRoYXQgZmlsZSBjYW4ndCBiZSBtb3ZlZCBmcm9tIGZvbGRlcjEgdG8gZm9sZGVyMwo+ICsg
Ki8KPiArCj4gKyNpbmNsdWRlICJsYW5kbG9ja19jb21tb24uaCIKPiArCj4gKyNkZWZpbmUgTU5U
UE9JTlQgInNhbmRib3giCj4gKyNkZWZpbmUgRElSMSBNTlRQT0lOVCIvZm9sZGVyMSIKPiArI2Rl
ZmluZSBESVIyIE1OVFBPSU5UIi9mb2xkZXIyIgo+ICsjZGVmaW5lIERJUjMgTU5UUE9JTlQiL2Zv
bGRlcjMiCj4gKyNkZWZpbmUgRklMRU5BTUUxIERJUjEiL2ZpbGUiCj4gKyNkZWZpbmUgRklMRU5B
TUUyIERJUjIiL2ZpbGUiCj4gKyNkZWZpbmUgRklMRU5BTUUzIERJUjMiL2ZpbGUiCj4gKwo+ICtz
dGF0aWMgc3RydWN0IGxhbmRsb2NrX3J1bGVzZXRfYXR0ciAqcnVsZXNldF9hdHRyOwo+ICtzdGF0
aWMgc3RydWN0IGxhbmRsb2NrX3BhdGhfYmVuZWF0aF9hdHRyICpwYXRoX2JlbmVhdGhfYXR0cjsK
PiArCj4gK3N0YXRpYyB2b2lkIHJ1bih2b2lkKQo+ICt7Cj4gKyAgICAgICBpZiAoIVNBRkVfRk9S
SygpKSB7Cj4KCkRvIHdlIHJlYWxseSBuZWVkIGEgZm9yayBhbmQgdGVzdCBpbiBjaGlsZHJlbiBo
ZXJlPwoKCgoKPiArICAgICAgICAgICAgICAgVFNUX0VYUF9QQVNTKHJlbmFtZShGSUxFTkFNRTEs
IEZJTEVOQU1FMikpOwo+ICsgICAgICAgICAgICAgICBpZiAoVFNUX1JFVCA9PSAtMSkKPiArICAg
ICAgICAgICAgICAgICAgICAgICByZXR1cm47Cj4gKwo+ICsgICAgICAgICAgICAgICBUU1RfRVhQ
X0ZBSUwocmVuYW1lKEZJTEVOQU1FMiwgRklMRU5BTUUzKSwgRVhERVYpOwo+ICsKPiArICAgICAg
ICAgICAgICAgX2V4aXQoMCk7Cj4gKyAgICAgICB9Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIHNl
dHVwKHZvaWQpCj4gK3sKPiArICAgICAgIGludCBydWxlc2V0X2ZkOwo+ICsKPiArICAgICAgIHZl
cmlmeV9sYW5kbG9ja19pc19lbmFibGVkKCk7Cj4gKwo+ICsgICAgICAgU0FGRV9NS0RJUihESVIx
LCAwNjQwKTsKPiArICAgICAgIFNBRkVfTUtESVIoRElSMiwgMDY0MCk7Cj4gKyAgICAgICBTQUZF
X01LRElSKERJUjMsIDA2NDApOwo+ICsgICAgICAgU0FGRV9UT1VDSChGSUxFTkFNRTEsIDA2NDAs
IE5VTEwpOwo+ICsKPiArICAgICAgIHRzdF9yZXMoVElORk8sICJBcHBseWluZyBMQU5ETE9DS19B
Q0NFU1NfRlNfUkVGRVIiKTsKPiArCj4gKyAgICAgICBydWxlc2V0X2F0dHItPmhhbmRsZWRfYWNj
ZXNzX2ZzID0KPiArICAgICAgICAgICAgICAgTEFORExPQ0tfQUNDRVNTX0ZTX1JFQURfRklMRSB8
Cj4gKyAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19XUklURV9GSUxFIHwKPiArICAg
ICAgICAgICAgICAgTEFORExPQ0tfQUNDRVNTX0ZTX1JFRkVSOwo+ICsKPiArICAgICAgIHJ1bGVz
ZXRfZmQgPSBTQUZFX0xBTkRMT0NLX0NSRUFURV9SVUxFU0VUKAo+ICsgICAgICAgICAgICAgICBy
dWxlc2V0X2F0dHIsIHNpemVvZihzdHJ1Y3QgbGFuZGxvY2tfcnVsZXNldF9hdHRyKSwgMCk7Cj4g
Kwo+ICsgICAgICAgYXBwbHlfbGFuZGxvY2tfcnVsZSgKPiArICAgICAgICAgICAgICAgcGF0aF9i
ZW5lYXRoX2F0dHIsCj4gKyAgICAgICAgICAgICAgIHJ1bGVzZXRfZmQsCj4gKyAgICAgICAgICAg
ICAgIExBTkRMT0NLX0FDQ0VTU19GU19SRUZFUiwKPiArICAgICAgICAgICAgICAgRElSMSk7Cj4g
Kwo+ICsgICAgICAgYXBwbHlfbGFuZGxvY2tfcnVsZSgKPiArICAgICAgICAgICAgICAgcGF0aF9i
ZW5lYXRoX2F0dHIsCj4gKyAgICAgICAgICAgICAgIHJ1bGVzZXRfZmQsCj4gKyAgICAgICAgICAg
ICAgIExBTkRMT0NLX0FDQ0VTU19GU19SRUZFUiwKPiArICAgICAgICAgICAgICAgRElSMik7Cj4g
Kwo+ICsgICAgICAgZW5mb3JjZV9ydWxlc2V0KHJ1bGVzZXRfZmQpOwo+ICsKPiArICAgICAgIFNB
RkVfQ0xPU0UocnVsZXNldF9mZCk7Cj4gK30KPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3Qg
dGVzdCA9IHsKPiArICAgICAgIC50ZXN0X2FsbCA9IHJ1biwKPiArICAgICAgIC5zZXR1cCA9IHNl
dHVwLAo+ICsgICAgICAgLm1pbl9rdmVyID0gIjUuMTkiLAo+ICsgICAgICAgLm5lZWRzX3RtcGRp
ciA9IDEsCj4gKyAgICAgICAubmVlZHNfcm9vdCA9IDEsCj4gKyAgICAgICAuZm9ya3NfY2hpbGQg
PSAxLAo+ICsgICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNoYXIgKltdKSB7Cj4gKyAg
ICAgICAgICAgICAgICJDT05GSUdfU0VDVVJJVFlfTEFORExPQ0s9eSIsCj4gKyAgICAgICAgICAg
ICAgIE5VTEwKPiArICAgICAgIH0sCj4gKyAgICAgICAuYnVmcyA9IChzdHJ1Y3QgdHN0X2J1ZmZl
cnMgW10pIHsKPiArICAgICAgICAgICAgICAgeyZydWxlc2V0X2F0dHIsIC5zaXplID0gc2l6ZW9m
KHN0cnVjdAo+IGxhbmRsb2NrX3J1bGVzZXRfYXR0cil9LAo+ICsgICAgICAgICAgICAgICB7JnBh
dGhfYmVuZWF0aF9hdHRyLCAuc2l6ZSA9IHNpemVvZihzdHJ1Y3QKPiBsYW5kbG9ja19wYXRoX2Jl
bmVhdGhfYXR0cil9LAo+ICsgICAgICAgICAgICAgICB7fSwKPiArICAgICAgIH0sCj4gKyAgICAg
ICAuY2FwcyA9IChzdHJ1Y3QgdHN0X2NhcCBbXSkgewo+ICsgICAgICAgICAgICAgICBUU1RfQ0FQ
KFRTVF9DQVBfUkVRLCBDQVBfU1lTX0FETUlOKSwKPiArICAgICAgICAgICAgICAge30KPiArICAg
ICAgIH0sCj4gKyAgICAgICAuZm9ybWF0X2RldmljZSA9IDEsCj4gKyAgICAgICAubW91bnRfZGV2
aWNlID0gMSwKPiArICAgICAgIC5tbnRwb2ludCA9IE1OVFBPSU5ULAo+ICsgICAgICAgLmFsbF9m
aWxlc3lzdGVtcyA9IDEsCj4gKyAgICAgICAuc2tpcF9maWxlc3lzdGVtcyA9IChjb25zdCBjaGFy
ICpbXSkgewo+ICsgICAgICAgICAgICAgICAidmZhdCIsCj4gKyAgICAgICAgICAgICAgIE5VTEwK
PiArICAgICAgIH0sCj4gK307Cj4KPiAtLQo+IDIuNDMuMAo+Cj4KPiAtLQo+IE1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
