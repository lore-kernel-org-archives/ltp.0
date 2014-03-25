Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WSQRh-0004nk-1H
	for ltp-list@lists.sourceforge.net; Tue, 25 Mar 2014 12:27:09 +0000
Date: Tue, 25 Mar 2014 13:26:44 +0100
From: chrubis@suse.cz
Message-ID: <20140325122644.GA1806@rei>
References: <CAE1O6mijvWG84ntBC3eep6gStru_WXC_wMayOO0UcsNvsE4v8w@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAE1O6mijvWG84ntBC3eep6gStru_WXC_wMayOO0UcsNvsE4v8w@mail.gmail.com>
Subject: Re: [LTP] LTP mm test fails,
 may be test case have some unclear problem
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
To: Levi Wang <wangli5665@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> LTP testing on RHEL-7.0 hit this issue. it's re-emerge not often.
> 
> Does anyone know this?
> 
> -----[cut here ]----
> 
> <<<test_start>>>
> tag=oom01 stime=1392954542
> cmdline="oom01"
> contacts=""
> analysis=exit
> <<<test_output>>>
> oom01       0  TINFO  :  set overcommit_memory to 2
> oom01       0  TINFO  :  allocating 3221225472 bytes.
> oom01       0  TINFO  :  allocating 3221225472 bytes.
> oom01       0  TINFO  :  allocating 3221225472 bytes.
> oom01       0  TINFO  :  allocating 3221225472 bytes.
> oom01       0  TINFO  :  set overcommit_memory to 2
> oom01       0  TINFO  :  expected victim is 31115.
> oom01       0  TINFO  :  set overcommit_memory to 0
> oom01       0  TINFO  :  expected victim is 31135.
> oom01       1  TFAIL  :  the victim unexpectedly failed: 9
> oom01       0  TINFO  :  set overcommit_memory to 1
> oom01       0  TINFO  :  start normal OOM testing.
> oom01       0  TINFO  :  expected victim is 31496.
> oom01       0  TINFO  :  start OOM testing for mlocked pages.
> oom01       0  TINFO  :  expected victim is 31514.
> oom01       0  TINFO  :  start OOM testing for KSM pages.
> oom01       0  TINFO  :  expected victim is 31525.
> oom01       0  TINFO  :  set overcommit_memory to 0
> <<<execution_status>>>

Hmm, the test does not expect to have it's children killed while the
child mmaps and dirties more and more memory. So it seems to be test
that asserts that mmap() returns failure before the test is killed with
oom although the documentation in the test source code says that the
test increases memory consumption untill OOM is triggered.

Anyway there seems to be something wrong with the test. I would say that
there is no guarantee that mmap() will fail before OOM tries to kill the
process if overcommit is set to 0 or 1.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
