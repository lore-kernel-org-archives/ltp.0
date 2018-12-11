From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 11 Dec 2018 11:27:04 +0100
Subject: [LTP] [PATCH v5] fzsync: Add delay bias for difficult races
In-Reply-To: <20181203105323.11768-1-rpalethorpe@suse.com>
References: <20181203105323.11768-1-rpalethorpe@suse.com>
Message-ID: <87h8fkmk93.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Richard Palethorpe <rpalethorpe@suse.com> writes:

> The ordering of some operations is significant and we need to force a
> particular order without creating a large time gap between them. It is
> difficult to do this without knowledge of the operations being run so this
> just gives the test writer the ability to directly modify the delay value.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Cyril Hrubis <chrubis@suse.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> ---
>
> The other patches in this series have already been committed, but I have
> continued using the patch version numbers.
>
> V5: Remove the stats' init function and associated documentation as it is now
> only used in a single location. Also rebase on master.
>
> There is another fzsync patch in flight from Jan (limit sampling time) which
> maybe should be committed first.

I Rebased and tested on Jan's patch, no changes are required to this
patch AFAICT.

>
>  include/tst_fuzzy_sync.h      | 71 ++++++++++++++++++++++++++---------
>  testcases/cve/cve-2016-7117.c |  3 ++
>  2 files changed, 57 insertions(+), 17 deletions(-)

-- 
Thank you,
Richard.
