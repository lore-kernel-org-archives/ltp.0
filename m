Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD27C25B10
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 06:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715323095; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pmHf/6xHiYUVTBYPRF2+wec9VxKsgLmToQZOt81Doz4=;
 b=deHg0VqzYC67AqGbzR9hRZbVG2oq/5sgSh7TzSkc/1kvL3MGP8whKDaCrss8I+SUpLfFK
 bWDem7s3jooBNZvP2XOxDwTbxZ7GofyNnuCPrbuxWMIHZiWULDJNhmF7TJzLGeSEHbsJGo4
 sa4hi48iNelQae1AXK//xhJCg9A40yc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 20CE53CE340
	for <ltp@archiver.kernel.org>; Fri, 10 May 2024 08:38:15 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 504143CE2EE
 for <ltp@lists.linux.it>; Fri, 10 May 2024 08:37:52 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=andestech.com (client-ip=60.248.80.70; helo=atcsqr.andestech.com;
 envelope-from=minachou@andestech.com; receiver=lists.linux.it)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E0CE91405162
 for <ltp@lists.linux.it>; Fri, 10 May 2024 08:37:48 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 44A6bZPo094640;
 Fri, 10 May 2024 14:37:35 +0800 (+08)
 (envelope-from minachou@andestech.com)
Received: from swlinux02 (10.0.15.183) by ATCPCS16.andestech.com (10.0.1.222)
 with Microsoft SMTP Server id 14.3.498.0;
 Fri, 10 May 2024 14:37:32 +0800
Date: Fri, 10 May 2024 14:37:29 +0800
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Zj3AqaAyuDp5YMGb@swlinux02>
References: <20240509090717.1342778-1-minachou@andestech.com>
 <20240509095439.GA263661@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509095439.GA263661@pevik>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Originating-IP: [10.0.15.183]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 44A6bZPo094640
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RESEND] [PATCH] hugemmap15: Support RISC-V to do
 __cache_flush.
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

On Thu, May 09, 2024 at 11:54:39AM +0200, Petr Vorel wrote:
> [EXTERNAL MAIL]
> 
> Hi Hui,
> 
> thanks, merged!
> 
> BTW how are the other RISC-V results in syscalls?
> Do you run other runtest files?
> 
> Kind regards,
> Petr
Hi Petr,

We ran all the runtest and found an issue with setitimer in syscalls. 
we've submitted a patch earlier[1] and is awaiting review ~~~

Another issue is hugemmap24, fails because the mmap address exceeds
TASK_SIZE. The test was designed for powerpc, but 1TB far exceeds
the riscv's TASK_SIZE=256G. The author hinted at a possible redesign[2], 
so we're ignoring this issue.

[1]: https://patchwork.ozlabs.org/project/ltp/patch/20240328083344.277502-1-minachou@andestech.com/
[2]: https://patchwork.ozlabs.org/project/ltp/patch/20230427034039.46512-1-liwang@redhat.com/

Thanks,
Mina

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
