Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5036EC3ABD8
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747276079; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=T2sVoDGYbFt1Y2/D2diucuTRCDJmJ7l0nswJe9DeZwI=;
 b=F3+yB9gt3is9Y7B4CjCHmv+9SNvqT0nW6VaeXf3GcHTdlH8Fpu1ZCANBO8W9k92MK/pdv
 e7bOJ/MJUN+gJbnAi5Bdbif4Ff7i/PNsX2yhczW6+Mek5r0k3xuxpOn5GbYVFvt3yxjFwdE
 c4QRL+Pg24PyliW3AOR90ko14mVkDkQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABD463CC2F1
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:27:59 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E23283CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:27:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CC2EE600D08
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:27:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OGVE4jyZ1dm/GZbicOk59p3pnAjoxCME6Q22Bxu0Ef4=;
 b=PxegKwh7T3+rQw9Ac9zp47I6czZDHQIVhwvA78cifEwEvmRsGaa25HClXmxw7JGbvWmAqL
 MM/VGoOeBcW5jmvRJ2xI13UoGJeBtRUFre8cYvfvtC+0fVDgEKEcby0ZTFrS8PYByEauJx
 0Vy5uDpYbiz9kSbcIO/KNwj3sNv1KYk=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-29-EzcNoXIlPga5x8KRJQv54g-1; Wed, 14 May 2025 22:27:28 -0400
X-MC-Unique: EzcNoXIlPga5x8KRJQv54g-1
X-Mimecast-MFC-AGG-ID: EzcNoXIlPga5x8KRJQv54g_1747276047
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e540fa2d0so3829425ad.1
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:27:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747276045; x=1747880845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OGVE4jyZ1dm/GZbicOk59p3pnAjoxCME6Q22Bxu0Ef4=;
 b=RwbV+Wv+Sw3M6XqDm/gTj9kr8oz6F6AEi0dm9GxRfm2k9ANpjJeiLG6ZNqHzA7+Set
 ADoe9fE8CN3kiXaId7f7q02+5pZ90m/LCftW7ohH1qkCmlFb+8E8/6EMqbhsnhQaFS8b
 O2OzZM/SCehJbQQzRWIJrkHQy4tUkO0r/qeCtf1puPmNzpQ8Ax3j2SjcUgf/pAEurfE+
 VP0N8xXTGQlbeWXOfWh12he8/dFJO1pS9bG/hEqCOOInl5rkkZQZRpLXl6jdQ3MXC2+J
 x4W89jug4mWZSzqTPA+RhqcDAWTvLvw7RKNjNlHTvsE9bK15ENTk7XnERemXq8EJF3yf
 tdVg==
X-Gm-Message-State: AOJu0Yzu1vajBKjUwLHgzcJLI/7RWdayRaciCW/TRK3Oz004H80pRusv
 Fms6htUl1R3rUyg8GWWVVNXUrNX9ykGqWui4qx6d1p2VO4tyhwd0H4cPUlJBalrOpdcy4T4O+Dm
 pJ1sxsGi4h9Re0U4pLDMxfCcb5WuepXnITOKoTkyuai+UJcMuJtkHpezXW1qbECgli00+IJYFMW
 aoX7VBnR32f3+pWoJStt2EORpLlpT5fD1rjw==
X-Gm-Gg: ASbGncvhssiey2CXFYJFQNfbgKMn17myhH2R/K38DeaeuySLoMUqBeo/2z0j6SXouj0
 EW4Ig4Yn/X14HsGsQYsNIPEEREbJajvGqq5ySCXkY/EIcl2DeOdin+CqRpUGjlapD3qPTXA==
X-Received: by 2002:a17:902:ec8a:b0:224:1157:6d26 with SMTP id
 d9443c01a7336-231b5e14b6cmr12795425ad.4.1747276045035; 
 Wed, 14 May 2025 19:27:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl2/n4om/FIKJc6IHnN2FK1x7aEJbQDEt82IAbREuokvDUlKVaZjKvW3WZ53t099xaTChR0lvM3SWbEoimoKI=
X-Received: by 2002:a17:902:ec8a:b0:224:1157:6d26 with SMTP id
 d9443c01a7336-231b5e14b6cmr12795145ad.4.1747276044651; Wed, 14 May 2025
 19:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-5-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-5-cd633e941e8b@suse.com>
Date: Thu, 15 May 2025 10:27:12 +0800
X-Gm-Features: AX0GCFtvqrl0IpqfDcf4uU4nOZXrvLQcMg-mBZhsGRy6R7u46jyXCvKizTk0n0U
Message-ID: <CAEemH2cqO7AHyibDxNUOsr4eLRJvXkD-ckj=YmLQQGrHO08OXA@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g4TNi4DmITpSuaHc9EVzoar90S9PyxMiQQFhJbQtU0c_1747276047
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/6] syscalls/kill09: Convert to new API
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

Hi Ricardo,

In this patch, you convert kill09.c to the new API, which is good,
but in patch 6/6 you remove kill09.c entirally.

I don't understand why we still need this conversion if we finally
need to remove it :).

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
