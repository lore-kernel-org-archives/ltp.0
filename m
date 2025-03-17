Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3DE1C282EC
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 15:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742223852; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=k38mUq0SUYps5K8J+A4QpWjgS0KJRMAYTXWTG3pJdrc=;
 b=lruAWZq6dl9v46kiGL6J7BLHhyAmHYMfdOUU4a2vNJX5bwKp1aTiRQ4JyYW9DqqE4LPIX
 taWR8jHIZIWYr46pLcGSwbatl8aL3HIWPiXa3jDf4iz81YZbtaGcNqwvVvsBDyw5OXOAV7X
 nPBM9adBqIeFzRz5JPSTEAEj5Id5oiI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D2BFD3CAB58
	for <ltp@archiver.kernel.org>; Mon, 17 Mar 2025 16:04:12 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059EA3C1D61
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 16:03:49 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C58261A0045B
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 16:03:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742223826;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jz/VkLLkwHWu+1bSCT46py5Op9/423lwp4Ss85UnKnE=;
 b=FsooQiosaKQiCeEL7jt+xOh45Lx7SGwGksJKkOvetiyBz0ChQS700mJvJfw/gxy1y2Wg9C
 BLkutsLQh1et/CfnIL5EOCQgvA0pZ3wFnKGMbYMkW0tMAQzOK0fo3XEP7kjdMqYJ5idc3A
 iFpQNH+JHYIYidR8tQILGPy9HSIZlKo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-171-G4t-tqNjPmaAfQuiRfrRWA-1; Mon, 17 Mar 2025 11:03:44 -0400
X-MC-Unique: G4t-tqNjPmaAfQuiRfrRWA-1
X-Mimecast-MFC-AGG-ID: G4t-tqNjPmaAfQuiRfrRWA_1742223824
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-47693206f16so94453121cf.1
 for <ltp@lists.linux.it>; Mon, 17 Mar 2025 08:03:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742223824; x=1742828624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jz/VkLLkwHWu+1bSCT46py5Op9/423lwp4Ss85UnKnE=;
 b=HYXf/AVGorFOvZfIFh1w3qegO6ttUB+KSvLAZITeclm24t4JyJfE8SbKiEczU4TNqW
 lK2BNieteavjjRbdjZVQVxJIZIO7HqYRa09L4kQVGO/Hf5fM68ca8CRHgwVuuqmStze8
 7BfdCrWXjY7owjNFKAOrvRnCYYO/XDAorKVvn3V7Aqm+UJvmJfwhvDJIAqMLPCeMb+8a
 RW7Xr7J8CyKYy2IFKv6W4wnFhyVEDGA9Lkk5Ljsf0MWNIZXHlY5m2Ebc6vhAigmSZ1w0
 jJrTsWQXkednh861a4fNFgM1g6PjejedlcTItjaa5kg7HOXGjGaUjUF57sYJ02MHdhzR
 kQMQ==
X-Gm-Message-State: AOJu0Yy6qr8LcTAwokjtTlo1IYug+ihzwuF93qp72MMzJEEV8cmgh+Kw
 3TeO+WyeelEPtwosBrcErA/c6jE3lZfmBGLI9gs0HQ75uC5/crXhsOL1U7JU1WYjUikd138g4D5
 5IlJhahleMDRj7CYot2wO0/EQX2n3Lnpzi2RTPQcwZhpqEE67ZzP3+aPLiKauKSMt6N0+bB3VfM
 m5HPQ2qaXBAIc7SC1aIa6naN0=
X-Gm-Gg: ASbGncubMDIZSrQyOsAxQ4xSAxQQKv2XLTY8mV8IK4ANGnBeyJQwq/kELj5ezePbgOS
 6gbKC6NthXpxPGW1DgyuBFd7ml+LP4LJjoXwe9EXulXvpMR2ONCb57BsoK7jhvYW+MnmkJkFK
X-Received: by 2002:ac8:5a4e:0:b0:474:f4a4:2ca9 with SMTP id
 d75a77b69052e-476c81461e5mr154804581cf.25.1742223823921; 
 Mon, 17 Mar 2025 08:03:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH97G/Gmyd94wHpiYhhu3NSyGuawBjYYKFRNMacrb7vnPxXppo3YpLX6xvgbPTB1M/orwhgdsJbHvsUUSJJ/MY=
