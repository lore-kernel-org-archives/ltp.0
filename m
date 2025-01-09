Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E094E77199
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 10:45:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F1693C21D0
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 11:45:55 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6B6263C206C
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:45:38 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 35D1C1A0BED2
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 11:45:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736419535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R0gJOGv4Yzua25X3b3NZ34ORgf6d50btW2vY/RVJfCI=;
 b=NqK6i4yu9M6OPJW4Azgbl4doeebssFVcP/kr0jcrRGuEWt/HOQYW24vZ8zxtFVBv3mwK0M
 tr8VJustcgX7l693HNgtKEd4NqKLTmh7PtlkxSnwupMXE7bytkdXH8JNj7dql+cynydbHj
 EQBrIsMPKrtG7CcRBJuPcnxUcBcZ+wo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-IFhqdD62PBqtaw2_TQ2aGg-1; Thu, 09 Jan 2025 05:45:34 -0500
X-MC-Unique: IFhqdD62PBqtaw2_TQ2aGg-1
X-Mimecast-MFC-AGG-ID: IFhqdD62PBqtaw2_TQ2aGg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef9864e006so2434181a91.2
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 02:45:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736419532; x=1737024332;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R0gJOGv4Yzua25X3b3NZ34ORgf6d50btW2vY/RVJfCI=;
 b=PM/hLNWyONkFuffgb24vjd4SyNLvOyvLIw3K1umCUKeFUEo757HAftWOp34a8/ivVm
 Ww2PRKFdWQEB5GMu7XZVbJYNwXnmsbaKM6aMKsKDtMXGQKuZARt/44BfxD3C7AJZP7Ny
 2Oc8TABikoQ8P4by9UMUD7boLb+savb45HYG12Iew7Fpvf/cqALl+TuZAZfoNiPp5LcU
 tsaNFdhWbZgMwhfys+YUTKEASeXpefb+xgGpRHNScrzbQHL/U8TWpFrHg1ThZLxkmdGC
 bgh7YRPJKVgXaPcOY1dEmUtdT4aNh0YAi3DhUiJ2tjKssstxQain2mvbvFP6rxRlSL4i
 2AKA==
X-Gm-Message-State: AOJu0YyG+a6IYQ0k+ZfTx0SI9Cf0eOJHh5KcpO5buoKP7vBKgPUw6hKG
 toq+eytf0BBfudOs7x1X/gn4BIzqm/KDba/Bywj8oZMEggEu20FuiCuNku5AJg6b1spBYDE5U/l
 SUzfYjwlGB+Inj+XAG8wmuxzKGKG8RZzEOxYlb3VOFgO40xcHCrVtZFc4TH1YmsSDbGbKxTvhwZ
 kKwRzJd+jedbWUY66AEAOtCvTbkwgkXXUfut91
X-Gm-Gg: ASbGnct3g2z7XRUuYxUIwaY1rHenS9wqY2Hpmr1olyBjufuA4EE1VM4R2M7EFBKs/ZN
 Fu0XmSc8mFdtRVpAC9We8yj6VFF2BHavawYWRCi0=
X-Received: by 2002:a17:90b:538e:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2f548f59a46mr8376981a91.21.1736419532684; 
 Thu, 09 Jan 2025 02:45:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFa791Zc+EWCjO9Wd3UZlSVpfTZeabjo+CCUmaeX/LhrF6rzunC0CbG6yyMvPsslQJYE2Nq7k5HAyhgVKm10ZA=
X-Received: by 2002:a17:90b:538e:b0:2ee:c4f2:a76d with SMTP id
 98e67ed59e1d1-2f548f59a46mr8376962a91.21.1736419532403; Thu, 09 Jan 2025
 02:45:32 -0800 (PST)
MIME-Version: 1.0
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
 <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
 <Z35wmODIV_vuYBOA@rei>
 <CAEemH2eHfJDLNhMwomZ5VHBSwqpUZsD9GuaMDRnpY_XdfPjEdA@mail.gmail.com>
 <Z39_3BKj3d3nbfau@rei.lan>
 <CAEemH2c0ur5W=ntte7mamqMSC_GtH4Lb3W=cob-h8OPMYU=o1w@mail.gmail.com>
 <CAEemH2epi7XZiPXP=NOQpV0rLpOT7dxt8eoadZg5RR3r5c=mwA@mail.gmail.com>
 <Z3-mSNc5YtTMYmM0@yuki.lan>
