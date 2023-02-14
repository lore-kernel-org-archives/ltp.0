Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D177C6379F
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 14:14:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 808273CC598
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 15:14:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 81CAB3CB0B8
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 15:14:45 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2EF9B20025A
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 15:14:41 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 31EEEYCc025526;
 Tue, 14 Feb 2023 22:14:34 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from ubuntu01 (10.0.12.75) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Tue, 14 Feb 2023 22:14:32 +0800
Date: Tue, 14 Feb 2023 14:14:17 +0000
From: Leo Liang <ycliang@andestech.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+uXOX+EA/hOFsh4@ubuntu01>
References: <20230214122509.2957225-1-ycliang@andestech.com>
 <20230214122509.2957225-2-ycliang@andestech.com>
 <Y+uOimkvJ76Q8diX@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+uOimkvJ76Q8diX@pevik>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Originating-IP: [10.0.12.75]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 31EEEYCc025526
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v2 2/2] lib/tst_pid.c: Increase PIDS_RESERVED to avoid
 fork failure.
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

Hi Petr,

On Tue, Feb 14, 2023 at 02:37:14PM +0100, Petr Vorel wrote:
> Hi Leo,
> 
> > After Adjusting how we count used pid, we increase
> > the number of PIDS_RESERVED to void fork failure.
> nit: in this case I'd actually keep changes in single commit
> (otherwise first commit alone would break tests),
> 

That makes sense!
Then we could probably drop this v2 patch
and stay with the v1?

Best regards,
Leo

> Kind regards,
> Petr
> 
> > Suggested-by: Petr Vorel <pvorel@suse.cz>
> > Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Changes v1 -> v2
> > * Split into two patches
> > ---
> >  lib/tst_pid.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/lib/tst_pid.c b/lib/tst_pid.c
> > index a282f8cc9..7582e4828 100644
> > --- a/lib/tst_pid.c
> > +++ b/lib/tst_pid.c
> > @@ -36,7 +36,7 @@
> >  #define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
> >  #define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
> >  /* Leave some available processes for the OS */
> > -#define PIDS_RESERVE 50
> > +#define PIDS_RESERVE 200
> 
> >  pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
> >  {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
