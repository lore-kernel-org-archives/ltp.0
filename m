Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9B74C77B6C
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 10:30:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACCCC3CC74D
	for <ltp@archiver.kernel.org>; Thu,  6 Apr 2023 12:30:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52A423C010A
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 12:29:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 64C5A1000AE8
 for <ltp@lists.linux.it>; Thu,  6 Apr 2023 12:29:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680776991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SkkObFe6fYfwjebDERQKmRo4wLgV5jjJxpdu55cLJkA=;
 b=SknndKgXbVQ+PSqp3axsLYZy2N8R8Ht/m2lmUq9aWB97t18UsD25y11RSpUwkNOV3EEhaO
 lNSj7ojfkIvL+fo0zGcUotaUMNIQ9jjo3L9367gh74wJrvU2fDH/7TGMKeNIfUQXb/ChIV
 CmA6oWoSHxxMYwzVlFBuSZE2BicgC6g=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-AXsDqNeRNwGgEq0DBF0kHA-1; Thu, 06 Apr 2023 06:29:50 -0400
X-MC-Unique: AXsDqNeRNwGgEq0DBF0kHA-1
Received: by mail-wm1-f72.google.com with SMTP id
 h22-20020a05600c351600b003ef739416c3so13341922wmq.4
 for <ltp@lists.linux.it>; Thu, 06 Apr 2023 03:29:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680776989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SkkObFe6fYfwjebDERQKmRo4wLgV5jjJxpdu55cLJkA=;
 b=TayuQdy27z+L0Cuc+p9n7Cjdy1dCL3XVdpms6OLn9zhRhf8KK+Eg9AnQrEbSzgQt+s
 KJ1TX8yGZYegwLIKWFf/ItYmTBNdpXx+nrF+H7j4JCN8qCVSmZVD2DFdbd6l+va4wJ4j
 OZlY+RpmrhbiXHccnh/antu5qdmp672hDH1X4RyXcWOur357UkyF62zL6F2fuZ5EyoGv
 70okWlx6VOlyB5LS96FgkFRRHnS7tB1KCxibbchU1W4Ft0kIVJ5Eyx5NK+gerE7fMqmY
 0GFmStWMXP5OfVEyW8+Z5r9RhluTHJbqcOebfR0e0UDJWedbr48j170oqqzHbKDC/15u
 TLWg==
X-Gm-Message-State: AAQBX9flvcxCSS2cQXLPIvSMsflHyq1zhNcPgTyNbi/5elzYsPtoJs2e
 9Om6hc8/qOCR+BSUCwmx7Fq5GtM+vg+5nlSJJbwrKZCX234J1b7qZDy65RaDkQSMgOlZv2wZ2qw
 SV3ZcOTDHYj3XFAP9ZcJCuYuiles=
X-Received: by 2002:a05:600c:20f:b0:3f0:3ce6:9b08 with SMTP id
 15-20020a05600c020f00b003f03ce69b08mr2244658wmi.8.1680776989208; 
 Thu, 06 Apr 2023 03:29:49 -0700 (PDT)
X-Google-Smtp-Source: AKy350YncHMeotk2Mo+T4vC5f7psmMgk/MAtLcFG9gK/gcVD8svdpjYU+kCn4EBVR9y6b2yhyDTkkSxXZLu28eQ3eJ0=
X-Received: by 2002:a05:600c:20f:b0:3f0:3ce6:9b08 with SMTP id
 15-20020a05600c020f00b003f03ce69b08mr2244650wmi.8.1680776988898; Thu, 06 Apr
 2023 03:29:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230404112852.1271969-1-pvorel@suse.cz>
 <CAEemH2fNLRxhj7NxRvxOr-XYe+gbXiEsYiKosm855_z+jdO5hA@mail.gmail.com>
 <20230406094853.GA1545779@pevik>
