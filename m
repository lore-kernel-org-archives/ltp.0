Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D328AD59D98
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 11:00:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A92633DB0E0
	for <ltp@archiver.kernel.org>; Tue, 26 Nov 2024 12:00:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 673933DB09F
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 11:59:47 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 847126190C1
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 11:59:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732618784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FiUa9AAtuV167qOPeJpZnWlx9xLodqKzJjP8/09+tk=;
 b=c/7DEzsJdQftz00RObIvOaOPQATJAzW9YRYtWuqpMxXbBQvOfQ+W51WLM+dPG4Jb3xidqg
 WM8gJYPNeQM1zTeK05CuD6/h+bZMomVn2N5/KVCWWxFlDePE1gts3auSc7O1rilE1Yd6JR
 e7IiqYP2wK5UOj22HSAw1z/dQQ3njws=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-250-8oseJjuOM7iKE4GU_dq08w-1; Tue, 26 Nov 2024 05:59:42 -0500
X-MC-Unique: 8oseJjuOM7iKE4GU_dq08w-1
X-Mimecast-MFC-AGG-ID: 8oseJjuOM7iKE4GU_dq08w
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ea28fcaad8so5429052a91.3
 for <ltp@lists.linux.it>; Tue, 26 Nov 2024 02:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732618781; x=1733223581;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6FiUa9AAtuV167qOPeJpZnWlx9xLodqKzJjP8/09+tk=;
 b=j4zIV0tG6xzzb1zrezqcL+6xqoJ4davn8XKIx98sHmQg6shZczczyWkSGngZnSZxVl
 Tiu/5sfLD2qV0k1ISbaokRSI+sNBbGXD5sCluuBAt590KOmH1VBNsL/qIBOxs2eQn7tP
 SkicjK6nWxD2ZiCHLxPjicTjm8ehFw8LDiPh85SB0xEictOF7Rw85nbwzqe1IU3+vhFq
 fCxlNcShspjlmRpiXROhHa/KawakTKt4x6gFWotnZLIGXR2EP64x7rSX0p2ubNH8XJQ+
 PBbP+ALgMGTw4hS8fZug7jXw7FP2Xsn6FZi/PUN8FVsPFHkAurCX+3RFaPazkMRNFapQ
 cJpg==
X-Gm-Message-State: AOJu0YxcrJjeZafmiw3tnYtywaB/aK1N6qA1SZPAEa6v+28/WI7iWyXg
 4f34Tn0iIz8sRGHx25fJY+E56TFqM/uXvrjskHlHOSh7wh8TZOHe641nQpl2V1SxH84J06egydK
 tjapu/R1zsa7kSBOdVuUKrIElgO9gDWDDc4wuA7bxwP4gx8SMoHCnbNgMYrOClK/DOdflMr7cPl
 ZyKigMosZdP9fe2jLO9KJ/PgM=
X-Gm-Gg: ASbGncsFcSLSq75pnPxWv4QhvVbTclv/YGTEnPuLko7hBB/o8tsoKlciSQTStvxTvAl
 ruE7i2O/18Z1cPnvqGTTUoUnrCqHGdC6c
X-Received: by 2002:a17:90b:4c45:b0:2ea:aa30:5ee3 with SMTP id
 98e67ed59e1d1-2eb0e024c46mr21047762a91.2.1732618781328; 
 Tue, 26 Nov 2024 02:59:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHtFkkXihKzF+CL3AzaeD6LAgquvhJ38TTxEs0LP4dt1pgQGJ0c/xyNfXnNBmy+9uLdMCixCpaCL5A9sgOb0Go=
X-Received: by 2002:a17:90b:4c45:b0:2ea:aa30:5ee3 with SMTP id
 98e67ed59e1d1-2eb0e024c46mr21047747a91.2.1732618780950; Tue, 26 Nov 2024
 02:59:40 -0800 (PST)
MIME-Version: 1.0
References: <20241126100445.17133-1-liwang@redhat.com>
 <Z0WitZsMZat6wdA2@yuki.lan>
