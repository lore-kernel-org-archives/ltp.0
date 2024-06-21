Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F213C27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:08:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC6CB3D0F73
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:08:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB32B3D0660
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 09:47:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=brauner@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id F0404601BBC
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 09:47:32 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E1CF662345;
 Fri, 21 Jun 2024 07:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ED54C2BBFC;
 Fri, 21 Jun 2024 07:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718956049;
 bh=+n1uE1MrLQMFhNN+7jwAvQajIquhPpIK6hC9WogIb1Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=VfFN+HuqInMOioum3nOUUAxrTdtVdjbZPYztVw5rmIyxcrJKkfr//GPMMvssZ97mF
 bc16USxoEeLnXgt2+ZWBhKfJaZxF6h94UXw/6wVZmRCosK7MzmOV/zy0hFkL9oAOTY
 pLA96PVGw92edy7QBoumKi8/eHn/jpPrkZVF8iciR02xYit0fMKT5AKfFI28z2S/Xo
 7cTGqzDyXh0801wUzYZXCV5iG5ibGw7x8NUtpfJaovfGEj4d4xgd71H8ZAoG1ltp5R
 DaYwRoRG9BedSojyfpOn0Rc1oP+3UrPp/XDKQIT4MVW7tJ4oBBcq8vXMRLFcoNlAPv
 I1hJb8yogM0Jw==
Date: Fri, 21 Jun 2024 09:47:19 +0200
From: Christian Brauner <brauner@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Message-ID: <20240621-jeden-hinab-e265b0d0807a@brauner>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-2-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240620162316.3674955-2-arnd@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
Subject: Re: [LTP] [PATCH 01/15] ftruncate: pass a signed offset
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
Cc: Rich Felker <dalias@libc.org>, Andreas Larsson <andreas@gaisler.com>,
 linux-mips@vger.kernel.org, Guo Ren <guoren@kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-sh@vger.kernel.org,
 linux-csky@vger.kernel.org, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, musl@lists.openwall.com,
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, ltp@lists.linux.it,
 Brian Cain <bcain@quicinc.com>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 20, 2024 at 06:23:02PM GMT, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The old ftruncate() syscall, using the 32-bit off_t misses a sign
> extension when called in compat mode on 64-bit architectures.  As a
> result, passing a negative length accidentally succeeds in truncating
> to file size between 2GiB and 4GiB.
> 
> Changing the type of the compat syscall to the signed compat_off_t
> changes the behavior so it instead returns -EINVAL.
> 
> The native entry point, the truncate() syscall and the corresponding
> loff_t based variants are all correct already and do not suffer
> from this mistake.
> 
> Fixes: 3f6d078d4acc ("fix compat truncate/ftruncate")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

Looks good to me,
Reviewed-by: Christian Brauner <brauner@kernel.org>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
