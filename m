Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962FACFC273
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 08:11:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D7903C66D5
	for <ltp@archiver.kernel.org>; Tue, 15 Oct 2024 10:11:20 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C10823C0202
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:11:05 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B29FC619590
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 10:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728979862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0q6o/SfvA0+tiALAPnWSQ099xkbaWkHLKC0PYr0L10=;
 b=FfInL4qNZR/hb8UIZrB37nFTNpFNfeG+j40hz6d+cz2LJ24WK84stUSb/KzCNT4vbpeeMP
 YKil8/zWmdjjBvBAOpDOWgE2D+IVEtO/R166u9eiQQhBvSKY8v3ccAP8gmLzpsNuOIJke1
 yUC0DGsriuzUtY4d4XjvrTZQqPA6c6I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-mmITPg7vPxyUUe_h56ct6w-1; Tue, 15 Oct 2024 04:10:59 -0400
X-MC-Unique: mmITPg7vPxyUUe_h56ct6w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2e2e8a71e3aso3899675a91.3
 for <ltp@lists.linux.it>; Tue, 15 Oct 2024 01:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728979857; x=1729584657;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q0q6o/SfvA0+tiALAPnWSQ099xkbaWkHLKC0PYr0L10=;
 b=SXk5elOt+RTlQeuHVSe606M5fzSv4JJ6G3JhkynrKfN3J8pCLCeNZqK9EM+ElPujO2
 mtY6Tb3Ze+oI5saOw8714CbWkG2pkL2ImvylRpNCx5DUKbVt5wykOOcrHMtwBTnxJBrp
 DjVDuidHW7CREV9vLTAVs9Kmjaduemvk6as1vCKXBfAi+a+pCtX3UxLW89U/EpI8Szai
 scHG9zbegSwYdSuByzWimbysq3vepkexsIBCYhqs92uElJRPHAmHP4E57Bc8zG2jdzQr
 FYeox5NL4zU3S8qkgKvs4spOLHI82NBGgmiGl9aNG3eksZhTO3BdjjrPAW2ptr2n4Lqb
 FfeQ==
X-Gm-Message-State: AOJu0Yy2sFZommM3x0uroYKssrt/+OdqpoeeUaGJKH4791PDrBP4T1A/
 hykdPrdR7DmmTiEg98uIaXRYPWu4FDmixg/LRtlc061XPES+S+bg2HOhEsDJHBzjEyvZQnbORkk
 rHYWen5SZyERPnuT3f4wQbwJ3XsOrbAHUn6Qnbbt6MjI8XE4dzQ4/hpG06MkyzfK+clCjrjhXkW
 oDEQ2/tV8d9VC1mDrTImHiL0xe7l8rLieIOsd5
X-Received: by 2002:a17:90a:bd8d:b0:2e2:ebab:792d with SMTP id
 98e67ed59e1d1-2e31538f0dbmr12547907a91.41.1728979857723; 
 Tue, 15 Oct 2024 01:10:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHrpx1lAxrI8FYw9apiZkJntfTuBd8SECndKUjmIaxK9ANdqBb4sX43hv8TVxHWyy9tyrcbn9pnVih6eoRb8xs=
X-Received: by 2002:a17:90a:bd8d:b0:2e2:ebab:792d with SMTP id
 98e67ed59e1d1-2e31538f0dbmr12547890a91.41.1728979857311; Tue, 15 Oct 2024
 01:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20241009-generate_syscalls-v4-0-5328a785bbad@suse.com>
 <20241009-generate_syscalls-v4-3-5328a785bbad@suse.com>
In-Reply-To: <20241009-generate_syscalls-v4-3-5328a785bbad@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 15 Oct 2024 16:10:45 +0800
Message-ID: <CAEemH2fzAnH7nyeVJycs8hM626Ct2mNZqEcKbfzsPpMTiFt8Ug@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 3/4] Delete obsolete strip_syscall.awk file
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

T24gV2VkLCBPY3QgOSwgMjAyNCBhdCA1OjQ24oCvUE0gQW5kcmVhIENlcnZlc2F0byA8YW5kcmVh
LmNlcnZlc2F0b0BzdXNlLmRlPgp3cm90ZToKCj4gRnJvbTogQW5kcmVhIENlcnZlc2F0byA8YW5k
cmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJlYSBDZXJ2ZXNh
dG8gPGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxs
aXdhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICBpbmNsdWRlL2xhcGkvc3lzY2FsbHMvc3RyaXBf
c3lzY2FsbC5hd2sgfCAxOSAtLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAx
OSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xhcGkvc3lzY2FsbHMvc3Ry
aXBfc3lzY2FsbC5hd2sKPiBiL2luY2x1ZGUvbGFwaS9zeXNjYWxscy9zdHJpcF9zeXNjYWxsLmF3
awo+IGRlbGV0ZWQgZmlsZSBtb2RlIDEwMDc1NQo+IGluZGV4IGU4ZGZmNDIyZS4uMDAwMDAwMDAw
Cj4gLS0tIGEvaW5jbHVkZS9sYXBpL3N5c2NhbGxzL3N0cmlwX3N5c2NhbGwuYXdrCj4gKysrIC9k
ZXYvbnVsbAo+IEBAIC0xLDE5ICswLDAgQEAKPiAtIyEvdXNyL2Jpbi9hd2sgLWYKPiAtIwo+IC0j
IER1bWIgc2NyaXB0IHRoYXQgY2FuIGJlIHVzZWQgdG8gc3RyaXAgYWxsIG9mIHRoZSBzeXNjYWxs
IGluZm9ybWF0aW9uCj4gZnJvbQo+IC0jIHRoZSBhcmNoLXJlc3BlY3RpdmUgdW5pc3RkKi5oLgo+
IC0jCj4gLSMgRXhhbXBsZXM6Cj4gLSMKPiAtIyAxLiBHcmFiIHRoZSBpMzg2IDMyLWJpdCBzeXNj
YWxscyBmcm9tIHVuaXN0ZF8zMi5oIGFuZCBwdXQgdGhlbSBpbgo+IGkzODYuaW4KPiAtIyBzdHJp
cF9zeXNjYWxsLmF3ayBhcmNoL3g4Ni9pbmNsdWRlL2FzbS91bmlzdGRfMzIuaCA+IGkzODYuaW4K
PiAtIwo+IC0KPiAtL14jZGVmaW5lW1s6c3BhY2U6XV0rX19OUl9bMC05YS16XSsvIHsKPiAtCj4g
LSAgICAgICBzdWIgKC8jZGVmaW5lW1s6c3BhY2U6XV0rX19OUl8vLCAiIiwgJDApOwo+IC0gICAg
ICAgc3ViICgvW1s6c3BhY2U6XV0qKFwvXCouKikvLCAiIiwgJDApOwo+IC0gICAgICAgc3ViICgv
W1s6c3BhY2U6XV0rLywgIiAiLCAkMCk7Cj4gLQo+IC0gICAgICAgcHJpbnQKPiAtfQo+Cj4gLS0K
PiAyLjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
