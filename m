Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1TJOAC-0005xb-GH
	for ltp-list@lists.sourceforge.net; Wed, 03 Oct 2012 12:34:56 +0000
Date: Wed, 3 Oct 2012 14:32:50 +0200
From: chrubis@suse.cz
Message-ID: <20121003123250.GA8435@rei>
References: <20121003114039.GC22986@saboteur.suse.cz>
	<564795434.6124572.1349265888804.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <564795434.6124572.1349265888804.JavaMail.root@redhat.com>
Subject: Re: [LTP] Test case send01 fails in kernel version 3.6-rc1,
 rc2 and rc3
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
Cc: shyju pv <shyju.pv@huawei.com>, ltp-list@lists.sourceforge.net

Hi!
> > The usuall concensus for such case is to change expected return
> > values
> > depending on the kernel version (see for example tst_kvercmp() in
> > testcases/kernel/syscalls/sysctl/sysctl03.c). Which is the best
> > solution
> > I can come up with.
> > 
> > On the other hand we don't bother to work with rc kernels they change
> > far to often.
> > 
> > Does this behave same on released linux 3.6?
> 
> I believe it does. I just tested with RHEL7 kernel based on 3.6, which is at this point
> very close to vanilla (+- few changes in build scripts and config).
> 
> # ./send01 
> send01      1  TPASS  :  bad file descriptor successful
> send01      2  TPASS  :  invalid socket successful
> send01      3  TPASS  :  invalid send buffer successful
> send01      4  TPASS  :  UDP message too big successful
> send01      5  TPASS  :  local endpoint shutdown successful
> send01      6  TFAIL  :  invalid flags set ; returned -1 (expected -1), errno 95 (expected 14)
> # cd ../sendto/
> # ./sendto01 
> sendto01    1  TPASS  :  bad file descriptor successful
> sendto01    2  TPASS  :  invalid socket successful
> sendto01    3  TPASS  :  invalid send buffer successful
> sendto01    4  TPASS  :  connected TCP successful
> sendto01    5  TPASS  :  not connected TCP successful
> sendto01    6  TPASS  :  invalid to buffer length successful
> sendto01    7  TPASS  :  invalid to buffer successful
> sendto01    8  TPASS  :  UDP message too big successful
> sendto01    9  TPASS  :  local endpoint shutdown successful
> sendto01   10  TFAIL  :  invalid flags set ; returned -1 (expected 0), errno 95 (expected 32)
> # cd ../sendmsg/
> # ./sendmsg01 
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
> sendmsg01   14  TFAIL  :  invalid flags set ; returned -1 (expected 0), errno 95 (expected 95)
> sendmsg01   15  TPASS  :  invalid cmsg length successful
> sendmsg01   16  TPASS  :  invalid cmsg pointer successful

Okay then I will prepare patch. Stay tuned.

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
