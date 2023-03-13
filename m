Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A34AC61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 05:59:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BEB093CCD5A
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 06:59:44 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D93213C03AE
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 06:59:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1351B100046C
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 06:59:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678687170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7USjachUbJ3fMrvGKfwgGItm1d3sfwRkqpzXKdjgv50=;
 b=Q1Pf3JAHh/920Xu6BPI7j5AQSSY4HdExANsWQQkndKGpQ/ZZHswxof1MCn8yXNt19RvW4F
 8wTCpwj93hmHyTNIbNbiN0Ex+Lz5fSrITNlCrHbzrYjBONDpyS77eGpt+ytJZVAr4qbNmg
 xwU1iusMY+EOJk3bhLXAL2i0ETFPLp4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-PL11db2EOl-LDE_y20hFbw-1; Mon, 13 Mar 2023 01:59:28 -0400
X-MC-Unique: PL11db2EOl-LDE_y20hFbw-1
Received: by mail-wm1-f69.google.com with SMTP id
 m28-20020a05600c3b1c00b003e7d4662b83so7295399wms.0
 for <ltp@lists.linux.it>; Sun, 12 Mar 2023 22:59:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678687167;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7USjachUbJ3fMrvGKfwgGItm1d3sfwRkqpzXKdjgv50=;
 b=MCsXNS0um6MJb5J1IcmpEENeSgwZFpKNxYPWHwZ9pIBtroJrJWDVFKpScBsOcFYl40
 jB6nGeLR0LAhkgRuGxKlkU/Qhh+myZXs3CPDON2FHOznfigSmuvpwd1l5DoGuiZc3T6+
 6DG1bYT1EOvsfnOEF5b1hNubkTV9ACcwKXQqEV+Y2qAQt/QFrfIZdJ0/uHhAmMx4FBKK
 paF1/alhjl15fRoy1CZHP2vVmhfhNkr2VntXUroICB8XjrjITzOwU/oar2u73wQD8Xum
 Ekd+1b1mO+LsRs4COxN2A04Q9YhiE+by5aeK7W0CgercAueRK8JcFFEUzRwjAudtWns9
 cJAg==
X-Gm-Message-State: AO0yUKVWsmFcgfxVl0wPnEU96pfkXO7CqmFVRQLBzKhRHGLueTcVrYS4
 yb5xG+LCmPZI4CUGJdFSwJweLLn+fqwifv5WdPODOgKUn37pgURONtdiwPa9JQMyfN/dNLMq90b
 zQxKx8UUsQzpY/eGtJ1SBgqOUtfABNzwOJVeClxh4
X-Received: by 2002:adf:ef8e:0:b0:2ca:ec13:e7a0 with SMTP id
 d14-20020adfef8e000000b002caec13e7a0mr6999128wro.8.1678687166923; 
 Sun, 12 Mar 2023 22:59:26 -0700 (PDT)
X-Google-Smtp-Source: AK7set8ToH4apR/yALvFQgdYzo03f/fxCmRjdUEWKWUbfQgYnz6Yzcx5LPOAbzpB1flqKjRcFVSdpQHidfF1CG92Nqc=
X-Received: by 2002:adf:ef8e:0:b0:2ca:ec13:e7a0 with SMTP id
 d14-20020adfef8e000000b002caec13e7a0mr6999126wro.8.1678687166454; Sun, 12 Mar
 2023 22:59:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230309031517.198523-1-gehao@kylinos.cn>
 <20230309091655.225444-1-gehao@kylinos.cn>
In-Reply-To: <20230309091655.225444-1-gehao@kylinos.cn>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Mar 2023 13:59:14 +0800
Message-ID: <CAEemH2f5jwOzP37ObYnMvgafeX2EO53G4jmDiBvtaFvcG0sbtQ@mail.gmail.com>
To: Hao Ge <gehao@kylinos.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V2] memcg_stress_test.sh: Fix reserved mem
 calculate
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

