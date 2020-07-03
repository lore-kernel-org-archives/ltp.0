From: Li Wang <liwang@redhat.com>
Date: Fri, 3 Jul 2020 11:00:18 +0800
Subject: [LTP] [PATCH 1/1] numa01.sh: Handle computation error
In-Reply-To: <20200701233133.122801-1-petr.vorel@gmail.com>
References: <20200701233133.122801-1-petr.vorel@gmail.com>
Message-ID: <CAEemH2cHWqRQ+bkUCof8mrK7jfy-DsuA9wegmOT8D-h8F1Cu2g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr, Harish,

Though the root cause is from the non-ordered node in a special machine, I
still think this patch makes sense to numa01, because the function
get_mem_cur() make code more readable.

So I'm going to merge both this one and Harish's patch, after doing that, I
will also follow Cyril's comment to remove test8(migrate_pages).

Any objections? or comments?

On Thu, Jul 2, 2020 at 7:31 AM Petr Vorel <petr.vorel@gmail.com> wrote:

> ...
> +get_mem_cur()
>  {
>         local pid=$1
>         local node=$(($2 + 2))
> +       local size=$3
> +       local numstat=$(numastat -p $pid |awk '/^Total/ {print $'$node'}')
>
> -       echo $(numastat -p $pid |awk '/^Total/ {print $'$node'}')
> +       if [ -z "$numstat" ]; then
> +               echo 0
> +               return
>

Maybe we'd better do TBROK from here if numstat doesn't work well?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200703/6552fbff/attachment.htm>
