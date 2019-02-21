From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Thu, 21 Feb 2019 23:27:38 +0530
Subject: [LTP] [PATCH] syscalls/preadv203: Add basic RWF_NOWAIT test
In-Reply-To: <20190206121028.GC13516@rei>
References: <20190128134656.27979-1-metan@ucw.cz> <20190206080400.GB13396@x230>
 <20190206121028.GC13516@rei>
Message-ID: <CA+G9fYsGOC0KP3gD3Yn=gNGTfOG846OtQnBTCAfFe34+pQoPcg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 6 Feb 2019 at 17:40, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > +static void *nowait_reader(void *unused LTP_ATTRIBUTE_UNUSED)
> > ...
> > > +           TEST(preadv2(fd, rd_iovec, 2, off, RWF_NOWAIT));
> > RWF_NOWAIT needs to be declared in lapi for old distros.
>
> Right and we should as well return TCONF on older kernels, I haven't
> tested that properly yet but I guess that we should check for EOPNOTSUPP
> and EINVAL. I will do that later on, I just didn't want to delay the
> initial test patch because it seem that kernel developers wanted to
> have it ASAP.


LTP syscalls test preadv201 and preadv201_64 failed on 4.4 branch
kernel on all devices.
PASS 4.9, 4.14, 4.20 kernel versions.

OTOH,
preadv202 and preadv202_64 PASS on 4.4, 4.9, 4.14 and 4.20 kernel versions.

Test output log,
tst_test.c:1085: INFO: Timeout per run is 0h 15m 00s
preadv201.c:91: PASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:91: PASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:91: PASS: preadv2() read 32 bytes with content 'b' expectedly
preadv201.c:64: FAIL: preadv2() failed: EINVAL
preadv201.c:64: FAIL: preadv2() failed: EINVAL
preadv201.c:64: FAIL: preadv2() failed: EINVAL
Summary:
passed   3
failed   3
skipped  0
warnings 0
tst_test.c:1085: INFO: Timeout per run is 0h 15m 00s
preadv201.c:91: PASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:91: PASS: preadv2() read 64 bytes with content 'a' expectedly
preadv201.c:91: PASS: preadv2() read 32 bytes with content 'b' expectedly
preadv201.c:64: FAIL: preadv2() failed: EINVAL
preadv201.c:64: FAIL: preadv2() failed: EINVAL
preadv201.c:64: FAIL: preadv2() failed: EINVAL
Summary:
passed   3
failed   3
skipped  0
warnings 0

Full test log from 4.4  branch kernel x86_64,
https://lkft.validation.linaro.org/scheduler/job/614534#L7922

https://qa-reports.linaro.org/lkft/linux-stable-rc-4.4-oe/tests/ltp-syscalls-tests/preadv201

- Naresh
