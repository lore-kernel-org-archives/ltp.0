Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7062C61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 05:41:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 458263CC0E0
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 06:41:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BFFE33CB0F9
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 06:41:13 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 536F914002A9
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 06:41:10 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 31G5f0fn072044;
 Thu, 16 Feb 2023 13:41:00 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from ubuntu01 (10.0.12.75) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Feb 2023 13:40:56 +0800
Date: Thu, 16 Feb 2023 05:40:39 +0000
From: Leo Liang <ycliang@andestech.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+3B1yAqIMrivj1O@ubuntu01>
References: <20230214122509.2957225-1-ycliang@andestech.com>
 <20230214122509.2957225-2-ycliang@andestech.com>
 <Y+uOimkvJ76Q8diX@pevik> <Y+uQB1iojD/0oQDY@yuki>
 <Y+uYAn0RyjKBTfj4@ubuntu01> <Y+uZ+ngyoz94gp9e@yuki>
 <Y+ukQAh4GMXh1TiK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+ukQAh4GMXh1TiK@yuki>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Originating-IP: [10.0.12.75]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 31G5f0fn072044
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

Hi Cyril,

On Tue, Feb 14, 2023 at 04:09:52PM +0100, Cyril Hrubis wrote:
> Hi!
> > > > > > After Adjusting how we count used pid, we increase
> > > > > > the number of PIDS_RESERVED to void fork failure.
> > > > > nit: in this case I'd actually keep changes in single commit
> > > > > (otherwise first commit alone would break tests),
> > > > 
> > > > Do we get a different result from ps and parsing /proc? That sounds
> > > > strange...
> > > 
> > > I think that's because "ps -eT" would list threads with the same PID
> > > but with different SPID.
> > > 
> > > I get the following output on my VM.
> > > 
> > > ycliang@ubuntu01:~$ ps -eT | wc -l
> > > 170
> > > ycliang@ubuntu01:~$ ls -d /proc/[0-9]* | xargs -n1 | wc -l
> > > 127
> > 
> > Adjusting the RESERVED constant is then a lousy workaround that wouldn't
> > work for systems with many threads per process.
> > 
> > One alternative would be to open /proc/$PID/status and read the number
> > of threads from there. Should be as easy as one call to
> > SAFE_FILE_LINES_SCANF().
> 
> Thinking of it again using SAFE_FILE_LINES_SCANF() may be prone to a
> race where the process exits and the file disappears between the call to
> the readdir() and the open in the SAFE_FILE_LINES_SCANF() so I suppose
> that we should use just the FILE_LINES_SCANF() instead and add the
> threads value only if the call succeeded.

Thanks for the advice!
Will send a v3.

Just out of curiosity, is there any reason that we should do this in plain C ?
(Otherwise, we could drop this patchset and stay with the current implementation)

Best regards,
Leo

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
