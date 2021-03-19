From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 19 Mar 2021 10:49:22 +0100
Subject: [LTP] [PATCH] syscalls/semctl09: Skip libc test if SEM_STAT_ANY
 not defined
In-Reply-To: <YFOcOJP4innlbIk4@pevik>
References: <20210318162409.9871-1-mdoucha@suse.cz> <YFOcOJP4innlbIk4@pevik>
Message-ID: <78ca788f-f24e-61f5-b0c6-a0742b6af176@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 18. 03. 21 19:30, Petr Vorel wrote:
> Hi Martin,
> 
>> The libc test variant should run only if system headers define SEM_STAT_ANY.
>> Skip it if we're falling back to the LAPI definition.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Thanks!
> 
> ...
>> +#if !HAVE_DECL_SEM_STAT_ANY
> nit: I'd prefer
> #ifndef HAVE_DECL_SEM_STAT_ANY

That will not work. AC_CHECK_DECLS() will always define
HAVE_DECL_SEM_STAT_ANY, either with the value of 0 (macro not defined)
or 1 (defined).

>> +	if (tst_variant == 1)
>> +		tst_brk(TCONF, "libc does not support semctl(SEM_STAT_ANY)");
>> +#endif
> Although I understand why you want to quit only tests with root
> (only these fail), it's a bit confusing to test with user nobody
> and then quit the same testing with root.

tst_variant has nothing to do with UID.
tst_variant == 0 => run the test using tst_syscall(__NR_semctl)
tst_variant == 1 => run the test again using libc semctl()

But if you want to make the test output a little more clear, I could
move the test_info() call at the end of setup() a few lines up before
the new #if.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
