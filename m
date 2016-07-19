From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 19 Jul 2016 17:57:32 +0300
Subject: [LTP] [PATCH V2 4/8] waitpid09: use the new API
In-Reply-To: <20160719124125.GD6409@rei.lan>
References: <20160718141844.GD18221@rei.suse.cz>
 <1468924444-924-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160719124125.GD6409@rei.lan>
Message-ID: <578E3FDC.9010003@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 07/19/2016 03:41 PM, Cyril Hrubis wrote:
> Hi!
>> This patch addresses all your comments, except the one about do_exit(),
>> because do_exit() is required for case 0.
>
> What I meant was to move the two lines that are in do_exit() to the if
> in the case0(). Previously the function was called from two places (one
> was the uclinux maybe_run_child and another one was after the fork) but
> now it does not make any sense to keep it as a separate function if it's
> called only from one place in the code.
>
> Or is there another reason to keep it in a fucntion I don't see?

No, there is no such reason.

I didn't get what you meant at that time, but now it's clear for me. 
Will update the patch.

>
>> +static void case2(void)
>>   {
>> +	pid_t ret;
>> +	int status;
>> +
>> +	ret = waitpid(-1, &status, 0);
>> +
>> +	if (ret != -1) {
>> +		tst_res(TFAIL, "Expected -1 got %d", ret);
>> +		return;
>> +	}
>> +	if (errno != ECHILD) {
>> +		tst_res(TFAIL, "Expected ECHILD got %d",
>> +			 errno);
>                          ^
> 			You should print the human-readable string
> 			returned by tst_strerrno() here as well or
> 			use TERRNO to have it printed by the library.
>

Okay.

>> +		return;
>> +	}
>> +
>> +	tst_res(TPASS, "Case 2 PASSED");
>>   }
>>
>> -static void inthandlr(void)
>> +static void case3(void)
>>   {
>> -	intintr++;
>> +	pid_t ret;
>> +	int status;
>> +
>> +	ret = waitpid(-1, &status, WNOHANG);
>> +	if (ret != -1) {
>> +		tst_res(TFAIL, "WNOHANG: Expected -1 got %d",
>> +			 ret);
>> +		return;
>> +	}
>> +	if (errno != ECHILD) {
>> +		tst_res(TFAIL, "WNOHANG: Expected ECHILD got "
>> +			 "%d", errno);
>
>                          Here as well.
>
>> +		return;
>> +	}
>> +
>> +	tst_res(TPASS, "Case 3 PASSED");
>>   }
>>
>> -static void wait_for_parent(void)
>
> Otherwise it looks good. Acked with the minor changes fixed.
>
