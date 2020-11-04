From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Nov 2020 17:12:09 +0800
Subject: [LTP] [RFC][PATCH] tst_cgroup: Attempt to use CGroups V2 then
 V1 instead of guessing
In-Reply-To: <87eela655z.fsf@suse.de>
References: <20200925121941.10475-1-rpalethorpe@suse.com>
 <CAEemH2eo6qVt0D36QVDFeW_2csWFEDnnghxRjd3_Ysu=CD-8Hw@mail.gmail.com>
 <87y2kuwa1x.fsf@suse.de>
 <CAEemH2ef9t+az4b=1zWyjuWYnUOkENL7471g0KczhUx-XFRFjQ@mail.gmail.com>
 <87eela655z.fsf@suse.de>
Message-ID: <CAEemH2dA2n2k_kquCtBSZVXNF_qtteDS+QA2vZd75NBaHMcWEw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Richard,

Richard Palethorpe <rpalethorpe@suse.de> wrote:

...
>
> Well, I have learnt some more about CGroups and reviewed some of our
> tests which use them and am now considering the following. This is so
> complicated that the below will probably turn out to be wrong as I try
> to implement it.
>

Glad to see your improvement plan.

It's okay, we can try it in practice. Sometimes the perfect solution
will be born in the code iteration :).


>
> 1) Scan the system for mounted Cgroup controllers and create a data
>    structure describing what controllers are mounted and where.
>
> There is only one cgroup root, it is possible to mount it multiple
> times, but it simplifies matters if we try to reuse whatever is already
> mounted. Especially in the case of V1 where remounting with different
> controller combinations will fail. Possibly there is some advantage to
> remounting, but I can't see what because changes to one mount are likely
> to be reflected in others, plus remounting is likely to fail if you
> don't use the same mount options.
>

I doubt that will be simplified to reuse the existing CGroup, It
sounds a bit idealization. Since there might be different paths
mounted on their Linux distributions or self-customized system,
we have to cover/scan all unsure situations if go this way, isn't it?


>
> 2) The user requests some controller values to be set in a unified
>    hierarchy. The LTP library then tries to translate this to whatever
>    CGroup setup the system is actually using.
>
> If no cgroups are mounted, then we try to mount a simple V2 setup
> falling back to the standard V1 setup with the (required) controllers in
> separate hierarchies. For some tests this will result in a hybrid setup
> because they first request a V2 compatible controller then a V1 only
> controller (or the inverse if there are any V2 only controllers). At
> least SUSE and Ubuntu are using hybrid setups so this is a valid thing
> to test (unfortunately).
>
+1
Yes, I totally agree to handle this kind of issue, which currently
LTP-CGroup-Lib has not done it. This is the new progress for us.


>
> If we find mounted controllers then try to create a new LTP hierarchy in
> the root of each controller (on V2 all the controllers are mounted to
> the same place, but V1 allows all kinds of stuff).
>

That sounds too complicated, there would be a situation that partly
used V2 in the root CGroup and also to use the V1-only controller
in a newly mounted V1 hierarchy.

Another concern is about the cleanup work, I'm not sure this will
be more simple or needs unify way to remove all created dir in the
hierarchy for both V2 and V1 mixed.

And, it is probably much difficult for debugging if hitting some problems.


>
> 3) The user requests some process is moved to a node of the unified
>    hierarchy for one or more controllers.
>
> Do the same setup as 2) if necessary. For V2 setups or V1 setups where
> all the controllers are mounted to the same place the controller
> argument is ignored. It is only relevant for V1 setups with separate
> hierarchies for some of the controllers. Of course a version of the
> interface can be provided without the controller argument.
>
> 4) The user requests processes are removed from our hierarchy (back to
> root) and/or we destroy our hierarchy.
>
> If we mounted any controllers unmount them, otherwise we just drain our
> hierarchy and remove it. Some tests currently just move their process
> into a cgroup (on each iteration instead of in setup) and never out of
>

Right, but at least, all of the processes will be kick-out from CGroup
hierarchy before unmounting in the cleanup phase.


> it. I don't think this makes sense, so that is another thing to
> investigate.
>
> I think the above will work for tests which are simply trying to use
> CGroup features even on systems which have an unusual V1 setup (but not
> all V1 setups). For tests which are trying to test CGroups themselves,
> then we will have to look at each test case and figure out if any code
> can be shared.
>
> For some tests (e.g. madvise06) we can provide a declarative interface
> like:
>
> tst_test.cgroup = {
>                 {"memory", "max", 256MB},
>                 {"memory", "swappiness", 60},
>                 { NULL },
> };
>
> Then the library will create a cgroup, set the memory controllers limit
> and put the test process in the cgroup. However a more thorough review
> of our cgroup usage is needed before deciding on a declarative
> interface.
>
> Note that so far I have not seen a need to create complex hierarchies
> for our tests or use threaded V2 controllers, but we will need to do
> this to test cgroups themselves. However most tests just need some basic
>

+1
That's also a long term goal for LTP and I had left open interfaces for the
purpose of extending and further development work.


> cgroup features and we can use test variants to enable random cgroup
> features on any test or implement cgroups in the test runner.
>

Good point.

Btw, I think you can try the thoughts first, as you mentioned it is
too complicated so we can't finish everything just in one time.
But the better solution will be fine out in practice I believe.

Here is the previous discussion about cover different CGroup scenarios
supporting(the end part of email), FYI:
http://lists.linux.it/pipermail/ltp/2020-June/017442.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201104/6a0d84fa/attachment.htm>
