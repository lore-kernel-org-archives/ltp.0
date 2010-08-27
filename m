Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <Jacky.Malcles@bull.net>) id 1OowsA-000303-Hz
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 11:13:26 +0000
Received: from ecfrec.frec.bull.fr ([129.183.4.8])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oows5-0001mS-No
	for ltp-list@lists.sourceforge.net; Fri, 27 Aug 2010 11:13:26 +0000
Received: from cyclope.frec.bull.fr (cyclope.frec.bull.fr [129.183.4.9])
	by ecfrec.frec.bull.fr (Postfix) with ESMTP id B532F6FA1D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 12:43:23 +0200 (CEST)
Received: from [129.183.160.80] (b015470.frec.bull.fr [129.183.160.80])
	by cyclope.frec.bull.fr (Postfix) with ESMTP id 3BB282728D
	for <ltp-list@lists.sourceforge.net>;
	Fri, 27 Aug 2010 12:43:21 +0200 (CEST)
Message-ID: <4C77999B.1070804@bull.net>
Date: Fri, 27 Aug 2010 12:55:23 +0200
From: "Jacky.Malcles" <Jacky.Malcles@bull.net>
MIME-Version: 1.0
Subject: [LTP] ltp-aiodio.sh script failed to find aio-stress testcase
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
To: ltp-list@lists.sourceforge.net

Hi,
ltp-aiodio.sh script failed to find aio-stress testcase

it failed as follows:
initiation_status="pan(ltp-aiostresspart1): execvp of 'aio-stress' (tag 
ADS1044) failed.  errno:2  No such file or directory"
duration=0 termination_type=exited termination_id=2 corefile=no
...

I just added a line to ltp-aiodio.sh script and then it finds aio-stress TC.

[root@xena5 testscripts]# diff -ru ltp-aiodio.sh.ori ltp-aiodio.sh
--- ltp-aiodio.sh.ori   2010-08-27 11:05:52.000000000 +0200
+++ ltp-aiodio.sh       2010-08-27 08:26:44.000000000 +0200
@@ -16,6 +16,7 @@
  cd ..
  export LTPROOT=${PWD}
 fi
+export PATH=$LTPROOT/testcases/bin:$PATH

 run0=0
 runTest=0
[root@xena5 testscripts]#

now it works for me.
..
tag=ADS1044 stime=1282901877
cmdline="aio-stress -I500  -o1 -O -r4    -t4   /test/aiodio/junkfile 
/test/aiodio/file2        /test/aiodio/file7  
/test/aiodio/file8                                                                               
"
contacts=""
analysis=exit
<<<test_output>>>
adding stage read
starting with read
file size 1024MB, record size 4KB, depth 64, ios per iteration 8
max io_submit 32, buffer alignment set to 4KB
...etc

please could you fixed this up,
regards,

-- 
 Jacky Malcles    	     B1-403   Email : Jacky.Malcles@bull.net
 Bull SA, 1 rue de Provence, B.P 208, 38432 Echirolles CEDEX, FRANCE
 Tel : 04.76.29.73.14


------------------------------------------------------------------------------
Sell apps to millions through the Intel(R) Atom(Tm) Developer Program
Be part of this innovative community and reach millions of netbook users 
worldwide. Take advantage of special opportunities to increase revenue and 
speed time-to-market. Join now, and jumpstart your future.
http://p.sf.net/sfu/intel-atom-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
