From: Li Wang <liwang@redhat.com>
Date: Wed, 23 Sep 2020 20:23:49 +0800
Subject: [LTP] [PATCH v4 1/4] lib: add new cgroup test API
In-Reply-To: <87pn6cycui.fsf@suse.de>
References: <20200609095102.21153-1-liwang@redhat.com> <87pn6cycui.fsf@suse.de>
Message-ID: <CAEemH2eqPgS=2n5NAgiVgE6Q+mie0=hiu-wn1OCrxPNEHnd1BA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Sep 23, 2020 at 7:03 PM Richard Palethorpe <rpalethorpe@suse.de>
wrote:

> Hello,
>
> Li Wang <liwang@redhat.com> writes:
>
> > Many of our LTP tests need Control Group in the configuration,
> > this patch makes cgroup unified mounting at setup phase to be
> > possible. The method is extracted from mem.h with the purpose
> > of extendible for further developing, and trying to compatible
> > the current two versions of cgroup,
> >
> > It's hard to make all APIs be strictly consistent because there
> > are many differences between v1 and v2. But it capsulate the detail
> > of cgroup mounting in high-level functions, which will be easier
> > to use cgroup without considering too much technical thing.
> >
> > Btw, test get passed on RHEL7(x86_64), RHEL8(ppc64le),
> > Fedora32(x86_64).
>
> This appears to be broken on SUSE.
>
> > +enum tst_cgroup_ver tst_cgroup_version(void)
> > +{
> > +     if (tst_cgroup_check("cgroup2")) {
> > +             if (!tst_is_mounted("cgroup2") && tst_is_mounted("cgroup"))
>
> Unfortunately this is backwards: if a cgroup controller is mounted
> (e.g. memory) in the v1 separated hierarchy then it is not available in
> the cgroup v2 unified hierarchy even though the v2 unified hierarchy
> exists.
>

That's on purpose because we don't want the user to mix v1 and v2 in using.
In other words, if a version of cgroup has been chosen on a SUT then LTP
follows in the same version.

The cgroup lib choose cgroup version likes:
      * system doesn't support any cgroup(v1, v2): TCONF
      * system only support cgroup v1: choose v1
      * system only support cgroup v2: choose v2
      * system support v1 & v2 but mounting v1: chosse v1   <=== this is
what you met
      * system support v1 & v2 but mounting v2: choose v2
      * system support v1 & v2 but mounting none: choose v2



>
> So ksm{03,04} fails with:
>
> safe_file_ops.c:299: BROK: Failed to close FILE
> '/tmp/cgroup_mem/cgroup.subtree_control' at tst_cgroup.c:301: ENOENT (2)
>
> because we have the memory controller (in fact all the controllers)
> mounted in the V1 way, but we also have the cgroup2 mounted. If I
>

Hmm, this is a situation that system mount v1&v2 at the same time.

So the ksm03/4 choose v2 automatically but hit a problem in cgroup_v2 using.
I pesonally think it mainly imputes to the SUT config in cgroup, because
that
makes cgroup_v2 has no actuall controllers in the cgroup.controllers. After
umounting all V1 hierarchies, the controllers get back into V2.



> unmount the memory controller from V1 then the test passes.
>
> Another potential problem is that it may be possible to remove access to
> controllers some other way in which case you have to check
> cgroup.controllers to see what is available. OTOH maybe this is not
> possible because you mount a new cgroup2 hierarchy?
>

I'm not sure about this.

To be honest, I hope a Linux distribution provides a pure way in cgroup
using, which means just mounting V1 or V2 but not to mix together. Or, do
you think LTP should handle the situation for the v1&v2 mixing mount?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200923/a5ace332/attachment.htm>
