From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Fri, 11 Aug 2017 16:52:28 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <20170811140905.GB3341@rei.lan>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
 <20170811140905.GB3341@rei.lan>
Message-ID: <b11d663b-0afb-58a7-bc3d-14d3e61084c4@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 11/08/2017 16:09, Cyril Hrubis wrote:
> Hi!
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>  include/tst_test.h |  4 ++++
>>  lib/tst_test.c     | 28 ++++++++++++++++++++++++++++
>>  2 files changed, 32 insertions(+)
>>
>> diff --git a/include/tst_test.h b/include/tst_test.h
>> index e90312a..519fd4c 100644
>> --- a/include/tst_test.h
>> +++ b/include/tst_test.h
>> @@ -124,6 +124,7 @@ struct tst_test {
>>  	int needs_checkpoints:1;
>>  	int format_device:1;
>>  	int mount_device:1;
>> +	int needs_latency:1;
>> =20
>>  	/* Minimal device size in megabytes */
>>  	unsigned int dev_min_size;
>> @@ -154,6 +155,9 @@ struct tst_test {
>> =20
>>  	/* NULL terminated array of resource file names */
>>  	const char *const *resource_files;
>> +
>> +	/* Latency constraint to be set for the test */
>> +	int latency;
>>  };
>=20
> This seems to be a bit too specific to me, I would be more happy if we
> named it "measures_sleep_time" or something that describes what the
> testcase does rather than calling it after specific workaround.

I'm sorry, I don't get the point. The latency is a system parameter for
any kind of run. Here it is in the common tst lib code as the constraint
may be needed for any other new test. I don't understand the
'measures_sleep_time', there is no connection with the latency word.

Perhaps the cpu_dma_latency needs a better explanation:

When the CPU has no task in its runqueue, the kernel will run a special
task (the idle task). When entering in the idle routine, it will use an
idle state process selection based on how long we predict the CPU will
be sleeping (based on a mix of wake up statistics and timer events) as
well as an exit latency constraint. The deeper the idle state is, the
longer the latency to wakeup is and the more energy we save.

The number of idle states is hardware specific, as well as the idle
state characteristics. For example, for an x86,i7 the deepest idle
state's exit latency is 86us, on other platforms (eg. mobile), the
deepest idle state's exit latency could more than 1500us (or less).

Under certain circumstances, you don't want your CPU to go to a too deep
idle state because you need fast response: eg. playing a game, reading a
mp3 or a HD video (otherwise you miss frames). The application will then
set a cpu_dma_latency constraint and as the kernel checks this latency
when selecting an idle state, deep idle state will be skipped.

For the specific pselect test, we measure the drift between the expected
wakeup and the observed one. With the energy framework, we added an
unacceptable (for the test) delay. This test does not check the latency,
it checks if the wakeup period from the *pselect* syscall is acceptable,
in absolute, so we need to put apart the idle routine during this
specific test.

Technically speaking, the cpu_dma_latency is set by opening the file
/dev/cpu_dma_latency and writing the value but as soon as you close the
file descriptor, the constraint is removed from the kernel. So in this
case, any test setting the cpu_dma_latency will have the file descriptor
close at exit time, the constraint is bound to the test itself.


> Also shouldn't this be set automatically for all timer related testcases
> (these that make use of the sampling function) rather than just for the
> pselect one? If so we should set the flag in the tst_timer_test.c
> library instead. Or we can also stick the latency setup/cleanup
> into the tst_timer_test.c as well and don't bother with adding more
> flags into the tst_test structure (see timer_setup() and timer_cleanup()
> in the tst_timer_test.c).

I'm not sure. We may want to measure everything together (timer + drift
+ energy framework latencies) in other testcases. I think it is fine if
we let the test program to decide what latency he wants to set.



--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

