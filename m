From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Sep 2020 20:37:00 +0200
Subject: [LTP] [PATCH 1/1] syscalls/fanotify15: TCONF also on EOPNOTSUPP
In-Reply-To: <CAOQ4uxgVkz3Xatg43Py4md7LKEUoJKbb4H-Z5y1PyzPdZbx-Rw@mail.gmail.com>
References: <20200910110712.2181-1-pvorel@suse.cz>
 <CAOQ4uxgVkz3Xatg43Py4md7LKEUoJKbb4H-Z5y1PyzPdZbx-Rw@mail.gmail.com>
Message-ID: <20200910183700.GA471436@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

> > I suppose that EXDEV (in fanotify_test_fid()) is really error which
> > should be caught as TBROK (unlike ENODEV and EOPNOTSUPP). Am I correct?

> No. EXDEV is also an indication of problematic filesystem.
> You will get it if you try to setup the mark on a btrfs subvolume, which is not
> the root volume, because in that case the "fsid" information from event is
> not reliable.

> Probably this is not going to happen in LTP, but still.
Right, I'll add also check for EXDEV and merge with your Reviewed-by tag.
Thanks for your review!

> Good spotting.

> Thanks,
> Amir.

Kind regards,
Petr
