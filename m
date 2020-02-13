From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 13 Feb 2020 03:35:53 -0500 (EST)
Subject: [LTP] [PATCH] syscalls/kill11: add a check between hard limit
 and MIN_RLIMIT_CORE
In-Reply-To: <71c807c2-b77b-5081-76f8-335aaf1cbe3a@cn.fujitsu.com>
References: <1581486286-13615-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1892366945.7197852.1581514327491.JavaMail.zimbra@redhat.com>
 <71c807c2-b77b-5081-76f8-335aaf1cbe3a@cn.fujitsu.com>
Message-ID: <702486188.7490041.1581582953077.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> > This looks OK, but could we also raise the limit when possible?
> > 
> Of course. Your way is more wise.
> But I also want to change this size of MIN_RLIMIT_CORE.
>  From ulimit manpage, I know in posix mode "-c" used 512-byte block. I
> doubt whether we can change MIN_RLIMIT_CORE(512 *1024), so this case
> can also pass in unbuntu(default environment).
> What do you think about this?

I don't see problem with that, we only check for correct signal.
Though it probably should be separate patch. Can you re-post
both as 2 patch series?

