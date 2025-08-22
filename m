Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02501CA0EFA
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 01:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755826723; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ys4xCjfZw3b9AmmyAE2jSmh4ko5a2rA8y+bCBtGZxmg=;
 b=EsHQV3CfGlakZAuKNd3Ro2ztA5YziuXgL96pLIAdXz0u4nn4FKd82/g5TMgFIAZZ9rTjt
 7rUgsmWjgK1CJ4hqZUjHjlHqOt6bSLq6+nH8XPyYFqgcCbfD2qX/5vjEXz2Var9PicBKY+C
 wB8w580rQQesntVL5MXNo/moDW0eSWc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 147D23CCC4F
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 03:38:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2857B3C07BB
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 03:38:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2D89B1A0024C
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 03:38:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755826698;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AauydPhrlN7KGswgZ9GVrNGSTu77Zwv02dbYf4TAm1w=;
 b=St1QoZ+qxaAcVsUVTw0Wo+PiItpnslBR+N6+nWfbSyhZciPN1S3Rd5PqGju/F98ulk083m
 /qSEs52hBQFtvYtFfkZNxipN7UFJd+y2QNGiX0qPIupqutSqu+Ux3nsEtniQRnEO5QQ7PA
 G+dwJKrLghLYPWiSks1qccrGEe9ntck=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-bvay2oXDPaS-cGJmAhBwgA-1; Thu, 21 Aug 2025 21:38:17 -0400
X-MC-Unique: bvay2oXDPaS-cGJmAhBwgA-1
X-Mimecast-MFC-AGG-ID: bvay2oXDPaS-cGJmAhBwgA_1755826696
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24456ebed7bso19531295ad.0
 for <ltp@lists.linux.it>; Thu, 21 Aug 2025 18:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755826695; x=1756431495;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AauydPhrlN7KGswgZ9GVrNGSTu77Zwv02dbYf4TAm1w=;
 b=CiFoqHzkPY8w6/ENHvrL5WdtQ27HDCEorpj5rIrr+9XdFWEp9eQa5WkpNSavjSsXnL
 6WSf+Hk7ZILPrNtaphjZMSJPgVOtPUTsKtV8++K8l5Yhh6qOC5prDg8k3I1g0Ed/XfqI
 iWtalYt6UVdsqFcQtsUvpVTLiHEj89jCXAxSub6u7RV0I5NoS98feMt2K6GiSO+bZ+EN
 xQxfmCmO9qLzBXEolQhoS8Zv+5WLv7zvIB9ceLZ/1MYSMAmG47IltJemAgi3rsD+8KW8
 nPxB9VTc+b3UUfcsNo78ZLUZ5vxj5eZXkmiLKGjnzhoyjkdM7dlmvYHfdasc5QsFwQud
 dVKQ==
X-Gm-Message-State: AOJu0YwtwFp0bO5GJbc+WzSjFUGPVizTUAcKxioFJ16iCHU7PNwTHgmY
 ntSRYh+Wj2RjPDetIfKMv++v3VxzevG75VXHHE9ypVIIq9WNvwAmAc5gW11EFtfExQHKlLGkVt1
 ciOohpr+fzfdzH5uokrjCneJO1FzW/bUel6FR70nhuMjLK613GYU6jbhYTaO3sjxAvPZsLVaMGM
 yCc5klejBaq2qqHOOmJeBhZ5olLShyflbP5AIEiz4u
X-Gm-Gg: ASbGncv/033KM/aw0pT9M1FmWc17evGuXTvBz8fvj07qgFpCcMLJQyQsBsihiMUvoSI
 Nax0KptBc+Rpb23N+XUxowVKu+bOM9eamKipH5zN40sCkENNCcZsKQuUIdGOH8z4sI/QcDpZ4uU
 jXP2FPnmTmdU5ZBY0QK5tK1A==
X-Received: by 2002:a17:902:f707:b0:240:ac96:e054 with SMTP id
 d9443c01a7336-246337acf34mr13333075ad.23.1755826694836; 
 Thu, 21 Aug 2025 18:38:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtvVcfFGMlv6IN8jW3gdd/TYGIl8pc/ccCJRhnMkxda2oIudmmeLQYh4rXNicsK5ilx24PZ+F/y9GhxQKPXCk=
X-Received: by 2002:a17:902:f707:b0:240:ac96:e054 with SMTP id
 d9443c01a7336-246337acf34mr13332875ad.23.1755826694366; Thu, 21 Aug 2025
 18:38:14 -0700 (PDT)
