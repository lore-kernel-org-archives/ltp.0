Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD6C01112259
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 02:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775097541; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dEBq1BtKmq3yPhGMmLfy9wCg1psD3OtxikwcaLInXog=;
 b=a6KiyU2iAixend7xYVayYmU67kEqVv5D6PcakN+7NYgefPymOA7C1lLH5kaP/2NWfp0yA
 dMRDVSzj0Zj1cxYhuSap4ZjqcVh4Fne5jXLvZO+dctlRHpWgYd1fz127XrwB++y2J0tjFIx
 R5PXhshS397VeMZh6kSvDP6XtkRRlxM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 486483E7377
	for <ltp@archiver.kernel.org>; Thu,  2 Apr 2026 04:39:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B4BC03E1C4F
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 04:38:36 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A45C0200BD7
 for <ltp@lists.linux.it>; Thu,  2 Apr 2026 04:38:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775097511;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8FO7s52QnJqyOIqEu3AEE3KUzzFoM2YP2glOihsBH9Y=;
 b=M03KmDb0M5oJb7lF+Ofhb0NJVYac9ok0BNAztZ3qk5oIbyO+FsBAA6Dis5PWV/enLAYSVR
 e8nFy97Q9P2UPoB2bDUvqLzsdW5AH/jSK9eB4u2WRT+lnkeo8HCQi67KfdQA1hVfx7DsXy
 HMHhRpWn00oPwhB00K4p1zxkPAbEDqg=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-OePpXZqzMfy6jHDft2Uv2g-1; Wed, 01 Apr 2026 22:38:30 -0400
X-MC-Unique: OePpXZqzMfy6jHDft2Uv2g-1
X-Mimecast-MFC-AGG-ID: OePpXZqzMfy6jHDft2Uv2g_1775097509
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c76b15a3ccfso130723a12.3
 for <ltp@lists.linux.it>; Wed, 01 Apr 2026 19:38:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775097508; x=1775702308;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8FO7s52QnJqyOIqEu3AEE3KUzzFoM2YP2glOihsBH9Y=;
 b=GqCI0xA9J4uxOqWaVz3/75jH7vp9QhyJKUw9W1aA/1sij6aTvwG2VZtgaiEltNCJfr
 RVfOaMPlVdRThpVr1pykcOFm9mvBPqPEiHlLx+BygFCOO3q4dNhXjzVjsbZUcJo4OYM1
 Y3Xw/Cud7Jd4NhKM4ixAfQaRVeQC/kIDVm32qxT2lMzHgshFat2jQ4gFqSpb2eLJ90X5
 GmTyEK//tK33YrD7cwOxRRGnpxNcw8UI6+SmbPWRueEDVOj7yVYWewAHchlnt+s1shMt
 o5wD7AmUTCSBIG9f6eJwuYiegNfCW6jHux0xk063YoLSp0IXHcjOMkID0GjJ2amsNuI7
 tplA==
X-Gm-Message-State: AOJu0YzjRIVhuR0Q4MqW2LMHov0w4mpZpzrDljQ/RHdY5QkCdmkJI5Bx
 4leZxZFXTyTQzZmU6utQ8ircW7zuBSqlGzYhsZfuE62MgDfJ6wwuIRQ80itgJIDyJ1XTK5D9v3O
 4r0MO42xxpHlqCwjlfZZt8mr8dZwinpvv1He3ugmExyJVuSxlri4eBqakvN7g
X-Gm-Gg: ATEYQzyctnfrW4cEHbT2gVMOBfRZoHUgjI8KaRub/SqaPJM2dxSXTJqkyn3uhgqdMO9
 CZBSpPuxx7jSFezxxTVRDulPxTleKi1JPAr2CDZ/8L2YB+2UQH9HJ0KTgRoPMGXkGBMoBJ9Y/Q8
 4IXR9bZwM8HyIvqYNh4Z7BKXAfze5SmUti1ckraI9aKO/VtFdJHJ9NPZGSyAQIqNB8nUWN405pC
 V2rL3ginAnBO3Ums1PXHMqU81E6hD70OMlkucO579gr5Oh44R5poz4k5JK3N3uFFJ1mnwJ0b4AZ
 5/O2i1BS3fupyw5O+VclEzVYYMtVd8VMLZPjcy1QEa+bYoYf53y6emGJjP+QnkitjAFCXMupbNY
 eEyvX4RJ93TXpmfD7Tg==
X-Received: by 2002:a05:6a20:7fa7:b0:389:8f3f:50ce with SMTP id
 adf61e73a8af0-39ef77631b8mr6322837637.56.1775097508475; 
 Wed, 01 Apr 2026 19:38:28 -0700 (PDT)
X-Received: by 2002:a05:6a20:7fa7:b0:389:8f3f:50ce with SMTP id
 adf61e73a8af0-39ef77631b8mr6322816637.56.1775097508032; 
 Wed, 01 Apr 2026 19:38:28 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9c3dd6bsm1263870b3a.32.2026.04.01.19.38.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Apr 2026 19:38:27 -0700 (PDT)
Date: Thu, 2 Apr 2026 10:38:24 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ac3WoOMzL0pN4Tp7@redhat.com>
References: <20260401115147.11604-1-chrubis@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260401115147.11604-1-chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: J_GIKjKnsHpexzPXs_XM_mLU7JIGvsO67caJ0n5szDk_1775097509
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: tst_kconfig: Add runtime checks for
 CONFIG_*_NS
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

On Wed, Apr 01, 2026 at 01:51:47PM +0200, Cyril Hrubis wrote:
> Previously LTP Kconfig parsing logic only checked if a feature was
> enabled during kernel compilation (e.g., CONFIG_USER_NS=y). However,
> some kernel features can be compiled in but disabled at runtime via
> kernel command-line or sysctls. Tests relying only on Kconfig variables
> may have failed when features were runtime disabled.
> 
> This patch introduces a runtime check mechanism for Kconfig variables.
> When a  CONFIG_* variable is parsed as 'y' or 'm' and when runtime check
> has been associated with the variable we run the check and potentionaly
> print a message and override the variable value.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
