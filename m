From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 26 Feb 2020 11:34:20 +0800
Subject: [LTP] [PATCH V3 08/10] syscalls/move_mount: New tests
In-Reply-To: <20200226022758.ls35mblsetg4nk6f@vireshk-i7>
References: <cover.1582612624.git.viresh.kumar@linaro.org>
 <e12560056ebc632918426194172a6cba48953d4e.1582612624.git.viresh.kumar@linaro.org>
 <20200225135709.GC62318@gacrux.arch.suse.de>
 <20200226022758.ls35mblsetg4nk6f@vireshk-i7>
Message-ID: <f1801e95-5200-48ee-a8b9-38e8b90e6593@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi

> On 25-02-20, 14:57, Petr Vorel wrote:
>>> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", tst_device->dev, 0));
>>> +	if (TST_RET == -1) {
>>> +		SAFE_CLOSE(fd);
>>> +		tst_res(TBROK | TERRNO, "fsconfig() failed");
>> These should be TFAIL otherwise it 1) breaks all tests 2) does not report any
>> result:
>>
>> move_mount02.c:37: BROK: fsopen() failed: SUCCESS (0)
>> tst_test.c:1051: BROK: Test 0 haven't reported results!
> 
> I am a bit confused about TBROK and TFAIL to be honest. The test
> writing guideline says this:
> 
> | 'TFAIL' | Test has failed.
> | 'TBROK' | Something has failed in test preparation phase.
> 
> And so in my code I have been using TFAIL only for the failures for the
> actual syscalls that we are testing, like move_mount here. And I have
> been using TBROK for pretty much everything else
If using TBROK, it will terminate the program. So how can test the 
remaining test?
Like move_mount02.c, if test "invalid-from-fd"and fsconfig failed, it 
will exit. So how do you test "invalid-from-path"?

Also, using return after TBROK is meaningless.

Best Regards
Yang Xu
> 
> Would be good if you and Cyril can explain what's the correct usage
> model for these is.
> 



