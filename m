Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wz4cO-0005Ia-Ug
	for ltp-list@lists.sourceforge.net; Mon, 23 Jun 2014 13:49:08 +0000
Date: Mon, 23 Jun 2014 15:48:53 +0200
From: chrubis@suse.cz
Message-ID: <20140623134852.GC6050@rei.Home>
References: <1403513949-24653-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403513949-24653-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] pan/ltp-pan.c: fix compilation warnings
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>  	static long cmdno = 0;
>  	int errpipe[2];		/* way to communicate to parent that the tag  */
>  	char errbuf[1024];	/* didn't actually start */
> +	int ret;
>  
>  	/* Try to open the file that will be stdout for the test */
>  	if (test_out_dir) {
> @@ -1026,7 +1025,8 @@ run_child(struct coll_entry *colle, struct tag_pgrp *active, int quiet_mode,
>  		char *termtype;
>  		struct tms notime = { 0, 0, 0, 0 };
>  
> -		read(errpipe[0], errbuf, errlen);
> +		ret = read(errpipe[0], errbuf, errlen);
> +		(void)ret;

I don't like that we do this just to silence compiler warning.

Can't we issue an error message in case that the read() failed instead?

i.e.

	if (read(errpipe[0], errbuf, errlen))
		fprintf(stderr, "Failed to read errbuf\n");

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
HPCC Systems Open Source Big Data Platform from LexisNexis Risk Solutions
Find What Matters Most in Your Big Data with HPCC Systems
Open Source. Fast. Scalable. Simple. Ideal for Dirty Data.
Leverages Graph Analysis for Fast Processing & Easy Data Exploration
http://p.sf.net/sfu/hpccsystems
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
