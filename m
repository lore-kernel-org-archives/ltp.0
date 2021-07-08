From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Jul 2021 16:27:16 +0800
Subject: [LTP] [PATCH] shmget03: fix test when some shm segments already
 exist
In-Reply-To: <60E661ED.7000305@fujitsu.com>
References: <20210706105758.43220-1-aleksei.kodanev@bell-sw.com>
 <CAEemH2cOm+1BMWE7oWVFttXNOeQsYk9veXePS+ctxAABk2rCWQ@mail.gmail.com>
 <c2c7ff46-df28-c7b6-49dd-c891d9655d00@bell-sw.com>
 <381b8420-3dba-d7c1-027c-e2e2adc719de@bell-sw.com>
 <60E50890.9040903@fujitsu.com>
 <CAEemH2fKXJmgKAr4JXW5y+dcgEwL1taobXLY7OdTWBzLXGVOYg@mail.gmail.com>
 <60E52E00.8020105@fujitsu.com> <60E661ED.7000305@fujitsu.com>
Message-ID: <CAEemH2fvp4C4VF8+bNbWbmenJr4Q3duX2va8UqD6y4DMzYbZUw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Jul 8, 2021 at 10:24 AM xuyang2018.jy@fujitsu.com <
xuyang2018.jy@fujitsu.com> wrote:

> Hi Li
>
> How about using CLONE_NEWIPC to test this, so we can avoid this race
> situation.
>

Maybe yes, but that sounds a bit like a new test.

If let me choose from Alex suggestion or this CLONE_NEWIPC,
I think both are OK, because it just an error return check,
not a big deal.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210708/ce66ae30/attachment.htm>
