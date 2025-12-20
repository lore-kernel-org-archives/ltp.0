Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A0A4E668A7
	for <ltp@archiver.kernel.org>; Sat, 20 Dec 2025 02:07:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766196443; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oHBHSC2RGjP56qnO56jJY4hzOssY7X1QJCS0sxe30Ws=;
 b=XGd950Ky+bnEzhvC6aZjjk9U449IwySTErzYG/TKl3ottYgurB4YN07ec5zdkjcbuu+cP
 V3sfbPuAsxTH09JFia8HU8KMiyd0BQjmAl3ZHg1VGmnbrsfUp4toyz6LQeXFpMTWKIUCOUY
 RpjCJYOZ+dobNdNRnqWkcWxb8UY0nco=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 022DF3CFF52
	for <ltp@archiver.kernel.org>; Sat, 20 Dec 2025 03:07:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 14C503CF07E
 for <ltp@lists.linux.it>; Sat, 20 Dec 2025 03:06:57 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9C6B31000D52
 for <ltp@lists.linux.it>; Sat, 20 Dec 2025 03:06:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766196409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iLUgPy2aKgQerlIDWas6Rl2K5ZbXiGbj5kvmJThDNlo=;
 b=LxNVPd8mGqkIS8GdoXBz/MFKvcQABEgN/jmTnCk5CjiTYHL63WT+1NXfYUTHSiPXBxr8jH
 knYDuuPzGMXPQ0+LNeeMocw4ile+J3T5yOubucP2zsKZlSZa0Yoas6l2EZ/smi2fHMAh6s
 6ax47R1cbBr99GgAqFCEMNUA2YPMifE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-VcJOkuPKPrC_Q9Xo6b2A-Q-1; Fri, 19 Dec 2025 21:06:47 -0500
X-MC-Unique: VcJOkuPKPrC_Q9Xo6b2A-Q-1
X-Mimecast-MFC-AGG-ID: VcJOkuPKPrC_Q9Xo6b2A-Q_1766196406
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b73586b1195so211748966b.3
 for <ltp@lists.linux.it>; Fri, 19 Dec 2025 18:06:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766196406; x=1766801206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iLUgPy2aKgQerlIDWas6Rl2K5ZbXiGbj5kvmJThDNlo=;
 b=kR6iynKQ5nxxD3/YZoEKWOnRCa+FoNfkM+AY7ykW4xD+q669WaySStqSp5EG4mv2YA
 x3UEf9FnDSns0hHMo1k3Gvh2RaYjJEhXC8XEl5H6a9C+t5PVLrBZx08WnWqk5KjQuOrf
 KubSiWommneffqbmoVsC3msf7RgaPGTKFhto0yIJaA17TIXmO7z0qQWGW3GCVul9B3/u
 1jOyiBKH3eedALU4c4UL1DVw84egVVVonm2h2z0pCRQCe7/LIvcySveG8jCLFlFUA9XM
 y6yIR6nBtuOu13uJlWj9v6S6h6uNV93EP/oFQyNqlJ8A9//LvxTusoo94FKYcXiNVSFE
 bJHQ==
X-Gm-Message-State: AOJu0YwzaC+QHwoDLRI8wTrF5mLkFu3hhcQo8rK2SLEZN7xGTERIKKyn
 PWSFIroR0asF8jIdoDt6rOo6xR24wz8Al99mzvawCak7ISbq/li2puswpXiaR0y4PaTA4ZJY+Jh
 30q5foJRY18retUyKBA9kWpuzZAG6l7AeOFwIu2zvdc7NC/IQL/NfJgrDDocd/da8QiUUllqD+D
 dwTBHh0HghfqpwG47yjqcCsYkmvbY=
X-Gm-Gg: AY/fxX7/t5uScvtGxbalggVASBOTi0k7FShlTxGM0kl+lAgAs7ln70xa3eY7n14Q7pg
 +9X2AItnCMAS/7TPHHSoInTDByexloJ9dSkiZ51hZhjaNrx8fkJhGOwkPgU3pBn8zg0sbX21rAr
 1vL1FC7Epw2nj1hkLiW9yr7SyNdxg9x5jY2nRXj6/gz3dn8w/+id01uefC9NdI0/J0Zo4=
X-Received: by 2002:a17:907:3f28:b0:b7a:1bde:a01d with SMTP id
 a640c23a62f3a-b8037228e19mr446885066b.65.1766196406129; 
 Fri, 19 Dec 2025 18:06:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFEDwKBOb3h4gRW30yhGU1J0fhm0WZ1IOuFhLzym7+hlPR8LiGv0vbCQ3ltxHRWpsIPDetA7QxLsmzMCtDsk08=
X-Received: by 2002:a17:907:3f28:b0:b7a:1bde:a01d with SMTP id
 a640c23a62f3a-b8037228e19mr446883766b.65.1766196405777; Fri, 19 Dec 2025
 18:06:45 -0800 (PST)
MIME-Version: 1.0
References: <20251126073521.159834-1-liwang@redhat.com>
 <aUVjZh2ho98yMhid@yuki.lan>
In-Reply-To: <aUVjZh2ho98yMhid@yuki.lan>
Date: Sat, 20 Dec 2025 10:06:30 +0800
X-Gm-Features: AQt7F2phrELBAHXqkymwxgo8mKV_JC_fWBSuBGWY60Xwt5uA-wJXKCLSeZBB_eQ
Message-ID: <CAEemH2fPQYVezFtq=T-agVARtj_k_9Fv+QADS1HPMX8gd-zewQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4KrdmAuN08OAvEIxXmV7f4UG09_Z9FWTg7c_L9KN6mQ_1766196406
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH] readahead02: detect cache stats via mincore
 per testfile
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

Cyril Hrubis <chrubis@suse.cz> wrote:


> > +     fd = SAFE_OPEN(path, O_RDONLY);
> > +
> > +     pagecnt = (length + pagesize - 1) / pagesize;
>
> We have LTP_ALIGN() macro, maybe we should use that one instead.
>

Yes.


> Otherwise: Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Patch merge (using LTP_ALIGN()). Thanks!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
