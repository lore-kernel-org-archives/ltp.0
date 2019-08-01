From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 1 Aug 2019 07:38:39 -0400 (EDT)
Subject: [LTP] [PATCH] daemonlib.sh: call tty before executing service
In-Reply-To: <5D42AEE8.2000801@cn.fujitsu.com>
References: <1561110806-2734-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1766730430.29482900.1561112032870.JavaMail.zimbra@redhat.com>
 <5D42AEE8.2000801@cn.fujitsu.com>
Message-ID: <1893379100.3999075.1564659519585.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> 
> > Bug 1711536 - polkit-0.112-22.el7 breaks restarting services from
> > background process
> > https://bugzilla.redhat.com/show_bug.cgi?id=1711536
> >
> > Not sure though we should be adding workarounds for what seems like a bug.
> Hi Jan
> 
> This bug has been sloved on gitlab after commit 75c8b8afaa ("pkttyagent:
> process stopped by SIGTTOU if run in background job") ,as below:
> 
> https://gitlab.freedesktop.org/polkit/polkit/issues/85
> https://gitlab.freedesktop.org/polkit/polkit/commit/75c8b8afaa8e1fba0efb63c3c7b66b5b5f713a35

Thanks for info, good to see there's a fix.

> 
> I think my patch was meaningless.
> 
> Thanks
> Yang Xu
> 
> 
> 
> 
