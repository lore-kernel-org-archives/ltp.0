Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E65FDC4332F
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 01:59:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 555C23CBA7B
	for <ltp@archiver.kernel.org>; Wed, 21 Dec 2022 02:59:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A25203C2435
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 02:59:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 84B3F2003A8
 for <ltp@lists.linux.it>; Wed, 21 Dec 2022 02:59:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671587978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+0oXbbDmUJPFWn/NkRK+V++/PvQBIjWEJWcPrru693w=;
 b=K069fYxhHKCn7desgAozvKTbQjk6s7ivkXxgNSpPb6uaTtWbVse+ISnpv1mV+QiW+6s9u/
 YCGNSTTilfkxvLBnlMQ2yIoEFK8nQt1833VKaK+iir5lA4bA1uEUsejzvCtSDpk4txnnkB
 gS7uLERLCUEZmBNJkxAhnaKHZwL8mCI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-134-QaO9B54VN9elC55PeSy-8A-1; Tue, 20 Dec 2022 20:59:36 -0500
X-MC-Unique: QaO9B54VN9elC55PeSy-8A-1
Received: by mail-wm1-f70.google.com with SMTP id
 bg25-20020a05600c3c9900b003cf3ed7e27bso7293775wmb.4
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 17:59:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=+0oXbbDmUJPFWn/NkRK+V++/PvQBIjWEJWcPrru693w=;
 b=FeSJbiC2a+AWwdRnUROfLvi3rXphtVV9BnwjV1fHUNhhE/TvgSR7aPGhdi7LI3thPN
 Ni4i4W4fqo4a+ilMKqu1iWJUmBKkB7tIL75qCO8y5ay0ZOrhfivnOEjoePSZdD7oSl6o
 uh1z0JkSDdVVQkg7zi/IOO2VsTR+p7sPfglIcWy8oI+9Um2l/nEI/W91RrK89pAnlscB
 bP2IK6pUXzxPqxrd2g46kL5yzmSkoGCQSTRVlyJcdBoU070MdT+Vlz4mEFgYHiPYBY+3
 e8MIlZcl8YeDa4lNOwfkzLxN0CJRI6/lLZniOamygvZVUUqt6Le+DX489lSh+SDkp8WL
 dOUw==
X-Gm-Message-State: AFqh2kqLHMshu0VDPWMb9uZe1J0MJvfnQ/t//XI8Kp1yDGygcjuC26FG
 A0ZI54wpIlIESWZ1t6mwPMCoKvayJWCFqY0ZvEBj7uIHWD5M2jrDvgOotpDxEDj0ruswvG0LOS0
 b496AnIMAYcPjIbmEXw7Bih9mbj8=
X-Received: by 2002:a05:600c:3b9f:b0:3d1:f076:26d8 with SMTP id
 n31-20020a05600c3b9f00b003d1f07626d8mr13374wms.99.1671587975760; 
 Tue, 20 Dec 2022 17:59:35 -0800 (PST)
X-Google-Smtp-Source: AMrXdXvlriO9nBp7FRBIHuQ4ukqrbZqdPBznTv5Cc7gZEmu8gq4oXLy6lUialj5SzAI3w0bp8uOX91ONsgdfeGMLLiA=
X-Received: by 2002:a05:600c:3b9f:b0:3d1:f076:26d8 with SMTP id
 n31-20020a05600c3b9f00b003d1f07626d8mr13373wms.99.1671587975500; Tue, 20 Dec
 2022 17:59:35 -0800 (PST)
MIME-Version: 1.0
References: <20221220054549.1757270-1-liwang@redhat.com>
 <Y6HD05Aa9WmWyUhl@yuki>
In-Reply-To: <Y6HD05Aa9WmWyUhl@yuki>
From: Li Wang <liwang@redhat.com>
Date: Wed, 21 Dec 2022 09:59:24 +0800
Message-ID: <CAEemH2eCfzyTggCu9F0BEanen2aN=zzaB9f3WwMZB+3JDJMypw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] set_mempolicy01: cancel the limit of maximum
 runtime
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Dec 20, 2022 at 10:15 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > It needs more time for running on multiple numa nodes system.
> > Here propose to cancel the limit of max_runtime.
> >
> >   ========= test log on 16 nodes system =========
> >   ...
> >   set_mempolicy01.c:80: TPASS: child: Node 15 allocated 16
> >   tst_numa.c:25: TINFO: Node 0 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 1 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 2 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 3 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 4 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 5 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 6 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 7 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 8 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 9 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 10 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 11 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 12 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 13 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 14 allocated 0 pages
> >   tst_numa.c:25: TINFO: Node 15 allocated 16 pages
> >   set_mempolicy01.c:80: TPASS: parent: Node 15 allocated 16
> >
> >   Summary:
> >   passed   393210
> >   failed   0
> >   broken   0
> >   skipped  0
> >   warnings 0
> >
> >   real        6m15.147s
> >   user        0m33.641s
> >   sys 0m44.553s
>
> Can't we just set the default to 30 minutes or something large enough?
>

Yes, I thought about a fixed larger value before, but seems the test
time go increased extremely faster when the test matrix doubled.

I don't have a system with more than 32 nodes to check if 30mins
enough, so I guess probably canceling the limitation like what we
did for oom tests would make sense, that timeout value depends
on real system configurations.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
