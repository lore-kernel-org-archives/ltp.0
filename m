Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZJjCt-0002dA-VI
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 14:16:43 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZJjCs-00019a-QN
	for ltp-list@lists.sourceforge.net; Mon, 27 Jul 2015 14:16:43 +0000
Date: Mon, 27 Jul 2015 16:16:23 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150727141622.GA15383@rei.suse.de>
References: <1436876572-28759-1-git-send-email-mmarhefk@redhat.com>
	<1436958370-21366-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1436958370-21366-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH 1/2 v2] added helper tools for creating and
 working with namespaces
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
To: Matus Marhefka <mmarhefk@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +static int child_fn(void *arg)
> +{
> +	struct argst *args = arg;
> +
> +	execvp(args->argv[2], args->argv+2);

We don't have to pass the argv pointer packed in the struct argst now,
right? Just pass the argv pointer to the clone function in main and cast
it to (char **) here.


...

> +	tst_resm(TINFO | TERRNO, "execvp");
> +	return 1;
> +}
> +	/* gets interface index */
> +	if (ioctl(sock_fd, SIOCGIFINDEX, &ifr) == -1) {
> +		close(sock_fd);
> +		tst_resm(TINFO | TERRNO, "ioctl");
> +		return -1;

Technically the close() may clobber the errno before it gets printed. So
ideally we should print the message, then close the sock_fd.

> +	}
> +
> +	close(sock_fd);
> +	return ifr.ifr_ifindex;
> +}


The rest looks fine.

Acked with the minor fixed included.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
