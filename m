Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8C7DC27C4F
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 09:08:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3853C3D0F38
	for <ltp@archiver.kernel.org>; Fri, 21 Jun 2024 11:08:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27C473D0E2C
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:28:34 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=alpha.franken.de (client-ip=193.175.24.41; helo=elvis.franken.de;
 envelope-from=tsbogend@alpha.franken.de; receiver=lists.linux.it)
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
 by in-5.smtp.seeweb.it (Postfix) with ESMTP id 736B56001F5
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 10:28:32 +0200 (CEST)
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
 id 1sKZbl-0001Si-00; Fri, 21 Jun 2024 10:26:57 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
 id 2189CC0120; Fri, 21 Jun 2024 10:25:23 +0200 (CEST)
Date: Fri, 21 Jun 2024 10:25:23 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Arnd Bergmann <arnd@kernel.org>
Message-ID: <ZnU480Ypb3f3nOek@alpha.franken.de>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-4-arnd@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240620162316.3674955-4-arnd@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 21 Jun 2024 11:00:08 +0200
Subject: Re: [LTP] [PATCH 03/15] mips: fix compat_sys_lseek syscall
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
 Nicholas Piggin <npiggin@gmail.com>, Alexander Viro <viro@zenIV.linux.org.uk>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, ltp@lists.linux.it,
 Brian Cain <bcain@quicinc.com>, Christian Brauner <brauner@kernel.org>,
 libc-alpha@sourceware.org, linux-parisc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Jun 20, 2024 at 06:23:04PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> This is almost compatible, but passing a negative offset should result
> in a EINVAL error, but on mips o32 compat mode would seek to a large
> 32-bit byte offset.
> 
> Use compat_sys_lseek() to correctly sign-extend the argument.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/mips/kernel/syscalls/syscall_o32.tbl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kernel/syscalls/syscall_o32.tbl b/arch/mips/kernel/syscalls/syscall_o32.tbl
> index 85751c9b9cdb..2439a2491cff 100644
> --- a/arch/mips/kernel/syscalls/syscall_o32.tbl
> +++ b/arch/mips/kernel/syscalls/syscall_o32.tbl
> @@ -27,7 +27,7 @@
>  17	o32	break				sys_ni_syscall
>  # 18 was sys_stat
>  18	o32	unused18			sys_ni_syscall
> -19	o32	lseek				sys_lseek
> +19	o32	lseek				sys_lseek			compat_sys_lseek
>  20	o32	getpid				sys_getpid
>  21	o32	mount				sys_mount
>  22	o32	umount				sys_oldumount
> -- 
> 2.39.2

applied to mips-fixes.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
