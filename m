Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A305CA0EFA
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755821193; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=n8DskHK01RQJXMM9uzx0mrvA8j0i9ZWX2Qkq6DF57lc=;
 b=qhrxLoVppbz6bLpj1nBFNOK0t8npmT/xUVo5XLHSbB6kgFcbgsPKVYo0qkH8DQM5xO6yj
 Yn3OCKGGUQC5XuL1QwwPSpJxIq8oQItV90bYVljAd7DLV2v0PHA7pBBvl0StH1r/9rmIJoJ
 BljsGkHetBLbkNW7N98ngcgXsINwFLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DEA43CCBCC
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 02:06:33 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02B443C2CBE
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 02:06:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84C64200239
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 02:06:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755821159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NGGHQbGMq04MUGI+/vwPNq2Rw2NUVHC8VPuTf5wxGho=;
 b=P/JZSLCmlopfhnsBENUx6BrlMirGlJONGpYHu9Tx2jFBM2v2ZIHtyw/mS8QQovQG1HUF+r
 2eFGbh+FtBAzwY2GSVq/8cRqNAkBVLvW3D/J+N6RfWPZ8h1psF+ZezVBZJwJVJGv5eg8ym
 ufRBZm+gx3f2MbPRZhqIPsKsgQvaI9I=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-442-YVs4Qt8HMYGh96SLYhm9Ug-1; Thu, 21 Aug 2025 20:05:52 -0400
X-MC-Unique: YVs4Qt8HMYGh96SLYhm9Ug-1
X-Mimecast-MFC-AGG-ID: YVs4Qt8HMYGh96SLYhm9Ug_1755821151
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-32505dbe23fso642406a91.1
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 17:05:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755821151; x=1756425951;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NGGHQbGMq04MUGI+/vwPNq2Rw2NUVHC8VPuTf5wxGho=;
 b=b9Rvb9zht+li5fmaFjgtelBqDLejPeJftdxkoUV9n7mqd5UKK/iiGUJg+1vShgKkXa
 gj0X/DfiijMkextsET4NE2LqZF/Ru9JVPOuCF8G9L8EOvoBm9nuQHIXqt01kZgTtD+9X
 z1ZfEc0/FlZ8S9ZSD/zZqDBgAc+xl5y0elH8vquqK07yvyBN+oG1ilu1B2uE0EbdxxcV
 YlwyrKMp4gmO616jxFryJIkywsddpuBKlvCHpZvs6rTxGqGN3Qv42TprbCmhqRXQjYN3
 RYGg7GUzEafg61NdpCvf56YWwBmznLuW9wTg0P/HFs9Gz854hqWs7twTrxdf2TvQTArz
 pODw==
X-Gm-Message-State: AOJu0YzZLDBB8TPwezXqQqRCy9H9HeZvvOhfqNspZisN4hBQ6WgFTffA
 TdKcM4ZeU99B6jU6Zr2S2hZm14tdDumNO+vfqlQ6GXfBUPOarF8pCGDx7HWY82duNpAYGEFY931
 CpmGrkQ7fQRS7Xs+YMl5YKafAUInLfDRsKdl4wppaOhDkV8Ld2zmEvq2B1vSExM1kC8caBTFc6o
 xrLFgNl4H6DlVhiMxJuS9rSlK9hyA=
X-Gm-Gg: ASbGncu2FpejUly/rw73YsWin709NKqEw/YrrF4R4CRgmIkLUpLakXV3U+6wvUS3WEj
 hLpas0Qs82vZef3DtN1Ny7nHOI+MSO19a50xGdqWxVYJNrjzeN+yN9d7HUA4yvlNbvdVqis8DTX
 d21wLhqQhDzqCMarfMuXpATQ==
X-Received: by 2002:a17:902:cf04:b0:243:80d:c513 with SMTP id
 d9443c01a7336-2462edd79c9mr15369825ad.4.1755821150957; 
 Thu, 21 Aug 2025 17:05:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZNhhwIxRm8MALDuP3lut3iauD3yAD49Dj1ksCmdM0uLc4ey+reV3HatpNcvaNOkYcCiPXkkYAUu67904v77M=
