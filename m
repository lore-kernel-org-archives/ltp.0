Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TJMcJ-0001l8-KK
	for ltp-list@lists.sourceforge.net; Wed, 03 Oct 2012 10:55:51 +0000
Date: Wed, 3 Oct 2012 12:56:15 +0200
From: chrubis@suse.cz
Message-ID: <20121003105615.GB22986@saboteur.suse.cz>
References: <E061084CB90FCE4F89232A6CF839683B32BC7AE2@SZXEML507-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E061084CB90FCE4F89232A6CF839683B32BC7AE2@SZXEML507-MBS.china.huawei.com>
Subject: Re: [LTP] sendmsg01 fails  from 3.6-rc1 kernel onward,
 possible ltp test case update needed
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
To: shyju pv <shyju.pv@huawei.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> System call sendmsg01 fails from 3.6-rc1 onward.
> LTP_Version: 2012-06-14
> Testcase : sendmsg01
> Description : verifies the sendmsg syscall returns value for various failure
> cases
> Failure Analysis : System call returns -1 and the test case expect 0
> Latest Kernel version in which test case passed :  Kernel 3.5
> Test case Failed : Kernel 3.6-rc1,rc2and rc3
> Output log :: <<<test_output>>>
> incrementing stop
> sendmsg01    1  TPASS  :  bad file descriptor successful
> sendmsg01    2  TPASS  :  invalid socket successful
> sendmsg01    3  TPASS  :  invalid send buffer successful
> sendmsg01    4  TPASS  :  connected TCP successful
> sendmsg01    5  TPASS  :  not connected TCP successful
> sendmsg01    6  TPASS  :  invalid to buffer length successful
> sendmsg01    7  TPASS  :  invalid to buffer successful
> sendmsg01    8  TPASS  :  UDP message too big successful
> sendmsg01    9  TPASS  :  local endpoint shutdown successful
> sendmsg01   10  TPASS  :  invalid iovec pointer successful
> sendmsg01   11  TPASS  :  invalid msghdr pointer successful
> sendmsg01   12  TPASS  :  rights passing successful
> sendmsg01   13  TPASS  :  invalid flags set w/ control successful
> sendmsg01   14  TFAIL  :  invalid flags set ; returned -1 (expected 0),
> errno
> 95 (expected 95)

That looks like kernel bugfix which made sendmsg() return -1 on invalid
flags, however further investigation will be needed.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Don't let slow site performance ruin your business. Deploy New Relic APM
Deploy New Relic app performance management and know exactly
what is happening inside your Ruby, Python, PHP, Java, and .NET app
Try New Relic at no cost today and get our sweet Data Nerd shirt too!
http://p.sf.net/sfu/newrelic-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
