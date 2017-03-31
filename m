From: Li Wang <liwang@redhat.com>
Date: Fri, 31 Mar 2017 15:34:10 +0800
Subject: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New
	API
In-Reply-To: <1856913062.17824117.1490944194254.JavaMail.zimbra@redhat.com>
References: <20170328032239.11917-1-liwang@redhat.com>
 <20170330154358.GC886@rei.lan>
 <1856913062.17824117.1490944194254.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eP2KYkQCFxXQwZQ1Cjn16dk7zmqiHQde6DmcMrrvpyRQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Mar 31, 2017 at 3:09 PM, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Cyril Hrubis" <chrubis@suse.cz>
>> To: "Li Wang" <liwang@redhat.com>
>> Cc: ltp@lists.linux.it
>> Sent: Thursday, 30 March, 2017 5:43:58 PM
>> Subject: Re: [LTP] [RFC PATCH 00/13] Convert LTP kernel/mem/testcase to New API
>>
>> Hi!
>> > Seems the failed reason in oom02/5 is not testcase issue, it just because
>> > New API sets
>> > test time in 5mins.
>>
>> The test_test structure has .timeout variable that, if set, overrides
>> the default timeout. All you need to do is to to measure how long the
>> test takes, then multiply it by something as 2 to be on a safe side
>> and set the .timeout correspondingly.
>
> OOM tests depend on amount of RAM+swap, so it's going to vary a lot.
> I'd say safe side is in order of hours.
>
> Other options that come to mind:
> - formula based on amount of RAM and swap
> - we measure how long it takes to fill 1GB of RAM/swap, and scale that up
> - we run all OOM tests in mem cgroup with fixed mem/swap limit,
>   and set timeout according to worse case / slowest system

This looks fine. But if we set all OOM tests in mem cgroup, that will
make this test range is limited.

How about divide it into two part:

1. OOM test take original way on small (less than 100G) RAM, and we
set the .timeout according to the spent time on 100G system.

2. If system RAM large than 100G, we go to the cgroup limited way.



-- 
Regards,
Li Wang
Email: liwang@redhat.com
