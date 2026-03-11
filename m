Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06077106289F
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773235068; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dA1AfbAZgUvKzX/rCSRlvnDhl5b/OSbgFHk1e+oBUCo=;
 b=UNMOBAbTstp58bZ4Pgj9Rrq4vKAcm6xTwLSJBX3QQnWNOuB9MEkoqjvnZZpJqZyT/NLrU
 ndPYt+x1LW3FhQQ6hcG73gfP2Qvr3PcBTKRZHxR4MlMUoYlaD2zarx0GsqYtqmTIlZR5a1z
 8IfOTSGk/CmyzWlhLyQme+oC2hVDQFE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 67D113E2BA6
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 14:17:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8372D3CD3F0
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 14:17:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id F2C5F10006BD
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 14:17:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773235043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aMMkJJ1/qHqQ0biYZJ339itb88LjdgI8d9t4btaIczY=;
 b=RYwPeXcJ8jbPLEQE8OV0SNSGv6bC439IEvT+JVmdpTSbLxS6AuJDG3TBwdAUte4N+mXKnx
 Cj1wHtRzKrqlxf5i/gtI3n9+HJ2j6bB39naGsGz6ZvoaaREtOT/JATl5DT1BG4bjnyO43B
 bPcQi5VB5x95k3wBTF1sm15LGEGCIK8=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-QV43nsEOOZuBfM0vxb4qMg-1; Wed, 11 Mar 2026 09:17:19 -0400
X-MC-Unique: QV43nsEOOZuBfM0vxb4qMg-1
X-Mimecast-MFC-AGG-ID: QV43nsEOOZuBfM0vxb4qMg_1773235039
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-35a02f3b8e2so3179566a91.0
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 06:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773235039; x=1773839839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aMMkJJ1/qHqQ0biYZJ339itb88LjdgI8d9t4btaIczY=;
 b=uWvjLjEahrqavB8FmzdK8GCwxPsRevvkTOFzzm4yyKL6oQqXPsHt7Du9Ptth24tGBP
 wWIectQiqnfolk9z9YICmVqwM3bbGhX/2jQpLzsjNCSr+sOIHVyaPkcod0dqR/2gKsWX
 nrENxCy1CvvbV1NH5B07weAGu2gaz7fajDi0plulv2eyUKsWFr1q5aptAIaVm/XDQqCl
 qnFEglEu8jheGIBU1roeq6s7uCR76vZg3ndzhnLc/wdD4KjGIavVPJ//vcZo0S7kbe4o
 5zJc1J/pgKvi+zdPr5DB66nV/DdPeuzGo151Q4V23QZkFnTClfsXMougauMoEjPGHcK3
 BsTw==
X-Gm-Message-State: AOJu0Yzk1exvlR1rroaRHp+BEZfo0MJ+9zu9VKlqDctD+eDRa3uIv34S
 ODV/IVxenKfYAAPZVUHUmKKM69nvFyVAvIFFQ2ObHlAA4ARQmXZCiIKWSvfHgeD3pqRVV8Jvati
 aCKGLe2tFgOxero51unEY1kpiSVVpQgdkRSg2zmctmV5Xri1iUfVF
X-Gm-Gg: ATEYQzy4Xvv9E0vSyrrsuog9GmSGG+7qTurLtmDQn/+zN5CyeQEjv7kTC7+0kJaWTYS
 +YzqmruEckavOommyExf8kYFha7HuhW1Oce7KTXW0JTP/TheGydPjwlLXucuvYjaIQg4p3jMuij
 7oBDNU95PM4ghOxhXOwIdztU11swAig/bOfs03ZmgKaN5sthfs4Wi0SXuWpJXw/gWjhrHlwZiiG
 fuE02iRlVq+BctomBsj+wdhU2rAdGleZnnlOe79ymxJVA0cwnm1EitdJXELtsU9z4WoOJ75goFv
 jSzh0/40KuUozpvU+k9Qz6hIqjMZWSDjSm/Fq/TIoMQ/Xs0ex0Nz9KU9xWkQMq491YJAYSsbuqB
 iqphw6i5z28yeHOA+9g==
X-Received: by 2002:a17:90b:55c4:b0:359:7d76:5ead with SMTP id
 98e67ed59e1d1-35a011a6ed7mr2527964a91.3.1773235038686; 
 Wed, 11 Mar 2026 06:17:18 -0700 (PDT)
X-Received: by 2002:a17:90b:55c4:b0:359:7d76:5ead with SMTP id
 98e67ed59e1d1-35a011a6ed7mr2527947a91.3.1773235038243; 
 Wed, 11 Mar 2026 06:17:18 -0700 (PDT)
Received: from redhat.com ([209.132.188.88]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a02474a97sm901893a91.11.2026.03.11.06.17.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 06:17:17 -0700 (PDT)
Date: Wed, 11 Mar 2026 21:17:15 +0800
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <abFrW5DJSJAeG8EE@redhat.com>
References: <69b16303.050a0220.27d4f3.6151@mx.google.com>
 <69b16378.050a0220.e24c3.cee0@mx.google.com>
MIME-Version: 1.0
In-Reply-To: <69b16378.050a0220.e24c3.cee0@mx.google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fojJU88vXEkKjBDOlnB_jNUd4UQO7PQoCvh8TbkmA5w_1773235039
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
Cc: Cyril Hrubis <notifications@github.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Can we go for Monday the 16th at 9:00 UTC?

ACK.

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
