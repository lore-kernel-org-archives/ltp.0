From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 3 Mar 2020 12:21:30 +0100
Subject: [LTP] [PATCH v2] Add test for CVE 2017-10661
In-Reply-To: <20200303104737.GA42129@gacrux.arch.suse.de>
References: <20200221120850.15874-1-mdoucha@suse.cz>
 <20200303104737.GA42129@gacrux.arch.suse.de>
Message-ID: <70a19473-081d-95ec-9801-d9c65b2e237c@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

(Resending because I forgot to CC the LTP mailing list in the original
message to Petr Vorel.)

On 3/3/20 11:47 AM, Petr Vorel wrote:
>> -LDLIBS			+= -lpthread -lrt
>> +timerfd_settime02:	CFLAGS	+= -pthread
>> +timerfd_settime02:	LDLIBS	+= -pthread -lrt
> Interesting, I thought -pthread wouldn't be needed to be in LDLIBS
> (enough to have it in CFLAGS), but old distros (CentOS 6 in our travis: gcc
> 4.4.7, glibc 2.12).

pthread_create() man page say "compile AND link with -pthread". ?\_(?)_/?

>> +	while (tst_fzsync_run_a(&fzsync_pair)) {
>> +		TEST(punch_clock(TFD_TIMER_ABSTIME | TFD_TIMER_CANCEL_ON_SET));
>> +
>> +		if (TST_RET == -1)
>> +			tst_res(TBROK | TTERRNO, TIMERFD_FLAGS " failed");
> Now this needs to be tst_res(TFAIL (person who merges this will do).
> 
>> +
>> +		if (TST_RET != 0)
>> +			tst_res(TBROK | TTERRNO, "Invalid " TIMERFD_FLAGS
>> +				" return value");
> The same here.

No, both should be tst_brk(). There's no point continuing the test if
setting the CANCEL_ON_SET flag fails. Sorry about the typo, I need more
coffee.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
