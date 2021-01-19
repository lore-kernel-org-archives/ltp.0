From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 19 Jan 2021 12:15:10 +0000
Subject: [LTP] [RFC PATCH 2/5] CGroup API rewrite
In-Reply-To: <CAEemH2diKwkvjZ=20+MGpNJsWzM3OskDbcyuY7MH3tEsGV4U=Q@mail.gmail.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
 <20201216100121.16683-3-rpalethorpe@suse.com>
 <CAEemH2ddomP4XO=61vNx5=3vQYNj4WOurUX2zcuC-46RxhMk0g@mail.gmail.com>
 <87eej1dpgm.fsf@suse.de>
 <CAEemH2diKwkvjZ=20+MGpNJsWzM3OskDbcyuY7MH3tEsGV4U=Q@mail.gmail.com>
Message-ID: <87eeihp1gx.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

> On Mon, Jan 4, 2021 at 5:24 PM Richard Palethorpe <rpalethorpe@suse.de>
> wrote:
>
>> Hello Li,
>>
>> Li Wang <liwang@redhat.com> writes:
>>
>> >>
>> >
>> > As I was mentioned in 0/5 that maybe we should create test_cgroup_dir
>> > for different progress so that the test could use the same controller
>> with
>> > various configurations in parallel.
>> >
>> > e.g. child_1 set SIZE to memory.limit_in_bytes
>> >        child_2 set SIZE/2 to memory.limit_in_bytes
>> >
>> > Any possibility to move this to tst_cgroup_move_current?
>>
>> Yes I suppose we can try this. Is there a test which already requires it?
>>
>
> So far we don't have such a test, I remember that in the previous Lib is
> also to keep expandability.

I think we have at least two problems:

1) This allows many CGroups to be created for each test and we must
   clean them up, adding some complication.

2) It's not clear if a future test will require the CGroup hierarchy to
   be the same as the process hierarchy or different. Depending what
   behaviour for tst_cgroup_move_current we choose it will make some
   configurations impossible.

So if we add this then it will add complexity, but I am not sure it will
help in the future. If we make it flexible enough to support any
hierarchy this will add a lot of complication.

Also if we did need this feature in the future, then we can add some new
functions which take a sub-group (or hierarchy) parameter. e.g.

void tst_cgroup_move(enum tst_cgroup_ctrl type, pid_t pid,
                     struct tst_cgroup_tree *path);

Alternate versions of other functions would also need to be added. Also
some changes to the internal data structures may be needed. However it
would keep the current API functions simple.

So until we have a test which requires this, I think the best option is
to do nothing :-)

-- 
Thank you,
Richard.
