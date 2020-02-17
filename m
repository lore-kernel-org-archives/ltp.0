From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 17 Feb 2020 15:13:06 +0100
Subject: [LTP] [PATCH v7 4/4] syscalls/fsmount01: Add test for fsmount
 series API
In-Reply-To: <20200217135205.GA25504@rei>
References: <20200217084622.11199-1-pvorel@suse.cz>
 <20200217084622.11199-5-pvorel@suse.cz>
 <20200217135205.GA25504@rei>
Message-ID: <20200217141306.GB32465@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > +	if (ismount(MNTPOINT)) {
> > +		tst_res(TPASS, "new mount API works");
Also I'll change this to "device mounted".

> > +		SAFE_UMOUNT(MNTPOINT);
> > +		is_mounted = 0;
> > +	} else
> > +		tst_res(TFAIL, "new mount API works");
>                                   ^
> 				"device not mounted" ?

Kind regards,
Petr