X-Received: by 2002:ac8:5a4e:0:b0:474:f4a4:2ca9 with SMTP id
 d75a77b69052e-476c81461e5mr154804171cf.25.1742223823457; Mon, 17 Mar 2025
 08:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250317140651.305762-1-pvorel@suse.cz>
In-Reply-To: <20250317140651.305762-1-pvorel@suse.cz>
Date: Mon, 17 Mar 2025 16:03:27 +0100
X-Gm-Features: AQ5f1Jp03xtpqIAij3KxrjdTAt6013No8NTEl_hTkG0B4xHzzYadqjfn2r30XAQ
Message-ID: <CAASaF6yxMFEFe4QgF3BF6-+7TvtbGnWMpHF-jE1fYvE5DNkNdA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Jvrt-G2q_SR67sK_JOwj_GqWunuYVkjLkhksD9wMdXM_1742223824
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Remove (custom) check for <linux/random.h>
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMTcsIDIwMjUgYXQgMzowN+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKPgo+IEhlYWRlciBzdXBwb3J0IGlzIG5vcm1hbGx5IGRvbmUgd2l0aCBBQ19D
SEVDS19IRUFERVJTX09OQ0UgYnVpbHRpbi4KPiA8bGludXgvcmFuZG9tLmg+IHdhcyBhZGRlZCBp
biBrZXJuZWwgZ2l0IGZyb20gdGhlIGJlZ2lubmluZyAoMi42LjEyKQo+IG5vIG5lZWQgdG8gY2hl
Y2sgZm9yIGl0Lgo+Cj4gZ2V0cmFuZG9tKCkgc3lzY2FsbCBpcyBzdXBwb3J0ZWQgc2luY2Uga2Vy
bmVsIDMuMTcgKGNoZWNrIGZvciBpdHMKPiBzdXBwb3J0LCB3aGljaCB3YXMgcmVsZXZhbnQgYXQg
dGhlIHRpbWUgaXMgZG9uZSBieSB0c3Rfc3lzY2FsbCgpKS4KPgo+IE5PVEU6IHdob2xlIGNoZWNr
IGlzIGRvbmUgZm9yIGdldHJhbmRvbSgpIGxpYmMgd3JhcHBlciBzdXBwb3J0ICh1c2VkIGluCj4g
aW5jbHVkZS9sYXBpL2dldHJhbmRvbS5oKSwgd2hpY2ggd2FzIGFkZGVkIGluIGdsaWJjIDIuMjUs
IG11c2wgMS4xLjIwCj4gYW5kIHVjbGliYy1uZyB2MS4wLjIgKGJ1dCB1bnRpbCB2MS4wLjUwIHJl
cXVpcmVkIF9HTlVfU09VUkNFKS4KPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3Jl
bEBzdXNlLmN6PgoKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3RhbmNla0ByZWRoYXQuY29tPgoK
PiAtLS0KPiBUZXN0ZWQ6Cj4gaHR0cHM6Ly9naXRodWIuY29tL3BldmlrL2x0cC9hY3Rpb25zL3J1
bnMvMTM5MDEzNTkwNDAKPgo+ICBjb25maWd1cmUuYWMgICAgICAgICAgICAgfCAgMSAtCj4gIGlu
Y2x1ZGUvbGFwaS9nZXRyYW5kb20uaCB8ICAyICstCj4gIG00L2x0cC1saW51eHJhbmRvbS5tNCAg
ICB8IDE5IC0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlv
bigrKSwgMjEgZGVsZXRpb25zKC0pCj4gIGRlbGV0ZSBtb2RlIDEwMDY0NCBtNC9sdHAtbGludXhy
YW5kb20ubTQKPgo+IGRpZmYgLS1naXQgYS9jb25maWd1cmUuYWMgYi9jb25maWd1cmUuYWMKPiBp
bmRleCAwZjJiNmYzMzI5Li42NTgyYmE4YjBmIDEwMDY0NAo+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+
ICsrKyBiL2NvbmZpZ3VyZS5hYwo+IEBAIC0zNzYsNyArMzc2LDYgQEAgTFRQX0NIRUNLX0ZPUlRJ
RllfU09VUkNFCj4gIExUUF9DSEVDS19LRVJORUxfREVWRUwKPiAgTFRQX0NIRUNLX0tFWVVUSUxT
X1NVUFBPUlQKPiAgTFRQX0NIRUNLX0xJQk1OTAo+IC1MVFBfQ0hFQ0tfTElOVVhSQU5ET00KPiAg
TFRQX0NIRUNLX1NFTElOVVgKPiAgTFRQX0NIRUNLX1NZTkNfQUREX0FORF9GRVRDSAo+ICBMVFBf
Q0hFQ0tfU1lTQ0FMTF9FVkVOVEZECj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9nZXRyYW5k
b20uaCBiL2luY2x1ZGUvbGFwaS9nZXRyYW5kb20uaAo+IGluZGV4IDcwNmVmOWI4ZmYuLjhkNWI5
MGVlOTMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS9sYXBpL2dldHJhbmRvbS5oCj4gKysrIGIvaW5j
bHVkZS9sYXBpL2dldHJhbmRvbS5oCj4gQEAgLTEwLDcgKzEwLDcgQEAKPgo+ICAjaWZkZWYgSEFW
RV9TWVNfUkFORE9NX0gKPiAgIyBpbmNsdWRlIDxzeXMvcmFuZG9tLmg+Cj4gLSNlbGlmIEhBVkVf
TElOVVhfUkFORE9NX0gKPiArI2Vsc2UKPiAgIyBpbmNsdWRlIDxsaW51eC9yYW5kb20uaD4KPiAg
I2VuZGlmCj4KPiBkaWZmIC0tZ2l0IGEvbTQvbHRwLWxpbnV4cmFuZG9tLm00IGIvbTQvbHRwLWxp
bnV4cmFuZG9tLm00Cj4gZGVsZXRlZCBmaWxlIG1vZGUgMTAwNjQ0Cj4gaW5kZXggNGY2YjlkMTM1
NS4uMDAwMDAwMDAwMAo+IC0tLSBhL200L2x0cC1saW51eHJhbmRvbS5tNAo+ICsrKyAvZGV2L251
bGwKPiBAQCAtMSwxOSArMCwwIEBACj4gLWRubCBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcgo+IC1kbmwgQ29weXJpZ2h0IChjKSBMaW51eCBUZXN0IFByb2plY3QsIDIw
MTUKPiAtCj4gLUFDX0RFRlVOKFtMVFBfQ0hFQ0tfTElOVVhSQU5ET01dLFsKPiAtICAgICAgIEFD
X01TR19DSEVDS0lORyhbZm9yIGxpbnV4L3JhbmRvbS5oXSkKPiAtICAgICAgIEFDX0NPTVBJTEVf
SUZFTFNFKFtBQ19MQU5HX1NPVVJDRShbCj4gLQo+IC0jaW5jbHVkZSA8bGludXgvcmFuZG9tLmg+
Cj4gLWludCBtYWluKHZvaWQpIHsKPiAtICAgICAgIHJldHVybiAwOwo+IC19XSldLFtoYXNfbGlu
dXhfcmFuZG9tX2g9InllcyJdKQo+IC0KPiAtaWYgdGVzdCAieCRoYXNfbGludXhfcmFuZG9tX2gi
ID0geHllczsgdGhlbgo+IC0gICAgICAgQUNfREVGSU5FKEhBVkVfTElOVVhfUkFORE9NX0gsMSxb
RGVmaW5lIHRvIDEgaWYgaGF2aW5nIGEgdmFsaWQgbGludXgvcmFuZG9tLmhdKQo+IC0gICAgICAg
QUNfTVNHX1JFU1VMVCh5ZXMpCj4gLWVsc2UKPiAtICAgICAgIEFDX01TR19SRVNVTFQobm8pCj4g
LWZpCj4gLV0pCj4gLS0KPiAyLjQ4LjEKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
