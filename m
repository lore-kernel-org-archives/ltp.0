From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 4 Oct 2019 12:50:40 +0200
Subject: [LTP] [PATCH v2] lsmod01: Add kernel module
In-Reply-To: <635c345d-18f8-6f2e-e658-648251d32e65@jv-coder.de>
References: <20190927092024.97928-1-lkml@jv-coder.de>
 <20191004103414.GE1231@rei>
 <635c345d-18f8-6f2e-e658-648251d32e65@jv-coder.de>
Message-ID: <20191004105040.GF1231@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > If you define the cleanup in TST_CLEANUP the library will call it for
> > you, do not call it yourself here.
> 
> No, if no TST_SETUP is defined, the library will not call it.
> See tst_test.sh:31:
> if[ -n "$TST_SETUP_STARTED" -a -n "$TST_CLEANUP" -a \
>  ?????? ???????? -z "$TST_NO_CLEANUP" ]; then
>  ?????? $TST_CLEANUP
> fi

That sounds like a bug in the test library, I will have a look at it
later on.

-- 
Cyril Hrubis
chrubis@suse.cz
