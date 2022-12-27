Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D2F8C10F1B
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 06:47:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7A6DC3CB817
	for <ltp@archiver.kernel.org>; Tue, 27 Dec 2022 07:47:35 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E4023C4F11
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 07:47:24 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6A350600653
 for <ltp@lists.linux.it>; Tue, 27 Dec 2022 07:47:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672123641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MNMWKUhDK1yhCYNLeGyukEDPhgdldnU5cMm2Haffd8o=;
 b=jKyA/vKZrmMzRRVQkcXTgnu+oIsodHkzNlenuosf0SNVg/zlqpI16qBrWG35LlHvcQhR8X
 QzDfJaKGn0+dmBei7NwbtpaHzUPL8EMCFaVybgsBZBxU4cKwE2ZV7ZT5d+WuNRhpHJ6JoS
 yto7nj2Qko7zeddl2aWuSZJ+A8qL2R8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-nQo9Ca7jOoKbWH670QY4Jw-1; Tue, 27 Dec 2022 01:47:18 -0500
X-MC-Unique: nQo9Ca7jOoKbWH670QY4Jw-1
Received: by mail-wm1-f72.google.com with SMTP id
 l9-20020a7bc349000000b003d35aa4ed8eso2989295wmj.0
 for <ltp@lists.linux.it>; Mon, 26 Dec 2022 22:47:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MNMWKUhDK1yhCYNLeGyukEDPhgdldnU5cMm2Haffd8o=;
 b=Pwredamv3CRtRhc6TjCPFKidYzAH/kl5Toq27u9qNZ/rCyXtmykaNtYAr2kz1CGbba
 9EXPIciT2FYx3BlEiBwKfk2RRyP/wL/00mDvdc8f0hg4RBNyutSwnznaWjhkhFC/OUoZ
 tzUA6ReyBqKaW0IFZZUXL0Cv/pPfNBYRXjqQX0WTrKkgLQQHWhramObYWsTw/zn2JtBq
 WmlZ+iek174dbwnqitqRY3421Hg8SnmWBt+DiO2Ult1ECm0zaSZRMY3LpWc72JG8ACwQ
 G8DWkADla1Wtmg10Q5a2rOYdLy58oBEPAbeaJVQuCvNN6TzXgsLKaPxmqsajHqJwKVkO
 Gv/g==
X-Gm-Message-State: AFqh2koxhn20P4SUzPKsGwSF1nFuvy8eZvo4FE32DYro20owDn4kg06C
 v5Kn3DJdbYFZAEx/hMU6kl+XUDrvvCnTJnLX5ebUV7MAdVdXN8NgQPZ7uCXY8gVEqinoVdsmk5D
 wYaVfyK0R9xNtDOuGDSR3Jee9uVQ=
X-Received: by 2002:a05:600c:3b9f:b0:3d1:f076:26d8 with SMTP id
 n31-20020a05600c3b9f00b003d1f07626d8mr723903wms.99.1672123637037; 
 Mon, 26 Dec 2022 22:47:17 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuYb9B52yUHXuWVcQf4sgQmiMSnfl3M4QqJkXG6K0sowmZJFd9xk8qthrvd7pS+eOycV8pyK8r6IH66RlZTg5k=
X-Received: by 2002:a05:600c:3b9f:b0:3d1:f076:26d8 with SMTP id
 n31-20020a05600c3b9f00b003d1f07626d8mr723900wms.99.1672123636820; Mon, 26 Dec
 2022 22:47:16 -0800 (PST)
MIME-Version: 1.0
References: <20221225154213.84183-1-tsahu@linux.ibm.com>
 <20221225154213.84183-9-tsahu@linux.ibm.com>
In-Reply-To: <20221225154213.84183-9-tsahu@linux.ibm.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 27 Dec 2022 14:47:05 +0800
Message-ID: <CAEemH2edjhVFmxEk2x=ciy=O9bOGjfMujd0EM2pK1dR_Kj1iag@mail.gmail.com>
To: Tarun Sahu <tsahu@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 08/13] Hugetlb: Migrating libhugetlbfs
 noresv-regarded-as-resv
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Tarun Sahu <tsahu@linux.ibm.com> wrote:

Migrating the libhugetlbfs/testcases/noresv-regarded-as-resv.c test
>
> Test Description: Test to correct handling for reserve count. If no
> reserved mapping is created to reserved file region, it should be
> considered as reserve mapping. Otherwise, reserve count will be
> overflowed.
>
> Signed-off-by: Tarun Sahu <tsahu@linux.ibm.com>
>

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
