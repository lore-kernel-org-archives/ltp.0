From: Zorro Lang <zlang@redhat.com>
Date: Tue, 14 Jan 2020 17:36:33 +0800
Subject: [LTP] [PATCH v3] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20200114081449.GB3468@dell5510>
References: <20191209160227.16125-1-zlang@redhat.com>
 <20191226072338.GH14328@dhcp-12-102.nay.redhat.com>
 <20200113153141.GA14282@dhcp-12-102.nay.redhat.com>
 <20200114081449.GB3468@dell5510>
Message-ID: <20200114093633.GD14282@dhcp-12-102.nay.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 14, 2020 at 09:14:49AM +0100, Petr Vorel wrote:
> Hi Zorro,
> 
> > > It's been several weeks passed. Is there more review points?
> 
> > ping again ... is there anything block this patch review?
> Here are my comments to your v3 review [1]. Some of them are now irrelevant
> as you're fixed them in v3 (Cyril ones from v1).

Wow, now I know why I didn't get any response for such long time. The emails
from you and Cyril were all sent to mail list, not to/cc me. I didn't pay so
much attention to the mail list. Sorry about that.

> 
> So it might be just .dev_fs_flags = TST_FS_SKIP_FUSE and tiny style fixes like
> is_mounted = 0. I wanted to fix them myself and merge, but didn't find a time.
> Sending v4 where you fix/implement suggestions generally helps speedup merging
> (as I already told you) :).

I'll read your review points, and send a V4 tonight.

Thanks,
Zorro

> 
> The real question is whether to merge this before release. I'd like it to be in
> the release, but it depends on other maintainers opinion.
> Cyril, Jan, Li? WDYT?
> 
> Kind regards,
> Petr
> 
> [1] https://patchwork.ozlabs.org/patch/1206389/#2333978
> 

