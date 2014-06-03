Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wrqej-0002gw-Uw
	for ltp-list@lists.sourceforge.net; Tue, 03 Jun 2014 15:29:41 +0000
Date: Tue, 3 Jun 2014 17:29:20 +0200
From: chrubis@suse.cz
Message-ID: <20140603152920.GA28308@rei>
References: <1401418614.3225.15.camel@G08JYZSD130126>
	<1401418662.3225.16.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1401418662.3225.16.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 2/2] statvfs/statvfs02.c: add new errno testes
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
Both pushed, thanks.

> +static struct test_case_t {
> +	char *path;
> +	struct statvfs *buf;
> +	int exp_errno;
> +} test_cases[] = {
> +	{NULL, &buf, EFAULT},

I've changed the testcase, for now, to map PROT_NONE page and set
pointer to it to a path for this testcase because there architectures
that have something mapped on NULL address (itanium if I recall
correctly).

I will deal with this by creating a library function to provide invalid
addresses and fix all the testcases later.

> +	{TEST_SYMLINK, &buf, ELOOP},
> +	{nametoolong, &buf, ENAMETOOLONG},
> +	{"filenoexist", &buf, ENOENT},
> +	{"statvfs_file/test", &buf, ENOTDIR},
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their 
applications. Written by three acclaimed leaders in the field, 
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
