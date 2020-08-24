From: Li Wang <liwang@redhat.com>
Date: Mon, 24 Aug 2020 16:51:20 +0800
Subject: [LTP] [PATCH] setxattr03: TCONF if failed to set immutable flag
In-Reply-To: <20200821021416.4jkqe2e57d42xkmx@xzhoux.usersys.redhat.com>
References: <20200820015211.u7xdye5ggbe34fsp@xzhoux.usersys.redhat.com>
 <CAEemH2faf5g0JUdBFNvqrNRHB5orbTvHnrwHCm5enF7tt7N=YA@mail.gmail.com>
 <20200821021416.4jkqe2e57d42xkmx@xzhoux.usersys.redhat.com>
Message-ID: <CAEemH2fYW2Q8CdQgEtfc3ao-XYGZ3x3OTNCgcCY07j0DLkN-Vg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Fri, Aug 21, 2020 at 10:14 AM Murphy Zhou <jencce.kernel@gmail.com>
wrote:

> Hi Li,
>
> On Thu, Aug 20, 2020 at 02:16:07PM +0800, Li Wang wrote:
> > Hi Murphy,
> >
> > On Thu, Aug 20, 2020 at 9:52 AM Murphy Zhou <jencce.kernel@gmail.com>
> wrote:
> >
> > > Instead of TBROK, probably the underlying filesystem not support this
> flag.
> > >
> >
> > Which filesystem do you mean here? What kind of error it was given?
> > Maybe we should confirm the errno is EINVAL or ENOTSUP before TCONF.
>
> NFS, with latest upstream kernel.
>

It sounds like a new issue appears in the mainline kernel testing.


> Like:
>
> tst_test.c:1247: INFO: Timeout per run is 0h 15m 00s
> setxattr03.c:142: BROK: Set setxattr03immutable immutable failed: ENOTTY
> (25)
> setxattr03.c:154: WARN: Unset setxattr03immutable immutable failed: ENOTTY
> (25)
>

I noticed the setxattr03 skipped on kernel v5.8-rc6, which means the newer
kernel
starts to support xattr in NFSv4.2? if so, shouldn't we check why it
returns ENOTTY
but not ENOTSUP in failed setxflags?

(btw, I assumed you guys did NOT change the mount way with user_xattr
option)

    Kernel Version: 5.8.0-rc6+
    setxattr03.c:135: CONF: No xattr support in fs or fs mounted without
user_xattr option


>
> The reason not checking errno is that `chattr +i` is a very basic
> operation,
> if it fails, most probably it's not supported. NFS returning ENOTTY
> makes checking errno more tricky. So I did not check it and made it as
> simple as the checking in xfstests.
>
> Thanks very much for reviewing!
>
> >
> > --
> > Regards,
> > Li Wang
>
> --
> Murphy
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200824/1b08664b/attachment.htm>
