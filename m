From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Jul 2016 17:13:28 +0200
Subject: [LTP] [PATCH v2 2/3] lib/cloner.c: Add tst_clone.h for new API
In-Reply-To: <1469002874-18630-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20160719135349.GE6409@rei.lan>
 <1469002874-18630-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1469002874-18630-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20160725151327.GA4052@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Make sure the functions from lib/cloner.c can be used by new API.

I've made use of the tst_clone.h in the test.h as well, since it does
not makes sense to keep two copies of the function prototypes and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
