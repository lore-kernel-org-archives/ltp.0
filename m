Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14374CCFA13
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:38:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B09F83E65B5
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:38:03 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 557DD3E2622
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:37:45 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C6A491A007B0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:37:44 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-8ee7ffd738dso179724685a.1
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 04:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777549063; x=1778153863; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Dx3bNCs8RXyXI999O5XZ4lmSu0J42FwHE/y8MzyAGs=;
 b=RTH+uU+tqWTStkcXiStXgfcBQnhNztYDmHvPado8ggl9oqu4dTBfJg4Z8/kFhcYzJS
 1nRByg+EgKtu6vs/sC8TT3GGGNr5SmGk4Xje6+b5gtHxyCe0srlnMIWkS8Q/IDlt7sbg
 G4hnpUr0gl6w/xQlgF2Gd6l63jTWttqlBBHCantJwNS6WtvflVzZIVSR15hoGDxfqXNm
 hpH7jrX66hE2V0mqx5o3PP6MB01weahWVK37djsHvX8hyfR9wotNQpD6Acewwo51VNdO
 zqmmvlk+LhfYBdhei4mhFCSPHQs2lSx5dhmmeEj7CO6HkRzIjVs8FAZxS7kEWO3XJJd8
 2Ekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777549063; x=1778153863;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5Dx3bNCs8RXyXI999O5XZ4lmSu0J42FwHE/y8MzyAGs=;
 b=DBdTTIERJ3tTsWgJNRZVdXDc8MJWspLjGffE1I13/mYiKu06C5oc10lywlL314ebns
 99wTLEejKyj1kzw9QBfjB9B9ATeWtSAj1FnQhV+k6l3wrxNvO2PodSR0ViO7pIdZPXWw
 lpG3yxRLG/fNQ4ZZ9U7SLkm+fPdlad2gfuCP9czIaPb0uLRZemTj5ART0KAfBry+8uh5
 qftPnMWj+dUs3Ry/ckrKQ6h2M+GNv3pRZ7LAixjW+JHj8OHkv0dAMEpyyBHqkwsmXnDS
 hZbgEa4qpfFDKNvrZwoEKeXWA3ID5UnytQ7yGhudCa8Mzkid6Y9M/SwR2SOn+ZEEKjLR
 bBPQ==
X-Gm-Message-State: AOJu0Yza2Y6h3W8oZ9jAbC9UStj5XWwTNw2v7GcPV6qd3ut6U7mVAXCz
 P0m9bJmRL+ZKk7IQVfgZkcEH5G2MXBmRVWG/eoudSJOsUAL50nsfi4TKrgdKMuGOd/s=
X-Gm-Gg: AeBDievbVVQgajHhGU3ZFVPxSqjvyLOONLyoINpHKpfinbfKHc9/iB72rX0NUdGs7DM
 9memqmHS61b4Z2anPAqrC0e23IZ/mOVVMjLN4vd6iBSfiAc9Vc7/89sjk3WdjKwQG6o3urexoin
 0tpyAEmRpGOZOqPToDEbM5ueff0iJrwHAZqQfOfUh1ynxsY3xmJKGgsoP/QAqb2SPe//XV4sPAP
 Z07MmSTNbrRjx3zWJd+neNKv4twFcB/fXrEZZiKyhGHTgl14JYz4YqnJP8dX/y1+0rbnCarUlIx
 7pLnt+nXT/iiV2fvFjXhaO5FPg/25i/W+jf8iQjH7AJQjQBSSRD/SOxeLMjrniNXQP0aNuWT4gb
 4/kFSftauhoGgQoAUwOjguaMi16sln2DsZrSCmy9DBrWYTtaaDQnLUNq/N6q50Jx9a0o2wT96mf
 3ifkY1nJowjlfjM4Hgx/hygZwiUNd+lnlfKVA3vtRk4sB6ZnjAQlkU1m7l6RA/exnI9JPpcQOfi
 fUDjn7QNanhSMgvSUBGxJvp/xRh6uz7EROLbG2qRounNRWml0Y=
X-Received: by 2002:a05:620a:40c3:b0:8d6:795d:5b84 with SMTP id
 af79cd13be357-8fabad170f2mr229497685a.21.1777549063531; 
 Thu, 30 Apr 2026 04:37:43 -0700 (PDT)
Received: from
 runnervmeorf1.gssiu3lefqqeza45sz3ce1gdkb.bx.internal.cloudapp.net
 ([52.152.180.201]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8f93d0f6eccsm424011085a.20.2026.04.30.04.37.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 04:37:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Thu, 30 Apr 2026 11:37:42 +0000
Message-ID: <20260430113742.4002-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430112346.4054436-1-wakel@google.com>
References: <20260430112346.4054436-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] listmount04: Allow both EINVAL and EBADF for
 BEFORE_6_17_9 case
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

Hi Wake,

On 2026-04-30, Wake Liu wrote:
> listmount04: Allow both EINVAL and EBADF for BEFORE_6_17_9 case

> Change-Id: If5b138e64b7c3d8434eea180dd6adc845db44f42

Please drop the Change-Id tag before sending to the mailing list; it is a
Gerrit internal tracker and does not belong in upstream LTP patches.

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
