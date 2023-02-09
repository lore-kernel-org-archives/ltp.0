Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6940CC61DA4
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 13:37:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6F5353CC0BE
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:37:03 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4FC633C03EB
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:36:54 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 539E32000AF
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:36:52 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 319DajAJ002528;
 Thu, 9 Feb 2023 21:36:45 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from ubuntu01 (10.0.12.75) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 9 Feb 2023 21:36:46 +0800
Date: Thu, 9 Feb 2023 13:36:36 +0000
From: Leo Liang <ycliang@andestech.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+T25EqnoMz60ESf@ubuntu01>
References: <20230207124008.1788759-1-ycliang@andestech.com>
 <Y+Tvqit/PmTn8Da5@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+Tvqit/PmTn8Da5@yuki>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Originating-IP: [10.0.12.75]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 319DajAJ002528
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_pids.c: fix fork failure on small memory
 systems
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

Hi Cyril,

On Thu, Feb 09, 2023 at 02:05:46PM +0100, Cyril Hrubis wrote:
> Hi!
> >  lib/tst_pid.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/lib/tst_pid.c b/lib/tst_pid.c
> > index 21cadef2a..3fb3f39ad 100644
> > --- a/lib/tst_pid.c
> > +++ b/lib/tst_pid.c
> > @@ -31,6 +31,7 @@
> >  #include "tst_safe_macros.h"
> >  
> >  #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
> > +#define THREADS_MAX_PATH "/proc/sys/kernel/threads-max"
> >  #define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
> >  #define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
> >  /* Leave some available processes for the OS */
> > @@ -113,7 +114,7 @@ static int get_session_pids_limit(void (*cleanup_fn) (void))
> >  int tst_get_free_pids_(void (*cleanup_fn) (void))
> >  {
> >  	FILE *f;
> > -	int rc, used_pids, max_pids, max_session_pids;
> > +	int rc, used_pids, max_pids, max_session_pids, max_threads;
> >  
> >  	f = popen("ps -eT | wc -l", "r");
> >  	if (!f) {
> > @@ -129,6 +130,8 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
> >  	}
> >  
> >  	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
> > +	SAFE_FILE_SCANF(cleanup_fn, THREADS_MAX_PATH, "%d", &max_threads);
> > +	max_pids = (max_pids < max_threads) ? max_pids : max_threads;
> 
> BTW: We do have a MIN() macro definition in tst_minmax.h header so we
>      can just do max_pids = MIN(max_pids, max_threads);
> 

Thanks for the review!
Will send a v2 to fix this!

Best regards,
Leo

> >  	max_session_pids = get_session_pids_limit(cleanup_fn);
> >  	if ((max_session_pids > 0) && (max_session_pids < max_pids))
> 
> Otherwise:
> 
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
