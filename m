Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3D98C54ED1
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 09:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1748339875; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FTBZOWe3/ZivrMJAKyAxx2aJGCyRGT+LH2mlNR5Vuig=;
 b=lWMw3SwwHIxC0czsybJB/L35d8dD+tR2Usi3CUjnV7rfe6bBttkT6g10BJTx8kuO21Aq3
 O/BzoXsmLaxVvXn9NF4nVekUzsxXxEuFf/C735ZNQVluP/zRvCmFG5P5OAZuYesun237M6G
 03e7HSU+9Npt03gpEQdAM3217okAotc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2885B3C56C3
	for <ltp@archiver.kernel.org>; Tue, 27 May 2025 11:57:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56F363C2C13
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:57:32 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 52C271000796
 for <ltp@lists.linux.it>; Tue, 27 May 2025 11:57:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748339850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fnP6Q9Mirt2XZPU2RiX5+a4bDaxSKVCQP3Rg1MnaY5Q=;
 b=Now2bHrMcASIRV44hiyLP2+bzGNHirA4XZ+D2hCDeNnNkU9oIeW3Sx0LKyrlblM/HTuvtB
 U8BCvW1RAsYIPpgnTu85F1eKi+xseDgi2sLa/Uw166taQCKxC69F0VuJJ2TLzHLPUPBJq9
 0BHNML55oN/JKqyZ/TSH9Gu//L/jz68=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-pfdbLleQM2SEu33oCcU7Yw-1; Tue, 27 May 2025 05:57:28 -0400
X-MC-Unique: pfdbLleQM2SEu33oCcU7Yw-1
X-Mimecast-MFC-AGG-ID: pfdbLleQM2SEu33oCcU7Yw_1748339848
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-311c5d9307eso91427a91.2
 for <ltp@lists.linux.it>; Tue, 27 May 2025 02:57:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748339847; x=1748944647;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fnP6Q9Mirt2XZPU2RiX5+a4bDaxSKVCQP3Rg1MnaY5Q=;
 b=LcrgoeJTRv2S/GUANTMDYFNpSW//pxbLhZ/Flqm4yK29tjhrdU7THUznU6PvZhityE
 X2XlQsGFsKz2naCdvHLwaB3VbyVMmB4WCWS1hRuMGp6th2GTB3bvk1OEglF/QAS/wKDs
 24KNG898GKCKzrCMfZmkUmg2pE9UN0h9IXkXA67vbr1rYHGpWnZFogS3xm7n3XQnuUYd
 LXDwIsdhpyO0OyP0/z90tBOYf55Ob6Kw9Ff/5y1fyRBxhcVwt26VspebZtLB/vUAsz+y
 x/VO604ZMzj2iZ6Ch8UIzvU6YYKczmhknMfaLB9dLF0xxlwZTa4F+hVV+nDAT+rygJ3k
 Iw7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtgevjRR5cc6qvvfdNtnfBWES7c1CFg2IssVmVhOxeZFZZLAOXK8G7LcnD+Fm4iWFIRYw=@lists.linux.it
X-Gm-Message-State: AOJu0YzRIai8GFQEZjT9ncifMIfOObT5ZP/BmqGwX5jCPSmUcBK1Vw4e
 oW5t6VdiiXG9Il247K1VO9lJVaE6i9juIfhD+FUN4MwcF9e+25TsYlQcAUOGJpj4m/GcqXYlYBZ
 O1UEq0kXfVLXv2YLNHkioYSURCe6k8Dp0NfLGnECY6ZGV7hnYF1YCy2F3qb5mXH/ZGxJQbMP/Pi
 g3bvE7o9dgS3QsbqdNY2GoagpKwas=
X-Gm-Gg: ASbGncvnlS/2Pr4vfGwXxzzhZ/u9Xtqz7ZTYIlC/CdkEsvyto8AHgD/7XtK5aSeUHWp
 3OENMg55fuCOot6zPHtvK+y7bsi/pi+rLL1aDl0O1TeeD1cmggODtJSdMwFlthJwm4bke9g==
X-Received: by 2002:a17:90b:2c8f:b0:311:c5d8:ea8b with SMTP id
 98e67ed59e1d1-311c5d8ed73mr322423a91.25.1748339847625; 
 Tue, 27 May 2025 02:57:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWOrSHHZU4fw2B32g5dVHQ8/cE3ry01iOVXmoX72VK+GIJdvWHk9HZH03WaAHv+QWGv++74MySSJwU7btsrNQ=
X-Received: by 2002:a17:90b:2c8f:b0:311:c5d8:ea8b with SMTP id
 98e67ed59e1d1-311c5d8ed73mr322399a91.25.1748339847303; Tue, 27 May 2025
 02:57:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250526143429.22997-1-chrubis@suse.cz>
 <20250526155132.GA151544@pevik>
 <CAEemH2eyj5k5tUAQyo+b-JXKF5-GcLzQA5SXbP7xpqU1xU73NQ@mail.gmail.com>
 <20250527093436.GC173684@pevik>
In-Reply-To: <20250527093436.GC173684@pevik>
Date: Tue, 27 May 2025 17:57:13 +0800
X-Gm-Features: AX0GCFtCmetErUHOGROnQja0Vo4f1pBqpN2Joi6CqsA4nuO0QzoELKX4nOetIpo
Message-ID: <CAEemH2cCL9LpBRMnfJtShmdtwKTHLMC2hQeC_sFKyh4KWwUt0Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: NrgUuD6qCzT6uT8xHkr5zZGXKZDueofU-HGqRnf8uEo_1748339848
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: LTP_SINGLE_FS_TYPE and
 LTP_FORCE_SINGLE_FS_TYPE
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

Petr Vorel <pvorel@suse.cz> wrote:

>
> > One more thing I'm a bit hesitant about, do we need to explicitly set
> > fs_types[1] to NULL here?
>
> Although it looks reasonable, I suppose it's not needed because array is static,
> therefore members are NULL, right?

That's right, just confirmed with Cyril, so far we need to do nothing
unless tst_get_supported_fs_types() is abused somewhere.

Thanks for the quick reply, and feel free to merge this one.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
