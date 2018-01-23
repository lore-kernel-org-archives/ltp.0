From: Li Wang <liwang@redhat.com>
Date: Tue, 23 Jan 2018 17:05:42 +0800
Subject: [LTP] [PATCH] fanotify: the mount fs_type should be given
In-Reply-To: <20180123084355.GA28385@rei>
References: <20180123082314.15902-1-liwang@redhat.com>
 <1498353661.3061593.1516696708906.JavaMail.zimbra@redhat.com>
 <20180123084355.GA28385@rei>
Message-ID: <CAEemH2f7+mfge0qPf3FqPiGYvdhbOVgzXHW3FtE1msSJ4CC1mw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, Jan 23, 2018 at 4:43 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > This commmit 28507e514c(safe_mount: Do not try mount() syscall for
> FUSE fs)
> > > involves FUSE fs check in safe_mount(), so we should give the
> "fs_type" when
> > > calling that in case the system kill our program.
> >
> > Shouldn't we rather change is_fuse() to return 0 if fs_type is NULL?
>

​Ok, that sounds better, let me re-write this.

Thanks!​



>
> Agreed.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>



-- 
Li Wang
liwang@redhat.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180123/5196ec7f/attachment.html>
