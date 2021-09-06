From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 6 Sep 2021 12:38:00 +0200
Subject: [LTP] [PATCH v2] copy_file_range03: comparing timestamp in
 tst_timespec_diff
In-Reply-To: <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
References: <20210906060020.3219023-1-liwang@redhat.com>
 <YTXYixG37nBTzhXk@yuki>
 <CAEemH2frfyGCsZAsam7CgGfW-BC1ah9YQZz=H=meJMM+zrTnAw@mail.gmail.com>
Message-ID: <YTXviHdUSqTaR1hx@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Theoretically, this is correct, but I'm fearing that the process might
> cost more time on performing with different system loads.
> 
> This means 'diff_us <= 2000000' is an unreliable condition to
> many virtual machines. That largely depends on the system
> scheduler at that moment as well.

Right, I guess that we can relax the upper bound, it can be even a
minute and it would still be a good sanity check.

-- 
Cyril Hrubis
chrubis@suse.cz
