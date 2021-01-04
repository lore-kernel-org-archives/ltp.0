From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 04 Jan 2021 09:24:41 +0000
Subject: [LTP] [RFC PATCH 2/5] CGroup API rewrite
In-Reply-To: <CAEemH2ddomP4XO=61vNx5=3vQYNj4WOurUX2zcuC-46RxhMk0g@mail.gmail.com>
References: <20201216100121.16683-1-rpalethorpe@suse.com>
 <20201216100121.16683-3-rpalethorpe@suse.com>
 <CAEemH2ddomP4XO=61vNx5=3vQYNj4WOurUX2zcuC-46RxhMk0g@mail.gmail.com>
Message-ID: <87eej1dpgm.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Li,

Li Wang <liwang@redhat.com> writes:

>>
>
> As I was mentioned in 0/5 that maybe we should create test_cgroup_dir
> for different progress so that the test could use the same controller with
> various configurations in parallel.
>
> e.g. child_1 set SIZE to memory.limit_in_bytes
>        child_2 set SIZE/2 to memory.limit_in_bytes
>
> Any possibility to move this to tst_cgroup_move_current?

Yes I suppose we can try this. Is there a test which already requires it?

-- 
Thank you,
Richard.
