From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Sep 2021 10:14:31 +0200
Subject: [LTP] [PATCH] lib: tst_virt: Add option to override virt
 detection
In-Reply-To: <CAEemH2cfT85O5HFPwG1d1Fso+JQBPi2h+cNFKRxhgsmW2j8f4w@mail.gmail.com>
References: <20210914150220.2467-1-chrubis@suse.cz>
 <CAEemH2cfT85O5HFPwG1d1Fso+JQBPi2h+cNFKRxhgsmW2j8f4w@mail.gmail.com>
Message-ID: <YUGrZ/My4DHyUAT5@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > There seems to be cases where systemd-detect-virt does not detect
> > virtualization correctly. To work around this bugs this commit adds a
> > a support for LTP_VIRT_OVERRIDE environment variable that if set is used
> > instead of the output from the systemd-detect-virt command.
> >
> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> >
> 
> Reviewed-by: Li Wang <liwang@redhat.com>

I've added a description for the variable into doc/user-guide.txt and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
