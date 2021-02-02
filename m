From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 2 Feb 2021 13:04:41 +0100
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: Run cleanup also on timeout
In-Reply-To: <YBkmQl1lFmxbdpcb@pevik>
References: <20210202074753.31516-1-pvorel@suse.cz>
 <47060cdf-58a3-2568-3508-31436b9c6e12@jv-coder.de> <YBkmQl1lFmxbdpcb@pevik>
Message-ID: <6c7e6893-efe2-0ac2-2a68-b7e4796e85d7@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
>>> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
>>> index 69f007d89..35ad6d2d7 100644
>>> --- a/testcases/lib/tst_test.sh
>>> +++ b/testcases/lib/tst_test.sh
>>> @@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
>>>    . tst_security.sh
>>>    # default trap function
>>> -trap "tst_brk TBROK 'test interrupted'" INT
>>> +trap "tst_brk TBROK 'test interrupted or timeout'" INT
>> should be "timed out" for consistency
> You probably mean consistency with TST_RETRY_FN_EXP_BACKOFF()
> I tried to be consistent with previous message:
> zram01 1 TBROK: test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> That one should be changed as well.
> I slightly prefer "timeout", but I'm not a native speaker.
No I was meant the "test interrupted" part. "test interrupt or timeout" 
would be consistent.
I am not a native speaker either, but "test interrupted or timed out" 
sound more correct to me.

J?rg
