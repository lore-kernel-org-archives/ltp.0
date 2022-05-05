Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C780C433EF
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 08:54:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 218273CA891
	for <ltp@archiver.kernel.org>; Thu,  5 May 2022 10:54:43 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 908543CA789
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:54:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 02E8E600943
 for <ltp@lists.linux.it>; Thu,  5 May 2022 10:54:31 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 25CF8218EA;
 Thu,  5 May 2022 08:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1651740871;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9rvd2LB0zod5FlJB+LI3MNJvS5mv+sZD6WFHRnO1J8=;
 b=nkeu1llNDwLhGohP3y6LRpRPZ++g7A3logxO+uJD2rGuqe8dONJ9gQX14Niuj0Zia41woh
 +KvnqMDDg1RLFi7sqAd3Wdkp/4uGZj/9EnOi5E+YFtMdpP48TGZ9wGWaA/AsnHtQ3YMaX+
 tOCCGFX7IWC8LUmpDuuE1eJWmnNIZfQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1651740871;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T9rvd2LB0zod5FlJB+LI3MNJvS5mv+sZD6WFHRnO1J8=;
 b=UxHQ7f6Johy82moYBxCrIlPR9kLEb2kDwijqRM1PP4Q6xrCooekx3UfipnKxccy/3DaGyk
 hgex7aMlCGxZuQDQ==
Received: from g78 (unknown [10.163.24.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CDD9E2C141;
 Thu,  5 May 2022 08:54:30 +0000 (UTC)
References: <20220503174718.21205-1-chrubis@suse.cz>
 <20220503174718.21205-24-chrubis@suse.cz> <YnGe7Z5mw03+UuLa@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 05 May 2022 09:51:49 +0100
In-reply-to: <YnGe7Z5mw03+UuLa@pevik>
Message-ID: <87o80ccqbd.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Automated-testing] [PATCH v2 23/30] fuzzy_sync: Convert
 to runtime
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Cyril,
>
>> The runtime for fuzzy sync tests are computed as timeout * exec_time_p.
>> The default timeout was 300 and the default was 0.5.
>
>> CC: Richard Palethorpe <rpalethorpe@suse.com>
>> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> ---
>>  include/tst_fuzzy_sync.h                      | 19 ++++---------------
>>  testcases/kernel/crypto/af_alg07.c            |  1 +
>>  testcases/kernel/mem/thp/thp04.c              |  1 +
>>  testcases/kernel/pty/pty03.c                  |  2 +-
>>  testcases/kernel/pty/pty05.c                  |  1 +
>>  testcases/kernel/pty/pty06.c                  |  1 +
>>  testcases/kernel/pty/pty07.c                  |  1 +
>>  testcases/kernel/sound/snd_seq01.c            |  2 +-
>>  testcases/kernel/sound/snd_timer01.c          |  1 +
>>  testcases/kernel/syscalls/bind/bind06.c       |  2 +-
>>  testcases/kernel/syscalls/inotify/inotify09.c |  1 +
>>  .../kernel/syscalls/ipc/shmctl/shmctl05.c     |  2 +-
>>  testcases/kernel/syscalls/sendmsg/sendmsg03.c |  1 +
>>  .../kernel/syscalls/setsockopt/setsockopt06.c |  2 +-
>>  .../kernel/syscalls/setsockopt/setsockopt07.c |  1 +
>>  .../syscalls/timerfd/timerfd_settime02.c      |  1 +
>>  testcases/kernel/syscalls/writev/writev03.c   |  2 +-
>>  17 files changed, 20 insertions(+), 21 deletions(-)
>
> FYI you haven't converted fuzzy sync tests.
> I suppose these errors must be fix in first commit.
>
> ./tst_fuzzy_sync01
> tst_test.c:1522: TINFO: Timeout per run is 0h 00m 30s
> tst_test.c:1483: TBROK: Runtime not set!

Ah, I see the missing runtime actually causes an error. I would have
expected it to use a default 5 seconds?

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
