Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <chrubis@suse.de>) id 1Q0G4l-000561-JK
	for ltp-list@lists.sourceforge.net; Thu, 17 Mar 2011 16:29:27 +0000
Date: Thu, 17 Mar 2011 17:51:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110317165127.GA14723@saboteur.suse.cz>
References: <4D7FB02B.2040904@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D7FB02B.2040904@redhat.com>
Subject: Re: [LTP] [PATCH] mm: hugemmap05: fix hardcoded hugepagesize
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
Here comes some minor notes.

> +static int hugepagesize; /* in Byte */

Correct spelling should be "in Bytes"

> +
> +static void get_hugepagesize(void)
> +{
> +	FILE *fp;
> +
> +	memset(buf, -1, BUFSIZ);
> +	if ((fp = fopen(PATH_MEMINFO, "r")) == NULL)
> +		tst_brkm(TBROK, NULL, "can't open %s", PATH_MEMINFO);
> +	while (fgets(line, BUFSIZ, fp) != NULL) {
> +		if (lookup(line, "Hugepagesize")) {
> +			tst_resm(TINFO, "Hugepagesize is %d kB", atoi(buf));

It's kind of useless to convert string into integer and then integer
into string again. ;)

> +			hugepagesize = atoi(buf) * 1024;
> +			return;
> +		}
> +	}
> +	tst_brkm(TBROK, NULL, "get Hugepagesize failed.");
> +}
> +
> +/* 
> + * It's not easy to #define tunable file paths via sysfs,
> + * use function get_hugepagesize and global variable instead. 
> + */
> +static void get_sys_sz_paths(void)
> +{
> +	sprintf(path_sys_sz, "/sys/kernel/mm/hugepages/hugepages-%dkB",
> +			hugepagesize / 1024);
> +	sprintf(path_sys_sz_over, "%s/nr_overcommit_hugepages", 
> +			path_sys_sz);
> +	sprintf(path_sys_sz_free, "%s/free_hugepages", 
> +			path_sys_sz);
> +	sprintf(path_sys_sz_resv, "%s/resv_hugepages", 
> +			path_sys_sz);
> +	sprintf(path_sys_sz_surp, "%s/surplus_hugepages", 
> +			path_sys_sz);
> +	sprintf(path_sys_sz_huge, "%s/nr_hugepages", 
> +			path_sys_sz);
> +}

It's kind of confusing to name the function get_sys_sz_paths() as it's
not returning anything, I would rather name it as init_sys_sz_paths().
The same goes for get_hugepagesize().


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
