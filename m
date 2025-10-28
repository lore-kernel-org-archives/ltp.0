Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85F8ECCD1BF
	for <ltp@archiver.kernel.org>; Tue, 28 Oct 2025 03:38:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761622708; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=fVVbr8Dpe6Yv/XQtphYXjnzjNG269r2rOBOaxo9t5Vs=;
 b=H2Bh9k6PjOVEM2fy8cZjvOuO79J2F1R68rWvgk10z88vIBJxCI1DSNkTmAp32drc6AWU2
 aKwT3P9I9wZNRvOwcCTY7VAkatPc+FACgoMwM5F3yvWLmkfeca7HESbp65hmGBRVLUpFsuH
 6fBvqaXe34RAjS2VjHBhayuFVt2is/o=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A112E3C843E
	for <ltp@archiver.kernel.org>; Tue, 28 Oct 2025 04:38:28 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F2A443C14F5
 for <ltp@lists.linux.it>; Tue, 28 Oct 2025 04:38:06 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1D1BF647872
 for <ltp@lists.linux.it>; Tue, 28 Oct 2025 04:38:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761622684;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SNAxKmnPrceMN9o7R2R+CGNz5DqduhWrMftHYDuEjr4=;
 b=eMx2tYDjEPUEvxcXeetxOff2HUtuYlOFyfQXwxNDRehCEKP8sWKvS4wSa1OccAJsmOIYSk
 8GW7fVq+xLZLkHLEtxdWFsWWzG7IJjvJXyUrEey27E6lSvYY7do0Zk7JxOYdul0Yqy6SP6
 c60KMnPIPfWxKZs9NaM/r3qnfiBk14I=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-210-h14HfPZaM9SkUXEv0sL1VQ-1; Mon, 27 Oct 2025 23:37:59 -0400
X-MC-Unique: h14HfPZaM9SkUXEv0sL1VQ-1
X-Mimecast-MFC-AGG-ID: h14HfPZaM9SkUXEv0sL1VQ_1761622678
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-2930e6e2c03so57713185ad.3
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 20:37:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761622678; x=1762227478;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SNAxKmnPrceMN9o7R2R+CGNz5DqduhWrMftHYDuEjr4=;
 b=sLvWz23/I9OpJZInMBQJKOqtcz4gqPOZ3PQ13T+eWE9VVQynHi1UvpcGYKbTOBzV1p
 S7YYlzR3fYv4AKvfwf+Kjlka3rmOLhdJgEW02GaBrrc1z9uOzI5+CY81NW9qKjdkCwXI
 iZ5PjjTR+MQboi+4HxGMM09WdbKJdcZ7HmsHn8rq9wxGfCHE+TBH/b0uxS7NovaLCkqT
 40MOps5eVTZsvLbTrE4wPcbRI1C3GrZ5OClsUtutqv3BAULwF+RYiZahjbHIdAwNZFYt
 JLXgvWYl/3lucB3fSUKWg/NLJT+6+xjUqeFkqboiR+nHgSd49fRIPP9tjAZYs3B20law
 6lKA==
X-Gm-Message-State: AOJu0YzWcjCQZitMXbkqNdblXXkImxQyi2w5RW8kOhuz0pcpwk7XuFqI
 +Lt0RrJ2KRTs9Dv2ZMz070muGs1L08ednx3w7FUj4XPwUIelADCqiEju4TPWaWOoGud2xbaZQB7
 Lf3dUmyWI4XXlwBG+R8jJ2igwBD5NQMBnfuJ67pPW6F+oOmvkXyQpN3v/665ExPnyXrT5UfzJqs
 iKG7nXKCKLY8kkjUTFbxhBOkppXMM=
X-Gm-Gg: ASbGncvblKpU0tO+ImM8gOhyvH2TKeRYdk8S29l80UD3a0xkgaPwGjioelBL16M+Wvy
 //WdQE82V1YLARCEXDvLAAqUsdRAsOpipNJYN6UwGFmCzYV/MwN26rJEp9/tYUEIAKWNGeMlbvA
 aS+MOHLFK1Y6pQPNMGbd3XeIRFaepk/no2bzpV0Pq6qLenSlfWSpTsK2xh
X-Received: by 2002:a17:902:d491:b0:28e:a70f:e882 with SMTP id
 d9443c01a7336-294cb36a031mr27384685ad.11.1761622678441; 
 Mon, 27 Oct 2025 20:37:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFi0b7tCGUfntOojLABKCPmPKAuHVJJoilYGouI16nZ4GSOULFyZhYg8+mtAE6SFPabziIx7scG3IsN2GHJitA=
