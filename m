Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VCUhX-00027e-R7
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 13:13:23 +0000
Date: Thu, 22 Aug 2013 15:13:21 +0200
From: chrubis@suse.cz
Message-ID: <20130822131321.GA11897@rei.ASUS>
References: <1376637057-1744-1-git-send-email-stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1376637057-1744-1-git-send-email-stanislav.kholmanskikh@oracle.com>
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

> One of parameters to setgroups() syscall is (gid_t *) pointer.
> If TST_USE_COMPAT16_VSYSCALL is defined a pointer to GID_T is passed
> instead (and sizeof(GID_T) < sizeof(gid_t)). It's not safe and
> can result in unaligned access (and SIGBUS) on several platforms.
> 
> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
> ---
>  testcases/kernel/syscalls/setgroups/compat_16.h   |   22 +++++++++++++++++++-
>  testcases/kernel/syscalls/setgroups/setgroups04.c |    6 ++++-
>  2 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/setgroups/compat_16.h b/testcases/kernel/syscalls/setgroups/compat_16.h
> index 0de4e78..35723d6 100644
> --- a/testcases/kernel/syscalls/setgroups/compat_16.h
> +++ b/testcases/kernel/syscalls/setgroups/compat_16.h
> @@ -32,9 +32,27 @@ extern void cleanup(void);
>  #ifdef TST_USE_COMPAT16_SYSCALL
>  
>  long
> -SETGROUPS(size_t gidsetsize, GID_T *list)
> +SETGROUPS(size_t gidsetsize, GID_T *list16)
>  {
> -	return ltp_syscall(__NR_setgroups, gidsetsize, list);
> +	int r;
> +	int i;
> +
> +	gid_t *list32;
> +
> +	list32 = calloc(gidsetsize, sizeof(gid_t));
> +	if (list32 == NULL)
> +		tst_brkm(TBROK | TERRNO, NULL,
> +			"calloc failed to allocate %zu bytes at %s:%d",
> +			gidsetsize * sizeof(gid_t),
> +			__FILE__, __LINE__);
> +
> +	for (i = 0; i < gidsetsize; i++)
> +		list32[i] = list16[i];
> +
> +	r = ltp_syscall(__NR_setgroups, gidsetsize, list32);
> +
> +	free(list32);
> +	return r;
>  }

This looks like the __NR_setgroups is not the compact16 one we want.

Look at the getgroups16 in kernel/uid16.c it calls groups16_from_user()
and that does:


        for (i = 0; i < group_info->ngroups; i++) {
                if (get_user(group, grouplist+i))
                        return  -EFAULT;


The grouplist is of old_gid_t __user *grouplist type so it's unsigned short, so
it works with array of unsigned short which is aligned to unsigned shorts due
to definiton of the GID_T in the test sources, there is no way this
would trigger unaligned access.

And actually the GETGROUPS() seems to be coded to pass list32 and converts it
to list16 which looks just wrong to me as it's inside of
TST_USE_COMPAT16_SYSCALL. It just looks to me like we have wrong syscall
number to begin with.

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
