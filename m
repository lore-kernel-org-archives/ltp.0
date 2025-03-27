Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D176FC36010
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E70C3C9E46
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 13:04:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203593C0280
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 13:03:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1;
 helo=galois.linutronix.de; envelope-from=tglx@linutronix.de;
 receiver=lists.linux.it)
Received: from galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a0a:51c0:0:12e:550::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 524561A00607
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 13:03:47 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020; t=1743077026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hfLC1YzRrCnSz3zVHN/pjpVelGRCCdNDMqdXleTErQ=;
 b=2CUlHLYmmjHr8fA1hplaYjlX2Rrr8FAqj38qPquIDKCdbe75yEhV35v9E21QpEgQ1Llj4r
 h2L2DKGkRXV1sGbBkGJDMSGVNbSP29d1Bf6voVgtqQQ+fGNRAcMuIY3eDkqqrIXAuSVC0/
 p7EtCd9HTBFb15/sXq1HSnBk+87ARWybYmkZIgoJAk4kBIvu3wnWk271LFVjQNkuYl+fbU
 qY8DPXgkMlE77tRvgwt893msRjv9uc9SlrAa+tPGaWGGYyhmv8KpvzhnElV8sz0G/rStNk
 0exz6iv3SIkSnAGgiey1TUe5Gp3EV0L/nNkU3rbz1g6fVXWDAX8G4g8hTQIbqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
 s=2020e; t=1743077026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hfLC1YzRrCnSz3zVHN/pjpVelGRCCdNDMqdXleTErQ=;
 b=Wmy/qs0NDbZZdF3X/u0ciYSLBcE9k5CgAgiLntMaDI2TaiBSlDSZB+tTcr6ztoP4fqJel6
 e3uYGfvHLgDArOCQ==
To: kernel test robot <oliver.sang@intel.com>, Roger Pau Monne
 <roger.pau@citrix.com>
In-Reply-To: <202503271537.b451d717-lkp@intel.com>
References: <202503271537.b451d717-lkp@intel.com>
Date: Thu, 27 Mar 2025 13:03:46 +0100
Message-ID: <87semyy925.ffs@tglx>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [PCI/MSI] d9f2164238:
 Kernel_panic-not_syncing:Fatal_exception
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
Cc: Juergen Gross <jgross@suse.com>, lkp@intel.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, xen-devel@lists.xenproject.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 27 2025 at 16:29, kernel test robot wrote:
> kernel test robot noticed "Kernel_panic-not_syncing:Fatal_exception" on:
>
> commit: d9f2164238d814d119e8c979a3579d1199e271bb ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master

Fixed upstream.

3ece3e8e5976 ("PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI backends")

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
