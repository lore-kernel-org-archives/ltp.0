Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Z0Bjx-0006aj-SA
	for ltp-list@lists.sourceforge.net; Wed, 03 Jun 2015 16:42:05 +0000
Date: Wed, 3 Jun 2015 18:41:06 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150603164105.GB8444@rei.suse.de>
References: <1433152944-759-1-git-send-email-weijg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1433152944-759-1-git-send-email-weijg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] sched_setparam/9-1: cleanup code and fix
 memory leak
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
To: "Wei,Jiangang" <weijg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> -static void kill_children(int *child_pid)
> +static void kill_children(int *child_pid, int count)
>  {
>  	int i;
>  
> -	for (i = 0; i < nb_cpu; i++)
> +	for (i = 0; i < count; i++)
>  		kill(child_pid[i], SIGTERM);
> +	free(child_pid);
>  }
>  
>  int main(void)
> @@ -191,9 +192,7 @@ int main(void)

The int 'j' is now unused.

>  		child_pid[i] = fork();
>  		if (child_pid[i] == -1) {
>  			perror("An error occurs when calling fork()");
> -			for (j = 0; j < i; j++)
> -				kill(child_pid[j], SIGTERM);
> -
> +			kill_children(child_pid, i)

                                                   ^
						   Missing ';'

>  			return PTS_UNRESOLVED;
>  		} else if (child_pid[i] == 0) {

I've fixed these, tested that the testcase works and pushed both
patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
