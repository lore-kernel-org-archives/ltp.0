Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23E80C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 12:06:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B0EE3D0DB7
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 14:06:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AE6E3CE037
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 14:06:06 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 99D6C14088EE
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 14:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718798763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yl9P1kxbkByeQ3iWrllKC5SEnKkujnj+kEKs/+d+FPU=;
 b=TfAEOUCCvyD9G2iMEpa691z81+0bI0cuvHYZyR8XWvN6bm6BSLjZaQY5H78ZBwCQCTngdt
 LPEHSMc9+ZiVb1ffhLMT37PmCmvWMw7a0kcVdhyzTQd0dc2ZMU8WDWK+1j4QylHGSQ+D03
 sg5zzaIJrtWeDpGAtJ1IRdu0AL1HtS0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-30-eEoede32Ot-PkcsA3vgXrQ-1; Wed, 19 Jun 2024 08:05:59 -0400
X-MC-Unique: eEoede32Ot-PkcsA3vgXrQ-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c24109ad3fso6799244a91.0
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 05:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718798758; x=1719403558;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s7pP/AS0mvYED1KcymrP6WVxczJIr5iyucRYSxvk5Ps=;
 b=vIkOkCDpn9j4ATxPBxxbyQlNi7e4uHbFYSmVENbOGjmgNg2QnpcjzoTrjLx30fjMUX
 46JU8JMps/3rlrL/4drA3D9z+NFIXd9cgUqHuLH0IMRf72nDnjTrQxyMtLLwzjgrV4Mc
 PXeq1a4Lksa4rQgHJbMeAUCSugY4tYFDGozAfINeFevBZVnl9XZiX3xrNHCJyiNUBfQz
 fXQxekSCswckHUGy6jUC2Klrzi50uGmqbDScvYURXOECAQqMcnn854T5f3TfX9Dzbtf9
 LU+SaRrVUhGGqzlbg2/7hfNAJ2iqmPvKxGq5dHL8vnsipi0V5O2iTKg/5AoCGhHnFV0U
 mcoQ==
X-Gm-Message-State: AOJu0YzhhyLLC7gQcjfTAMr1SBha3xwzGE9SCcc2iHGOdqTavtXzeTO6
 OB59XFBjtzZkp1fwilcCwiP8aAWDimUTVH7EQlLmkRpBqez4br6Mb2JdhrAcpG7tiKZC5y9FGIu
 A+/zXlBMiRWV5L9F+G5JszdVk4uZvGkL0uTPJOPmElemsv36xSayuWzkKibk4E0x7WlLZf+03rw
 /rVKgtkH9l8S8lZF9qu9bHHfE=
X-Received: by 2002:a17:90a:e00e:b0:2c0:17b4:85aa with SMTP id
 98e67ed59e1d1-2c7b5c9f60amr2173745a91.22.1718798758237; 
 Wed, 19 Jun 2024 05:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxpZJcp7KygT2tyKPiXkV1BY7cKi6V1tTiDJ41C5rmNv0GvP/jxvOOCgdlaogFg/fsWkWOdR9ichHE5gITxGQ=
X-Received: by 2002:a17:90a:e00e:b0:2c0:17b4:85aa with SMTP id
 98e67ed59e1d1-2c7b5c9f60amr2173717a91.22.1718798757700; Wed, 19 Jun 2024
 05:05:57 -0700 (PDT)
MIME-Version: 1.0
References: <20240617053436.301336-1-liwang@redhat.com>
 <20240619092704.GA428912@pevik>
