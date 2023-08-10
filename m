Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76EE5C001DB
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 07:30:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6639E3CD08A
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 09:30:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F1E253C894D
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 09:29:59 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 254DD200387
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 09:29:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691652597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GOemtNuCstFwdVnSH1lcdRYrZc5vhZelC7Wrk6SwYlc=;
 b=KaUD0DG+TIhRUCFMIFSNN6IzmVMCSrBvjlk4I/q6p63biGH3LstBn/y4+5WnO2ThkwY8c+
 FO2ZhOVwDoFwFOC043/jt6CgX8JshEQrarwuu4CE6UrKzTt7dSSEctD8xdK4ChRU3ikwHh
 cqif4gSuA9fIjMapQZW/MREwB2jMlF8=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-G_VSbeMRNeGfE8mXcMlMzA-1; Thu, 10 Aug 2023 03:29:54 -0400
X-MC-Unique: G_VSbeMRNeGfE8mXcMlMzA-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9dc1bfdd2so7023981fa.1
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 00:29:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691652593; x=1692257393;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GOemtNuCstFwdVnSH1lcdRYrZc5vhZelC7Wrk6SwYlc=;
 b=eotCyjlNZWpZGBDqDX0oYsUFeP+HMFREjZX1QphGVMRdE9G05a3TQH6gzyNdAuRGIk
 zUd1lBHLm4018XZlgnyMWL98fYjyZ6dEz7LUcj3g0H+u+Y34CM8ufAAjsQuPADOB0wDY
 leK8t8esLS6/kmoFI3cEyEvT5kg8LoQg824fK0vn0WKOAcULO6Y+gx/8LOF5ziRuu4+w
 FLhIK4XwibNXY/ck0mxnSFfl+jqAyv0ZcAVss/ZAZKCWOsCoI4fLfwEKWgzrKIXioLFX
 YqHrBjWIBWTzWncx5FY8APOIdgmj+djhsZMqSFbaMQqmDvuh0Onm1zWTDTwyL8L5wMdX
 I+vg==
X-Gm-Message-State: AOJu0Yw7LG2XdtwAUtKhtHe9Ddg8hsJd/4x/6yvuv8rRhRLu0XgHDxQO
 64b2wsvk77AhEBLOB5/qqKqV5jI62S+i5FCz+rOpV/3tZpEA9rYvQs53uvLepnCXK97YESv2+Wb
 C+3WRpRnbJaVfdHp1ksBPZjgdBHs=
X-Received: by 2002:a2e:7c0a:0:b0:2b9:ef0a:7d40 with SMTP id
 x10-20020a2e7c0a000000b002b9ef0a7d40mr1218326ljc.41.1691652593581; 
 Thu, 10 Aug 2023 00:29:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWKOOi9eWNdDI8117hnFG0RySdB4wrRHVUsWNgE4KSq5SfwAWMRW+TfiDOQzk7g4uaLHp1yIfuKBvwSHOzf1s=
X-Received: by 2002:a2e:7c0a:0:b0:2b9:ef0a:7d40 with SMTP id
 x10-20020a2e7c0a000000b002b9ef0a7d40mr1218318ljc.41.1691652593233; Thu, 10
 Aug 2023 00:29:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230807033536.1927020-1-ycliang@andestech.com>
In-Reply-To: <20230807033536.1927020-1-ycliang@andestech.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 10 Aug 2023 15:29:41 +0800
Message-ID: <CAEemH2d9FHG-B7RC2kMmbXiWYQyq3T-4iG9qDBNyZ9Uyok6DQw@mail.gmail.com>
To: Leo Yu-Chi Liang <ycliang@andestech.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [v2,
 1/1] hugeshmat04: make use of save_restore to simplify code
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
Cc: cynthia@andestech.com, patrick@andestech.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Leo,

Thanks for your work, patch was applied.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
