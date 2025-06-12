Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 091E9C71136
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 01:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749693187; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=axsBv09T8M5IXnSay0avyPQRQNXLiiAFWn2E8OFOAEM=;
 b=NVB60bu0uyoP5/2m1kX3IOUSkVL3XWIhXJn6W17k5a52ShzdBugVPr2QwDCZ72+3v40Ie
 TXt5i0ODpTaQYiGCKZf9gQNKaQWqMiuNYYPHrFOcflZFGFvGJmQu9hKkZ0q+c2wqm2mp4MP
 PcFmEykH5yYGQ92RsOPeD/0zOjmDTR8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEB813CB2CF
	for <ltp@archiver.kernel.org>; Thu, 12 Jun 2025 03:53:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABCC93C8A7F
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 03:52:47 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5DEE01A004D3
 for <ltp@lists.linux.it>; Thu, 12 Jun 2025 03:52:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749693161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9po71QMpxPWdwdxVSa5jJNl7sEswja3gJtDCZvxDRIY=;
 b=WWE/v71hTMtlBvSuVy4UFUDc+Yzp0PvyBElKtqJsD6yqWNozCAXPrOzqe3bkYQtdwRhM4I
 0UVpCRrYER0L0cydfn3vX+Av30ByK3u8okZ7W6/mvVuUbbxBDkFnnKg0+Y9/Xa5AOvU3QX
 M+9pQT6kUvP7s/G478SFJl2sGReeFfU=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-lz1qUzfxNhe1PO2POdDq_g-1; Wed, 11 Jun 2025 21:52:39 -0400
X-MC-Unique: lz1qUzfxNhe1PO2POdDq_g-1
X-Mimecast-MFC-AGG-ID: lz1qUzfxNhe1PO2POdDq_g_1749693158
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-3132e7266d3so487862a91.2
 for <ltp@lists.linux.it>; Wed, 11 Jun 2025 18:52:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749693158; x=1750297958;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9po71QMpxPWdwdxVSa5jJNl7sEswja3gJtDCZvxDRIY=;
 b=n5mK3qqNmggdygYDH2OsjjIAUTVMLLp3/bn9//xE7C+BSKvadOj/zSr+/jSyH9zvgL
 wqr+Oi5LIl/wUquTVgrBzKWhkXv7z/xou0IKYDWai1ERAvR+xv5riN7EZQJXXYz5EQW+
 AaUbpDh8D8zjzPEyo5SNLMT8DFOrDuAwL5imaPSW4OEKegWbUAcgq+jSjx9C/kNhAxs7
 Q83JmN5nEZyzJvCERo7xY9cVBBkcJEqNdtMFHt+55lq9nPz3KRY1tcUSHS1TX10zOlua
 5u5hLvOjY5pS4O5g63G2Hn4TaKCrF+Ldtmk4RqDIvPAVjjlkQ0P8PnNxvHu2XPZYVzMe
 BqAQ==
X-Gm-Message-State: AOJu0YxrQW/L+sMnKXoA3ul4j99UfM8zXwXJe7BnP/Ti9xVWmVOcI3TS
 yVjf4FXYQeDoCZHoiZ4R+5M0LtoFWzgzT9r1F2oSeCwQyjsMuiWZ4+d6pLQOz+uqP9aKg6/qre6
 WOqlxc3AIO/ZiRNDIBa1WlVlqs/kLyEGZFSO9msYC25oMNt5EbRK9yHNd2DW/3s/zENThBwzEYR
 U+Dd9RYlzDQiVuI3ojzE/8FedL5XA=
X-Gm-Gg: ASbGncv04Dbe8grU5RX72onLIAd2VCF84U0cgj32wFDz7pgJ4NrFz9+ZY16UO2nPLMS
 +9i3+eqhjL4zmnMUNWReWBxdtsiZ3ljly9Cb8sPwSwnSlAzw9Z+dSok/ZQR1xbOInE+AnEPZuf+
 HMAKNC
X-Received: by 2002:a17:90a:fd0c:b0:312:639:a058 with SMTP id
 98e67ed59e1d1-313c08d2882mr1377034a91.27.1749693158102; 
 Wed, 11 Jun 2025 18:52:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEusftLGyDMpcEYAynp2lV5Fe0KWK2q+nICWhTC7/upJ0RQbY9E+9R3aUaVrwDOIBSl43qQAHtS7pQuRJoUcjA=
X-Received: by 2002:a17:90a:fd0c:b0:312:639:a058 with SMTP id
 98e67ed59e1d1-313c08d2882mr1377001a91.27.1749693157538; Wed, 11 Jun 2025
 18:52:37 -0700 (PDT)
MIME-Version: 1.0
References: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
In-Reply-To: <20250611-conversions-kill-v1-1-a5d7312df7fe@suse.com>
Date: Thu, 12 Jun 2025 09:52:24 +0800
X-Gm-Features: AX0GCFthZF5oQgzyqhSpZm-mi-pV5zE7Gq4Pz5vUqt9gXyBywabc9gRqA8LUNsQ
Message-ID: <CAEemH2d1JwuFBVVTLTji172qZHss0AgK6n6-uEH1v+Xz_P7P-Q@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -SjYB8OBUOqGhNEuNHFWfV6cZBx_VqdJe4lsCM4XeAo_1749693158
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] syscalls: kill: Remove kill07
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

UmljYXJkbyBCLiBNYXJsacOocmUgdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToK
CkZyb206IFJpY2FyZG8gQi4gTWFybGnDqHJlIDxyYm1Ac3VzZS5jb20+Cj4KPiBUaGUgdGVzdCBj
YXNlIGRlc2NyaXB0aW9uIHJlYWRzOgo+Cj4gIlRlc3QgY2FzZSB0byBjaGVjayB0aGF0IFNJR0tJ
TEwgY2FuIG5vdCBiZSBjYXVnaHQuIgo+Cj4gSXQgbWFrZXMgdXNlIG9mIHNpZ2FjdGlvbigpIHRv
IHNldCB1cCBhIGhhbmRsZXIgZm9yIFNJR0tJTEwsIGJ1dAo+IGFjY29yZGluZyB0byBpdHMgbWFu
dWFsIHBhZ2U6Cj4KPiAiRUlOVkFMIEFuIGludmFsaWQgc2lnbmFsIHdhcyBzcGVjaWZpZWQuICBU
aGlzIHdpbGwgYWxzbyBiZSBnZW5lcmF0ZWQgaWYgYW4KPiBhdHRlbXB0IGlzIG1hZGUgdG8gY2hh
bmdlIHRoZSBhY3Rpb24gZm9yIFNJR0tJTEwgb3IgU0lHU1RPUCwgd2hpY2ggY2Fubm90Cj4gYmUg
Y2F1Z2h0IG9yIGlnbm9yZWQuIgo+CgpPciBjb3VsZCB3ZSByZWZhY3RvciBraWxsMDcgdG8gdmFs
aWRhdGUgdGhlIEVJTlZBTCB3aGVuIGNoYW5naW5nIGFjdGlvbiBvbgpTSUdLSUxML1NJR1NUT1A/
CgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9s
aXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
