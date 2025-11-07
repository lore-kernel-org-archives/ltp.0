Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2CF7CCFA13
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 03:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1762485345; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JjZD5RpWc/og/SAuAnkfBQcHsjYX1IQPlxHSmrQiBW8=;
 b=k1gV7KtKcERONJeJwnAXDzChfXW8rV22N1KM7W307bfz8p8wc1X3WE6FPyPhIchB7IkWj
 FnYz3Mc3ipxyPzK1mjpYvLrkRlWVZrYAOdoSZ6LjBftQn+ZKmPATiHmjJbaGCBUIFOgg7Jq
 Xt5Ezd41XvuSwbbetWV70X/3LAkXtNQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 449303CED07
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 04:15:45 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 445E43C0F41
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 04:15:23 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 82AAD600D6E
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 04:15:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762485320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SDY3BpDUR8Up4EuRbqPPU78WWo3Tmy9GCnkux1RzNDg=;
 b=I44nhpICLgJ7+cqjgBmg57Nv98pmdU6z9JuZWQibW7j+KlPHiXkF/to6BEZRmiBJYqAQ0c
 Wj9sumIxHN+pZLHfQ75bm3AknyzmVXr+BvNRg7T/84W8qan9YqPrVBEeMYPjS27kp6mrTW
 LX0dUl7D/q5VPBTvQyjzevw9KAzhTOk=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-120-_5TTz4mAMRaqPbvkqQJGLA-1; Thu, 06 Nov 2025 22:15:18 -0500
X-MC-Unique: _5TTz4mAMRaqPbvkqQJGLA-1
X-Mimecast-MFC-AGG-ID: _5TTz4mAMRaqPbvkqQJGLA_1762485317
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b98e6ff908aso711225a12.2
 for <ltp@lists.linux.it>; Thu, 06 Nov 2025 19:15:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762485317; x=1763090117;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SDY3BpDUR8Up4EuRbqPPU78WWo3Tmy9GCnkux1RzNDg=;
 b=d3s3sW5EPtuTTC0ylJzy3BXkJb0W0FBT2n4L2RyEq4C45VL2ec/YSKh7L1I9PHoCOM
 AmTEsgPtA9ERNeg1EEdPPiV8Gve5jabbkBcl1EwQ+IoMTcSNTkFEakJ/FEB3lPYVuy88
 E9xmTQjAkGKcFJNpXPQ10RUGkoyH48asjIZCoV0ugpKTwG6FYBJ6rvBrSRWfsP0B6rAo
 EBeAvPf1GKluFiXuLvBKRQ0IF4v01M07a7IsP0YlT1n+LdBvOkv+xQfdrQWEYQx68i/p
 mcqQdwy6qgcqlu20oy7lVKzHfWLytJcoGhFmoIK5TEtDE3g5Ru/58/HtfhanS7OERNHq
 VjgQ==
X-Gm-Message-State: AOJu0YwhZ2OXjOFjVEkwNvjr+PbmaU6k5I/SOF2zAySfzp5Sac8KBScm
 SSqaXrWyYX4pDUcoHp4x49YRa1guFfDfCtWfmd5fVAGxNNWfWRIMLMLFCpQ+XxxjJRjrJBYIc/U
 XNYx4/3fqktd8trDUD8fixvE1h/KwLM2f0MteL0mZjDOaMgQ6a0Fz12xfIzSZAJygYx0Rh2Uimx
 d6XPKPOwqDpP22LgC+XbnaXYWy8bY=
X-Gm-Gg: ASbGncs79WRcuFhVlsoKTP9ctd3xdCGiufA/EGMvoDa1FGEzfUW3yfiTHnfDvIJFCKY
 j4pko2vbdclN/3uf+pRPy7BXqMhlVD3qxpp2sIs7WBak6Wya1vk4An8vJBsxWLkOk3gHCTmQPjf
 Jaz6Uiif7mSXD55vDyRLXy9mNbT8Xux5yPYJwQHvwbi0fq/yuCTUxypCiO
X-Received: by 2002:a17:903:40c6:b0:297:c4b0:8d53 with SMTP id
 d9443c01a7336-297c4b091cemr16624105ad.54.1762485317330; 
 Thu, 06 Nov 2025 19:15:17 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZSKCNv57ZkJhggn50O7V7bYeRZb2gRR461w5PrasXmk4YENwF6/vl+5F41CF60bstVYxHMQm2uQiiwBX50eM=
X-Received: by 2002:a17:903:40c6:b0:297:c4b0:8d53 with SMTP id
 d9443c01a7336-297c4b091cemr16623835ad.54.1762485317048; Thu, 06 Nov 2025
 19:15:17 -0800 (PST)
MIME-Version: 1.0
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-4-pvorel@suse.cz>
In-Reply-To: <20251106163500.1063704-4-pvorel@suse.cz>
Date: Fri, 7 Nov 2025 11:15:05 +0800
X-Gm-Features: AWmQ_bkXfTyTcRCf0OQ168b9YD1fozBg57vmqpOX4KxNt9kqr0zqF66s-s4YV5g
Message-ID: <CAEemH2ddtfdUZU3ToFn_stU+mE9ADQAHzWuK0mOj9nN39Jrj5w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kdPfD9o_oHX1ChkcCRnRXgqUcG0p4uEKhu_b9E07GrY_1762485317
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 3/5] swapon03: Try to swapon() as many files
 until it fails
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
Cc: Michal Hocko <mhocko@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

For the patch set:
Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
