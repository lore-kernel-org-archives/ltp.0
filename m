From: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 25 Nov 2020 12:57:28 +0100
Subject: [LTP] [PATCH] fzsync: skip test when avaliable CPUs less than 2
In-Reply-To: <20201125115406.GD2297@yuki.lan>
References: <20201125101633.30154-1-liwang@redhat.com>
 <87eekhof3i.fsf@suse.de> <20201125115406.GD2297@yuki.lan>
Message-ID: <1fa5e025-ba61-30c7-d9e8-3382e939b7d0@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 25. 11. 20 12:54, Cyril Hrubis wrote:
> Hi!
>> Perhaps this test would pass with more loops and a big enough delay
>> range, but this is also wasting time on a single vCPU. I'm not sure
>> whether we should filter this test at the LTP level; it may trigger the
>> bug on some single CPU configs.
>>
>> Why not print a warning instead of refusing to run?
> 
> That's not a solution either, warning would end up in a test results as
> well.
> 
> I guess that we can add something as .min_cpus to the tst_test structure
> and set it for this test?

+1 for .min_cpus from me.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
