From: Li Wang <liwang@redhat.com>
Date: Wed, 18 Nov 2020 09:51:01 +0800
Subject: [LTP] [PATCH v2] madvise06: Allow for kmem and memsw counters
 being disabled
In-Reply-To: <20201117101717.30478-1-rpalethorpe@suse.com>
References: <20201116105209.20395-1-rpalethorpe@suse.com>
 <20201117101717.30478-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2c-4bh+Uh29GhG-2EtzpDV=T8v0M5CsWWvT-k=8G0N=3g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 17, 2020 at 6:17 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> These may be missing in which case we can not read them for diagnostic
> info or set the swap limit to a value which is known to be large
> enough. However if there is no swap counter then there is no swap
> limit, so we just try to set the limit if the counter exists.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
> Reviewed-by: Li Wang <liwang@redhat.com>
> ---
>
> V2: Check if the memsw limit exists before writing to it. This
>     replaces another patch which removed it altogether.
>

Merged, thanks.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201118/786c43a7/attachment-0001.htm>
