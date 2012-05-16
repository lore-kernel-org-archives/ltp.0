Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SUfeq-0004KM-5v
	for ltp-list@lists.sourceforge.net; Wed, 16 May 2012 14:56:56 +0000
Date: Wed, 16 May 2012 16:53:53 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120516145353.GA12228@saboteur.suse.cz>
References: <4F2CE53D.9030908@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F2CE53D.9030908@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ltp-pan.c: fix error of Total Tests
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> When execvp() fails, the testcases is counted in Total Tests, but not added in
> logfile. In fact the testcases result should be added in logfile.
>  static pid_t
> -run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode)
> +run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
> +	  int *failcnt, int fmt_print, FILE * logfile)
>  {
>      ssize_t errlen;
>      int cpid;
> @@ -978,6 +982,26 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode)
>  	    termtype = "unknown";
>  	}
>  	time(&end_time);
> +	if (logfile != NULL) {
> +		if (!fmt_print)
> +			fprintf(logfile,
> +				"tag=%s stime=%d dur=%d exit=%s "
> +				"stat=%d core=%s cu=%d cs=%d\n",
> +				colle->name, (int)(active->mystime),
> +				(int) (end_time - active->mystime), termtype,
> +				termid, (status & 0200) ? "yes" : "no",
> +				0, 0);
> +		else {

I suggest to add curly brackets around the multiline fprintf too.

> +			if (termid != 0)
> +				++*failcnt;
> +
> +			fprintf(logfile, "%-30.30s %-10.10s %-5d\n",
> +				colle->name, ((termid != 0) ? "FAIL" : "PASS"),
> +				termid);
> +		}
> +		fflush(logfile);
> +	}
> +
>  	if (!quiet_mode)
>  	{
>  		//write_test_start(active, errbuf);

Otherwise I don't have any objection to adding this into the ltp-pan.
Although I don't understand the messy pan code that much (and I don't
have any intentions to study it more closely).

Do have anybody else an opinion?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
