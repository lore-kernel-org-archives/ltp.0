From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Nov 2020 20:25:40 +0100
Subject: [LTP] [PATCH 2/2] loop: Fix occasional uevent drop
In-Reply-To: <20201112165005.4022502-3-hch@lst.de>
References: <20201112165005.4022502-1-hch@lst.de>
 <20201112165005.4022502-3-hch@lst.de>
Message-ID: <20201112192540.GB14767@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christoph,

> From: Petr Vorel <pvorel@suse.cz>
Thanks for rebasing my code. Using loop.c specific code in the file instead of
the function is indeed much better.

I also like your cleanup for 5.11 (remove the update_bdev parameter from
set_capacity_revalidate_and_notify).

> Commit 716ad0986cbd ("loop: Switch to set_capacity_revalidate_and_notify")
> causes an occasional drop of loop device uevent, which are no longer
> triggered in loop_set_size() but in a different part of code.

> Bug is reproducible with LTP test uevent01 [1]:

> i=0; while true; do
>     i=$((i+1)); echo "== $i =="
>     lsmod |grep -q loop && rmmod -f loop
>     ./uevent01 || break
> done

> Put back triggering through code called in loop_set_size().

> Fix required to add yet another parameter to
> set_capacity_revalidate_and_notify().
This ^ is no longer true and should be removed.

Kind regards,
Petr
