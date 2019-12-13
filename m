From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 13 Dec 2019 13:31:09 +0100
Subject: [LTP] [PATCH 1/1] tst_test.sh: Fix check for non-mounted device
In-Reply-To: <20191213122256.GA20795@rei.lan>
References: <20191209161918.2411991-1-pvorel@suse.cz>
 <20191213122256.GA20795@rei.lan>
Message-ID: <20191213123109.GB13630@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> Hi!
> > 1) unset TST_DEVICE if acquiring failed
> > 2) do not try to umount the device in this case

> Looks good, acked.
Thanks for your review, merged.

Kind regards,
Petr
