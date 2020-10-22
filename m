From: Shakeel Butt <shakeelb@google.com>
Date: Thu, 22 Oct 2020 16:59:56 -0700
Subject: [LTP] [PATCH v4] mm: memcg/slab: Stop reparented obj_cgroups
 from charging root
In-Reply-To: <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
References: <87sga6vizp.fsf@suse.de>
 <20201022122858.8638-1-rpalethorpe@suse.com>
 <CALvZod4u79DSwyM=Kg8g5tR1L5eomHgUkaJmp6s9D3jC7OnN0A@mail.gmail.com>
 <20201022172508.GF300658@carbon.dhcp.thefacebook.com>
Message-ID: <CALvZod5p-O72gCY-R+oLcDZjEkPRioz7e7p5Jg=nXxhmtiwKWw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Oct 22, 2020 at 10:25 AM Roman Gushchin <guro@fb.com> wrote:
>
[snip]
> >
> > Since bf4f059954dc ("mm: memcg/slab: obj_cgroup API") is in 5.9, I
> > think we can take this patch for 5.9 and 5.10 but keep Roman's cleanup
> > for 5.11.
> >
> > What does everyone think?
>
> I think we should use the link to the root approach both for stable backports
> and for 5.11+, to keep them in sync. The cleanup (always charging the root cgroup)
> is not directly related to this problem, and we can keep it for 5.11+ only.
>
> Thanks!

Roman, can you send the signed-off patch for the root linking for
use_hierarchy=0?
