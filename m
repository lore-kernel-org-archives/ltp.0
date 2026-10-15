Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45296CC6B34
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792054930; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=jxF9xaowNb4ZNMZMrMD5ZDhDaPHXGg/Lg93Xu9moguA=;
 b=LclWldJQsRIoMSn7KICvJH2Ai9LAjfBDuQRV3ujQnt0Lle4EApJB3qqOfUDgHg2pjthkz
 3bUu+6d6HNS8GTtc7KB69NlOXN4weggjIbM6M/J5uVXx1Mou+G1N7exU7DYWSUFPUMIJe4i
 AaKMLIq8orsXpfjshVhO6bwrUPHBe6k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 793BB3E9AF2
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 11:02:10 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06BF03E1D5D
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 11:01:50 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 39AD314002D3
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 11:01:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792054907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNYfj6Hb9SdxTaOKOd79yIocfOp3uXkvMPrrfn59pGI=;
 b=MUcARHEaQuLeT+1HMv1LCdmb5rBjo5KG33YtBfrNoyWiMbd83xKptb/eVuqmVSHU6piptC
 owgedCFZug9HZqVOeOHPbWfhCw465/g7Nx2c3yULaOdtXpjgM82TrtiJeI50ftKqVDsImQ
 XAOEg+AoUqVPOq5ZsdjctrOO1a/8v9E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-6d_wdIgTPWSYMBQuyKCsbA-1; Thu, 15 Oct 2026 09:01:46 +0000
X-MC-Unique: 6d_wdIgTPWSYMBQuyKCsbA-1
X-Mimecast-MFC-AGG-ID: 6d_wdIgTPWSYMBQuyKCsbA_1792054905
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4a166a9ea21so42405035e9.2
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 02:01:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792054905; x=1792659705;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=VNYfj6Hb9SdxTaOKOd79yIocfOp3uXkvMPrrfn59pGI=;
 b=WGQg7GsiE/KToZ9FK0BKIUP1FHEQITgn0qdF6F7NuQ5ogOji2SEGAvc9pAxiiiUS7V
 beNAv4xN2/RsG8WBbXu2t8UPiZ5aAXOzPY/c7Xqv/q6VNuqL+TMNEkoeT8uYKR33AqC0
 0plgoQSHz/F7RPFtgGhCkj2WGdf7Tmz1x+cVPHGWnHFMowKAMRgLR7CRT5fLrhr0ENfn
 vxn/w1BMdfrsP4uoaxL8PpKsWfjbddiC0VzMb4fMpR41BbRMXw+53bcu7NIT/OfoBIe/
 ioPqnMT74MeKN4aeoSkPzXKy0wIQjAa0SSdQ8bXWD6mzzxxNQ8AJh80rupHYGpR521Aj
 Vfnw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxJa3oJX3wTZsVgegWGKC/2cLdGbCHruiDPF8TjM/b7kP0/ffSoWVVUt8NAibwuGHBdSoc=@lists.linux.it
X-Gm-Message-State: AFq9FYL4NJqYNZ5GpVgeSutLkIBnceOX8tNWS7zYQaiIyhBlDb7ocv6Z
 VIg30QT8PKMK/9/6DeSYDBUuxXHUZjLLjREU8CNDotin6maNi3XVVWMopehB+gyWwVJSpq4qV5a
 L3NPEMQ0awzZinstnIEsqPQeL++VHQiQh40lE5i57dWado/ZTz33h9gKOdOT1
X-Gm-Gg: AYBFou03rOUrknk0jRNa10HITrFWF1tHvAuI7s5MvAcakmtl5qNWTGmM6cKAC/4yINh
 z/o7vmI5TkMRlUgbU3BBgJ/wxCJ2DzVYRfR06tS3hXMTFnCaZZhlAEdDC6hCafUMgcUa/OvoH7D
 x1vXaEXG65A3GLeMaRkaCIYV6oyA93f0L3Szuk1D71BV7qT3mkjRsHEW9tIZgCwOWUZaej6qshU
 Yi7+ywl8bVmlqhIX4oXhJG/AnZcuy55nc49Fae8SuaAMZJmKXPr0wGyhaOpQ8lhhQQhHz9a+E93
 +RDah4Kx8vxkS2os1MpzRSfvNV/1nO1kh7UOjc+g1OQu/9BVj0qVh1sDci8kYCFi
