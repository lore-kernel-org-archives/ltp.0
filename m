From: Saravana Kannan <saravanak@google.com>
Date: Tue, 19 Mar 2019 13:19:46 -0700
Subject: [LTP] [PATCH v2] setpriority01: Skip only PRIO_USER when unable
 to add test user
In-Reply-To: <20190319112815.GA19707@dell5510>
References: <20190307233154.12873-1-saravanak@google.com>
 <20190319083210.GB26794@dell5510>
 <20190319100348.GA6204@rei> <20190319102803.GA13634@dell5510>
 <20190319103140.GD6204@rei> <20190319112815.GA19707@dell5510>
Message-ID: <CAGETcx--V=PEvDPqGz3AtA=wXdnsKSSoSe=LX_NcFhckWF-3RA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The problem with using eaccess is that it doesn't build on Android as
eaccess isn't implemented.

I vote for mapping useradd exit code 1 to TCONF. Sure there are some very
unlikely cases where useradd might fail with 1 when the file system is
writable. Excluding that corner case if it means being able to run on a lot
of Android devices seems like a good compromise.

-Saravana


On Tue, Mar 19, 2019 at 4:28 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > > > > > I still think v1 is the right approach. But if you want TCONF
> for only
> > > > > > for cases like Android where useradd itself isn't present, then
> v2 would
> > > > > > be the right patch.
> > > > > Agree with it, but waiting for Cyril approval to merge it.
>
> > > > As far as I can tell this patch still removes the read-only rootfs
> check
> > > > introduced in:
> > > Good catch, eaccess check should stay in.
> > > I'll put it back again and push, ok?
>
> > Or we can check the return value 1 from useradd and map it to TCONF as
> > suggested by Saravana.
> Probably. According to useradd sources, exit 1 (E_PW_UPDATE) also happen
> when
> problems to lock /etc/passwd, which could theoretically on different
> circumstance than read-only /, but I guess we can ignore it.
>
> Or we could use statvfs to detect read-only / ("can't update password
> file" does
> can be for different purposes), but I wouldn't bother and user return
> value 1.
>
> Kind regards,
> Petr
>
> [1] https://github.com/shadow-maint/shadow/blob/master/src/useradd.c#L1626
>
> --
> You received this message because you are subscribed to the Google Groups
> "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to kernel-team+unsubscribe@android.com.
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190319/ecb38559/attachment-0001.html>
