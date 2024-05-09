Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A00C10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 08:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715243722; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=7YCF95qSxVZFV8XvBo22X11JsSgHt0JoZpEE+LGclLk=;
 b=NfcsOsGgsjbrnCFibUHM7P2SbW7p0Dq39OAUjiEZbrH7TnEQLeMyK2YREfSsfCRMASZ0Q
 AV53Enl013TmG7Jj0wioNNLVQtQ/rqheadhr97qEGoj0ypz78tSBKx9JgSKNDOdUrhAX8zv
 6h7OVL5QEzSKLBhNXWKA/Bfds6DPtyc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 613FB3CE0D9
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 10:35:22 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 042303CE088
 for <ltp@lists.linux.it>; Thu,  9 May 2024 10:35:00 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7BD441A00916
 for <ltp@lists.linux.it>; Thu,  9 May 2024 10:34:56 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 4498YiKA048566;
 Thu, 9 May 2024 16:34:44 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Thu, 9 May 2024 16:34:42 +0800
Date: Thu, 9 May 2024 16:34:38 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZjyKnmdVd1Nj7_kR@swlinux02>
References: <20240509052541.18707-1-minachou@andestech.com>
 <20240509080649.GB234264@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509080649.GB234264@pevik>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 4498YiKA048566
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] hugemmap15: Support RISC-V to do __cache_flush.
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
Cc: tim609@andestech.com, cynthia@andestech.com, az70021@gmail.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, May 09, 2024 at 10:06:49AM +0200, Petr Vorel wrote:
> [EXTERNAL MAIL]
> 
> Hi Hui,
> 
> > AndesCore CPU test fails due to an illegal instruction at the first
> > jumpfunc(), caused by executing incorrect instructions after
> > self-modifying code.
> 
> > On RISC-V CPUs, a FENCE.i synchronizes instruction and data streams,
> > ensuring that subsequent instruction fetch on a RISC-V hart will see
> > any previous data stores already visible to the same RISC-V hart.
> 
> > Thus, cacheflush() in the test should also use __clear_cache for RISC-V.
> > In SMP systems, it invokes the kernel syscall riscv_flush_icache to inform
> > each hart to flush their local i-caches.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> BTW what "#79" in the git message subject means?
> 
> Kind regards,
> Petr
Hi Petr,

Sorry, that was my mistake. I'll remove it and send another one.

Thanks,
Mina

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
