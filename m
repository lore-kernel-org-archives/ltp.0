Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44D39ECAAD3
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 10:51:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA5003CA8B0
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 12:51:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 85EF13CA729
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 12:51:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 867791400DB6
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 12:51:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BFEC4225EB;
 Thu,  1 Sep 2022 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1662029479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRXK/8ua0eLRMSgIZDjpLH+MwiXZGPpjw0K8EBRwqE0=;
 b=BChMpkbeZ6zNecKkriIOg4da01quG3Cf6/1PlGNyv/SwlgiDtIARexCO7VvfT+3/LeAEl8
 RpkWa6gLaVL7mr7GUw8mgsiANseX6Na+SgngQ1fisxAjFnFQh1bvhsgwwikZLOGchLSuKF
 JFtXitWKbkhLjim20uIQjkmmKW2cXPk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1662029479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nRXK/8ua0eLRMSgIZDjpLH+MwiXZGPpjw0K8EBRwqE0=;
 b=EcckEbbODnUsavB+EaSHKquLDlNjQCtLg0ogsADpc7imuqWU9daKW6WYbPyY95VqJFuf/D
 jh3MfUeK2RnckuAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0401F13A79;
 Thu,  1 Sep 2022 10:51:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9cyyLaaOEGPkdAAAMHmgww
 (envelope-from <akumar@suse.de>); Thu, 01 Sep 2022 10:51:18 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it, Li Wang <liwang@redhat.com>
Date: Thu, 01 Sep 2022 16:21:16 +0530
Message-ID: <1830205.tdWV9SEqCh@localhost>
Organization: SUSE
In-Reply-To: <CAEemH2eLoJwm_+ORaoT7xamtqvLTekN7H7NWmU-ErXPMdK+77w@mail.gmail.com>
References: <20220830105418.15966-1-akumar@suse.de>
 <CAEemH2eLoJwm_+ORaoT7xamtqvLTekN7H7NWmU-ErXPMdK+77w@mail.gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getsid02.c: Rewrite using new LTP API
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

On Wednesday, August 31, 2022 12:10:44 PM IST Li Wang wrote:
> On Tue, Aug 30, 2022 at 6:54 PM Avinesh Kumar <akumar@suse.de> wrote:
> 
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >  testcases/kernel/syscalls/getsid/getsid02.c | 83 +++++----------------
> >  1 file changed, 17 insertions(+), 66 deletions(-)
> >
> > diff --git a/testcases/kernel/syscalls/getsid/getsid02.c
> > b/testcases/kernel/syscalls/getsid/getsid02.c
> > index b5ab339e2..c235af362 100644
> > --- a/testcases/kernel/syscalls/getsid/getsid02.c
> > +++ b/testcases/kernel/syscalls/getsid/getsid02.c
> > @@ -1,81 +1,32 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> >  /*
> > - *
> >   *   Copyright (c) International Business Machines  Corp., 2001
> >   *   Copyright (c) 2012 Cyril Hrubis <chrubis@suse.cz>
> > - *
> > - *   This program is free software;  you can redistribute it and/or modify
> > - *   it under the terms of the GNU General Public License as published by
> > - *   the Free Software Foundation; either version 2 of the License, or
> > - *   (at your option) any later version.
> > - *
> > - *   This program is distributed in the hope that it will be useful,
> > - *   but WITHOUT ANY WARRANTY;  without even the implied warranty of
> > - *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See
> > - *   the GNU General Public License for more details.
> > - *
> > - *   You should have received a copy of the GNU General Public License
> > - *   along with this program;  if not, write to the Free Software
> > - *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
> > 02110-1301 USA
> > + *   Copyright (c) 2022 SUSE LLC Avinesh Kumar <avinesh.kumar@suse.com>
> >   */
> >
> > -#define _GNU_SOURCE 1
> > -
> > -#include "test.h"
> > -
> > -#include <errno.h>
> > +/*\
> > + * [Description]
> > + *
> > + * Verify that getsid(2) fails with ESRCH errno when there is no
> > + * process found with process ID pid.
> > + */
> >
> > -char *TCID = "getsid02";
> > -int TST_TOTAL = 1;
> > +#include "tst_test.h"
> >
> >  static pid_t unused_pid;
> >
> > -static void cleanup(void);
> > -static void setup(void);
> > -
> > -int main(int ac, char **av)
> > +static void setup(void)
> >  {
> > -       int lc;
> > -
> > -       tst_parse_opts(ac, av, NULL, NULL);
> > -
> > -       setup();
> > -
> > -       for (lc = 0; TEST_LOOPING(lc); lc++) {
> > -               tst_count = 0;
> > -
> > -               TEST(getsid(unused_pid));
> > -
> > -               if (TEST_RETURN == 0) {
> > -                       tst_resm(TFAIL, "call succeed when failure
> > expected");
> > -                       continue;
> > -               }
> > -
> > -               switch (TEST_ERRNO) {
> > -               case ESRCH:
> > -                       tst_resm(TPASS, "expected failure - errno = %d -
> > %s",
> > -                                TEST_ERRNO, strerror(TEST_ERRNO));
> > -                       break;
> > -               default:
> > -                       tst_resm(TFAIL, "call failed to produce "
> > -                                "expected error - errno = %d - %s",
> > -                                TEST_ERRNO, strerror(TEST_ERRNO));
> > -                       break;
> > -               }
> > -       }
> > -
> > -       cleanup();
> > -       tst_exit();
> > +       unused_pid = tst_get_unused_pid();
> >
> 
> We can simply move this to the main function to avoid unused PID
> reusing again if people perform test with '-i N'.
> 
> How about this below:
> 
> #include "tst_test.h"
> 
> static void run(void)
> {
>     pid_t unused_pid;
>     unused_pid = tst_get_unused_pid();
> 
>     TST_EXP_FAIL(getsid(unused_pid), ESRCH);
> }
> 
> static struct tst_test test = {
>     .test_all = run
> };
> 
> 
Yes, I agree to your suggestion. But while testing '-i N' with this code
also I am getting the same unused_pid which is equal to 
/proc/sys/kernel/pid_max in my env.


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
