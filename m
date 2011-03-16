Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PztFD-0004v7-6o
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 16:06:43 +0000
Date: Wed, 16 Mar 2011 17:28:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316162837.GA10245@saboteur.suse.cz>
References: <[PATCH1/2]> <1300290266-26725-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1300290266-26725-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH v4 1/2] fs: fsstress: make test more POSIX
 compliant
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
To: czhang@redhat.com
Cc: ltp-list@lists.sourceforge.net

Hi!
>  dread_f(int opno, long r)
>  {
>  	__int64_t	align;
> -	char		*buf;
> +	char		*buf = NULL;
>  	struct dioattr	diob;
>  	int		e;
>  	pathname_t	f;
> @@ -1826,7 +1826,14 @@ dread_f(int opno, long r)
>  		len = align;
>  	else if (len > diob.d_maxiosz)
>  		len = diob.d_maxiosz;
> -	buf = memalign(diob.d_mem, len);
> +	if (posix_memalign((void **)&buf, diob.d_mem, len) != 0) {
> +		perror("posix_memalign");

Sorry for not spotting this earlier, but I've doublechecked the
manual page and it says:

...
posix_memalign() returns zero on success, or one of the error values
listed in the next section on failure.  Note that errno is not set.
...

So you can't use perror() to print the error message. It would probably
print something like:

posix_memalign: Succeded

The correct solution is to save the return value from posix_memalign()
and use strerror().

> +		exit(1);
> +	}
> +	if (buf == NULL) {
> +		fprintf(stderr, "posix_memalign: buf is NULL\n");
> +		exit(1);
> +	}
>  	e = read(fd, buf, len) < 0 ? errno : 0;
>  	free(buf);

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Colocation vs. Managed Hosting
A question and answer guide to determining the best fit
for your organization - today and in the future.
http://p.sf.net/sfu/internap-sfd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
