Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C645CD1038B
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764145909; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6vrsgu/yZzj/BKzfR3Jtp2GwT/cqtcs0WcRuUTboJwU=;
 b=aaKP7Sd7yXJiCebIshhafTbX1Ra43kstCLJfbGyZDZmo6gqsjvmKan5Du8pV7bULJ3q0s
 4r7E5XKFYip7IV8C1D/bwefMRD7Y2eYoGzJ3UU1O2+YYdhuYRsXxvchcHMmgJyitlt16+Bp
 rpMzPsZVcUnwjYaBL+whVZk3FWo1lbE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0541B3CF211
	for <ltp@archiver.kernel.org>; Wed, 26 Nov 2025 09:31:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A5063C79B9
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 09:31:27 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1A03B6002DD
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 09:31:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764145885;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qsww5rhUrSWPAWik7BYVPBQd9o9hs/3WRqKyDHaj+wI=;
 b=Kc0sGHJiYrfd0DtoZrs15CqPmdeIjXw5dqffoPX9YNYJO6eSuUHYqZLhE0uDh9Q+oNX1fC
 /pRHvIF2fsveLX93rT/C4E/v+6NY/bRuJ6aFZ8f5k2KbNJC5eVzFCIY3jwVUiuWDrXL0qh
 592S1kPrPgXtRm04lBM1fBAMvUeqfa0=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-JoDrynvaM4CeWHvjPvYnsQ-1; Wed, 26 Nov 2025 03:31:20 -0500
X-MC-Unique: JoDrynvaM4CeWHvjPvYnsQ-1
X-Mimecast-MFC-AGG-ID: JoDrynvaM4CeWHvjPvYnsQ_1764145880
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-bc0de474d4eso16002771a12.0
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 00:31:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764145878; x=1764750678;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Qsww5rhUrSWPAWik7BYVPBQd9o9hs/3WRqKyDHaj+wI=;
 b=FbJAvl+ar51FeKsBC3ZZzfbcIzT07u/CGSJiSwO+yb4uaHOQ8/7b9j3IQUu1CSmudh
 nKmrr3Er1iZAV7Ez39RB2ZztRwRBAkWXn6n6KPxQ3iJzWU7Q22QO9r1oko5gXy6fAWJJ
 3Vkv4Kl5Cm3YHaRUzu6JdbtUpJFIxixrMUZrL2U7fjMKkQCcYDKHIJgB4ulnUPKgpGce
 JtzT4I2S1oLqHUMP53TJ97UfE/OwuNrlXs/Le0tv4Iq36hJLtW91eCkKWtg+Et2UMkKQ
 pj8zgKrcaL2gPgEHJz1udE/H+zoE4tTsDd/hyKattvd2JQUHhpuIbnaDTmbCp+vlGTJ2
 H/9g==
X-Gm-Message-State: AOJu0Yw2tFBuOuc3cAOO1KpgSgmIk74FyliCeQIwyP5bAZoXOHcglj37
 2gNFaSpDUZlniT5FQJrF5pJGZk3hnXhcNjOV/DYwChK3VSi9QZ/Q6YspLtVXrfZwWErz7XzJuHu
 S+718ddaow4zFoFNdkdpiONHWCAGzHRkfF6tsHTd6XxMdcs2hMUIaaUwtJLDGkQ4zgKIACjzN2P
 7LdhjXMV91Wbmh7+mOwFqFRReMSOChRJdOZdrCB/F7
X-Gm-Gg: ASbGncvvICeoCeDNioifl9q4s0NTunGCDzLhgPl1r2WqG2dkx4sdl3Pe+EaCAPGYyD3
 Ia8cq8NDNoYOmDIv/ZS/EVINZKIJn3PxE/SqO4CPZkyx37bbsBODfy/UeJUCBxgsWNRI0SBl0M4
 665FssqaniUEnY2rFyyilfdlw89+kF1x7hUkqKtINKQWLcMMhxTGREfC1uc1MhXykYNl4=
X-Received: by 2002:a05:7300:8a1d:b0:2a4:3592:cf5e with SMTP id
 5a478bee46e88-2a9415824d7mr3537029eec.2.1764145878441; 
 Wed, 26 Nov 2025 00:31:18 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAYeLp+Pv4u9aaLNhMG6zUDEsOW4JfH+el3dhVs9pf0lA5hvIkUzm/JZ2A9ebpdMk7xikr647N2s4hinrk9kY=
