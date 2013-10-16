Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VWOdU-0004Hn-Cj
	for ltp-list@lists.sourceforge.net; Wed, 16 Oct 2013 10:47:28 +0000
Date: Wed, 16 Oct 2013 12:47:12 +0200
From: chrubis@suse.cz
Message-ID: <20131016104712.GA24451@rei.Home>
References: <1380881342-13025-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20131015133036.GB25867@rei> <525E61D0.7030704@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <525E61D0.7030704@oracle.com>
Subject: Re: [LTP] controllers/cpuset: promised patches
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net, miaox@cn.fujitsu.com

Hi!
> >> This a series promised in 'Re: [LTP] [PATCH V2 8/8] controllers/cpuset: reorganization'.
> > The patches looks good, but when I try to run it on SLES11 SP3 I got
> > failures in setup() in cpuset_funcs.sh:
> >
> > TFAIL  :  Could not mount cgroup filesystem with
> > TWARN  :  /dev/cpuset already exists.. overwriting
> > mkdir: cannot create directory `/dev/cpuset': File exists
> > ...
> >
> >
> > If I comment the code in the setup() the tests at least run, but I got a
> > lot of invalid arguments and errors (see bellow). This is machine with
> > two nodes and 24 Xeon CPUs.
> 
> Thanks. I will check it. Could you paste the code you comment?

Just disable the setup, for example like this:

diff --git a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
index a83845c..b178d53 100755
--- a/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
+++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
@@ -129,6 +129,7 @@ check()
 # clean any group created eralier (if any)
 setup()
 {
+       return 0;
        if [ -e "$CPUSET" ]
        then
                tst_resm TWARN "$CPUSET already exist.. overwriting"


And as I've looked for the the cpuset_funcs.sh I've found that there are two copies of the file that differ only in one line.

$ find -name cpuset_funcs.sh
./testcases/kernel/controllers/cpuset/cpuset_lib/cpuset_funcs.sh
./testcases/kernel/controllers/cpuset/cpuset_funcs.sh

$ diff -u cpuset_funcs.sh cpuset_lib/cpuset_funcs.sh 
--- cpuset_funcs.sh     2013-10-16 12:06:12.978604247 +0200
+++ cpuset_lib/cpuset_funcs.sh  2013-05-27 11:16:48.186777123 +0200
@@ -31,7 +31,7 @@
        N_NODES="`cat /sys/devices/system/node/has_normal_memory`"
 fi
 N_NODES=${N_NODES#*-*}
-N_NODES=$(($N_NODES + 1))
+: $((N_NODES++))
 
 CPUSET="/dev/cpuset"
 CPUSET_TMP="/tmp/cpuset_tmp"


We should remove one of them...

> I suppose cleanup() function doesn't perform normally. Since it has many 
> '> /dev/null 2>&1' you didn't see any errors on the screen.

That is likely.

And after I've rebooted the machine, the tests seems to run fine (the setup is
no longer commented).

I think that the problem is that the cleanup() is not able to cope with the
/dev/cpuset directory left out after killed cpuset01 test. I will look into
this.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60135031&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
