Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B66CD4F54
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 11:22:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 17D423CB041
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 13:22:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E54B43C2EB7
 for <ltp@lists.linux.it>; Wed, 27 May 2026 13:22:23 +0200 (CEST)
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com
 [91.218.175.186])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D7ABC100099D
 for <ltp@lists.linux.it>; Wed, 27 May 2026 13:22:22 +0200 (CEST)
Date: Wed, 27 May 2026 19:22:00 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779880940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wkAHJN1cH3wfWLJD284ERHSjVI/NuEAUHjzXIyJULmo=;
 b=AvmQVGOE/g4xKehtkTpAEGejR02LqyIXq5EZIdKj2YiFBHY07CrDV9IRbop6eMH5YpHdyA
 bAnTI+8qYuHtg3KZUxg6OAmMWSm+6uMAFAVpW8n6sHNw4cDi7iIVZgVr+q9Qqy6x7S8vMD
 WGgEEHa1YNOyxMojj9H2qeZpVVPbP70=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ahbT2MRuzwEo-RY2@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20260527103756.448843-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260527103756.448843-1-chrubis@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/madvise06: Fix sporadic not enough RAM
 TCONFs
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

Cyril Hrubis wrote:

> On systems with <= 2GB RAM the test produced sporadic TCONFs. That is
> because even if the test setup does sync() and drops caches the system
> starts fauting in pages immediatelly after caches were dropped. It may
> easily happen that system may fault in a few hundred of MBs of memory
> betwen the write to drop_caches and the time sysinfo() syscall returns.
> 
> The correct fix is to use the MemAvailable metric from /proc/meminfo
> that includes both free memory and caches and is more realistic estimate
> of how much memory can be consumed by a test. We even have helper
> functions in the test library so we simply make use of them.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>

Sounds reasonable.

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
