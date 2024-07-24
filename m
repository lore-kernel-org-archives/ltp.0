Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C87AAC3DA63
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 12:12:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 455443D1C0E
	for <ltp@archiver.kernel.org>; Wed, 24 Jul 2024 14:12:51 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC0C53D1B59
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:12:35 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BEFF4600BA2
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 14:12:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721823152;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c1XhIIJShuuxZx+1seMCLkg2NktGYSF5QTcVwUikMGw=;
 b=cWAEZC8uaVv7iV89Qw1UkDH/LlCqRgGjKSD6G+lRBrQwoSofF5+Kvw5K2OCfP+EGNugQ6r
 +mTIQAus9TnKKc8diSfYSVjIOKsLYxA+LK7G0QL/OaX+uXWFFxnfprhROBEyPMTIIn/tkT
 ykYy9hR/sPoV2hNjyd9QzyfeN+NCsEg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-235-9tjbrtPiN0yHns6HSZtANQ-1; Wed, 24 Jul 2024 08:12:30 -0400
X-MC-Unique: 9tjbrtPiN0yHns6HSZtANQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2cb600e1169so6259577a91.1
 for <ltp@lists.linux.it>; Wed, 24 Jul 2024 05:12:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721823148; x=1722427948;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=c1XhIIJShuuxZx+1seMCLkg2NktGYSF5QTcVwUikMGw=;
 b=MWMhlDAgctByqZGVcL0j5vcbtTONWyyGpPXiiy3DE0iCr2ti/NznzVIH3YYm43aoNW
 PAYgYsoWP8OsUsn5FTU31f/WYsljD+T7KAYD00OEMdxsx7SzdSGh6xvk/Ep7YTQPvESE
 L2If43I2zmGWRp6A68UGntSS6a0U2inwk2Eu9DwuSM30HUWyEa9VlbjYI0qvoRwjLSbg
 LCBpM9ZsH/2kEaLYaS4i6+TspnNx6wtBiNIsqoZEzvgLNvdF6mO8S2T/HpHSf302oyuT
 zplV09c0xS+mmfnNZmCTZYSflnHnnllon729hEWTIbjM2ch1V1+zRlaW/nD+KyM1/lD6
 6V4Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUjhvlD3fTqHjy77/K5Figg/bA2Fw1CnWI5XQMycmQVqVnE9YRZXyYATkgePKrjTW6+v0Pfj6Qg+VnbsSwsqkJFpE4=
X-Gm-Message-State: AOJu0YyBieXmcoJV4PjHFlgZscxl4zCuoSq5rA7RTwRqmr3T56PSpx1d
 cDhh7PqA4yLV78NwCgfvV9aSuQUlAuAHDm9VYvY7iYadPSWdK0oVGpdlnr3aZ0eo2c8gKHqUoiK
 3hFhuQBmXQ7rp7lB1i75q6zXg5x6x+yVPBjy7PV476Oxfk2R951RrX33yMuX6mslXBcJxcxdY71
 S/1g+sycILWXLdHv1YYW3FSZPdi13EmMKLRObN
X-Received: by 2002:a17:90a:8c95:b0:2c5:3dbd:58bc with SMTP id
 98e67ed59e1d1-2cdae46f193mr3092281a91.25.1721823148330; 
 Wed, 24 Jul 2024 05:12:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx50RrdNUVtSE60E4zGImNpTDXKTA/Dea86zxTryRekFEDeYLOk+tTKMYRv+EbHAKgudhNc8sEWl/VI1OzNFg=
X-Received: by 2002:a17:90a:8c95:b0:2c5:3dbd:58bc with SMTP id
 98e67ed59e1d1-2cdae46f193mr3092244a91.25.1721823147874; Wed, 24 Jul 2024
 05:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240711-landlock-v3-0-c7b0e9edf9b0@suse.com>
 <20240711-landlock-v3-9-c7b0e9edf9b0@suse.com>
 <20240716172725.GC549165@pevik>
