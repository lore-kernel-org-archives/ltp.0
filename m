Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A06BCA0EFA
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 00:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755823990; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Lbt2mIsy1mT8xkMV8NyrEuFLoFwnCjkJIRsDEYiGmz4=;
 b=Y8SeP5QDvFChhChLf5TzKKdrElHkPcsXWCSwYFH8GOMRQDr/eG5iLwEVDljVNuygjtxtQ
 +WjzdH9iX3gmN5+6gquJVNg9CLnW3GA+tNIrlz19WUjyT1sG8wB5gKzESq4k/MoaEEaYbeN
 5MlPEtSiqA+vymVpe1ID7GE48HO8O3k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D1163CCB06
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 02:53:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 931A13C2CBD
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 02:52:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 61413100037C
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 02:52:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755823966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YyJXRpAVGPcHp4QqOzYjoOwPiFj3GDh7sriR3nvF3b4=;
 b=UAHyX3ZaDJ4/isdEBkCWIvlffQdJivQYv2TFOBnBdUDY/gWxKtnRGIEcvnRyegMRCqcAoB
 e2Se5oLtAQ+eH80K6gJhIJ3hT3NYBGm6xpgNTQztzQXVd/4GdIbTJqD9V2Ov8bO2LWULy5
 yJ3pUiOGEby1DCq9o4VV2PGMeRbaPrM=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-ZzwrR_hXOvWrJQ_8OKHShg-1; Thu, 21 Aug 2025 20:52:44 -0400
X-MC-Unique: ZzwrR_hXOvWrJQ_8OKHShg-1
X-Mimecast-MFC-AGG-ID: ZzwrR_hXOvWrJQ_8OKHShg_1755823963
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-324e318d628so1792678a91.3
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 17:52:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755823963; x=1756428763;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YyJXRpAVGPcHp4QqOzYjoOwPiFj3GDh7sriR3nvF3b4=;
 b=eSuhsR+UHN/KPYqcWjOlD3bbP7iM1lmulpAOVd2pPJ76siqfX+1T0pHPbq/N/Lycvo
 rWz1jE5BziM/WJavsULE08l5xUiZjZfvG2oxFiAweVTo1VirSrQq+1/Shhl+7nzSlJ4V
 xdUOxcrCbCNpCPonbwMR77fZmcjTy9Ufv2kzfeYzDK0lUb1iBOFtK2dd819JhWwaN6tv
 Vvf6Bye7CFSQ1gFk6j+C33wyhmEgvoDYID8nQQzFzpaIQFMdOiuHIgX7l9dWy476Q7EX
 ziTPBlJb6hZzb98euk8Tns3wQk7ljgkY+tN84sDoO/LhgU3hDKxXX0CQGv8YhbSmarx7
 oDGg==
X-Gm-Message-State: AOJu0YxhHwHOg4ULK/TGEEhEz8FHXZu5MbbgWlMGn/8UzkQbM1JmRTUM
 wfDrGYB8/0VOaWzNAsSxOr9/z/YWODwTGMXBM/2Dt26xPLrJIHTf9zRoE+fROjsIJAtLT22UyaE
 wJEkp0xo7Vba8Wv6pk66byddqkGwEn+G6v0/+G8VFK4YHkZBxUbg0CEhizS7WuHLLnpc2dDfacq
 ReBFEjZyQCRlMhNO/QK6v2U79S2NM=
X-Gm-Gg: ASbGncsS7jCUDHJCxY96XMRUaY+KoHyr3vJpjyUyVTF7KXAJMBeHVwyqzOJL/w5GHMm
 BOp3p/dPVHih3ofeBP5QCnE39wGnLIsVyGsgZx8BW9Lh8xt1+Dtvzr2JOtRX3E/36LCOzIVuZdy
 jQmyX469Qq2HCAUO2yzoKu8A==
X-Received: by 2002:a17:90b:3d0d:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-32515ec3216mr1716336a91.7.1755823963040; 
 Thu, 21 Aug 2025 17:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgBrg0tgMzFzohNgF97fzKKw1vT7gEme4cC3LpyHNYIY3ZOEJm1RKNDgNAT6cVMglQJge0+oktzzsWYoulp1Q=
