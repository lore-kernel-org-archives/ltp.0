Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6935BC3DA7F
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 08:27:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACCF13D21B5
	for <ltp@archiver.kernel.org>; Thu, 15 Aug 2024 10:27:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 071503D219A
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:27:28 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linuxfoundation.org (client-ip=2604:1380:40e1:4800::1;
 helo=sin.source.kernel.org; envelope-from=gregkh@linuxfoundation.org;
 receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org
 [IPv6:2604:1380:40e1:4800::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 81B94600624
 for <ltp@lists.linux.it>; Thu, 15 Aug 2024 10:27:26 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6AEDECE1957;
 Thu, 15 Aug 2024 08:27:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC684C4AF0E;
 Thu, 15 Aug 2024 08:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1723710442;
 bh=v8P56oHNTYvbAAxCX1bbMP4akoI/55elIExQZz8jGoY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x0v9ZRzjzZ5mhfptkgtbMNTmD6JdDVWHeRNGmGANLYsAz7YzjXNX+VtFx06hz9t0K
 eS621uasixkYSjt/489e+4GYPLPeBwwAKIVoT/mmVADiSIzIY5lzVhEXcaSAD1KwQW
 mhHYMpPMaBuyuuR5m5sawgMbLpX2KxIiwWakBHE0=
Date: Thu, 15 Aug 2024 10:27:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: cel@kernel.org
Message-ID: <2024081509-surgical-surgical-fb94@gregkh>
References: <20240810200009.9882-1-cel@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240810200009.9882-1-cel@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6.1.y 00/18] Backport "make svc_stat per-net
 instead of global"
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
Cc: linux-nfs@vger.kernel.org, sherry.yang@oracle.com, stable@vger.kernel.org,
 Chuck Lever <chuck.lever@oracle.com>, calum.mackay@oracle.com,
 kernel-team@fb.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Sat, Aug 10, 2024 at 03:59:51PM -0400, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Following up on
> 
> https://lore.kernel.org/linux-nfs/d4b235df-4ee5-4824-9d48-e3b3c1f1f4d1@oracle.com/
> 
> Here is a backport series targeting origin/linux-6.1.y that closes
> the information leak described in the above thread.
> 
> I started with v6.1.y because that is the most recent LTS kernel
> and thus the closest to upstream. I plan to look at 5.15 and 5.10
> LTS too if this series is applied to v6.1.y.
> 
> Review comments welcome.

Now queued up, thanks.

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
