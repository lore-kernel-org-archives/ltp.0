Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6F70ECAAD3
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 11:49:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96F103CAC4F
	for <ltp@archiver.kernel.org>; Thu, 15 Sep 2022 13:49:47 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BA7A3CAC06
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:49:35 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 357B11400DAF
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 13:49:32 +0200 (CEST)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.54])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MSwPf6bLxzmV8j
 for <ltp@lists.linux.it>; Thu, 15 Sep 2022 19:45:42 +0800 (CST)
Received: from canpemm500005.china.huawei.com (7.192.104.229) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 15 Sep 2022 19:49:29 +0800
Received: from canpemm500005.china.huawei.com ([7.192.104.229]) by
 canpemm500005.china.huawei.com ([7.192.104.229]) with mapi id 15.01.2375.031; 
 Thu, 15 Sep 2022 19:49:29 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Thread-Topic: [LTP] [PATCH] lib: Add checking of setup params in kernel
 command line
Thread-Index: AdjI9+7pXmkjsJmiSYeYM6GdwkH/yw==
Date: Thu, 15 Sep 2022 11:49:29 +0000
Message-ID: <aa31518506504f3d9504629c1341d2e4@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.67.110.209]
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: Add checking of setup params in kernel
 command line
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
From: zhaogongyi via ltp <ltp@lists.linux.it>
Reply-To: zhaogongyi <zhaogongyi@huawei.com>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!


> 
> Hi!
> > There are some test cases that need to check the configuration of
> > setup params, so we add tst_kernel_cmdline_check() to check it in
> > do_setup().
> 
> Can you elaborate on that? Which tests and what for?


In linux kernel, there are many setup params configured throng command line, for example, PSI is not enabled by default,
We need to set psi=1 in command line to enable it.

As far as I know, there is no testcase referenced setup param now. it can be considered as a possible use in future.


> 
> > Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
> > ---
> >  include/tst_kernel.h |  9 +++++++++
> >  include/tst_test.h   |  3 +++
> >  lib/tst_kernel.c     | 21 +++++++++++++++++++++
> >  lib/tst_test.c       |  9 +++++++++
> >  4 files changed, 42 insertions(+)
> >
> > diff --git a/include/tst_kernel.h b/include/tst_kernel.h index
> > 9e17bb71e..874ec3bf4 100644
> > --- a/include/tst_kernel.h
> > +++ b/include/tst_kernel.h
> > @@ -20,4 +20,13 @@ int tst_kernel_bits(void);
> >   */
> >  int tst_check_driver(const char *driver);
> >
> > +/*
> > + * Checks if there is a configuration in the kernel command line.
> > + *
> > + * @param cmd The setup param that need to be checked in command
> line.
> > + * @return Returns 0 if the kernel configured the setup param in
> command line.
> > + * -1 when the setup param is not configured.
> > + */
> > +int tst_kernel_cmdline_check(const char *cmd);
> > +
> >  #endif	/* TST_KERNEL_H__ */
> > diff --git a/include/tst_test.h b/include/tst_test.h index
> > ac52f268c..ba7d538b7 100644
> > --- a/include/tst_test.h
> > +++ b/include/tst_test.h
> > @@ -312,6 +312,9 @@ struct tst_test {
> >
> >  	/* {} terminated array of required CGroup controllers */
> >  	const char *const *needs_cgroup_ctrls;
> > +
> > +	/* NULL terminated array of required kernel cmdlines. */
> > +	const char *const *needs_kernel_cmdlines;
> >  };
> >
> >  /*
> > diff --git a/lib/tst_kernel.c b/lib/tst_kernel.c index
> > ecf4b917e..1e6d18e55 100644
> > --- a/lib/tst_kernel.c
> > +++ b/lib/tst_kernel.c
> > @@ -24,6 +24,8 @@
> >  #include "tst_kernel.h"
> >  #include "old_safe_stdio.h"
> >
> > +#define COMMAND_LINE_SIZE 4096
> > +
> >  static int get_kernel_bits_from_uname(struct utsname *buf)  {
> >  	if (uname(buf)) {
> > @@ -189,3 +191,22 @@ int tst_check_driver(const char *driver)
> >
> >  	return ret;
> >  }
> > +
> > +int tst_kernel_cmdline_check(const char *cmd) {
> > +	char cmdline[COMMAND_LINE_SIZE];
> > +
> > +	FILE *f = fopen("/proc/cmdline", "r");
> > +	if (f == NULL) {
> > +		tst_brkm(TBROK | TERRNO, NULL, "Open /proc/cmdline failed");
> > +		return -1;
> > +	}
> > +
> > +	while (fscanf(f, "%s", cmdline) > 0) {
> > +		if (!strcmp(cmdline, cmd))
> > +			return 0;
> > +	}
> > +
> > +	tst_brkm(TCONF, NULL, "Setup param '%s' is not configured", cmd);
> > +	return -1;
> > +}
> 
> If nothing else this call should really take the NULL terminated array as
> parameter and check for all flags so that we don't have to parse the file
> eac time we check for a flag.

> 
> Also there is no point in doing return from a function that calls tst_brkm().
> The function should just return void in this case.
> 
> > diff --git a/lib/tst_test.c b/lib/tst_test.c index
> > 8ccde1629..7a842c5ae 100644
> > --- a/lib/tst_test.c
> > +++ b/lib/tst_test.c
> > @@ -1125,6 +1125,15 @@ static void do_setup(int argc, char *argv[])
> >  	if (tst_test->min_kver)
> >  		check_kver();
> >
> > +	if (tst_test->needs_kernel_cmdlines)
> > +	{
> > +		const char *cmd;
> > +		int i;
> > +
> > +		for (i = 0; (cmd = tst_test->needs_kernel_cmdlines[i]); ++i)
> > +			tst_kernel_cmdline_check(cmd);
> > +	}
> > +
> >  	if (tst_test->supported_archs
> && !tst_is_on_arch(tst_test->supported_archs))
> >  		tst_brk(TCONF, "This arch '%s' is not supported for test!",
> > tst_arch.name);
> >
> > --
> > 2.17.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
