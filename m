From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Mon, 14 Aug 2017 16:19:34 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <20170814133351.GA11524@rei>
References: <337916262.70548323.1502450718721.JavaMail.zimbra@redhat.com>
 <1502456086-14696-1-git-send-email-daniel.lezcano@linaro.org>
 <20170811140905.GB3341@rei.lan>
 <b11d663b-0afb-58a7-bc3d-14d3e61084c4@linaro.org>
 <20170811152855.GA14152@rei.lan>
 <a0a61ae1-15fe-fc0d-9bfb-b2efd94f3c42@linaro.org>
 <20170814133351.GA11524@rei>
Message-ID: <99937465-7b6b-ce2c-6194-bf920b2994f4@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 14/08/2017 15:33, Cyril Hrubis wrote:

[ ... ]

>>> Are you, by any chance, using latest stable release? Since we had=20
>>> rewritten all the timer precision tests recently in:
>>>
>>> https://github.com/linux-test-project/ltp/commit/c459654db64cd29177a382=
ab178fdd5ad59664e4
>>
>> Yes, I am.
>=20
> That explains it. Previously each of the timer testcases had it's own
> PASS/FAIL criteria and each of them was slightly different. We got rid
> of that mess recetly and so the latest git has a timer measurement
> library and the test only defines a sampling function now. We also did
> quite a lot of testing to make sure that the test are stable now.  And
> because of that we take more samples and apply discarded mean to get rid
> of random outliners. But we did most of the testing on x86 hardware so
> it's possible that it still needs some adjustements.

IMO, you should not try to adjust this because there can be a so big gap
between some arch/platforms in term of exit_latency that can make the
test to miss a bug. I mean being more tolerant for one arch can make the
test miss a bug on another arch.

eg.

exynos4 : 5000us
at91: 10us
ux500: 70us
mediatek: 600us
ppc: 10us
x86: 86us
sh mobile: 2300us

etc...


The simplest and cleanest way is to reduce the latency to its minimum in
order to reduce the energy framework impact on the tests.

It is recent the mobile runs ltp.

> Can you, please, try with the latest git to see if these tests works for
> you now? And then, in a case that they stil fail, we will figure out how
> to fix them. Most likely we will patch the timer test library, either
> to loosen the crieria or to keep the cpu_dma_latecy open while we sample
> the timers.

There is a misunderstanding. I ran the tests (and they fail) on the
latest one 4a707d417e3f95025fe6c707e2763e84b2bed29a.





--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

