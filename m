From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Fri, 16 Oct 2020 16:05:21 +0100
Subject: [LTP] [RFC PATCH] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <87sgaesba0.fsf@suse.de>
References: <20201014190749.24607-1-rpalethorpe@suse.com>
 <20201016094702.GA95052@blackbook> <87sgaesba0.fsf@suse.de>
Message-ID: <87pn5irz2m.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Richard Palethorpe <rpalethorpe@suse.de> writes:

> Hello Michal,
>
> Michal Koutn? <mkoutny@suse.com> writes:
>
>> Hello.
>>
>> On Wed, Oct 14, 2020 at 08:07:49PM +0100, Richard Palethorpe <rpalethorpe@suse.com> wrote:
>>> SLAB objects which outlive their memcg are moved to their parent
>>> memcg where they may be uncharged. However if they are moved to the
>>> root memcg, uncharging will result in negative page counter values as
>>> root has no page counters.
>> Why do you think those are reparented objects? If those are originally
>> charged in a non-root cgroup, then the charge value should be propagated up the
>> hierarchy, including root memcg, so if they're later uncharged in root
>> after reparenting, it should still break even. (Or did I miss some stock
>> imbalance?)
>
> I traced it and can see they are reparented objects and that the root
> groups counters are zero (or negative if I run madvise06 multiple times)
> before a drain takes place. I'm guessing this is because the root group
> has 'use_hierachy' set to false so that the childs page_counter parents
> are set to NULL. However I will check, because I'm not sure about
> either.

Yes, it appears that use_hierarchy=0 which is probably because the test
mounts cgroup v1, creates a child group within that and does not set
use_hierarchy on the root. On v2 root always has use_hierarchy enabled.

>
>>
>> (But the patch seems justifiable to me as objects (not)charged directly to
>> root memcg may be incorrectly uncharged.)
>>
>> Thanks,
>> Michal

I'm don't know if that could happen without reparenting. I suppose if
use_hierarchy=1 then actually this patch will result in root being
overcharged, so perhaps it should also check for use_hierarchy?

-- 
Thank you,
Richard.
