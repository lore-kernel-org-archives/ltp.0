From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 20 Jul 2021 14:36:10 +0200
Subject: [LTP] [PATCH 3/3] Add lockdown checks to init_module* and
 finit_module* tests
In-Reply-To: <YPa7bSB8pNPrBDn8@yuki>
References: <20210720103941.9767-1-mdoucha@suse.cz>
 <20210720103941.9767-3-mdoucha@suse.cz> <YPa7bSB8pNPrBDn8@yuki>
Message-ID: <e6033278-8e27-eed5-5f36-1dd09e68bf5a@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20. 07. 21 14:02, Cyril Hrubis wrote:
> Hi!
>> +static void lockdown_setup(struct tcase *tc)
>> +{
>> +	if (kernel_lockdown)
>> +		tc->exp_errno = EPERM;
>> +}
>> +
>>  static struct tcase tcases[] = {
>>  	{"invalid-fd", &fd_invalid, "", O_RDONLY | O_CLOEXEC, 0, 0, 0, bad_fd_setup},
>>  	{"zero-fd", &fd_zero, "", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
>> -	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT, NULL},
>> -	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0, EINVAL, NULL},
>> +	{"null-param", &fd, NULL, O_RDONLY | O_CLOEXEC, 0, 0, EFAULT,
>> +		lockdown_setup},
>> +	{"invalid-param", &fd, "status=invalid", O_RDONLY | O_CLOEXEC, 0, 0,
>> +		EINVAL, lockdown_setup},
>>  	{"invalid-flags", &fd, "", O_RDONLY | O_CLOEXEC, -1, 0, EINVAL, NULL},
>>  	{"no-perm", &fd, "", O_RDONLY | O_CLOEXEC, 0, 1, EPERM, NULL},
>>  	{"module-exists", &fd, "", O_RDONLY | O_CLOEXEC, 0, 0, EEXIST, NULL},
> 
> I'm slightly afraid that the order of checks may change over the time
> and we will get EPERM in all these cases, but maybe I'm just overly
> cautious. Other than this the code looks good.

I don't think we need to worry about that. With root privileges, the
EPERM error is returned when a kernel module does not have a valid
signature. How would something that is not even a valid kernel module in
the first place fail that check?

The only subtests that actually try to load a valid kernel module are
null-param, invalid-param and module-exists. All three of them now
handle lockdown correctly.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