X-Received: by 2002:a05:7300:8a1d:b0:2a4:3592:cf5e with SMTP id
 5a478bee46e88-2a9415824d7mr3537015eec.2.1764145877956; Wed, 26 Nov 2025
 00:31:17 -0800 (PST)
MIME-Version: 1.0
References: <20251126073521.159834-1-liwang@redhat.com>
 <CAASaF6zB399vN6VNGy0MaAfWn77dhpC+zyoMYii2Ca-92VSFCQ@mail.gmail.com>
In-Reply-To: <CAASaF6zB399vN6VNGy0MaAfWn77dhpC+zyoMYii2Ca-92VSFCQ@mail.gmail.com>
Date: Wed, 26 Nov 2025 16:31:06 +0800
X-Gm-Features: AWmQ_bnv-UUMV4upPSZDFu5EUqva53gKkfoJIRIdcz0Nt421N_ile3Q4bUkhbms
Message-ID: <CAEemH2fBSnurM_sy9hzCn-X2699acfewcZqObWS2jVYt8SZquw@mail.gmail.com>
To: Jan Stancek <jstancek@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: rl6C1ZJkHAyZi2b1TEj060XTZn9bb_Mm5vjR5NWFQ-E_1764145880
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] readahead02: detect cache stats via mincore
 per testfile
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

