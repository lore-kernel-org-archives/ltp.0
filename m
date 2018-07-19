From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 19 Jul 2018 14:58:50 +0200
Subject: [LTP] [PATCH v2] Testing statx syscall
In-Reply-To: <5b980260fcaeb195f7228851a197d7fa.squirrel@pike.zilogic.com>
References: <20180716134147.25232-1-tarun@zilogic.com>
 <20180718122252.GA7117@rei>
 <1331af4eba3f2858595365072179e60d.squirrel@pike.zilogic.com>
 <20180719091700.GA1646@rei>
 <5b980260fcaeb195f7228851a197d7fa.squirrel@pike.zilogic.com>
Message-ID: <20180719125850.GA21609@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >> Also, since only ext4 supports these attribute flags for now, we have
> >> used
> >> that alone in our test case.
> >
> > Okay then, if it's supported only by ext4 then we should go with that
> > for now, but we should make sure that mkfs.ext4 is present and that the
> > kernel supports ext4. We do have a functions for that in the C test
> > library.
> >
> >> Also we have used script because we don't have any equivalent for
> >> tune2fs
> >> and e4crypt.
> >
> > Looking closer, the tune2fs writes some bytes to the device, indeed that
> > is something we do not want to replicate in our tests. But we can call
> > the binary easily from the C test as well.
> >
> We are unable to understand this part, Can you help us with this please??

I was just trying to say that we can execute tune2fs from the C
testacase as well. Have a look at how we use tst_run_cmd() in the
syscalls/quotactl/quotactl01.c.

-- 
Cyril Hrubis
chrubis@suse.cz
