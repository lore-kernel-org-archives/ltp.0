Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2615C27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 12:08:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D84F3D0DC2
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 14:08:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAAB73D0D99
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 14:08:32 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 52E86607125
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 14:08:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718798909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Wsv4Z0keMD+1i0M3UdVIUsnCZmrS9JM3b/XCt7qtBIk=;
 b=Xk2ctsKORUywN6CZozfdTjMeIXNJCQBWQWdkGW5yMHC6BTWP3wt1KK1qoLoUb4lDHEey6U
 mptQql9QtbBymixgimhumcILRh6wk7obdYehpE0nfGI7NJcJEbK+uokOCHydjZo9pp3YBb
 CvAPOoNoxr8NQ50jx+bnrqm1MYTCHAs=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-zm4YrmHVNL64_xydi9Kt4w-1; Wed, 19 Jun 2024 08:08:27 -0400
X-MC-Unique: zm4YrmHVNL64_xydi9Kt4w-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c7b752f4a7so866354a91.0
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 05:08:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718798906; x=1719403706;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vtMGB2+i3iPsI476FuKkBkf+YqxiSkLGqOQLyUSbPtQ=;
 b=I52XE5drWTgvv5cbXerPe5uPwdW9Hu29N0qwf4hb/8F4TK0DR0yzoli0ahNd5Yem5D
 i7kkxhPlZdpshMxJP03n6xVN9znFTmd9EEJN6snwU4mW0MszFFeBu1zAqPRC5DyRvCdV
 0lilSe3aCTMzfW8pqBUyLBgg6U0jx+umqR1bKjvWMheUCQTjCYXoUakhq12fEDe/+o67
 oJQHrfZOgD7JB4VScoG9kbHS99X1jXQRyVi6+aK6IGjzy1HcOV+cQIYGIcf40nfg948u
 T8YkZ8nnCzg/wF/9oOyfU2Hd8CmlDkf803C6hgV8cQL/WgF3Y9QYQBcU7Vc3Pv75qgwp
 yz+Q==
X-Gm-Message-State: AOJu0YyOjTAqfKnzUiHC2f65zl4zmVb2GAJd6R4dD76Xv1KHyL+HPvDG
 IuPeESez9l9oxC+qAWyAU0ueWtdaSirFiUGwUWDvXZWELviKCtukYFpEkw/yemB+vwukGTaDJHC
 //Z9HI8Tsotg8EOuHTE9GEJPH/pJerztD3+WHwiN+WtQHu91QW4wjufGbSZmOh+anHsSGgCinmz
 Tv0EePi/LqRcWh3XcrH/iKUWY=
X-Received: by 2002:a17:90b:3552:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c7b5daec84mr2160543a91.45.1718798906131; 
 Wed, 19 Jun 2024 05:08:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIkMqQzyU4ifqAg++idSn6LSICzKFFV77pXomUV63fK2VLCeUKcpKnXJ6USYxE5yWCGcAstC3S2gIYj6vH1f8=
X-Received: by 2002:a17:90b:3552:b0:2c3:11fa:41f with SMTP id
 98e67ed59e1d1-2c7b5daec84mr2160519a91.45.1718798905734; Wed, 19 Jun 2024
 05:08:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240617053436.301336-1-liwang@redhat.com>
 <20240619092704.GA428912@pevik>
 <CAEemH2d=m3qAJkiv86B+L+iTc5qc+phGn+GO=kEe_fGOXxEMLQ@mail.gmail.com>
In-Reply-To: <CAEemH2d=m3qAJkiv86B+L+iTc5qc+phGn+GO=kEe_fGOXxEMLQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Jun 2024 20:08:14 +0800
Message-ID: <CAEemH2fH6tX9obxcVS6XJLcMvAvOz-JPe6wWoQdv26x8GAx2rQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Zirong Lang <zlang@redhat.com>,
 Boyang Xue <bxue@redhat.com>, Eric Sandeen <sandeen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

