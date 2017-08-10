From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 10 Aug 2017 14:00:15 +0200
Subject: [LTP] [PATCH 2/2] syscalls/pselect: Add a zero latency
	constraint
In-Reply-To: <1cbcc5dd-e060-94df-982e-198b3b342ec6@redhat.com>
References: <1502352088-10136-1-git-send-email-daniel.lezcano@linaro.org>
 <1502352088-10136-2-git-send-email-daniel.lezcano@linaro.org>
 <1cbcc5dd-e060-94df-982e-198b3b342ec6@redhat.com>
Message-ID: <ad947ee0-ee2a-840a-b9ac-74170d0ec7f3@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 10/08/2017 13:50, Jiri Jaburek wrote:
> On 08/10/17 10:01, Daniel Lezcano wrote:
>> The pselect_01 testcase works well on an x86 as it is a fast platform, w=
ith
>> fast exit latency idle routine.
>>
>> However on ARM[64] the idle routine can take much more time, for example
>> 1500us.
>>
>> The pselect fails on the ARM[64] platforms because of these slow exit la=
tencies,
>> the delay between the expected expiration and the observed one is not
>> acceptable.
>>
>> The fix could be to increase the deviation on ARM64 but that wouldn't ma=
ke
>> sense as some platforms, for the same architecture, can have faster or
>> different delays, hence we can potentially miss a bug.
>>
>> The simplest solution is to set the cpu_dma latency constraint to zero, =
so the
>> idle driver will always choose the fastest idle state, thus fixing the i=
ssue
>> above. The latency constraint will apply only for this test.
>=20
> I think a more generic LTP-wide solution could be made; there are more
> tests that fail ie. on virtualized environments because of CPU over-
> provisioning on the host (x86, s390, ppc, etc.)

Not sure a latency constraint will fix the above.

> and I can imagine ie.
> networking tests having similar needs as well (probably currently worked
> around using big timeouts).

Here you can set the network latency.

> Basically some system that would allow a user to set some "latency
> multiplier" based on the system under test, so that ie. dedicated x86
> machines with fairly deterministic CPU/net/etc. scheduling could have it
> set low, and so that other systems could still run tests that are now
> deemed unsuitable for such hardware.

Here the solution is to provide the cpu_dma latency, it will prevent the
cpuidle driver to choose a deeper idle state introducing an excessive
wakeup latency.

The excessive idle exit latency is the root cause of the pselect to
fail, setting the cpu_dma latency is the correct fix to let this test to
do the right thing. It is the purpose of the cpu_dma latency constraint.



>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  testcases/kernel/syscalls/pselect/pselect01.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/testcases/kernel/syscalls/pselect/pselect01.c b/testcases/k=
ernel/syscalls/pselect/pselect01.c
>> index a2b5339..42027b6 100644
>> --- a/testcases/kernel/syscalls/pselect/pselect01.c
>> +++ b/testcases/kernel/syscalls/pselect/pselect01.c
>> @@ -44,6 +44,9 @@ int sample_fn(int clk_id, long long usec)
>>  }
>> =20
>>  static struct tst_test test =3D {
>> +	.needs_root =3D 1,
>> +	.needs_latency =3D 1,
>> +	.latency =3D 0,
>>  	.tid =3D "pselect()",
>>  	.sample =3D sample_fn,
>>  };
>>
>=20
>=20


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

