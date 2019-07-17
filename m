From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 17 Jul 2019 12:54:18 +0200
Subject: [LTP] [PATCH v5 1/3] lib: alter find_free_loopdev()
In-Reply-To: <5D2EF9D1.3020102@cn.fujitsu.com>
References: <20190711125108.GB8709@rei>
 <1563356676-2384-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAOQ4uxiV_weQXVnDn0vFq5exk=Z_F=70Lk1D+783fOV=hsf_6A@mail.gmail.com>
 <5D2EF9D1.3020102@cn.fujitsu.com>
Message-ID: <20190717105418.GB14596@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Another option is to leave this function internal and export a wrapper
> > for the exact needed functionality:
> >
> > /* Just find a free minor number */
> > int tst_find_free_loopdev(void)
> > {
> >          return find_free_loopdev(NULL, 0);
> > }
> >
> > I don't mind wither way.
> Hi Amir
> 
> The second way looks better for me.  But I also want to hear the idea of cyril.

Well I wanted to keep the path exposed to user in a case that there
would be a test that would need more than one device. But it's not like
we cannot change the API later when it's actually needed.

-- 
Cyril Hrubis
chrubis@suse.cz
