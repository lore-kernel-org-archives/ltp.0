Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YSRqF-0004qs-AI
	for ltp-list@lists.sourceforge.net; Mon, 02 Mar 2015 15:01:07 +0000
Date: Mon, 2 Mar 2015 16:00:17 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150302150017.GC27832@rei>
References: <1425024732-30751-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<1425024732-30751-2-git-send-email-gux.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1425024732-30751-2-git-send-email-gux.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/9] lib/sched_mc.py: add testcase/bin path for
 searching ebizzy/kernbench
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
To: Xing Gu <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> +            else:
> +                print "INFO: ebizzy benchmark not found"
> +                sys.exit(1)
> +        else:
> +            path = '%s/testcases/bin' % os.environ['LTPROOT']
> +            os.chdir(path)
> +            workload_file = ""
> +            for file_name in os.listdir('.'):
> +                if file_name == workload:
> +                    workload_file = file_name
> +                    break
> +            if workload_file == "":
> +                print "INFO: ebizzy benchmark not found"
> +                sys.exit(1)
> +        get_proc_data(stats_start)
> +        get_proc_loc_count(intr_start)
> +        try:
> +            if background == "yes":
> +                succ = os.system('./ebizzy -t%s -s4096 -S %s >/dev/null &'
> +                    % (threads, duration))

The $LTPROOT/testcases/bin should be in $PATH while LTP is executed. So
why don't we remove all the code that tries to figure the path and just
run os.system('ebizzy ....') and return TCONF if that returned 127?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
