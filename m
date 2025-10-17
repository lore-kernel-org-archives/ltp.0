Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD71CCD19A
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 09:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760695125; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Wx8YewFcnLg13xPQuaGgam5luW5Paz4Pw5jhqty1ITY=;
 b=pdGQ7uMhXitbPgyO++5IFJvIH1rL1/y/oFKGsd4gClsayvaEqgo58sBBibMkuworyWSTi
 RSzdZPxiJpLl/CWsy+2qboXMLpFqegZi5R+3uNjo+EiJub7HskiPaSXbYysWnbGfm/L17uN
 h9yTGl7jnAkf3feO8Z7D+e4pbeRAqqU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA54A3CEE69
	for <ltp@archiver.kernel.org>; Fri, 17 Oct 2025 11:58:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B8773CEE14
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:58:25 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B8B201000DEC
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 11:58:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760695102;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jNDFM707QKED0TCITSsPpLuqeCxw7fdlsaN1xGJ9Tbw=;
 b=TZFDrcZojwhQGsWhoNAtzzrDWsdh71DyuHC/khQ+zM8c+RRigc1U6gdhfqGeQcKRxk6Poq
 W9Q0SNXNG3bM75dHNSky7YT81YzYIUM9/uYap6c6RNuy0h/JzBeVOXCKugNKaMVrNwhLp+
 jWWABeTHtIARslJ1Nv4SqqYHu2nOA9w=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-BuZg4L5PMCWopUFfconI8A-1; Fri, 17 Oct 2025 05:58:20 -0400
X-MC-Unique: BuZg4L5PMCWopUFfconI8A-1
X-Mimecast-MFC-AGG-ID: BuZg4L5PMCWopUFfconI8A_1760695100
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-28e538b5f23so21017595ad.3
 for <ltp@lists.linux.it>; Fri, 17 Oct 2025 02:58:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760695098; x=1761299898;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jNDFM707QKED0TCITSsPpLuqeCxw7fdlsaN1xGJ9Tbw=;
 b=AZutqvyQoJDM0eDAafm46UNUxpYgUbMFQVoaIrUrPxHd2jbRTn3BBTHQ9rqrkruOl6
 oQwT/Oxzj1zHETVzGpDBHnZcpnbgSfzHGEHLB8jEs3n4UDTmGjDk1b2l4gbStcVXTylL
 N+k2fIjLMaHnqCkB8Fi/eS6fHoDAuPlnFR63wrkM/R6EHbrYQYaPz9xWGH5I3D/79ToH
 WRLEYws/SK3TkLUKh9U9uzfmrZmkfUVWRtYHb4eb/2c1XcBcpcFBCYhTKL6AZ0Akz8Sa
 u7xRQ2Yiopf112/S7nzo7kINNt1f9HbsWTFhhDhcJU1ILe65Ti4r97x1dEUthqS1aDaH
 FsNg==
X-Gm-Message-State: AOJu0YyVAD1y8L1Jbbr/IbxO3NoUqszKrc9OqHU7vBXSiP76cwzUn8Gf
 4CvwAkYWit5jgO1xeNt9y5HihLeVKLCwEczh3jZlPBdbBGTNbdXM67nlJvpegYOyV8544quBcQ8
 1BIn1Mq6tmAN4pPfrr4uIdRY6bLaBwIzAQHr3HbU/mjcEcM53yJx6QGoKKEhd6lUArtD/2soMYy
 ibS9wBWW5L9Gvn0KnSfPXSb2KXIQG1k2ObiHQ8lQ==
X-Gm-Gg: ASbGncsFJHNBu+85R0s7mDdCBr6kF9hYUdHOgZRyN7R/dLywJNqB0WoALTe84GHZwKq
 3bfNoFLqxb6PUY/A7SKAD6+JFpWt+tlRx5G6YoL0qHeGMk+vCDgcm1/6GrbKqeklXtKKyijb/+E
 /vfLdixAIsR33KfaqGLUvSQ1R8m6z3Et3tcq0+T8C3JOJfUmw1DRH8NWIp
