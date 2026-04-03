Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4566AD6AAFA
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 01:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1775181568; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=KkCpPnyO6vQ4GvY+hFF6A+jO/ccH3MhYlzqto9CZO/M=;
 b=X40inqzc/M4kY0rR9Fegik6BZFph+Tx2Ak5V09rRczjwwpRkvSoJaubWOHCM2xwVD/BKS
 SFDdfqQXJcXUFcqy8MPIPCKJ4EzLpfDgA4efIGqJiJZ/E+HYB1OdGMgqBHwV9LrB0mucvsH
 B52iEVXKS1GYf8z3HtKYoYvfhfRApdo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D94453E5493
	for <ltp@archiver.kernel.org>; Fri,  3 Apr 2026 03:59:28 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 60BF13E1D52
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 03:59:05 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D48FB1000A1E
 for <ltp@lists.linux.it>; Fri,  3 Apr 2026 03:59:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775181543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YwOv/xPmOdBam++G7+JE3nXnkV3pi+e1/5sjssc9Ex0=;
 b=bWkw6ug39xx/cXLg6oFVeXDTG6D3+/VvrxmERegSnMJDFytsdYusV0v1aVbvfh68Fhkb1O
 cgLos+tVyrG9lq8V7ekuknnJSzmaa7ejS5bMGnkUYmBZ8Z4hFzdewOZPJnemLTPUIWblNe
 EfaSZR6ja3G2TGLmoBeLu2h+CcsHVrU=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-1rZlpc-WMQ2qUcNvS5S4cw-1; Thu, 02 Apr 2026 21:59:02 -0400
X-MC-Unique: 1rZlpc-WMQ2qUcNvS5S4cw-1
X-Mimecast-MFC-AGG-ID: 1rZlpc-WMQ2qUcNvS5S4cw_1775181540
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-82c70d1f65aso765816b3a.1
 for <ltp@lists.linux.it>; Thu, 02 Apr 2026 18:59:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775181540; x=1775786340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YwOv/xPmOdBam++G7+JE3nXnkV3pi+e1/5sjssc9Ex0=;
 b=Q4BgH4CQNbk8OOQyPxAmMSANBvQEEr1IOvHxiVyK4RU22gDMH67LUknYm6YKXAcsr2
 nepNeE1lpXjcGGfxDEreCBvj7GzKVtM9QpjCkLV+Jtpw1qWVQ3is0YGCrY3t/0y84QpY
 y934ijqWJb8MeFfgSNPjjbXY61riye/L5T5ebQxhCjW1rsZMKqu+svFZqaUtVz9lttpz
 lOYIVkFK013SbhaU2bWqldI6VZbTkAXpIGU0S0/4x7ThGITjA5xgSPNvQ+OrHtEatOb8
 GXWeQ3lJFvexu9E4oFSK2Gdl/51f95jySNX3/ibJNETobLAPnaJFj8kV2iyiVQVwZro6
 swYA==
X-Gm-Message-State: AOJu0YyA+hY+2VDM8vebCm7Qghrqr24fKa55O9Ea5az/Wvqe2NlLXUID
 3oxu3F6jD3W8M55Z9vFX+povwn6n5q1eybGB5ZXg8qrfSeX55t0abBO/Y8w02tSEKyIKpntn8Pa
 leAyF8K7XqnHkep3z3FWKUj0K8feGMyH09bjAdX1K5CeOT3C9qWfd
X-Gm-Gg: ATEYQzw7bvXyPeixRk7CmENm6M7k19mkOo0Vxrr/oz/yXc8Fc/SY8lOfYRlkse+/V1J
 Twfd5G4oad3lz2F/rWezsB5gx7Tjo/0NYVXllZidlGD/C3ISSJ0xuZ1dvxSuZEQuNgzvSeALDcK
 tDmJqMqNsZrk/uGOc+Hx/sfeNilGs6EkAWGkIkMhC0MhducK1+51LU62xJUV1Pr8/ouEUHJr1J6
 RRlTALrEc2AmooEQOIh6BV4rOHhS+ufgfURB585s0oFgbONAswQiQ9bIIA925x5/hPDU/73fosS
 9Sx0HBw/I7cGppwe4P9VMASYJaulKZNfpQr6z2eFUbeKO5KVc8MZNfFGd6+5Ow8dpyn4yM4MM2Z
 YY4sX9lSFjMov7+AspQ==
X-Received: by 2002:a05:6a00:10c6:b0:82c:2445:bd45 with SMTP id
 d2e1a72fcca58-82d0da3dac1mr1234579b3a.10.1775181540454; 
 Thu, 02 Apr 2026 18:59:00 -0700 (PDT)
X-Received: by 2002:a05:6a00:10c6:b0:82c:2445:bd45 with SMTP id
 d2e1a72fcca58-82d0da3dac1mr1234551b3a.10.1775181539943; 
 Thu, 02 Apr 2026 18:58:59 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82cf9b27064sm5554093b3a.9.2026.04.02.18.58.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2026 18:58:59 -0700 (PDT)
Date: Fri, 3 Apr 2026 09:58:56 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ac8e4A9YPcXoFobL@redhat.com>
References: <20260402205534.224141-1-pvorel@suse.cz>
 <20260402205534.224141-3-pvorel@suse.cz>
MIME-Version: 1.0
In-Reply-To: <20260402205534.224141-3-pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: a2F4q3WUmP-NzCdHn8obi9MMQCyYCFABQdpw4gXqgTg_1775181540
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] pidns32: fix PID namespace nesting depth
 off-by-one
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
Cc: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 02, 2026 at 10:55:34PM +0200, Petr Vorel wrote:
> From: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> 
> The 2023 refactor used tst_atomic_inc() before clone with a zero-initial
> counter, which only performed 31 CLONE_NEWPID nests while still expecting
> MAXNEST (32). Use tst_atomic_return_add() so the shared counter runs
> 0..32 and the chain reaches 32 nested namespaces again.
> 
> Fixes: 647cfd468c3b ("Refactor pidns32 test using new LTP API")
> Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> Signed-off-by: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
> [ pvorel: use tst_atomic_return_add() ]
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
