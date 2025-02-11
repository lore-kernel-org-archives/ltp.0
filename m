Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88A60C0219E
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 05:55:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E10833C9902
	for <ltp@archiver.kernel.org>; Tue, 11 Feb 2025 06:55:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5C383C2D4E
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 06:54:44 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id A8E7F600792
 for <ltp@lists.linux.it>; Tue, 11 Feb 2025 06:54:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739253280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6aztAXBWQiBsJ0RQkPVK/8198YxmsDg9pBpt+/atV2A=;
 b=Wls/NB9m6DR3SkM1X4tOxkFYq8akGt+1tXodQ0bWMhfK2+42gQdx6Kb41rzHQ4wE2JLJP7
 Kzx20NQ6ESvZFnkf4wvB/9KG6k0DlTaUpx9At4Seeyc1iNrIlU+Z2fKmRO/R9zbaEIvzjm
 Bwgk9wgj+5f7haIu+VX2ZvcUg9i/6Bs=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-YYr4pMbANaO7zDE5KGB4jg-1; Tue, 11 Feb 2025 00:54:38 -0500
X-MC-Unique: YYr4pMbANaO7zDE5KGB4jg-1
X-Mimecast-MFC-AGG-ID: YYr4pMbANaO7zDE5KGB4jg
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fa157b0fc7so9671911a91.2
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 21:54:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739253278; x=1739858078;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aztAXBWQiBsJ0RQkPVK/8198YxmsDg9pBpt+/atV2A=;
 b=L6pd6rRwZOqxWTRfdVTF3nhUlofa/NCL9sCfL6HEpLk8ybOHsKfrI5AXiRLlhxFvkH
 y8+21W7/IQpT19LLwkTyzpr4yhm4OFMiYbJ3VK2MUTc/eqTqfzhLqrZazLzI7r4JFGLp
 /Qfq+iDS+rudkUNhPtiTNrKLLawKv9AlTypeHfK+g1mk+JwoZACcyh5SjFeEjV65kxWq
 k4f9Kk8blsBPIvVsm/hc8Mt9xIzitmoqOajM1pQE4dZOQCyGbf0MqXD0z4R0tVwFJxDv
 c7LmWVpjF22GPpRAepuUF9MO9Cm8bOd7wcz4QVcQIaj85RA770S/ueEIrtAlGz37D86Z
 +xAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqXzjXh7gyssnyj+VAYR0pC5JU0wCORL5KItWVDQel/zX+V7dwNu3jiFsoYAiIrfp7hVg=@lists.linux.it
X-Gm-Message-State: AOJu0YzDZzfD9dS47UQlH6iA6EjSGR7/SAfsNQ0ZDstxE1Sl9PwXrj6N
 Dw9Q94HQiLZaRjRHadWULqkYcxYBdWZTpU5qmF/2kSCWY+D7ykeNVcbCYHJZc191kTO/Bwwe26z
 k7oooOUEhL5IoVT24GIbl1DBsO9xZ1/BJDcYzoNq/kRqUETRI6FSprl+VbRWL4kFXhs7SL4JcHY
 wqd2vjOhtfA4XNL9iMc7LsA2c=
X-Gm-Gg: ASbGncsJoaQegPvUZJXC7SJY5gueiAtqFkcaXsyIdf1Enl1yjczW+olVkuZSMs/eSoD
 ldK6OxxqYmfjK/kg8B0W6LNhi9Hhfs5Qy2NKd26ht6N5gnsLxB0SunklqSktzbkM=
X-Received: by 2002:a17:90b:19c9:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2fa243f2121mr21959274a91.32.1739253277812; 
 Mon, 10 Feb 2025 21:54:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKGGY790PTi6eiF34YVr8fa0bgrBz0LG4iydoc8Kz5DIegJ577IlxCLcepMQrAEmNmnwjPt0Rq0bvvjDwcwT4=
X-Received: by 2002:a17:90b:19c9:b0:2f1:30c8:6e75 with SMTP id
 98e67ed59e1d1-2fa243f2121mr21959256a91.32.1739253277551; Mon, 10 Feb 2025
 21:54:37 -0800 (PST)
MIME-Version: 1.0
References: <5a87594f-9066-4ee1-8bc7-5f9f2d71829a.jinguojie.jgj@alibaba-inc.com>
 <CA+B+MYSmAjFQTbt98AZj-CRFSWT-dMc-3dAd5mQ=S6rDEYq+Sw@mail.gmail.com>
 <CAEemH2eMPDjSf0ShgsQc-4=Pg5M_9z6HnUMJRDM8OONkydDndg@mail.gmail.com>
 <20250115121744.GA648257@pevik>
 <CAEemH2djpaSi4sTngsRhFpro3J2_vmhe84dW2vy9K_wS=eioeA@mail.gmail.com>
In-Reply-To: <CAEemH2djpaSi4sTngsRhFpro3J2_vmhe84dW2vy9K_wS=eioeA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 11 Feb 2025 13:54:25 +0800
X-Gm-Features: AWEUYZl3LdeBlOtP38808_LXtGaoy36i8vsc5OsqLcG4D3yuiHr5oCYyEdf-_Pc
Message-ID: <CAEemH2eSQODo-myMNVGx-wBE4azRK+iTjURF8pvTuCuc+u3CpQ@mail.gmail.com>
To: Jin Guojie <guojie.jin@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eG6gNOjO7crUyRrpxSeAjbK8gzRSiav6o0uqbEy0Hqs_1739253278
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3] memcg/memcontrol04: Fix judgment for
 recursive_protection
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
Cc: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Guojie,

Could have a look and send patch v4 based on the above comments?
I do want to merge this one for ltp Cgroup library :).

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
