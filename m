From: Trond Myklebust <trondmy@hammerspace.com>
Date: Tue, 27 Aug 2019 12:58:16 +0000
Subject: [LTP] Linux-next-20190823: x86_64/i386: prot_hsymlinks.c:325:
 Failed to run cmd: useradd hsym
In-Reply-To: <866876796.8349197.1566901536625.JavaMail.zimbra@redhat.com>
References: <CA+G9fYtN2tjHZtjtc8isdsD5hF76teeh2-pngUp+uj3WYdj7jA@mail.gmail.com>
 <20190826104127.GA14729@haruka>
 <1264279239.8133737.1566817520787.JavaMail.zimbra@redhat.com>
 <CA+G9fYsHpNKFHr=ZukVvj+uMJDyHj2Xwb9bCfzPQyYzMjZ0rCw@mail.gmail.com>
 <203971593.8175020.1566830285708.JavaMail.zimbra@redhat.com>
 <fcd20866bb836d45b1e384dd68080c671bcde938.camel@hammerspace.com>
 <2039173876.8300255.1566861172742.JavaMail.zimbra@redhat.com>
 <566e862d9bfaf88cdde6d66f0f59033fe6225a22.camel@hammerspace.com>
 <866876796.8349197.1566901536625.JavaMail.zimbra@redhat.com>
Message-ID: <294428f05e4dba1a6b10b8744cfa5da0637f84a4.camel@hammerspace.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2019-08-27 at 06:25 -0400, Jan Stancek wrote:
> That theory is probably not correct for this case, since EIO I see
> appears
> to originate from write and nfs_writeback_result(). This function
> also
> produces message we saw in logs from Naresh.
> 
> I can't find where/how is resp->count updated on WRITE reply in
> NFSv2.
> Issue also goes away with patch below, though I can't speak about its
> correctness:
> 
> NFS version     Type    Test    Return code
> nfsvers=2       tcp     -b:base         0
> nfsvers=2       tcp     -g:general      0
> nfsvers=2       tcp     -s:special      0
> nfsvers=2       tcp     -l:lock         0
> Total time: 141
> 
> diff --git a/fs/nfs/nfs2xdr.c b/fs/nfs/nfs2xdr.c
> index cbc17a203248..4913c6da270b 100644
> --- a/fs/nfs/nfs2xdr.c
> +++ b/fs/nfs/nfs2xdr.c
> @@ -897,6 +897,16 @@ static int nfs2_xdr_dec_writeres(struct rpc_rqst
> *req, struct xdr_stream *xdr,
>                                  void *data)
>  {
>         struct nfs_pgio_res *result = data;
> +       struct rpc_task *rq_task  = req->rq_task;
> +
> +       if (rq_task) {
> +               struct nfs_pgio_args *args = rq_task-
> >tk_msg.rpc_argp;
> +
> +               if (args) {
> +                       result->count = args->count;
> +               }
> +       }
>  
>         /* All NFSv2 writes are "file sync" writes */
>         result->verf->committed = NFS_FILE_SYNC;

Thanks! I've moved the above to nfs_write_done() so that we do it only
on success (see 
http://git.linux-nfs.org/?p=trondmy/linux-nfs.git;a=commitdiff;h=3ba5688da709dd0f7d917029c206bc1848a6ae74
)
-- 
Trond Myklebust
Linux NFS client maintainer, Hammerspace
trond.myklebust@hammerspace.com


