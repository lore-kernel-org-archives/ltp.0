From: Li Wang <liwang@redhat.com>
Date: Tue, 8 Sep 2020 13:10:48 +0800
Subject: [LTP] [PATCH V2 1/3] syscalls: select: Merge few tests and
 migrate to new format
In-Reply-To: <fa29d6d05e385170a74a06fbe752fbaac3965358.1599469171.git.viresh.kumar@linaro.org>
References: <fa29d6d05e385170a74a06fbe752fbaac3965358.1599469171.git.viresh.kumar@linaro.org>
Message-ID: <CAEemH2cfwkYPR-BKRnDBwKMFcz9DzEvZCzMkcE9uuGfcKUhyww@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Viresh Kumar <viresh.kumar@linaro.org> wrote:


> + * 1.) select(2) to fd of regular file with no I/O and small timeout
> + * 2.) select(2) to fd of system pipe with no I/O and small timeout
> + * 2.) select(2) of fd of a named-pipe (FIFO) with no I/O and small
> timeout value
>

"3.) select(2) to..."  ^  someone who merges this can help fix the typo.

For the series:
Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200908/db4922b8/attachment.htm>
