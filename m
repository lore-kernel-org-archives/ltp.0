From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 25 Apr 2016 12:38:20 -0400 (EDT)
Subject: [LTP] [PATCH] preadv02/pwritev02: fix EFAULT testcase on s390/x
In-Reply-To: <20160425151905.GF20158@rei.lan>
References: <4d64dda152c0b8020df70f88d838c649aec716c0.1461277019.git.jstancek@redhat.com>
 <20160425151905.GF20158@rei.lan>
Message-ID: <1048042510.133236.1461602300545.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Monday, 25 April, 2016 5:19:05 PM
> Subject: Re: [LTP] [PATCH] preadv02/pwritev02: fix EFAULT testcase on s390/x
> 
> Hi!
> >  static struct iovec rd_iovec2[] = {
> > +#if !defined(__s390__) && !defined(__s390x__)
> >  	{buf, CHUNK},
> > +#endif
> >  	{(char *)-1, CHUNK},
> >  };
> 
> What about splitting it as:
> 
> --- a/testcases/kernel/syscalls/preadv/preadv02.c
> +++ b/testcases/kernel/syscalls/preadv/preadv02.c
> @@ -58,6 +58,9 @@ static struct iovec rd_iovec1[] = {
>  
>  static struct iovec rd_iovec2[] = {
>         {buf, CHUNK},
> +};
> +
> +static struct iovec rd_iovec3[] = {
>         {(char *)-1, CHUNK},
>  };
>  
> @@ -71,7 +74,7 @@ static struct tcase {
>         {&fd1, rd_iovec1, 1, 0, EINVAL},
>         {&fd1, rd_iovec2, -1, 0, EINVAL},
>         {&fd1, rd_iovec2, 1, -1, EINVAL},
> -       {&fd1, rd_iovec2, 2, 0, EFAULT},
> +       {&fd1, rd_iovec3, 1, 0, EFAULT},
>         {&fd3, rd_iovec2, 1, 0, EBADF},
>         {&fd2, rd_iovec2, 1, 0, EBADF},
>         {&fd4, rd_iovec2, 1, 0, EISDIR},
> 
> instead of adding #ifdefs?
> 
> That should work fine as well. Or do you want to reatain the part that tests
> that we get EFAULT for the second part of the iovec as well?

No, I think we can split it as you suggested. I'll run a quick test and post v2.

Regards,
Jan
