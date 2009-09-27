Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1MryId-0005no-LZ
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:43 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MryIY-0004XC-BA
	for ltp-list@lists.sourceforge.net; Sun, 27 Sep 2009 18:16:43 +0000
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8RIEHOd012758
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:14:17 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8RIGWVl201508
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:16:32 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8RIGVbl000759
	for <ltp-list@lists.sourceforge.net>; Sun, 27 Sep 2009 12:16:32 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <1254005162-27353-1-git-send-email-avagin@gmail.com>
References: <1254005162-27353-1-git-send-email-avagin@gmail.com>
Date: Sun, 27 Sep 2009 23:45:40 +0530
Message-Id: <1254075341.10457.29.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH 1/5] fsstress: delete tralling spaces
Reply-To: subrata@linux.vnet.ibm.com
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Andrew Vagin <avagin@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, 2009-09-27 at 02:45 +0400, Andrew Vagin wrote: 
> Signed-off-by: Andrew Vagin <avagin@gmail.com>

Thanks.

Regards--
Subrata

> ---
>  testcases/kernel/fs/fsstress/fsstress.c |   36 +++++++++++++++---------------
>  1 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
> index 1f11f6e..b313b62 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -295,7 +295,7 @@ int main(int argc, char **argv)
>  	ptrdiff_t	srval;
>  #endif
>          int             nousage=0;
> -#ifndef NO_XFS	
> +#ifndef NO_XFS
>  	xfs_error_injection_t	err_inj;
>  #endif
> 
> @@ -308,7 +308,7 @@ int main(int argc, char **argv)
>  		switch (c) {
>  		case 'c':
>  			/*Don't cleanup*/
> -			cleanup=1; 
> +			cleanup=1;
>  			break;
>  		case 'd':
>  			dirname = optarg;
> @@ -389,13 +389,13 @@ int main(int argc, char **argv)
>  					ops[i].freq = 0;
>  			}
>  		}
> -       
> +
>         	 	if (!dirname) {
>         	     	/* no directory specified */
>      	        	if (!nousage) usage();
>             	 exit(1);
>          	}
> -       
> +
>  		(void)mkdir(dirname, 0777);
>  		if (chdir(dirname) < 0) {
>  			perror(dirname);
> @@ -472,7 +472,7 @@ int main(int argc, char **argv)
>  			while (wait(&stat) > 0)
>  				continue;
>  		}
> -#ifndef NO_XFS	
> +#ifndef NO_XFS
>  		if (errtag != 0) {
>  			err_inj.errtag = 0;
>  			err_inj.fd = fd;
> @@ -724,7 +724,7 @@ doproc(void)
>  		p = &ops[freq_table[random() % freq_table_size]];
>  		if ((unsigned long)p->func < 4096) abort();
> 
> -	
> +
>  		p->func(opno, random());
>  		/*
>  		 * test for forced shutdown by stat'ing the test
> @@ -1225,7 +1225,7 @@ show_ops(int flag, char *lead_str)
>          if (flag<0) {
>                  /* print in list form */
>                  int             x = WIDTH;
> -               
> +
>  	        for (p = ops; p < ops_end; p++) {
>  			if (lead_str != NULL && x+strlen(p->name)>=WIDTH-5)
>  				x=printf("%s%s", (p==ops)?"":"\n", lead_str);
> @@ -1277,7 +1277,7 @@ symlink_path(const char *name1, pathname_t *name)
>  	char		buf[MAXNAMELEN];
>  	pathname_t	newname;
>  	int		rval;
> -       
> +
>          if (!strcmp(name1, name->path)) {
>              printf("yikes! %s %s\n", name1, name->path);
>              return 0;
> @@ -1553,12 +1553,12 @@ bulkstat_f(int opno, long r)
>  	t = malloc(nent * sizeof(*t));
>  	fd = open(".", O_RDONLY);
>  	total = 0;
> -   
> +
>          bsr.lastip=&last;
>          bsr.icount=nent;
>          bsr.ubuffer=t;
>          bsr.ocount=&count;
> -           
> +
>  	while (ioctl(fd, XFS_IOC_FSBULKSTAT, &bsr) == 0 && count > 0)
>  		total += count;
>  	free(t);
> @@ -1580,7 +1580,7 @@ bulkstat1_f(int opno, long r)
>  	xfs_bstat_t	t;
>  	int		v;
>          xfs_fsop_bulkreq_t bsr;
> -       
> +
> 
>  	good = random() & 1;
>  	if (good) {
> @@ -1610,12 +1610,12 @@ bulkstat1_f(int opno, long r)
>  		v = verbose;
>  	}
>  	fd = open(".", O_RDONLY);
> -       
> +
>          bsr.lastip=&ino;
>          bsr.icount=1;
>          bsr.ubuffer=&t;
>          bsr.ocount=NULL;
> -       
> +
>  	e = ioctl(fd, XFS_IOC_FSBULKSTAT_SINGLE, &bsr) < 0 ? errno : 0;
>  	if (v)
>  		printf("%d/%d: bulkstat1 %s ino %lld %d\n",
> @@ -1699,9 +1699,9 @@ creat_f(int opno, long r)
>  			if (ioctl(fd, XFS_IOC_FSSETXATTR, &a) < 0)
>  				e1 = errno;
>  			esz = a.fsx_estsize;
> -		
> +
>  		}
> -#endif	
> +#endif
>  		 		 add_to_flist(type, id, parid);
>  		close(fd);
>  	}
> @@ -1723,7 +1723,7 @@ setdirect(int fd)
>  		return 0;
> 
>  	flags = fcntl(fd, F_GETFL, 0);
> -	if (flags < 0) 
> +	if (flags < 0)
>  		return 0;
> 
>  	if (fcntl(fd, F_SETFL, flags|O_DIRECT)  < 0) {
> @@ -1734,7 +1734,7 @@ setdirect(int fd)
>  		printf("cannot set O_DIRECT: %s\n",strerror(errno));
>  		return 0;
>  	}
> -			      
> +
>  	return 1;
>  }
> 
> @@ -1752,7 +1752,7 @@ dread_f(int opno, long r)
>  	off64_t		off;
>  	struct stat64	stb;
>  	int		v;
> -      
> +
>  	init_pathname(&f);
>  	if (!get_fname(FT_REGFILE, r, &f, NULL, NULL, &v)) {
>  		if (v)


------------------------------------------------------------------------------
Come build with us! The BlackBerry&reg; Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9&#45;12, 2009. Register now&#33;
http://p.sf.net/sfu/devconf
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
