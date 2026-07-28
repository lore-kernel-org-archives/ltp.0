Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27426C54F4C
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 13:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785246638; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=BEwdZwxrdc6KFU1EHt8T/s7fHSnRDckZ6IRhQOx8QLY=;
 b=PD2KpVp9OsM6ac8c4BkAmrYHGK6ETM8UoSX0AfJe/JNfHetLoRmdYahBC7h1UaNG1V0ml
 U9TIfpccjjOQXpKV0a3miiFcZa24gpF+1WhB8kpj0eynIj3it93J+P/VkF2dJC+BfJV3ssw
 xZVuGdF/oxk/vnxTXsQXdVSHTtI9BaU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C6963E749F
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 15:50:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2532C3CD529
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:50:17 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CFF3B60068A
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 15:50:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785246613;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=obtli1dJeVhLQIVKBbMkMn7pPeFS0z7xzBmzhH7uhDA=;
 b=i2BjfIx5eqhtvh9BAW1SNOaxyWhn6pikO3kcS9EyiUTZKHLtIPZT8Eez6O6Uzimg4MpmoD
 +3C96Ce0wtQOSnlB7PT1cVqTH3eDVf2GAo4QfWkHiyoMMksPVISWuh1/F1tKcHeMFY1aku
 mPY/KZmhuKKjh3wXbpl1FaDlb2W9md8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-68LmW9cgMNa-WRL4r8Qf5Q-1; Tue, 28 Jul 2026 09:50:10 -0400
X-MC-Unique: 68LmW9cgMNa-WRL4r8Qf5Q-1
X-Mimecast-MFC-AGG-ID: 68LmW9cgMNa-WRL4r8Qf5Q_1785246609
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-47faa02f707so799171f8f.1
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 06:50:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785246609; x=1785851409;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=obtli1dJeVhLQIVKBbMkMn7pPeFS0z7xzBmzhH7uhDA=;
 b=tWIOgRetC7qulQjTRNANKNFPqrcCEZwWGVgF1ysZ2fHRug+NhImMEQ9C8BHtzz5Wqq
 NF1AFf9SUqeGMEkgZb3e22Mmu+QaqTDt7ggAA9jgVUzvJkAZW6YxKpMfCkX7rLgyl/j5
 3+KXGxw3Ll2ymDiuE6+qcvZ+/HT4OFUBAZSvQ3LxVAL69uU2BpNyeXQY2ND0t+0vVDWO
 bvfqeWV3JmaM0yQxoEj43ovQWkgvcEqJzTsnrNIorEJUyrLOcBPZAMvxW5/H+Q7hM4+m
 aXhXyKOwBJjz9YrWB4ju0CI6rgpwThlwVnzwDRB5Mqc/ulXke0Xy4OhPX092eSlkpZXm
 DmCA==
X-Forwarded-Encrypted: i=1;
 AHgh+Roau1JLl+orJlkEpvcKFGzbTnt+YF81q/U6XNquSJ886xAaxoqf7Xprd3MyDIEcqXcHSDs=@lists.linux.it
X-Gm-Message-State: AOJu0Yzt7O9mkcb4gvZeTm8kfjlzECDhKhhoT2SgVj46gDNTKV1/79MK
 td490lcw6E19pS8GmWRTuOStmqTQEc1cV6CTLFU7VZ5b6wvRTFHNgyGa9Us8BwoqM5SWquPeS3e
 z/Nmpl/9t6YZC8tWD9zM/oydPv/5GwNR/RlSJE0MrFMh5WmScwF4beSKmPiJs6dozl/GF4bonnN
 nZcm8So1xGr8gB4rBNVEh1AFpYmXY=
X-Gm-Gg: AR+sD13KG3sjyaQ01KAuSJjXfG4FD2OlFp/GHWwI6A6NoKj7SQMHKcvbVb5SZr3Jcn1
 3soLf3gMtYZrUF7S5v6tpPrpvU1L6eF/rGde265k8goIeYStfbKtp0jnPlUw18oNC1jqKSROwbj
 pawXObW+0HLpN96Z6f8rwyUAfTJr59jrjdbZhr8aWGUJzQmk7DzlkkJQk=
X-Received: by 2002:a05:6000:2502:b0:47f:924a:655b with SMTP id
 ffacd0b85a97d-47fb1ee2a4fmr3281282f8f.26.1785246609462; 
 Tue, 28 Jul 2026 06:50:09 -0700 (PDT)
X-Received: by 2002:a05:6000:2502:b0:47f:924a:655b with SMTP id
 ffacd0b85a97d-47fb1ee2a4fmr3281238f8f.26.1785246608997; Tue, 28 Jul 2026
 06:50:08 -0700 (PDT)
MIME-Version: 1.0
References: <20260722192052.3975-1-linuxtestproject.agent@gmail.com>
 <20260722212646.2340340-1-bgrech@redhat.com> <20260727082240.GA1010349@pevik>
 <CAA835F7iF91Hrb099kbpG0+CR3WOBCH34C7tiB-4uJfNWjva8w@mail.gmail.com>
 <20260728131601.GA1065673@pevik>
