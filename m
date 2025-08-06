Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 435A1C87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754522603; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ImVola9eM1c1nefmap6/BooAGwXTjz9AXhPf1NTEmkc=;
 b=hrpwYjDbS7ELShYE5/EAn8N3Fqd0VdJRgSq4cI2xpKM8e5XOnixKVJbE6y6xmcfYY1E0v
 qo56H5vAYanA0r1oR9w3vVp3VULp3kmPXoNjPpDxwwl2z9VzvJILh1PbG4ofM+juv+njV8I
 QCKz20b+KkAiGxHOyANshNFgpzS/h5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 979ED3C8338
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 01:23:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE7B33C73A6
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 01:23:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 444B6600739
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 01:23:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754522579;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U1YXBVPldevNWtCycsTX3dx7/PD0YQFKM4WW+qNwlAs=;
 b=Y+HWh8MaHCocGd8qK7qZpStFzlhhRCbAVg5KP7X1jYdcQYWzLjjMU9H32BCXmImfacxVJB
 09CGxjQMwN9tTEw/U7lWdPSw0JKjboOXnrKykhRFN7kO5ofQeF+MPlrcNMuEoiZHYDpO+9
 9+BNlEqf/6EsNbL9OzwXj3pR6e/Ddbk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-479-IVC9p6iyOWWGHgUdoA15eQ-1; Wed, 06 Aug 2025 19:22:57 -0400
X-MC-Unique: IVC9p6iyOWWGHgUdoA15eQ-1
X-Mimecast-MFC-AGG-ID: IVC9p6iyOWWGHgUdoA15eQ_1754522577
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b42249503c4so1185907a12.0
 for <ltp@lists.linux.it>; Wed, 06 Aug 2025 16:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754522577; x=1755127377;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U1YXBVPldevNWtCycsTX3dx7/PD0YQFKM4WW+qNwlAs=;
 b=dXwGupUk4XXUpw0aUoGtS6vuQniwn7mYQn/pzBBSpDQWH+kzaTogaFBOEPPuBYiQVg
 mu2BkIZYqf03iZgP996c7Fu0Q1CcTfgy2IkHf6J43kTwyFaLFul3b+1/TGNpwsCZbJzH
 asHp/jUT5o8kM46VZCqh5AFLaQExcD6RERFjKqgDjdvecpAA/Pix8RByXge/hmemCyPL
 NyRzHVTo/SPTkr/9QnC+ukmCGN/fXC12p6JkyRay8h5ARs+fcd+gy+VsOn9BAnkKqDiE
 3Hk7VglJFPtE0v7LzKD3a80hxcfsY3rTxg0gtCMbHLB08cgjZHR/5fCfPhfR9RJc0Jtc
 /kyw==
X-Gm-Message-State: AOJu0YxaukV9ynLU0Y0AG77ZCN5lVjwHb6UOspXbr6eTQPqSI5kcanY9
 1rOu1vLHnUZxKmUNVcyJGU/ijTxl2OVl23VYvHOO2rEAa1FrCetzpgQrIjddTbBU/dE2+g9iGb1
 bic9pI4JRd4F68dXvcpq7e0iO0ntABvkVjznqDFOY5p3gAPQm0syRAgzNEBldD1XRf9mRYlFL3k
 u9BF9mWR9MTJt/XK0zmG3rCD1yJE0=
X-Gm-Gg: ASbGncuf2o929tkJAjfCRu3eyIEoJO/vgXNBUW1L5R4z6LBo7SJpgt3Sf3KRwHNlKcE
 P6x3SNb5BX5aKeswfL2D+kvL+xonxdH2dDQ1G0QnkTn0tCd8b+jEI+8IhnT7rOP+qiAGS7J8ZN/
 k69VJoyBYmsKjJ25WKP6vbCg==
X-Received: by 2002:a17:902:f68b:b0:23f:b00a:d4c with SMTP id
 d9443c01a7336-242b06056d8mr16112165ad.2.1754522576640; 
 Wed, 06 Aug 2025 16:22:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvl55cYPSzwQ3avZLm8/8A+wwUcRwKqtDWwBcakJe+vOm2sL1+Ad6KOCckqoA2S3vLl5EpcusX63NyC1i9dGU=
X-Received: by 2002:a17:902:f68b:b0:23f:b00a:d4c with SMTP id
 d9443c01a7336-242b06056d8mr16111925ad.2.1754522576225; Wed, 06 Aug 2025
 16:22:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250806211420.445452-1-pvorel@suse.cz>
