From: Trond Myklebust <trondmy@hammerspace.com>
Date: Tue, 27 Aug 2019 00:59:48 +0000
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
In-Reply-To: <2039173876.8300255.1566861172742.JavaMail.zimbra@redhat.com>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
 <20190826104127.GA14729@haruka>
 <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
 <CA+G9fYsHpNKFHr=ZukVvj+uMJDyHj2Xwb9bCfzPQyYzMjZ0rCw@mail.gmail.com>
 <203971593.8175020.1566830285708.JavaMail.zimbra@redhat.com>
 <fcd20866bb836d45b1e384dd68080c671bcde938.camel@hammerspace.com>
 <2039173876.8300255.1566861172742.JavaMail.zimbra@redhat.com>
Message-ID: <566e862d9bfaf88cdde6d66f0f59033fe6225a22.camel@hammerspace.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-08-26 at 19:12 -0400, Jan Stancek wrote:
> ----- Original Message -----
> > On Mon, 2019-08-26 at 10:38 -0400, Jan Stancek wrote:
> > > ----- Original Message -----
> > > > Hi Jan and Cyril,
> > > > 
> > > > On Mon, 26 Aug 2019 at 16:35, Jan Stancek <jstancek@redhat.com>
> > > > wrote:
> > > > > 
> > > > > ----- Original Message -----
> > > > > > Hi!
> > > > > > > Do you see this LTP prot_hsymlinks failure on linux next
> > > > > > > 20190823 on
> > > > > > > x86_64 and i386 devices?
> > > > > > > 
> > > > > > > test output log,
> > > > > > > useradd: failure while writing changes to /etc/passwd
> > > > > > > useradd: /home/hsym was created, but could not be removed
> > > > > > 
> > > > > > This looks like an unrelated problem, failure to write to
> > > > > > /etc/passwd
> > > > > > probably means that filesystem is full or some problem
> > > > > > happend
> > > > > > and how
> > > > > > is remounted RO.
> > > > > 
> > > > > In Naresh' example, root is on NFS:
> > > > >   root=/dev/nfs rw
> > > > >  
> > > > > nfsroot=10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extr
> > > > > act-
> > > > > nfsrootfs-tyuevoxm,tcp,hard,intr
> > > > 
> > > > Right !
> > > > root is mounted on NFS.
> > > > 
> > > > > 10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-
> > > > > nfsrootfs-tyuevoxm
> > > > > on / type nfs
> > > > > (rw,relatime,vers=2,rsize=4096,wsize=4096,namlen=255,hard,nol
> > > > > ock,
> > > > > proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.66.16.123,
> > > > > moun
> > > > > tvers=1,mountproto=tcp,local_lock=all,addr=10.66.16.123)
> > > > > devtmpfs on /dev type devtmpfs
> > > > > (rw,relatime,size=3977640k,nr_inodes=994410,mode=755)
> > > > > 
> > 
> > The only thing I can think of that might cause an EIO on NFSv2
> > would be
> > this patch
> > http://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=627d48e597ec5993c4abb3b81dc75e554a07c7c0
> > assuming that a bind-related error is leaking through.
> > 
> > I'd suggest something like the following to fix it up:
> 
> No change with that patch,
> but following one fixes it for me:
> 
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 20b3717cd7ca..56cefa0ab804 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -590,7 +590,7 @@ static void nfs_pgio_rpcsetup(struct
> nfs_pgio_header *hdr,
>         }
>  
>         hdr->res.fattr   = &hdr->fattr;
> -       hdr->res.count   = 0;
> +       hdr->res.count   = count;
>         hdr->res.eof     = 0;
>         hdr->res.verf    = &hdr->verf;
>         nfs_fattr_init(&hdr->fattr);
> 
> which is functionally revert of "NFS: Fix initialisation of I/O
> result struct in nfs_pgio_rpcsetup".
> 
> This hunk caught my eye, could res.eof == 0 explain those I/O errors?

Interesting hypothesis. It could if res.count ends up being 0. So does
the following also fix the problem?
8<----------------------------------------
From b5bc0812350e94f8c9331174d22f24692411aef9 Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Mon, 26 Aug 2019 20:41:16 -0400
Subject: [PATCH] NFSv2: Fix eof handling

If we received a reply from the server with a zero length read and
no error, then that implies we are at eof.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/nfs/proc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nfs/proc.c b/fs/nfs/proc.c
index 5552fa8b6e12..5919878549d2 100644
--- a/fs/nfs/proc.c
+++ b/fs/nfs/proc.c
@@ -594,7 +594,8 @@ static int nfs_read_done(struct rpc_task *task, struct nfs_pgio_header *hdr)
 		/* Emulate the eof flag, which isn't normally needed in NFSv2
 		 * as it is guaranteed to always return the file attributes
 		 */
-		if (hdr->args.offset + hdr->res.count >= hdr->res.fattr->size)
+		if (hdr->res.count == 0 && hdr->args.count > 0 ||
+		    hdr->args.offset + hdr->res.count >= hdr->res.fattr->size)
 			hdr->res.eof = 1;
 	}
 	return 0;
-- 
2.21.0

-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


