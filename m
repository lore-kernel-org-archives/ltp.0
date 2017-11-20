From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 20 Nov 2017 14:19:52 +0100
Subject: [LTP] [PATCH] fs_fill: switch the SAFE MACROs back to
	ordinary	syscall
In-Reply-To: <1515676468.42550872.1511176722601.JavaMail.zimbra@redhat.com>
References: <20171110111519.27872-1-liwang@redhat.com>
 <1515676468.42550872.1511176722601.JavaMail.zimbra@redhat.com>
Message-ID: <20171120131952.GA22113@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> >   safe_macros.c:225: BROK: tst_fill_fs.c:43:
> >   open(mntpoint/thread48/file0,65,0700) failed: ENOSPC
> >   safe_macros.c:169: BROK: fs_fill.c:49: mkdir(mntpoint/thread21,0700)
> >   failed: ENOSPC
> > 
> > Signed-off-by: Li Wang <liwang@redhat.com>
> 
> Pushed.

I do not like that the worker exits prematurely here if the mkdir fails,
that's why I suggested to mkdir() all the directories before we attempt
to run the the worker threads.

But I can always change that in a follow up patch...

-- 
Cyril Hrubis
chrubis@suse.cz
