Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2AA5EC05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 13:36:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D4CDA3CC0A8
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 14:36:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4C293C03EB
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:36:08 +0100 (CET)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9700A200747
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 14:36:05 +0100 (CET)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 319DZtNf002205;
 Thu, 9 Feb 2023 21:35:55 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from ubuntu01 (10.0.12.75) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0; Thu, 9 Feb 2023 21:35:51 +0800
Date: Thu, 9 Feb 2023 13:35:39 +0000
From: Leo Liang <ycliang@andestech.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y+T2qzXrZcGK/EQt@ubuntu01>
References: <20230207124008.1788759-1-ycliang@andestech.com>
 <Y+JVPi5jo++joA/g@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y+JVPi5jo++joA/g@pevik>
User-Agent: Mutt/2.0.5 (2021-01-21)
X-Originating-IP: [10.0.12.75]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 319DZtNf002205
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

Hi Petr,

On Tue, Feb 07, 2023 at 02:42:22PM +0100, Petr Vorel wrote:
> Hi Leo,
> 
> > Running syscalls/msgstress03 on a system with less than ~1 GB of RAM fails:
> 
> > 	msgstress03    1  TFAIL  :  msgstress03.c:163:  Fork failed (may be OK if under stress)
> 
> > The reason is that besides /proc/sys/kernel/pid_max, /proc/sys/kernel/threads-max
> > is another factor determining how many processes a system could create.
> 
> > Use the smaller number between pid_max and threads-max as the nprocs.
> 
> Makes sense.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW IMHO it'd be better to rewrite
> f = popen("ps -eT | wc -l", "r");
> to list count of /proc/[0-9]*/ in plain C (TODO for us).
>

Thanks for the review!
I could send a v2 to add this as well.

Best regards,
Leo

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
