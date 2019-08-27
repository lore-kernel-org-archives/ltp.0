From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 27 Aug 2019 12:04:17 +0530
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
Message-ID: <CA+G9fYvKbU5St+D=awgQS--SSO-_AteEpfMJ69COq-eOTHa2NA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 27 Aug 2019 at 04:42, Jan Stancek <jstancek@redhat.com> wrote:
>
>
> ----- Original Message -----
> > On Mon, 2019-08-26 at 10:38 -0400, Jan Stancek wrote:
>
> No change with that patch,

Same for me.

> but following one fixes it for me:

Works for me.
Thanks for the fix patch.

>
> diff --git a/fs/nfs/pagelist.c b/fs/nfs/pagelist.c
> index 20b3717cd7ca..56cefa0ab804 100644
> --- a/fs/nfs/pagelist.c
> +++ b/fs/nfs/pagelist.c
> @@ -590,7 +590,7 @@ static void nfs_pgio_rpcsetup(struct nfs_pgio_header *hdr,
>         }
>
>         hdr->res.fattr   = &hdr->fattr;
> -       hdr->res.count   = 0;
> +       hdr->res.count   = count;
>         hdr->res.eof     = 0;
>         hdr->res.verf    = &hdr->verf;
>         nfs_fattr_init(&hdr->fattr);
>
> which is functionally revert of "NFS: Fix initialisation of I/O result struct in nfs_pgio_rpcsetup".
>
> This hunk caught my eye, could res.eof == 0 explain those I/O errors?
>                 /* Emulate the eof flag, which isn't normally needed in NFSv2
>                  * as it is guaranteed to always return the file attributes
>                  */
>                 if (hdr->args.offset + hdr->res.count >= hdr->res.fattr->size)
>                         hdr->res.eof = 1;


- Naresh
