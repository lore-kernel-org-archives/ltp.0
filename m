Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710EE1061B0F
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 15:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774884218; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=zAxMWpCGd78Srz4MnCjXO1NanbZcvWD6/XGo80VTIOU=;
 b=mlnhbnuWaRx2dfF8aCHXDOieqORCvTWyORK/oLCDv819S12nVw5bnbt9I+BWA/8+x/2nL
 4spNkJxVr2KuMyCF/4vvnAYlJxdeb7JzSp+hpO7O9P4pH8DqW0Somq+GercdaD/bs6cu4t5
 gLv5LMK40kF5BfYqSIm3Sa4d4UBLssM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C60663E5717
	for <ltp@archiver.kernel.org>; Mon, 30 Mar 2026 17:23:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 16A773CC2ED
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 17:23:14 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DC0DC200B6B
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 17:23:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774884192;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=iIuFkKPkGHII5LvTYs+sv2lJ1RIrjYlOzSU1LzqCjtc=;
 b=W9JJL2IzNUQkwfq985cSv2lymdlWpE1cuZKdEQyN+YPU+u1xU/+GecQkBFIAn/Z1PalFcC
 e/DFZeodJwUSFvxlOKhVfhHKJcA8erkdO+WCuNYpxnUM7NEtXwpvvmWd9eUpNVqb3CY4ep
 dC97K851fZXchDyjPkrUnRjQgJCDSzE=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-Gu_J8XepOfSOQJ5oqcYh3A-1; Mon, 30 Mar 2026 11:23:04 -0400
X-MC-Unique: Gu_J8XepOfSOQJ5oqcYh3A-1
X-Mimecast-MFC-AGG-ID: Gu_J8XepOfSOQJ5oqcYh3A_1774884183
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a2b88578f1so442225e87.3
 for <ltp@lists.linux.it>; Mon, 30 Mar 2026 08:23:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774884183; x=1775488983;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fodnTcNaOUz5tdPBvhvyb+cD/c/ocKP7LzDalMDqS/k=;
 b=CTTrrmF6QGzswLlK19iciKwKOXghMJoCgnZInnxOAF/3Ll7n+OMNJZ300Eg2lJEsv8
 XWtBmu/xbxK8W8QeI1hYem363XPeYXTihYFSCc+AduEQS6mLvPTYN4H5jbxbuHQaNPIb
 h3aCvSDhtU9bnsEBrq6LTzDf1kKXV4hEXQidAbNPubVL7VIF0vzCCyqbEtBBNPBqlgpI
 FCys5glewvFqU/T9bv+T8Mp+SVSxpLCScs5TtGspTQDhOj7woRQhqJXtsWPeqaEf7vXb
 Ij0eDGscAcJ53DmnmYimdkRIetmYUpvNOMs9ZMFDhyGg6GU6AEpfMOPO7ZM4YRdCvXAG
 NCzQ==
X-Gm-Message-State: AOJu0Yzh7ou11Ysr8Ew3youSrOf7liDTG+Wt9AGriutZ9LPphlfSjxXF
 v/FECHiWC4u0fiBYfZt0Oojv+5bM5785ELfhwi1bx9V5MUUPr7YP1+2Wiaiza5x8zF3YWXMPEzU
 NhDW1R7ms3+pksAB/33wrNAMf4lz0ucInNJ4sZQOmMPJxjkDeaLbt7pi4fTucK9EvrK3G6xtijx
 scXefMTY+aCBEPizsbJJLBFN/ogNBD3AOrzp5v3A==
X-Gm-Gg: ATEYQzwbd1DyTYRwWlpXb9b3e4ORAG/6x367Hl79HuJDSFyZozILFDaUZQw9nIyxCh5
 bd/YkKGTosVxpSUPn7ZQ0D+a6r1EN30ojKRhSZusUDSwx6zERmesJXAyODHGqYh37GnUi9IIUaS
 HwuKZlv0UH7elfJ8UmrhjNEUn0deOB1jJU9aMKTb1xrYBqm99K7usKmQ4RssTMrJ2D40MQQYpMx
 yXpsAE=
X-Received: by 2002:a05:6512:3404:b0:5a1:8722:64bc with SMTP id
 2adb3069b0e04-5a2ab93172emr3701842e87.37.1774884182611; 
 Mon, 30 Mar 2026 08:23:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3404:b0:5a1:8722:64bc with SMTP id
 2adb3069b0e04-5a2ab93172emr3701831e87.37.1774884181973; Mon, 30 Mar 2026
 08:23:01 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 Mar 2026 18:22:45 +0300
X-Gm-Features: AQROBzAgj7ZjQxaI6I5pKhUCW6rq6xaSiDuxoOfcleWurJvksWFZea5enqezGkk
Message-ID: <CAHGiOXfj60hbfgVPBUYwTicuD9HMkdpjDwx9CLRLKHQ+BYO58A@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CW7ESstVlQsA_ClkBTvbrNNi4T6JH8qy-Qt9H_i3lVo_1774884183
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] PATCH] futex: Add error coverage tests for wait,
 wake and cmp_requeue
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
From: Michael Menasherov via ltp <ltp@lists.linux.it>
Reply-To: Michael Menasherov <mmenashe@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi.
I like to submit a patch that adds error coverage tests for the futex
syscall.
The test's cover are as follows.
futex_wait06: EFAULT for bad uaddr and timeout pointers
futex_wait07: EINTR when interrupted by a signal
futex_wake05: EFAULT for unmapped and PROT_NONE addresses
futex_cmp_requeue03: EFAULT for bad uaddr/uaddr2, and EACCES

This is my first patch contribution to LTP, any feedback and suggestions
will be welcomed.
Thanks.
-- 

Michael Menasherov

Software Quality Engineer - Automotive Kernel

Red Hat <https://www.redhat.com/>
<https://www.redhat.com/>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
