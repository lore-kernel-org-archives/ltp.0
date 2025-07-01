Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0C34C7EE30
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 03:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751340022; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EcsytsZ5bLYu2xA8qKqJywQbiBoMOvHYlC/K52Y8Hn8=;
 b=aOsGiEKP3psTcEzkfyPG+vuGbls6RM0PTwLgzD7BORGX+f1Hun226Q9gIFNrERrXk9IgR
 6T7iC4GFApz+WjWgm3F90jSOQd8apnCKM2e8JPjzkqSrIGxISnXhuQ743Q7k9xoyqA7/mjs
 AuE84XCMDbVHDjLVUVEz8kFfSbF1RDo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 83C8C3C74D3
	for <ltp@archiver.kernel.org>; Tue,  1 Jul 2025 05:20:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF4EB3C7113
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 05:20:02 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4347D600A5C
 for <ltp@lists.linux.it>; Tue,  1 Jul 2025 05:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751339998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cJ+Gsv86UHA/ChJiwYzqcHfTZ7SXior0+ABTxv+D4cg=;
 b=hfs/f41OLREUajtiGSsBdLPdAA6DUMIPXSD5BhM9b50Eld47m0NcBHa/I0MWUKZakoMxf/
 9wNltBhBdnN3g0wnaH6e4go/ByU0QNScVgDnXVSjBnGFEdlyElNJ/B3cCySqEb1E34++Wa
 iQ6DKOGMVYFyFGOZUzMLA+I/Aw1bBMM=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-74-l5HG-B92NuyKyiEKGXE9lw-1; Mon, 30 Jun 2025 23:19:49 -0400
X-MC-Unique: l5HG-B92NuyKyiEKGXE9lw-1
X-Mimecast-MFC-AGG-ID: l5HG-B92NuyKyiEKGXE9lw_1751339987
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-b2fcbd76b61so3711274a12.3
 for <ltp@lists.linux.it>; Mon, 30 Jun 2025 20:19:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751339986; x=1751944786;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cJ+Gsv86UHA/ChJiwYzqcHfTZ7SXior0+ABTxv+D4cg=;
 b=qesRgfD5yyXWFXnfiqayOjMujxobUFk8n86xoVMx2Vv8yPiABCbefuUASrqMKT3KFM
 zVMS6VNwZySPr5ntGJqanF0G0zMffLJfgHLQHdoRDp3w5ZwsSs7SfyQO9r/NeSLSgOLC
 GQTaArqALIPRbfZxRUkDo5z392+jt7Lm0uqvYKLCktfC46Aewtv+ok+NJ+HvXg2IY3po
 BDZnMjz/p/ZgA0VWKj8h5hjRibFl5TFlo7NsblVTEtlJWuPiEnAfOwk32VXVckDjIhzx
 gNR+iyEjEshVFQCxV4qBhcm7tBpLkDe/kS6T7CN1JLCSnbI4FAS7uhFNnZvTNpKKXkLI
 SWRw==
X-Gm-Message-State: AOJu0YzeBUfg7AC6ez7p5mk1b61XscAZTum0DdYnLrUJgN/I+b9XATbz
 /eH5eINF2N6FCopscB1+B8oisVBYk1EqNkd1UnT4KgvINvqAuePxxD9VELbhEUwkkQCZgSOXrRa
 apcVjI6s4nc5758hqRR8EKwXrvTCMd8V4Pef2CnqOOLWvRogVMwDZtQXuN4iLX74ihIrwG4PVPi
 iVaulB+OCzD8KFm1giZx9E2EatMc217qq0Bxg=
X-Gm-Gg: ASbGncvrfuW1HqBuPy2Ab/qJKrEEJ6KMmdYqG8wAFxKRmrREP1xRXvaZjUgiWUs9g4r
 g+ynQBvlspGO6POlTpkF6Vme9KNkg/oRujxi5ko3yOMHoyO/zYg0Pug+GSlm/8kNk5PuACWT9Xl
 JFfnGn
X-Received: by 2002:a17:902:ce0e:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23ac40d4bf7mr256268115ad.12.1751339986498; 
 Mon, 30 Jun 2025 20:19:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiTwyJhTzUOWrmmpfh/cny8sK1/QR2R/XIeHGUSOqbF1LuolJMvqj9wCws4/gX1V1o4+hyi9sKMcCsm4iyezE=
X-Received: by 2002:a17:902:ce0e:b0:235:ea0d:ae10 with SMTP id
 d9443c01a7336-23ac40d4bf7mr256267805ad.12.1751339986180; Mon, 30 Jun 2025
 20:19:46 -0700 (PDT)
MIME-Version: 1.0
References: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
In-Reply-To: <20250630-conversions-shmt-v2-0-6bb1bf315cce@suse.com>
Date: Tue, 1 Jul 2025 11:19:33 +0800
X-Gm-Features: Ac12FXyKDZ2SvWERV_0REa0PipolyzddpZ4IRXzFr_DYQeT4M_WcExbwd4yKF30
Message-ID: <CAEemH2d2zv+L=K6Mv2AEWcyOyb=R+-WOQ-50f_NYxHuac4SNWg@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7NxABny3bUz6vw_rZP4Il4fACVB6qqtpkfSYwG9ePdo_1751339987
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 0/9] mem: shmt: Convert to new API
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

Patchset merged with minor adjustments(code format), thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
