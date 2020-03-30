From: Li Wang <liwang@redhat.com>
Date: Mon, 30 Mar 2020 19:57:06 +0800
Subject: [LTP] [PATCH 2/6] Use .needs_cmds
In-Reply-To: <20200330114838.GB23915@dell5510>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-3-pvorel@suse.cz>
 <20200330113111.GD9845@yuki.lan> <20200330114838.GB23915@dell5510>
Message-ID: <CAEemH2c6UKHipLfc0XXH-QaAx3pVeuqnR+HoUW6hasN8mLmghw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 30, 2020 at 7:48 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > Hi!
> > Looks good, acked.
> thanks a lot for review.
>
> Merged these two patches.
>

Thanks Petr, there is still a tiny place need fix.
Hope you can help to correct the description in the next round patch
merging.

+       /* NULL terminated array of required binaries */
+       const char *const *needs_cmds;

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200330/1489ca88/attachment.htm>