X-Received: by 2002:a17:902:cf04:b0:243:80d:c513 with SMTP id
 d9443c01a7336-2462edd79c9mr15369325ad.4.1755821150377; Thu, 21 Aug 2025
 17:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250820002556.26865-1-wegao@suse.com>
In-Reply-To: <20250820002556.26865-1-wegao@suse.com>
Date: Fri, 22 Aug 2025 08:05:38 +0800
X-Gm-Features: Ac12FXz863pDNXdlOZWeuQGAY6bsXnltJ_K6YMShQnaTz5kLPZqcnaN0cXLlfKg
Message-ID: <CAEemH2eApy1bANtFp1Z3qFQMJannqe9Q-dWAGiL_wXv2hbE3+A@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NkSoFqsd_k0NHwOdTOhyettCjCzItC-klYEnzFNhUTw_1755821151
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] fspick01.c: Check mount point was really
 remounted read only
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

SGkgV2VpLAoKT24gV2VkLCBBdWcgMjAsIDIwMjUgYXQgODoyNuKAr0FNIFdlaSBHYW8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gRml4ZXM6ICMxMTcxCj4gVGhlIGZzcGlj
azAxIHRlc3QgZG9lcyBub3QgdGVzdCBpZiBGU0NPTkZJR19DTURfUkVDT05GSUdVUkUgcmVhbGx5
Cj4gcmVjb25maWd1cmVzIHRoZSBtb3VudCBwb2ludCwgZS5nLiBpZiB0aGUgbW91bnQgcG9pbnQg
d2FzIHJlYWxseQo+IHJlbW91bnRlZCByZWFkIG9ubHkuCj4KPiBTaWduZWQtb2ZmLWJ5OiBXZWkg
R2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiAtLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
c3BpY2svZnNwaWNrMDEuYyB8IDQzICsrKysrKysrKysrKysrKysrKysrLQo+ICAxIGZpbGUgY2hh
bmdlZCwgNDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZnNwaWNrL2ZzcGljazAxLmMKPiBiL3Rlc3RjYXNlcy9r
ZXJuZWwvc3lzY2FsbHMvZnNwaWNrL2ZzcGljazAxLmMKPiBpbmRleCBkMDNjYWNkM2QuLmMyYWQz
NjlkNCAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2ZzcGljay9mc3Bp
Y2swMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mc3BpY2svZnNwaWNrMDEu
Ywo+IEBAIC02LDYgKzYsNyBAQAo+ICAgKi8KPiAgI2luY2x1ZGUgInRzdF90ZXN0LmgiCj4gICNp
bmNsdWRlICJsYXBpL2ZzbW91bnQuaCIKPiArI2luY2x1ZGUgInRzdF9zYWZlX3N0ZGlvLmgiCj4K
PiAgI2RlZmluZSBNTlRQT0lOVCAgICAgICAgICAgICAgICJtbnRwb2ludCIKPiAgI2RlZmluZSBU
Q0FTRV9FTlRSWShfZmxhZ3MpICAgIHsubmFtZSA9ICJGbGFnICIgI19mbGFncywgLmZsYWdzID0g
X2ZsYWdzfQo+IEBAIC0yMCwxMSArMjEsMzggQEAgc3RhdGljIHN0cnVjdCB0Y2FzZSB7Cj4gICAg
ICAgICBUQ0FTRV9FTlRSWShGU1BJQ0tfRU1QVFlfUEFUSCksCj4gIH07Cj4KPiArc3RhdGljIGlu
dCBpc19tb3VudGVkX3JvKGNvbnN0IGNoYXIgKnBhdGgpCj4KCk1heWJlIHdlIGNhbiBjb25zaWRl
ciByZWZhY3RvcmluZyB0aGlzIGZ1bmN0aW9uIGFzIGEgbW9yZSBnZW5lcmljLAplLmcuIHRzdF9t
b3VudF9oYXNfb3B0KGNvbnN0IGNoYXIgKnBhdGgsIGNvbnN0IGNoYXIgKm9wdCkgYW5kIG1vdmUK
aXQgaW50byB0c3RfZGV2aWNlLmMgZmlsZT8KCnN0YXRpYyBpbnQgdHN0X21vdW50X2hhc19vcHQo
Y29uc3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqb3B0KQp7CiAgICAuLi4KfQoKaW50IHRzdF9p
c19tb3VudGVkX3JvKGNvbnN0IGNoYXIgKnBhdGgpCnsKICAgIHJldHVybiB0c3RfbW91bnRfaGFz
X29wdChwYXRoLCAicm8iKTsKfQoKaW50IHRzdF9pc19tb3VudGVkX3J3KGNvbnN0IGNoYXIgKnBh
dGgpCnsKICAgIHJldHVybiB0c3RfbW91bnRfaGFzX29wdChwYXRoLCAicnciKTsKfQoKUGVvcGxl
IGNhbiBjYWxsIHRzdF9pc19tb3VudGVkX3JvKHBhdGgpIG9yIHRzdF9pc19tb3VudGVkX3J3KHBh
dGgpIGRpcmVjdGx5LgoKCj4gK3sKPiArICAgICAgIGNoYXIgbGluZVtQQVRIX01BWF07Cj4gKyAg
ICAgICBGSUxFICpmaWxlOwo+ICsgICAgICAgaW50IHJldCA9IDA7Cj4gKwo+ICsgICAgICAgZmls
ZSA9IFNBRkVfRk9QRU4oIi9wcm9jL21vdW50cyIsICJyIik7Cj4gKwo+CgoKCj4gKyAgICAgICB3
aGlsZSAoZmdldHMobGluZSwgc2l6ZW9mKGxpbmUpLCBmaWxlKSkgewo+ICsgICAgICAgICAgICAg
ICBjaGFyIGRldltQQVRIX01BWF0sIG1vdW50X3BvaW50W1BBVEhfTUFYXSwKPiBmc3R5cGVbUEFU
SF9NQVhdLCBvcHRpb25zW1BBVEhfTUFYXTsKPiArCj4gKyAgICAgICAgICAgICAgIGlmIChzc2Nh
bmYobGluZSwgIiVzICVzICVzICVzIiwgZGV2LCBtb3VudF9wb2ludCwgZnN0eXBlLAo+IG9wdGlv
bnMpIDwgNCkKPiArICAgICAgICAgICAgICAgICAgICAgICBjb250aW51ZTsKPiArCj4gKyAgICAg
ICAgICAgICAgIGlmIChzdHJzdHIobW91bnRfcG9pbnQsIHBhdGgpICYmIChzdHJzdHIob3B0aW9u
cywgInJvLCIpKSkKPiB7Cj4KCnN0cnN0cihtb3VudF9wb2ludCwgcGF0aCkgbWF5IGdpdmUgZmFs
c2UgcG9zaXRpdmVzIChlLmcuIC9tbnQgd2lsbCBtYXRjaAovbW50MikuCkJldHRlciB0byB1c2Ug
c3RyY21wKCkgb3IgcHJlZml4IG1hdGNoaW5nIHdpdGggLyBib3VuZGFyaWVzLgoKSG93IGFib3V0
IHRoaXM6Cgp3aGlsZSAoZmdldHMobGluZSwgc2l6ZW9mKGxpbmUpLCBmaWxlKSkgewogICAgICAg
IGNoYXIgbW91bnRfcG9pbnRbUEFUSF9NQVhdLCBvcHRpb25zW1BBVEhfTUFYXTsKCiAgICAgICAg
aWYgKHNzY2FuZihsaW5lLCAiJSpzICVzICUqcyAlcyIsIG1vdW50X3BvaW50LCBvcHRpb25zKSA8
IDIpCiAgICAgICAgICAgICAgICBjb250aW51ZTsKCiAgICAgICAgaWYgKHN0cmNtcChtb3VudF9w
b2ludCwgcGF0aCkgIT0gMCkKICAgICAgICAgICAgICAgIGNvbnRpbnVlOwoKICAgICAgICBjaGFy
ICp0b2sgPSBzdHJ0b2sob3B0aW9ucywgIiwiKTsKICAgICAgICB3aGlsZSAodG9rKSB7CiAgICAg
ICAgICAgICAgICBpZiAoc3RyY21wKHRvaywgb3B0KSA9PSAwKSB7CiAgICAgICAgICAgICAgICAg
ICAgICAgIHJldCA9IDE7CiAgICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAg
ICAgICAgfQogICAgICAgICAgICAgICAgdG9rID0gc3RydG9rKE5VTEwsICIsIik7CiAgICAgICAg
ICAgIH0KICAgICAgICBpZiAocmV0KQogICAgICAgICAgICAgICAgYnJlYWs7Cn0KCgorICAgICAg
ICAgICAgICAgICAgICAgICByZXQgPSAxOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIGJyZWFr
Owo+ICsgICAgICAgICAgICAgICB9Cj4gKyAgICAgICB9Cj4gKwo+CgoKCj4gKyAgICAgICBTQUZF
X0ZDTE9TRShmaWxlKTsKPiArCj4gKyAgICAgICByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICBzdGF0
aWMgdm9pZCBydW4odW5zaWduZWQgaW50IG4pCj4gIHsKPiAgICAgICAgIHN0cnVjdCB0Y2FzZSAq
dGMgPSAmdGNhc2VzW25dOwo+ICAgICAgICAgaW50IGZzcGlja19mZDsKPgo+ICsgICAgICAgVFNU
X0VYUF9WQUwoaXNfbW91bnRlZF9ybyhNTlRQT0lOVCksIDApOwo+ICsKPiAgICAgICAgIFRFU1Qo
ZnNwaWNrX2ZkID0gZnNwaWNrKEFUX0ZEQ1dELCBNTlRQT0lOVCwgdGMtPmZsYWdzKSk7Cj4gICAg
ICAgICBpZiAoZnNwaWNrX2ZkID09IC0xKSB7Cj4gICAgICAgICAgICAgICAgIHRzdF9yZXMoVEZB
SUwgfCBUVEVSUk5PLCAiZnNwaWNrKCkgZmFpbGVkIik7Cj4gQEAgLTQ5LDggKzc3LDIxIEBAIHN0
YXRpYyB2b2lkIHJ1bih1bnNpZ25lZCBpbnQgbikKPiAgICAgICAgICAgICAgICAgZ290byBvdXQ7
Cj4gICAgICAgICB9Cj4KPiAtICAgICAgIHRzdF9yZXMoVFBBU1MsICIlczogZnNwaWNrKCkgcGFz
c2VkIiwgdGMtPm5hbWUpOwo+ICsgICAgICAgVFNUX0VYUF9WQUwoaXNfbW91bnRlZF9ybyhNTlRQ
T0lOVCksIDEpOwo+Cj4gKyAgICAgICBURVNUKGZzY29uZmlnKGZzcGlja19mZCwgRlNDT05GSUdf
U0VUX0ZMQUcsICJydyIsIE5VTEwsIDApKTsKPiArICAgICAgIGlmIChUU1RfUkVUID09IC0xKSB7
Cj4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLCAiZnNjb25maWcoRlND
T05GSUdfU0VUX0ZMQUcpCj4gZmFpbGVkIik7Cj4gKyAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+
ICsgICAgICAgfQo+ICsKPiArICAgICAgIFRFU1QoZnNjb25maWcoZnNwaWNrX2ZkLCBGU0NPTkZJ
R19DTURfUkVDT05GSUdVUkUsIE5VTEwsIE5VTEwsIDApKTsKPiArICAgICAgIGlmIChUU1RfUkVU
ID09IC0xKSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLAo+ICJm
c2NvbmZpZyhGU0NPTkZJR19DTURfUkVDT05GSUdVUkUpIGZhaWxlZCIpOwo+ICsgICAgICAgICAg
ICAgICBnb3RvIG91dDsKPiArICAgICAgIH0KPiArCj4gKyAgICAgICB0c3RfcmVzKFRQQVNTLCAi
JXM6IGZzcGljaygpIHBhc3NlZCIsIHRjLT5uYW1lKTsKPiAgb3V0Ogo+ICAgICAgICAgU0FGRV9D
TE9TRShmc3BpY2tfZmQpOwo+ICB9Cj4gLS0KPiAyLjQzLjAKPgo+Cj4gLS0KPiBNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVn
YXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
