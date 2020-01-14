From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 14 Jan 2020 10:58:04 +0100
Subject: [LTP] [PATCH v3] syscalls/newmount: new test case for new mount
 API
In-Reply-To: <20200114093633.GD14282@dhcp-12-102.nay.redhat.com>
References: <20191209160227.16125-1-zlang@redhat.com>
 <20191226072338.GH14328@dhcp-12-102.nay.redhat.com>
 <20200113153141.GA14282@dhcp-12-102.nay.redhat.com>
 <20200114081449.GB3468@dell5510>
 <20200114093633.GD14282@dhcp-12-102.nay.redhat.com>
Message-ID: <20200114095804.GA9211@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zorro,

> > > ping again ... is there anything block this patch review?
> > Here are my comments to your v3 review [1]. Some of them are now irrelevant
> > as you're fixed them in v3 (Cyril ones from v1).

> Wow, now I know why I didn't get any response for such long time. The emails
> from you and Cyril were all sent to mail list, not to/cc me. I didn't pay so
> much attention to the mail list. Sorry about that.
OK good :). I'm sorry to forget to Cc you in some of my replies (I usually pay
attention to Cc people). It's also safer to look at ML or patchwork as this
sometimes happen :).

> > So it might be just .dev_fs_flags = TST_FS_SKIP_FUSE and tiny style fixes like
> > is_mounted = 0. I wanted to fix them myself and merge, but didn't find a time.
> > Sending v4 where you fix/implement suggestions generally helps speedup merging
> > (as I already told you) :).

> I'll read your review points, and send a V4 tonight.
Thanks a lot!

Kind regards,
Petr
