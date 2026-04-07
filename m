Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AC34FEEF27
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 11:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775562087; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=h24N5UYGtlG1RJSWv4nnR3zvmX0uO5FpUapDYSMalbA=;
 b=ZC978yWhTHquKUCIAYsgfHCppzpIT8KJLRn8iFrrLe+P9uC5+dOulrPGHyKns1Q0RDWyI
 FHCbgfY2FhB3ne20JieEDT0BlHKTfc3mEVJqGGhN165yuzmhDQiUteWNqWpZtZLIFJBMUhe
 5J7dinEt5hMnBZOGZ64T471Ei24Hh2I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2748C3E29B0
	for <ltp@archiver.kernel.org>; Tue,  7 Apr 2026 13:41:27 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15C1F3C1987
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:41:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7178C600714
 for <ltp@lists.linux.it>; Tue,  7 Apr 2026 13:41:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775562058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UWKNP4She2EH6wTVESR9FIbcOscja142vLTgD1CJgWQ=;
 b=WYIJVWgFGpURk8J0+/piqtjrtyh6FcNXzUzH1DSipg3CZIuoCJ50kEeBJD1zKcUTG4QSwG
 4s/4hN1a/Apw1nNJzOA4gLvWtkIwmPKGksyAROe42RH5pT3njIkZzJX9/tKA16xznZ2n0C
 Jyb0Ei5MWMyuG7JdXLlQzunZ0CSqBHw=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-414-2hoL2RahMMeXB5iBDxEcQg-1; Tue, 07 Apr 2026 07:40:57 -0400
X-MC-Unique: 2hoL2RahMMeXB5iBDxEcQg-1
X-Mimecast-MFC-AGG-ID: 2hoL2RahMMeXB5iBDxEcQg_1775562056
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2b24a00d12cso53829735ad.1
 for <ltp@lists.linux.it>; Tue, 07 Apr 2026 04:40:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775562056; x=1776166856;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWKNP4She2EH6wTVESR9FIbcOscja142vLTgD1CJgWQ=;
 b=r69iHsfXNntxoOjdjnoff0RWzrwmoBBq5k1wy6bFLWkvoQutBsAC+y0wgdvKUJjRAF
 lQp/n2VMFDtuzsz+BfAWpENV9bKnpBocLUWu6Kibzo9cuq0HopSs7mYY0vSD8ljR5uAF
 wcEEDxPWEibqr+zAgYV0fVjuPde648p8rTjdBSeuVjWCiow0liDjkGly89fXF19gFuAc
 VJG2CzTPwZDzcBBnjFUqLZ0s4CK0/m64KFqoEXlT7II3mIxTZvqVN3gLEPD/r4AW0xV5
 Rz7WKYSUeKdj0ThQ0/naVm9UEcRhsOblloBDLPPQb7R4OfW2JWvClppc9eTCN1c/Yy7o
 VZuQ==
X-Gm-Message-State: AOJu0YzjT5BqIaSrDT5W7F5/mmOSNI4vkBn0iKyOBhsEQs5aihHF68cN
 zLqvSDKcG/jmJ9X+A3875i/pjNSJoXVAbALTD1uLKMrZQJ/wnQ0fqINQTCUSu/2T0+xhUAEAMcl
 y9BGChdOmy1bCx24F7vyf1nFCd9sCM6EVrTHUBfEbPQjxBJxBgjdH
X-Gm-Gg: AeBDietylG3JAVpfderJtJw5cRHSUj+w/CWqOcE8YDNWphb6QJJ1tprnikUuUAX3q7N
 rbySsQY66A7MjU/KHw8ovNyJcw+oIWYHDD5ADEYW/NUXxSKPQ/mdC4q96lpxWwsSkbpQI0iKmHG
 WP5y+9dnL5NSpYrw/5slvyEmRQgD2ZstlNTGHLMGUXDufvxHiBtSz1PKHQHh9YuB0m3at9Vdwch
 pa3oKnd1eiOZOSGS0/DeSOtMivagnMNWxMRv5D9dYOo5LUMT8lCD6prbLftrvesMz2JqqwFUIRb
 eCaTBaRatZqCwbToCrJDXE6YIqZJVR7UY5x9ZC1f2LMIYjBHIBP4YUf+6e8BFEDVMKR1ePFDIzA
 +qlXklJBiYpDLKlfPkw==
X-Received: by 2002:a17:903:3508:b0:2b0:7a27:bb2b with SMTP id
 d9443c01a7336-2b28178ef7amr183497265ad.34.1775562056124; 
 Tue, 07 Apr 2026 04:40:56 -0700 (PDT)
X-Received: by 2002:a17:903:3508:b0:2b0:7a27:bb2b with SMTP id
 d9443c01a7336-2b28178ef7amr183497015ad.34.1775562055561; 
 Tue, 07 Apr 2026 04:40:55 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27497af26sm174471245ad.49.2026.04.07.04.40.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Apr 2026 04:40:54 -0700 (PDT)
Date: Tue, 7 Apr 2026 19:40:53 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <adTtRQ66M4UUgtVR@redhat.com>
References: <20260402121356.31266-1-chrubis@suse.cz>
 <20260402121356.31266-5-chrubis@suse.cz>
 <ac8vdjEM0awKPmHE@redhat.com> <adTW1Jmq3vfkTWSO@yuki.lan>
MIME-Version: 1.0
In-Reply-To: <adTW1Jmq3vfkTWSO@yuki.lan>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Z1KuPSRPD0Lvdt6XOf9kfl4_zFdyLttevpGRJJztG2o_1775562056
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 04/17] lib: tst_kconfig: Add module presence checks
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

> I do not have strong opition, if you agree that these names are better
> we can rename them.

Yes, I have a bit preference to rename.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
