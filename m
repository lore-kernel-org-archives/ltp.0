Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6986DC001DB
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 08:30:52 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 91E003C62DA
	for <ltp@archiver.kernel.org>; Thu, 10 Aug 2023 10:30:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6974A3C62DA
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 10:30:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 96823601188
 for <ltp@lists.linux.it>; Thu, 10 Aug 2023 10:30:37 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0238A1F38D;
 Thu, 10 Aug 2023 08:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691656236; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4d3gomxYT1ofllTPcuCL5wAFLP4dHrlKfTQkkM4UoSo=;
 b=CFfrlaRrwFYH55gobDW59FO9zFem56DMOsW1c2+8bFAwqwIzwReIzZaHdNjyJltqAecC33
 c1ll0noLNld3YY7z4knnxr321ZK4fwqEuol35t+4tCCNBPqz6M4tYzy7ifY8QQlX42gP1Q
 1YB+LssHWsKw/kHrXVDsGOkV+Vn/Ut8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691656236;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4d3gomxYT1ofllTPcuCL5wAFLP4dHrlKfTQkkM4UoSo=;
 b=Jjm8j1DeiffXz3bDNzS0qqR57eBdMif8asgSlM/AkiMje3jw1VCs0ObPGzZYQcn4ZcWDjI
 9qNCBtq5lEoOBpAw==
Received: from suse.de (mgorman.tcp.ovpn2.nue.suse.de [10.163.32.246])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id CFA742C142;
 Thu, 10 Aug 2023 08:30:33 +0000 (UTC)
Date: Thu, 10 Aug 2023 09:30:28 +0100
From: Mel Gorman <mgorman@suse.de>
To: Peter Zijlstra <peterz@infradead.org>
Message-ID: <20230810083028.l2ov4wpffhv3zw3h@suse.de>
References: <20230802151906.25258-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230802151906.25258-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2 RESEND] Two fixes for sysctl_sched_rr_timeslice
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
Cc: Juri Lelli <juri.lelli@redhat.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 02, 2023 at 05:19:04PM +0200, Cyril Hrubis wrote:
> - Fixes rounding error for initial value with CONFIG_HZ_300
> 
> - Fixes read from the file after reset to default (by writing val <= 0)
> 

Hi Peter,

Any chance this can be picked up in tip please? It might have helped if
the leader mentioned the main problem covered in patch 1 -- some HZ
values can fail LTP tests due to a simple rounding error at compile
time.

-- 
Mel Gorman
SUSE Labs

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
