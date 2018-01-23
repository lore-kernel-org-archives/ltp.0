From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 23 Jan 2018 09:43:55 +0100
Subject: [LTP] [PATCH] fanotify: the mount fs_type should be given
In-Reply-To: <1498353661.3061593.1516696708906.JavaMail.zimbra@redhat.com>
References: <20180123082314.15902-1-liwang@redhat.com>
 <1498353661.3061593.1516696708906.JavaMail.zimbra@redhat.com>
Message-ID: <20180123084355.GA28385@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This commmit 28507e514c(safe_mount: Do not try mount() syscall for FUSE fs)
> > involves FUSE fs check in safe_mount(), so we should give the "fs_type" when
> > calling that in case the system kill our program.
> 
> Shouldn't we rather change is_fuse() to return 0 if fs_type is NULL?

Agreed.

-- 
Cyril Hrubis
chrubis@suse.cz
