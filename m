From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 30 Nov 2020 08:54:44 +0000
Subject: [LTP] [PATCH v3] overcommit_memory: Fix unstable subtest
In-Reply-To: <01818271-8dba-96a3-76f3-575243c93243@jv-coder.de>
References: <20201127071419.20370-1-lkml@jv-coder.de> <87360rnuio.fsf@suse.de>
 <01818271-8dba-96a3-76f3-575243c93243@jv-coder.de>
Message-ID: <87zh2zmdgr.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Joerg Vehlow <lkml@jv-coder.de> writes:

> Hi,
>>> +static long get_total_batch_size_bytes(void)
>>> +{
>>> +	struct sysinfo info;
>>> +	long ncpus = tst_ncpus_conf();
>> I'm not completely sure if this is the same value as num_cpus_present()
>> in the kernel? I'm just wondering if CPU hotplugging could result in the
>> wrong value being calculated (other than if it is hotplugged while the test
>> is running).
>
> I was thinking about this as well when I implemented this. Here is my
> reasoning:
>
> If hotplug is disabled possible=present and possible=nr cpus at
> boot. Otherwise present is the real number of existing (not
> necessarily enabled cpus), and possible=NR_CPU
> In both cases it is the number of cpus installed in the system,
> enabled or not.
>
> tst_ncpus_conf is _SC_NPROCESSORS_CONF, which is documented as
> "returns the number of processors the operating system configured. But
> it might be possible for the operating system to disable individual
> processors and so the call", in contrast to _SC_NPROCESSORS_ONLN
> "returns the number of processors which are currently online (i.e.,
> available).".
>
> I would interpret _SC_NPROCESSORS_CONF as equal to present and
> _SC_NPROCESSORS_ONLN as equal to online.
>
> Anything flaw in my logic?
>
> J?rg

This sounds correct, it would be strange if _SC_NPROCESSORS_CONF
returned num_possible_cpus().

-- 
Thank you,
Richard.