MIME-Version: 1.0
References: <20250605142943.229010-1-wegao@suse.com>
 <20250610221435.1680891-1-wegao@suse.com>
In-Reply-To: <20250610221435.1680891-1-wegao@suse.com>
Date: Fri, 22 Aug 2025 09:38:02 +0800
X-Gm-Features: Ac12FXwfI0SLeLcM1Ey0IjqagHhSSCvoL42VbxTKX0Uf2PRGPYu1RJ4umRHNO_s
Message-ID: <CAEemH2ehxd7kpQa090hO2f_8jLCKY+pp5BHiZTafOgfWzxEBgw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jqakNcl-LdlsR1raavhl3LuY_Y6hJDcwQW8ur3uO1-Y_1755826696
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_cgroup.c: Skip cases which testing cgroup
 v2 with CONFIG_RT_GROUP_SCHED=y
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
Cc: mkoutny@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMTAsIDIwMjUgYXQgNjoxNeKAr1BNIFdlaSBHYW8gdmlhIGx0cCA8bHRwQGxp
c3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gUlRfR1JPVVAgc2NoZWR1bGluZyBpcyBjZ3JvdXAgdjEg
ZmVhdHVyZSBhcyBvZiBub3cuIFNvIHdlIG5lZWQgc2tpcCB0ZXN0Cj4gY2FzZXMKPiBmb3IgY2dy
b3VwIHYyIHdpdGggQ09ORklHX1JUX0dST1VQX1NDSEVEPXkuCj4KPiBTa2lwIGNhc2VzIGxpc3Q6
Cj4gc2NoZWRfcnJfZ2V0X2ludGVydmFsMDEKPiBzY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMgo+IHNj
aGVkX3JyX2dldF9pbnRlcnZhbDAzCj4gc2NoZWRfc2V0cGFyYW0wMgo+IHNjaGVkX2dldHNjaGVk
dWxlcjAxCj4KPiBGaXhlczogaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9s
dHAvaXNzdWVzLzEyNDUKPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4K
PiAtLS0KPiAgaW5jbHVkZS90c3RfY2dyb3VwLmggICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgfCAgMiArKwo+ICBsaWIvdHN0X2Nncm91cC5jICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDExICsrKysrKysrKysrCj4gIC4uLi9zY2hlZF9nZXRzY2hlZHVsZXIv
c2NoZWRfZ2V0c2NoZWR1bGVyMDEuYyAgICAgICAgIHwgIDIgKysKPiAgLi4uL3NjaGVkX3JyX2dl
dF9pbnRlcnZhbC9zY2hlZF9ycl9nZXRfaW50ZXJ2YWwwMS5jICAgfCAgMiArKwo+ICAuLi4vc2No
ZWRfcnJfZ2V0X2ludGVydmFsL3NjaGVkX3JyX2dldF9pbnRlcnZhbDAyLmMgICB8ICAyICsrCj4g
IC4uLi9zY2hlZF9ycl9nZXRfaW50ZXJ2YWwvc2NoZWRfcnJfZ2V0X2ludGVydmFsMDMuYyAgIHwg
IDIgKysKPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9zY2hlZF9zZXRwYXJhbS9zY2hlZF9zZXRwYXJh
bTAyLmMgfCAgMiArKwo+ICA3IGZpbGVzIGNoYW5nZWQsIDIzIGluc2VydGlvbnMoKykKPgo+IGRp
ZmYgLS1naXQgYS9pbmNsdWRlL3RzdF9jZ3JvdXAuaCBiL2luY2x1ZGUvdHN0X2Nncm91cC5oCj4g
aW5kZXggZDJiNTIyNGEwLi4wZjBmNDRlYzMgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3RfY2dy
b3VwLmgKPiArKysgYi9pbmNsdWRlL3RzdF9jZ3JvdXAuaAo+IEBAIC0yNTYsNCArMjU2LDYgQEAg
aW50IHNhZmVfY2dfb2NjdXJzaW4oY29uc3QgY2hhciAqZmlsZSwgY29uc3QgaW50Cj4gbGluZW5v
LAo+Cj4gIGludCB0c3RfY2dfbWVtb3J5X3JlY3Vyc2l2ZXByb3Qoc3RydWN0IHRzdF9jZ19ncm91
cCAqY2cpOwo+Cj4gK3ZvaWQgdHN0X2NoZWNrX3J0X2dyb3VwX3NjaGVkX3N1cHBvcnQodm9pZCk7
Cj4gKwo+ICAjZW5kaWYgLyogVFNUX0NHUk9VUF9IICovCj4gZGlmZiAtLWdpdCBhL2xpYi90c3Rf
Y2dyb3VwLmMgYi9saWIvdHN0X2Nncm91cC5jCj4gaW5kZXggMzY2MDI0MDJkLi40ZWJkZjcwMWYg
MTAwNjQ0Cj4gLS0tIGEvbGliL3RzdF9jZ3JvdXAuYwo+ICsrKyBiL2xpYi90c3RfY2dyb3VwLmMK
PiBAQCAtMTYsNiArMTYsNyBAQAo+ICAjaW5jbHVkZSAibGFwaS9mY250bC5oIgo+ICAjaW5jbHVk
ZSAibGFwaS9tb3VudC5oIgo+ICAjaW5jbHVkZSAidHN0X3NhZmVfZmlsZV9hdC5oIgo+ICsjaW5j
bHVkZSAidHN0X2tjb25maWcuaCIKPgo+ICBzdHJ1Y3QgY2dyb3VwX3Jvb3Q7Cj4KPiBAQCAtMTUz
MSwzICsxNTMyLDEzIEBAIGludCB0c3RfY2dfbWVtb3J5X3JlY3Vyc2l2ZXByb3Qoc3RydWN0IHRz
dF9jZ19ncm91cAo+ICpjZykKPiAgICAgICAgICAgICAgICAgcmV0dXJuIGNnLT5kaXJzX2J5X2N0
cmxbMF0tPmRpcl9yb290LT5tZW1vcnlfcmVjdXJzaXZlcHJvdDsKPiAgICAgICAgIHJldHVybiAw
Owo+ICB9Cj4gKwo+ICt2b2lkIHRzdF9jaGVja19ydF9ncm91cF9zY2hlZF9zdXBwb3J0KHZvaWQp
Cj4gK3sKPiArICAgICAgIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3Qga2NvbmZbXSA9IHsiQ09O
RklHX1JUX0dST1VQX1NDSEVEPXkiLAo+IE5VTEx9Owo+ICsKPiArICAgICAgIGlmICgoYWNjZXNz
KCIvc3lzL2ZzL2Nncm91cC9jZ3JvdXAuY29udHJvbGxlcnMiLCBGX09LKSA9PSAwKSAmJgo+ICF0
c3Rfa2NvbmZpZ19jaGVjayhrY29uZikpIHsKPgoKSGVyZSBpcyB3aGF0IHdlIGFzc3VtZSB0aGUg
Y2dydXAgdjIgZGVmYXVsdCBtb3VudCBwYXRoLCBidXQKYmV0dGVyIHRvIHVzZSBjZ3JvdXBfdjJf
bW91bnRlZCgpIGluIGNhc2Ugc29tZSB0ZXN0IGVudiBpcyBub3QKbW91bnQgY2dyb3VwIG9uIHRo
ZSBwYXRoLgoKSSBtYWRlIHRoZSBiZWxvdyBjaGFuZ2UgYW5kIHB1c2hlZDoKCi0tLSBhL2xpYi90
c3RfY2dyb3VwLmMKKysrIGIvbGliL3RzdF9jZ3JvdXAuYwpAQCAtMTUzNyw3ICsxNTM3LDkgQEAg
dm9pZCB0c3RfY2hlY2tfcnRfZ3JvdXBfc2NoZWRfc3VwcG9ydCh2b2lkKQogewogICAgICAgIHN0
YXRpYyBjb25zdCBjaGFyICogY29uc3Qga2NvbmZbXSA9IHsiQ09ORklHX1JUX0dST1VQX1NDSEVE
PXkiLApOVUxMfTsKCi0gICAgICAgaWYgKGNncm91cF92Ml9tb3VudGVkKCkgJiYgIXRzdF9rY29u
ZmlnX2NoZWNrKGtjb25mKSkgeworICAgICAgIHRzdF9jZ19zY2FuKCk7CisKKyAgICAgICBpZiAo
Y2dyb3VwX3YyX21vdW50ZWQoKSAmJiB0c3Rfa2NvbmZpZ19jaGVjayhrY29uZikpIHsKICAgICAg
ICAgICAgICAgIHRzdF9icmsoVENPTkYsICJDT05GSUdfUlRfR1JPVVBfU0NIRUQgbm90IHN1cHBv
cnQgb24KY2dyb3VwdjIiKTsKICAgICAgICB9CgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
