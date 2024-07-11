Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278FBC3DA41
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 01:17:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E9483D3890
	for <ltp@archiver.kernel.org>; Thu, 11 Jul 2024 03:17:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFAC33D0B06
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 03:17:16 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CE379602BCA
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 03:17:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720660634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o6Q/UBcinJMvFFpgoqm9n8bZBLHghu+7emIDxTgUIJc=;
 b=eI+f2SqugsLywQajNTLPCFkwTTZ2yZcczrT+W4Dj7py2zGOOWVqzR3NbZEkwDn8IzcPRTT
 GIzcez/hFMzQJ5kYjGY9rI3qLy7njAYLdpAOKzS8bwSCpxqyzdcoLUs8UUJigtSmSd3bII
 Nbq43A6K+lSDDNHxOqhpdSx6DMPxn+Q=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-J347ENAoMMGxcvIjJN496A-1; Wed, 10 Jul 2024 21:17:12 -0400
X-MC-Unique: J347ENAoMMGxcvIjJN496A-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2c96cb48a8bso345530a91.1
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 18:17:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720660631; x=1721265431;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o6Q/UBcinJMvFFpgoqm9n8bZBLHghu+7emIDxTgUIJc=;
 b=Ro2rNgvnaN4QYMd/xVUKg+TFykCyzzgoevoFrCKowQAbq04cT0jIZqCeEaiLfxRpOU
 OVeILaO6wgTRPfbcmGhl2UCaBmDuOdLqT31BzG2gAG8GA5zsx2bJrmgmmCeCEBJFsonP
 OCwF1D0RoyKD5vHpN9/iZolg3T/CXD+QRoNcQMJ6JlYiQEcdKpIwiSTFv8QYA+Hfs3AW
 vl9PvRqgGHN0Mt8K0Oux9Gm/D/P/Pkc4zgNFMWyfKXYtpcMndmURv/ZGD4IMguXogROY
 5fymMHoOgkQD2Tc1ufdFQRUES/G60oqaVLz7GCuvAf4r9SXUsQFnIBqQ2263eMBPbHi0
 1Uhg==
X-Gm-Message-State: AOJu0YwJa5RSY32Bv5NEK57DnA3wYPVxLZ2LToLqP1uuqcuYh3GwPI6t
 u/LvJHTi2VMUQiyk594fv8YXcK+a7YEdz+3WpduUiOj++gOnQJ1XJbRnu66uDePBU9Ln56WFAQT
 iXHoSWmgJFNYRRwNHiPRthDOMMSPFUZYQWyrCtvgT0vLSPV5xkiKp48rHynFs0imXGKveMWLWpF
 7aia6j5YU557J0dd+yvcSWQC0=
X-Received: by 2002:a17:90a:f2cb:b0:2c9:9f4f:c787 with SMTP id
 98e67ed59e1d1-2ca35d44b14mr5804336a91.35.1720660631042; 
 Wed, 10 Jul 2024 18:17:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH6FMk1wB2onajk3PmIBqfaxW/b0wmZEVWfv3q7BlLmlotkZHERv6OdTfV/wESq83MrYr3G3YFu2/PBBfz2/OM=
X-Received: by 2002:a17:90a:f2cb:b0:2c9:9f4f:c787 with SMTP id
 98e67ed59e1d1-2ca35d44b14mr5804324a91.35.1720660630667; Wed, 10 Jul 2024
 18:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240710-landlock-v2-0-ff79db017d57@suse.com>
 <20240710-landlock-v2-1-ff79db017d57@suse.com>
In-Reply-To: <20240710-landlock-v2-1-ff79db017d57@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 11 Jul 2024 09:16:58 +0800
Message-ID: <CAEemH2d6T6KGQdqVa_BZRF3fyPRu3a6sbApJa=V_cedQSiZwpg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 01/11] Add landlock syscalls definitions
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
