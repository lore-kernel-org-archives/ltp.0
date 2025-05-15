Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9385C3ABD8
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747275232; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=B0xkG7D3PITqplcFDMEdRWvu/jqPZtgpjyXl6ggGLmE=;
 b=Nh3WO7MYf9F+OJLxMJVf/d6GHHNmPtiy0w2625bf1+Cx9eSU2nkKDbyZGwb1hC87PscMG
 7wAlQh9k/89sCyLkrcf9yhYjyIdbGOo848h/FuYXjNDnNI158qaQo5r3ljyAqT8qAPDuqoW
 YBgz6QAZty8Nnn3tegIQOfFoXDp0PJI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 149E13CC3EE
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:13:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 318D83CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:13:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82D271400B82
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:13:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747275209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=Tb28/Wk5PLm7hW8kuoDdX3SuldQksy/RK5Dmag97DcFvgOZFdmx6pE+1r5q/ZbGJbomi88
 2b1QnN/1pXn9fx90T/ejcYoxwL6vkLbLdlXo2v6p+/Km3Yk8I/gdRAY6mzI6mATmk/UkM2
 2jMYiOd6p8EjOi936NFiUiToBwCF7dk=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-100-zduYhomeO7SwFmqgpIK7GQ-1; Wed, 14 May 2025 22:13:28 -0400
X-MC-Unique: zduYhomeO7SwFmqgpIK7GQ-1
X-Mimecast-MFC-AGG-ID: zduYhomeO7SwFmqgpIK7GQ_1747275207
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-22fb8cfff31so3743495ad.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:13:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747275206; x=1747880006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iRgRMZQmTwKufpT2a+k58zoz2At60jBudm7LrNl4d/Q=;
 b=EtwOtowZZiGHCP/KE9gJ7ned/Wy9A/WFFvdo10BD8CvrVJK/LFp3NXUU+H8M/lb39t
 A6RsQ3A8uhdl33iao6LBNBAJGbT6kYiy6b13EqlfodW5w5C4MxOWBAVKDzy40n1O4du9
 AuFcGEOwz3P/V/QRY5ui1BmOX6mkQBRJHokxYLQpgvgpE8mUoIJosS5tqdO6KA6/E4zg
 q5fhDA7+ROl9NXcQd4G9Ulie9t747ATk8soWvycEqxnbiYX8noK9Vs/dX+QnE6Ajwbd1
 8k96mBZkEfB3bxGVCQrDAZqsAGOCBLkzym5CE0dfc4GOE+48Xj2qhfgE1sUERb2Y8xCP
 D/9g==
X-Gm-Message-State: AOJu0YzjijsFqCkfA03zRYB9X5+PAzas2Fy5j2OEgM0ddEdro/rOHb9C
 UFVtcdvoVLyapqhaaReqoGMyaD+R9mk5JH/ev2Ucs/Up/frDuIGvDTiOriqPIZFbrEeoFW4BCm7
 NdJgcDqk6V1a/cOrb0o6k+ig+RObmICQH6eGfWqZEBFCXVN3RIW33nn0UnjDLKWO/pR8jVMfbZj
 ySi5C2vlMC2lsq9C9VZJNMQpOm7suTImHZbg==
X-Gm-Gg: ASbGncvVVfgQ2fqMKA2JLrKfoyMhz14DzslO6YtinS3A/SyR6RsSow+qBTMgGjkucls
 QEm0juWnuXYuYllCldti/WqTReSASQx8QptYj2d5NWBdNa+Nli8jQ6M1fysO6na5X39GpMQ==
X-Received: by 2002:a17:903:194f:b0:22f:a48f:7a9a with SMTP id
 d9443c01a7336-231981bf07emr70369695ad.37.1747275206259; 
 Wed, 14 May 2025 19:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9EJHpU2RBPOfI9qBnBmlPcAzknDqZ7tbM4/Uzmcq0ZnJDXnGaP4v3ZGFdOadgNyusrXtQ9LxARBEKxs+pmSY=
X-Received: by 2002:a17:903:194f:b0:22f:a48f:7a9a with SMTP id
 d9443c01a7336-231981bf07emr70369555ad.37.1747275205917; Wed, 14 May 2025
 19:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-1-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-1-cd633e941e8b@suse.com>
Date: Thu, 15 May 2025 10:13:13 +0800
X-Gm-Features: AX0GCFtsKw_l-ET03OHm0_FzsU6W_iUe7QIIeuKnnCGDAKDRwEwy_6Rzod9eqEg
Message-ID: <CAEemH2cKWnFa=7E+du-08cRuDd8+ZOzVaFtOh9mC+85QZjjHaA@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zYCkd1R6-maw7qv2wBWjyTPFg7VV2MClYKoU3x9ZzdE_1747275207
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] syscalls/kill03: Fix test description metadata
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
