From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 03 Nov 2020 11:39:04 +0000
Subject: [LTP] [RFC][PATCH] tst_cgroup: Attempt to use CGroups V2 then
 V1 instead of guessing
In-Reply-To: <CAEemH2ef9t+az4b=1zWyjuWYnUOkENL7471g0KczhUx-XFRFjQ@mail.gmail.com>
References: <20200925121941.10475-1-rpalethorpe@suse.com>
 <CAEemH2eo6qVt0D36QVDFeW_2csWFEDnnghxRjd3_Ysu=CD-8Hw@mail.gmail.com>
 <87y2kuwa1x.fsf@suse.de>
 <CAEemH2ef9t+az4b=1zWyjuWYnUOkENL7471g0KczhUx-XFRFjQ@mail.gmail.com>
Message-ID: <87eela655z.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Li Wang <liwang@redhat.com> writes:

> On Mon, Sep 28, 2020 at 5:00 PM Richard Palethorpe <rpalethorpe@suse.de>
> wrote:
>
>> Hello Li,
>>
>> Li Wang <liwang@redhat.com> writes:
>>
>> >>
>> >> -static void tst_cgroup2_mount(const char *mnt_path, const char
>> *new_path)
>> >> +static int cgroup2_mount(const char *mnt_path, const char *new_path)
>> >>
>> >
>> > We'd like to make the series function name starts with tst_*.
>> >
>>
>> The idea is this will be an internal/static function and
>> tst_cgroup2_mount will be a public function if it is needed. I guess
>> that eventually there will be features only available in cgroup2, in
>> which case the test author will want to call tst_cgroup2_mount not
>> tst_cgroup_mount and they will just want it to fail with tst_brk if
>> cgroup2 can't be mounted.
>>
>
> Sounds good.
>
>
>>
>> Infact, if the user wants cpuset or some other V1 only controller, then
>> they should probably call tst_cgroup1_mount. AFAICT some of these
>> controllers will not be moved to V2. OTOH a functionally similar feature
>> may be available in V2, but with a different interface. There is a
>> difference between requiring a specific controller to test it and
>> needing some functionality without caring how it is provided.
>>
>> So I suggest providing an API for mounting specific cgroup versions and
>> controllers and an API to mount specific controllers of either version
>> (i.e. tst_cgroup_mount). Then we can create helper functions to provide
>> functionality without caring how it is achieved, if we need to do that.
>>
>
> This is a really good suggestion.
>
>
>> Other comments sound good! I will try creating another patch with
>> diagnostics.
>>
>
> Thanks!

Well, I have learnt some more about CGroups and reviewed some of our
tests which use them and am now considering the following. This is so
complicated that the below will probably turn out to be wrong as I try
to implement it.

1) Scan the system for mounted Cgroup controllers and create a data
   structure describing what controllers are mounted and where.

There is only one cgroup root, it is possible to mount it multiple
times, but it simplifies matters if we try to reuse whatever is already
mounted. Especially in the case of V1 where remounting with different
controller combinations will fail. Possibly there is some advantage to
remounting, but I can't see what because changes to one mount are likely
to be reflected in others, plus remounting is likely to fail if you
don't use the same mount options.

2) The user requests some controller values to be set in a unified
   hierarchy. The LTP library then tries to translate this to whatever
   CGroup setup the system is actually using.

If no cgroups are mounted, then we try to mount a simple V2 setup
falling back to the standard V1 setup with the (required) controllers in
separate hierarchies. For some tests this will result in a hybrid setup
because they first request a V2 compatible controller then a V1 only
controller (or the inverse if there are any V2 only controllers). At
least SUSE and Ubuntu are using hybrid setups so this is a valid thing
to test (unfortunately).

If we find mounted controllers then try to create a new LTP hierarchy in
the root of each controller (on V2 all the controllers are mounted to
the same place, but V1 allows all kinds of stuff).

3) The user requests some process is moved to a node of the unified
   hierarchy for one or more controllers.

Do the same setup as 2) if necessary. For V2 setups or V1 setups where
all the controllers are mounted to the same place the controller
argument is ignored. It is only relevant for V1 setups with separate
hierarchies for some of the controllers. Of course a version of the
interface can be provided without the controller argument.

4) The user requests processes are removed from our hierarchy (back to
root) and/or we destroy our hierarchy.

If we mounted any controllers unmount them, otherwise we just drain our
hierarchy and remove it. Some tests currently just move their process
into a cgroup (on each iteration instead of in setup) and never out of
it. I don't think this makes sense, so that is another thing to
investigate.

I think the above will work for tests which are simply trying to use
CGroup features even on systems which have an unusual V1 setup (but not
all V1 setups). For tests which are trying to test CGroups themselves,
then we will have to look at each test case and figure out if any code
can be shared.

For some tests (e.g. madvise06) we can provide a declarative interface
like:

tst_test.cgroup = {
                {"memory", "max", 256MB},
                {"memory", "swappiness", 60},
                { NULL },
};

Then the library will create a cgroup, set the memory controllers limit
and put the test process in the cgroup. However a more thorough review
of our cgroup usage is needed before deciding on a declarative
interface.

Note that so far I have not seen a need to create complex hierarchies
for our tests or use threaded V2 controllers, but we will need to do
this to test cgroups themselves. However most tests just need some basic
cgroup features and we can use test variants to enable random cgroup
features on any test or implement cgroups in the test runner.

-- 
Thank you,
Richard.
