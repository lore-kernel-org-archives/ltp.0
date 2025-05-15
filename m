Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AF65C3ABC9
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 09:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747299745; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=CBACeI5cWR9CVCMYB6RT/v8ttlLbeeVk+HPuLj5poes=;
 b=l4owoc0VmMR8z7eIXLXzIqR+TbdE6TEYzS5ylG7rRO92B/J6i3GR5O22LkSR0Ii+cGa37
 gsmirGd4TBBPpMRco+vHTwNRkXVNQvy8DtkFwXvymVc4MVPs+Vgnl4UDULMo0TYAS4xxJPQ
 xP9Sb9yrETLwtY3F7tp63CKUYis7pdI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C0B33CC473
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 11:02:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 816D13CB7DE
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:02:03 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5572E600909
 for <ltp@lists.linux.it>; Thu, 15 May 2025 11:02:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747299720;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Knyi98d9eRHd3Qm8baCuRQU3IzEvaWzfO4cNpMmMAXE=;
 b=P5l8S5+SU5FX9iOnX4DZsgA455op6gtx4RYO8WUpEMPX1dsUlM86wj7IYdGUDVxlaLWlJb
 81FB5tfXhal/7sPmjNHa/AOx1LV36ARIP03IpS4QtanDYVvOTsone7Oa7j4ki4YEXJM9Cs
 mhNAXdvm/yfjhysx8KWkluNJ5TyotuQ=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-_oaCoBoAM7-VIXa_FIL_ZQ-1; Thu, 15 May 2025 05:01:58 -0400
X-MC-Unique: _oaCoBoAM7-VIXa_FIL_ZQ-1
X-Mimecast-MFC-AGG-ID: _oaCoBoAM7-VIXa_FIL_ZQ_1747299718
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22fc829046fso7385485ad.2
 for <ltp@lists.linux.it>; Thu, 15 May 2025 02:01:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747299718; x=1747904518;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Knyi98d9eRHd3Qm8baCuRQU3IzEvaWzfO4cNpMmMAXE=;
 b=uHr1tOYzOnTpYpsMQwIHxUW5FaLPJAji+484H5iQvgN+zhTxIFO7kxUpFkDIN4fgb8
 mYhlxL3KPb4hx1W1AUiHTUMRPZk3Iy5n+ACPlJ7I3SbuKdxt3W3GPZURHu7vxGHam5Rb
 hiQM2INaihmUzwpfUPZxfD7gLHKQ0XPoA1cYmlHPuMHR92sz7UDwF6XmheqAUs1CLjbq
 4l3P5pIJ+c0txZsed37IARWSCk8dGxtYmbnelxjSE8EwIbg/iqV4UDy/hRjg1yidmkXm
 jwdpeWDwrHr2BPYtieTUC66GJHMjZAek04z4a9/e5b8HicYC9IBRkU5PZ/OxphLcrx60
 tvFg==
X-Gm-Message-State: AOJu0YxdyaTjPc2bcdFDT5Az1s889e/1V9xUYIYDoiy2vMwit0Tyvao3
 +wSG7ge4DX3g8n4inqGsEoXn9HC1v6gbGbndKE3lu1dTa8+4IeUEzf7QBDjJyrMsbr5Z0xhN9zm
 UYu5FbNeYjAuwAEJtst9ozUoHg11aPNCrtablaOPCrUQy3AFcpVrOB7BoLQq21X+TvR25SrpjRZ
 SZtNHNWesU9Lk2V9cSzSCEwVM=
X-Gm-Gg: ASbGncuvCd/xCRlK+YTVqQ4u2Ld9lkMdthw/IbXjXZKAVS6daYe9oJWupsW64akWWFg
 8774KQsa4hNxT05wSvwr3xEd1REnM66gujrY2eaQcXlgqnkgYFRLIEcDG1VUW4Rq5t070Pg==
