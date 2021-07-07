From: Li Wang <liwang@redhat.com>
Date: Wed, 7 Jul 2021 09:26:12 +0800
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
Message-ID: <CAEemH2fcubrbMpeoeSJJoZtD+xaiRrs_upG_+KQXB_8C9m3eQg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Alexey Kodanev <aleksei.kodanev@bell-sw.com> wrote:


>
> It's also possible that some resources will be freed during
> the tests... perhaps, moving the loop to verify_*() is the
> better option?
>

Yes, good point, that would be more precise for ENOSPC testing.


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210707/89e22f1e/attachment.htm>
