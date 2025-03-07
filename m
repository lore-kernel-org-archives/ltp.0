Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF2B2C282DE
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 10:07:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D8863CA11A
	for <ltp@archiver.kernel.org>; Fri,  7 Mar 2025 11:07:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7159C3CA00D
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 11:07:11 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9B0621400138
 for <ltp@lists.linux.it>; Fri,  7 Mar 2025 11:07:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741342028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bL3eFzrUvokXeVo/hr/trTZwaFHAIg7dvVSR11Wokl0=;
 b=bxGXRI0HWFdf5uwhcBXwOYEQpz0602Hncuzh4i2zvxLMsQu3i6zeLMmZjscXMt9kZaScdd
 01IhfiIzYKuuvzNLREnL/9RFUn7hT8ikL5qyXSnq3okpNPwVUwx9fSoV7E/neyi3ybiA/9
 rdFOQwZr50R6//PQIlpOqa8QC/yCWRo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-490-WEgLT9ybNxKfnQkXGfcIIQ-1; Fri, 07 Mar 2025 05:07:04 -0500
X-MC-Unique: WEgLT9ybNxKfnQkXGfcIIQ-1
X-Mimecast-MFC-AGG-ID: WEgLT9ybNxKfnQkXGfcIIQ_1741342024
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff58318acaso4811952a91.0
 for <ltp@lists.linux.it>; Fri, 07 Mar 2025 02:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741342023; x=1741946823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bL3eFzrUvokXeVo/hr/trTZwaFHAIg7dvVSR11Wokl0=;
 b=sPJoc/urYChxt5FT5oEr7ZTtALkrKBhDWBEMB+ySEwDScJgWe7MMuzeIFpa0GmOL6s
 MFe1cMnTTKF9Y5bkSWDbLQs3NfYd70BMqlRfXyeOqTtc4I7BK13KHVXLKt49PC0RB/ON
 LTSkOEpUnL6LmnyxtFs5zydtJRvO1CAIox8Aq+2YTo4BMwmwGM3ORukGgV6t3X+uY2hM
 +IRjzjV7fSOXv08AHzEFbRBv2HvmmkNM50DNPnOLqI5uh6YlbPqvWhlL3wekfVgnYOq5
 hApuHvtHXZCsqoOfIwZoWVVlkIFA2n8TqFs78vxzXJRrPLMIyvBpMsMjz2QtMPlCdzGt
 VFgQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Z69AE/8Ogyb/jK6jADCuETWYvYkPnIE8SqWhIUx/Fp2b9pjphPfzuA2MLervcuc8MwA=@lists.linux.it
X-Gm-Message-State: AOJu0YwQiOh2S7eMBvcN3vG/4EjFgGefOkmfYrAnu6dCPj3DtIcoKkKp
 XRsQnje9sD3WnRd6cyp78bnIo/Xhz1CnK6ABGFRvad8g+DOm6HYJBKUHqcatjTOKFib4LySv4/s
 nyBIDYkqsI16JOEJLmqi+A5aCOPAjPMvHcRxqugghgebiCY5J9daIkJYu4YZ8pyIK0zmq11In67
 dIGsU8nHLheW6HGyl1ASOEmpw=
X-Gm-Gg: ASbGncukC6dKrf1ohzoq41ikBmhMOIu559fwJqyAASmcyphwRkXYohVT8vIZLaG6+Q8
 PU/a7XNfEQB2g2dl90XE9SuocsRFTVfvSVKLyt5Mv4O1rJR4MHDjkCbhkt3M544kJC/VR+0gYEA
 ==
X-Received: by 2002:a17:90b:2782:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff7ce938b6mr5175186a91.18.1741342023745; 
 Fri, 07 Mar 2025 02:07:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHSOnRhaUKVjotsFEIItilAh3aphdGUUcZitSP2WPBYcR2CPzwBBtNIaUJoW60hsqYhXKw0lo9YNdQMtIwAWFo=
