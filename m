From: Greg Hackmann <ghackmann@google.com>
Date: Wed, 7 Nov 2018 13:11:47 -0800
Subject: [LTP] [PATCH] getrlimit/getrlimit03: new test for underlying
 syscall variants
In-Reply-To: <20181106194725.GA11344@rei.lan>
References: <20181106180804.163305-1-ghackmann@google.com>
 <629612842.70327511.1541533513279.JavaMail.zimbra@redhat.com>
 <20181106194725.GA11344@rei.lan>
Message-ID: <f05a9bd7-0a81-1f1e-185f-71ba498fdd69@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/06/2018 11:47 AM, Cyril Hrubis wrote:
> Hi!
>>> +const uint64_t RLIM_INFINITY_U64 = UINT64_MAX;
>>> +
>>> +static int getrlimit_u64(int resource, struct rlimit64 *rlim)
>>> +{
>>> +	return syscall(__NR_prlimit64, 0, resource, NULL, rlim);
>>
>> Hi,
>>
>> (Likely an issue for old distro kernels, but)
>> consider using ltp_syscall here, or in setup(). Syscall __NR defines
>                   ^
> 		 That would be tst_syscall() for new tst_test.h library
> 
>> come from LTP, so those will be always present, but syscall can still
>> be unsupported by kernel, so test can end up comparing with 'ENOSYS'.
> 
> 

Thanks for the feedback.  I'll send a v2 with this change shortly.
