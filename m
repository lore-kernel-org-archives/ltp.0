Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 186F1CD3430
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 13:42:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B52D83E620A
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 15:42:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 049C83E2CA1
 for <ltp@lists.linux.it>; Mon,  4 May 2026 15:42:36 +0200 (CEST)
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com
 [95.215.58.189])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2377560074A
 for <ltp@lists.linux.it>; Mon,  4 May 2026 15:42:35 +0200 (CEST)
Date: Mon, 4 May 2026 21:42:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1777902155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+BpviM/qdnFiEf1iOEiHRR5i2VlCyDqklTUk2tZjH0U=;
 b=aMwIjXKW8iuSjQs1OPIqkY3q4vo75c2Cz2LluFRZmjNeDIoB9/noMfndJiz+EeSuUtf33/
 +AasU0WuVcSpkVDaU5HLj9iGLKUZiiGUq2VovNL1GtPVMn1Ws7ipzAvHgaT5GjMb1Onf75
 zigc+hzRLreYNkimYZ7A6A/PAVi6Wp4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <afiiLSAuuSt0AuBT@linux.dev>
Mail-Followup-To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <afNbfCcv83zeMsgZ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <afNbfCcv83zeMsgZ@yuki.lan>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

On Thu, Apr 30, 2026 at 03:39:08PM +0200, Cyril Hrubis wrote:
> Hi!
> Given that we have a SUSE Labs konference in the week starting 18. May I
> would like to start LTP May release preparations a bit sooner.
> 
> I would like to do the usual patch review that decides what goes into
> the release during the first two weeks of May. Followed by the
> pre-release freeze starting at the 18. May and final release at the end
> of the Month.
> 
> If there are any patches that should be considered to be included before
> the release, please reply to this email.

I have a cleanup patch (tested by me) to standardize the naming
of commonly used macros throughout LTP. This way, contributors
don't need to define various similar macros (e.g., /proc, /sys)
everywhere, we can manage/unify them all in one place.

It doesn't change any functionality, but it make sense for
engineering specifications.

Please consider merging this patch before release:
  https://lists.linux.it/pipermail/ltp/2026-May/048154.html

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
