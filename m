From: Li Wang <liwang@redhat.com>
Date: Mon, 2 Dec 2019 11:57:15 +0800
Subject: [LTP] [PATCH] Unshare KSM pages before setting max_page_sharing
In-Reply-To: <20191202032936.GA32335@dell5510>
References: <20191128163147.4377-1-mdoucha@suse.cz>
 <20191202032936.GA32335@dell5510>
Message-ID: <CAEemH2d03WLKxJNap2fzMPhEoVQH3EkEQGgwTVCOZxuf+-fOZA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Dec 2, 2019 at 11:29 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Martin,
>
> > Setting max_page_sharing is possible only when there are no KSM shared
> pages
> > in the system. Otherwise writing to max_page_sharing SysFS file will fail
> > with EBUSY.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>

Pushed.

>
> Good catch!
>
> BTW at least ksm01 will fail on VM host with running VMs,
> but that's another story not related to this patch.
>

AFAIK, KSM is mainly designed for VMs pages merging. It seems the LTP ksm
test can't run in parallel too, they are suggested to be the only test
without any other ksm-test running in the background. Because ksmd does not
distinguish which process the pages belong to, it just does merging and
counting work in total for the whole system.

If we run ./ksm01 & ./ksm01, it will also fail like below I think.


>
> mem.c:251: FAIL: pages_shared is not 1 but 3629.
> mem.c:251: FAIL: pages_sharing is not 98302 but 113789.
> mem.c:251: FAIL: pages_volatile is not 0 but 12.
> mem.c:251: FAIL: pages_unshared is not 1 but 48519.
>


-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191202/8c711629/attachment.htm>
