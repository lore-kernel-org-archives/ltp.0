Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62C0C88E56
	for <ltp@archiver.kernel.org>; Sat, 12 Sep 2026 16:05:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789229152; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=mQ3Y1R25IMBVFEUASPV+I7tsG2AokM0dZlzpwhRMxq4=;
 b=XzXn9C52NKGybqZjTfmTRsvpgbwV7Y7CXbbnLYjdkHWN4yV5GQJFJnvv4+sK+wZB7Gc4p
 9WzggYkpFzqzGS6BL2cVLstLurQ6WXEh9mun2Pwp/i3ZJCLd/UKMG+blLkaAuHUhEzpy+RO
 Da70E0Cj2T9HQ9px9SZKyGeTumhvNPY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8ACEA3E9177
	for <ltp@archiver.kernel.org>; Sat, 12 Sep 2026 18:05:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4CA853C0E10
 for <ltp@lists.linux.it>; Sat, 12 Sep 2026 18:05:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 401B6600041
 for <ltp@lists.linux.it>; Sat, 12 Sep 2026 18:05:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789229129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mgOCulKK8WJPYgKqSDOvIjmc8owKJyrHjxv0j1C/k40=;
 b=cIVMsqpdMcchdqirTRb7mWiz0LWmxY4q5zAEGHv++ovYbUoTPTbttuFPj2bweXaE3IBisl
 WuExRssVC8tZnS6U5mslq6eRIRsDgVMei0lgDBOg6etTlA611IMYm1PPrHR/VIPRIPjgHS
 xjopePfWJQc+r5x2Bs2xEW8muaod9dQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-dUBkuzIVObSE82lE-TRARQ-1; Sat, 12 Sep 2026 12:05:27 -0400
X-MC-Unique: dUBkuzIVObSE82lE-TRARQ-1
X-Mimecast-MFC-AGG-ID: dUBkuzIVObSE82lE-TRARQ_1789229126
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49b8c651ac0so25188175e9.2
 for <ltp@lists.linux.it>; Sat, 12 Sep 2026 09:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789229126; x=1789833926;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mgOCulKK8WJPYgKqSDOvIjmc8owKJyrHjxv0j1C/k40=;
 b=Bnn2knhrMG1hzl+f872pWsHbKhF8pRtttcFWB5jpaP2l0u7YvLA1u8SvDxNtxYVMOA
 UYy1J5MHN0+zyW0QM5b3IrkaT+NgIqJ5NxrHDJywLLLDv7uMSm63RDwAqNMK/Quac2W3
 3Pff7CbKYOzxpZPomukc7sJJJYg6cjQhr0khV0rhWhP0FSxGPykl2s0e6j6wIkI3wfLC
 AIGvp1YJ/63LG8f3Ey/DYZSNvFwwDqEaibfIdTW/eS+ddpsm+blc3EaMXWlDrKHkRCK5
 nAolAGLyL3WVJNWE2/NUhb6wbFzeh27iy3eF6uio/iXa5KPHKLYMSPkHV5duh2iGkwfX
 ET1A==
X-Gm-Message-State: AFuF++mQ/XfVLgMZfABubSnyudZyWJthxYq0lX6UuZ09q+5rM7Gt5ufU
 9mRmTCyGDGQuHhvscgL3qEKS+VEintFfZEcpo6NewK75nW23adr5h3UgLq2N88ovNTNb16Q69Sc
 GXareqaZCHAZ5bTInLuV8S8aXPNQV/DQerq7ENFhqEgfmcvKt6xSGe6OQDN21BQZo2hk/OTJZeW
 w/2n3eXj9XcfNd1w1ooDUZHWemSuA=
X-Gm-Gg: AYBFou3yFtiA6XKFXwD0sstfd/b3iq3vOqcyRtbSip1sGn2iAl9EufehwlI0x7f/yLb
 msSRKOFIX8/D/8Mxz7GfxdPgfZkexzRUOXYLdT+4+z5CyNqJM1Gh0/vbK/8/tdVxzD2ko3Fd+V1
 DUuvFG8CaPVRXb4vuIiZ1dcq8mhif9THzAgjXni8XEuvqZ1OeKIJE7g8x2oA==
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr101265435e9.4.1789229125974; 
 Sat, 12 Sep 2026 09:05:25 -0700 (PDT)
X-Received: by 2002:a05:600c:3b90:b0:49d:16df:8521 with SMTP id
 5b1f17b1804b1-49e619805f1mr101265145e9.4.1789229125541; Sat, 12 Sep 2026
 09:05:25 -0700 (PDT)
MIME-Version: 1.0
References: <a308e12198ce96305761a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com>
 <6a9ab385.aefdde3a.ed129.d0ca@mx.google.com>
In-Reply-To: <6a9ab385.aefdde3a.ed129.d0ca@mx.google.com>
Date: Sat, 12 Sep 2026 19:05:13 +0300
X-Gm-Features: AcwNN1XGgRUYWRDVV6pRRKNQEts3puV_3h0sCjymPnjoMwvWNDZ_vr6OuP2G5fw
Message-ID: <CAASaF6xRAGdWOaLKYO634DrjKP2vqKH9pFp1EfeJYVQMq6feaw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XznbbHOSxdfR85zB2LGb1dqctuwlapHuI-3ItqGB-e0_1789229126
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] getrusage03: Pin the test to a single CPU
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks, I missed that one. It looks like that thread is also reaching same
patch - pinning to single cpu. I'll have a closer look next week.

On Fri, Sep 4, 2026, 15:03 Andrea Cervesato <andrea.cervesato@suse.com>
wrote:

> Hi Jan,
>
> is this patch taken into account? should we reject it and consider this
> one only?
>
>
> https://patchwork.kernel.org/project/ltp/patch/20260902160113.1207205-1-nirmoyd@nvidia.com/
>
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
>
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