X-Received: by 2002:a17:902:d491:b0:28e:a70f:e882 with SMTP id
 d9443c01a7336-294cb36a031mr27384465ad.11.1761622678014; Mon, 27 Oct 2025
 20:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <20251027150924.17679-1-chrubis@suse.cz>
In-Reply-To: <20251027150924.17679-1-chrubis@suse.cz>
Date: Tue, 28 Oct 2025 11:37:46 +0800
X-Gm-Features: AWmQ_bmcOcg5TY_BVFpBrHJqo-XZxu5y82MfbopxyCxfQH7CsuMJ1GrLMsy8kbQ
Message-ID: <CAEemH2cLDd6JvbXgL514mJ5LJ2aQRWz3gacngYdjd4Ddw6XG_g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RpRC6cv7FqSyETOa80YL918tK-qXU2GHlrOzSK8JxpQ_1761622678
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib/tst_test: Fix FS kernel supported check
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

T24gTW9uLCBPY3QgMjcsIDIwMjUgYXQgMTE6MTDigK9QTSBDeXJpbCBIcnViaXMgPGNocnViaXNA
c3VzZS5jej4gd3JvdGU6Cgo+IEluIGNhc2UgdGhhdCB0aGVyZSBpcyBvbmx5IHNpbmdsZSBmaWxl
c3lzdGVtIGRlZmluZWQgaW4KPiB0c3RfdGVzdC5maWxlc3lzdGVtcyB3ZSBmb3JtYXQgdGhlIGRl
dmljZSBpbiB0aGUgc2V0dXAgcmF0aGVyIGluIHRoZQo+IGZ1bmN0aW9uIHRoYXQgaXRlcmF0ZXMg
b3ZlciBhbGwgZmlsZXN5c3RlbXMuIEhvd2V2ZXIgd2UgbWlzc2VkIGEgY2hlY2sKPiBpZiBhIGZp
bGVzeXN0ZW0gaXMgc3VwcG9ydGVkIGluIHRoaXMgc2hvcnRjdXQsIGhlbmNlIGlmIG1rZnMgZm9y
IHRoZQo+IGZpbGVzeXN0ZW0gd2FzIGluc3RhbGxlZCBhbmQga2VybmVsIHN1cHBvcnQgd2FzIG1p
c3NpbmcgdGhlIHRlc3QgZmFpbGVkCj4gd2hlbiBpdCBhdHRlbXB0ZWQgdG8gbW91bnQgdGhlIGZp
bGVzeXN0ZW0uCj4KPiBUZXN0ZWQtYnk6IEFuZGVycyBSb3hlbGwgPGFuZGVycy5yb3hlbGxAbGlu
YXJvLm9yZz4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3VzZS5jej4K
PgoKUmV2aWV3ZWQtYnk6IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKLS0tCj4gIGxpYi90
c3RfdGVzdC5jIHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKykKPgo+
IGRpZmYgLS1naXQgYS9saWIvdHN0X3Rlc3QuYyBiL2xpYi90c3RfdGVzdC5jCj4gaW5kZXggYjg4
OTRmNzgyLi5kNDlmMzQ2MjMgMTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF90ZXN0LmMKPiArKysgYi9s
aWIvdHN0X3Rlc3QuYwo+IEBAIC0xNTMwLDYgKzE1MzAsMTAgQEAgc3RhdGljIHZvaWQgZG9fc2V0
dXAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKPiAgICAgICAgICAgICAgICAgdGRldi5mc190eXBl
ID0gZGVmYXVsdF9mc190eXBlKCk7Cj4KPiAgICAgICAgICAgICAgICAgaWYgKCF0c3RfdGVzdC0+
YWxsX2ZpbGVzeXN0ZW1zICYmIGNvdW50X2ZzX2Rlc2NzKCkgPD0gMSkgewo+ICsKPiArICAgICAg
ICAgICAgICAgICAgICAgICBpZiAoIXRzdF9mc19pc19zdXBwb3J0ZWQodGRldi5mc190eXBlKSkK
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9icmsoVENPTkYsICJUaGUgJXMg
ZmlsZXN5c3RlbSBpcyBub3QKPiBzdXBwb3J0ZWQiLCB0ZGV2LmZzX3R5cGUpOwo+ICsKPiAgICAg
ICAgICAgICAgICAgICAgICAgICBpZiAodHN0X3Rlc3QtPmZpbGVzeXN0ZW1zICYmCj4gdHN0X3Rl
c3QtPmZpbGVzeXN0ZW1zLT5ta2ZzX3ZlcikKPgo+IHRzdF9jaGVja19jbWQodHN0X3Rlc3QtPmZp
bGVzeXN0ZW1zLT5ta2ZzX3ZlciwgMSk7Cj4KPiAtLQo+IDIuNDkuMQo+Cj4KPiAtLQo+IE1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
