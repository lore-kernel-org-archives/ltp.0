Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X0BOI-0002JN-Nb
	for ltp-list@lists.sourceforge.net; Thu, 26 Jun 2014 15:15:10 +0000
Date: Thu, 26 Jun 2014 17:14:52 +0200
From: chrubis@suse.cz
Message-ID: <20140626151452.GA31396@rei.suse.cz>
References: <1403593899-17040-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1403593899-17040-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1403593899-17040-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2 2/2] pan/ltp-pan.c: add statistics about not
 fully tested testcases
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
> Currently numbers of testcases in LTP will return TCONF when they are not
> appropriate to run. But when users execute './runltp' to run the default
> test suite towards an linux distribution or upstream kernel, if testcases
> return TCONF, ultimately they will print TPASS to users, then users will
> not know the real LTP test coverage.
> 
> Here we change this behaviour and show users testcases which return TCONF,
> meaning that these testcases are not fully tested.

Reviewed, tested and pushed with cosmetic changes, thanks.

> Here is a sample:
> 1. Before this patch, The output will be:
> Test Start Time: Tue Jun 24 14:32:15 2014
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> access01                       PASS       0
> access02                       PASS       0
> access03                       PASS       0
> getxattr01                     PASS       0
> getxattr02                     PASS       0
> access04                       PASS       0
> ext4-nsec-timestamps           PASS       0
> ext4-uninit-groups             PASS       0
> access05                       PASS       0
> access06                       PASS       0
> 
> -----------------------------------------------
> Total Tests: 10
> Total Failures: 0
> Kernel Version: 3.16.0-rc1+
> Machine Architecture: x86_64
> Hostname: localhost.localdomain
> 
> 2. After this patch, the output will be:
> Test Start Time: Tue Jun 24 14:28:27 2014
> -----------------------------------------
> Testcase                       Result     Exit Value
> --------                       ------     ----------
> access01                       PASS       0
> access02                       PASS       0
> access03                       PASS       0
> getxattr01                     TCONF      32
> getxattr02                     TCONF      32

I've changed this report to be:

access03                       PASS       0
getxattr01                     CONF      32
...

So that the Result column is nicely aligned.


And changed the header filename to tst_res_flags.h because we have
tst_res.c

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
