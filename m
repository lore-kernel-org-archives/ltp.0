From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 20 Jan 2021 22:34:50 +0530
Subject: [LTP] [PATCH] tst_pollute_memory(): Set minimal safety margin
 to 64MB
In-Reply-To: <YAhHAWTedDb/6Hd/@yuki.lan>
References: <20210118163240.29558-1-mdoucha@suse.cz>
 <YAbT62ecN/lq12cT@yuki.lan>
 <CA+G9fYv_6tiMrF38jLPYK=C6D+LNBndun1XuGQJiOK60LhYRyA@mail.gmail.com>
 <YAhEEzWShFLlHrk1@yuki.lan>
 <CA+G9fYuDpnJOcHA5Me4KM4v+NaFW=2_3id=Am6skbDavb1iACw@mail.gmail.com>
 <YAhHAWTedDb/6Hd/@yuki.lan>
Message-ID: <CA+G9fYtKz+mW4S3SjgNDomPKo8JbVh9SyQYbbj92xZYxuEmG1Q@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 20 Jan 2021 at 20:35, Cyril Hrubis <chrubis@suse.cz> wrote:
>
> Hi!
> > > > I have applied your patch and rebuilt completely and retested
> > > > ioctl_sg01 test case in a loop on three different devices.
> > > >
> > > > 1 PASS out of 20 runs with overcommit_memory 0 on x86_64.
> > > > 1 PASS out of 20 runs with overcommit_memory 1 on x86_64.
> > > >
> > > > Which means 19 times the test case triggered oom-killer and the test was broken.
> > >
> > > So it looks like 64MB is not enough in your case.
> > >
> > > Does it work with 128MB or 256MB?
> > >
> > > i.e.:
> > >
> > > safety = MAX(4096 * SAFE_SYSCONF(_SC_PAGESIZE), 128 * 1024 * 1024);

After changing to 128MB the test got PASS with overcommit_memory 0 on x86_64.

- Naresh
