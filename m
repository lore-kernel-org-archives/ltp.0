From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 13 Mar 2019 13:26:14 -0300
Subject: [LTP] [PATCH v3 1/2] lib: include SAFE_CLOCK_ADJTIME() macro
In-Reply-To: <20190313160941.GB6171@rei>
References: <20190226001716.GA12569@dell5510>
 <20190226160804.16596-1-rafael.tinoco@linaro.org> <20190313160941.GB6171@rei>
Message-ID: <E8CFCE43-7512-482C-8C7A-53D6F680C7C7@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

> On 13 Mar 2019, at 13:09, Cyril Hrubis <chrubis@suse.cz <mailto:chrubis@suse.cz>> wrote:
> 
> Hi!
>> +static inline void safe_clock_adjtime(const char *file, const int lineno,
>> +	clockid_t clk_id, struct timex *txc)
>> +{
>> +	int rval;
>> +
>> +	rval = tst_syscall(__NR_clock_adjtime, clk_id, txc);
> 
> Any reason why we don't use clock_adjtime() here?
> 
> Or is the glibc wrapper missing?

Yes, it is missing. It was added in glibc NEWS in a “new Linux interfaces” list and put into the syscalls list, but, at the moment, there is nothing wrapping it. 

> 
>> +	if (rval != 0)
>> +		tst_brk(TBROK | TERRNO,
>> +			"%s:%d clock_adjtime() failed", file, lineno);
>> +}
>> #define SAFE_CLOCK_GETRES(clk_id, res)\
>> 	safe_clock_getres(__FILE__, __LINE__, (clk_id), (res))
>> 
>> @@ -50,3 +63,6 @@ static inline void safe_clock_settime(const char *file, const int lineno,
>> 
>> #define SAFE_CLOCK_SETTIME(clk_id, tp)\
>> 	safe_clock_settime(__FILE__, __LINE__, (clk_id), (tp))
>> +
>> +#define SAFE_CLOCK_ADJTIME(clk_id, txc)\
>> +	safe_clock_adjtime(__FILE__, __LINE__, (clk_id), (txc))
>> -- 
>> 2.20.1
>> 
>> 
>> -- 
>> Mailing list info: https://lists.linux.it/listinfo/ltp <https://lists.linux.it/listinfo/ltp>
> -- 
> Cyril Hrubis
> chrubis@suse.cz <mailto:chrubis@suse.cz>

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190313/40e5e580/attachment.html>
