Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAEBC61DC2
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 07:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787731136; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6rioC7/CEfYj8YRB1eyq3bx6Ob4RB22qxjtkIusnrbg=;
 b=kjZEONyrj/17JVYejzIOz+/HCaBy1nxP41au0iMcoug8yTrjclkwCZu6GJrLhdovbbj9p
 keq6gBARUpnLcAI3sTfp/ISS0kT1NgLO0IhgBL9Tx5lrXgy/oZ/VaR+P3uu54Qy+8YEVM8R
 EZL0KvFu4XFS+QTZ99jvem5+nq4d1Sw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 629C83CBF5E
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 09:58:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 916093CA166
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:58:36 +0200 (CEST)
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com
 [IPv6:2a00:1450:4864:20::62e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21942200AD8
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 09:58:36 +0200 (CEST)
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-c214321dc32so71594066b.0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 00:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787731115; x=1788335915; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pnEq2munARd3NGZvF8V95Fv4HoesX0+C0Njf8vodu+s=;
 b=QgiQDC3UY/nDdapE20ujOwS9m6jFH0jWl8YsytXSOMdBJ8aIwN6RR3dMsQ56D84qsn
 2GTTcnJddw8rvMJ+4aia4zrmtRw9rkru+FUq2D4j+uE/f+xeKU49ePmI/L8k+LNAcJgp
 gBt3Vy2O4PvEgFyoAvY6+/Hu3ydxUP/QRzkLKhPYhoP/XegYzQDxtC0ZyYZP1VouiFpP
 l5fXL9QSkZ45dJEkqkPfuc3h8YHJHKzBP7k7tB3dyJh2wywHTWUf856frWqrVWpEh5Nx
 5Q+GyLlJJ36EroQ2AnZvlYt/+jfXtMXwHXfGwbGKdRx/bR4akkkIuxS/ETVEKo/UmQoi
 7Cyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787731115; x=1788335915;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pnEq2munARd3NGZvF8V95Fv4HoesX0+C0Njf8vodu+s=;
 b=V3Fz+x9aien6Ihc8PsBB48ZSif0OPc5V5BIMVL7PTfG1xgkmnjU5fSiakVPMnjso44
 5FUT4caC5uJhms2pm3anDgy+K432BUYlvZQ0Aslcobt3z2dMBuwlVaqayUj42XFCSN3I
 vgXV24yirauMOGRS7EGhBENPdxnOMzyZvPE/V2yPuqWLcGycM5ysvwMIUohz89yrzZOA
 niTPySkjOb+0udGivHOEpsrVT1hqNp997vRSPsaGntmGZmIfpf97UrvDDNZ3HvG3QqH3
 i9Kqde6QZmevKPnGwzMJyGhJsspgubeZoErM3ZQoquQj3x5ExGrO4FlzFVSq9NloGBnt
 Qw5w==
X-Gm-Message-State: AFuF++nubalj+kx1XUr6A3TuAXI0Mxl2Uy/tIB0jPhD5+BhONp5HAiCJ
 i6aafShPO9snNEjcHGR9vEddXGJhgWFALcaMwHVn3vrNtw1dPlt485+K/eXs3ZIpIUY=
X-Gm-Gg: AR+sD10sPNvY+Mw2OrEi3xEqI3rRo+2rJwSdhC5emtiwEO0OA3QIT+6nxPJH+0FHraz
 bw+e6i7a5kWkF7818b2O8v+DrTe0pMWlyZ0FgXjEElVwvGJCNYeL9bvpa3EKURdXXIopXDbffPY
 lBw4hP0Reo8Bv40jx31ZDEruQcIFE/2BLwPV7wue3jy0DQYtakLNbMtUPUVjT+xZ7YwJkngixE6
 29gd7Es5xJrMs1ze0ChMcRv1DDBb2AmWs8drIfbsAV5dI4EcjBKifxc2rTdv16LdiW1rEcxlhNx
 YSELIkagrx8SH1rGtE0dl6cqQUURTI5qwTnBm8OyJx3ZtQIsx2FD+XD3obGRjWUEFlZmZaslK11
 x8HGWgz81mDa8mUra734qUoPJL0uRvKOaKu2/TCIL/nmoIgxUNS6Jm9Tm4pDHrx1RL/D4Hg55j+
 6nq2XBkY5vlukS+sPN7Hr3y3xTmFF9uSDnDFzfFkAGUhpaN/Bwxoic/M1+aVuDY3otR61tqzCA9
 JNB7fRVcp4iMMXE0PQWX1adsSGbs3dPWpY1DfRhOVyUVsJBn4NZmeVWH0QNC9WYadEwn4g=
X-Received: by 2002:a17:907:998d:b0:c1a:5d49:f99d with SMTP id
 a640c23a62f3a-c250baffb5bmr655553566b.7.1787731115229; 
 Wed, 26 Aug 2026 00:58:35 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25258a0438sm124477566b.22.2026.08.26.00.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 00:58:35 -0700 (PDT)
Message-ID: <6a8e9cab.c5f98925.1b714b.83c7@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <ao6R_qZC1ged_wzE@autotest-wegao.qe.prg2.suse.org>
Date: Wed, 26 Aug 2026 07:58:34 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: Rate limit page-dirtying loop to
 prevent MemCG OOM-kills
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> The goal of this test is to reach memory.max and trigger kernel-driven 
> swapping as a direct result of hitting that limit.
> Proactively calling memory.reclaim forces swapping before reaching memory.max, 
> meaning the memory limit is never actually reached. Furthermore, if calling memory.reclaim 
> after hitting memory.max is too late to prevent OOM-kills on slow storage.
> So i do not think `memory.reclaim` solution can help on our oom failure.

memory.reclaim doesn't run during the pressure, but right after we
reached the memory limit, so OOM killer can be handled by excluding
it from the chain and getting an error instead of an OOM kill. In this
way we know if there's an error while swapping, instead of guessing that
device is too slow.

That's basically what we would do if we want to implement something
that is suitable for all the devices: we disable OOM killer in the cgroup,
we remove any sleep, we give a max runtime and if that is reached, it
means that after a number of attempts we are still not swapping -> TFAIL.

Just notice that what I just described is not so far from what OOM-killer
or memory.reclaim does. The ending result is exactly the same, but we
do things by hand.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
