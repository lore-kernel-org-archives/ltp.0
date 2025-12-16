Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44166D5E12E
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765884225; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=rHfN2IQdokLuseXcr+fRyf5rg0l2WZP84kO6TNluffY=;
 b=Tlmgjam6dM3+5BZRxmNizZyIUwxsO4j3J6CRaCNfy9P4YRyYRP7PFhVNtHF8NN0C6CxSJ
 Zi/97xEXX02tBWSgHA8w3rvCQapEziox25wjpQexmgIiX3CPBz4FHVjmWrMt5dk2ZuE0QsE
 /S5L1i4WdEi2d3ei3nFy1s4sFdnbKwQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99F573D0330
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:23:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E8A793C0322
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:23:22 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 26793600063
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:23:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765884200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1ZKhhIMZn87E36VYAY70xujfgMvxf1bkLgI6HCno8Vc=;
 b=ZCmBjFp4CDbqI60SaRduEnfypbXDjTPyJkSMcWY/5GoLUcMglzcEXGAwwr9NEK43vlcYs+
 SpEWapgzCw8VlwhfaJK9xaf+DoBhF7qHFmw7kwnBJu/aTNpkpu7aaq57ltjuYVWdCctqoh
 /at185C+PwEyk7kaFB22ak8v6MzyzE8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-5-AH4BAAMCW5QbU42ukZVw-1; Tue, 16 Dec 2025 06:23:19 -0500
X-MC-Unique: 5-AH4BAAMCW5QbU42ukZVw-1
X-Mimecast-MFC-AGG-ID: 5-AH4BAAMCW5QbU42ukZVw_1765884198
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b471737e673so5631166a12.1
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 03:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765884197; x=1766488997;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1ZKhhIMZn87E36VYAY70xujfgMvxf1bkLgI6HCno8Vc=;
 b=vTxFTG2nAE2qqG83oEHVyjPqyMkfzW05BU819lT1WbpRPS3wV1abYpxDpeGUNzjsQS
 eA5Z5a/4j/E7nzpLm0mZ8Debk7w2kJsJI3hNsxs7/fV0npAbLKa3ORVgBRJYHIhMUNam
 5GNclhmshoVFd4dxMpJZaHDSeH4IaTIaOqz14rcydib5E0VBUQlEzLHu8aItTJfFmehh
 lgs8V9NPRqEKqJ4RkhVat3Xgpo91VQ3eVgwYBb4aWvOGhWyYUfSxahH3TwhgowMVVVo0
 LO5cHAJe201xQpPuf3asOkJyj2l8tC0Cia3aNCowL9S3NnAbQaA0Ktk3FgPOpqQ/KFik
 Esng==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp+Qbq3Oq4BNL/ERqBIFkm12AvfoA2ly+6l7gpjqW18Hk4RaFjpYGulxe1vUsVVO8cMvw=@lists.linux.it
X-Gm-Message-State: AOJu0YyCu8HIecQk6AVG6B+n4BvFaUprtskY5/4QvSxlbZo8cGfO/ZdU
 MCPaCOcCmW2zScRocCqgK1Zibk6vdSLsTVxJ9OnNZba4C1mxsvlpe8cMjVMyStfRLCCCgYhUBkp
 3RTV+r0ZLG3SpOW2u1hQy1nnB/VxJqXljRopw+fNcazW1NCw9b0S6QQDUEpQMd8iI5ppbNjOfsy
 qhfdwOZrkogSM0E5bCA+HSWAaN7AJ/sgHO2Altiw==
X-Gm-Gg: AY/fxX78W5lbU/uDUnbjiq77skDz10CopB2fSt6Wdj8NJ4lR2x9R4P74tonIbF3GVPK
 too4JcwXPLOsFeaUPgPDCYLtNrBr90G1qqS2K2oO2eM9Gfs1Emib56PbJckqELDRRWM6Lm/B4QR
 A58bQieLlFDn/o8izK2ivfxGeeszVY4ecD4LSNnROJHfiyS44+uD7NaCL3vUJcx5rgTj0=
X-Received: by 2002:a05:693c:2402:b0:2a4:3593:c7c9 with SMTP id
 5a478bee46e88-2ac2f8812acmr9823881eec.9.1765884196962; 
 Tue, 16 Dec 2025 03:23:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH0AQLPl0GTZ1QNoDGhu8QleKp0URQQmtZ7JqlWOteZGLjyljeksY8MKahr4nq9FCPb2KrjBpaK0hr3eCypyWM=
X-Received: by 2002:a05:693c:2402:b0:2a4:3593:c7c9 with SMTP id
 5a478bee46e88-2ac2f8812acmr9823865eec.9.1765884196543; Tue, 16 Dec 2025
 03:23:16 -0800 (PST)
