From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Apr 2018 16:07:53 +0200
Subject: [LTP] [RFC PATCH v3 10/10] ima: Print /proc/cmdline and IMA
 kernel config
In-Reply-To: <20180425140209.5k4q3ijmktk7xgc4@dell5510>
References: <20180424183556.2368-1-pvorel@suse.cz>
 <20180425074116.hic5a3nfunyxamcd@g206.suse.de>
 <20180425131620.GA27526@x230> <20180425134003.GB24333@rei>
 <20180425140209.5k4q3ijmktk7xgc4@dell5510>
Message-ID: <20180425140753.GD24333@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also depending on the existence of /boot/config-* is really bad idea,
> > just imagine you compiled and kexeced testing kernel and testcases are
> > starting to fail for no good reason.
> Do you NACK this commit? This code is just for debugging (nothing happen if /boot/config-*
> doesn't exist)...

It's okay for additional debugging output, but we should not depend on
it in any way.

-- 
Cyril Hrubis
chrubis@suse.cz
