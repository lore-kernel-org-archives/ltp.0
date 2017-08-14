From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 14 Aug 2017 14:56:40 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <20170811152855.GA14152@rei.lan>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
 <20170811140905.GB3341@rei.lan>
 <b11d663b-0afb-58a7-bc3d-14d3e61084c4@linaro.org>
 <20170811152855.GA14152@rei.lan>
Message-ID: <a0a61ae1-15fe-fc0d-9bfb-b2efd94f3c42@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 11/08/2017 17:28, Cyril Hrubis wrote:
> Hi!
>>> This seems to be a bit too specific to me, I would be more happy=20
>>> if we named it "measures_sleep_time" or something that describes=20
>>> what the testcase does rather than calling it after specific=20
>>> workaround.
>>=20
>> I'm sorry, I don't get the point. The latency is a system
>> parameter for any kind of run. Here it is in the common tst lib
>> code as the constraint may be needed for any other new test. I
>> don't understand the 'measures_sleep_time', there is no connection
>> with the latency word.
>=20
> My point of view is that this is very specific tuning parameter and=20
> in ideal world the testcases would not need to touch kernel tuning=20
> knobs unless the knob is what is being tested, but we do not live in=20
> an ideal world either so some kind of solution is desirable. On the=20
> other hand there is plenty of different tuning knobs there and I=20
> would like to avoid putting each of them into the test library as=20
> another flag to be set in the test structure.
>=20
>> Perhaps the cpu_dma_latency needs a better explanation:
>>=20
>> When the CPU has no task in its runqueue, the kernel will run a=20
>> special task (the idle task). When entering in the idle routine,
>> it will use an idle state process selection based on how long we=20
>> predict the CPU will be sleeping (based on a mix of wake up=20
>> statistics and timer events) as well as an exit latency
>> constraint. The deeper the idle state is, the longer the latency to
>> wakeup is and the more energy we save.
>>=20
>> The number of idle states is hardware specific, as well as the idle
>> state characteristics. For example, for an x86,i7 the deepest idle
>> state's exit latency is 86us, on other platforms (eg. mobile), the
>> deepest idle state's exit latency could more than 1500us (or=20
>> less).
>>=20
>> Under certain circumstances, you don't want your CPU to go to a
>> too deep idle state because you need fast response: eg. playing a
>> game, reading a mp3 or a HD video (otherwise you miss frames). The=20
>> application will then set a cpu_dma_latency constraint and as the=20
>> kernel checks this latency when selecting an idle state, deep idle=20
>> state will be skipped.
>>=20
>> For the specific pselect test, we measure the drift between the=20
>> expected wakeup and the observed one. With the energy framework,
>> we added an unacceptable (for the test) delay. This test does not=20
>> check the latency, it checks if the wakeup period from the=20
>> *pselect* syscall is acceptable, in absolute, so we need to put=20
>> apart the idle routine during this specific test.
>>=20
>> Technically speaking, the cpu_dma_latency is set by opening the=20
>> file /dev/cpu_dma_latency and writing the value but as soon as you=20
>> close the file descriptor, the constraint is removed from the=20
>> kernel. So in this case, any test setting the cpu_dma_latency will=20
>> have the file descriptor close at exit time, the constraint is=20
>> bound to the test itself.
>=20
> So if I'm getting this correctly the kernel tries to save power=20
> agressively in your case since it knows when next timer expires and=20
> that waking up from deep idle state would make the timer slack,=20
> right? From that point of view this more or less looks like an=20
> workaround :-).

No, it is not trying to save power aggressively. It has exactly the same
behavior than other platforms/arch. The kernel does not have a
constraint in terms of latency, so it does not discriminate any idle
state. Luckily the test works on different architecture because:

 1. the architecture / platform does not have deep idle state
    or
 2. the deep idle state have fast exit latency

However, there are some discussions around setting in the kernel
a timer to force a wakeup a bit sooner (basically minus the exit
latency) in order to reduce the drift but that won't be for tomorrow
because other parameters are entering in the equation (eg. latency can
change depending on the CPU clock).

> But what I do not understand here is why pselect requires special=20
> handling while rest of the timer testcases that do exactly the same=20
> and end up using the very same hrtimer framework in kernel work=20
> fine.
> We do have at least select() and poll()=20

I tested them individually and they fail with the userspace governor+min
freq.

If I change the cpufreq governor to ondemand and run select0[0-4] one
after other, they don't fail. The reason is because the previous tests
have a CPU duty cycle long enough and the governor decides to stay at a
high frequency, thus reducing the exit latency.

> tests that should end up=20
> using the same timer with the same slack formula in kernel and hence=20
> should fail in the very same way. And possibly rest of the timer=20
> testcases should likely fail as well since these are not that=20
> different either.

The latencies introduced by the kernel energy saving framework can make
these tests to fail and it is impossible to get rid of that, except by
setting the latency to zero when running specific test cases.


> Are you, by any chance, using latest stable release? Since we had=20
> rewritten all the timer precision tests recently in:
>=20
> https://github.com/linux-test-project/ltp/commit/c459654db64cd29177a382ab=
178fdd5ad59664e4

Yes, I am.


>>> Also shouldn't this be set automatically for all timer related=20
>>> testcases (these that make use of the sampling function) rather=20
>>> than just for the pselect one? If so we should set the flag in=20
>>> the tst_timer_test.c library instead. Or we can also stick the=20
>>> latency setup/cleanup into the tst_timer_test.c as well and
>>> don't bother with adding more flags into the tst_test structure
>>> (see timer_setup() and timer_cleanup() in the tst_timer_test.c).
>>=20
>> I'm not sure. We may want to measure everything together (timer +=20
>> drift + energy framework latencies) in other testcases. I think it=20
>> is fine if we let the test program to decide what latency he wants=20
>> to set.
>=20
> Are you using latest git with the timer library? I would suspect that
> all of the test would need the very same treatement  since the test
> paramters and maximal error margins are all defined in a single place
> now.

Do you mean setting the zero latency in the tst_timer_test ?


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

