From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 8 Jun 2020 13:41:02 +0200
Subject: [LTP] [PATCH v2] LIB: Use INTERNAL_LIB for ltp lib
In-Reply-To: <9e9b223b-833b-0023-cfc7-7fbe22cb9b45@cn.fujitsu.com>
References: <1591083478-5342-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200608101032.GA9222@dell5510>
 <9e9b223b-833b-0023-cfc7-7fbe22cb9b45@cn.fujitsu.com>
Message-ID: <20200608114102.GB23175@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > Cyril concerned 3rd party use of lib/libltp.a, but nobody complained.
> > Given Jan acked v1, I'd be also for merge.

>  We also should include android_libpthread and android_librt Makefile.
Not sure what you mean. You did the change in android_libpthread and
android_librt Makefile (this is v2 thread), thus I consider this patch ready.
Or am I missing something?

Kind regards,
Petr
