Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76BEC30658
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 02:26:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA1DA3D1159
	for <ltp@archiver.kernel.org>; Wed, 26 Jun 2024 04:26:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 008E93CF09B
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 04:26:22 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 798571A0078A
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 04:26:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719368779;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wKOJL+BFL3pSgliVrqrje0sjwUJcWFgfME9TqZipDdQ=;
 b=HwAm21XeX1JHRPHDd9fJV9i/5+t7nLdI3Oek8GJiYm6ioIgSLSGNTs4CfMOE9wmjJOJqf0
 x/gB8fDxa5BQENejJ4LkQlMp0RAoEGIr7/CQL0120uYfShBYq+/2f+ErvpoMz09Gf3C3+8
 uUo1CVCuL6vSSkU2z/2s9UsuIYbUilc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-BjbujbyiNl2dUnFUVIsWUg-1; Tue, 25 Jun 2024 22:26:14 -0400
X-MC-Unique: BjbujbyiNl2dUnFUVIsWUg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c7a8949243so7689520a91.0
 for <ltp@lists.linux.it>; Tue, 25 Jun 2024 19:26:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719368773; x=1719973573;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wKOJL+BFL3pSgliVrqrje0sjwUJcWFgfME9TqZipDdQ=;
 b=DK5jj0bDcdLoRLEPoTOJ9Ao1iiVPWSwaFKLOSKwMpjFxxjzeMk/LtfgzF2mFNw/k7w
 5w4ZHqRVzQUwM0KKEdhTT7KnHLtDGT9riCBrM0ia/seOPWzG06O0kiuwgFJerlMw3XTu
 QmAy+p7lgEeqWvPOKoyQca+qvzmvbPaoMAcvxFtoKB1m6CmP6KdL9Kk5N/pxSrRwbigU
 opkuIOzp8YlCcE9OO3lt2H19XFibxX8nqOI/XMH0o1txmDSPtGwXPnRWO9uk2dnYH63Y
 lw9Co97cRN8FrN0/lpKz0h58X5f1uBq1dk+hV8MK6Br+VlSH3xLBJiXgrFfGMvajnPRG
 Tetw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVay2lF+cQ5pPuVitmdssS1UoO2wzt9Rz/24gWggALY62fnrFXOdWSFmXKdWwcAjZlBPV+Z8Im6fqPNJswVlwQmq/c=
X-Gm-Message-State: AOJu0Yzqpk7SIJdCh6ygwuGqwGMSXrMfnhIYxzEBM0h7Hcf9DOOnLD7X
 Js/vT64NyIfoYOw8y5mrr2z1ZXe6FPKT07q9kbCseHfaSCz+JA32mXYmiAk6FrG14B31VN5FLU9
 QSxS4VcGEQBrIX2n8ObWgSv6eVCsi3gWTU4NGE+gDLthHvm50dwcxhq+v1ciQMAwDabyGOZHTGM
 Z9zT07ono8EUieTCV2/k8dYis=
X-Received: by 2002:a17:90b:17d2:b0:2c7:a8ca:90fb with SMTP id
 98e67ed59e1d1-2c8613db271mr7998592a91.29.1719368773502; 
 Tue, 25 Jun 2024 19:26:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCQXWRCTKk+kiIabIiopMm4DZ5fhc+rqkeKFAqtf8QltdattS1Sg1dPI5dN8puEjIP6nU8VDWWYVNzdoC9eZU=
X-Received: by 2002:a17:90b:17d2:b0:2c7:a8ca:90fb with SMTP id
 98e67ed59e1d1-2c8613db271mr7998579a91.29.1719368773074; Tue, 25 Jun 2024
 19:26:13 -0700 (PDT)
MIME-Version: 1.0
References: <20240423225821.4003538-1-jstultz@google.com>
 <20240423225821.4003538-3-jstultz@google.com>
 <Zi9jL1jycx6oo37g@yuki>
 <CANDhNCq__ZY9w3Nse-+K+d9gyXhrOe_6oZ=X01x_HufZwQ_6ig@mail.gmail.com>
 <Zjn1-1YRyZGIUtEP@yuki> <ZnlORS6RGTAA4UhS@yuki>
 <CANDhNCqk-3o+Bu_c9PbqoxSacGQaGUrdTM5VDoZCOipEttXKLw@mail.gmail.com>
 <CAEemH2fT2NsoZfRvNrhRrstF=dhzF8Y90HqVQSCf1VxqpNHgEw@mail.gmail.com>
 <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
In-Reply-To: <CANDhNCr4-cE7_Uy86Pa3kjzFG_EOOB38C_mSGSfZtc=vd7L5yQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 26 Jun 2024 10:26:01 +0800
Message-ID: <CAEemH2cUj4U4Z=G437fduyQA6-UrnhE4b1_QtRB0kmPn5OMgAA@mail.gmail.com>
To: John Stultz <jstultz@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/6] sched_football: Use atomic for ball
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
Cc: Darren Hart <darren@os.amperecomputing.com>, kernel-team@android.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi John,

John Stultz <jstultz@google.com> wrote:

> Try this:
> >
> > # cd ltp dir/
> > # make autotools
> > #  ./configure
> > #  make -C testcases/realtime/
>
> Thank you! That does indeed work.
>
> > See:
> https://linux-test-project.readthedocs.io/en/latest/users/quick_start.html
>
> Should the old --with-realtime-testsuite option be removed then?
>

No, we need it.

When configuring LTP without the --with-realtime-testsuite option, it will
skip building the stuff under testcases/realtime/ by default.

Unless you build it manually like: make -C testcase/realtime/.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
