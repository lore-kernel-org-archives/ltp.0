Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42DE6C54E58
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 02:54:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28EF43CFB9C
	for <ltp@archiver.kernel.org>; Mon, 25 Mar 2024 03:54:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E2DA3CB23F
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 03:53:52 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CAC4B1A002D4
 for <ltp@lists.linux.it>; Mon, 25 Mar 2024 03:53:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711335230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S9TT8UXLgtdn3gVqZ0sXoyaiHgKYBRVVqUwMHKlGX6M=;
 b=OUGz7BwIA3mYlN3nVaBASE8Uhl9b8/3o4Kt5l2vTtCvioJMvg/d0G4EmBiZwbZeUPJWi8J
 5hPx295iSeRSyoxGA0h29SVmwiHKFZ73K9IB9lTSgnMeNZlWwDQUYznL/K8NE8V3cDnU/V
 zMx2CoK4igmCSAwdEm3cLR2+2DjheZU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-472-CXGBZcLTMbqVVyHduMehaw-1; Sun, 24 Mar 2024 22:53:47 -0400
X-MC-Unique: CXGBZcLTMbqVVyHduMehaw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-29dfa2c256fso2757170a91.3
 for <ltp@lists.linux.it>; Sun, 24 Mar 2024 19:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711335226; x=1711940026;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=S9TT8UXLgtdn3gVqZ0sXoyaiHgKYBRVVqUwMHKlGX6M=;
 b=FiLSP+ZOUUiQUZIieN6+xiWEyFOpX/20CfM+hkyAHqAdd3IXb0Bv73yLQveg71Q8rF
 sthXqE/LX9xZElNTFBWiE1K7cp8IjEm9wGfiyWUR4fqpO/i92Nz54tRXDLzz+liqp06L
 Nk+9X9jXsfKaVw/8PprOTzFpKdQsUbfv6jEXDfoqoQk/fV4Wv8po1TpDMMfZVa5B0o4H
 my8kAX7KOTSpv3WWwlcEJnDuT3uf9uAP4JW8Ie6pm1h2S79LNUnjVECQz5PLl/iIBz5b
 IERLbiHazyoxvUWXjjRQWUP9gTAkKbaWJs2AUVTu5KDH9G4NmEMrJGhZ7isEHnf/gMpw
 Fg0w==
X-Gm-Message-State: AOJu0YzrRtK4YqwRMSYzr074elYqBrvAHP9K3zsZYeeHXOAf8E24y+5y
 LlQQoN+zRxsRci5e68edfVA/+5R6MN8jAPGbQ7mpnPQO39tV2osGTfOo9LyLZ/6FWitdXeOp/Ne
 TPF2hjwRSd6ys7o/Xs9iLrRfLxVjWyfi9bZzCiOACA7yamvyPZGrjyNJx2VJBjQNTgBmSCfZmzN
 CMNKtCLFJqPiK4V7q+zKRYi6k=
X-Received: by 2002:a17:90b:1d03:b0:2a0:65df:9d5 with SMTP id
 on3-20020a17090b1d0300b002a065df09d5mr1463876pjb.36.1711335226115; 
 Sun, 24 Mar 2024 19:53:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdo4P2r27lKRibImFIh/LS5ieZNAx00X9iatiKPznZu7ELCyKXSFPhVRR1KE52ini7+gpjqU3RPykIK0g9R+Q=
X-Received: by 2002:a17:90b:1d03:b0:2a0:65df:9d5 with SMTP id
 on3-20020a17090b1d0300b002a065df09d5mr1463868pjb.36.1711335225740; Sun, 24
 Mar 2024 19:53:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240322030208.3278120-1-liwang@redhat.com>
 <20240322050046.GA572447@pevik>
 <CAEemH2c3SNktFnPpsnbXvtTvfEv84byRrNmjcz3YyQHem9mcGg@mail.gmail.com>
 <20240322053217.GA588706@pevik>
In-Reply-To: <20240322053217.GA588706@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 25 Mar 2024 10:53:33 +0800
Message-ID: <CAEemH2fjNisDjZjRn60534rK1AHefbXPEUPS1FS0EA0OcfFrtQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] libswap: add two methods to create swapfile
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

Petr Vorel <pvorel@suse.cz> wrote:


>
> > Thanks, I would give the patch set more time in case others have
> comments.
>
> Sure. Thanks for a nice work!
>

Patch set applied.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
