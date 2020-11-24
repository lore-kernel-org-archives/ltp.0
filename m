From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Nov 2020 21:16:24 +0800
Subject: [LTP] [PATCH] syscalls/select03: Fix segfaults on aarch64
In-Reply-To: <20201124120154.27017-1-chrubis@suse.cz>
References: <20201124120154.27017-1-chrubis@suse.cz>
Message-ID: <CAEemH2eKQq_s+RbtVoadRF7Hg_1ddqLUv0HSAG28bKGT54e9Kg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 24, 2020 at 8:00 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> The select() syscall is implemented via pselect6() in aarch64 glibc, which
> means that glibc has to convert the timeout from timeval to timespec hence
> it
> will segfault rather than return EFAULT.
>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Viresh Kumar <viresh.kumar@linaro.org>
>

Acked-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201124/ff0c17c7/attachment.htm>