X-Received: by 2002:a17:90b:2782:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-2ff7ce938b6mr5175155a91.18.1741342023483; Fri, 07 Mar 2025
 02:07:03 -0800 (PST)
MIME-Version: 1.0
References: <67cabd64-fb43-4d1a-a471-995fd51a0e2b@suse.com>
 <20250307092606.GA263657@pevik> <Z8q9QFilTbSc7QAw@yuki.lan>
In-Reply-To: <Z8q9QFilTbSc7QAw@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Mar 2025 18:06:51 +0800
X-Gm-Features: AQ5f1Jov-ox2z4JgdmOyjmsASox5OGO9fMXA5_F-WEI5S6EjZlkU0bwR8AgJnzE
Message-ID: <CAEemH2cBTkmaDw7SU5V28_1VTDozEXifYD7XSwtA7A1Qqf2sgw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fWaJKMysoo6Y0ZB-QJnvhCd37c1k1hpB0d2LE89g7E8_1741342024
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Meetings schedule
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
Cc: Xiao Yang <yangx.jy@fujitsu.com>, "Ricardo B. Marliere" <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBNYXIgNywgMjAyNSBhdCA1OjMy4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gLSBNb250aGx5IG1lZXRpbmdzCj4gPiA+IC0gTWVl
dGluZ3MgZXZlcnkgdHdvIG1vbnRocwo+ID4gPiAtIE1lZXRpbmdzIGFmdGVyIGVhY2ggcmVsZWFz
ZQo+ID4KPiA+IEkgZ3Vlc3Mgb25jZSBhIG1vbnRoIGlzIE9LLiBPciwgaWYgaXQncyB0b28gbXVj
aCB0byBzb21lYm9keSBvbmNlIGV2ZXJ5IDIKPiA+IG1vbnRocy4gSSdtIG5vdCBzdXJlIGlmIGl0
IHNob3VsZCBiZSBhaW1lZCBiZWZvcmUgdGhlIHJlbGVhc2Ugb3IgYWZ0ZXIKPiB0aGUKPiA+IHJl
bGVhc2UuCj4KPiBBZ3JlZSBoZXJlLCBtb250aGx5IGlzIGZpbmUuCj4KCisxCgoKPiA+ID4gSSBz
dWdnZXN0IHdlIGFpbSB0byBob2xkIG91ciBtZWV0aW5ncyBkdXJpbmcgdGhlIGZpcnN0IHdlZWsg
b2YgdGhlCj4gbW9udGguIElmCj4gPiA+IGEgbWVldGluZyBjYW5ub3QgYmUgaGVsZCBkdWUgdG8g
cHVibGljIGhvbGlkYXlzLCB3ZSBjYW4gY29uc2lkZXIKPiA+ID4gcmVzY2hlZHVsaW5nIGl0IGZv
ciB0aGUgZm9sbG93aW5nIHdlZWsuCj4gPgo+ID4gTEdUTS4gV2hpY2ggZGF5PyBJIHdvdWxkIHBy
ZWZlciBub3QgRnJpZGF5Lgo+ID4KPiA+IEFsc28sIEkgd291bGQgcHJlZmVyIGl0IG5vdCBjbGFz
aCB3aXRoIE9BVFMgbW9udGhseSBjYWxsOiB3aGljaCBpcwo+ICpzZWNvbmQqCj4gPiBUaHVyc2Rh
eSBpbiBtb250aCwgMTQ6MDAgVVRDICgxNWggQ0VUKS4KPgo+IEkgZ3Vlc3MgdGhhdCB3ZSB3aWxs
IGtlZXAgdGhlIG1lZXRpbmdzIGluIHRoZSBDRVQvQ0VTVCBtb3JuaW5nIGFzIHdlCj4gZGlkLCB3
aGljaCBpcyBtb3JlIHRpbWV6b25lIGZyaWVuZGx5IHdpdGggQXNpYS4KPgoKRXhhY3RseSEKCi0t
IApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
