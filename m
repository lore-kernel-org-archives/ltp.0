From: Amir Goldstein <amir73il@gmail.com>
Date: Wed, 30 Jan 2019 20:49:34 +0200
Subject: [LTP] [PATCH 4.14 00/68] 4.14.97-stable review
In-Reply-To: <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
References: <20190129113131.751891514@linuxfoundation.org>
 <CA+G9fYvh6axRDLWpR3_ozw46JUknsYgEjvYOZfQEUbhroHPVTA@mail.gmail.com>
Message-ID: <CAOQ4uxiZ2ZPfcVNSX64ZD_JqQuBwz45_WAoNjpYEhfvTuHgZHQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: ltp@lists.linux.it

On Wed, Jan 30, 2019 at 2:55 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> On Tue, 29 Jan 2019 at 17:19, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > This is the start of the stable review cycle for the 4.14.97 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> >
> > Responses should be made by Thu Jan 31 11:31:10 UTC 2019.
> > Anything received after that time might be too late.
> >
> > The whole patch series can be found in one patch at:
> >         https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patc=
h-4.14.97-rc1.gz
> > or in the git tree and branch at:
> >         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stab=
le-rc.git linux-4.14.y
> > and the diffstat can be found below.
> >
> > thanks,
> >
> > greg k-h
>
> Results from Linaro=E2=80=99s test farm.
> No regressions on arm64, arm, x86_64, and i386.
>
> NOTE:
> -----
> LTP upgrade to 20190115 and fanotify01, fanotify09 and readahead02 tests =
failed
>
> fanotify01 failed on hikey and dragonboard410c arm64 boards all kernel ve=
rsions
> fanotify01.c:256: FAIL: got event: mask=3D2 (expected 20) pid=3D2756 fd=
=3D9
> https://bugs.linaro.org/show_bug.cgi?id=3D4261
>
> fanotify09 failed on arm64 devices running 4.14 version kernel
> fanotify09.c:202: FAIL: first group got more than 2 events (72 > 48)
> https://bugs.linaro.org/show_bug.cgi?id=3D4271
>

fanotify09 was added a new regression test case for commit
  b469e7e47c8a: fanotify: fix handling of events on child sub-directory

That commit was backported to v4.19. As I wrote in "backport hint", the bug
exists in older kernels, but fix does not apply cleanly to older kernels.

Thanks,
Amir.
