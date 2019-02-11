From: Matthias =?unknown-8bit?q?M=C3=A4nnich?= <maennich@google.com>
Date: Mon, 11 Feb 2019 08:28:33 +0000
Subject: [LTP] [PATCH v1] sigpending: use direct syscall
In-Reply-To: <aaf4de2f-9171-3e27-e9ab-3811eea7b5c3@google.com>
References: <20190207155153.41816-1-maennich@google.com>
 <aaf4de2f-9171-3e27-e9ab-3811eea7b5c3@google.com>
Message-ID: <E5659E9E-4279-4C8E-B51F-50E6B04832ED@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



> On 7 Feb 2019, at 18:58, Steve Muckle <smuckle@google.com> wrote:
> 
> On 02/07/2019 07:51 AM, Matthias Maennich wrote:
>>  	/* set sigset to point to an invalid location */
>>  	sigset_t *sigset = (sigset_t *) - 1;
>>  -	TEST(sigpending(sigset));
>> +	TEST(tst_syscall(__NR_rt_sigpending, sigset, NSIG / 8));
>>    	/* check return code */
>>  	if (TST_RET == -1) {
> 
> Should this be using __NR_sigpending instead? That worked for me (for 32-bit anyway, it's not available on arm64).
> 
> Alternately, this test/dir could be renamed to rt_sigpending, though we should also add a test for sigpending.
> 

Syscall wrappers usually call __NR_rt_sigpending if the kernel provides it. So, I was going with this. But I guess you are right: if we already bypass the wrappers, we should adjust the tests accordingly.

I will update the patch.

Cheers,
Matthias