X-Received: by 2002:a17:903:124d:b0:22e:62da:2e66 with SMTP id
 d9443c01a7336-23198154a16mr106624925ad.24.1747299717892; 
 Thu, 15 May 2025 02:01:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG3//y+xFCUFIfeGukns7BqlzneamASjy7At4agG0Q/2sBtTgwhvy6kZ2CMtETqkfPc/dORK81t1/sgM7iUixc=
X-Received: by 2002:a17:903:124d:b0:22e:62da:2e66 with SMTP id
 d9443c01a7336-23198154a16mr106624675ad.24.1747299717550; Thu, 15 May 2025
 02:01:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-5-cd633e941e8b@suse.com>
 <CAEemH2cqO7AHyibDxNUOsr4eLRJvXkD-ckj=YmLQQGrHO08OXA@mail.gmail.com>
 <D9WLQ935PWHU.15YKNJYVP25PV@suse.com>
In-Reply-To: <D9WLQ935PWHU.15YKNJYVP25PV@suse.com>
Date: Thu, 15 May 2025 17:01:45 +0800
X-Gm-Features: AX0GCFuFaEDqo_1DN1SDbbrZZuyWn4cIVwcrd33QJiw5MEp3H4XsT4ZxwgTxsbc
Message-ID: <CAEemH2fHu8JjL3Q3dxY8nwCC-W92KZd=LrR7u7+6mMq25sDerg@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eGvDIB3eyb_jjcLYFgkK295XIWHZVXuGYERQAdsz8pw_1747299718
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] syscalls/kill09: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBNYXkgMTUsIDIwMjUgYXQgNDo0NuKAr1BNIFJpY2FyZG8gQi4gTWFybGnDqHJlIDxy
Ym1Ac3VzZS5jb20+IHdyb3RlOgo+Cj4gSGkgTGkhCj4KPiBPbiBXZWQgTWF5IDE0LCAyMDI1IGF0
IDExOjI3IFBNIC0wMywgTGkgV2FuZyB3cm90ZToKPiA+IEhpIFJpY2FyZG8sCj4gPgo+ID4gSW4g
dGhpcyBwYXRjaCwgeW91IGNvbnZlcnQga2lsbDA5LmMgdG8gdGhlIG5ldyBBUEksIHdoaWNoIGlz
IGdvb2QsCj4gPiBidXQgaW4gcGF0Y2ggNi82IHlvdSByZW1vdmUga2lsbDA5LmMgZW50aXJhbGx5
Lgo+ID4KPiA+IEkgZG9uJ3QgdW5kZXJzdGFuZCB3aHkgd2Ugc3RpbGwgbmVlZCB0aGlzIGNvbnZl
cnNpb24gaWYgd2UgZmluYWxseQo+ID4gbmVlZCB0byByZW1vdmUgaXQgOikuCj4KPiBVbmZvcnR1
bmF0ZWx5IGl0IG9ubHkgYmVjYW1lIGFwcGFyZW50IHRoYXQgaXQgY291bGQgYmUgcmVtb3ZlZCBl
bnRpcmVseQo+IGFmdGVyIEkgY29udmVydGVkIGl0LiBTbyBJIHNlbnQgaXQgdGhpcyB3YXkgdG8g
c2VlIGlmIGl0J3MgYWNjZXB0YWJsZSB0bwo+IHJlbW92ZSwgYXMgaXRzIGVhc2llciB0byBzZWUg
d2h5LiBCdXQgYWdyZWVkIHRoYXQgaXQgc2hvdWxkIGJlIHNxdWFzaGVkLAo+IEknbGwgc2VuZCBh
IHYyLgoKT2gsIEkgc2VlLiBUaGFua3MgZm9yIHRoZSBjbGFyaWZpY2F0aW9uLgpZb3Ugb25seSBu
ZWVkIHRvIHNlbmQgdGhlIGxhc3QgbmV3IHBhdGNoIGFmdGVyIHNxdWFzaGluZy4KCi0tIApSZWdh
cmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4
Lml0L2xpc3RpbmZvL2x0cAo=
