Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34165C27C53
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 03:25:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3F8BD3D0A85
	for <ltp@archiver.kernel.org>; Fri,  7 Jun 2024 05:25:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E74E23CB987
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 05:25:24 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4F6A51400B8E
 for <ltp@lists.linux.it>; Fri,  7 Jun 2024 05:25:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717730722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WnnjzznyeGnMnKxzvqk37F6U628NqYNgovxy7oU2Igg=;
 b=Pp5GW2sGxqG4YhtDO/C9H8kPSLJDBcP5WulZnKJvnDDHGS9CM30SmNipMvniy8i3+Z+pAb
 yXUqfF7dqCxDqRScVPa0u/ilsfxX5RDjxwLXGeLOT82bWtG1cHzg4oyxn5wDmaifaMzlSR
 KnqrZo2BCv86jF7PTAeLZr0hXgqC7CA=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-6MW_EsLlPSWYrja8pLcOtg-1; Thu, 06 Jun 2024 23:25:05 -0400
X-MC-Unique: 6MW_EsLlPSWYrja8pLcOtg-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c1a23d1382so1620995a91.0
 for <ltp@lists.linux.it>; Thu, 06 Jun 2024 20:25:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717730703; x=1718335503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WnnjzznyeGnMnKxzvqk37F6U628NqYNgovxy7oU2Igg=;
 b=Db254M7H3FQ8dLHnzhqpSnoILZRcTnbqKpOoNhRWT6u+Zuio9dTbkToJKGoqfa5yLC
 BqSuh05ypW9U4phCi++cec432DI3YoYE5gPgaG5l+k66sA3NCgVmdXpzM6ZeHiONuBZi
 N8RdZFuRSen01o9VAz/aZVkQISY+RmiSsiWoopQf5dM/NqE5wQ3F54tkvuokmtDP7OsU
 o+YEidbsPtCTdb2/e4a6jU4A0I+/i7BFBBea4EkCgCx5vZx0Jgiu96rw4vtfvDfneFzw
 ESndsGSKYypJxPfrWXXMFprmbwpggrWMrcfE1q+h6qWnorqXx57BznVK3CZVMRSSlpzE
 W3sQ==
X-Gm-Message-State: AOJu0YzjEKmrQU7iZiwQts71OaIU/JqOTJwBnq9v9ElbttZ64QYSmnxY
 7qBY44Vx0QMs94ifKHUhWeJdT2PzKRQzwh8CqqtHu7VqGk6bhW8k3YLvntwGYSSJa/qLUYdMG/v
 E4jD1HQsOjFSmyOptZsd+7dV1LiFNr/E7U1aJaojjgacMTWN4SPVGoCnAA85FrbUE1cra4/jrx/
 BqKzzUq7OdVHi6bhpND2DJiCOo7P5HwDGJN2SJ4eI=
X-Received: by 2002:a17:90a:ea18:b0:2c2:154c:d02a with SMTP id
 98e67ed59e1d1-2c2bcc7b567mr1312858a91.45.1717730703593; 
 Thu, 06 Jun 2024 20:25:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0mh8DMXy+ERoFTqhbAECSwhbRvEQ6itZDZ4z4qar5x6HS1eCh2a+ToH+39JnqcksCDjk/PxFqjFfXNIaSPiU=
X-Received: by 2002:a17:90a:ea18:b0:2c2:154c:d02a with SMTP id
 98e67ed59e1d1-2c2bcc7b567mr1312852a91.45.1717730703285; Thu, 06 Jun 2024
 20:25:03 -0700 (PDT)
MIME-Version: 1.0
References: <20240527063346.289771-1-pvorel@suse.cz>
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 7 Jun 2024 11:24:51 +0800
Message-ID: <CAEemH2dw5JU+t0oQSkpmHNxVBY1xkBNq_DQ9ua8h_n18Y-T0Hw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 00/15] Remove kernel >= 3.x checks
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

Hi Petr,

Nice cleanup work!
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
