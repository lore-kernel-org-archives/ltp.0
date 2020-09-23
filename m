From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Sep 2020 22:40:01 +0800
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <87mu1gy6r8.fsf@suse.de>
References: <20200609095102.21153-1-liwang@redhat.com> <87pn6cycui.fsf@suse.de>
 <CAEemH2eqPgS=2n5NAgiVgE6Q+mie0=hiu-wn1OCrxPNEHnd1BA@mail.gmail.com>
 <87mu1gy6r8.fsf@suse.de>
Message-ID: <CAEemH2eCEyebEBZhuQJ+FHs9UpWw_+A=D0vJbx6g8KixPTH4jA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 23, 2020 at 9:14 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> ...
> > That's on purpose because we don't want the user to mix v1 and v2 in
> using.
> > In other words, if a version of cgroup has been chosen on a SUT then LTP
> > follows in the same version.
> >
> > The cgroup lib choose cgroup version likes:
> >       * system doesn't support any cgroup(v1, v2): TCONF
> >       * system only support cgroup v1: choose v1
> >       * system only support cgroup v2: choose v2
> >       * system support v1 & v2 but mounting v1: chosse v1   <=== this is
> > what you met
>
> Perhaps you meant:
>
> if (tst_is_mounted("cgroup"))
>    cg_ver = TST_CGROUP_V1;
> else
>    cg_ver = TST_CGROUP_V2;
>

This is not enough for the version choice. As tst_is_mounted(?cgroup?) can't
distinguish precisely what "cgroup" or "cgroup2" has been mounted. Because
the function is fuzzy matching a string.



> >
> > To be honest, I hope a Linux distribution provides a pure way in cgroup
> > using, which means just mounting V1 or V2 but not to mix together. Or, do
> > you think LTP should handle the situation for the v1&v2 mixing mount?
>
> For now, I think we just need to use V1 if it is mounted. I don't like
> the fact we have both mounted, but it seems most software can handle it,
> so LTP should as well.
>

Agreed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200923/eefa7f5a/attachment.htm>
