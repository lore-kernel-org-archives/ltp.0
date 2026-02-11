Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C34E9E2F7
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 12:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1770811472; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=RlvO9r0QUfTfJqDyk/GvkurXH6LVkcPXGRFyeYhefMY=;
 b=Tcx7TVVL6YNbNIei+A/QZ8lhNFcanDYekrVGmBoHnvCtKMV6QKySrWQA8gTO3wkbtIuCc
 1HcZycwxzU+1xm3D/OUoWhqTZma1hxOE1isndPNNNzROHsd/oUXQ6+jtrEs/x7R6HIvsDHi
 7ZPRSkUC2XtyLW9taHMuBC1gKR6r/GY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D63D23CE48A
	for <ltp@archiver.kernel.org>; Wed, 11 Feb 2026 13:04:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2D013CDFC9
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 13:04:08 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 24CE0200B01
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 13:04:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770811446;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dxijEaMOzlRYxMq62SAodMjuyWCkjnR7Dubqc8buslI=;
 b=IJvUMU7HpHJi2Dm6iqhy9KZOCnNsYxuyh0jeqi0ICyyDjZsIEgRdhe274EMQ8vRoHMYsja
 YkDTwMPLJr0IPDkQ8DaajPjrSxreF52/4x/BTX6QT9JNerpiYE5Qswt0+VDtdWBFq6nDCG
 EcY5txxE2iWCaCHDckiG3aTF9Y1NTps=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-kPp1w5lDNYubiR-7jxCVKg-1; Wed, 11 Feb 2026 07:04:04 -0500
X-MC-Unique: kPp1w5lDNYubiR-7jxCVKg-1
X-Mimecast-MFC-AGG-ID: kPp1w5lDNYubiR-7jxCVKg_1770811444
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8c6a289856eso241778185a.0
 for <ltp@lists.linux.it>; Wed, 11 Feb 2026 04:04:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770811444; x=1771416244;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dxijEaMOzlRYxMq62SAodMjuyWCkjnR7Dubqc8buslI=;
 b=nl0BvFC4rgYgo/Xqit3UAAlpLNGGQFeMB1LRAAo2W5U242xzM2jdpG2g0XtikxlnyD
 HphcWkQLqyryY4AiX/kPrx+7w1KSTyIiWAKWT3XpPxbF47d0dY13vMSKTnht0OStwzPB
 bTqlkeC5DyhGz50afnWwa4zrXtjBTGyg0ilgtiOCoi+AzLLIwbwN9naIf7+Ws0xFfRHm
 n6jy4HjJ9Ih84qn0EYcbsDILQoEY0C9UKIks1tTNt+mw1oTPYSyMWP98twJmXafZEZmO
 qy9nOKvPRZEK56/qh8WvxBqIbOLZ01C2RQ3Jf/3AEulc2VjNG+MZqAQD9QC6dJ6I7ztX
 nblg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHsWLaw18WPxohhirvp7XZbDTzB3KUo4yrhlXrs9F3ujnWu/fz2eREGSVKddxPQu6EvwU=@lists.linux.it
X-Gm-Message-State: AOJu0YwN289RXSPY3RaY/y3jXUHLZRJC6ew2epLB8aL4ALe3G3c7+wFt
 rUTm1Mt4JB5gPDFS9jGbQ/zDQ4VW7WpRRQzN7xCQ1Mhm99mZoVcOAC3DlMmTIRcaVqJPXiaIMOQ
 WXFEglNYw1TynWUFUVZobyzoPx4lnzoBVrVu0/BhheT7HohPIC4iPzBDNFP8i7Cxtuwg4UMvmDQ
 Wa/wbppfPvOHoQllqBeMICj3DNavA=
X-Gm-Gg: AZuq6aKUYF6pImwPHxlWi2/0a3e778VRMLRM2nR2uiyuxvFVRyo4ly2Ov1r7G825cRd
 cXKPmrXjWmz5ZDa+bWQqZzAf1nqx70CD9Ax4MgnW87tAqOlCi2cwSGQDLFS4HroxpDPYOx+AMXB
 4BWENBMTOPs1jmXicBB/DX8WZC5x0w9cTJjUItW66VtXlAezLttI3F8HBoAmLFM1PjNuGdrO+19
 v/yFA==
X-Received: by 2002:a05:620a:1993:b0:8b2:e17a:17e3 with SMTP id
 af79cd13be357-8cb1ed63b8emr736651985a.1.1770811443759; 
 Wed, 11 Feb 2026 04:04:03 -0800 (PST)
X-Received: by 2002:a05:620a:1993:b0:8b2:e17a:17e3 with SMTP id
 af79cd13be357-8cb1ed63b8emr736649085a.1.1770811443385; Wed, 11 Feb 2026
 04:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20260209234418.2810671-1-sbertram@redhat.com>
 <DGC004SO49C6.LWOJO8CM24XW@suse.com> <20260211085514.GA39031@pevik>
In-Reply-To: <20260211085514.GA39031@pevik>
Date: Wed, 11 Feb 2026 07:03:52 -0500
X-Gm-Features: AZwV_Qj0FzC1Q1RT8gc4g6IZqNvjGUIRCFsMaTyCB1YorwAP5lF8iDFYEUB-lI4
Message-ID: <CAD_=S2=oSOkBPH-+8_yaw8irCiUnUx15sJpkmxOTowCOkeH8-g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dTcRYoE18rZ5GP4iuBmNyUrf-PWG-dv33WxYZgT4ZFw_1770811444
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] mq_timedreceive01: fails sometimes with EEXIST.
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
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwKClJ1bm5pbmcgd2l0aCA0IHBhcmFsbGVsLCBzbyBwYXNzaW5nIGAtdyA0YCB0byBr
aXJrIG9yIHJ1bmx0cC4KCkl0IGRvZXNuJ3QgaGFwcGVuIGFsbCB0aGUgdGltZSwgYnV0IG1heWJl
IDEgaW4gNCBpdCB3aWxsIGdpdmUgYW4gRUVYSVNUCmVycm9yLiBBbmQgc28gZmFyIGl0J3Mgb25s
eSBoYXBwZW5lZCB3aXRoIG9uZSBvZiB0aGUgNCBpbnN0YW5jZXMuCgpJdCBoYXBwZW5lZCBmb3Ig
bWUgd2l0aCBtcV90aW1lZHJlY2VpdmUwMS4KCnRoYW5rcywKCnN0ZXBoZW4KSGUvSGlzL0hpbQoK
Ck9uIFdlZCwgRmViIDExLCAyMDI2IGF0IDM6NTXigK9BTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3Vz
ZS5jej4gd3JvdGU6Cgo+IEhpIFN0ZXBoZW4sCj4KPiA+IEhpLAo+Cj4gPiBSZXZpZXdlZC1ieTog
QW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4KPgo+IFJldmlld2Vk
LWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgo+IE91dCBvZiBjdXJpb3NpdHkgSSB3
b25kZXIgaG93IHlvdSBhY2hpZXZlIHRoZSBjbGFzaC4gSSB3YXMgbm90IGFibGUgdG8sCj4gd2hl
bgo+IHJ1bm5pbmcgbWFueSBwcm9jZXNzZXMgbG9uZyB0aW1lIGVub3VnaDoKPgo+IC4vbXFfbm90
aWZ5MDEgLWkgMjAwMDAwICYKPiAuL21xX25vdGlmeTAxIC1pIDIwMDAwMCAmCj4gLi4uCj4KPiBL
aW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