In-Reply-To: <Z0WitZsMZat6wdA2@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Tue, 26 Nov 2024 18:59:28 +0800
Message-ID: <CAEemH2cpYA28nknKOhNV0D4q8G+xPw6EuvScMHbgOO3jpRPv7w@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ei8zFilfzjW183AXlzFT_qpXK5KRa485qsbsybmAAMw_1732618781
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] starvation: set a baseline for maximum runtime
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
Cc: Philip Auld <pauld@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBOb3YgMjYsIDIwMjQgYXQgNjoyOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUaGUgY29tbWl0IGVjMTRmNDU3MiAoInNjaGVkOiBz
dGFydmF0aW9uOiBBdXRvY2FsbGlicmF0ZSB0aGUgdGltZW91dCIpCj4gPiBpbnRyb2R1Y2VkIGEg
cnVudGltZSBjYWxpYnJhdGlvbiBtZWNoYW5pc20gdG8gZHluYW1pY2FsbHkgYWRqdXN0IHRlc3QK
PiA+IHRpbWVvdXRzIGJhc2VkIG9uIENQVSBzcGVlZC4KPiA+Cj4gPiBXaGlsZSB0aGlzIHdvcmtz
IHdlbGwgZm9yIHNsb3dlciBzeXN0ZW1zIGxpa2UgbWljcm9jb250cm9sbGVycyBvciBBUk0KPiA+
IGJvYXJkcywgaXQgc3RydWdnbGVzIHRvIGRldGVybWluZSBhcHByb3ByaWF0ZSBydW50aW1lcyBm
b3IgbW9kZXJuIENQVXMsCj4gPiBlc3BlY2lhbGx5IHdoZW4gZGVidWdnaW5nIGtlcm5lbHMgd2l0
aCBzaWduaWZpY2FudCBvdmVyaGVhZC4KPgo+IFdvdWxkbid0IGl0IGJlIGJldHRlciB0byBlaXRo
ZXIgc2tpcCB0aGUgdGVzdCBvbiBrZXJuZWxzIHdpdGggZGVidWdpbmcKPiBjb25maW5nIG9wdGlv
bnMgb24/IE9yIG11bHRpcGx5IHRoZSB0aW1lb3V0IHdlIGdvdCBmcm9tIHRoZSBjYWxsaWJyYXRp
b24KPiB3aGVuIHdlIGRldGVjdCBhIGRlYnVnZ2luZyBrZXJuZWw/Cj4KCldlbGwsIHdlIGhhdmUg
bm90IGFjaGlldmVkIGEgcmVsaWFibGUgd2F5IHRvIGRldGVjdCBkZWJ1ZyBrZXJuZWxzIGluIExU
UC4KV2hpbGUgSSBsb29raW5nIGF0IG91ciBSSEVMOSBrZXJuZWwgY29uZmlnIGZpbGUuIFRoZSBn
ZW5lcmFsIGtlcm5lbCBhbHNvCmVuYWJsZXMgdGhpbmdzIGxpa2UgIkNPTkZJR19ERUJVR19LRVJO
RUw9eSIuCgojIHVuYW1lIC1yCjUuMTQuMC01MzMuZWw5Lng4Nl82NAoKIyBncmVwIENPTkZJR19E
RUJVR19LRVJORUwgL2Jvb3QvY29uZmlnLTUuMTQuMC01MzMuZWw5Lng4Nl82NApDT05GSUdfREVC
VUdfS0VSTkVMPXkKCgoKPiBUaGUgcHJvYmxlbSBpcyB0aGF0IGFueSBudW1iZXIgd2UgcHV0IHRo
ZXJlIHdpbGwgbm90IGJlIGNvcnJlY3QgaW4gYSBmZXcKPiB5ZWFycyBhcyBDUFUgYW5kIFJBTSBz
cGVlZCBpbmNyZWFzZSBhbmQgdGhlIHRlc3Qgd2lsbCBiZSBlZmZlY3RpdmVseQo+IGRvaW5nIG5v
dGhpbmcgYmVjYXVzZSB0aGUgZGVmYXVsdCB3ZSBwdXQgdGhlcmUgd2lsbCBjb3ZlciBrZXJuZWxz
IHRoYXQKPiBhcmUgb3Zlcmx5IHNsb3cgb24gYSBmdXR1cmUgaGFyZHdhcmUuCj4KClNvdW5kcyBy
ZWFzb25hYmxlLiBUaGUgaGFyZGNvZGUgYmFzZWxpbmUgdGltZSBpcyBub3QgYSB3aXNlIG1ldGhv
ZCwKSXQgaXMgc3RpbGwgcG9zc2libGUgbm90IHRvIHNhdGlzZnkgc29tZSBzbG93ZXIgYm9hcmRz
IG9yIG5ldyBwcm9jZXNzb3JzLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
