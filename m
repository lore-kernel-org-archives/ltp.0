Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7F25CAC592
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 08:25:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C9163CDE2A
	for <ltp@archiver.kernel.org>; Mon, 22 Sep 2025 10:25:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 142403C1977
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 10:24:54 +0200 (CEST)
Received: from gnu.wildebeest.org (gnu.wildebeest.org [45.83.234.184])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F61E1400B8B
 for <ltp@lists.linux.it>; Mon, 22 Sep 2025 10:24:53 +0200 (CEST)
Received: by gnu.wildebeest.org (Postfix, from userid 1000)
 id B0CEF314137C; Mon, 22 Sep 2025 10:24:52 +0200 (CEST)
Date: Mon, 22 Sep 2025 10:24:52 +0200
From: Mark Wielaard <mark@klomp.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250922082452.GH19408@gnu.wildebeest.org>
References: <20250918152640.1146279-1-mark@klomp.org>
 <aND_aLgsukouVATL@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aND_aLgsukouVATL@yuki.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap04: Make sure the scanf address format is at
 least 8 hex chars
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
Cc: Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

On Mon, Sep 22, 2025 at 09:48:56AM +0200, Cyril Hrubis wrote:
> > The addresses in /proc/self/maps are at least 8 hex chars. Zeros are
> > added to the front of the address when shorted (both on 32bit and
> > 64bit systems.
> > 
> > Under valgrind the mmaps used in kernel/syscalls/mmap/mmap04.c come
> > out very low in the address space and might be shorter than 8 hex
> > chars. This causes the scanf to fail:
> > mmap04.c:62: TBROK: Expected 1 conversions got 0 FILE '/proc/self/maps'
> 
> I guess I do not understand the problem here. The PRIxPTR translates to
> "x", "lx", or "llx" depending on architecture and as far as I can tell
> the %x modifier handles leading zeroes just fine.

The problem is that we want to match (scanf) an absolute address
(addr2) at the start of the line. It is this absolute/literal address
that doesn't match (because it might not have leading zeros).

e.g. We might want to match the address 403a000 and want to match
against: 0403a000-04048000 rw-p

When creating the fmt which we want to use for scanf we currently
generate: "403a000-%*x %s" Which doesn't match because it is missing
the leading zero (the "-%*x %s" would match the rest, except that the
start of the line doesn't). So with the "%08" fix we would generate:
"0403a000-%*x %s" which does match because it has the same number of
leading zeros.

> > Fix this by using "%08" PRIxPTR when creating the fmt used.
> 
> Unfortunately this is not universally true. For example the vsyscall
> page is mapped at very high address on x86_64:
> 
> ffffffffff600000-ffffffffff601000 --xp 00000000 00:00 0                  [vsyscall]

Assuming we want to match the starting address ffffffffff600000 this
will work fine. "%08" PRIxPTR will generate that exact address without
extra leading zeros because it is already > 8 hex chars.

Hope that explains what is going on. The confusion might be because we
first use a patterns with sprintf to generate the pattern that we are
then going to use with scanf to parse both an actual/literal address
(plus hex address and perm string).

Cheers,

Mark

> > Signed-off-by: Mark Wielaard <mark@klomp.org>
> > ---
> >  testcases/kernel/syscalls/mmap/mmap04.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
> > index 4a050b7b50da..5b28180df29b 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap04.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> > @@ -58,7 +58,8 @@ static void run(unsigned int i)
> >  
> >  	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags | MAP_FIXED, -1, 0);
> >  
> > -	sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> > +	/* A /proc/self/maps address is at least 8 hex (left zero padded) */
> > +	sprintf(fmt, "%08" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> >  	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
> >  
> >  	if (!strcmp(perms, tc->exp_perms)) {
> > -- 
> > 2.51.0
> > 
> > 
> > -- 
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
