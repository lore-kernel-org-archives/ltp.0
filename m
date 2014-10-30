Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1XjsAV-0002mI-Ls
	for ltp-list@lists.sourceforge.net; Thu, 30 Oct 2014 16:01:47 +0000
Date: Thu, 30 Oct 2014 17:01:14 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20141030160114.GA18064@rei.suse.de>
References: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1414681678-28439-1-git-send-email-mmarhefk@redhat.com>
Subject: Re: [LTP] [PATCH] containers: added mountns/mountns05.c
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
I do not like these macros.

> +#define REPORT_PARENT_ERROR(errmsg) \
> +{ \
> +	msgctl(id, IPC_RMID, NULL); \

	^
	This should be removed from the test cleanup.

	If you want to call the default cleanup defined in the header
	you can define second cleanup function that does specific
	cleanup and then calls the generic cleanup pass the right
	function pointers to tst_brmk()

> +	tst_brkm(TBROK | TERRNO, cleanup, errmsg); \
> +}
> +
> +#define REPORT_CHLD_ERROR(errmsg) \
> +{ \
> +	perror(errmsg); umount(DIRA); \
> +	msgctl(id, IPC_RMID, NULL); \
> +	wait(&status); return ERRC; \
> +}

Can't we do the cleanup the kenel style?

i.e.

	if (something_failed()) {
		errmsg = "message";
		goto err;
	}

	...

	return result;
err:
	perror(errmsg);
	umout(DIRA);
	msgclt(id, IPC_RMID, NULL);
	wait(&status);
	return ERRC;


...

> diff --git a/testcases/kernel/containers/mountns/mountns_helper.h b/testcases/kernel/containers/mountns/mountns_helper.h
> index d4a6a91..d82c837 100644
> --- a/testcases/kernel/containers/mountns/mountns_helper.h
> +++ b/testcases/kernel/containers/mountns/mountns_helper.h
> @@ -47,6 +47,10 @@ static int check_newns(void)
>  
>  static void cleanup(void)
>  {
> +	int status;
> +
> +	wait(&status);
> +	umount(DIRA);
>  	umount(DIRA);
>  	umount(DIRB);
>  	tst_rmdir();

This changes function called from several testcases, I guess that this
is missing cleanup being added there. Maybe it should deserve to be
pushed as a separate patch with description in commit message.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
