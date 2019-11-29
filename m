From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 29 Nov 2019 10:55:17 +0100
Subject: [LTP] [PATCH] mtest01: correct the ALLOC_THRESHOLD definition
 on s390x
In-Reply-To: <20191128045525.15454-1-liwang@redhat.com>
References: <20191128045525.15454-1-liwang@redhat.com>
Message-ID: <20191129095517.GA30496@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> mtest01 hits a problem on s390x platform. The situation is that if children's
> memory allocating is ongoing and the test remaining time is in an emergency, the
> parent will break from the while loop and try to revoke children, obviously, it
> doesn't have enough time to wait for the children's status change to 'T'. Then it
> occurs timeout issue as below:

>   mtest01.c:134: INFO: Filling up 80% of free ram which is 5868864 kbytes
>   mtest01.c:149: INFO: ... child 38289 starting
>   mtest01.c:149: INFO: ... child 38288 starting
>   mtest01.c:208: WARN: the remaininig time is not enough for testing
>   mtest01.c:218: FAIL: kbytes allocated (and written to) less than expected 5868864
>   Test timeouted, sending SIGKILL!

> The immediate cause is the memory allocating is too slow to finish fleetly on such
> a small virtual s390x machine, because ALLOC_THRESHOLD does not take real effort.
> Here let's correct the allocating threshold definition to make sure each child
> allocates less memory.

> And, another fix for the fail handling. In case children are still on memory
> allocating, the remaining 15 seconds is not enough to wait for process status
> change. We kill them directly to avoid test timeout occurring.

> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Rachel Sibley <rasibley@redhat.com>

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
