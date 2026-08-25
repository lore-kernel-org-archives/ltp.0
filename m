Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE86C61DBC
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 17:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787680197; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=y9B30JOsuUSiAjfwZ9XNMp17zgmxjiyFn7I0vz9/UNo=;
 b=bDiPANgxukSCrnKNkm2RgylEkDLw7QL6quJE39e+Rrm+bQ9S5ug7EyLVCBRk1JBI/ett4
 gGzdxZmmhPvrL0jM6pEox03ezyP28x416A1ABr+1M4BU/68ckL7nUa83f7UcgLvopuy7dhj
 TmIHeT/cfOHbUaGCH67tGWiAx0M5dnM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 396093C7B15
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 19:49:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C4FC3C2CE3
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:49:34 +0200 (CEST)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com
 [IPv6:2a00:1450:4864:20::536])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4C1451000472
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 19:49:34 +0200 (CEST)
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a3819e8be8so188457a12.0
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 10:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787680174; x=1788284974; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pMWJ1xgVXuaSkS7yaDwTmmUc5WNh79zVkGaGPzhHbhw=;
 b=QmPE4jHNLVmQSub3ifRlR/B8zlyQK9aRQwlrgOGXB6jGQL4Duvag9X3cv7SDjGw4YW
 28SYUR23XJaRUsRNW1Yeu8JRmtR76FNjL/LST3nIsYEFw3hxYaT8T9Z2eU0xFyP3SUmr
 iSFXIG6IJH+24lL+k1rdQPfm/vfqlfQXa9+Qx6UH/4HjXFEBnYV5NKH7L6rhf5x6mqcD
 mpiSlxIAi3AU3bqyTPx5M6WjuOrIjIvEueXx0QlNz2pMeX4pVNC9VfePTO76Cj6pB6G3
 62sM+JXLnLq9WWMBZyKLMMFvxEIl9bhJtty0Krr3W651imHbMDy73cYJWI2BFjteTtMR
 tMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787680174; x=1788284974;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pMWJ1xgVXuaSkS7yaDwTmmUc5WNh79zVkGaGPzhHbhw=;
 b=Yj5tzCOJRDInvEyC7WdaKFTYqrSf3FLz/LHOdnnoP+3xUZ8+QEl6YQ6cAHX6eqzU/f
 uRseEHTZU5mlw4vf4F99aZFw5OgghNyhGwtlLaQdVsLDVR6S+Eb1k8FfduAvq7mEbIMF
 na4AOdOPz0LiK7Dd43bXpWnFoeMIre4J1nh9VJ2J6XARXmcMXN3XSgowg/D0PN9ZvnkV
 EJUIFj4Alm2INuyDUzonuPfHfAZb64F8fNvLcuwmZYcwytlE3SF31ZHrUHxjMebyhYMV
 6Bilyy65rTJvvolWQR8wQ8dbuxsQyByVBjvVLxDXR8Zhc4CDnLXea10xJR9HjDROT9Wf
 4vTA==
X-Gm-Message-State: AFuF++mlfQ0CuDvw8TEZRn5RxYw9cnubgpxGnPyaC05PgWuDRDwVW6H8
 ijDRXN0JDWHeWFzldRz7Hh4G9w6wQzoVb2T19BztAwK9vj6MHjE8zhBNV2+iT04n+NnedjWTP3D
 aRzNFu4c=
X-Gm-Gg: AR+sD11Sq2Y4MkTYHtLebdMvkBXa8yE80MiokLIHD2dx5ONSUuVH7XW5Oax8XpvOCWp
 kXI6HfbGK+oNWAX9moG11WNmS1ecvXhrG9XY52I0A8xO4rPhF6BeCEFOBF5HiQkbbvFzAYUaEEV
 sr6LMgEhPmaQF3IrBfzkQI1kIdKhPz+Y+6huXfWJePggn8uoxITOypqWGYr1qR/mSfWB4BmebRh
 vWlwthIZeMkPJqZF3rzJ+Ucro8CqTv0JbFte6wCh8tJu7FawSkHvcI83vfMUyuZSIuZbaJKUIeB
 KjCE/Lggyy12CQAjmcUGpcdc+vrTYKGNwRta/ZCSCtm1+DhgNNyR1IaF0QCZ5LvpNko0uy/77yu
 gUlGLemx9ElL/jLftHebAJq6WPCG4BuLSUDPP/u2Ogvk5hFHTJDOJkdllbL8rq1MmPR2EFnh+Rd
 6/W4PvAy0sxsdxYB3tnjBkB8+xM5Sp/HvJJiVc5H3B1jgOn6nUFxi8aXBRjiFDWXdhux50+ILjg
 PKW9Z2U5Yv/8uCTiKAXGDDuCHMn9cBJV1yR6RxUAPQvtq3tny92YgZQDmT1m5rn36v6R0Q=
X-Received: by 2002:a05:6402:1515:b0:6a5:d284:1134 with SMTP id
 4fb4d7f45d1cf-6a5d28413a6mr5276308a12.2.1787680173686; 
 Tue, 25 Aug 2026 10:49:33 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8b6412sm618693a12.2.2026.08.25.10.49.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:49:33 -0700 (PDT)
Message-ID: <6a8dd5ad.f6f3f786.161b9a.8106@mx.google.com>
To: sowmya.indranna@ibm.com
In-Reply-To: <20260819161032.1883-1-sowmya.indranna@ibm.com>
Date: Tue, 25 Aug 2026 17:49:32 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fs: Add fsplough entries to runtest
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

Hi Sowmya,

what's the purpose of this patch? That's used in the nfs testing suite.
In particular, nfs10.sh.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