In-Reply-To: <Z3-mSNc5YtTMYmM0@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 18:45:20 +0800
X-Gm-Features: AbW1kvZ00ebO2fblBUVz1k6jSLXHrnrKVzxtES8f_-QYehfwwu7F7mylNtnvTOw
Message-ID: <CAEemH2cXo7_jrxafHH1VU4sNqkcX4U90fsOm12SxmubRzk9TvQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: l1dpKcLgmG50epFhJZWVqxMaNMENISWZahpN8KVFQis_1736419533
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gOSwgMjAyNSBhdCA2OjM14oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+ID4gVGhlIHJlYXNvbiBmb3IgY2FsbGluZyB0c3Rfc2V0
X3J1bnRpbWUoKSBpbiBlYWNoIGl0ZXJhdGlvbiBpcyB0aGF0IHdlCj4gY2FuCj4gPiA+IGRpcmVj
dGx5IHV0aWxpemUgdGhlIHJlYWwgZWxhcHNlZCB0aW1lIGFzIHJ1bnRpbWUgYW5kIGRvbid0IG5l
ZWQgdG8gZG8KPiA+ID4gYWRkaXRpb25hbCBtZWFzdXJlbWVudHMuCj4gPiA+Cj4gPgo+ID4gRm9y
Z290IHRvIHNheSwgdGhhdCBlYWNoIGl0ZXJhdGlvbiBoYXMgZm91ciBzdWItdGNhc2VzIHRvIGFj
Y29tcGxpc2guCj4gPiBUaGUgcmVjb21tZW5kZWQgd2F5ICh5b3UgZ2F2ZSBhYm92ZSkgaXMgdG8g
cmVnYXJkIHRoZW0gYXMgb25lCj4gPiBiaWcgdGVzdCBhbmQgcmVzZXQgdGltZW91dCBieSBoZWFy
dGJlYXQoKSBpbiB0c3RfdGVzdC0+dGNudC4gSWYgdGhpcwo+IHZhbHVlCj4gPiBpcyBiaWcgZW5v
dWdoLCB0aGF0J3MgZmluZS4gQnV0IEkgZmVhciB0aGF0IHZhbHVlIChjb21lIGZyb20gbWVhc3Vy
ZW1lbnQpCj4gPiBpcyBzdGlsbCBub3QgY292ZXJlZCBhbGwgc2l0dWF0aW9ucy4KPgo+IEkgYWdy
ZWUgdGhhdCB0aGUgdGVzdCBpcyBhIGJpdCB1bnByZWRpY3RhYmxlLCBhcyBpdCBzeW5jZXMgZmls
ZXN5dGVtIGFuZAo+IGRyb3BzIGNhY2hlcyB0d2ljZSBpbiBlYWNoIGl0ZXJhdGlvbi4gSG93ZXZl
ciB0aGUgLnRpbWVvdXQgaXMgYSBzYWZldHkKPiBtZWNoYW5pc20sIHNvIG5vdGhpbmcgc3RvcHMg
dXMgZm9yIG1ha2luZyBpdCA0eCBvciA4eCBvZiB0aGUgdXN1YWxsCj4gdGVzdCBleGVjdXRpb24g
dGltZSBvbiBzbG93ZXIgaGFyZHdhcmUuCj4KCk9rLCBJIHdpbGwgY29sbGVjdCBhIHByb3BlciB0
aW1lb3V0IHZhbHVlIG9uIG15IFJQaTQgYW5kCmdvIHdpdGggdGhlIHJlY29tbWVuZGF0aW9uIHdh
eS4KClRoZW4sIGxldCdzIHNlZSBob3cgaXQgZ29lcyBpbiB0aGUgZnV0dXJlLgoKCi0tIApSZWdh
cmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXgu
aXQvbGlzdGluZm8vbHRwCg==
