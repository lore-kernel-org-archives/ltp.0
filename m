Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QEkE0-0000aD-0t
	for ltp-list@lists.sourceforge.net; Tue, 26 Apr 2011 15:30:52 +0000
Date: Tue, 26 Apr 2011 17:56:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110426155618.GA28253@saboteur.suse.cz>
References: <1624817233.26998.1303211901975.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1624817233.26998.1303211901975.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v3] kill05: fix sporadic failures
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> 1. misusage of getpwnam causes ltpuser1 and ltpuser2 to point
> to same passwd structure, from getpwnam(3):
> "The return value may point to a static area, and may be overwritten by
> subsequent calls to getpwent(3)."
> Fix this by copying the results from returned pointer.

I see, that was caused by replacing the my_getpwnam() by
SAFE_GETPWNAM().

Anyway my_getpwnam() is wrong hackend interface, we should get rid of
it. For next time Garrett note that getpwnam() is one of these
non-reentrant interfaces and do it correctly ;).

> +void wait_for_flag(int value)
> +{
> +	while (1) {
> +		if (*flag == value)
> +			break;
> +		else
> +			sleep(1);
> +	}
> +}
> +
>  /*
>   * do_master_child()
>   */
> @@ -141,10 +158,16 @@ void do_master_child(char **av)
>  	char user1name[] = "nobody";
>  	char user2name[] = "bin";
>  
> -	struct passwd *ltpuser1, *ltpuser2;
> +	struct passwd *user;
> +	unsigned int uid1, uid2, gid1, gid2;

Technically these should be uid_t and gid_t.

> -	ltpuser1 = SAFE_GETPWNAM(NULL, user1name);
> -	ltpuser2 = SAFE_GETPWNAM(NULL, user2name);
> +	user = SAFE_GETPWNAM(NULL, user1name);
> +	uid1 = user->pw_uid;
> +	gid1 = user->pw_gid;
> +
> +	user = SAFE_GETPWNAM(NULL, user2name);
> +	uid2 = user->pw_uid;
> +	gid2 = user->pw_gid;
>  
>  	TEST_EXP_ENOS(exp_enos);
>  
> @@ -158,11 +181,11 @@ void do_master_child(char **av)
>  		tst_brkm(TBROK|TERRNO, cleanup, "Fork failed");
>  
>  	if (pid1 == 0) {
> -
> -		if (setreuid(ltpuser1->pw_uid, ltpuser1->pw_uid) == -1) {
> +		if (setreuid(uid1, gid1) == -1) {
>  			perror("setreuid failed (in child)");
>  			exit(1);
>  		}
> +		*flag = 1;
>  #ifdef UCLINUX
>  		if (self_exec(av[0], "") < 0) {
>  			perror("self_exec failed");
> @@ -172,15 +195,18 @@ void do_master_child(char **av)
>  		do_child();
>  #endif
>  	}
> -	if (setreuid(ltpuser2->pw_uid, ltpuser2->pw_uid) == -1) {
> +	if (setreuid(uid2, gid2) == -1) {
>  		perror("seteuid failed");
>  		exit(1);
>  	}
>  
> +	/* wait until child sets its euid */
> +	wait_for_flag(1);
> +
>  	TEST(kill(pid1, TEST_SIG));
>  
>  	/* signal the child that we're done */
> -	*flag = 1;
> +	*flag = 2;
>  
>  	if (waitpid(pid1, &status, 0) == -1) {
>  		perror("waitpid failed");
> @@ -209,12 +235,8 @@ void do_child()
>  	pid_t my_pid;
>  
>  	my_pid = getpid();
> -	while (1) {
> -		if (*flag == 1)
> -			exit(0);
> -		else
> -			sleep(1);
> -	}
> +	wait_for_flag(2);
> +	exit(0);
>  }
>  
>  void setup(void)

And the patch doesn't apply (as your source is older than current git).

Please use latest git sources when creating patches.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
WhatsUp Gold - Download Free Network Management Software
The most intuitive, comprehensive, and cost-effective network 
management toolset available today.  Delivers lowest initial 
acquisition cost and overall TCO of any competing solution.
http://p.sf.net/sfu/whatsupgold-sd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
