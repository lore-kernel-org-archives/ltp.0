Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2458CC61DA4
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 14:52:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B9823CC119
	for <ltp@archiver.kernel.org>; Thu, 16 Feb 2023 15:52:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C0553CB167
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 15:52:45 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 15CD2200B3F
 for <ltp@lists.linux.it>; Thu, 16 Feb 2023 15:52:41 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 31GEqXY0051864;
 Thu, 16 Feb 2023 22:52:33 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from ubuntu01 (10.0.12.75) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 16 Feb 2023 22:52:32 +0800
Date: Thu, 16 Feb 2023 14:52:14 +0000
From: Leo Liang <ycliang@andestech.com>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y+5DHpOxWi0iP8H0@ubuntu01>
References: <20230214122509.2957225-1-ycliang@andestech.com>
 <20230214122509.2957225-2-ycliang@andestech.com>
 <Y+uOimkvJ76Q8diX@pevik> <Y+uQB1iojD/0oQDY@yuki>
 <Y+uYAn0RyjKBTfj4@ubuntu01> <Y+uZ+ngyoz94gp9e@yuki>
 <Y+ukQAh4GMXh1TiK@yuki> <Y+3B1yAqIMrivj1O@ubuntu01>
 <Y+3tg68PkP7ce2eV@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+3tg68PkP7ce2eV@yuki>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Originating-IP: [10.0.12.75]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 31GEqXY0051864
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

Hi Cyril,

On Thu, Feb 16, 2023 at 09:46:59AM +0100, Cyril Hrubis wrote:
> Hi!
> > Just out of curiosity, is there any reason that we should do this in plain C ?
> > (Otherwise, we could drop this patchset and stay with the current implementation)
> 
> There are a few, calling random scripts from C is a bad practice
> overall.
> 
> Portabilitity may be one of the problems, there are several
> iimplementations of the basic UNIX utilities for Linux eg. coreutils,
> busybox, toybox, etc. These implemtations are subtly incompatible, not
> all commandline options are supported and so on. And for the busybox and
> toybox some options can be disabled at a compile time. We leaned that
> sometimes you have to double check if the functionality available and
> most of the time the end result is that it's just easier to rewrite the
> code in C.
> 
> We also have rule to make tests as self contained as possible, which
> simplifies debugging. One of the problems is that we do not have the
> environment the shell code runs in under control, we had a few test
> failing for non-standard settings of the LANG variables.
> 
> In this case the code is reasonably simple, so it will be less likely to
> be problematic, however I would stil lean towards replacing it with C
> code.
> 
> tl;dr Calling shell code from C programs makes things less predictable
>       and possibly unstable.
> 

Understood! Thank you for the detailed explanation!!
Will send a v3 patch ASAP in accordance with your advice!

Best regards,
Leo

> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