In-Reply-To: <20240716172725.GC549165@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2024 20:12:16 +0800
Message-ID: <CAEemH2fP9eGdHs1Wb5JLhS-H-XXxKB=73n8WAXqj3ZNxw9xDVA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 09/11] Add landlock04 test
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
Cc: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwgQW5kcmVhLAoKT24gV2VkLCBKdWwgMTcsIDIwMjQgYXQgMToyN+KAr0FNIFBldHIg
Vm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSGkgQW5kcmVhLAo+Cj4gLi4uCj4gPiAr
c3RhdGljIHZvaWQgZW5hYmxlX2V4ZWNfbGlicyhjb25zdCBpbnQgcnVsZXNldF9mZCkKPiA+ICt7
Cj4gPiArICAgICBGSUxFICpmcDsKPiA+ICsgICAgIGNoYXIgbGluZVsxMDI0XTsKPiA+ICsgICAg
IGNoYXIgcGF0aFtQQVRIX01BWF07Cj4gPiArICAgICBjaGFyIGRlcGVuZGVuY3lbOF1bUEFUSF9N
QVhdOwo+ID4gKyAgICAgaW50IGNvdW50ID0gMDsKPiA+ICsgICAgIGludCBkdXBsaWNhdGUgPSAw
Owo+ID4gKwo+ID4gKyAgICAgZnAgPSBTQUZFX0ZPUEVOKCIvcHJvYy9zZWxmL21hcHMiLCAiciIp
Owo+ID4gKwo+ID4gKyAgICAgd2hpbGUgKGZnZXRzKGxpbmUsIHNpemVvZihsaW5lKSwgZnApKSB7
Cj4gPiArICAgICAgICAgICAgIGlmIChzdHJzdHIobGluZSwgIi5zbyIpID09IE5VTEwpCj4gPiAr
ICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gPiArCj4gPiArICAgICAgICAgICAgIFNB
RkVfU1NDQU5GKGxpbmUsICIlKngtJSp4ICUqcyAlKnggJSpzICUqZCAlcyIsIHBhdGgpOwo+ID4g
Kwo+ID4gKyAgICAgICAgICAgICBmb3IgKGludCBpID0gMDsgaSA8IGNvdW50OyBpKyspIHsKPiA+
ICsgICAgICAgICAgICAgICAgICAgICBpZiAoc3RyY21wKHBhdGgsIGRlcGVuZGVuY3lbaV0pID09
IDApIHsKPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGR1cGxpY2F0ZSA9IDE7Cj4g
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiA+ICsgICAgICAgICAgICAg
ICAgICAgICB9Cj4gPiArICAgICAgICAgICAgIH0KPiA+ICsKPiA+ICsgICAgICAgICAgICAgaWYg
KGR1cGxpY2F0ZSkgewo+ID4gKyAgICAgICAgICAgICAgICAgICAgIGR1cGxpY2F0ZSA9IDA7Cj4g
PiArICAgICAgICAgICAgICAgICAgICAgY29udGludWU7Cj4gPiArICAgICAgICAgICAgIH0KPiA+
ICsKPiA+ICsgICAgICAgICAgICAgc3RybmNweShkZXBlbmRlbmN5W2NvdW50XSwgcGF0aCwgUEFU
SF9NQVgpOwo+ID4gKyAgICAgICAgICAgICBjb3VudCsrOwo+ID4gKwo+ID4gKyAgICAgICAgICAg
ICB0c3RfcmVzKFRJTkZPLCAiRW5hYmxlIHJlYWQvZXhlYyBwZXJtaXNzaW9ucyBmb3IgJXMiLAo+
IHBhdGgpOwo+ID4gKwo+ID4gKyAgICAgICAgICAgICBwYXRoX2JlbmVhdGhfYXR0ci0+YWxsb3dl
ZF9hY2Nlc3MgPQo+ID4gKyAgICAgICAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19S
RUFEX0ZJTEUgfAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIExBTkRMT0NLX0FDQ0VTU19GU19F
WEVDVVRFOwo+ID4gKyAgICAgICAgICAgICBwYXRoX2JlbmVhdGhfYXR0ci0+cGFyZW50X2ZkID0g
U0FGRV9PUEVOKHBhdGgsIE9fUEFUSCB8Cj4gT19DTE9FWEVDKTsKPiA+ICsKPiA+ICsgICAgICAg
ICAgICAgU0FGRV9MQU5ETE9DS19BRERfUlVMRSgKPiA+ICsgICAgICAgICAgICAgICAgICAgICBy
dWxlc2V0X2ZkLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIExBTkRMT0NLX1JVTEVfUEFUSF9C
RU5FQVRILAo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHBhdGhfYmVuZWF0aF9hdHRyLAo+ID4g
KyAgICAgICAgICAgICAgICAgICAgIDApOwo+Cj4gVW5mb3J0dW5hdGVseSwgb24gNi42LjE1LWFt
ZDY0IGtlcm5lbCAocmFuZG9tIERlYmlhbiBtYWNoaW5lKSBpdCBmYWlscwo+IChhZnRlcgo+IGZy
ZXNoIGJvb3QpIHdpdGg6Cj4KPiAuLi4KPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6OTc6IFRJ
TkZPOiBLZXJuZWwgc3VwcG9ydHMgdG1wZnMKPiB0c3Rfc3VwcG9ydGVkX2ZzX3R5cGVzLmM6NDk6
IFRJTkZPOiBta2ZzIGlzIG5vdCBuZWVkZWQgZm9yIHRtcGZzCj4gdHN0X3Rlc3QuYzoxNzQ2OiBU
SU5GTzogPT09IFRlc3Rpbmcgb24gZXh0MiA9PT0KPiB0c3RfdGVzdC5jOjExMTE6IFRJTkZPOiBG
b3JtYXR0aW5nIC9kZXYvbG9vcDEgd2l0aCBleHQyIG9wdHM9JycgZXh0cmEKPiBvcHRzPScnCj4g
bWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykKPiB0c3RfdGVzdC5jOjExMjM6IFRJTkZPOiBNb3Vu
dGluZyAvZGV2L2xvb3AxIHRvIC90bXAvTFRQX2xhbnQ2V2JLSi9zYW5kYm94Cj4gZnN0eXA9ZXh0
MiBmbGFncz0wCj4gbGFuZGxvY2tfY29tbW9uLmg6MzA6IFRJTkZPOiBMYW5kbG9jayBBQkkgdjMK
PiBsYW5kbG9jazA0LmM6MTUxOiBUSU5GTzogVGVzdGluZyBMQU5ETE9DS19BQ0NFU1NfRlNfRVhF
Q1VURQo+IGxhbmRsb2NrMDQuYzoxMjM6IFRJTkZPOiBFbmFibGUgcmVhZC9leGVjIHBlcm1pc3Np
b25zIGZvcgo+IC91c3IvbGliL2kzODYtbGludXgtZ251L2xpYmMuc28uNgo+IGxhbmRsb2NrMDQu
YzoxMzE6IFRCUk9LOiBsYW5kbG9ja19hZGRfcnVsZSgzLCAxLCAweGY3ZjEzZmY0LCAwKTogRUlO
VkFMCj4gKDIyKQo+CgpQb3NzaWJseSB0aGF0J3MgYmVjYXVzZSB0aGUgJ0xBTkRMT0NLX1JVTEVf
UEFUSF9CRU5FQVRIJyAgd2FzCnJlZmFjdG9yZWQgZnJvbSB0aGUgdjYuNyBtYWlubGluZSBrZXJu
ZWwsIHNvIGl0IGNhbid0IGFkZCB0aGUgcnVsZSBjb3JyZWN0bHkKd2l0aCBvbGRlciBrZXJuZWxz
LgoKY29tbWl0IDBlMGZjN2U4ZWI0YTExYmQ5Zjg5YTljNzRiYzdjMGUxNDRjNTYyMDMKQXV0aG9y
OiBLb25zdGFudGluIE1lc2toaWR6ZSA8a29uc3RhbnRpbi5tZXNraGlkemVAaHVhd2VpLmNvbT4K
RGF0ZTogICBUaHUgT2N0IDI2IDA5OjQ3OjQ2IDIwMjMgKzA4MDAKCiAgICBsYW5kbG9jazogUmVm
YWN0b3IgbGFuZGxvY2tfYWRkX3J1bGUoKSBzeXNjYWxsCgpCdXQgdGhpcyBpcyBteSBndWVzcyAo
dGhyb3VnaCByZWFkaW5nIHRoZSBjb2RlKSwgSSBkaWRuJ3QgZG8gbW9yZSB0bwp2ZXJpZnkgdGhh
dCBieSBpbnN0YWxsaW5nIHN1Y2ggYSBrZXJuZWwuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
