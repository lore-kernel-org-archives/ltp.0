From: Li Wang <liwang@redhat.com>
Date: Wed, 4 Nov 2020 09:50:28 +0800
Subject: [LTP] [PATCH] madvise06: Add tag for "mm: memcg: link page
 counters to root ..."
In-Reply-To: <20201103154950.32000-1-rpalethorpe@suse.com>
References: <20201103154950.32000-1-rpalethorpe@suse.com>
Message-ID: <CAEemH2c2pm438iDTZZDOAoFBHL_AW0-kUh=qB5e6JhssG0+img@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 3, 2020 at 11:50 PM Richard Palethorpe <rpalethorpe@suse.com>
wrote:

> The test may trigger a warning if bf4f059 is present (5.9) and
> use_hierarchy=0 which is fixed by 8de15e920dc8. Full details of the
> bug are in the kernel commit description and I do not want to repeat
> them in the test description as they are likely to be irrelevant to
> most readers.
>
> Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
>

Pushed.
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201104/c44afaed/attachment.htm>
