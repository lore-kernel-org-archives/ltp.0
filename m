From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 20 Mar 2019 09:49:05 +0800
Subject: [LTP] [PATCH] lib/tst_af_alg.c: Fix wrong errno for unsupported
 AF_ALG
In-Reply-To: <20190319164017.GA202956@gmail.com>
References: <1552965902-22452-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <20190319164017.GA202956@gmail.com>
Message-ID: <5C919C11.3090305@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/03/20 0:40, Eric Biggers wrote:
> On Tue, Mar 19, 2019 at 11:25:02AM +0800, Xiao Yang wrote:
>> According to socket(2) manpage and source code, socket(2) actually
>> returns EAFNOSUPPORT instead of EPROTONOSUPPORT when AF_ALG is not
>> supported by kernel.
>>
>> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
>> ---
>>   lib/tst_af_alg.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/lib/tst_af_alg.c b/lib/tst_af_alg.c
>> index 9ce1ca4..97be548 100644
>> --- a/lib/tst_af_alg.c
>> +++ b/lib/tst_af_alg.c
>> @@ -16,7 +16,7 @@ int tst_alg_create(void)
>>   	TEST(socket(AF_ALG, SOCK_SEQPACKET, 0));
>>   	if (TST_RET>= 0)
>>   		return TST_RET;
>> -	if (TST_ERR == EPROTONOSUPPORT)
>> +	if (TST_ERR == EAFNOSUPPORT)
>>   		tst_brk(TCONF, "kernel doesn't support AF_ALG");
>>   	tst_brk(TBROK | TTERRNO, "unexpected error creating AF_ALG socket");
>>   	return -1;
>> -- 
>> 1.8.3.1
>>
>>
>>
>>
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp
> Thanks, somehow I missed this.
>
> Reviewed-by: Eric Biggers<ebiggers@google.com>
Hi Eric,

Pushed, thanks for your review. :-)

Best Regards,
Xiao Yang
>
>