MIME-Version: 1.0
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <CAEemH2eoJ9v88TE63ScjZB2xw73_hgZF90BPDQq72_HX4OobLw@mail.gmail.com>
 <20251215143048.GA267467@pevik>
 <CAEemH2cmuxr7jKBA32eXQHOwQLvq4tPMDsmcen_9C7di=eSpDQ@mail.gmail.com>
 <20251216101117.GA295306@pevik>
 <CAEemH2dyDmwz=bCMAUCgma5P7dYbfeD16Cey-anLrVxyFRmg4w@mail.gmail.com>
 <DEZLECEME0NF.1AAT13XDV0HO5@suse.com>
In-Reply-To: <DEZLECEME0NF.1AAT13XDV0HO5@suse.com>
Date: Tue, 16 Dec 2025 19:23:04 +0800
X-Gm-Features: AQt7F2r5pVbwJKCGBYxn4aIB6vz-FHqSyNLS_qXc9171HSD-6MahxZPRdIh7RDw
Message-ID: <CAEemH2fv7PumS7V+M-ZydqbdLiP0kC1UFTL7fyKQajhqjDGQhw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wy2h0Et4RTE97eXqLtIWJLaKOPUpT5Wbg5EKiPcHnP0_1765884198
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

T24gVHVlLCBEZWMgMTYsIDIwMjUgYXQgNzowOeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gPGFuZHJl
YS5jZXJ2ZXNhdG9Ac3VzZS5jb20+Cndyb3RlOgoKPiA+Cj4gPiBKdXN0IGxpa2UgWWluZyBIdWFu
ZyAoRnJvbSBBbGliYWJhKSBzcG9rZSB0byBtZToKPiA+ICJJIGZvdW5kIHRoYXQgQUkgcGVyZm9y
bXMgYmV0dGVyIG9ubHkgd2hlbiBJIGJyZWFrIHRoZSB3b3JrIGRvd24gaW50bwo+ID4gYXRvbWlj
IHVuaXRzLiIKPgo+IFRoZSBwcm9ibGVtIEkgaGF2ZSB3aXRoIHRoaXMgYXBwcm9hY2ggaXMgdGhh
dCB0aGVyZSdzIGEgcmlzayBvZiAiZHVtYgo+IGVmZmVjdCIsIHdoZXJlIGFuIGVuZ2luZWVyIHdp
bGwgcmVseSBvbiBBSSBzbyBtdWNoIHRvIGZvcmdldCBob3cgdG8KPiB3cml0ZSAxMDAgbGluZXMg
b2YgY2xlYW4gY29kZS4KPgoKVGhhdCdzIGFic29sdXRlbHkgcmlnaHQuCgoKCj4KPiA+IFRoZXJl
Zm9yZSwgaXQncyBlc3BlY2lhbGx5IGltcG9ydGFudCB0byByZWx5IG9uIGVuZ2luZWVycycgZXhw
ZXJpZW5jZSB0bwo+ID4gY2xlYXJseSB1bmRlcnN0YW5kIHdoYXQgcHJvYmxlbXMgYXJlIGhpbmRl
cmluZyB0aGVtIGFuZCBob3cgdG8KPiA+IGNvbW11bmljYXRlIHdpdGggQUkuCj4gPgo+Cj4gSSBh
Z3JlZSB3aXRoIHRoaXMuIEJvcmluZywgcmVwZXRpdGl2ZSB0YXNrcyBpcyB3aHkgd2UgY3JlYXRl
ZCBhdXRvbWF0aW9uCj4gYW5kIEFJIGlzIGEgcGFydCBvZiBpdC4gTGV0J3MgZ2l2ZSBpdCB0aGUg
cmlnaHQgc3BhY2UgYW5kIHdlIHdvbid0IGVuZAo+IHdvcmtpbmcgZG91YmxlIGJlY2F1c2Ugb2Yg
QUkgbWFkbmVzcyA6LSkKPgo+IFRoaXMgcGFydCBvZiBkb2N1bWVudGF0aW9uIGlzIG5lZWRlZCBh
bmQgaXQgd291bGQgYmUgbmljZSB0byBoYXZlIGl0Cj4gYWxyZWFkeSBieSB0aGUgZW5kIG9mIHRo
ZSB5ZWFyLiBXRFlUPwo+CgpJIGFncmVlLiBJbiBjb25jbHVzaW9uLCB3ZSBuZWVkIGEgc3BlY2lm
aWMgQUkgcnVsZSBmb3IgTFRQIGNvbW11bml0eS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
