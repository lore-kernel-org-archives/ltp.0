From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 04 Nov 2020 11:44:12 +0000
Subject: [LTP] [RFC][PATCH] tst_cgroup: Attempt to use CGroups V2 then
 V1 instead of guessing
In-Reply-To: <CAEemH2dA2n2k_kquCtBSZVXNF_qtteDS+QA2vZd75NBaHMcWEw@mail.gmail.com>
References: <20200925121941.10475-1-rpalethorpe@suse.com>
 <CAEemH2eo6qVt0D36QVDFeW_2csWFEDnnghxRjd3_Ysu=CD-8Hw@mail.gmail.com>
 <87y2kuwa1x.fsf@suse.de>
 <CAEemH2ef9t+az4b=1zWyjuWYnUOkENL7471g0KczhUx-XFRFjQ@mail.gmail.com>
 <87eela655z.fsf@suse.de>
 <CAEemH2dA2n2k_kquCtBSZVXNF_qtteDS+QA2vZd75NBaHMcWEw@mail.gmail.com>
Message-ID: <87zh3x4a9f.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> Hi Richard,
>
> Richard Palethorpe <rpalethorpe@suse.de> wrote:
>
> ...
>>
>> Well, I have learnt some more about CGroups and reviewed some of our
>> tests which use them and am now considering the following. This is so
>> complicated that the below will probably turn out to be wrong as I try
>> to implement it.
>>
>
> Glad to see your improvement plan.
>
> It's okay, we can try it in practice. Sometimes the perfect solution
> will be born in the code iteration :).

+1

>
>
>>
>> 1) Scan the system for mounted Cgroup controllers and create a data
>>    structure describing what controllers are mounted and where.
>>
>> There is only one cgroup root, it is possible to mount it multiple
>> times, but it simplifies matters if we try to reuse whatever is already
>> mounted. Especially in the case of V1 where remounting with different
>> controller combinations will fail. Possibly there is some advantage to
>> remounting, but I can't see what because changes to one mount are likely
>> to be reflected in others, plus remounting is likely to fail if you
>> don't use the same mount options.
>>
>
> I doubt that will be simplified to reuse the existing CGroup, It
> sounds a bit idealization. Since there might be different paths
> mounted on their Linux distributions or self-customized system,
> we have to cover/scan all unsure situations if go this way, isn't it?

To clarify; I think the only option is to reuse existing CGroups if the
system has already mounted them. We can rebind/mount them to a new path,
but it is the same structure underneath.

If you try to remount the CGroup with different options from the
original mount then it will fail. This is especially true for V1
controllers which may be mounted together or separately. So we must
parse the mounts file and look at the options anyway.

The alternative would be to not run the test if cgroups are already
mounted or refuse to run if they are mounted in a way we can't handle.

Note that the kernel self-tests scan the system for an existing V2
hierarchy and don't try to mount anything. Because they only test V2
this is pretty simple.

>
>
>>
>> 2) The user requests some controller values to be set in a unified
>>    hierarchy. The LTP library then tries to translate this to whatever
>>    CGroup setup the system is actually using.
>>
>> If no cgroups are mounted, then we try to mount a simple V2 setup
>> falling back to the standard V1 setup with the (required) controllers in
>> separate hierarchies. For some tests this will result in a hybrid setup
>> because they first request a V2 compatible controller then a V1 only
>> controller (or the inverse if there are any V2 only controllers). At
>> least SUSE and Ubuntu are using hybrid setups so this is a valid thing
>> to test (unfortunately).
>>
> +1
> Yes, I totally agree to handle this kind of issue, which currently
> LTP-CGroup-Lib has not done it. This is the new progress for us.
>
>
>>
>> If we find mounted controllers then try to create a new LTP hierarchy in
>> the root of each controller (on V2 all the controllers are mounted to
>> the same place, but V1 allows all kinds of stuff).
>>
>
> That sounds too complicated, there would be a situation that partly
> used V2 in the root CGroup and also to use the V1-only controller
> in a newly mounted V1 hierarchy.
>
> Another concern is about the cleanup work, I'm not sure this will
> be more simple or needs unify way to remove all created dir in the
> hierarchy for both V2 and V1 mixed.
>
> And, it is probably much difficult for debugging if hitting some
> problems.

This is why CGroups V1 is deprecated and V2 only has a unified hierarchy
:-p.

Again if the system has already mounted some unusual V1 setup then you
can not change that. We either have to scan it and create our hierarchy
multiple times for each set of mounted controllers or refuse to run.

For example try something like the following (with no cgroups mounted):

$ mount -t cgroup -o cpu,cpuacct nodev /tmp/a
$ mount -t cgroup -o cpu         nodev /tmp/b

The second mount should fail, however the following should work:

$ mount -t cgroup -o cpuacct nodev /tmp/a
$ mount -t cgroup -o cpu     nodev /tmp/b

This is because there is only one instance of each controller and the
hierarchy it is attached to. The controllers and cgroup hierarchies are
created during the first mount, but are then reused by any further
mounts.

-- 
Thank you,
Richard.
