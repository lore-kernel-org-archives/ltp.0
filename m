Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1QANP4-0007da-0p
	for ltp-list@lists.sourceforge.net; Thu, 14 Apr 2011 14:20:14 +0000
Date: Thu, 14 Apr 2011 16:44:37 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110414144437.GF3206@saboteur.suse.cz>
References: <20110413173333.GC3206@saboteur.suse.cz>
	<3d2379f1357b2be2957c69ac408365c257e40a44.1302751818.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3d2379f1357b2be2957c69ac408365c257e40a44.1302751818.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v3] [syscalls] io_submit: fix broken testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +static void check_result(long exp, long act)
> +{
> +	if (exp >= 0)
> +	{
> +		if (act == exp)
> +			tst_resm(TPASS, "expected success - "
> +					"returned value = %ld", act);
> +		else
> +			tst_resm(TFAIL, "unexpected failure - "
> +					"returned value = %ld : %s",
> +					act, strerror(-1 * act));
> +	} else {
> +		if (act == exp)
> +			tst_resm(TPASS, "expected failure - "
> +					"returned value = %ld : %s",
> +					act, strerror(-1 * act));
> +		else if (act == 0)
> +			tst_resm(TFAIL, "call succeeded unexpectedly");
> +		else
> +			tst_resm(TFAIL, "unexpected failure - "
> +					"returned value = %ld : %s, "
> +					"expected value = %ld : %s",
> +					act, strerror(-1 * act),
> +					exp, strerror(-1 * exp));
> +	}
>  }

I hate being CodingStyle nazi (and that is one more reason why you should
learn how to use linux/scripts/checkpatch.pl...).

But here the curly bracket should be located at the end of if (exp >= 0)
and not on the new line.

Also it could be a little better if there were an return statement in
the first code block, something like:

if (exp >= 0) {
	...
	return;
}

if (act == exp)
	...

Which would make the code IMHO more readable.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Benefiting from Server Virtualization: Beyond Initial Workload 
Consolidation -- Increasing the use of server virtualization is a top
priority.Virtualization can reduce costs, simplify management, and improve 
application availability and disaster protection. Learn more about boosting 
the value of server virtualization. http://p.sf.net/sfu/vmware-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
