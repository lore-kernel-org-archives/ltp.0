From: Daniel Lezcano <daniel.lezcano@linaro.org>
Date: Thu, 17 Aug 2017 16:02:23 +0200
Subject: [LTP] [PATCH V2 1/2] ltp: Add the ability to specify the
 latency constraint
In-Reply-To: <20170817135029.GA31322@rei>
References: <20170811140905.GB3341@rei.lan>
 <b11d663b-0afb-58a7-bc3d-14d3e61084c4@linaro.org>
 <20170811152855.GA14152@rei.lan>
 <a0a61ae1-15fe-fc0d-9bfb-b2efd94f3c42@linaro.org>
 <20170814133351.GA11524@rei>
 <99937465-7b6b-ce2c-6194-bf920b2994f4@linaro.org>
 <20170814143609.GB11524@rei>
 <a1f4e3bb-3b7d-c259-67d1-596ee6f2b142@linaro.org>
 <20170815110648.GC20715@rei.lan>
 <dafa7cdd-a9c6-1b1f-cbd8-b35d271d8d9f@linaro.org>
 <20170817135029.GA31322@rei>
Message-ID: <159427fd-195a-8a6c-086f-2f01d829e8a7@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On 17/08/2017 15:50, Cyril Hrubis wrote:
> Hi!
>>>> Yes, that make sense.
>>>>
>>>> Do you want keep the latency option for future use?
>>>
>>> I tend not to add anything just in case that we may need it later in
>>> order to keep the test library as small as possible, it's complex enough
>>> even as it is. Moreover we can always add it easily when we find a test
>>> that requires it.
>>
>> Setting the latency to zero in tst_timer_start(), if the opening of the
>> /dev/cpu_dma_latency file fails, we continue but issue a warning with =09
>>
>> 	tst_resm(TWARN,
>> 		"Failed to open '/dev/cpu_dma_latency': %s',
>> 		strerror(errno));
>>
>> is ok ?
>=20
> Issuing TWARN marks the test as a failure, you should go for TINFO if
> you want just inform the user about non-fatal problem.

Ok.


> Also are you sure that tst_timer_start() is the right place to open the
> file? That function is called ~1000 times in each timer test hence this
> would add quite a bit of overhead. Why don't we just put it into the
> timer_setup() in the lib/tst_timer_test.c that is called once at the
> start of the test?

Yes, absolutely.

Thanks.

  -- Daniel




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for ARM=
 SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

