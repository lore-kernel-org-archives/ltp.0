Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3A43CD6E5D
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 07:11:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 125E53E196A
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:11:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09CA43CDC08
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 09:11:28 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 07CE41000A48
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 09:11:27 +0200 (CEST)
Date: Fri, 5 Jun 2026 15:11:21 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1780643486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yddrkEl0/HqVnTLYfYeTV+AV2eThvh4fGau0YNPEflw=;
 b=hNgLBfwxhFwzWnaMgRm1yYVXcCNNurTS9xZiJmlcJQTFljG4lWJ8t4byuvoGAdntRR0lbU
 h4ulXyockqAdj840N5QNUvEqahfv3+SfRnLSACpOkWRhFvmnBEA2GZNpBCEEBOZpCV0Ibx
 ckLZT6Y9ugpGx3NwAmXdm2aoGkore3E=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wei Gao <wegao@suse.com>
Message-ID: <aiJ0Yw8S0pCnSoqw@linux.dev>
Mail-Followup-To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20260605042942.30480-1-wegao@suse.com>
 <20260605052814.4342-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260605052814.4342-1-linuxtestproject.agent@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mmapstress06: Convert to new API
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

Hi Wei,

The refactoring generally looks good, but have minor issues:

1. We can remove the strict requirement for Cgroup V2.

2. Check gloabl RAM size, in Cgroup v2, memory.max limits
   physical RAM usage. If the system only has 256MB of
   physical RAM, the process can never reach the 500MB
   memory.max limit.

3. Set mem_limit/map_size to small values e.g. 128MB/256MB
   to make the test widely run.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
