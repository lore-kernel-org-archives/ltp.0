From: qi.fuli@fujitsu.com <qi.fuli@fujitsu.com>
Date: Fri, 17 Sep 2021 04:29:34 +0000
Subject: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
In-Reply-To: <614409AA.6080809@fujitsu.com>
References: <20210916104933.33409-1-qi.fuli@fujitsu.com>
 <20210916104933.33409-6-qi.fuli@fujitsu.com> <614409AA.6080809@fujitsu.com>
Message-ID: <OSZPR01MB6454365236CCEC704143CB55F7DD9@OSZPR01MB6454.jpnprd01.prod.outlook.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

> Subject: Re: [LTP] [PATCH v3 5/5] syscalls/dup2: rename dup205 to dup204
> 
> Hi Qi
> 
> > From: QI Fuli<qi.fuli@fujitsu.com>
> >
> > Signed-off-by: QI Fuli<qi.fuli@fujitsu.com>
> > ---
> >   testcases/kernel/syscalls/dup2/{dup205.c =>  dup204.c} | 0
> >   1 file changed, 0 insertions(+), 0 deletions(-)
> >   rename testcases/kernel/syscalls/dup2/{dup205.c =>  dup204.c} (100%)
> You miss .gitnore and runtest/syscalls. We also need to remove dup205 tag in
> them.
> 
> No need v4. Maintainer Will remove them when merging this patchset.
> 
> Other than some nits(useless comments, empty line, whitespace), this patchset
> looks good to me.
> 
> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> 
> Best Regards
> Yang Xu
> 

Thank you very much.

Best,
QI

> >
> > diff --git a/testcases/kernel/syscalls/dup2/dup205.c
> > b/testcases/kernel/syscalls/dup2/dup204.c
> > similarity index 100%
> > rename from testcases/kernel/syscalls/dup2/dup205.c
> > rename to testcases/kernel/syscalls/dup2/dup204.c
