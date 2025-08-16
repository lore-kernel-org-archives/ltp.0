Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB9B9CA0ED1
	for <ltp@archiver.kernel.org>; Sat, 16 Aug 2025 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755308347; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SeC0HRNXzzKO4CXrte4V8VFGTkPurLjVYqBPetsdSFw=;
 b=Ma73RPC1SV5/Z3qI3R96sv0pQgWYqiscixcrasSkzsAatGPD6dbqA4FBbouQJzeMQjyGl
 tab3/fLvFfrTdeIb1R7ih9GSSSEsIVr4DC8FuZRaskB6zEErS59VC5IjmJ8hyy12NOt2q8w
 3IxdCyvF65uIGydNR4bNIfZ+i9Fv7lw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 94E7D3CC251
	for <ltp@archiver.kernel.org>; Sat, 16 Aug 2025 03:39:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5070F3C23EC
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 03:38:44 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D3DF2003B5
 for <ltp@lists.linux.it>; Sat, 16 Aug 2025 03:38:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755308321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ee4tTGd8cl4NO0LXIEBka0wD6u+8xWDzQCJ5xZQbi+8=;
 b=H420KuIsJeLYnypAfuAPzEj2g9Jj92Z1h7gBsz3A/5TwTW/q9ghNcR+u60MBue6QJkaVrg
 5SDNq1mCxMZMJyMhpmeHrFZdwicmiS27AsPPQ4aKFAwZzpvjLXXU/5iQgMkJBp1KxKkt10
 uBD+RPEP4ZXLeDGWlwfetRF3PQ0zuaU=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-295-wod-N2YIMIuQ0hkI2XawKA-1; Fri, 15 Aug 2025 21:38:40 -0400
X-MC-Unique: wod-N2YIMIuQ0hkI2XawKA-1
X-Mimecast-MFC-AGG-ID: wod-N2YIMIuQ0hkI2XawKA_1755308319
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-244581950a1so27809875ad.2
 for <ltp@lists.linux.it>; Fri, 15 Aug 2025 18:38:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755308319; x=1755913119;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ee4tTGd8cl4NO0LXIEBka0wD6u+8xWDzQCJ5xZQbi+8=;
 b=AGnjvSGijkZRjZ2X40w5lZfJ+TPY8iDqhISR9tfr4ubK42vISvJEXokaQIkrddvKQT
 xrZDLOSqaqHhzqh8c62TGZNI7FNmleAj2Qft7embmL4CpERJ1xmn+KFKkJQt1kj+zhTU
 fkvrmGSRPXvJcxROEa2YRl6zj3/aSdUpWSr+H8HKsrvww2q94rEaTDuqgQjxBujgMhuM
 EpPNLH7IFtRqpkJFMO6MEB9j/dghskpW/WpTVTHCYxf3pvURFmDhQ+zmhSm+rTSMymDA
 WSgoOZtk7grWHrYrVTCSKGg0Sdkg0abK0b+0b/puQ1EfI8b/0lGup9nVJHrevmEdfboe
 iB2A==
X-Gm-Message-State: AOJu0YzffzTKBs2xpPni2c0qEJJupb8MYneKdzP0Astia7TXB707znhH
 6NOhSFkXycdI6osDBVjz1za3WPYGeDjDP1dzLHmS0PoDvQyss3YtKsgWp0joLS45sH/236Ue6iS
 ZYxFzllVRqZQhJaoySZd0XDhl4+/bx+wbnkyYgBd3qnu0leMEOOVUmxCphilBeEfQOCn4qXKG2u
 1RVQrWvP3n1SdpzAxCe2jeRv44MZw=
X-Gm-Gg: ASbGncuYMCQ4qSojP0Ksb3NJME/+YAWhQIHeVK/JIep0+PFm53h75eKFnSaq0pglLSr
 PNyFHlFCp3G7W5OJwk1ep+ZflVpg5F+o+5ENSuXI4hdyK3yn/cZQ5c9IzgZaP+JU4ICGFXUcKyy
 LD7EkSpyKUuT3fuUX5qOinqw==
X-Received: by 2002:a17:903:3bc6:b0:240:1f19:d35c with SMTP id
 d9443c01a7336-2446d8f0fc8mr61571285ad.39.1755308319079; 
 Fri, 15 Aug 2025 18:38:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH1k/RFtuk+q/5yhljE+JrY6fYsLUNZCsV6jzFQJq6FKyrsiYqgduGCIuHNBgm5p9Csrv5sy7txxq/nri0blZ4=
X-Received: by 2002:a17:903:3bc6:b0:240:1f19:d35c with SMTP id
 d9443c01a7336-2446d8f0fc8mr61570925ad.39.1755308318618; Fri, 15 Aug 2025
 18:38:38 -0700 (PDT)
MIME-Version: 1.0
References: <20250812141709.33540-1-liwang@redhat.com>
 <20250814130629.GA575710@pevik>
 <CAEemH2fgnJH201_fvDvPRbAFrfdEz4v_cEg-LXudWje-+w68VA@mail.gmail.com>
 <20250815052231.GA32490@pevik>
In-Reply-To: <20250815052231.GA32490@pevik>
Date: Sat, 16 Aug 2025 09:38:26 +0800
X-Gm-Features: Ac12FXxBmJX5WW8V4Xi53VUZdQRIsXWJz2HHEozyHKnf_8C_Fsf_GT11cdfgVbE
Message-ID: <CAEemH2fJO8a4cEZcdLkCGMjSRQSprs4ZLM+1930qVZaiu7TO_w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QElsA6gHLwHEOcVBzhzIyRQw3RecyXDX4LUYbmD_2wc_1755308319
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_mkfs: print short hint when mkfs fails in
 device busy
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
Cc: rafael.tinoco@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMTUsIDIwMjUgYXQgMToyMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBTbyB3aGF0IGFib3V0Ogo+Cj4gPiAgdHN0X3Jlc21fKGZpbGUsIGxp
bmVubywgVFdBUk4sCj4gPiAgICAgIm1rZnMgbWF5IGhhdmUgZmFpbGVkIGJlY2F1c2UgdGhlIGRl
dmljZSBpcyBidXN5IChlLmcuLCB1ZGlza3MyIHByb2JpbmcpLiAiCj4gPiAgICAgIkNvbnNpZGVy
IGRpc2FibGluZyBiYWNrZ3JvdW5kIHByb2Jpbmcgc2VydmljZXMuIik7CgpQYXRjaCBtZXJnZWQg
d2l0aCB0aGlzIHJlZmluZW1lbnQuCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
