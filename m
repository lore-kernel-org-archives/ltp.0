Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 229ADCA551C
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 09:29:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 10CD73CB312
	for <ltp@archiver.kernel.org>; Wed, 13 Sep 2023 11:29:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A7733C9947
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:29:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 32CC7602838
 for <ltp@lists.linux.it>; Wed, 13 Sep 2023 11:29:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15779218E8;
 Wed, 13 Sep 2023 09:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694597362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zkN0jprRlNgAWBNnwR9+n4RWOVj4MMw+4ONI9DbmTg=;
 b=sy/7mX2iw7iKv8P9spaqJzKhuvhMTMG7zNwc5tSfPCX0r8mq5sC5YkIUe+u9AxXK4XSUqs
 cR6JPoEcWTiAwdkObk2E+nbLNrdNFostv0/2Cn4Az6qCOMdUEl8g1Et3jILR0xBH8KbkpP
 Ci0yCSTsutSN0D9fjp49FPxHDkzu0ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694597362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3zkN0jprRlNgAWBNnwR9+n4RWOVj4MMw+4ONI9DbmTg=;
 b=CNYrhCga/C9N/KHhBo2n4aWMUeeYw4VKE6KPB/ijC8ftosBsahMcvFujh2F7XJFh61XT6b
 jBGdb8BTnnSy0jAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 05FCC13582;
 Wed, 13 Sep 2023 09:29:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id j0s1APKAAWUvRAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 13 Sep 2023 09:29:22 +0000
Date: Wed, 13 Sep 2023 11:30:08 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <ZQGBINUoRuEhTFwQ@yuki>
References: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvHhiiGKhNd=L9+xYFVwv0Q8k6gUBeFQGWCWw1cWhb50Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Qemu-arm64: LTP: cfs_bandwidth01: Unable to handle kernel
 NULL pointer dereference at virtual address 0000000000000038
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
Cc: Arnd Bergmann <arnd@arndb.de>, Linux PM <linux-pm@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 open list <linux-kernel@vger.kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Following kernel crash noticed on Linux stable-rc 6.5.3-rc1 on qemu-arm64 while
> running LTP sched tests cases.
> 
> This is not always reproducible.

What the test does is to create three levels of cgroups, sets CPU
quotas for them, runs bussy loop proceses in the groups and changes the
quotas during the time the bussy processes runs.

And the test is regression test for quite a few commits:

commit 39f23ce07b9355d05a64ae303ce20d1c4b92b957
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed May 13 15:55:28 2020 +0200

    sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list


commit b34cb07dde7c2346dec73d053ce926aeaa087303
Author: Phil Auld <pauld@redhat.com>
Date:   Tue May 12 09:52:22 2020 -0400

    sched/fair: Fix enqueue_task_fair() warning some more

commit fe61468b2cbc2b7ce5f8d3bf32ae5001d4c434e9
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri Mar 6 14:52:57 2020 +0100

    sched/fair: Fix enqueue_task_fair warning

commit 5ab297bab984310267734dfbcc8104566658ebef
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Fri Mar 6 09:42:08 2020 +0100

    sched/fair: Fix reordering of enqueue/dequeue_task_fair()

commit 6d4d22468dae3d8757af9f8b81b848a76ef4409d
Author: Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon Feb 24 09:52:14 2020 +0000

    sched/fair: Reorder enqueue/dequeue_task_fair path

commit fdaba61ef8a268d4136d0a113d153f7a89eb9984
Author: Rik van Riel <riel@surriel.com>
Date:   Mon Jun 21 19:43:30 2021 +0200

    sched/fair: Ensure that the CFS parent is added after unthrottling


Unless this is a random corruption we should look closer at scheduller
changes.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
