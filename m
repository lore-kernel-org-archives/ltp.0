From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Sun, 16 Sep 2018 13:58:31 -0300
Subject: [LTP] LTP master: arm64: execveat03: execveat() returned
 unexpected errno: EINVAL
In-Reply-To: <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
References: <CA+G9fYsEqrXhTK=TJ0m8aTDonEG39HT1aLnV4GnsZuHB7c38ow@mail.gmail.com>
 <811224868.48837664.1537008641635.JavaMail.zimbra@redhat.com>
Message-ID: <CABdQkv-nmBfK3=+2u2fHGCO-WVF=rHpnqVgHnxLechaL+VXyeA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Jan, Naresh:

The fix has been backported to:

$ git tag --contains ff1663fc9483e131f674db8b2f42f9a99460ae50
v4.18.7
v4.18.8

$ git tag --contains 5a842ecca279f583c3fdc9a1ed8fe7a4cc348789
v4.14.69
v4.14.70

This fix has not been backported to v4.9 nor v4.4.

From the build URL:
http://snapshots.linaro.org/openembedded/ltp/rocko/hikey/300/rpb/
Looks like build from commit 94710cac did NOT contain needed fix.

I think it will be all good for future builds.

Naresh,

I would blacklist this one for 4.4 and 4.9.

On Sat, Sep 15, 2018 at 7:50 AM Jan Stancek <jstancek@redhat.com> wrote:
> ----- Original Message -----
> > LTP master testing on Hikey (arm64) device reported newly added
> > execveat03 failed.
>
> Looks expected if your kernel doesn't have commit:
>       355139a8dba4 ("cap_inode_getsecurity: use d_find_any_alias()
>                      instead of d_find_alias()")
>
> Can you confirm?
>
> > Test output,
> > execveat03.c:74: FAIL: execveat() returned unexpected errno: EINVAL
> >
> > Full log link,
> > https://lkft.validation.linaro.org/scheduler/job/420924#L2941
> >
> > FYI,
> > LTP Version: 20180515-270-ge7bab6188
> >
> > Best regards
> >
> > Naresh Kamboju