Y2MgRXJpYyBTYW5kZWVuIDxzYW5kZWVuQHJlZGhhdC5jb20+IHdobyBpcyB0aGUgYXV0aG9yIG9m
OgoKY29tbWl0IDlkNjAyM2E4NTZhMWM0Zjg0NDE1ZGZmNTliMGQ1NDU5Y2M4NzY4ZGIKQXV0aG9y
OiBFcmljIFNhbmRlZW4gPHNhbmRlZW5AcmVkaGF0LmNvbT4KRGF0ZTogICBUaHUgRmViIDI3IDE1
OjA1OjQ4IDIwMjAgLTA1MDAKCiAgICBsaWJ4ZnM6IHVzZSBGQUxMT0NfRkxfWkVST19SQU5HRSBp
biBsaWJ4ZnNfZGV2aWNlX3plcm8KCk9uIFdlZCwgSnVuIDE5LCAyMDI0IGF0IDg6MDXigK9QTSBM
aSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cgo+IEhpIFBldHIsIFhGUy1FeHBlcnRz
LAo+Cj4gT24gV2VkLCBKdW4gMTksIDIwMjQgYXQgNToyN+KAr1BNIFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PiB3cm90ZToKPgo+PiBIaSBMaSwKPj4KPj4gPiBUaGVzZSBjaGFuZ2VzIGhlbHAg
ZW5zdXJlIHRoYXQgdGhlIG5lY2Vzc2FyeSBmZWF0dXJlcyBhbmQgZGVmaW5pdGlvbnMKPj4gPiBh
cmUgYXZhaWxhYmxlIGR1cmluZyB0aGUgY29uZmlndXJhdGlvbiBwcm9jZXNzLCBwcmV2ZW50aW5n
IHBvdGVudGlhbAo+PiA+IGlzc3VlcyByZWxhdGVkIHRvIG1pc3Npbmcgb3IgaW5jb21wYXRpYmxl
IGRlZmluaXRpb25zLiBUaGlzIHNob3VsZAo+PiA+IHJlc29sdmUgdGhlIGNvbXBpbGF0aW9uIGVy
cm9yIHJlbGF0ZWQgdG8gc3RydWN0IGZzX3F1b3RhX3N0YXR2Ogo+Pgo+PiA+ICAvdXNyL2luY2x1
ZGUveGZzL3hxbS5oOjE2Nzo4OiBlcnJvcjogcmVkZWZpbml0aW9uIG9mIOKAmHN0cnVjdAo+PiBm
c19xZmlsZXN0YXR24oCZCj4+Cj4+IEkgd29uZGVyIGhvdyBfR05VX1NPVVJDRSBpbmZsdWVuY2Vz
IGFueSBYRlMgaGVhZGVyPwo+PiBJIGhhdmVuJ3QgZm91bmQgYW55dGhpbmcgaW4gKDx4ZnMvKi5o
Pikgb3IgaW4gPHN5cy9xdW90YS5oPgo+Pgo+Cj4gV2l0aCBpbnN0YWxsaW5nIGEgbmV3ZXIgeGZz
cHJvZ3MtZGV2IHBhY2thZ2Ugb24gUkhFTCwgd2UgZ290IGEgcHJvYmxlbQo+IGluIGNvbmZpZ3Vy
aW5nIG91ciBMVFAgdGVzdC4KPgo+IEFjY29yZGluZyB0byB0aGUgaW5jbHVzaW9uIHJlbGF0aW9u
c2hpcDogInhmcy94cW0uaCIgLT4gInhmcy94ZnMuaCIgLT4KPiAieGZzL2xpbnV4LmgiLgo+IFRo
ZSBsaW51eC5oIGhlYWRlciBpbnRyb2R1Y2VzIGFuIGlubGluZWQgZnVuY3Rpb24gdGhhdCBuZWVk
cyAnX0dOVV9TT1VSQ0UnCj4gYW5kIDxmY25jdGwuaD4uCj4KPiAkIGdpdCBjbG9uZSBodHRwczov
L2tlcm5lbC5nb29nbGVzb3VyY2UuY29tL3B1Yi9zY20vZnMveGZzL3hmc3Byb2dzLWRldgo+ICQg
Y2QgeGZzcHJvZ3MtZGV2Lwo+ICQgZ2l0IGRlc2NyaWJlIC0tY29udGFpbnMgOWQ2MDIzYTg1NmEx
YzRmODQ0MTVkZmY1OWIwZDU0NTljYzg3NjhkYgo+IHY1LjUuMC1yYzF+MzkKPgo+ICNpZiBkZWZp
bmVkKEZBTExPQ19GTF9aRVJPX1JBTkdFKQo+IHN0YXRpYyBpbmxpbmUgaW50Cj4gcGxhdGZvcm1f
emVyb19yYW5nZSgKPiAgICAgICAgIGludCAgICAgICAgZmQsCj4gICAgICAgICB4ZnNfb2ZmX3Qg
ICAgICAgIHN0YXJ0LAo+ICAgICAgICAgc2l6ZV90ICAgICAgICBsZW4pCj4gewo+ICAgICAgICAg
aW50IHJldDsKPgo+ICAgICAgICAgcmV0ID0gZmFsbG9jYXRlKGZkLCBGQUxMT0NfRkxfWkVST19S
QU5HRSwgc3RhcnQsIGxlbik7Cj4gICAgICAgICBpZiAoIXJldCkKPiAgICAgICAgIHJldHVybiAw
Owo+ICAgICAgICAgcmV0dXJuIC1lcnJubzsKPiB9Cj4gI2Vsc2UKPiAjZGVmaW5lIHBsYXRmb3Jt
X3plcm9fcmFuZ2UoZmQsIHMsIGwpICgtRU9QTk9UU1VQUCkKPiAjZW5kaWYKPgo+Cj4gTXkgdGVz
dCB2ZXJzaW9uIGlzIGJhc2VkIG9uIDYuNSBzbyBjb250YWlucyB0aGUgaW5saW5lZCBmdW5jdGlv
biB0byBidWlsZC4KPgo+ICMgcnBtIC1xZiAvdXNyL2luY2x1ZGUveGZzL3hxbS5oCj4geGZzcHJv
Z3MtZGV2ZWwtNi41LjAtMy5lbDEwLng4Nl82NAo+Cj4KPgo+PiBJIGtub3cgdGhhdCBzb21lIHF1
b3RhY3RsMFsyM10uYyBkZWZpbmUgX0dOVV9TT1VSQ0UsIGJ1dCBpdCdzIGludGVyZXN0aW5nCj4+
IHRoYXQKPj4gdGhpcyBpbmZsdWVuY2UgdGhlIGhlYWRlci4gQWxzbywgd2hpY2ggUkhFTCAob3Ig
d2hhdGV2ZXIgZGlzdHJvKSB2ZXJzaW9uCj4+IGhhcwo+PiB0aGlzIHByb2JsZW0/Cj4KPgo+IFRo
ZSBlcnJvciBvY2N1cnJlZCAod2l0aCBpbnN0YWxsIHhmc3Byb2dzLWRldmVsKSBkdXJpbmcgdGhl
IGNvbmZpZ3VyZQo+IHNjcmlwdAo+IGNoZWNraW5nIHN0cnVjdCBmc19xdW90YV9zdGF0di4gSXQg
ZmFpbGVkIHRvIGNvbXBpbGUgY29uZnRlc3QuYyBhbmQgcmVwb3J0Cj4gc3VjaCBlcnJvcnM6Cj4K
PiBjb25maWd1cmU6NTY5NzogY2hlY2tpbmcgZm9yIHN0cnVjdCBmc19xdW90YV9zdGF0dgo+IGNv
bmZpZ3VyZTo1Njk3OiBnY2MgLWMgLWcgLU8yICBjb25mdGVzdC5jID4mNQo+IEluIGZpbGUgaW5j
bHVkZWQgZnJvbSAvdXNyL2luY2x1ZGUveGZzL3hmcy5oOjksCj4gICAgICAgICAgICAgICAgICBm
cm9tIC91c3IvaW5jbHVkZS94ZnMveHFtLmg6OSwKPiAgICAgICAgICAgICAgICAgIGZyb20gY29u
ZnRlc3QuYzoxMzg6Cj4gL3Vzci9pbmNsdWRlL3hmcy9saW51eC5oOiBJbiBmdW5jdGlvbiAncGxh
dGZvcm1femVyb19yYW5nZSc6Cj4gL3Vzci9pbmNsdWRlL3hmcy9saW51eC5oOjE4ODoxNTogZXJy
b3I6IGltcGxpY2l0IGRlY2xhcmF0aW9uIG9mIGZ1bmN0aW9uCj4gJ2ZhbGxvY2F0ZScgWy1XaW1w
bGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICAxODggfCAgICAgICAgIHJldCA9IGZhbGxv
Y2F0ZShmZCwgRkFMTE9DX0ZMX1pFUk9fUkFOR0UsIHN0YXJ0LCBsZW4pOwo+ICAgICAgIHwgICAg
ICAgICAgICAgICBefn5+fn5+fn4KPiBjb25maWd1cmU6NTY5NzogJD8gPSAxCj4KPiBJdCBzaW1p
bGFybHkgdG8gdGhlIGFib3ZlIHF1b3RhY3RsMDcgcGF0Y2ggZml4LCBzbyBhZGRpbmcgJyNkZWZp
bmUKPiBfR05VX1NPVVJDRScKPiBpcyBhY3R1YWxseSBmb3IgbWFraW5nIHRoZSBmYWxsb2NhdGUo
KSBoYXBweS4KPgo+IE9yLCBhbm90aGVyIHdheSBpcyB0aGUgY2hhbmdlIG1hZGUgaW4gInhmc3By
b2dzLWRldi9pbmNsdWRlL2xpbnV4LmgiCj4gb3RoZXJ3aXNlIHdlIGNhbid0Cj4gY29uZmlndXJl
IG91ciBMVFAgY29ycmVjdGx5Lgo+Cj4KPiAtLQo+IFJlZ2FyZHMsCj4gTGkgV2FuZwo+CgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