In-Reply-To: <20250806211420.445452-1-pvorel@suse.cz>
Date: Thu, 7 Aug 2025 07:22:43 +0800
X-Gm-Features: Ac12FXxkCs2y8ewjee-Gw1oZzZ0TjfHVYKdfRPrs1-GNbJF11m3fxwHl4sDMte8
Message-ID: <CAEemH2cgv6vwZvK4J5cquG4=sXt2076CdNtB-fuMzx0+OOFcDw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5mxHvZSgHXv3F1tfiA6S0badYQ3N6jTOS6VJKQwpqvw_1754522577
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] Makefile: Add kernel modules related make
 targets
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
Cc: =?UTF-8?Q?Ricardo_B_=2E_Marli=C3=A8re?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKCk9uIFRodSwgQXVnIDcsIDIwMjUgYXQgNToxNOKAr0FNIFBldHIgVm9yZWwgPHB2
b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gTFRQIGNvbnRhaW5zIGZldyBrZXJuZWwgbW9kdWxlcyBh
bmQgdGVzdHMgd2hpY2ggYXJlIHVzaW5nIHRoZW0uICBUaGVzZQo+IHJlcXVpcmUgdG8gYmUgYnVp
bHQgd2l0aCB0aGUgc2FtZSBrZXJuZWwgaGVhZGVycyBhcyB0aGUgcnVubmluZyBrZXJuZWwKPiAo
U1VUKS4gU29tZXRpbWVzIHRoZSBiZXN0IHdheSB0byBhY2hpZXZlIHRoaXMgaXMgdG8gY29tcGls
ZSB0aGVtIG9uIHRoZQo+IFNVVC4KPgo+IEFkZCAnbW9kdWxlcycsICdtb2R1bGVzLWNsZWFuJyBh
bmQgJ21vZHVsZXMtaW5zdGFsbCcgbWFrZSB0YXJnZXRzIHRvCj4gbWFrZSBpdCBlYXNpZXIgdG8g
YnVpbGQgdGhlbS4KPgoKTWF5YmUgYmV0dGVyIHRvIGtlZXAgdGhlIG1ha2UgdGFyZ2V0IGNvbnNp
c3RlbnQgd2l0aCB0aGUga2VybmVsIGJ1aWxkCmNvbW1hbmQ6CiAgbWFrZSBtb2R1bGVzX2luc3Rh
bGwKICBtYWtlIG1vZHVsZXNfY2xlYW4KCgoKPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwg
PHB2b3JlbEBzdXNlLmN6Pgo+CgpSZXZpZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5j
b20+CgoKPiAtLS0KPiBDaGFuZ2VzIHYyLT52MzoKPiAqIEF1dG9tYXRpYyBkZXRlY3Rpb24gKExp
KSwgbm90ZTogd2l0aG91dCAnc29ydCAtdScgYXMgdGhlcmUgc2hvdWxkIGJlCj4gICBzaW5nbGUg
TWFrZWZpbGUgaW4gZGlyZWN0b3J5Lgo+Cj4gTGluayB0byB2MjoKPgo+IGh0dHBzOi8vcGF0Y2h3
b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyNTA4MDExMDA5MzUuOTc0MzUxLTEt
cHZvcmVsQHN1c2UuY3ovCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwODAxMTAw
OTM1Ljk3NDM1MS0xLXB2b3JlbEBzdXNlLmN6Lwo+Cj4gIElOU1RBTEwgIHwgMTAgKysrKysrKysr
Kwo+ICBNYWtlZmlsZSB8IDIxICsrKysrKysrKysrKysrKysrKysrKwo+ICAyIGZpbGVzIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9JTlNUQUxMIGIvSU5TVEFMTAo+
IGluZGV4IGNiZTI3ZjMyZWEuLjEwYzE5ZDQxMDUgMTAwNjQ0Cj4gLS0tIGEvSU5TVEFMTAo+ICsr
KyBiL0lOU1RBTEwKPiBAQCAtMTY1LDYgKzE2NSwxNiBAQCBQS0dfQ09ORklHX0xJQkRJUj0vdXNy
L2xpYi9pMzg2LWxpbnV4LWdudS9wa2djb25maWcKPiBDRkxBR1M9LW0zMiBMREZMQUdTPS1tMzIg
Li9jCj4gICogQXJjaCBMaW51eAo+ICBQS0dfQ09ORklHX0xJQkRJUj0vdXNyL2xpYjMyL3BrZ2Nv
bmZpZyBDRkxBR1M9LW0zMiBMREZMQUdTPS1tMzIKPiAuL2NvbmZpZ3VyZQo+Cj4gK0tlcm5lbCBt
b2R1bGVzCj4gKy0tLS0tLS0tLS0tLS0tCj4gKwo+ICtMVFAgY29udGFpbnMgZmV3IGtlcm5lbCBt
b2R1bGVzIGFuZCB0ZXN0cyB3aGljaCBhcmUgdXNpbmcgdGhlbS4KPiArVGhlc2UgcmVxdWlyZSB0
byBiZSBidWlsdCB3aXRoIHRoZSBzYW1lIGtlcm5lbCBoZWFkZXJzIGFzIHRoZSBydW5uaW5nCj4g
a2VybmVsIChTVVQpLgo+ICtTb21ldGltZXMgdGhlIGJlc3Qgd2F5IHRvIGFjaGlldmUgdGhpcyBp
cyB0byBjb21waWxlIHRoZW0gb24gdGhlIFNVVC4KPiArCj4gKydtb2R1bGVzJywgJ21vZHVsZXMt
Y2xlYW4nIGFuZCAnbW9kdWxlcy1pbnN0YWxsJyBtYWtlIHRhcmdldHMgYXJlCj4gc2hvcnRjdXRz
Cj4gK3RvIGJ1aWxkIGp1c3QgdGhlc2UgbW9kdWxlcyBhbmQgdGVzdHMuCj4gKwo+ICBBbmRyb2lk
IFVzZXJzCj4gIC0tLS0tLS0tLS0tLS0KPgo+IGRpZmYgLS1naXQgYS9NYWtlZmlsZSBiL01ha2Vm
aWxlCj4gaW5kZXggZWFiNDBkYThhNi4uY2RhZDhiMTBjZSAxMDA2NDQKPiAtLS0gYS9NYWtlZmls
ZQo+ICsrKyBiL01ha2VmaWxlCj4gQEAgLTIxMiw2ICsyMTIsMjcgQEAgZW5kaWYKPiAgdGVzdC1t
ZXRhZGF0YTogbWV0YWRhdGEtYWxsCj4gICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2Rpcikv
bWV0YWRhdGEgdGVzdAo+Cj4gK01PRFVMRV9ESVJTIDo9ICAkKHNoZWxsIFwKPiArICAgICAgIGRp
cm5hbWUgJCQoZ3JlcCAtbCAnaW5jbHVkZS4qbW9kdWxlXC5taycgJCQoZmluZCB0ZXN0Y2FzZXMv
IC10eXBlCj4gZiAtbmFtZSAnTWFrZWZpbGUnKSkpCj4gKwo+ICsKPiArLlBIT05ZOiBtb2R1bGVz
IG1vZHVsZXMtY2xlYW4gbW9kdWxlcy1pbnN0YWxsCj4gK21vZHVsZXM6Cj4gKyAgICAgICBAJChm
b3JlYWNoIGRpciwkKE1PRFVMRV9ESVJTKSxcCj4gKyAgICAgICAgICAgICAgIGVjaG8gIkJ1aWxk
ICQoZGlyKSI7XAo+ICsgICAgICAgICAgICAgICAkKE1BS0UpIC1DICQoYWJzX3NyY2RpcikvJChk
aXIpOyBcCj4gKykKPiArbW9kdWxlcy1jbGVhbjoKPiArICAgICAgIEAkKGZvcmVhY2ggZGlyLCQo
TU9EVUxFX0RJUlMpLFwKPiArICAgICAgICAgICAgICAgZWNobyAiQnVpbGQgJChkaXIpIjtcCj4g
KyAgICAgICAgICAgICAgICQoTUFLRSkgLUMgJChhYnNfc3JjZGlyKS8kKGRpcikgY2xlYW47IFwK
PiArKQo+ICttb2R1bGVzLWluc3RhbGw6IG1vZHVsZXMKPiArICAgICAgIEAkKGZvcmVhY2ggZGly
LCQoTU9EVUxFX0RJUlMpLFwKPiArICAgICAgICAgICAgICAgZWNobyAiQnVpbGQgJChkaXIpIjtc
Cj4gKyAgICAgICAgICAgICAgICQoTUFLRSkgLUMgJChhYnNfc3JjZGlyKS8kKGRpcikgaW5zdGFs
bDsgXAo+ICspCj4gKwo+ICAjIyBIZWxwCj4gIC5QSE9OWTogaGVscAo+ICBoZWxwOgo+IC0tCj4g
Mi41MC4xCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