In-Reply-To: <20240619092704.GA428912@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Jun 2024 20:05:44 +0800
Message-ID: <CAEemH2d=m3qAJkiv86B+L+iTc5qc+phGn+GO=kEe_fGOXxEMLQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Zirong Lang <zlang@redhat.com>,
 Boyang Xue <bxue@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] configure.ac: Add _GNU_SOURCE for struct
 fs_quota_statv check
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
Cc: linux-xfs@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwgWEZTLUV4cGVydHMsCgpPbiBXZWQsIEp1biAxOSwgMjAyNCBhdCA1OjI34oCvUE0g
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+ID4gVGhlc2Ug
Y2hhbmdlcyBoZWxwIGVuc3VyZSB0aGF0IHRoZSBuZWNlc3NhcnkgZmVhdHVyZXMgYW5kIGRlZmlu
aXRpb25zCj4gPiBhcmUgYXZhaWxhYmxlIGR1cmluZyB0aGUgY29uZmlndXJhdGlvbiBwcm9jZXNz
LCBwcmV2ZW50aW5nIHBvdGVudGlhbAo+ID4gaXNzdWVzIHJlbGF0ZWQgdG8gbWlzc2luZyBvciBp
bmNvbXBhdGlibGUgZGVmaW5pdGlvbnMuIFRoaXMgc2hvdWxkCj4gPiByZXNvbHZlIHRoZSBjb21w
aWxhdGlvbiBlcnJvciByZWxhdGVkIHRvIHN0cnVjdCBmc19xdW90YV9zdGF0djoKPgo+ID4gIC91
c3IvaW5jbHVkZS94ZnMveHFtLmg6MTY3Ojg6IGVycm9yOiByZWRlZmluaXRpb24gb2Yg4oCYc3Ry
dWN0Cj4gZnNfcWZpbGVzdGF0duKAmQo+Cj4gSSB3b25kZXIgaG93IF9HTlVfU09VUkNFIGluZmx1
ZW5jZXMgYW55IFhGUyBoZWFkZXI/Cj4gSSBoYXZlbid0IGZvdW5kIGFueXRoaW5nIGluICg8eGZz
LyouaD4pIG9yIGluIDxzeXMvcXVvdGEuaD4KPgoKV2l0aCBpbnN0YWxsaW5nIGEgbmV3ZXIgeGZz
cHJvZ3MtZGV2IHBhY2thZ2Ugb24gUkhFTCwgd2UgZ290IGEgcHJvYmxlbQppbiBjb25maWd1cmlu
ZyBvdXIgTFRQIHRlc3QuCgpBY2NvcmRpbmcgdG8gdGhlIGluY2x1c2lvbiByZWxhdGlvbnNoaXA6
ICJ4ZnMveHFtLmgiIC0+ICJ4ZnMveGZzLmgiIC0+CiJ4ZnMvbGludXguaCIuClRoZSBsaW51eC5o
IGhlYWRlciBpbnRyb2R1Y2VzIGFuIGlubGluZWQgZnVuY3Rpb24gdGhhdCBuZWVkcyAnX0dOVV9T
T1VSQ0UnCmFuZCA8ZmNuY3RsLmg+LgoKJCBnaXQgY2xvbmUgaHR0cHM6Ly9rZXJuZWwuZ29vZ2xl
c291cmNlLmNvbS9wdWIvc2NtL2ZzL3hmcy94ZnNwcm9ncy1kZXYKJCBjZCB4ZnNwcm9ncy1kZXYv
CiQgZ2l0IGRlc2NyaWJlIC0tY29udGFpbnMgOWQ2MDIzYTg1NmExYzRmODQ0MTVkZmY1OWIwZDU0
NTljYzg3NjhkYgp2NS41LjAtcmMxfjM5CgojaWYgZGVmaW5lZChGQUxMT0NfRkxfWkVST19SQU5H
RSkKc3RhdGljIGlubGluZSBpbnQKcGxhdGZvcm1femVyb19yYW5nZSgKICAgICAgICBpbnQgICAg
ICAgIGZkLAogICAgICAgIHhmc19vZmZfdCAgICAgICAgc3RhcnQsCiAgICAgICAgc2l6ZV90ICAg
ICAgICBsZW4pCnsKICAgICAgICBpbnQgcmV0OwoKICAgICAgICByZXQgPSBmYWxsb2NhdGUoZmQs
IEZBTExPQ19GTF9aRVJPX1JBTkdFLCBzdGFydCwgbGVuKTsKICAgICAgICBpZiAoIXJldCkKICAg
ICAgICByZXR1cm4gMDsKICAgICAgICByZXR1cm4gLWVycm5vOwp9CiNlbHNlCiNkZWZpbmUgcGxh
dGZvcm1femVyb19yYW5nZShmZCwgcywgbCkgKC1FT1BOT1RTVVBQKQojZW5kaWYKCgpNeSB0ZXN0
IHZlcnNpb24gaXMgYmFzZWQgb24gNi41IHNvIGNvbnRhaW5zIHRoZSBpbmxpbmVkIGZ1bmN0aW9u
IHRvIGJ1aWxkLgoKIyBycG0gLXFmIC91c3IvaW5jbHVkZS94ZnMveHFtLmgKeGZzcHJvZ3MtZGV2
ZWwtNi41LjAtMy5lbDEwLng4Nl82NAoKCgo+IEkga25vdyB0aGF0IHNvbWUgcXVvdGFjdGwwWzIz
XS5jIGRlZmluZSBfR05VX1NPVVJDRSwgYnV0IGl0J3MgaW50ZXJlc3RpbmcKPiB0aGF0Cj4gdGhp
cyBpbmZsdWVuY2UgdGhlIGhlYWRlci4gQWxzbywgd2hpY2ggUkhFTCAob3Igd2hhdGV2ZXIgZGlz
dHJvKSB2ZXJzaW9uCj4gaGFzCj4gdGhpcyBwcm9ibGVtPwoKClRoZSBlcnJvciBvY2N1cnJlZCAo
d2l0aCBpbnN0YWxsIHhmc3Byb2dzLWRldmVsKSBkdXJpbmcgdGhlIGNvbmZpZ3VyZSBzY3JpcHQK
Y2hlY2tpbmcgc3RydWN0IGZzX3F1b3RhX3N0YXR2LiBJdCBmYWlsZWQgdG8gY29tcGlsZSBjb25m
dGVzdC5jIGFuZCByZXBvcnQKc3VjaCBlcnJvcnM6Cgpjb25maWd1cmU6NTY5NzogY2hlY2tpbmcg
Zm9yIHN0cnVjdCBmc19xdW90YV9zdGF0dgpjb25maWd1cmU6NTY5NzogZ2NjIC1jIC1nIC1PMiAg
Y29uZnRlc3QuYyA+JjUKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5jbHVkZS94ZnMveGZz
Lmg6OSwKICAgICAgICAgICAgICAgICBmcm9tIC91c3IvaW5jbHVkZS94ZnMveHFtLmg6OSwKICAg
ICAgICAgICAgICAgICBmcm9tIGNvbmZ0ZXN0LmM6MTM4OgovdXNyL2luY2x1ZGUveGZzL2xpbnV4
Lmg6IEluIGZ1bmN0aW9uICdwbGF0Zm9ybV96ZXJvX3JhbmdlJzoKL3Vzci9pbmNsdWRlL3hmcy9s
aW51eC5oOjE4ODoxNTogZXJyb3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCidm
YWxsb2NhdGUnIFstV2ltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQogIDE4OCB8ICAgICAg
ICAgcmV0ID0gZmFsbG9jYXRlKGZkLCBGQUxMT0NfRkxfWkVST19SQU5HRSwgc3RhcnQsIGxlbik7
CiAgICAgIHwgICAgICAgICAgICAgICBefn5+fn5+fn4KY29uZmlndXJlOjU2OTc6ICQ/ID0gMQoK
SXQgc2ltaWxhcmx5IHRvIHRoZSBhYm92ZSBxdW90YWN0bDA3IHBhdGNoIGZpeCwgc28gYWRkaW5n
ICcjZGVmaW5lCl9HTlVfU09VUkNFJwppcyBhY3R1YWxseSBmb3IgbWFraW5nIHRoZSBmYWxsb2Nh
dGUoKSBoYXBweS4KCk9yLCBhbm90aGVyIHdheSBpcyB0aGUgY2hhbmdlIG1hZGUgaW4gInhmc3By
b2dzLWRldi9pbmNsdWRlL2xpbnV4LmgiCm90aGVyd2lzZSB3ZSBjYW4ndApjb25maWd1cmUgb3Vy
IExUUCBjb3JyZWN0bHkuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
