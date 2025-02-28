Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A61C19776
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 14:17:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3729D3C9E5D
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 15:17:23 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 343A83C1E14
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 15:17:05 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=arm.com
 (client-ip=217.140.110.172; helo=foss.arm.com;
 envelope-from=cristian.marussi@arm.com; receiver=lists.linux.it)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by in-3.smtp.seeweb.it (Postfix) with ESMTP id 474E81BD40E5
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 15:17:04 +0100 (CET)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7586F1515;
 Fri, 28 Feb 2025 06:17:18 -0800 (PST)
Received: from pluto (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0B4283F6A8;
 Fri, 28 Feb 2025 06:17:01 -0800 (PST)
Date: Fri, 28 Feb 2025 14:16:52 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z8HFHQuYeCo-i9tM@pluto>
References: <20250227183359.918722-1-cristian.marussi@arm.com>
 <20250228130619.GB3222454@pevik> <Z8HC6E5dK9O8n6FS@pluto>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z8HC6E5dK9O8n6FS@pluto>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_fj_commmon.sh: Avoid explicitly disabling
 controllers on cleanup
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
Cc: aishwarya.tcv@arm.com, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Feb 28, 2025 at 02:06:32PM +0000, Cristian Marussi wrote:
> On Fri, Feb 28, 2025 at 02:06:19PM +0100, Petr Vorel wrote:
> > Hi all,
> > 
> > [ Cc Way and Li (1204b1d853), Cyril and Michal (the cgroup expert) ]
> > 
> 
 
[snip}

> 
> Indeed, we are using Bullseye with forced CGROUP v1 with:
> 
> 	systemd.legacy_systemd_cgroup_controller=true

and this (I forgot)

	systemd.unified_cgroup_hierarchy=false

Thanks,
Cristian

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
