From: Martin Doucha <mdoucha@suse.cz>
Date: Fri, 11 Jun 2021 17:07:42 +0200
Subject: [LTP] [Automated-testing] [PATCH 3/4] lib: Introduce concept of
 max_test_runtime
In-Reply-To: <YMDC/mjGTXxoq9uH@yuki>
References: <20210609114659.2445-1-chrubis@suse.cz>
 <20210609114659.2445-4-chrubis@suse.cz> <YMDBFfCZwYDYwWDg@pevik>
 <YMDC/mjGTXxoq9uH@yuki>
Message-ID: <fd006cd4-2f65-138a-8907-94153ee3b45e@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 09. 06. 21 15:32, Cyril Hrubis wrote:
> Hi!
>>>   - the scaled value is then divided, if needed, so that we end up a
>>>     correct maximal runtime for an instance of a test, i.e. we have
>>>     max runtime for an instance fork_testrun() that is inside of
>>>     .test_variants and .all_filesystems loops
>> Now "Max runtime per iteration" can vary, right? I.e. on .all_filesystems
>> runtime for each filesystems depends on number of filesystems? E.g. writev03.c
>> with setup .timeout = 600 on 2 filesystems is 5 min (300s), but with all 9
>> filesystems is about 1 min. We should document that author should expect max
>> number of filesystems. What happen with these values in the (long) future, when
>> LTP support new filesystem (or drop some)? This was a reason for me to define in
>> the test value for "Max runtime per iteration", not whole run.
> 
> That's one of the downsides of this approach.
> 
> The reason why I choose this approach is that you can set upper cap for
> the whole test run and not only for a single filesystem/variant.
> 
> Also this way the test timeout corresponds to the maximal test runtime.
> 
> Another option would be to redefine the timeout to be timeout per a
> fork_testrun() instance, which would make the approach slightly easier
> in some places, however that would mean either changing default test
> timeout to much smaller value and annotating all long running tests.
> 
> Hmm, I guess that annotating all long running tests and changing default
> timeout may be a good idea regardless this approach.

Some fuzzysync tests have long run time by design because running too
few loops on broken systems will not trigger the bug. Limiting maximum
program execution time may be useful for quick smoke tests but it's not
usable for real test runs where we want reliable reproducibility.

I'd prefer adding a command line option to tst_test (e.g. -m) that would
just print test metadata, including total timeout of all fork_testrun()
subtests, and exit. Static metadata is not a sufficient solution for
this because the same test binary may have different runtimes on
different system configurations, for example because the list of
available filesystems may change arbitrarily between test runs. It'd be
great if test runners other than runltp-ng could get a straighforward
timeout number without reimplementing a calculation that may change in
future versions of LTP.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
