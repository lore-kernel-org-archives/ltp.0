From: Vlastimil Babka <vbabka@suse.cz>
Date: Thu, 10 May 2018 20:17:55 +0200
Subject: [LTP] [PATCH -next 0/2] ipc/shm: shmat() fixes around nil-page
In-Reply-To: <20180503203243.15045-1-dave@stgolabs.net>
References: <20180503203243.15045-1-dave@stgolabs.net>
Message-ID: <8addf0c1-26cd-add9-fb9c-292cc3567014@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 05/03/2018 10:32 PM, Davidlohr Bueso wrote:
> Hi,
> 
> These patches fix two issues reported[1] a while back by Joe and Andrea
> around how shmat(2) behaves with nil-page.
> 
> The first reverts a commit that it was incorrectly thought that mapping
> nil-page (address=0) was a no no with MAP_FIXED. This is not the case,
> with the exception of SHM_REMAP; which is address in the second patch.

Can you add appropriate Fixes: tags if possible? I guess patch 1 is
clear, dunno about patch 2...

> I chose two patches because it is easier to backport and it explicitly
> reverts bogus behaviour. Both patches ought to be in -stable and ltp
> testcases need updated (the added testcase around the cve can be modified
> to just test for SHM_RND|SHM_REMAP).

CC'd ltp so they know :)

Thanks,
Vlastimil

> 
> [1] lkml.kernel.org/r/20180430172152.nfa564pvgpk3ut7p@linux-n805
> 
> Thanks! 
> 
> Davidlohr Bueso (2):
>   Revert "ipc/shm: Fix shmat mmap nil-page protection"
>   ipc/shm: fix shmat() nil address after round-down when remapping
> 
>  ipc/shm.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 

