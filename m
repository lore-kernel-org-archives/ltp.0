Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1PzrdD-00022Y-2B
	for ltp-list@lists.sourceforge.net; Wed, 16 Mar 2011 14:23:23 +0000
Date: Wed, 16 Mar 2011 15:45:16 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110316144516.GE2096@saboteur.suse.cz>
References: <1300284319-23476-1-git-send-email-czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1300284319-23476-1-git-send-email-czhang@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] fs: fsstress: make test more POSIX compliant
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
> diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
> index e3b48ea..37956f3 100644
> --- a/testcases/kernel/fs/fsstress/fsstress.c
> +++ b/testcases/kernel/fs/fsstress/fsstress.c
> @@ -1826,7 +1826,13 @@ dread_f(int opno, long r)
>  		len = align;
>  	else if (len > diob.d_maxiosz)
>  		len = diob.d_maxiosz;
> -	buf = memalign(diob.d_mem, len);
> +	if (posix_memalign((void **)&buf, diob.d_mem, len) != 0) {
> +		perror("posix_memalign");
> +		exit (1);
> +	} else if (buf == NULL) {
> +		fprintf(stderr, "buf remains NULL unexpectly\n");
> +		exit (1);
> +	}

Okay, last comments:

* exit is a function so we should write exit(1);

* there is no need for the second if to be in else branch as the first
  one calls exit anyway.

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