In-Reply-To: <20260728131601.GA1065673@pevik>
Date: Tue, 28 Jul 2026 15:49:52 +0200
X-Gm-Features: AUfX_mySgHc651jvzzhtcUQT12LUMQaHMlep-H1-b-gd3DFYxWFHJRePJpor6jM
Message-ID: <CAASaF6xWz9LxH-=wUveuSt0UBmUs9L7Os1OdWQ5VdpSy3UUTkg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Kp6v4aeqmwnkKlzJ8R7v0C4l7SBR0iukhXzXT1kquSk_1785246609
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec
 for debug kernel reliability
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdWwgMjgsIDIwMjYgYXQgMzoxNuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhpIEJyaWFuLAo+Cj4gPiBIaSBQZXRyLAo+Cj4gPiBIYXBweSB0byBj
b250cmlidXRlIQo+IFdlIGFyZSBoYXBweSB0byBnZXQgbmV3IGNvbnRyaWJ1dG9ycyA6KS4KPgo+
ID4gVGhhbmsgeW91IGZvciBsZXR0aW5nIG1lIGtub3csIHRoYXQgaXMgc3RyYW5nZS4gT24gbXkg
c3lzdGVtIGl0J3MKPiA+IGNvbmZpZ3VyZWQgY29ycmVjdGx5LiBEaWdnaW5nIGEgbGl0dGxlIGRl
ZXBlciwgSSB0aGluayBpdCBtaWdodCBiZSBhCj4gPiBjb3Jwb3JhdGUgc210cCBpc3N1ZS4KPgo+
IEZZSSBpdCdzIG1hbmdsZWQgIkZyb206IiBtYWlsIGhlYWRlciBbMV06ICJGcm9tOiBCcmlhbiBH
cmVjaCB2aWEgbHRwCj4gPGx0cEBsaXN0cy5saW51eC5pdD4iLiBJdCdzIHByb2JhYmx5IERNQVJD
ICsgTWFpbG1hbiByZWxhdGVkLgo+Cj4gQlRXIEkgdGhvdWdodCBpdCBzaG91bGQgbm90IGJlIG9u
IHJlZGhhdC5jb20gc2lkZSwgYmVjYXVzZSBKYW4gU3RhbmNlayBkb2VzIG5vdAo+IGhhdmUgdGhh
dCBwcm9ibGVtLCBidXQgYWN0dWFsbHkgaGUgZG9lcyBoYXZlIHRoYXQgcHJvYmxlbSBhcyB3ZWxs
IFszXSAiRnJvbTogSmFuCj4gU3RhbmNlayB2aWEgbHRwIDxsdHBAbGlzdHMubGludXguaXQ+Ii4g
SXQncyBqdXN0IGhlIHByb2JhYmx5IGRvZXMgbWVyZ2UgdGhlc2UKPiBwYXRjaGVzIGRpcmVjdGx5
IHdpdGhvdXQgZmlyc3QgZG93bmxvYWRpbmcgdGhlbSBmcm9tIHRoZSBtYWlsaW5nIGxpc3QuCj4K
PiBBbnl3YXksIHZlcnkgbWlub3IgcHJvYmxlbSwgYnV0IGl0J2QgYmUgbmljZSB0byBnZXQgaXQg
Zml4ZWQuIE91ciBsaXN0IGhhcwo+IHNldHVwOiBmcm9tX2lzX2xpc3QgPSBuby4gSSBzdXBwb3Nl
IHRoaXMgaXMgY29ycmVjdCAobG9va2luZyBhdCB0aGUgZG9jcyBbNF0gYW5kCj4gYWxzbyBjaGVj
ayBvdGhlciBwcm9qZWN0cyBzZXR1cCBbNV0pLgoKQ2FuIHlvdSBzZWUgYWxzbyB0aGVzZSB0d28g
aW4gb3VyIGNvbmZpZz8KZG1hcmNfbW9kZXJhdGlvbl9hY3Rpb24gPSBBY2NlcHQKZG1hcmNfcXVh
cmFudGluZV9tb2RlcmF0aW9uX2FjdGlvbiA9IE5vCgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIK
Pgo+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvMjAyNjA3MjIyMTI2NDYuMjM0MDM0
MC0xLWJncmVjaEByZWRoYXQuY29tL3Jhdwo+IFsyXSBodHRwczovL3dpa2kubGlzdC5vcmcvREVW
L0RNQVJDCj4gWzNdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8wOGM4NWNmNjRkNzAzZGZh
YmEzMTM5OGFiOWQ5YjQ4MDQ4OGZlMzM4LjE3NDcyMjc0ODEuZ2l0LmpzdGFuY2VrQHJlZGhhdC5j
b20vcmF3Cj4gWzRdIGh0dHBzOi8vbGlzdC5vcmcvbWFpbG1hbi1hZG1pbi50eHQKPiBbNV0gaHR0
cHM6Ly9zb3VyY2V3YXJlLm9yZy9waXBlcm1haWwvYmludXRpbHMvMjAyMy1PY3RvYmVyLzEyOTg1
Mi5odG1sCj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
