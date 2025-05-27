Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B45EAC54F30
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 05:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748324501; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IOLW18jvxIvnwhRTCyyP0jJyDSZLoUtV5ZkyVFZFMwQ=;
 b=SL5Lp7y8ErnixCrnjzkcdXT2Vmh8TcXRZjjvpziYluykdZyNjyFzNGKbJO9gd5APRTfV9
 VZsRYU5vUemQzfDCaiqxGFjRK9N5GoEh8wjYMTx7T0Cc3W/20TlDliQ7He2F6nw9mbabxGN
 wEFF7KWDO7pKu0hU55DT+V1ib+SqUqw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2495A3C4D49
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 07:41:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CB733C053B
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:41:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C3415600847
 for <ltp@lists.linux.it>; Tue, 27 May 2025 07:41:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748324476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f6GyiLphCLQ5rKD1vvdNnaqtFQtn++FZMNcf99vxPMI=;
 b=B1+Jm7aRHtrcn2YPlG/zl3T7Vob3iAd7/CFBNHJ3xpTb6hc/PlDNmgaf8V7fvlG2hvfJTS
 AdzAs0DbaN6Bl4CSjisQoaghsqwwhP3XNm7oiQ3ZWuUhb5JnHl7Me4XjIQefUM1m4lg2nY
 DNhSvYVOLO8ZDO4opBBX/34U5E7ce9I=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-1w5gmcWyP1uL0-mzCmcmxA-1; Tue, 27 May 2025 01:41:15 -0400
X-MC-Unique: 1w5gmcWyP1uL0-mzCmcmxA-1
X-Mimecast-MFC-AGG-ID: 1w5gmcWyP1uL0-mzCmcmxA_1748324474
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-310efb64693so2830508a91.0
 for <ltp@lists.linux.it>; Mon, 26 May 2025 22:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748324473; x=1748929273;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f6GyiLphCLQ5rKD1vvdNnaqtFQtn++FZMNcf99vxPMI=;
 b=aluTJN2tr9s/4kXYOqij3NWyWfMdnvo7b3mTJaeTSykyQFdHr/JtLZ9QEAutj5i+Ev
 TS83MNeos5Xi9XxsUN/9/o37KLJFwYHMJKgpbC+6YLeHR/ikZ+0kKKneL2T2quw/hcEw
 /OSAOXHkk5QHIFA2F+elsFlcNDmnCNVVEthIL+e5F7sFi7npURMN+br2ppvtG6KT6Sjd
 opMhqP6/wMz+CNnURBYtAB4IZCjoER3vVJCYZ3EaHBJxHHCksoIkngEkSYoRGEAxfzGT
 4kPZmC5IMGtFrpGyJClrMLSh2/+UG5azuCi/g/STGZO2LV2v/UQsErKlqr6Op9c8aB4H
 VDgQ==
X-Gm-Message-State: AOJu0Yxw6J2A9xzhOdlyIht/ggnkYQRj5Q0Lb4Fe5ChdgLLPg9PfoJcR
 38qgBxF4pfIcY68eUgoYu0iSRpjB05J+CkNnj5v5F2phzCnuJhTf2drtQTHI/XDE9/svE7bmMww
 88qgTEwHzTLS7mFwAhEjhQtQTI7xBi9caqPJaUFPJ0bSV13QrcsX8ZY3wdRYfz0F3wYwITCCmkO
 6C92RXfDi7OX1mSLHVPJ3OiYyhKLZ63sqSOrVhfw==
X-Gm-Gg: ASbGncvRa1n75Ie6A6wEijL+Y5WV+0xCVkt++Fev2+p05nHEuiy2KLsnzx+P/ZdKqEG
 fOqvVLdrnE3UCRQcBcZY+VSipHgItf0cZnYTrYzagM+vhVRuLeju0DBmYSlksN8x8t0Dghg==
X-Received: by 2002:a17:90b:3143:b0:310:8d4a:a26c with SMTP id
 98e67ed59e1d1-3110f30daf0mr19547019a91.18.1748324473116; 
 Mon, 26 May 2025 22:41:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE1J8i5y2VZWQxgxd4I174/KsQx61DgXL2fXdXkK5zoyA8CvNkg7uyJFHGXt1ZAV8M4O/P5hntdf/eygLJbXHE=
X-Received: by 2002:a17:90b:3143:b0:310:8d4a:a26c with SMTP id
 98e67ed59e1d1-3110f30daf0mr19546998a91.18.1748324472834; Mon, 26 May 2025
 22:41:12 -0700 (PDT)
MIME-Version: 1.0
References: <aBSURzY2zu2HGI2x@yuki.lan> <20250507175707.GC182617@pevik>
In-Reply-To: <20250507175707.GC182617@pevik>
Date: Tue, 27 May 2025 13:41:01 +0800
X-Gm-Features: AX0GCFsAPFjD_gQJiUoscZtbfzPrp6kYyJQ-qEd0xQtoZyi2IyPqE4-LSQe0YW0
Message-ID: <CAEemH2cYmWZDAXHAR9zBTYiX1JcN69Jvj2Je3vHE427xx-ipkw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: V-tbFaeUmZaezifYW9j32orwuAMZAeR99uevqIvaDtk_1748324474
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP release preparations
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

Petr Vorel <pvorel@suse.cz> wrote:

> > Hi!
> > As usuall we are going to produce a release at the end of the May, let's
> > start with pointing out patches that should be reviewed before we freeze
> > the git. If there is anything I should have a look on please let me
> > know.
>
> It'd be nice also this macros doc related patchset merged:
>
> https://patchwork.ozlabs.org/project/ltp/list/?series=439525&state=*

I completed my pre-release test on both RHEL 9 and 10, everything looks good.

Btw, I hope we can get this merge:
https://patchwork.ozlabs.org/project/ltp/patch/20250520202429.577890-1-luizcap@redhat.com/


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
