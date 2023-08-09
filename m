Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A677EC0015E
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 10:34:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 21EB03CACD6
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 12:34:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3FAC3C8B63
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 12:34:06 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8C1462009CA
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 12:34:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691577243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JPfEnBCGV4rroz8MraCO42RVfwsSx+5o/AlgPgk0D6c=;
 b=DCafBcIAAmsGJrKVhnMaidGMt4a7SQ16Rn2mmnCRB0jesvjYXSQWK6ZWZ9yrFdwMDob+Sc
 hQMomPqPnzDvYyNbpUqWmi2oTIUQWNFQT2BgxFgd0i7U2bf8/vVB7FPS8/+d1Yi+Xqp3f/
 0UH0kP4qeDqG4YxWJTytqGVB9dM+Mz8=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-Vvb53ZehNUCjLzRSH-arSg-1; Wed, 09 Aug 2023 06:34:02 -0400
X-MC-Unique: Vvb53ZehNUCjLzRSH-arSg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2ba077dcbbcso66276701fa.2
 for <ltp@lists.linux.it>; Wed, 09 Aug 2023 03:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691577240; x=1692182040;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JPfEnBCGV4rroz8MraCO42RVfwsSx+5o/AlgPgk0D6c=;
 b=Fqz+zGALzJvgipCMtNLozyychaU4I4wXbcF3cR+YSyO+H2A7WIJ7ORyKg4VdyRono1
 bt9Mlk1YY2fCBmoyTIA3Xg0rRB+qkbC/hcZwsyeLelmkG3Qd3VasLaCS1aXukAsxmpjn
 HMVZy1cFbCTDR8ajv0AWxrOrljM3xfaci25GZxdSwr0Ic0nNi0YdEjGkgUgzM/1R9S0p
 TvnejXmOWmNJce8U//rFg8guhQf2Baky8C1AD4oFXxrdpjHOWNqr30fPTi0K/4vFg2rF
 +vjW4AehRWex4YU86vFi3eCRHvHvm/OILH1K+I7JxAH9vIrf+H+TIg0gtqV+wCUY7Yqi
 Pygg==
X-Gm-Message-State: AOJu0YwnSdMP8j4gJ4IU3np6dto69RkZeCMUJpa0gaPWKMIoqKEAEMpH
 i3D/K2YZguvvCjfD3brlyzqsRtG1e4DQq4sJnS8ZR5n20H89v9IuMqGk/0npeqWKN6Z5pxeH3gj
 jriQNI2I6ZRPw13o4em7aidqEYEqvleqGxzIZmw==
X-Received: by 2002:a2e:9bd3:0:b0:2b4:6f0c:4760 with SMTP id
 w19-20020a2e9bd3000000b002b46f0c4760mr1479648ljj.11.1691577239792; 
 Wed, 09 Aug 2023 03:33:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTKzJxGeJlq7F5/z78y2ok9BEUJ+8hMcRx9zl/ox5XHmceVeWZwyEdApFUyUu0O8vvTaAiih38iB2PV7ceW3E=
X-Received: by 2002:a2e:9bd3:0:b0:2b4:6f0c:4760 with SMTP id
 w19-20020a2e9bd3000000b002b46f0c4760mr1479642ljj.11.1691577239460; Wed, 09
 Aug 2023 03:33:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230808154141.23780-1-akumar@suse.de>
In-Reply-To: <20230808154141.23780-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Aug 2023 18:33:47 +0800
Message-ID: <CAEemH2d_HMFfo2A6q1SfZ2Nje89F9kE9=quuJZ+5xcYKtedB-w@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] gethostname01: Fix docparse format and make check
 warning
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

Pushed, thanks!


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