In-Reply-To: <20230406094853.GA1545779@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 6 Apr 2023 18:29:37 +0800
Message-ID: <CAEemH2db7gN9GduVYwfeLM1Px9rp_WTV6uXm1O+urVLXWrMbfA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] mmap20: Fix invalid address
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
Cc: Paulson Raja L <paulson@zilogic.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBBcHIgNiwgMjAyMyBhdCA1OjQ54oCvUE0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBhbGwsCj4KPiA+IEhpIFBldHIsCj4KPiA+ICgxPDw5KSBpcyBhbHNv
IHVzZWQgYnkgYW5vdGhlciBmbGFnIG9uIGFscGhhLCBidXQgaXQgc2FpZCBub3QKPiA+IGxpbnV4
LXNwZWNpZmljLAo+ID4gc28gSSBndWVzcyBpdCB3b24ndCBiZSBhIHByb2JsZW0gKGF0IGxlYXN0
IGZvciBub3cpLgo+ID4gICBhbHBoYS9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaDojZGVmaW5lIF9N
QVBfSEFTU0VNQVBIT1JFIDB4MDIwMAo+Cj4gR29vZCBwb2ludCEgSSBjaGVja2VkIG9ubHkgZ2xp
YmMvbXVzbCBoZWFkZXJzLCBvYnZpb3VzbHkgY2hlY2tpbmcga2VybmVsCj4gc291cmNlcwo+IGlz
IGJldHRlciBhcyBpdCBjb250YWlucyBvbGQgYXJjaHMuIEl0IGFmZmVjdHMgYWxwaGEsIGlhNjQg
YW5kIHNwYXJjCj4gKHdlbGwsIHRoZXkgbWlnaHQgbm90IGV2ZW4gY29tcGlsZSBjdXJyZW50IExU
UCwgd2Ugd2VyZSBkcm9wcGluZyBpYTY0IGZpeGVzCj4gYW55d2F5KS4KPgoKT2theSwgSSBvbmx5
IG5vdGljZWQgdGhhdCBhbHBoYSBpcyBub3QgZGVmaW5lZCAweDAyMDAgZm9yIExpbnV4CnNwZWNp
ZmljYWxseS4KCgoKPgo+ICQgZ2l0IGdyZXAgLXcgMHgwMjAwIGFyY2gvKi9pbmNsdWRlL3VhcGkv
YXNtL21tYW4uaAo+IGFyY2gvYWxwaGEvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmg6I2RlZmluZSBf
TUFQX0hBU1NFTUFQSE9SRSAweDAyMDAKPiBhcmNoL2lhNjQvaW5jbHVkZS91YXBpL2FzbS9tbWFu
Lmg6I2RlZmluZSBNQVBfR1JPV1NVUCAgIDB4MDIwMCAgICAgICAgICAvKgo+IHJlZ2lzdGVyIHN0
YWNrLWxpa2Ugc2VnbWVudCAqLwo+IGFyY2gvc3BhcmMvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmg6
I2RlZmluZSBNQVBfR1JPV1NET1dOICAgICAgICAweDAyMDAKPiAgICAgICAvKiBzdGFjay1saWtl
IHNlZ21lbnQgKi8KPgo+IEJ1dCBhcyAweDQwMCAoMSA8PCAxMCkgaXMgbm90IHVzZWQgYW55d2hl
cmUsIEkgbWVyZ2VkIGl0IHdpdGggdGhpcyB2YWx1ZS4KPgoKCkhtbSwgSSBkaWRuJ3QgdW5kZXJz
dGFuZCBoZXJlIHdoeSBtZXJnZWQgd2l0aCAweDA0MDAsCmFyZW4ndCB0aGVyZSBzdGlsbCBkdXBs
aWNhdGVkIGZsYWdzPwoKJCBnaXQgZ3JlcCAtdyAweDA0MDAgYXJjaC8qL2luY2x1ZGUvdWFwaS9h
c20vbW1hbi5oCmFyY2gvYWxwaGEvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmg6I2RlZmluZSBfTUFQ
X0lOSEVSSVQgMHgwNDAwCmFyY2gvbWlwcy9pbmNsdWRlL3VhcGkvYXNtL21tYW4uaDojZGVmaW5l
IE1BUF9OT1JFU0VSVkUgMHgwNDAwICAgICAgICAgIC8qCmRvbid0IGNoZWNrIGZvciByZXNlcnZh
dGlvbnMgKi8KYXJjaC94dGVuc2EvaW5jbHVkZS91YXBpL2FzbS9tbWFuLmg6I2RlZmluZSBNQVBf
Tk9SRVNFUlZFICAgICAgIDB4MDQwMAogICAgIC8qIGRvbid0IGNoZWNrIGZvciByZXNlcnZhdGlv
bnMgKi8KCgoKPgo+IEl0J2QgYmUgZ29vZCB0byBmb2xsb3cgSmFuJ3Mgc29sdXRpb24gKGRvbid0
IG1hcCBhIGZpbGUsIGFuZCB0aGVuIGFkZAo+IE1BUF9TWU5DCj4gdG8gZmxhZ3MpLCBidXQgSSds
bCBwb3N0cG9uZSBpdCB0byBsYXRlci93aGVuIG5lZWRlZC9uZXZlciAodGhlcmUgYXJlIG90aGVy
Cj4gdGVzdHMgd2hpY2ggbmVlZHMgdG8gYmUgZml4ZWQuCj4KPiBUaGFua3MgYSBsb3QgYm90aCEK
Pgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
