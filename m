From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Mar 2021 13:59:12 +0800
Subject: [LTP] [PATCH] syscalls/swapoff/swapoff01: remove the check for
 BTRFS
In-Reply-To: <20210320161933.2088737-1-qi.fuli@fujitsu.com>
References: <20210320161933.2088737-1-qi.fuli@fujitsu.com>
Message-ID: <CAEemH2c0B0hWmXaZZEqVy4ZK7zgCM7OHYF139sb33Hv1AsWfdA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Sun, Mar 21, 2021 at 12:20 AM QI Fuli <fukuri.sai@gmail.com> wrote:

> From: QI Fuli <qi.fuli@fujitsu.com>
>
> remove the redundant task as BTRFS is checked in is_swap_supported()
> Fixes: eadffb391("syscalls/swapoff/swapoff0{1,2}: use helpers to check
>         support status")
>

Thanks for the cleanup, pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210322/f5a83514/attachment.htm>
