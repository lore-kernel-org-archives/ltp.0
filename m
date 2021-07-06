From: Alexey Kodanev <aleksei.kodanev@bell-sw.com>
Date: Tue, 6 Jul 2021 16:43:05 +0300
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
Message-ID: <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,
On 06.07.2021 15:49, Li Wang wrote:
> Hi Alexey,
> 
> On Tue, Jul 6, 2021 at 6:59 PM Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>> wrote:
> 
>     It's unlikely, but still possible that some of them could be
>     created during the test as well, so the patch only checks
>     errno.
> 
> 
> Thanks for fixing this, seems the msgget03 has this problem as well.
> https://github.com/linux-test-project/ltp/issues/842 <https://github.com/linux-test-project/ltp/issues/842>

Yes, it is the same, it can be easily reproduced:

$ ./msgget03
tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
msgget03.c:50: TINFO: The maximum number of message queues (32000) reached
msgget03.c:29: TPASS: msgget(1627491660, 1536) : ENOSPC (28)

$ ipcmk -Q
Message queue id: 32768

$ ./msgget03
tst_test.c:1311: TINFO: Timeout per run is 0h 05m 00s
msgget03.c:46: TBROK: msgget failed unexpectedly: ENOSPC (28)


We can fix it similarly.

> 
> 
>     Signed-off-by: Alexey Kodanev <aleksei.kodanev@bell-sw.com <mailto:aleksei.kodanev@bell-sw.com>>
> 
> ?Reviewed-by: Li Wang <liwang@redhat.com <mailto:liwang@redhat.com>>
> 
> -- 
> Regards,
> Li Wang

