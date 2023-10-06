Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5FFE92FDE
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 10:05:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 893073C8EC8
	for <ltp@archiver.kernel.org>; Fri,  6 Oct 2023 12:05:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57F0F3C2969
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 12:04:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3665860028C
 for <ltp@lists.linux.it>; Fri,  6 Oct 2023 12:04:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id A9210210E0;
 Fri,  6 Oct 2023 10:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696586696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejqvNCHLOjb7UP7xSpPWsCZ0SGJd4ujMlA9oPXUqcSU=;
 b=FxTzczUUsc/Ll3+HIcn10auawNu3VvUNTcBORlo61TRH3kro1vEQFQ3PjAdZRYIyxiwE1u
 4bk5CV1AYO1UjiURiJiCA7M+r0okV+kqpMlR5LokC5g4zvY5ppFSeLC7LOKPrzD86+GND4
 BeSpPbAzqiV+uHCYbscgK70yu5Fyn4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696586696;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ejqvNCHLOjb7UP7xSpPWsCZ0SGJd4ujMlA9oPXUqcSU=;
 b=HULUL1W7zPP61ltVO00KcTydDOfyv5DMbleXqCPG/kKgFtwPHbIZIlylXJN/PWNV6HJegp
 td6TwFaMIaGP7sDQ==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 5877D2C142;
 Fri,  6 Oct 2023 10:04:56 +0000 (UTC)
References: <20230905114157.4190-1-andrea.cervesato@suse.de>
 <20230905114157.4190-2-andrea.cervesato@suse.de> <87mswx1lul.fsf@suse.de>
 <a379dd67-e786-41b9-91d0-5606cd67d419@suse.com>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Date: Fri, 06 Oct 2023 10:45:49 +0100
Organization: Linux Private Site
In-reply-to: <a379dd67-e786-41b9-91d0-5606cd67d419@suse.com>
Message-ID: <87edi812yi.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Rewrite gettid01 test
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Andrea Cervesato <andrea.cervesato@suse.com> writes:

> Hi!
>
> On 10/5/23 10:50, Richard Palethorpe wrote:
>> Hello,
>>
>> Andrea Cervesato <andrea.cervesato@suse.de> writes:
>>
>>> From: Andrea Cervesato <andrea.cervesato@suse.com>
>>>
>>> The old test wasn't doing anything meaningful, but just checking
>>> gettid() syscall was working. In this test we checks if gettid() is
>>> working and if PID differs from its return value.
>>>
>>> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
>>> ---
>>>   testcases/kernel/syscalls/gettid/gettid01.c | 102 +++-----------------
>>>   1 file changed, 14 insertions(+), 88 deletions(-)
>>>
>>> diff --git a/testcases/kernel/syscalls/gettid/gettid01.c b/testcases/kernel/syscalls/gettid/gettid01.c
>>> index 7e5b6b175..3ee139d5f 100644
>>> --- a/testcases/kernel/syscalls/gettid/gettid01.c
>>> +++ b/testcases/kernel/syscalls/gettid/gettid01.c
>>> @@ -1,96 +1,22 @@
>>> +// SPDX-License-Identifier: GPL-2.0-or-later
>>>   /*
>>> - * Crackerjack Project
>>> - *
>>> - * Copyright (C) 2007-2008, Hitachi, Ltd.
>>> - * Author(s): Takahiro Yasui <takahiro.yasui.mp@hitachi.com>,
>>> - *            Yumiko Sugita <yumiko.sugita.yf@hitachi.com>,
>>> - *            Satoshi Fujiwara <sa-fuji@sdl.hitachi.co.jp>
>>> - *
>>> - * This program is free software; you can redistribute it and/or
>>> - * modify it under the terms of the GNU General Public License
>>> - * as published by the Free Software Foundation; either version 2
>>> - * of the License, or (at your option) any later version.
>>> - *
>>> - * This program is distributed in the hope that it will be useful,
>>> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> - * GNU General Public License for more details.
>>> - *
>>> - * You should have received a copy of the GNU General Public License
>>> - * along with this program; if not, write to the Free Software
>>> - * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
>>> - *
>>> - * $Id: gettid01.c,v 1.5 2009/10/26 14:55:47 subrata_modak Exp $
>>> + * Copyright (C) 2023 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>>> + */
>>> +/*\
>>> + * [Description]
>>>    *
>>> + * This test checks if parent pid is equal to tid in single-threaded
>>> + * application.
>>>    */
>>>   -/* Porting from Crackerjack to LTP is done
>>> -   by Masatake YAMATO <yamato@redhat.com> */
>>> -
>>> -#include <sys/types.h>
>>> -#include <linux/unistd.h>
>>> -#include <errno.h>
>>> -
>>> -#include "test.h"
>>> -
>>> -void setup();
>>> -void cleanup();
>>> +#include "tst_test.h"
>>> +#include "lapi/syscalls.h"
>>>   -char *TCID = "gettid01";
>>> -
>>> -int TST_TOTAL = 1;
>>> -
>>> -pid_t my_gettid(void)
>>> +static void run(void)
>>>   {
>>> -	return (pid_t) syscall(__NR_gettid);
>>> +	TST_EXP_EQ_LI(getpid(), tst_syscall(__NR_gettid));
>> Perhaps this is nit picking, but this assumes libc didn't put us in a
>> thread or just caches the wrong value in getpid. So it is more a test of
>> libc than the kernel.
> I understand the cache part. Probably we need to call
> tst_syscall(__NR_getpid) instead of getpid(), but I don't get the
> thread part. Is it possible that libc moves test function inside a
> thread?

I suppose it is possible, but very unlikely. I haven't seen anything
like that; I'm just using my wild imagination.

Perhaps we could check 'grep Threads /proc/self/status'? It should be
equal to 1. If not then something may have instrumented the process or
the system's libc is insane or something else. It's just some extra
debug info.

>> Is there some other way we could check that the main test process is not
>> a thread? There could be some file in proc I guess. Then we are
>> comparing information from multiple sources and it should all align.
>>
>> Also getpid could be called directly avoiding libc.
>>
>>>   }
>>>   -int main(int ac, char **av)
>>> -{
>>> -	int lc;
>>> -
>>> -	tst_parse_opts(ac, av, NULL, NULL);
>>> -
>>> -	setup();
>>> -
>>> -	/*
>>> -	 * The following loop checks looping state if -c option given
>>> -	 */
>>> -	for (lc = 0; TEST_LOOPING(lc); lc++) {
>>> -
>>> -		tst_count = 0;
>>> -
>>> -		TEST(my_gettid());
>>> -
>>> -		if (TEST_RETURN == -1) {
>>> -			tst_resm(TFAIL, "gettid() Failed, errno=%d: %s",
>>> -				 TEST_ERRNO, strerror(TEST_ERRNO));
>>> -		} else {
>>> -			tst_resm(TPASS, "gettid() returned %ld",
>>> -				 TEST_RETURN);
>>> -		}
>>> -	}
>>> -
>>> -	cleanup();
>>> -	tst_exit();
>>> -}
>>> -
>>> -/*
>>> - * setup() - performs all ONE TIME setup for this test.
>>> - */
>>> -void setup(void)
>>> -{
>>> -
>>> -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
>>> -
>>> -	TEST_PAUSE;
>>> -
>>> -}
>>> -
>>> -/*
>>> - * cleanup() - performs all ONE TIME cleanup for this test at
>>> - *		completion or premature exit.
>>> - */
>>> -void cleanup(void)
>>> -{
>>> -}
>>> +static struct tst_test test = {
>>> +	.test_all = run,
>>> +};
>>> -- 2.35.3
>>
> Andrea


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
