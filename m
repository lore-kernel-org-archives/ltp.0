From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 26 Mar 2018 18:47:48 +0200
Subject: [LTP] [PATCH] lib/tst_test.c: log testing fstyp when iterating
 all_filesystems
In-Reply-To: <1521852471-3052-1-git-send-email-xzhou@redhat.com>
References: <1521852471-3052-1-git-send-email-xzhou@redhat.com>
Message-ID: <20180326164748.GC22676@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It's more clear that which test is going on and saving debug time
> if anything goes wrong.

We kind of print this information, since tst_mkfs prints which FS we are
formatting the device with, but I guess that if we crash before that we
will never see it...

I've reworded the patch description a bit and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
