From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Mon, 9 Sep 2019 10:36:00 +0800
Subject: [LTP] nfs-for-5.3-3 update "breaks" NFSv4 directIO somehow
In-Reply-To: <00923c9f5d5a69e8225640abcf7ad54df2cb62d2.camel@hammerspace.com>
References: <20190828102256.3nhyb2ngzitwd7az@XZHOUW.usersys.redhat.com>
 <00923c9f5d5a69e8225640abcf7ad54df2cb62d2.camel@hammerspace.com>
Message-ID: <20190909023600.sxygdyclxm4ivllw@XZHOUW.usersys.redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Aug 28, 2019 at 03:32:25PM +0000, Trond Myklebust wrote:
> On Wed, 2019-08-28 at 18:22 +0800, Murphy Zhou wrote:
> > Hi,
> > 
> > If write to file with O_DIRECT, then read it without O_DIRECT, read
> > returns 0.
> > From tshark output, looks like the READ call is missing.
> > 
> > LTP[1] dio tests spot this. Things work well before this update.
> > 
> > Bisect log is pointing to:
> > 
> > 	commit 7e10cc25bfa0dd3602bbcf5cc9c759a90eb675dc
> > 	Author: Trond Myklebust <trond.myklebust@hammerspace.com>
> > 	Date:   Fri Aug 9 12:06:43 2019 -0400
> > 	
> > 	    NFS: Don't refresh attributes with mounted-on-file
> > informatio
> > 
> > With this commit reverted, the tests pass again.
> > 
> > It's only about NFSv4(4.0 4.1 and 4.2), NFSv3 works well.
> > 
> > Bisect log, outputs of tshark, sample test programme derived from
> > LTP diotest02.c and a simple test script are attached.
> > 
> > If this is an expected change, we will need to update the testcases.
> 
> That is not intentional, so thanks for reporting it! Does the following
> fix help?

Hi Trond,

Will you queue this fix for v5.3 ?

Thanks!

> 
> 8<------------------------
> From ce61618bc085d8cea8a614b5e1eb09e16ea8e036 Mon Sep 17 00:00:00 2001
> From: Trond Myklebust <trond.myklebust@hammerspace.com>
> Date: Wed, 28 Aug 2019 11:26:13 -0400
> Subject: [PATCH] NFS: Fix inode fileid checks in attribute revalidation code
> 
> We want to throw out the attrbute if it refers to the mounted on fileid,
> and not the real fileid. However we do not want to block cache consistency
> updates from NFSv4 writes.
> 
> Reported-by: Murphy Zhou <jencce.kernel@gmail.com>
> Fixes: 7e10cc25bfa0 ("NFS: Don't refresh attributes with mounted-on-file...")
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> ---
>  fs/nfs/inode.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
> index c764cfe456e5..d7e78b220cf6 100644
> --- a/fs/nfs/inode.c
> +++ b/fs/nfs/inode.c
> @@ -1404,10 +1404,11 @@ static int nfs_check_inode_attributes(struct inode *inode, struct nfs_fattr *fat
>  		return 0;
>  
>  	/* No fileid? Just exit */
> -	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
> -		return 0;
> +	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
> +		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
> +			return 0;
>  	/* Has the inode gone and changed behind our back? */
> -	if (nfsi->fileid != fattr->fileid) {
> +	} else if (nfsi->fileid != fattr->fileid) {
>  		/* Is this perhaps the mounted-on fileid? */
>  		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
>  		    nfsi->fileid == fattr->mounted_on_fileid)
> @@ -1808,10 +1809,11 @@ static int nfs_update_inode(struct inode *inode, struct nfs_fattr *fattr)
>  			atomic_read(&inode->i_count), fattr->valid);
>  
>  	/* No fileid? Just exit */
> -	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID))
> -		return 0;
> +	if (!(fattr->valid & NFS_ATTR_FATTR_FILEID)) {
> +		if (fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID)
> +			return 0;
>  	/* Has the inode gone and changed behind our back? */
> -	if (nfsi->fileid != fattr->fileid) {
> +	} else if (nfsi->fileid != fattr->fileid) {
>  		/* Is this perhaps the mounted-on fileid? */
>  		if ((fattr->valid & NFS_ATTR_FATTR_MOUNTED_ON_FILEID) &&
>  		    nfsi->fileid == fattr->mounted_on_fileid)
> -- 
> 2.21.0
> 
> -- 
> Trond Myklebust
> Linux NFS client maintainer, Hammerspace
> trond.myklebust@hammerspace.com
> 
> 
