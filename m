Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9883CD128A
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 03:16:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1712546172; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=dHDkA6LweOBoEBt/liGx5gLNKVkpyuhqGscM9t36zws=;
 b=MP06XXbPaSK8fMS2ryEGGYDl97S/yH47jgvXRS5Q79XIzu741VyNvt66ERE9nIfSIoCvp
 Jxqn57Uz6cF2lZANvqdH5TxKU1TfFoiS5csUGobvRHtSl86/E43XzlA21BatdBaAh0JL3nT
 xi1qv64ZnFBw0LjU6BQmsAcJegxqz5E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B11DD3CF557
	for <ltp@archiver.kernel.org>; Mon,  8 Apr 2024 05:16:12 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 10C3F3C13C1
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 05:15:48 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0D0E11A0079C
 for <ltp@lists.linux.it>; Mon,  8 Apr 2024 05:15:44 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4383FcP6022613
 for <ltp@lists.linux.it>; Mon, 8 Apr 2024 11:15:38 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Mon, 8 Apr 2024 11:15:34 +0800
Date: Mon, 8 Apr 2024 11:15:30 +0800
To: <ltp@lists.linux.it>
Message-ID: <ZhNhUlbGPGK_QbFJ@swlinux02>
References: <20240403051825.1545018-1-minachou@andestech.com>
 <Zg02mbnjInBl7pw_@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zg02mbnjInBl7pw_@yuki>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4383FcP6022613
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] waitid10: Set the core dump file location to
 temporary directory
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
From: Mina Chou via ltp <ltp@lists.linux.it>
Reply-To: Mina Chou <minachou@andestech.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Apr 03, 2024 at 12:59:37PM +0200, Cyril Hrubis wrote:
> [EXTERNAL MAIL]
> 
> Hi!
> > When testing via NFS mount LTP folder on the board, with the NFS server
> > configured using 'anonuid' and 'anongid' options to set specific
> > uid/gid, waitid10 fails. This is due to a uid mismatch during core dump
> > file creation, leading to an aborted dump, resulting in the child
> > process receiving the signal CLD_KILLED instead of CLD_DUMPED.
> >
> >   # ./waitid10
> >   tst_buffers.c:56: TINFO: Test is using guarded buffers
> >   tst_test.c:1732: TINFO: LTP version: 20240129
> >   tst_test.c:1616: TINFO: Timeout per run is 0h 05m 00s
> >   waitid10.c:64: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
> >   [  296.482665] mnt_uid= 1036, curr_uid= 0
> >   [  296.483041] Core dump to core aborted: cannot preserve file owner
> >   waitid10.c:36: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
> >   waitid10.c:37: TPASS: infop->si_pid == pidchild (149)
> >   waitid10.c:38: TPASS: infop->si_status == SIGFPE (8)
> >   waitid10.c:39: TPASS: infop->si_signo == SIGCHLD (17)
> >   waitid10.c:42: TFAIL: infop->si_code (2) != CLD_DUMPED (3)
> >
> > Therefore, referring to madvise08, during testing, set the core dump file
> > to the temporary directory instead of the current working directory. After
> > testing, restore the contents of /proc/sys/kernel/core_pattern and clear
> > all test temporary file.
> 
> Thanks for the detailed description, now it's clear what happens on your
> system.
> 
> >   # ./waitid10
> >   tst_buffers.c:56: TINFO: Test is using guarded buffers
> >   tst_test.c:1709: TINFO: LTP version: 20240129-45-g69537563d16a
> >   tst_test.c:1593: TINFO: Timeout per run is 0h 05m 00s
> >   waitid10.c:60: TINFO: Temporary core pattern is '/tmp/LTP_waiSzyEv2/core'
> >   waitid10.c:73: TINFO: Raising RLIMIT_CORE rlim_cur=0 -> 0
> >   [68549.534126] mnt_uid= 0, curr_uid= 0
> >   waitid10.c:38: TPASS: waitid(P_ALL, 0, infop, WEXITED) passed
> >   waitid10.c:39: TPASS: infop->si_pid == pidchild (163)
> >   waitid10.c:40: TPASS: infop->si_status == SIGFPE (8)
> >   waitid10.c:41: TPASS: infop->si_signo == SIGCHLD (17)
> >   waitid10.c:44: TPASS: infop->si_code == CLD_DUMPED (3)
> >
> > Signed-off-by: Hui Min Mina Chou <minachou@andestech.com>
> > ---
> >  testcases/kernel/syscalls/waitid/waitid10.c | 16 +++++++++++++++-
> >  1 file changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/testcases/kernel/syscalls/waitid/waitid10.c b/testcases/kernel/syscalls/waitid/waitid10.c
> > index e55e88c2325e..3e48f52d0ea8 100644
> > --- a/testcases/kernel/syscalls/waitid/waitid10.c
> > +++ b/testcases/kernel/syscalls/waitid/waitid10.c
> > @@ -16,6 +16,8 @@
> >  #include <sys/prctl.h>
> >  #include "tst_test.h"
> >
> > +#define CORE_PATTERN "/proc/sys/kernel/core_pattern"
> > +
> >  static siginfo_t *infop;
> >  static int core_dumps = 1;
> >
> > @@ -48,9 +50,16 @@ static void setup(void)
> >  {
> >       struct rlimit rlim;
> >       char c;
> > +     char cwd[1024];
> > +     char tmpcpattern[1048];
> >
> >       SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
> > -     SAFE_FILE_SCANF("/proc/sys/kernel/core_pattern", "%c", &c);
> > +
> > +     SAFE_GETCWD(cwd, sizeof(cwd));
> > +     snprintf(tmpcpattern, sizeof(tmpcpattern), "%s/core", cwd);
> > +     tst_res(TINFO, "Temporary core pattern is '%s'", tmpcpattern);
> > +     SAFE_FILE_PRINTF(CORE_PATTERN, "%s", tmpcpattern);
> > +     SAFE_FILE_SCANF(CORE_PATTERN, "%c", &c);
> 
> Given the description do we really need to change the core pattern?
> 
> I guess that just adding .needs_tmpdir = 1 would fix the test since the
> test $CWD would point to the test temporary directory.
>

Yes, you're right! Simply adding .needs_tmpdir = 1 can solve the issue.
Thanks, I'll revise another version.

> >       if (rlim.rlim_cur)
> >               return;
> > @@ -76,4 +85,9 @@ static struct tst_test test = {
> >               {&infop, .size = sizeof(*infop)},
> >               {},
> >       },
> > +     .needs_tmpdir = 1,
> > +     .save_restore = (const struct tst_path_val[]) {
> > +             {CORE_PATTERN, NULL, TST_SR_TCONF},
> > +             {}
> > +     },
> >  };
> > --
> > 2.34.1
> >
> >
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz

Thanks,
Mina

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
