Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1WGlfz-00080N-KK
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 08:41:43 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WGlfy-0004el-C8
	for ltp-list@lists.sourceforge.net; Fri, 21 Feb 2014 08:41:43 +0000
Message-ID: <530710B9.4010102@cn.fujitsu.com>
Date: Fri, 21 Feb 2014 16:39:21 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1392969112-15851-1-git-send-email-francesco.rundo@st.com>
	<5307080F.8000702@cn.fujitsu.com>
	<D2A2C37B00D2EA4CB1886D29B96695C55AE388@SAFEX1NODE23.st.com>
In-Reply-To: <D2A2C37B00D2EA4CB1886D29B96695C55AE388@SAFEX1NODE23.st.com>
Subject: Re: [LTP] [PATCH] madvise/madvise03.c: Changed test exit code
Reply-To: gaowanlong@cn.fujitsu.com
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On 02/21/2014 04:38 PM, Francesco RUNDO wrote:
> The requested log:
> 
> with patch:
> madvise03    1  TCONF  :  madvise test for MADV_REMOVE unsupported return = -1, errno = 95 : Operation not supported
> madvise03    2  TPASS  :  madvise test for MADV_DONTFORK PASSED
> madvise03    3  TPASS  :  madvise test for MADV_DOFORK PASSED
> 
> Without patch (original one):
> madvise03    1  TFAIL  :  madvise test for MADV_REMOVE failed with return = -1, errno = 95 : Operation not supported
> madvise03    2  TPASS  :  madvise test for MADV_DONTFORK PASSED
> madvise03    3  TPASS  :  madvise test for MADV_DOFORK PASSED

Thank you.

Acked-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>


> 
> 
> Regards,
> FR
> 
> -----Original Message-----
> From: Wanlong Gao [mailto:gaowanlong@cn.fujitsu.com] 
> Sent: Friday, February 21, 2014 9:02 AM
> To: Francesco RUNDO
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] [PATCH] madvise/madvise03.c: Changed test exit code
> 
> On 02/21/2014 03:51 PM, Francesco RUNDO wrote:
>> Changed exit code from TFAIL to TCONF  in case of unsupported syscall. 
>> The "madvise" syscall needs kernel support as well as fs support as 
>> -for specific advice- it requires specific filesystem operations such 
>> as fallocate().
> 
> Could you paste the running log on not supported system?
> 
> Thanks,
> Wanlong Gao
> 
>> So, if kernel support is missed or fs doesn't provide specific 
>> operation needed for such "advice" scenario of that syscall, the right 
>> exit code (according to LTP defs) is not TFAIL as it is not a failure 
>> but it is TCONF as the syscall is unsupported.
>>
>> Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
>> ---
>>  testcases/kernel/syscalls/madvise/madvise03.c |   17 +++++++++++++----
>>  1 files changed, 13 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/madvise/madvise03.c 
>> b/testcases/kernel/syscalls/madvise/madvise03.c
>> index b0c17e8..23dd9a6 100644
>> --- a/testcases/kernel/syscalls/madvise/madvise03.c
>> +++ b/testcases/kernel/syscalls/madvise/madvise03.c
>> @@ -160,10 +160,19 @@ static void cleanup(void)  static void 
>> check_and_print(char *advice)  {
>>  	if (TEST_RETURN == -1) {
>> -		tst_resm(TFAIL,
>> -			 "madvise test for %s failed with "
>> -			 "return = %ld, errno = %d : %s",
>> -			 advice, TEST_RETURN, TEST_ERRNO, strerror(TEST_ERRNO));
>> +		if (TEST_ERRNO != ENOTSUP) {
>> +			tst_resm(TFAIL,
>> +				 "madvise test for %s failed with "
>> +				 "return = %ld, errno = %d : %s",
>> +				 advice, TEST_RETURN, TEST_ERRNO,
>> +				 strerror(TEST_ERRNO));
>> +		} else {
>> +			tst_resm(TCONF,
>> +				"madvise test for %s unsupported "
>> +				"return = %ld, errno = %d : %s",
>> +				advice, TEST_RETURN, TEST_ERRNO,
>> +				strerror(TEST_ERRNO));
>> +		}
>>  	} else if (STD_FUNCTIONAL_TEST) {
>>  		tst_resm(TPASS, "madvise test for %s PASSED", advice);
>>  	}
>>
> 
> 


------------------------------------------------------------------------------
Managing the Performance of Cloud-Based Applications
Take advantage of what the Cloud has to offer - Avoid Common Pitfalls.
Read the Whitepaper.
http://pubads.g.doubleclick.net/gampad/clk?id=121054471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
