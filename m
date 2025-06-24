Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 272FBC77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 07:53:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750751592; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=15TGw4eVuot4lYgOr0DOI8fRwMwPzOoHgEdZkmh1dBY=;
 b=JLOI3wsASHf63LBqGN/crr5MrpG6zbc0+WxAEsHlIEnY/bkiTxyK8v44U6QVSl/7fELZg
 8UQZ9Z7OkHL1cUX03KdaJDrDUbUXBEHSXoZhbOupgwsx2ExTPxH8S7d0rkjCA2PhNAMX1lN
 hC5ihtbr+V1KkV3Lu9JaCwvKe7x7EAI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FE813CCA98
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 09:53:12 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C8453CA1EF
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 09:52:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 844E760043C
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 09:52:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750751568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=11ICvBxPCMFpFaYnTzauI17XQVwE5qGQAVVbRkdH4YA=;
 b=iz57yz/sSsPNqUpSniPPGk/PS26l9fFjJx7FLNoJgVr8StXbaepxJyFzgDNN3G2lLoeFLr
 xTQGLUEfjATpnC8ki2ZLsUQVG1iw9epAvBWRIX16fl6bx/sMulBkultSrIRiVdYV/NKJIg
 mUeMuiAPWSqJv24QNFkh99UN9mErbG4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-y9dQTcJhMNeO7BjocUxahw-1; Tue, 24 Jun 2025 03:52:45 -0400
X-MC-Unique: y9dQTcJhMNeO7BjocUxahw-1
X-Mimecast-MFC-AGG-ID: y9dQTcJhMNeO7BjocUxahw_1750751565
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313ff01d2a6so202679a91.3
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 00:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750751563; x=1751356363;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=11ICvBxPCMFpFaYnTzauI17XQVwE5qGQAVVbRkdH4YA=;
 b=fXTvrGQLTbNi2sLy8qIWMTUqypsvrn3CnlurXfJAe8iBYW+6MfVG812lAFisluMk3p
 +OfDwlEJooJ3Q7+AD6XVJ5o/6F0J8GBbShqB9MCS9opTRm5SAHcs2PACO/VxjfyGcQka
 wqt03Lh2JCsg7MLvGG4FugiWOrXul5TMXs4zkdhMzR8LXmXrqXU6C9Jy0xN8jwUI2tRd
 kiHNfRc6Y4Ti2NjhveRuh1x8rqShOWiL31vMUgBmWAqYdUh3P+3EQm1XKlAb7B793gI9
 mhY35KSVuO0O7FLxXDC5j/fFGnb1vjzVU5pPDrcmshJRS0ihBgvUeb7EGv8EQHjReL1p
 ZFQg==
X-Gm-Message-State: AOJu0YzhuAc0Iclwv7LYQgJrYlK4M1OMq4ZeGf0g2DUbAhO9gcjDPhGO
 ywgqkCpnTL0vgq2CxWoLh2em6TgdVI9i13EqTgFmO0fgRvgoFgymYTPd3RBx9S23EXi0jvtq9DJ
 iT+v7T54Ib5Sx0cveEYAC31dAq17UFr/kJ0vWgXZ9fUPbifL7QKTxpVjRxbeAY7PJoJYr5VxfcR
 GIo42bjCii0ASM48Vt1SEmbDmrlhkBRflpStn32A==
X-Gm-Gg: ASbGnculddj0PciuNkPXX/mK9oYtAGTJe6kfrFj2T3i6l8yGZkSXOyVQU2hKBqpwcZ4
 n84F8BgR2JjpgQsHf/BjJvaPLVbLILU0WwQrM0//WzYVCVdDzwad8o/K5HqIn0gXM1kcgO4uQU9
 lfnhoq
X-Received: by 2002:a17:90b:5826:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-3159d64e390mr24140163a91.11.1750751563120; 
 Tue, 24 Jun 2025 00:52:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcH86p5waCTHysDJF8vOFOLpuz8ROyFPoXiMpWYrHqRS+uxAUyW1C9W1cUbiKRioSkESmJCt2GkI5rCYwVNUw=
X-Received: by 2002:a17:90b:5826:b0:311:afd1:745b with SMTP id
 98e67ed59e1d1-3159d64e390mr24140134a91.11.1750751562774; Tue, 24 Jun 2025
 00:52:42 -0700 (PDT)
MIME-Version: 1.0
References: <20250623140210.32347-1-liwang@redhat.com>
 <aFrxBElBT0jg6IOy@MiWiFi-CR6608-srv>
In-Reply-To: <aFrxBElBT0jg6IOy@MiWiFi-CR6608-srv>
Date: Tue, 24 Jun 2025 15:52:31 +0800
X-Gm-Features: Ac12FXyisMmK-G804epBI4ufkFUM4GyektNNCTevOgbbNaL8k-jR_HpDp7QrDsk
Message-ID: <CAEemH2ctXX_-xs3UPu4wCikok-b7qq747wgTBoer8q6+vELzXw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WA7P-YXKtirdB_qwX0UfWZQolPP0nf69QRpaa_BE7uI_1750751565
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Wei Gao <wegao@suse.com> wrote:


> > + * @min_runtime: Optional lower bound (in seconds) applied after
> runtime is
> > + *           scaled by LTP_RUNTIME_MUL. If the scaled runtime is smaller
> > + *           than this value, it will be clamped up to min_runtime.
> > + *           This is useful for tests that require a minimum execution
> > + *           time to gather sufficient samples or trigger events (e.g.,
> > + *           probabilistic or fuzzy synchronization tests).
> > + *           If not set, a default minimum of 1 second is enforced.
> Base your logic once .min_runtime is set then .runtime value effectively
> becomes irrelevant.
> So i guess we need mention it in above description?
>

Yes, combined with Martin's comment, we should at least ensure that
.runtime is not overwritten when it exists.

+       if (tst_test->min_runtime && !tst_test->runtime)
+               tst_test->runtime = tst_test->min_runtime;


Also, I make the .min_runtime uses the value of .runtime (then
remove .runtime) for those fuzzy_sync tests, that have a large
'pair.min_smaples' value.

But the default 1024 min_samples I still have no idea how long
the .min_runtime needs. Maybe we can estimate and set .min_runtime
on a slow system manually.

For others, which do not have strict requirements on execution
time, we only need to set .runtime.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
