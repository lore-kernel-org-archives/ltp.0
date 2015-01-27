Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YG87H-0003MD-Lx
	for ltp-list@lists.sourceforge.net; Tue, 27 Jan 2015 15:31:47 +0000
Date: Tue, 27 Jan 2015 16:31:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150127153140.GG16759@rei.suse.de>
References: <1422336738-617-1-git-send-email-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1422336738-617-1-git-send-email-liwang@redhat.com>
Subject: Re: [LTP] [PATCH] mem/hugeshmat: new case for hugepage leak
	inspection
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
To: Li Wang <liwang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +void setup(void)
> +{
> +	long mem_total, hpage_size;
> +
> +	tst_require_root(NULL);
> +
> +	mem_total = read_meminfo("MemTotal:");
> +	if (mem_total < 2L*1024*1024) {
> +		tst_resm(TINFO, "Test requires more than 2GB of RAM");
> +		tst_exit();

This should be:

                tst_brmk(TCONF, "Test requires more than 2GB of RAM");

As I said in the last mail.

Otherwise it looks fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
