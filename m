From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 22 Nov 2017 14:29:09 +0100
Subject: [LTP] [PATCH] fs_fill: switch the SAFE MACROs back to ordinary
 syscall
In-Reply-To: <1410675646.43959033.1511355089017.JavaMail.zimbra@redhat.com>
References: <20171110111519.27872-1-liwang@redhat.com>
 <1515676468.42550872.1511176722601.JavaMail.zimbra@redhat.com>
 <20171120131952.GA22113@rei.lan>
 <CAEemH2ei8WXrpWLN5J_+tb4cZiZGeE1ovd43TnbUtb=seEdf3Q@mail.gmail.com>
 <20171121094445.GA9443@rei.lan>
 <1075630177.43956420.1511354910460.JavaMail.zimbra@redhat.com>
 <1410675646.43959033.1511355089017.JavaMail.zimbra@redhat.com>
Message-ID: <20171122132909.GD2389@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > But perhaps this should go to setup(), otherwise with "-i 2"
> > it hits TBROK on mkdir.
> > 
> > I tried adding RMDIR after join, but unlink doesn't seem to remove
> > everything:
> > safe_macros.c:184: BROK: fs_fill.c:108: rmdir(mntpoint/thread4) failed:
> > ENOTEMPTY
> 
> I see, there's "break" in loop that does unlink. Which is likely by design,
> so we hit ENOSPC sooner.

That was the intention. The initial idea is that many threads race on
writing into nearly full filesystem. I guess I should have written
better description in the top level comment.

-- 
Cyril Hrubis
chrubis@suse.cz
