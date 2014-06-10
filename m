Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WuLTV-0001fM-Dw
	for ltp-list@lists.sourceforge.net; Tue, 10 Jun 2014 12:48:25 +0000
Date: Tue, 10 Jun 2014 14:48:15 +0200
From: chrubis@suse.cz
Message-ID: <20140610124815.GA32749@rei.Home>
References: <7CF842D49929104A9E5360C8FA9370998CEA4E@POCITMSEXMB03.LntUniverse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7CF842D49929104A9E5360C8FA9370998CEA4E@POCITMSEXMB03.LntUniverse.com>
Subject: Re: [LTP] Request to help in analyzing the failed test cases in LTP
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
To: Ajoymon Joseph <AJOY.JOSEPH@LNTTECHSERVICES.COM>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> Hi ,
>             I am not understanding how failed test cases can be checked. What is the reason for the failure. These are the failed test cases

There is nothing magical about this. You have to read the test source,
figure out what it does, find where it fails and figure out if it's test
or system fault.

> cat output/LTP_RUN_ON-2000_Jan_01-05h_26m_37s.failed
> chdir01A symlink01 -T
> fcntl13_64 fcntl13_64
> fcntl18_64 fcntl18_64
> fstatfs02_64 fstatfs02_64
> gethostid01 gethostid01
> ioctl03      ioctl03
> linkat01 linkat01
> msgctl11 msgctl11
> nftw6401 nftw6401
> rt_sigprocmask01 rt_sigprocmask01
> sendfile02_64 sendfile02_64
> sendfile03_64 sendfile03_64
> sendfile04_64 sendfile04_64
> sendfile05_64 sendfile05_64
> sendfile06_64 sendfile06_64
> sendfile07_64 sendfile07_64
> sendmsg01 sendmsg01
> signalfd4_01 signalfd4_01
> signalfd4_02 signalfd4_02
> statfs02_64 statfs02_64
> statfs03_64 statfs03_64
> syslog01 syslog01
> syslog02 syslog02
> syslog03 syslog03
> syslog04 syslog04
> syslog05 syslog05
> syslog07 syslog07
> syslog08 syslog08
> syslog09 syslog09
> syslog10 syslog10
> timer_gettime01 timer_gettime01
> utimensat01 utimensat_tests.sh
> gf01 growfiles -W gf01 -b -e 1 -u -i 0 -L 20 -w -C 1 -l -I r -T 10 glseek20 glseek20.2 -d $TMPDIR
> gf10 growfiles -W gf10 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I l g_lio14 g_lio14.2 -d $TMPDIR
> gf11 growfiles -W gf11 -b -e 1 -u -r 1-5000 -i 0 -L 30 -C 1 -I L g_lio15 g_lio15.2 -d $TMPDIR
> gf12 mkfifo $TMPDIR/gffifo17; growfiles -b -W gf12 -e 1 -u -i 0 -L 30 gffifo17 -d $TMPDIR
> gf13 mkfifo $TMPDIR/gffifo18; growfiles -b -W gf13 -e 1 -u -i 0 -L 30 -I r -r 1-4096 gffifo18 -d $TMPDIR
> gf14 growfiles -W gf14 -b -e 1 -u -i 0 -L 20 -w -l -C 1 -T 10 glseek19 glseek19.2 -d $TMPDIR
> gf15 growfiles -W gf15 -b -e 1 -u -r 1-49600 -I r -u -i 0 -L 120 Lgfile1 -d $TMPDIR
> gf16 growfiles -W gf16 -b -e 1 -i 0 -L 120 -u -g 4090 -T 100 -t 408990 -l -C 10 -c 1000 -S 10 -f Lgf02_ -d $TMPDIR
> gf17 growfiles -W gf17 -b -e 1 -i 0 -L 120 -u -g 5000 -T 100 -t 499990 -l -C 10 -c 1000 -S 10 -f Lgf03_ -d $TMPDIR
> gf18 growfiles -W gf18 -b -e 1 -i 0 -L 120 -w -u -r 10-5000 -I r -l -S 2 -f Lgf04_ -d $TMPDIR
> rwtest02 export LTPROOT; rwtest -N rwtest02 -c -q -i 60s  -f
> 
> 
> How it can be analyzed. I ran the test individually.
> 
> ./symlink01 -T chdir01
> 
> 
> Given the output.
> 
> chdir01     1  TFAIL  :  symlink(object, symbolic) was succesful.
> mkdir(object, 0700) was successful
> chdir(2) returned successfully, but getcwd(3) indicated new current working directory location /mnt/CPSW/tmp/chdf7a0eK/object not equal to expected /tmp/chdf7a0eK/object
> chdir01     2  TPASS  :  chdir(2) to non-existent object file location through symbolic link file failed as expected
> chdir01     3  TPASS  :  Nested symbolic link access condition caught.  ELOOP is returned
> 
> 
> How I can fix this issue?

As said above, you have to figure out what is wrong here. We cannot help
you unless you have at least some clue what went wrong.

From the log it looks like something is wrong with the /tmp location
perpahs some nonstandard steps used to setup the machine, but without
more information that is just wild guess.

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
