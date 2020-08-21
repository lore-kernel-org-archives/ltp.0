From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Fri, 21 Aug 2020 10:14:16 +0800
Subject: [LTP] [PATCH] setxattr03: TCONF if failed to set immutable flag
In-Reply-To: <CAEemH2faf5g0JUdBFNvqrNRHB5orbTvHnrwHCm5enF7tt7N=YA@mail.gmail.com>
References: <20200820015211.u7xdye5ggbe34fsp@xzhoux.usersys.redhat.com>
 <CAEemH2faf5g0JUdBFNvqrNRHB5orbTvHnrwHCm5enF7tt7N=YA@mail.gmail.com>
Message-ID: <20200821021416.4jkqe2e57d42xkmx@xzhoux.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

On Thu, Aug 20, 2020 at 02:16:07PM +0800, Li Wang wrote:
> Hi Murphy,
> 
> On Thu, Aug 20, 2020 at 9:52 AM Murphy Zhou <jencce.kernel@gmail.com> wrote:
> 
> > Instead of TBROK, probably the underlying filesystem not support this flag.
> >
> 
> Which filesystem do you mean here? What kind of error it was given?
> Maybe we should confirm the errno is EINVAL or ENOTSUP before TCONF.

NFS, with latest upstream kernel.

Like:

tst_test.c:1247: INFO: Timeout per run is 0h 15m 00s
setxattr03.c:142: BROK: Set setxattr03immutable immutable failed: ENOTTY (25)
setxattr03.c:154: WARN: Unset setxattr03immutable immutable failed: ENOTTY (25)

The reason not checking errno is that `chattr +i` is a very basic operation,
if it fails, most probably it's not supported. NFS returning ENOTTY
makes checking errno more tricky. So I did not check it and made it as
simple as the checking in xfstests.

Thanks very much for reviewing!

> 
> -- 
> Regards,
> Li Wang

-- 
Murphy
