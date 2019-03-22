From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Fri, 22 Mar 2019 10:36:25 -0300
Subject: [LTP] [PATCH v3 4/4] syscalls/clock_adjtime: create
 clock_adjtime syscall tests
In-Reply-To: <20190322133425.GB20408@rei.lan>
References: <20190321141015.GG1252@rei>
 <20190321202732.3331-1-rafael.tinoco@linaro.org>
 <20190321202732.3331-4-rafael.tinoco@linaro.org>
 <5A6B4777-4D7E-4D2A-A338-8972236466C1@linaro.org>
 <20190322133425.GB20408@rei.lan>
Message-ID: <1D255064-CE80-42FF-A607-6C60AFF771C8@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

> On 22 Mar 2019, at 10:34, Cyril Hrubis <chrubis@suse.cz> wrote:
>=20
> Hi!
>>> +	if (rval !=3D TIME_OK)
>>> +		tst_brk(TBROK | TTERRNO, "unsynced clock or on-going leap???);
>>=20
>> I choose to break test if rval > 0 mainly because it could still have
>> on-going leap operations, since clock_adjtime() is async, and also
>> because doing the test with an unsynced clock seems weird.
>=20
> We should print the saved with timex_show() here and the rval at least.

Alright. v4 on its way.

>=20
> It however it looks like kernel boots with STA_UNSYNC until NTP manges
> to sync the time and clears the flag but only if it manages to sync the
> clock.
>=20
> See:
>=20
> http://linuxelf.com/blog/2017/03/27/clock-status-unsync/
>=20
> Which itself is an argument to run the test with unsynced clock, since
> not all environments have access to internet or ntp daemon running.

Valid point. I=E2=80=99ll allow rval being 5 then.

>=20
> --=20
> Cyril Hrubis
> chrubis@suse.cz


