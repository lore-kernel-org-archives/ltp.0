Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A73DFFF8850
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 04:46:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1A9A53CE1C6
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 06:46:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 620863CCF96
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 06:46:29 +0200 (CEST)
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com
 [91.218.175.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C955310001DB
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 06:46:27 +0200 (CEST)
Date: Mon, 27 Apr 2026 12:46:17 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777265186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8uxUmcsgbkLUZ5l4qZ+oPfjoC2Qgie4LyKOyzy/Ibs=;
 b=dF1DDZwpgPTvip6fHns5sWOW5UdH/2RvURO3dLSY8Ai4ysdUx0FEgzE3VvyX9NSSUWyVGW
 pc3cgQnaxRFx4XMY+26nFkwXSL5pDDt/6MO7/gzQ+/9CO9MnZhUMXZSRnwIC04igrsbjlJ
 /aJ1Re6HrNM6iQpo72c3AuoXMkVFWMg=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ae7qGUvFo5NVHJrv@linux.dev>
Mail-Followup-To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it,
 Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>,
 Wei Gao <wegao@suse.com>, Jan Polensky <japo@linux.ibm.com>
References: <20260424101508.505501-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260424101508.505501-1-pvorel@suse.cz>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ioctl_pidfd06: Update kernel version
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

Petr Vorel wrote:

> Kernel commit ab89060fbc92e ("pidfs: return -EREMOTE when PIDFD_GET_INFO
> is called on another ns") from v7.0 was backported into stable/LTS
> kernels v6.18.14 (7446125afb6d9) and v6.19.10 (2920abaf56c09).
> Update errnos for these stable/LTS kernels (do not treat older behavior
> as an error).
> 
> Follow-up: f630471a6520 ("ioctl_pidfd06: Select expected errno for PIDFD_GET_INFO across pidns")
> Reported-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Works for me as well:

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
