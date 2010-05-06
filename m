Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1O9v31-0000NF-HP
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:59:03 +0000
Received: from e33.co.us.ibm.com ([32.97.110.151])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O9v2z-0002kB-Na
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 06:59:02 +0000
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e33.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o466sutA029300
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:54:56 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o466wuZp124754
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:56 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o466wt5T001589
	for <ltp-list@lists.sourceforge.net>; Thu, 6 May 2010 00:58:55 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
Date: Thu, 06 May 2010 12:28:45 +0530
Message-Id: <20100506065844.23879.29307.sendpatchset@subratamodak.linux.ibm.com>
In-Reply-To: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
Subject: [11/12 FAILURE] LTPX file test fails
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============8948625877121438259=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Linus Test Project <ltp-list@lists.sourceforge.net>
Cc: Sharyathi Nagesh <sharyath@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, B N Poornima <bnpoorni@in.ibm.com>

--===============8948625877121438259==

Subject: LTP�� file_test fails

Issues Description below:
====================================
# vi runtest/file_test
file export TCdat=$LTPROOT/testcases/bin; file_test.sh
<EOF>

Run LTP with the following command:
# ./runltp -f file_test
<<<test_output>>>
file01      0  TINFO  :  TEST #1: file command recogizes ASCII text files
file01      1  TPASS  :  file: Recognised ASCII file correctly
file02      0  TINFO  :  TEST #2: file command recognizes bash shell scripts
file02      2  TPASS  :  file: Recognised bash shell script correctly
file03      0  TINFO  :  TEST #3: file command recognizes korn shell scripts
file03      3  TPASS  :  file: recognised korn shell script
file04      0  TINFO  :  TEST #4: file command recognizes C shell scripts
file04      4  TPASS  :  file: Recognised C shell script correctly
file05      0  TINFO  :  TEST #5: file command recognizes C programs text
file05      5  TPASS  :  file: Recognised C program text correctly
file06      0  TINFO  :  TEST #6: file command recognizes ELF executables
file06      6  TPASS  :  file: Recognized ELF binary executable
file07      0  TINFO  :  TEST #7: file command recognizes tar files.
file07      7  TPASS  :  file: Recognised tar files
file08      0  TINFO  :  TEST #8: file command recognizes tar zip files
file08      8  TPASS  :  file: Recognised tar zip file
file09      0  TINFO  :  TEST #9: file command recognizes RPM files
file09      9  TFAIL  :  file: Failed to Recognize RPM file. Reason:
/root/rpmbuild/SRPMS/cprog-0.0.7-3.src.rpm: RPM v3.0 src
file10      0  TINFO  :  TEST #10: file command recognizes vmlinu file
file10     10  TPASS  :  file: Recognised vmlinu file correctly
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=exited termination_id=1 corefile=no
cutime=7 cstime=18
<<<test_end>>>

Regards--
Subrata



--===============8948625877121438259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============8948625877121438259==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============8948625877121438259==--
