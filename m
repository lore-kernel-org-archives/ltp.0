From: Martin Doucha <mdoucha@suse.cz>
Date: Mon, 9 Dec 2019 13:50:59 +0100
Subject: [LTP] [PATCH] cpuhotplug05.sh: Rewrite test case
In-Reply-To: <31fe4c0c-863e-4ba6-d8d7-1af909013fb7@163.com>
References: <20191202101943.17335-1-ice_yangxiao@163.com>
 <7b7c1e8a-1db1-bf9f-96ff-01803416120e@suse.cz>
 <31fe4c0c-863e-4ba6-d8d7-1af909013fb7@163.com>
Message-ID: <8f5e7d2a-34a8-5d2a-658c-a1f535fd1cc7@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/9/19 4:13 AM, Xiao Yang wrote:
>> Your new scenario has two problems:
>>
>> - You have to run at least two test loops to verify that reactivating a
>> CPU doesn't break /proc/stat entries.
> 
> I think running cpuhotplug05.sh with -i 2 can verfiy this point.
> 
> Perhaps we can add -i option to runtest/cpuhotplug, or do you prefer to
> keep the original scenario?

I'd prefer keeping the original scenario (with your version of cleanup).
Running extra iterations of the same test should not be required to get
the full intended test coverage.

>> - Also consider doing the above check for all CPUs to increase test
>> coverage.
> 
> Is it necessary to add above check for all CPUs?
> 
> This test is designed to test specified CPU so you can test each CPU by
> using -c option.

It's not necessary but it'd be a nice addition. Note that running the
test script multiple times with different -c arguments does not fully
cover this extra check. Turning a CPU core off and on again might reset
its /proc/stat line into a sane state while breaking all the others.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
