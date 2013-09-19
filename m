Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VMde0-0007dU-Ej
	for ltp-list@lists.sourceforge.net; Thu, 19 Sep 2013 12:47:40 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VMddx-0008VR-5Y
	for ltp-list@lists.sourceforge.net; Thu, 19 Sep 2013 12:47:40 +0000
Received: from acsinet22.oracle.com (acsinet22.oracle.com [141.146.126.238])
	by aserp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id r8JClU5c003312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Sep 2013 12:47:31 GMT
Received: from userz7021.oracle.com (userz7021.oracle.com [156.151.31.85])
	by acsinet22.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8JClUCb007087
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Sep 2013 12:47:30 GMT
Received: from abhmt111.oracle.com (abhmt111.oracle.com [141.146.116.63])
	by userz7021.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	r8JClTV6015811
	for <ltp-list@lists.sourceforge.net>; Thu, 19 Sep 2013 12:47:29 GMT
Message-ID: <523AF25C.1010907@oracle.com>
Date: Thu, 19 Sep 2013 16:47:24 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
Subject: [LTP] Policy regarding BASH
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

Hi!

During looking into shell testcases I came across a situation where
* main shell script is a bash script (ie it has #!/bin/bash in the header)
* for each testcase number main shell script executes a separate (child) 
shell-script which has #!/bin/sh in the header

So If I try to run main script on Debian (where /bin/sh  points to 
/bin/dash) I get error like this:
root@debian7-x64:/opt/ltp/testcases/bin# ./run_cpuset_test.sh 3
TEST 3: CPUSET CONTROLLER TESTING
TEST STARTED: Please avoid using system while this test executes
./cpuset_exclusive_test.sh: 34: ./cpuset_funcs.sh: arithmetic 
expression: expecting primary: "N_NODES++"

So what is the policy regarding bash presence in LTP? Is it permitted to 
write testcases using bash specific features?
Or are we strongly encouraged to use "common shell" only?

And how should I proceed with this particular testcase? Try to remove 
"bashism" or just change header of child scripts from "#!/bin/sh" to 
"#!/bin/bash"?

Thank you.






------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
