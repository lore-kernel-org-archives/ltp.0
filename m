From: Li Wang <liwang@redhat.com>
Date: Mon, 6 Sep 2021 18:42:45 +0800
Subject: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
In-Reply-To: <YTXviHdUSqTaR1hx@yuki>
References: <20210906060020.3219023-1-liwang@redhat.com>
 <YTXYixG37nBTzhXk@yuki>
 <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
 <YTXviHdUSqTaR1hx@yuki>
Message-ID: <CAEemH2f3CJH7girY25U8idTWtAoM-RC7zCZ6KGQae9OCHrU=sw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Sep 6, 2021 at 6:37 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Theoretically, this is correct, but I'm fearing that the process might
> > cost more time on performing with different system loads.
> >
> > This means 'diff_us <= 2000000' is an unreliable condition to
> > many virtual machines. That largely depends on the system
> > scheduler at that moment as well.
>
> Right, I guess that we can relax the upper bound, it can be even a
> minute and it would still be a good sanity check.
>

Yes, I'd relax it to 30 sec to see how it performs in real scenarios.

Patch v3 is on the way.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210906/e8d728fd/attachment.htm>
