Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FD4EC433F5
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 12:03:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 736993CAE08
	for <ltp@archiver.kernel.org>; Wed,  5 Oct 2022 14:03:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 544A23C9A5D
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 14:03:01 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C80A200980
 for <ltp@lists.linux.it>; Wed,  5 Oct 2022 14:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1664971379;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NwFa6Gd4YnJQj38WhkduXn3qHfZw7zPzmfgc2YeKUy4=;
 b=HxNijUm3XDXo3FtAzgOKS27UYjsG841rWzQjVDOEsh/C+pjkTlhVKe7mknuQc5HW2tlzFn
 vndCldZ1gV08BnrE90p69JDZbOv1Bd+i7+aH/o8SxxyQOjOd90MQQwyZZB8Rwa0JvW7kos
 PzHIkC5T9gkvg47LP5GJk5CDtgVoJI0=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-387-_LIbXFcBNiWmXmg2832Ecw-1; Wed, 05 Oct 2022 08:02:57 -0400
X-MC-Unique: _LIbXFcBNiWmXmg2832Ecw-1
Received: by mail-ua1-f69.google.com with SMTP id
 h11-20020ab0470b000000b003bf1da44886so6331461uac.17
 for <ltp@lists.linux.it>; Wed, 05 Oct 2022 05:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date;
 bh=NwFa6Gd4YnJQj38WhkduXn3qHfZw7zPzmfgc2YeKUy4=;
 b=iAGJBRX/8YrOMxjt32zRG24NcJ+KIXV25ZCeOO3DnZoAOcUll1H2eu+7DPocNTvt7+
 T2xB4+FkkvXUmGEXJp+5K97hvTNCmoigSp01MPjPbXTBf+KyuB9YZZ/jLEHNQ/WdSfwb
 +0Q6N076nMNikjeE8p6Ck9/t8Qx/wbjHOia5J9mL49KhYZ8YlGxrmpxS5//bKEvbAFkJ
 LIgKkCoi7lNcB3yqVyg2NsevJdScbEu/eNKV4XyLwnwIk7drnePqeFDSg6F4i6VChab3
 LqKITAtQiCQimm76KGqCibVq9rN+ECnFCGYMB3viWlptZs0Mg4frkfjCgE1CnGkRn184
 x43A==
X-Gm-Message-State: ACrzQf226l7xSswuxs0TDNNWZs5vkCKWNxglJfx9/f2dQmZG3onlgP55
 cBwRPQPQQW99GIRVEG9TqsapVMUyitj8IpVw01d5pBXnYzgPJHLlbVkDSuiE/YMWAyzaTfbB0ls
 DuI7A5MTYx9zS8gtEDV/Z23C6YhQ=
X-Received: by 2002:a67:e196:0:b0:3a6:ae9a:d823 with SMTP id
 e22-20020a67e196000000b003a6ae9ad823mr4426267vsl.26.1664971376010; 
 Wed, 05 Oct 2022 05:02:56 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7wXhQQST+RpJnojjQsGYgH8/g4b8kLuOuqF/LFinByNw/TxQ/Ox61afX8K9u3qWUlFrjf/YRkwLm3q+oCOLgA=
X-Received: by 2002:a67:e196:0:b0:3a6:ae9a:d823 with SMTP id
 e22-20020a67e196000000b003a6ae9ad823mr4426236vsl.26.1664971375695; Wed, 05
 Oct 2022 05:02:55 -0700 (PDT)
MIME-Version: 1.0
References: <43d65409eb3290b09e1c3a21cb0dc079c5f4849c.1664801307.git.jstancek@redhat.com>
 <938c864ee6bb82ffdee9371bd802642ffedc606c.1664872194.git.jstancek@redhat.com>
 <Yz1PQEvpLBQg3313@yuki>
In-Reply-To: <Yz1PQEvpLBQg3313@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Wed, 5 Oct 2022 14:02:39 +0200
Message-ID: <CAASaF6wbO4hCsqXQ2zmym75DvtWDN=2hLDHUkYRnDcy2xsiBjQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] lib: introduce safe_write() retry
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

On Wed, Oct 5, 2022 at 11:31 AM Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Pushed with Petr notes about comments and whitespace fixed.

>
> --
> Cyril Hrubis
> chrubis@suse.cz
>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
