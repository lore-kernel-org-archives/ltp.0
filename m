From: Jan Stancek <jstancek@redhat.com>
Date: Sat, 16 Nov 2019 12:22:57 -0500 (EST)
Subject: [LTP] [PATCH 1/1] fanotify: Fix for musl
In-Reply-To: <20191116002003.13013-1-petr.vorel@gmail.com>
References: <20191116002003.13013-1-petr.vorel@gmail.com>
Message-ID: <977310824.12699736.1573924977430.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> FSID_VAL_MEMBER() wrapper was meant to be only for struct
> fanotify_event_info_fid, it was used also for struct event_t
> (which has also __kernel_fsid_t fsid, but shouldn't be redefined).
> 
> This caused error on recent musl v1.1.23 (with f67b3c17),
> which has struct fanotify_event_info_fid.
> 
> Fixes: 0498fc0a8 ("fanotify: Detect val vs. __val
> fanotify_event_info_fid.fsid member")
> 
> Signed-off-by: Petr Vorel <petr.vorel@gmail.com>

If it's needed for __kernel_fsid_t we'll need to come up with better names.
This basically reverts part of previous patch, which looks ok to me.

Acked-by: Jan Stancek <jstancek@redhat.com>

