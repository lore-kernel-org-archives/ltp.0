From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Fri, 17 Jan 2020 22:14:35 +0530
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.13-rc1-7f1b863.cki
 (stable)
In-Reply-To: <1477632721.2420697.1579250111441.JavaMail.zimbra@redhat.com>
References: <cki.FA900DB853.LBD049H627@redhat.com>
 <84944fa0-3c18-f8a4-47ca-7627eb4e0594@redhat.com>
 <20200116153741.GA558@rei>
 <1477632721.2420697.1579250111441.JavaMail.zimbra@redhat.com>
Message-ID: <CA+G9fYuuVLziEVJ+93OWSWeB0h-=_qaYcAObe=_JSsbtydO7cQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, 17 Jan 2020 at 14:05, Jan Stancek <jstancek@redhat.com> wrote:
>
>
>
> ----- Original Message -----
> > Hi!
> > > > One or more kernel tests failed:
> > > >
> > > >      ppc64le:
> > > >       ??? LTP
> > >
> > > Hi, I see max_map_count failed on ppc64le:
> > > https://artifacts.cki-project.org/pipelines/385189/logs/ppc64le_host_2_LTP_mm.run.log
> >
> > That's strange, we do attempt to map 65536 mappings but we do not touch
> > them, so these shouldn't be faulted in, so there is no real reason why
> > mmap() in the child process should stop prematurely at 65532.
> >
> > I guess that we cannot do much here, unless it's reproducible, because
> > there is not much information there.
>
> max_map_count.c:205: FAIL: 64882 map entries in total, but expected 65536 entries
>
> I can reproduce it by running it in loop for couple hours. Though no idea
> why we started seeing it only in 5.4.13 rc kernels, as there doesn't seem
> to be any significant mm changes.
>
> I'll try some older kernels.

I have noticed max_map_count fail intermittently on multiple stable
branches on slow devices.

max_map_count.c:202: FAIL: 63231 map entries in total, but expected
65536 entries

https://qa-reports.linaro.org/lkft/linux-stable-rc-4.19-oe/tests/ltp-mm-tests/max_map_count
https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-mm-tests/max_map_count?&page=2

- Naresh
