Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867C5C2BD09
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 09:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DAAD03D122C
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 11:24:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 97EB23C721F
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 21:57:05 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=aerifal.cx (client-ip=2001:19f0:5:42::1;
 helo=brightrain.aerifal.cx; envelope-from=dalias@aerifal.cx;
 receiver=lists.linux.it)
Received: from brightrain.aerifal.cx (brightrain.aerifal.cx
 [IPv6:2001:19f0:5:42::1])
 (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B52076020C4
 for <ltp@lists.linux.it>; Fri, 21 Jun 2024 21:57:02 +0200 (CEST)
Date: Fri, 21 Jun 2024 15:57:23 -0400
From: Rich Felker <dalias@libc.org>
To: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Message-ID: <20240621195723.GB10433@brightrain.aerifal.cx>
References: <20240620162316.3674955-1-arnd@kernel.org>
 <20240620162316.3674955-10-arnd@kernel.org>
 <366548c1a0d9749e42c0d0c993414a353c9b0b02.camel@physik.fu-berlin.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <366548c1a0d9749e42c0d0c993414a353c9b0b02.camel@physik.fu-berlin.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 27 Jun 2024 11:23:37 +0200
Subject: Re: [LTP] [musl] Re: [PATCH 09/15] sh: rework sync_file_range ABI
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
Cc: Andreas Larsson <andreas@gaisler.com>, linux-mips@vger.kernel.org,
 Guo Ren <guoren@kernel.org>, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linux-sh@vger.kernel.org,
 linux-csky@vger.kernel.org, "Naveen N . Rao" <naveen.n.rao@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, Brian Cain <bcain@quicinc.com>,
 musl@lists.openwall.com, Nicholas Piggin <npiggin@gmail.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>, ltp@lists.linux.it,
 Arnd Bergmann <arnd@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, libc-alpha@sourceware.org,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Jun 21, 2024 at 10:44:39AM +0200, John Paul Adrian Glaubitz wrote:
> Hi Arnd,
> 
> thanks for your patch!
> 
> On Thu, 2024-06-20 at 18:23 +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > The unusual function calling conventions on superh ended up causing
>                                               ^^^^^^
>                                        It's spelled SuperH
> 
> > sync_file_range to have the wrong argument order, with the 'flags'
> > argument getting sorted before 'nbytes' by the compiler.
> > 
> > In userspace, I found that musl, glibc, uclibc and strace all expect the
> > normal calling conventions with 'nbytes' last, so changing the kernel
> > to match them should make all of those work.
> > 
> > In order to be able to also fix libc implementations to work with existing
> > kernels, they need to be able to tell which ABI is used. An easy way
> > to do this is to add yet another system call using the sync_file_range2
> > ABI that works the same on all architectures.
> > 
> > Old user binaries can now work on new kernels, and new binaries can
> > try the new sync_file_range2() to work with new kernels or fall back
> > to the old sync_file_range() version if that doesn't exist.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 75c92acdd5b1 ("sh: Wire up new syscalls.")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  arch/sh/kernel/sys_sh32.c           | 11 +++++++++++
> >  arch/sh/kernel/syscalls/syscall.tbl |  3 ++-
> >  2 files changed, 13 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/sh/kernel/sys_sh32.c b/arch/sh/kernel/sys_sh32.c
> > index 9dca568509a5..d5a4f7c697d8 100644
> > --- a/arch/sh/kernel/sys_sh32.c
> > +++ b/arch/sh/kernel/sys_sh32.c
> > @@ -59,3 +59,14 @@ asmlinkage int sys_fadvise64_64_wrapper(int fd, u32 offset0, u32 offset1,
> >  				 (u64)len0 << 32 | len1, advice);
> >  #endif
> >  }
> > +
> > +/*
> > + * swap the arguments the way that libc wants it instead of
> 
> I think "swap the arguments to the order that libc wants them" would
> be easier to understand here.
> 
> > + * moving flags ahead of the 64-bit nbytes argument
> > + */
> > +SYSCALL_DEFINE6(sh_sync_file_range6, int, fd, SC_ARG64(offset),
> > +                SC_ARG64(nbytes), unsigned int, flags)
> > +{
> > +        return ksys_sync_file_range(fd, SC_VAL64(loff_t, offset),
> > +                                    SC_VAL64(loff_t, nbytes), flags);
> > +}
> > diff --git a/arch/sh/kernel/syscalls/syscall.tbl b/arch/sh/kernel/syscalls/syscall.tbl
> > index bbf83a2db986..c55fd7696d40 100644
> > --- a/arch/sh/kernel/syscalls/syscall.tbl
> > +++ b/arch/sh/kernel/syscalls/syscall.tbl
> > @@ -321,7 +321,7 @@
> >  311	common	set_robust_list			sys_set_robust_list
> >  312	common	get_robust_list			sys_get_robust_list
> >  313	common	splice				sys_splice
> > -314	common	sync_file_range			sys_sync_file_range
> > +314	common	sync_file_range			sys_sh_sync_file_range6
>                                                                  ^^^^^^ Why the suffix 6 here?
> 
> >  315	common	tee				sys_tee
> >  316	common	vmsplice			sys_vmsplice
> >  317	common	move_pages			sys_move_pages
> > @@ -395,6 +395,7 @@
> >  385	common	pkey_alloc			sys_pkey_alloc
> >  386	common	pkey_free			sys_pkey_free
> >  387	common	rseq				sys_rseq
> > +388	common	sync_file_range2		sys_sync_file_range2
> >  # room for arch specific syscalls
> >  393	common	semget				sys_semget
> >  394	common	semctl				sys_semctl
> 
> I wonder how you discovered this bug. Did you look up the calling convention on SuperH
> and compare the argument order for the sys_sync_file_range system call documented there
> with the order in the kernel?
> 
> Did you also check what order libc uses? I would expect libc on SuperH misordering the
> arguments as well unless I am missing something. Or do we know that the code is actually
> currently broken?

No, there's no reason libc would misorder them because syscalls aren't
function calls, and aren't subject to function call ABI. We have to
explicitly bind the arguments to registers and make a syscall
instruction.

The only reason this bug happened on the kernel side is that someone
thought it would be a smart idea to save maybe 10 instructions by
treating the register state on entry as directly suitable to jump from
asm to a C function rather than explicitly marshalling the arguments
out of the user-kernel syscall ABI positions into actual arguments to
a C function call.

Rich

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
