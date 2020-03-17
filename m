From: Li Wang <liwang@redhat.com>
Date: Tue, 17 Mar 2020 16:21:21 +0800
Subject: [LTP] [PATCH] open_posix_testsuite: Fix compilation issues
In-Reply-To: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
References: <1584430031-47227-1-git-send-email-zou_wei@huawei.com>
Message-ID: <CAEemH2fjmP=FxH0zfnBrXX=uE4VQDTbmnso5fpNs+qBWOuKRqw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 17, 2020 at 3:21 PM Zou Wei <zou_wei@huawei.com> wrote:

> Fix compilation issues:
> 1. Add the '-lpthread -lrt -lm' config into LDFLAGS
> 2. Update makefile and locate-test script
>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
>
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200317/4027ca28/attachment.htm>
