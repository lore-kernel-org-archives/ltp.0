Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UfAXb-0002ha-TG
	for ltp-list@lists.sourceforge.net; Wed, 22 May 2013 15:01:23 +0000
Date: Wed, 22 May 2013 17:02:34 +0200
From: chrubis@suse.cz
Message-ID: <20130522150234.GA9737@rei.suse.cz>
References: <f86dfe8123738c73c9dc2fd08309bfbe09e925e6.1368780870.git.jstancek@redhat.com>
	<4ea3e87b9e1000e948e77a117c7cd77dd3c9ccda.1369120163.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4ea3e87b9e1000e948e77a117c7cd77dd3c9ccda.1369120163.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH v2 2/2] waitid02: split code into separate
	testcases
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
> -int TST_TOTAL = 4;
> +static int TST_TOTAL = sizeof(tdat) / sizeof(tdat[0]);

You can use ARRAY_SIZE() macro we have. ;)

> -		}
> +		/* setup alarm for unlikely event that test blocks */
> +		alarm(5);

I'm slightly against adding timeouts to tests in this fashion.

The correct solution for this would be making the test driver to kill
the test after some timeout. Which is what I want to solve with new test
execution framework (that unfortunately does not exist at the moment).

I guess that we can hack around some default timeout (30 mins or
something equally big) into ltp-pan.c for the time being. Which would at
least assure that the testsuite will not hang forever. We can't do
anything smarter without anotating long lived testcases (more than five
minutes or so) with proper timeouts in the runtest files though :(.

>  	cleanup();
>  	tst_exit();

The rest is fine.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
