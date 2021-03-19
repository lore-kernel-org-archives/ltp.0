From: Yang Xu <xuyang_jy_0410@163.com>
Date: Fri, 19 Mar 2021 10:56:03 +0800
Subject: [LTP] [PATCH] syscalls/semctl09: Skip libc test if SEM_STAT_ANY
 not defined
In-Reply-To: <YFOcOJP4innlbIk4@pevik>
References: <20210318162409.9871-1-mdoucha@suse.cz> <YFOcOJP4innlbIk4@pevik>
Message-ID: <920d81b2-567a-4e28-58f7-b27151b1cad7@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Martin,
>
>> The libc test variant should run only if system headers define SEM_STAT_ANY.
>> Skip it if we're falling back to the LAPI definition.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thanks!
>
> ...
>> +#if !HAVE_DECL_SEM_STAT_ANY
> nit: I'd prefer
> #ifndef HAVE_DECL_SEM_STAT_ANY
+1
>> +	if (tst_variant == 1)
>> +		tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
>> +#endif
> Although I understand why you want to quit only tests with root
> (only these fail), it's a bit confusing to test with user nobody
> and then quit the same testing with root.

I don't get this.? Martin only wants to skip libc test when undefined 
and it doesn't matter which user we use.


> Kind regards,
> Petr
>

