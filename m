Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F1F2C3064D
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 07:41:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 034223D3EC6
	for <ltp@archiver.kernel.org>; Tue,  2 Jul 2024 09:41:40 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 766663D3EA4
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:41:26 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 81D521401389
 for <ltp@lists.linux.it>; Tue,  2 Jul 2024 09:41:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719906083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sH3CJoq9dHdKzALhvriPBIVkg/on5N8VpVoeuiYI2Ig=;
 b=WsT9EGZhO3S+F66IV3WmacXKSacsmFG5BKe7uO+V+hm58hGSABZE/obtx8W+Cmw3MsJIQa
 B1r4pi0TLKV38V+Y6YuFVEN8towhTUuofwIIgeaXV7kgjlv+D2KJvcuF0jYDHXyLKcUO9d
 ++L8gJBesdxXW7MnzyuOYdYQAms1mYg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-340-4_RiNd3CMuuiggLj_PbsDw-1; Tue, 02 Jul 2024 03:41:19 -0400
X-MC-Unique: 4_RiNd3CMuuiggLj_PbsDw-1
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-6fd42bf4316so1559631a12.2
 for <ltp@lists.linux.it>; Tue, 02 Jul 2024 00:41:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719906078; x=1720510878;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sH3CJoq9dHdKzALhvriPBIVkg/on5N8VpVoeuiYI2Ig=;
 b=MP04XvGg/3/NU8x56yqE1NG/RUqYH0qnQyXn1nJM/hjr5kJjh9PKrEGa0pNT0x6ryU
 K1jLhRCN3LQDwr5IqR0mRTfqbK2/3jZiJugcnwFzkxQo8H2pOOINO3907wm2v14FcWUo
 1Vy5dNI0ewquiAYNL+QL9eVpsV8FOKhPjllS4jyaqc+l0aI83URcaMDw68Wo/UrhDdxx
 Q9UtxIsHHu/j6rnQueGHMZvRRmxfu0jo0y7NT48/rb5upauYDuy4Z5jihn4rGJnq2RNk
 1pejgs0yrjTFpklb19UOiVb3sBiu/YDJNfLHG9yaik4lLJqt484+w6Wu1iCOfo5pCP/L
 VpaA==
X-Gm-Message-State: AOJu0YzMx4/DgMdLVHCw/HE10cPPV/SyIEsLdf0ofXEgIwQyIs0RCGEY
 sThntyRZG93VbLmyc4bGcp2UX0m+GVU0Rn0j5CNVLAhJ1e4Kd/6PgP6CYWhG32XJWGwt1s8v5t5
 v2rbTRglFVTUMjXVzGvWn8Yz9rjxvItvtWNe24775BIJdFdePLkctWTUSdJm4uRCN8xw/nS0i3+
 1oiB5U31aU7cPPxLh/XPpEbj8+u88VONEJhlvt
X-Received: by 2002:a05:6a21:183:b0:1bd:27be:5dca with SMTP id
 adf61e73a8af0-1bef6190275mr7679856637.29.1719906077679; 
 Tue, 02 Jul 2024 00:41:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFzE3kgIq9j2O5KuM1frlz7Xy/84aYwSmQcmbgQetPzLCI/PUwSD9MSQnqjgGkiS0mnsB17Bw5IQV8IPeDEu0E=
X-Received: by 2002:a05:6a21:183:b0:1bd:27be:5dca with SMTP id
 adf61e73a8af0-1bef6190275mr7679841637.29.1719906077210; Tue, 02 Jul 2024
 00:41:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240701-landlock-v1-0-58e9af649a72@suse.com>
 <20240701-landlock-v1-2-58e9af649a72@suse.com>
 <CAEemH2dUH+SM9_EALFtuNOq1v=1dSXOvsvxSk2pgOJknZ3VcgQ@mail.gmail.com>
In-Reply-To: <CAEemH2dUH+SM9_EALFtuNOq1v=1dSXOvsvxSk2pgOJknZ3VcgQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 2 Jul 2024 15:41:05 +0800
Message-ID: <CAEemH2f3ShGqBLaZpXYcVpLO3TiOkXb2kbDPGafwwzxtSacYEg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 02/10] Add lapi/landlock.h fallback
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

Li Wang <liwang@redhat.com> wrote:


> +AC_CHECK_TYPES([struct landlock_path_beneath_attr],,,[#include
>> <linux/landlock.h>])
>> +AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include
>> <linux/landlock.h])
>>
>
> This line misses the ), it should be:
>

Typo, I meant there was missing an angle bracket ">".


> -AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include
> <linux/landlock.h])
> +AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include
> <linux/landlock.h>])
>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
