From: Trond Myklebust <trondmy@hammerspace.com>
Date: Mon, 26 Aug 2019 15:58:06 +0000
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
In-Reply-To: <203971593.8175020.1566830285708.JavaMail.zimbra@redhat.com>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
 <20190826104127.GA14729@haruka>
 <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
 <CA+G9fYsHpNKFHr=ZukVvj+uMJDyHj2Xwb9bCfzPQyYzMjZ0rCw@mail.gmail.com>
 <203971593.8175020.1566830285708.JavaMail.zimbra@redhat.com>
Message-ID: <fcd20866bb836d45b1e384dd68080c671bcde938.camel@hammerspace.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-08-26 at 10:38 -0400, Jan Stancek wrote:
> ----- Original Message -----
> > Hi Jan and Cyril,
> > 
> > On Mon, 26 Aug 2019 at 16:35, Jan Stancek <jstancek@redhat.com>
> > wrote:
> > > 
> > > 
> > > ----- Original Message -----
> > > > Hi!
> > > > > Do you see this LTP prot_hsymlinks failure on linux next
> > > > > 20190823 on
> > > > > x86_64 and i386 devices?
> > > > > 
> > > > > test output log,
> > > > > useradd: failure while writing changes to /etc/passwd
> > > > > useradd: /home/hsym was created, but could not be removed
> > > > 
> > > > This looks like an unrelated problem, failure to write to
> > > > /etc/passwd
> > > > probably means that filesystem is full or some problem happend
> > > > and how
> > > > is remounted RO.
> > > 
> > > In Naresh' example, root is on NFS:
> > >   root=/dev/nfs rw
> > >  
> > > nfsroot=10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-
> > > nfsrootfs-tyuevoxm,tcp,hard,intr
> > 
> > Right !
> > root is mounted on NFS.
> > 
> > > 10.66.16.123:/var/lib/lava/dispatcher/tmp/886412/extract-
> > > nfsrootfs-tyuevoxm
> > > on / type nfs
> > > (rw,relatime,vers=2,rsize=4096,wsize=4096,namlen=255,hard,nolock,
> > > proto=tcp,timeo=600,retrans=2,sec=sys,mountaddr=10.66.16.123,moun
> > > tvers=1,mountproto=tcp,local_lock=all,addr=10.66.16.123)
> > > devtmpfs on /dev type devtmpfs
> > > (rw,relatime,size=3977640k,nr_inodes=994410,mode=755)
> > > 

The only thing I can think of that might cause an EIO on NFSv2 would be
this patch 
http://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=627d48e597ec5993c4abb3b81dc75e554a07c7c0
assuming that a bind-related error is leaking through.

I'd suggest something like the following to fix it up:

8<---------------------------------------
From 1e9336ac5363914dfcc1f49bf091409edbf36f8d Mon Sep 17 00:00:00 2001
From: Trond Myklebust <trond.myklebust@hammerspace.com>
Date: Mon, 26 Aug 2019 11:44:04 -0400
Subject: [PATCH] fixup! SUNRPC: Don't handle errors if the bind/connect
 succeeded

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 net/sunrpc/clnt.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index f13ec73c8299..a07b516e503a 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -1980,9 +1980,11 @@ call_bind_status(struct rpc_task *task)
 
 	dprint_status(task);
 	trace_rpc_bind_status(task);
-	if (task->tk_status >= 0 || xprt_bound(xprt)) {
-		task->tk_action = call_connect;
-		return;
+	if (task->tk_status >= 0)
+		goto out_next;
+	if (xprt_bound(xprt)) {
+		task->tk_status = 0;
+		goto out_next;
 	}
 
 	switch (task->tk_status) {
@@ -2045,6 +2047,9 @@ call_bind_status(struct rpc_task *task)
 
 	rpc_call_rpcerror(task, status);
 	return;
+out_next:
+	task->tk_action = call_connect;
+	return;
 retry_timeout:
 	task->tk_status = 0;
 	task->tk_action = call_bind;
@@ -2107,8 +2112,10 @@ call_connect_status(struct rpc_task *task)
 		clnt->cl_stats->netreconn++;
 		goto out_next;
 	}
-	if (xprt_connected(xprt))
+	if (xprt_connected(xprt)) {
+		task->tk_status = 0;
 		goto out_next;
+	}
 
 	task->tk_status = 0;
 	switch (status) {
-- 
2.21.0



-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


