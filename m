Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20FB7CAC5A7
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 02:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1758594518; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mSoyiP3DBy9ypoQKTvlqCcx7dYcLsRByDR4CH3u+RYw=;
 b=QdifgLTy0WOyMSSWBCql7FgxOeTh6f18hiKypnAZAMdO1WtIqkuxbD5kSpouxSfEFyPHD
 93ZWyOCF42Sa0AJ1WrJKAneJ22/QOC3tGayjnnqj3FIRDMTJWHn/omXodF41swa3+kpoXHK
 z4cJZ2aggcMqZ9HhM5O8F0J7LxI4dR4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4598F3CDE78
	for <ltp@archiver.kernel.org>; Tue, 23 Sep 2025 04:28:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C4F23C2566
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 04:28:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C902600B2A
 for <ltp@lists.linux.it>; Tue, 23 Sep 2025 04:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758594496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WhDuVbJYxp20nc6Eho9UZu6hjWmwa3aZcAWW9LucoCc=;
 b=RGriGOo0NAlp5Glg7LhAKM4jo6TiNuMjCJ63wAeQO/hwxhYjNvq4iybNizbYDYKh3Dmaos
 7wvQkHMzuI+w8EHYVqVGRqpMuGFXfJ0xYAv6rBjrsSv5J/1kIUWMxqm41684n0hQYf+5rG
 0RoX2oZD0df88pLw3XP/9mLYJtMM+8Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-4I2BTvr_NiqKRy0Q32RBvQ-1; Mon, 22 Sep 2025 22:28:13 -0400
X-MC-Unique: 4I2BTvr_NiqKRy0Q32RBvQ-1
X-Mimecast-MFC-AGG-ID: 4I2BTvr_NiqKRy0Q32RBvQ_1758594493
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-24ae30bd2d0so45268055ad.3
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 19:28:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758594493; x=1759199293;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WhDuVbJYxp20nc6Eho9UZu6hjWmwa3aZcAWW9LucoCc=;
 b=enJepiiixTY7FJmdn+E8o6BjRFKHRJsG8CFS0smjlpw3N25q+m8R7KCc109Qojq1xz
 sYAEmpIVy0/drjSSEnQfUkkbQV/XMSqXTHKPNSaijloH+7qGz5vok85ZD6Kw0BkLFUKC
 MVI185bLiHXB/9CuW0CwRMiHc4nA9VrZA5mVA/KjGavhs/cV+3hC/euE0VQlSmEYg8ZJ
 oIFp9suwPIs6TUdKjn0dalAUdiRYTALUNUs86Nn2cIWFKZY6+p6oRwPxLiS1bySlIZQk
 f4lkm6zXBDXQTw9VXjUCSzQVhRSqXDVwlbUKwFHMCT4vn9hqdQxMvqa9szgRevVmtaMz
 rCpA==
X-Gm-Message-State: AOJu0YyzVn2UnBM5uLjGtQ5GbK6878nz9VxYuVrZFg7symnLlV/IyYFs
 LjoTdCm1uChJ+tbLavKEHWx22xeyb8Hn4A9dPkg7YM3yiW4IMIi7p1WKjCkf1xHnM5ns/1BJlu7
 IufWZl5++abDzt7NW5aXW6UEYi4aqzRRTvIbzIJ5AkQ0jyipHgfyHsbKjQZIy8lCcAGPi5tAqQH
 aTMG4Ml+2yTj+YGl+aYaDaRDgX2FM=
X-Gm-Gg: ASbGncsACugEwpq96vfKd5oO8zPN58J1Q/XCGJ2bZ+O7FNBMlIkb1eoemO0th0dBD7s
 qLwvsQdR20fmXnyILpiM+bPXxJZIjQfsn1h25It0L49RrAQ0c5I89o1HBZcwJhK6D55gRW0hBoE
 nkJSRVjBLehfF/zsw8r0tgvg==
X-Received: by 2002:a17:903:3550:b0:246:a543:199 with SMTP id
 d9443c01a7336-27cc836c35emr12375735ad.54.1758594492782; 
 Mon, 22 Sep 2025 19:28:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHE/hZUZYykakwQBUI6D0I0J/snYm+Jsu/FBHx1wFsEm2mA2VX5C8tKMxFwWmEcgg7FNIquKuaTAbpknmB0Qvg=
X-Received: by 2002:a17:903:3550:b0:246:a543:199 with SMTP id
 d9443c01a7336-27cc836c35emr12375455ad.54.1758594492230; Mon, 22 Sep 2025
 19:28:12 -0700 (PDT)
MIME-Version: 1.0
References: <aLVzVyaVhr4IHkyd@yuki.lan>
In-Reply-To: <aLVzVyaVhr4IHkyd@yuki.lan>
Date: Tue, 23 Sep 2025 10:28:00 +0800
X-Gm-Features: AS18NWDhOQIIvBHQ7m2AHVlIXNc_DZkStFHDEIB2LrDXBhUq6j2I3XTMRgzmHSc
Message-ID: <CAEemH2d_0eTYA+DtV5Dy16vTJ5s9a94mpKY6cp+Ofh2Ze1S68Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>, Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ykz8ilUxS2iFLj33MvLjV19wmbOOcN8YdqHIEbjg4Qs_1758594493
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] LTP Release preparations
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

Hi Cyril, Petr,

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> It's about the time we start to prepare for the September release. As
> usuall I will go over the patches in the patchwork in the next week or
> two. If there is something that you think should be part of the release,
> please point it out so that I can have a look ASAP.
>


LTP pre-release test looks good on our latest RHEL 9/10 series.
Just few minor errors that need the following two fix patches:

https://patchwork.ozlabs.org/project/ltp/patch/20250922203927.14552-1-akumar@suse.de/
https://patchwork.ozlabs.org/project/ltp/patch/20250917075729.30093-1-liwang@redhat.com/


Note:  Next week is our public holiday (7days), so I may not be able to
reply to emails in time.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