X-Received: by 2002:a17:902:fc8e:b0:27d:c542:fe25 with SMTP id
 d9443c01a7336-290cb27c8e8mr40451365ad.41.1760695098319; 
 Fri, 17 Oct 2025 02:58:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGwzfEcgNq6fwlMzhJnnDXp6l1lEn5dkv8JKZz1Apic4prWC3CNyfR0KyEMuhmOlc1fB4RppExXD6gidS+estI=
X-Received: by 2002:a17:902:fc8e:b0:27d:c542:fe25 with SMTP id
 d9443c01a7336-290cb27c8e8mr40451115ad.41.1760695097913; Fri, 17 Oct 2025
 02:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20251016124025.1472694-1-ben.copeland@linaro.org>
In-Reply-To: <20251016124025.1472694-1-ben.copeland@linaro.org>
Date: Fri, 17 Oct 2025 17:58:05 +0800
X-Gm-Features: AS18NWBQ_csZ-EAqBhOTQ3wFaHmlFjtxg1O1S8lUkqHPhf7ziUJ2CH4OupndGdg
Message-ID: <CAEemH2eEY1QQA2QYE_RDJbsqotRNH178cbuvNo75t8BQmseCFQ@mail.gmail.com>
To: Ben Copeland <ben.copeland@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: IVJIPrtGaRBxZEWdn-YRBvHuI2qidDkzY6hNA6-_B9s_1760695100
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] overcommit_memory: Fix integer overflow and
 32-bit limits
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
Cc: dan.carpenter@linaro.org, lkft-triage@lists.linaro.org, arnd@arndb.de,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBPY3QgMTYsIDIwMjUgYXQgODo0MeKAr1BNIEJlbiBDb3BlbGFuZCA8YmVuLmNvcGVs
YW5kQGxpbmFyby5vcmc+Cndyb3RlOgoKPiBUaGUgb3ZlcmNvbW1pdCB0ZXN0IHVzZXMgc3VtX3Rv
dGFsLCB0aGUgc3VtIChtZW1vcnkgYW5kIHN3YXApIHRvIHRlc3QKPiB0aGUgb3ZlcmNvbW1pdCBz
ZXR0aW5ncy4KPgo+IFRoaXMgZml4ZXMgdHdvIHByb2JsZW1zIG9uIDMyLWJpdCBzeXN0ZW1zLiBU
aGUgZmlyc3QgaXMgc2VlbiB3aXRoIGEKPiBpbnRlZ2VyIG92ZXJmbG93IGNhbiBvY2N1ciB3aGVu
IGNhbGN1bGF0aW5nIHN1bV90b3RhbCAqIDIsIGlmIHRoZQo+IHN1bV90b3RhbCBpcyBsYXJnZXIg
dGhhbiAyR0IuIFRoZSBzZWNvbmQgaXMgbGltaXRlZCB2aXJ0dWFsIGFkZHJlc3MKPiBzcGFjZSAo
Mi0zR0IpIG1lYW5zIHRoZSB0ZXN0IGNhbiBmYWlsIGZyb20gYWRkcmVzcyBzcGFjZSBleGhhdXN0
aW9uCj4gYmVmb3JlIG92ZXJjb21taXQgaGFzIGJlZW4gdGVzdGVkLgo+Cj4gTm93IHRoZSB0ZXN0
IHJ1bnMgY29ycmVjdGx5IG9uIGxvdy1tZW1vcnkgMzItYml0IHN5c3RlbXMgd2hpbGUgYXZvaWRp
bmcKPiBib3RoIHRoZSBvdmVyZmxvdyBidWcgYW5kIHZpcnR1YWwgYWRkcmVzcyBzcGFjZSBpc3N1
ZXMuCj4KPiBBY2tlZC1ieTogQXJuZCBCZXJnbWFubiA8YXJuZEBhcm5kYi5kZT4KPiBSZXZpZXdl
ZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gU2lnbmVkLW9mZi1ieTogQmVuIENv
cGVsYW5kIDxiZW4uY29wZWxhbmRAbGluYXJvLm9yZz4KPgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcg
PGxpd2FuZ0ByZWRoYXQuY29tPgoKCi0tLQo+ICAuLi4va2VybmVsL21lbS90dW5hYmxlL292ZXJj
b21taXRfbWVtb3J5LmMgICAgfCAzMSArKysrKysrKysrKysrKy0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyNCBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvbWVtL3R1bmFibGUvb3ZlcmNvbW1pdF9tZW1vcnkuYwo+IGIvdGVzdGNh
c2VzL2tlcm5lbC9tZW0vdHVuYWJsZS9vdmVyY29tbWl0X21lbW9yeS5jCj4gaW5kZXggOWIyY2I0
NzlkLi5kNGZhYWVlZTAgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9tZW0vdHVuYWJs
ZS9vdmVyY29tbWl0X21lbW9yeS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vdHVuYWJs
ZS9vdmVyY29tbWl0X21lbW9yeS5jCj4gQEAgLTEzMSwyNCArMTMxLDQxIEBAIHN0YXRpYyB2b2lk
IG92ZXJjb21taXRfbWVtb3J5X3Rlc3Qodm9pZCkKPiAgICAgICAgIFRTVF9TWVNfQ09ORl9MT05H
X1NFVChPVkVSQ09NTUlUX01FTU9SWSwgMiwgMSk7Cj4KPiAgICAgICAgIHVwZGF0ZV9tZW1fY29t
bWl0KCk7Cj4gLSAgICAgICBhbGxvY19hbmRfY2hlY2soY29tbWl0X2xlZnQgKiAyLCBFWFBFQ1Rf
RkFJTCk7Cj4gLSAgICAgICBhbGxvY19hbmRfY2hlY2soY29tbWl0X2xpbWl0ICsgdG90YWxfYmF0
Y2hfc2l6ZSwgRVhQRUNUX0ZBSUwpOwo+IC0gICAgICAgdXBkYXRlX21lbV9jb21taXQoKTsKPiAt
ICAgICAgIGFsbG9jX2FuZF9jaGVjayhjb21taXRfbGVmdCAvIDIsIEVYUEVDVF9QQVNTKTsKPiAr
ICAgICAgIC8qIFNraXAgdGVzdHMgdGhhdCB3b3VsZCBvdmVyZmxvdyBvciBleGNlZWQgMzItYml0
IGFkZHJlc3Mgc3BhY2UgKi8KPiArICAgICAgIGlmICh0c3Rfa2VybmVsX2JpdHMoKSA9PSA2NCB8
fCAodW5zaWduZWQgbG9uZyljb21taXRfbGVmdCA8PQo+IFRTVF9HQiAvIFRTVF9LQikgewo+ICsg
ICAgICAgICAgICAgICBhbGxvY19hbmRfY2hlY2soY29tbWl0X2xlZnQgKiAyLCBFWFBFQ1RfRkFJ
TCk7Cj4gKyAgICAgICAgICAgICAgIGFsbG9jX2FuZF9jaGVjayhjb21taXRfbGltaXQgKyB0b3Rh
bF9iYXRjaF9zaXplLAo+IEVYUEVDVF9GQUlMKTsKPiArICAgICAgICAgICAgICAgdXBkYXRlX21l
bV9jb21taXQoKTsKPiArICAgICAgICAgICAgICAgYWxsb2NfYW5kX2NoZWNrKGNvbW1pdF9sZWZ0
IC8gMiwgRVhQRUNUX1BBU1MpOwo+ICsgICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAg
dHN0X3JlcyhUQ09ORiwgIlNraXBwaW5nIGxhcmdlIGFsbG9jYXRpb24gdGVzdHMgZHVlIHRvCj4g
YWRkcmVzcyBzcGFjZSBsaW1pdHMiKTsKPiArICAgICAgIH0KPgo+ICAgICAgICAgLyogc3RhcnQg
dG8gdGVzdCBvdmVyY29tbWl0X21lbW9yeT0wICovCj4gICAgICAgICBUU1RfU1lTX0NPTkZfTE9O
R19TRVQoT1ZFUkNPTU1JVF9NRU1PUlksIDAsIDEpOwo+Cj4gICAgICAgICB1cGRhdGVfbWVtKCk7
Cj4gICAgICAgICBhbGxvY19hbmRfY2hlY2soZnJlZV90b3RhbCAvIDIsIEVYUEVDVF9QQVNTKTsK
PiAtICAgICAgIGFsbG9jX2FuZF9jaGVjayhzdW1fdG90YWwgKiAyLCBFWFBFQ1RfRkFJTCk7Cj4g
KyAgICAgICAvKiBTa2lwIGlmIHN1bV90b3RhbCAqIDIgd291bGQgZXhjZWVkIGFkZHJlc3Mgc3Bh
Y2UuCj4gKyAgICAgICAgKiBPbiAzMi1iaXQsIHNraXAgd2hlbiBzdW1fdG90YWwgPiBVTE9OR19N
QVgvNCAofjFHQikuCj4gKyAgICAgICAgKiBNb3N0IDMyLWJpdCBzeXN0ZW1zIHdpdGggPD0xR0Ig
UkFNIGNhbiBtYXAgMnggdGhhdCBpbiAzR0IgdmFkZHIKPiBzcGFjZS4KPiArICAgICAgICAqIFN5
c3RlbXMgd2l0aCAyR0IrIFJBTSBsaWtlbHkgY2Fubm90IGZpdCBhbGxvY2F0aW9ucyBpbiB2YWRk
cgo+IHNwYWNlLiAqLwo+ICsgICAgICAgaWYgKHRzdF9rZXJuZWxfYml0cygpID09IDY0IHx8ICh1
bnNpZ25lZCBsb25nKXN1bV90b3RhbCA8PSBUU1RfR0IKPiAvIFRTVF9LQikgewo+ICsgICAgICAg
ICAgICAgICBhbGxvY19hbmRfY2hlY2soc3VtX3RvdGFsICogMiwgRVhQRUNUX0ZBSUwpOwo+ICsg
ICAgICAgfSBlbHNlIHsKPiArICAgICAgICAgICAgICAgdHN0X3JlcyhUQ09ORiwgIlNraXBwaW5n
IGxhcmdlIGFsbG9jYXRpb24gdGVzdCBkdWUgdG8KPiBhZGRyZXNzIHNwYWNlIGxpbWl0cyIpOwo+
ICsgICAgICAgfQo+Cj4gICAgICAgICAvKiBzdGFydCB0byB0ZXN0IG92ZXJjb21taXRfbWVtb3J5
PTEgKi8KPiAgICAgICAgIFRTVF9TWVNfQ09ORl9MT05HX1NFVChPVkVSQ09NTUlUX01FTU9SWSwg
MSwgMSk7Cj4KPiAgICAgICAgIGFsbG9jX2FuZF9jaGVjayhzdW1fdG90YWwgLyAyLCBFWFBFQ1Rf
UEFTUyk7Cj4gLSAgICAgICBhbGxvY19hbmRfY2hlY2soc3VtX3RvdGFsLCBFWFBFQ1RfUEFTUyk7
Cj4gLSAgICAgICBhbGxvY19hbmRfY2hlY2soc3VtX3RvdGFsICogMiwgRVhQRUNUX1BBU1MpOwo+
ICsgICAgICAgaWYgKHRzdF9rZXJuZWxfYml0cygpID09IDY0IHx8ICh1bnNpZ25lZCBsb25nKXN1
bV90b3RhbCA8PSBUU1RfR0IKPiAvIFRTVF9LQikgewo+ICsgICAgICAgICAgICAgICBhbGxvY19h
bmRfY2hlY2soc3VtX3RvdGFsLCBFWFBFQ1RfUEFTUyk7Cj4gKyAgICAgICAgICAgICAgIGFsbG9j
X2FuZF9jaGVjayhzdW1fdG90YWwgKiAyLCBFWFBFQ1RfUEFTUyk7Cj4gKyAgICAgICB9IGVsc2Ug
ewo+ICsgICAgICAgICAgICAgICB0c3RfcmVzKFRDT05GLCAiU2tpcHBpbmcgbGFyZ2UgYWxsb2Nh
dGlvbiB0ZXN0cyBkdWUgdG8KPiBhZGRyZXNzIHNwYWNlIGxpbWl0cyIpOwo+ICsgICAgICAgfQo+
Cj4gIH0KPgo+IC0tCj4gMi41MS4wCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
