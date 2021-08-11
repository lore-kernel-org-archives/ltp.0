From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 11 Aug 2021 08:09:30 +0100
Subject: [LTP] [PATCH] setsockopt08: Handle ENOPROTOOPT even with
 compatible config
In-Reply-To: <28d60c6e-f29b-e17b-a34c-31142e872e3f@suse.cz>
References: <20210806111938.12007-1-rpalethorpe@suse.com>
 <28d60c6e-f29b-e17b-a34c-31142e872e3f@suse.cz>
Message-ID: <87y298laol.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Martin,

Martin Doucha <mdoucha@suse.cz> writes:

> Hi,
>
> On 06. 08. 21 13:19, Richard Palethorpe via ltp wrote:
>> One or more necessary modules can be missing even if they are present
>> in the config.
>> 
>> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>> ---
>>  .../kernel/syscalls/setsockopt/setsockopt08.c | 24 +++++++++++++++----
>>  1 file changed, 20 insertions(+), 4 deletions(-)
>> 
>> diff --git a/testcases/kernel/syscalls/setsockopt/setsockopt08.c b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
>> index 33892f9b1..d3cd5b5b2 100644
>> --- a/testcases/kernel/syscalls/setsockopt/setsockopt08.c
>> +++ b/testcases/kernel/syscalls/setsockopt/setsockopt08.c
>> @@ -110,6 +110,7 @@ void run(void)
>>  	struct xt_entry_target *xt_entry_tgt =
>>  		((struct xt_entry_target *) (&ipt_entry->elems[0] + match_size));
>>  	int fd = SAFE_SOCKET(AF_INET, SOCK_DGRAM, 0);
>> +	int result;
>>  
>>  	xt_entry_match->u.user.match_size = (u_int16_t)match_size;
>>  	strcpy(xt_entry_match->u.user.name, "state");
>> @@ -126,10 +127,25 @@ void run(void)
>>  	ipt_replace->num_counters = 1;
>>  	ipt_replace->size = ipt_entry->next_offset;
>>  
>> -	TST_EXP_FAIL(setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1),
>> -		     EINVAL,
>> -		     "setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)",
>> -		     fd, buffer);
>> +	errno = 0;
>> +	if (setsockopt(fd, IPPROTO_IP, IPT_SO_SET_REPLACE, buffer, 1) == -1) {
>> +		switch (errno) {
>> +		case EINVAL:
>> +			result = TPASS;
>> +			break;
>> +		case ENOPROTOOPT:
>> +			result = TCONF;
>> +			break;
>> +		default:
>> +			result = TFAIL;
>> +		}
>> +	} else {
>> +		result = TFAIL;
>> +	}
>> +
>> +	tst_res(result | TERRNO,
>> +		"setsockopt(%d, IPPROTO_IP, IPT_SO_SET_REPLACE, %p, 1)",
>> +		fd, buffer);
>>  
>>  	SAFE_CLOSE(fd);
>>  }
>
> I think it'd be better to call tst_brk(TCONF) when setsockopt() returns
> ENOPROTOOPT. The CVE runfile iterates the test 100 times and this error
> will not change between iterations.

Ah, yes, this is a mistake, I will reroll the patch.

-- 
Thank you,
Richard.
