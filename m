Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VDuzw-00067w-CA
	for ltp-list@lists.sourceforge.net; Mon, 26 Aug 2013 11:30:16 +0000
Date: Mon, 26 Aug 2013 13:30:21 +0200
From: chrubis@suse.cz
Message-ID: <20130826113021.GA3344@rei>
References: <1376637057-1744-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20130822131321.GA11897@rei.ASUS> <52174875.9030606@oracle.com>
	<20130823113927.GA24285@rei> <521B331D.7050902@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <521B331D.7050902@oracle.com>
Subject: Re: [LTP] [PATCH] syscalls/setgroups: fix implicit SETGROUPS
 parameter casting
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> I looked at arch/* from linux sources and prepared this table:
> 
> Architecture | __NR_setgroups32 defined | __NR_setgroups defined | glibc 
> for setgroups() invokes |
> alpha            |     | + |
> arm              | + | + |
> avr32           |     | + |
> blackfin        | + | + |
> cris               | + | + |
> frv                | + | + |
> h8300           | + | + |
> ia64              | + |   |
> m32r            | + |   |
> m68k            | + | + |
> microblaze   | + | + |
> mips             |    | + |
> mn10300     | + | + |
> parisc           |    | + |
> powerpc       |    | + | setgroups   |
> s390             | + | + | setgroups32 |
> s390x           |     | + | setgroups   |
> sh-32            | + | + | setgroups32 |
> sh-64            | + | + | setgroups32 |
> sparc32        | + | + | setgroups32 |
> sparc64        |     | + | setgroups   |
> i386              | + | + | setgroups32 |
> x86_64         |     | + | setgroups   |
> xtensa          |    | + |
> 
> Sorry for formatting.
> 
> It looks like that if __NR_setgroups32 is defined then this means that 
> syscall pointed by __NR_setgroups is 16bit.
> 
> So how do you think about this patch ?
> 
> diff --git a/testcases/kernel/syscalls/setgroups/compat_16.h 
> b/testcases/kernel/syscalls/setgroups/compat_16.h
> index 0de4e78..8f46da9 100644
> --- a/testcases/kernel/syscalls/setgroups/compat_16.h
> +++ b/testcases/kernel/syscalls/setgroups/compat_16.h
> @@ -32,9 +32,16 @@ extern void cleanup(void);
>   #ifdef TST_USE_COMPAT16_SYSCALL
> 
>   long
> -SETGROUPS(size_t gidsetsize, GID_T *list)
> +SETGROUPS(size_t gidsetsize, GID_T *list16)
>   {
> -       return ltp_syscall(__NR_setgroups, gidsetsize, list);
> +# if (__NR_setgroups32 != __LTP__NR_INVALID_SYSCALL)
> +       /* __NR_setgroups - 16-bit version of setgroups() syscall */
> +       return ltp_syscall(__NR_setgroups, gidsetsize, list16);
> +# else
> +       /* The platform has no 16-bit version of setgroups() syscall */
> +       tst_brkm(TCONF, NULL,
> +               "16-bit version of setgroups() is not supported on your 
> arch");
> +# endif /* __NR_setgroups32 */

Looks good to me.

And we should fix the getgroups in the same header as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
