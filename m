From: Enji Cooper <yaneurabeya@gmail.com>
Date: Mon, 25 Feb 2019 16:24:53 -0800
Subject: [LTP] [PATCH v2 2/2] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190226001716.GA12569@dell5510>
References: <20190221200547.7277-2-rafael.tinoco@linaro.org>
 <20190221203037.21826-1-rafael.tinoco@linaro.org>
 <20190221203037.21826-2-rafael.tinoco@linaro.org>
 <20190226001716.GA12569@dell5510>
Message-ID: <1F9E3DDC-2938-47BA-8431-84586115ACCD@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



> On Feb 25, 2019, at 4:17 PM, Petr Vorel <pvorel@suse.cz> wrote:
> 
> Hi Rafael,
> 
>> diff --git a/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c b/testcases/kernel/syscalls/clock_adjtime/clock_adjtime01.c
>> new file mode 100644
>> index 000000000..541d9437d
> ...
> 
>> +	SAFE_CLOCK_ADJTIME(CLOCK_REALTIME, &ttxc);
>> +	timex_show("SET", ttxc);
>> +
>> +	if (tc[i].ptr) {
>> +
>> +		/* adjtimex field being tested so we can verify later */
>> +
>> +		ptroff = (long) tc[i].ptr - (long) &ttxc;
>> +		ptr = (void *) &verify + ptroff;
>> +	}
>> +
>> +	TEST(sys_clock_adjtime(CLOCK_REALTIME, &verify));
>> +	timex_show("VERIFY", verify);
>> +
>> +	if (tc[i].ptr && *tc[i].ptr != *ptr) {
> Can you please fix this compiler error:
> clock_adjtime01.c: In function ‘verify_clock_adjtime’:
> clock_adjtime01.c:199:33: warning: ‘ptr’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>  if (tc[i].ptr && *tc[i].ptr != *ptr) {

Wow. That’s a really dumb, tautologically impossible compiler error :(…
-Enji