SGkgSGFvLAoKT24gVGh1LCBNYXIgOSwgMjAyMyBhdCA1OjE34oCvUE0gSGFvIEdlIDxnZWhhb0Br
eWxpbm9zLmNuPiB3cm90ZToKCj4gV2hlbiBydW5uaW5nIHRoaXMgdGVzdCBjYXNlIG9uIGEgbWFj
aGluZSB3aXRoIGxhcmdlIG1lbW9yeSwKPiBhbmQgd2l0aG91dCBzd2FwIG9yIHN3YXAgaXMgdG9v
IHNtYWxsLGV4aXN0aW5nIHJlc2VydmVkCj4gbWVtb3J5IGlzIHRvbyBzbWFsbCBmb3IgYSBtYWNo
aW5lIHdpdGggbGFyZ2UgbWVtb3J5LGFuZAo+IHdpbGwgY2F1c2UgZm9ya2luZyBhIHN1YnByb2Nl
c3MgdG8gcnVuIGEgY29tbWFuZCB3aWxsIGZhaWwKPiBkdWUgdG8gbWVtb3J5IGlzIGV4aGF1c3Rl
ZCxzbyBvcHRpbWl6ZSByZXNlcnZlZCBtZW1vcnkKPiBjYWxjdWxhdGUgdG8gdGVuIHBlcmNlbnQg
b2YgZnJlZSBtZW1vcnkuCj4KPiBIZXJlIGlzIGFuIGV4YW1wbGU6Cj4KPiBmcmVlIC1tCj4gICAg
ICAgICAgICAgICB0b3RhbCAgICAgICAgdXNlZCAgICAgICAgZnJlZSAgICAgIHNoYXJlZCAgYnVm
Zi9jYWNoZQo+ICBhdmFpbGFibGUKPiBNZW06ICAgICAgICAgMjYwMTg0ICAgICAgICAyOTU5ICAg
ICAgMjU1ODU0ICAgICAgICAgIDYyICAgICAgICAxMzcwCj4gMjM2MzQ2Cj4gU3dhcDogICAgICAg
ICAgNDA5NSAgICAgICAgICAgMCAgICAgICAgNDA5NQo+Cj4gd2hlbiB5b3UgcnVuIHRoaXMgdGVz
dGNhc2UsY29uc29sZSB3aWxsIHJlcG9ydAo+IGZvcmvvvJpDYW5ub3QgYWxsb2NhdGUgbWVtb3J5
Cj4KPiBTaWduZWQtb2ZmLWJ5OiBIYW8gR2UgPGdlaGFvQGt5bGlub3MuY24+Cj4gLS0tCj4gIC4u
Li9rZXJuZWwvY29udHJvbGxlcnMvbWVtY2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoICAg
IHwgNiArKystLS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQKPiBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMvbWVt
Y2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCj4gYi90ZXN0Y2FzZXMva2VybmVsL2NvbnRy
b2xsZXJzL21lbWNnL3N0cmVzcy9tZW1jZ19zdHJlc3NfdGVzdC5zaAo+IGluZGV4IGNiNTI4NDBk
Ny4uZjI2YTlmNzJhIDEwMDc1NQo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvY29udHJvbGxlcnMv
bWVtY2cvc3RyZXNzL21lbWNnX3N0cmVzc190ZXN0LnNoCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5l
bC9jb250cm9sbGVycy9tZW1jZy9zdHJlc3MvbWVtY2dfc3RyZXNzX3Rlc3Quc2gKPiBAQCAtNDAs
NyArNDAsNyBAQCBzZXR1cCgpCj4gICAgICAgICBNRU09JCgoICRtZW1fZnJlZSArICRzd2FwX2Zy
ZWUgLyAyICkpCj4gICAgICAgICBNRU09JCgoICRNRU0gLyAxMDI0ICkpCj4gICAgICAgICBSVU5f
VElNRT0kKCggMTUgKiA2MCApKQo+IC0gICAgICAgWyAiJHBnc2l6ZSIgPSAiNDA5NiIgXSAmJiBU
SFJFQURfU1BBUkVfTUI9MSB8fCBUSFJFQURfU1BBUkVfTUI9OAo+ICsgICAgICAgUkVTRVJWRURf
TUVNT1JZPSQoKCAkTUVNICogMTAvMTAwICkpCj4KClRoYW5rcyBmb3IgdGhlIGltcHJvdmVtZW50
IHdvcmsuCgpCdXQgSU1ITywgdGhpcyBkb2VzIG5vdCBjb21wbGV0ZWx5IHJlc29sdmUgdGhlIHBv
dGVudGlhbCBpc3N1ZSB3aGljaAppbiBlYXRpbmcgZnJlZV9tZW0gZm9yIHN0cmVzcyB0ZXN0aW5n
LgoKV2UgaGF2ZSB0byBjb25zaWRlciBtYW55IHNjZW5hcmlvcyBmb3IgdGhlIHN5c3RlbSdzIGF2
YWlsYWJsZSBtZW1vcnkKaW5jbHVkaW5nIHdpdGhvdXQgc3dhcCBmaWxlLCBmcmVlX21lbSA+IGF2
YWlsX21lbSwgYW5kIG1pbl9mcmVlX2tieXRlcwppbXBhY3Rpb24uCgpGb3IgZXhhbXBsZSwgeW91
ciBwYXRjaCBtYXkgX25vdF8gd29yayBvbiB0aGlzOgoKTWVtVG90YWw6ICAgICAgIDM2MDQ0NTQ0
IGtCCk1lbUZyZWU6ICAgICAgICAyOTE3NzcyOCBrQgpNZW1BdmFpbGFibGU6ICAgMjYzOTE0ODgg
a0IKLi4uClN3YXBUb3RhbDogICAgICAgICAgICAgMCBrQgpTd2FwRnJlZTogICAgICAgICAgICAg
IDAga0IKCkkgd291bGQgc3VnZ2VzdCB5b3UgdGFrZSBhIGxvb2sgaW50bzoKCmh0dHBzOi8vZ2l0
aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2xpYi90c3RfbWVtdXRp
bHMuYyNMMTkKdG8gc2VlIGhvdyB0aGlzIGZ1bmN0aW9uIHRyZWF0cyB0aGlzIGFuZCBrZWVwcyBh
IHNhZmV0eSBtZW0gbWFyZ2luLgpIb3BlIGl0IGdpdmVzIHlvdSBzb21lIGluc3BpcmF0aW9uLgoK
CgoKPgo+ICAgICAgICAgdHN0X3JlcyBUSU5GTyAiQ2FsY3VsYXRlZCBhdmFpbGFibGUgbWVtb3J5
ICRNRU0gTUIiCj4gIH0KPiBAQCAtOTMsMTIgKzkzLDEyIEBAIHJ1bl9zdHJlc3MoKQo+Cj4gIHRl
c3QxKCkKPiAgewo+IC0gICAgICAgcnVuX3N0cmVzcyAxNTAgJCgoICgkTUVNIC0gMTUwICogJFRI
UkVBRF9TUEFSRV9NQikgLyAxNTAgKSkgNQo+ICRSVU5fVElNRQo+ICsgICAgICAgcnVuX3N0cmVz
cyAxNTAgJCgoICgkTUVNIC0gJFJFU0VSVkVEX01FTU9SWSkgLyAxNTAgKSkgNSAkUlVOX1RJTUUK
PiAgfQo+Cj4gIHRlc3QyKCkKPiAgewo+IC0gICAgICAgcnVuX3N0cmVzcyAxICQoKCAkTUVNIC0g
JFRIUkVBRF9TUEFSRV9NQikpIDUgJFJVTl9USU1FCj4gKyAgICAgICBydW5fc3RyZXNzIDEgJCgo
ICRNRU0gLSAkUkVTRVJWRURfTUVNT1JZKSkgNSAkUlVOX1RJTUUKPiAgfQo+Cj4gIC4gY2dyb3Vw
X2xpYi5zaAo+IC0tCj4gMi4yNS4xCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoK
LS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0
cAo=