X-Received: by 2002:a05:600c:524d:b0:4a1:80d8:aeb3 with SMTP id
 5b1f17b1804b1-4a18e4a95c2mr367069335e9.12.1792054904790; 
 Thu, 15 Oct 2026 02:01:44 -0700 (PDT)
X-Received: by 2002:a05:600c:524d:b0:4a1:80d8:aeb3 with SMTP id
 5b1f17b1804b1-4a18e4a95c2mr367068925e9.12.1792054904303; 
 Thu, 15 Oct 2026 02:01:44 -0700 (PDT)
Received: from toolbx ([85.93.121.125]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaa5dbsm18164939f8f.12.2026.10.15.02.01.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2026 02:01:43 -0700 (PDT)
Date: Thu, 15 Oct 2026 11:01:41 +0200
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <atCVc5kQoGx5spgk@toolbx>
References: <as9x2R-9IQb7vjn7@toolbx>
 <27AE9564-6115-491B-AE80-D9016EA7CDB5@suse.com>
 <20261015083851.GA290292@pevik>
MIME-Version: 1.0
In-Reply-To: <20261015083851.GA290292@pevik>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uBfhYgo-5kVNb30hTW0QCgAq-BM9D1L9xRe488nu01I_1792054905
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] Suggested fix for the mremap03
 syscall testcase
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
From: Martin Cermak via ltp <ltp@lists.linux.it>
Reply-To: Martin Cermak <mcermak@redhat.com>
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCndpdGggcGF0Y2hlZCB0ZXN0Y2FzZSwgdmFsZ3JpbmQgZG9lc24ndCBjcmFzaCBh
bnkgbW9yZSwgYXQgbGVhc3QKbXkgZnJlc2ggdXBzdHJlYW0gdmVyc2lvbiBvZiB2YWxncmluZCBk
b2Vzbid0OgoKJCBnaXQgbG9nIC0xIC0tb25lbGluZSB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxz
L21yZW1hcC9tcmVtYXAwMy5jCjNkZGNmYThjMyAoSEVBRCAtPiBtYXN0ZXIpIEZpeCB0aGUgbXJl
bWFwMDMgc3lzY2FsbCB0ZXN0Y2FzZQokIHZhbGdyaW5kIC0tdmVyc2lvbgp2YWxncmluZC0zLjI4
LjAuR0lUCiQgdmFsZ3JpbmQgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tcmVtYXAvbXJlbWFw
MDMKPT0xNDE5OTczPT0gTWVtY2hlY2ssIGEgbWVtb3J5IGVycm9yIGRldGVjdG9yCj09MTQxOTk3
Mz09IENvcHlyaWdodCAoQykgMjAwMi0yMDI2LCBhbmQgR05VIEdQTCdkLCBieSBKdWxpYW4gU2V3
YXJkIGV0IGFsLgo9PTE0MTk5NzM9PSBVc2luZyBWYWxncmluZC0zLjI4LjAuR0lUIGFuZCBMaWJW
RVg7IHJlcnVuIHdpdGggLWggZm9yIGNvcHlyaWdodCBpbmZvCj09MTQxOTk3Mz09IENvbW1hbmQ6
IHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXJlbWFwL21yZW1hcDAzCj09MTQxOTk3Mz09IAp0
c3RfdGVzdC5jOjIwNjE6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNjA5MzAtMjAtZzNkZGNmYThj
Mwp0c3RfdGVzdC5jOjIwNjQ6IFRJTkZPOiBUZXN0ZWQga2VybmVsOiA3LjIuNy0yMDAuZmM0NC54
ODZfNjQgIzEgU01QIFBSRUVNUFRfRFlOQU1JQyBNb24gU2VwIDIxIDE4OjI1OjU3IFVUQyAyMDI2
IHg4Nl82NAp0c3Rfa2NvbmZpZy5jOjczOiBUSU5GTzogQ291bGRuJ3QgbG9jYXRlIGtlcm5lbCBj
b25maWchCnRzdF90ZXN0LmM6MTg5NTogVElORk86IE92ZXJhbGwgdGltZW91dCBwZXIgcnVuIGlz
IDBoIDAwbSAzMHMKbXJlbWFwMDMuYzo0MjogVEZBSUw6IG1yZW1hcChiYWRfYWRkciwgbWVtc2l6
ZSwgbmV3c2l6ZSwgTVJFTUFQX01BWU1PVkUpIGV4cGVjdGVkIEVGQVVMVDogRUlOVkFMICgyMikK
PT0xNDE5OTkyPT0gCj09MTQxOTk5Mj09IEhFQVAgU1VNTUFSWToKPT0xNDE5OTkyPT0gICAgIGlu
IHVzZSBhdCBleGl0OiAwIGJ5dGVzIGluIDAgYmxvY2tzCj09MTQxOTk5Mj09ICAgdG90YWwgaGVh
cCB1c2FnZTogMTMgYWxsb2NzLCAxMyBmcmVlcywgNyw2NDcgYnl0ZXMgYWxsb2NhdGVkCj09MTQx
OTk5Mj09IAo9PTE0MTk5OTI9PSBBbGwgaGVhcCBibG9ja3Mgd2VyZSBmcmVlZCAtLSBubyBsZWFr
cyBhcmUgcG9zc2libGUKPT0xNDE5OTkyPT0gCj09MTQxOTk5Mj09IEZvciBsaXN0cyBvZiBkZXRl
Y3RlZCBhbmQgc3VwcHJlc3NlZCBlcnJvcnMsIHJlcnVuIHdpdGg6IC1zCj09MTQxOTk5Mj09IEVS
Uk9SIFNVTU1BUlk6IDAgZXJyb3JzIGZyb20gMCBjb250ZXh0cyAoc3VwcHJlc3NlZDogMCBmcm9t
IDApCgpTdW1tYXJ5OgpwYXNzZWQgICAwCmZhaWxlZCAgIDEKYnJva2VuICAgMApza2lwcGVkICAw
Cndhcm5pbmdzIDAKPT0xNDE5OTczPT0gCj09MTQxOTk3Mz09IEhFQVAgU1VNTUFSWToKPT0xNDE5
OTczPT0gICAgIGluIHVzZSBhdCBleGl0OiAwIGJ5dGVzIGluIDAgYmxvY2tzCj09MTQxOTk3Mz09
ICAgdG90YWwgaGVhcCB1c2FnZTogNiBhbGxvY3MsIDYgZnJlZXMsIDQsNDg4IGJ5dGVzIGFsbG9j
YXRlZAo9PTE0MTk5NzM9PSAKPT0xNDE5OTczPT0gQWxsIGhlYXAgYmxvY2tzIHdlcmUgZnJlZWQg
LS0gbm8gbGVha3MgYXJlIHBvc3NpYmxlCj09MTQxOTk3Mz09IAo9PTE0MTk5NzM9PSBGb3IgbGlz
dHMgb2YgZGV0ZWN0ZWQgYW5kIHN1cHByZXNzZWQgZXJyb3JzLCByZXJ1biB3aXRoOiAtcwo9PTE0
MTk5NzM9PSBFUlJPUiBTVU1NQVJZOiAwIGVycm9ycyBmcm9tIDAgY29udGV4dHMgKHN1cHByZXNz
ZWQ6IDAgZnJvbSAwKQokCgpCdXQgdGhhdCBkb2Vzbid0IG1lYW4gdGhpbmdzIGFyZSBwZXJmZWN0
LiAgVGhlIG1haW4gcHJvYmxlbSBpcwp0aGF0IHVuZGVyIHZhbGdyaW5kIHRoZSB0ZXN0Y2FzZSBi
ZWhhdmVzIGRpZmZlcmVudGx5IGNvbXBhcmVkIHRvCmEgcnVuIHdpdGhvdXQgdmFsZ3JpbmQuIExv
b2tpbmcgaW50byBpdC4gIFRoYW5rcyBmb3IgdGhlIG1lcmdlLgoKTWFydGluCgpPbiAgVGh1ICAy
MDI2LTEwLTE1ICAxMDozOCAsIFBldHIgVm9yZWwgd3JvdGU6Cj4gSGkgTWFydGluLCBBbmRyZWEs
IAo+IAo+ID4gSGkgTWFydGluLAo+IAo+ID4geW91IGFyZSByaWdodC4gVGhhdOKAmXMgYSBidWcg
d2UgZGlkbuKAmXQgc3BvdCBkdXJpbmcgdGhlIHRlc3QgcmV3cml0ZS4gVGhhbmtzLgo+IAo+IEdv
b2QgY2F0Y2gsIE1hcnRpbiwgeW91J3JlIG9mIGNvdXJzZSByaWdodCA9PiB0dXJuZWQgaW50byBw
cm9wZXIgcGF0Y2ggYW5kCj4gbWVyZ2VkLgo+IAo+IHZhbGdyaW5kIC4vbXJlbWFwMDMKPiB0c3Rf
dGVzdC5jOjE4OTU6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBz
Cj4gLS0yOTI3OTktLSBWQUxHUklORCBJTlRFUk5BTCBFUlJPUjogVmFsZ3JpbmQgcmVjZWl2ZWQg
YSBzaWduYWwgMTEgKFNJR1NFR1YpIC0gZXhpdGluZwo+IC0tMjkyNzk5LS0gc2lfY29kZT0xOyAg
RmF1bHRpbmcgYWRkcmVzczogMHg4OyAgc3A6IDB4MTAwMmVmMmNjMAo+IAo+IHZhbGdyaW5kOiB0
aGUgJ2ltcG9zc2libGUnIGhhcHBlbmVkOgo+ICAgIEtpbGxlZCBieSBmYXRhbCBzaWduYWwKPiAK
PiBob3N0IHN0YWNrdHJhY2U6Cj4gPT0yOTI3OTk9PSAgICBhdCAweDU4MEFFM0QzOiA/Pz8gKGlu
IC91c3IvbGliZXhlYy92YWxncmluZC9tZW1jaGVjay1hbWQ2NC1saW51eCkKPiA9PTI5Mjc5OT09
ICAgIGJ5IDB4NTgwQTdFRDk6ID8/PyAoaW4gL3Vzci9saWJleGVjL3ZhbGdyaW5kL21lbWNoZWNr
LWFtZDY0LWxpbnV4KQo+ID09MjkyNzk5PT0gICAgYnkgMHg1ODBBMzg3QTogPz8/IChpbiAvdXNy
L2xpYmV4ZWMvdmFsZ3JpbmQvbWVtY2hlY2stYW1kNjQtbGludXgpCj4gPT0yOTI3OTk9PSAgICBi
eSAweDU4MEE1OEE2OiA/Pz8gKGluIC91c3IvbGliZXhlYy92YWxncmluZC9tZW1jaGVjay1hbWQ2
NC1saW51eCkKPiA9PTI5Mjc5OT09ICAgIGJ5IDB4NTgxMTUwODg6ID8/PyAoaW4gL3Vzci9saWJl
eGVjL3ZhbGdyaW5kL21lbWNoZWNrLWFtZDY0LWxpbnV4KQo+IAo+IEJUVyB0ZXN0Y2FzZSBhZnRl
ciBmaXggc3RpbGwgZmFpbHMsIGJ1dCB0aGF0J3MgSSBzdXBwb3NlIGp1c3QgZXhwZWN0ZWQgdmFs
Z3JpbmQKPiBiZWhhdmlvciBvbiBtbWFwKFBST1RfTk9ORSksIHJpZ2h0Pwo+IAo+IHZhbGdyaW5k
IC4vbXJlbWFwMDMKPiA9PTI5Mjk0MT09IE1lbWNoZWNrLCBhIG1lbW9yeSBlcnJvciBkZXRlY3Rv
cgo+ID09MjkyOTQxPT0gQ29weXJpZ2h0IChDKSAyMDAyLTIwMjYsIGFuZCBHTlUgR1BMJ2QsIGJ5
IEp1bGlhbiBTZXdhcmQgZXQgYWwuCj4gPT0yOTI5NDE9PSBVc2luZyBWYWxncmluZC0zLjI3LjEg
YW5kIExpYlZFWDsgcmVydW4gd2l0aCAtaCBmb3IgY29weXJpZ2h0IGluZm8KPiA9PTI5Mjk0MT09
IENvbW1hbmQ6IC4vbXJlbWFwMDMKPiA9PTI5Mjk0MT09Cj4gdHN0X3Rlc3QuYzoyMDYxOiBUSU5G
TzogTFRQIHZlcnNpb246IDIwMjYwOTMwLTIwLWdkNDk0YThlMWM5Cj4gLi4uCj4gdHN0X3Rlc3Qu
YzoxODk1OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcwo+IG1y
ZW1hcDAzLmM6NDI6IFRGQUlMOiBtcmVtYXAoYmFkX2FkZHIsIG1lbXNpemUsIG5ld3NpemUsIE1S
RU1BUF9NQVlNT1ZFKSBleHBlY3RlZCBFRkFVTFQ6IEVJTlZBTCAoMjIpCj4gCj4gS2luZCByZWdh
cmRzLAo+IFBldHIKPiAKPiAKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