T24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgNDoxNeKAr1BNIEphbiBTdGFuY2VrIDxqc3RhbmNla0By
ZWRoYXQuY29tPiB3cm90ZToKCj4gT24gV2VkLCBOb3YgMjYsIDIwMjUgYXQgODozNeKAr0FNIExp
IFdhbmcgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgo+IHdyb3RlOgo+ID4KPiA+IFN0b3Ag
c2FtcGxpbmcgZ2xvYmFsIOKAnENhY2hlZOKAnSBmcm9tIC9wcm9jL21lbWluZm8gYW5kIGluc3Rl
YWQgbWVhc3VyZSBob3cKPiA+IG1hbnkgYnl0ZXMgb2YgdGhlIGN1cnJlbnQgdGVzdCBmaWxlIGFy
ZSByZXNpZGVudCB2aWEgbWluY29yZSgpLiBUaGlzIGxldHMKPiA+IHRoZSB0ZXN0IHJlcG9ydCBw
ZXItZmlsZSBjYWNoZSB1c2FnZSwgcmVtb3ZlcyB0aGUgTUVNSU5GTyBkZXBlbmRlbmN5LCBhbmQK
PiA+IG1ha2VzIHRoZSByZWFkYWhlYWQgd2FpdCBsb29wIHdhdGNoIHRoZSBhY3R1YWwgZmlsZSBj
YWNoZSBncm93dGguCj4gPgo+ID4gQmVjYXVzZSB0aGUgbWluY29yZSB2YWx1ZXMgYXJlIGFscmVh
ZHkgaW4gYnl0ZXMgd2Ugbm8gbG9uZ2VyIGp1Z2dsZQo+ID4gY2FjaGVkX2hpZ2gvY2FjaGVkX2xv
dyBkZWx0YXMgbm9yIHNjYWxlIGJ5IDEwMjQuIFRoZSBjYWNoZS1jYXBhY2l0eSBnYXRlCj4gPiBu
b3cgY29tcGFyZXMgY2FjaGVkX21heCBkaXJlY3RseSBhZ2FpbnN0IHRlc3RmaWxlX3NpemUsIGFu
ZCB0aGUgdXNlci0KPiA+IHZpc2libGUga0IgcHJpbnRzIGFyZSBkZXJpdmVkIGZyb20gdGhlIGJ5
dGUgY291bnRlcnMuCj4gPgo+ID4gTm90ZTogdGhpcyBwYXRjaCBiZXNlZCBvbiBDeXJpbCdzIGNo
YW5nZToKPiA+ICAgICBodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFpbC9sdHAvMjAyNS1O
b3ZlbWJlci8wNDU3MTguaHRtbAo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IExpIFdhbmcgPGxpd2Fu
Z0ByZWRoYXQuY29tPgo+ID4gLS0tCj4gPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQv
cmVhZGFoZWFkMDIuYyAgIHwgODYgKysrKysrKysrKysrLS0tLS0tLQo+ID4gIDEgZmlsZSBjaGFu
Z2VkLCA1MyBpbnNlcnRpb25zKCspLCAzMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDIuYwo+IGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDIuYwo+ID4gaW5k
ZXggZTBmNTZlOTg5Li4wMGFiNDcwYzQgMTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVs
L3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMi5jCj4gPiArKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMi5jCj4gPiBAQCAtMzYsNyArMzYsNiBA
QAo+ID4KPiA+ICBzdGF0aWMgY2hhciB0ZXN0ZmlsZVtQQVRIX01BWF0gPSAidGVzdGZpbGUiOwo+
ID4gICNkZWZpbmUgRFJPUF9DQUNIRVNfRk5BTUUgIi9wcm9jL3N5cy92bS9kcm9wX2NhY2hlcyIK
PiA+IC0jZGVmaW5lIE1FTUlORk9fRk5BTUUgIi9wcm9jL21lbWluZm8iCj4gPiAgI2RlZmluZSBQ
Uk9DX0lPX0ZOQU1FICIvcHJvYy9zZWxmL2lvIgo+ID4gICNkZWZpbmUgREVGQVVMVF9GSUxFU0la
RSAoNjQgKiAxMDI0ICogMTAyNCkKPiA+ICAjZGVmaW5lIElOSVRJQUxfU0hPUlRfU0xFRVBfVVMg
MTAwMDAKPiA+IEBAIC0xMTAsMTMgKzEwOSw0NSBAQCBzdGF0aWMgdW5zaWduZWQgbG9uZyBnZXRf
Ynl0ZXNfcmVhZCh2b2lkKQo+ID4gICAgICAgICByZXR1cm4gcmV0Owo+ID4gIH0KPiA+Cj4gPiAt
c3RhdGljIHVuc2lnbmVkIGxvbmcgZ2V0X2NhY2hlZF9zaXplKHZvaWQpCj4gPiArc3RhdGljIHVu
c2lnbmVkIGxvbmcgZ2V0X2ZpbGVfY2FjaGVkX2J5dGVzKGNvbnN0IGNoYXIgKnBhdGgsIHNpemVf
dAo+IGxlbmd0aCkKPgo+IEF0bS4gSSBkb24ndCBzZWUgYW4gaXNzdWUgd2l0aCB0aGlzIGFwcHJv
YWNoLCBqdXN0IHdvbmRlcmluZyB3aGV0aGVyCj4gdGhpcyBmdW5jdGlvbiB3b3VsZCBiZSB1c2Vm
dWwKPiB0byBoYXZlIHNvbWV3aGVyZSBpbiBsaWIsIHdoYXQgZG8geW91IHRoaW5rPwo+CgoKTWF5
YmUgeWVzLCBidXQgdGhlIHByb2JsZW0gaXMgdGhhdCB3aGVuIHdlIHVzZSBtaW5jb3JlKCkgdG8K
ZGV0ZXJtaW5lIHRoZSByZXNpZGVudCBtZW1vcnkgdGhhdCB1c3VhbGx5IHJlcXVpcmVzIGEgZmV3
IG1vcmUKbG9vcHMgdG8gd2FpdCBmb3IgdGhlIEkvTyBjYWNoZSB0byBiZSBjb21wbGV0ZWQuCgpM
aWtlIGxhc3QgdGltZSwgSSB1c2VkIG1pbmNvcmUoKSB0byBkZXRlcm1pbmUgTUFQX0RST1BQQUJM
RQpwYWdlIHJlY2xhaW1lZCBpbiBjb21taXQgOTRhNjkwMWQ3ZTk4MmYzZTUyYiwgaXQgYWxzbyBu
ZWVkcwppbmNlcnQgdXNsZWVwKDEwMDAwMCkgdGhlcmUgZm9yIHdhaXRpbmcuCgpTbyB0aGUgcG9p
bnQgaXMgdG8gZmxleGlibHkgdXNlIG1pbmNvcmUoKSBmdW5jdGlvbiBhbmQgY3VzdG9taXNlCndo
YXQgd2UgbmVlZCBpbiBkaWZmZXJlbnQgc2NlbmFyaW9zLiBCeSBub3cgSSBkb24ndCBzZWUgb3Ro
ZXIgdGVzdApoYXMgdGhlIHNhbWUgcmVxdWlyZW1lbnQgZm9yIGdldF9maWxlX2NhY2hlZF9ieXRl
cyhjb25zdCBjaGFyICpwYXRoLCBzaXplX3QKbGVuZ3RoKSwKaGVuY2Ugbm93IEkgd291bGQga2Vl
cCBpdCBpbiByZWFkYWhlYWQwMi4KCk9yLCBsZXQncyBoZWFyIG90aGVyIHZvaWNlcywgbWF5YmUg
SSBtaXNzZWQgc29tZXRoaW5nLgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