X-Received: by 2002:a17:90b:3d0d:b0:311:df4b:4b93 with SMTP id
 98e67ed59e1d1-32515ec3216mr1716303a91.7.1755823962511; Thu, 21 Aug 2025
 17:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250818075438.151407-1-pvorel@suse.cz>
In-Reply-To: <20250818075438.151407-1-pvorel@suse.cz>
Date: Fri, 22 Aug 2025 08:52:30 +0800
X-Gm-Features: Ac12FXw_EA5qyQB1YScxEJE7NxemwOzbh8kG295k_sSRW8iyeFTl60P05n2Y3Is
Message-ID: <CAEemH2dyRPkY4-AGSdDXYiX_zL_zL_Xg04OxL6Yng5_yDZ6ZGQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BCI6o5hrhBaDgIRxKj4A0iJbX8pLKhylU2CXQEYk9sM_1755823963
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v5 1/1] tst_res_: Print error to stderr,
 with filename and lineno
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

SGkgUGV0ciwKCk9uIE1vbiwgQXVnIDE4LCAyMDI1IGF0IDM6NTXigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+IFByaW50IG5vdCBvbmx5IHRzdF9yZXNfLmMgZmlsZW5h
bWUgYW5kIGxpbmVubyBidXQgYWxzbyBzY3JpcHQgd2hpY2gKPiBpbnZva2VkIHRzdF9yZXNfLmMg
KGlmIGF2YWlsYWJsZSkuIFRoYXQgaGVscHMgZmluZCB3cm9uZyB0c3RfcmVzXy5jCj4gaW52b2Nh
dGlvbjoKPgo+ICAgICB0c3RfcmVzXy5jOjQyOiBXcm9uZyB0eXBlICdUUEFTU19FRScgKGludm9r
ZWQgYnkgc2hlbGxfbG9hZGVyLnNoOi0xKQo+ICAgICBVc2FnZTogdHN0X3tyZXMsYnJrfSBmaWxl
bmFtZSBsaW5lbm8KPiBbVFBBU1N8VEJST0t8VEZBSUx8VFdBUk58VENPTkZ8VElORk98VERFQlVH
XSAnQSBzaG9ydCBkZXNjcmlwdGlvbicKPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+
CgotLS0KPiBDaGFuZ2VzIHY0LT52NToKPiAqIFVzZSBhcmd2WzFdIGFuZCBhcmd2WzJdIChDeXJp
bCkKPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvYUlDMUE5eU5YS1g2UU4yTkB5dWtpLmxh
bi8KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sdHAvYUlJSGgyQ1ljcmFBSkhxR0B5dWtpLmxh
bi8KPgo+IExpbmsgdG8gdjQ6Cj4KPiBodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL3Byb2pl
Y3QvbHRwL3BhdGNoLzIwMjUwNzIyMTI1OTE2Ljc0OTY3LTUtcHZvcmVsQHN1c2UuY3ovCj4gaHR0
cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwNzIyMTI1OTE2Ljc0OTY3LTUtcHZvcmVsQHN1
c2UuY3ovCj4KPiAgdGVzdGNhc2VzL2xpYi90c3RfcmVzXy5jIHwgMTIgKysrKysrKystLS0tCj4g
IDEgZmlsZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvdGVzdGNhc2VzL2xpYi90c3RfcmVzXy5jIGIvdGVzdGNhc2VzL2xpYi90c3RfcmVz
Xy5jCj4gaW5kZXggYzA5ZDY4OWVlNS4uMmNjMzFlNzQwZiAxMDA2NDQKPiAtLS0gYS90ZXN0Y2Fz
ZXMvbGliL3RzdF9yZXNfLmMKPiArKysgYi90ZXN0Y2FzZXMvbGliL3RzdF9yZXNfLmMKPiBAQCAt
MSw2ICsxLDcgQEAKPiAgLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0
ZXIKPiAgLyoKPiAgICogQ29weXJpZ2h0IChjKSAyMDI0IEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6Pgo+ICsgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAyNQo+ICAg
Ki8KPgo+ICAjZGVmaW5lIFRTVF9OT19ERUZBVUxUX01BSU4KPiBAQCAtMTMsMTMgKzE0LDE1IEBA
IHN0YXRpYyB2b2lkIHByaW50X2hlbHAodm9pZCkKPgo+ICBpbnQgbWFpbihpbnQgYXJnYywgY2hh
ciAqYXJndltdKQo+ICB7Cj4gLSAgICAgICBpbnQgdHlwZSwgaTsKPiArICAgICAgIGludCBpLCBs
aW5lbm8sIHR5cGU7Cj4KPiAgICAgICAgIGlmIChhcmdjIDwgNSkgewo+IC0gICAgICAgICAgICAg
ICBwcmludGYoImFyZ2MgPSAlaSBleHBlY3RlZCA1XG4iLCBhcmdjKTsKPiArICAgICAgICAgICAg
ICAgZnByaW50ZihzdGRlcnIsICIlczolZDogYXJnYyA9ICVpIGV4cGVjdGVkIDVcbiIsIF9fRklM
RV9fLAo+IF9fTElORV9fLCBhcmdjKTsKPgoKImFyZ2MgPSAlaSBleHBlY3RlZCA1IiBpcyBmaW5l
LCBidXQgbWF5YmUgImludmFsaWQgYXJnYz0laSwgZXhwZWN0ZWQgNSIKd291bGQgYmUgY2xlYXJl
ci4KCiAgICAgICAgICAgICAgICBnb3RvIGhlbHA7Cj4gICAgICAgICB9Cj4KPiArICAgICAgIGxp
bmVubyA9IGF0b2koYXJndlsyXSk7CgorCj4gICAgICAgICBpZiAoIXN0cmNtcChhcmd2WzNdLCAi
VFBBU1MiKSkgewo+ICAgICAgICAgICAgICAgICB0eXBlID0gVFBBU1M7Cj4gICAgICAgICB9IGVs
c2UgaWYgKCFzdHJjbXAoYXJndlszXSwgIlRGQUlMIikpIHsKPiBAQCAtMzUsNyArMzgsOCBAQCBp
bnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+ICAgICAgICAgfSBlbHNlIGlmICghc3Ry
Y21wKGFyZ3ZbM10sICJUQlJPSyIpKSB7Cj4gICAgICAgICAgICAgICAgIHR5cGUgPSBUQlJPSzsK
PiAgICAgICAgIH0gZWxzZSB7Cj4gLSAgICAgICAgICAgICAgIHByaW50ZigiV3JvbmcgdHlwZSAn
JXMnXG4iLCBhcmd2WzNdKTsKPiArICAgICAgICAgICAgICAgZnByaW50ZihzdGRlcnIsICIlczol
ZDogV3JvbmcgdHlwZSAnJXMnIChpbnZva2VkIGJ5Cj4gJXM6JWQpXG4iLCBfX0ZJTEVfXywKPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fTElORV9fLCBhcmd2WzNdLCBhcmd2WzFd
LCBsaW5lbm8pOwo+ICAgICAgICAgICAgICAgICBnb3RvIGhlbHA7Cj4gICAgICAgICB9Cj4KPiBA
QCAtNTcsNyArNjEsNyBAQCBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqYXJndltdKQo+Cj4gICAg
ICAgICB0c3RfcmVpbml0KCk7Cj4KPiAtICAgICAgIHRzdF9yZXNfKGFyZ3ZbMV0sIGF0b2koYXJn
dlsyXSksIHR5cGUsICIlcyIsIG1zZyk7Cj4gKyAgICAgICB0c3RfcmVzXyhhcmd2WzFdLCBsaW5l
bm8sIHR5cGUsICIlcyIsIG1zZyk7Cj4KPiAgICAgICAgIHJldHVybiAwOwo+ICBoZWxwOgo+IC0t
Cj4gMi41MC4xCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
