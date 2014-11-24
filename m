Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <msripal@linux.vnet.ibm.com>) id 1XswLX-0007gc-EG
	for ltp-list@lists.sourceforge.net; Mon, 24 Nov 2014 16:18:39 +0000
Received: from e8.ny.us.ibm.com ([32.97.182.138])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XswLV-0005GM-R4
	for ltp-list@lists.sourceforge.net; Mon, 24 Nov 2014 16:18:39 +0000
Received: from /spool/local
	by e8.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <msripal@linux.vnet.ibm.com>; 
	Mon, 24 Nov 2014 11:18:32 -0500
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
	[9.57.198.28])
	by d01dlp03.pok.ibm.com (Postfix) with ESMTP id AACC9C90048
	for <ltp-list@lists.sourceforge.net>;
	Mon, 24 Nov 2014 11:10:32 -0500 (EST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	sAOGISTB24379492
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Nov 2014 16:18:28 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	sAOGISqx006302
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Nov 2014 11:18:28 -0500
Received: from oc3602201088.ibm.com (sig-9-65-68-77.mts.ibm.com [9.65.68.77])
	by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	sAOGIRDf006126
	for <ltp-list@lists.sourceforge.net>; Mon, 24 Nov 2014 11:18:27 -0500
Message-ID: <54735A52.8020909@linux.vnet.ibm.com>
Date: Mon, 24 Nov 2014 10:18:26 -0600
From: Meenakshi Sripal <msripal@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] proposed patch to fix ltp max_map_count test failure on ppc
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3737634961956696956=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3737634961956696956==
Content-Type: multipart/alternative;
	boundary="------------070701000909030404070906"

This is a multi-part message in MIME format.
--------------070701000909030404070906
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Ltp-list:

*Description: *Base ltp testcase max_map_count is failing on ppc arch

kernel: 3.10.0-123.9.3

Here is the proposed patch to be submitted upstream:
Patch:
--- ltp-full-20140828.orig/testcases/kernel/mem/tunable/max_map_count.c 
    2014-11-11 11:13:39.811776626 -0600
+++ ltp-full-20140828/testcases/kernel/mem/tunable/max_map_count.c   
  2014-11-11 11:14:05.650945873 -0600
@@ -231,7 +231,7 @@ static void max_map_count_test(void)
          * is the mm failure point at the time of
          * writing this COMMENT!
         */
-        if (map_count == (max_maps + 1))
+        if (map_count <= (max_maps + 1))
             tst_resm(TPASS, "%ld map entries in total "
                  "as expected.", max_maps);
         else

*
*Although according to the description of the test case "map_count <= 
max_map_count" is valid, it is implemented as "map_count == 
(max_map_count + 1)" in the code.

We can say that the test case can be passed for "map_count <= 
(max_map_count + 1)"  because, MAP_FAILED can be triggered NOT ONLY when 
max_map_count is reached, but also when the kernel is running out of 
memory. IN THIS TESTCASE KERNEL RUNS OUT OF MEMORY BECAUSE THE PAGE SIZE 
IS HUGE.
Kernel allocates mapped area for each process, as entered in the file 
/proc/[pid]/maps, as multiples of pagesize.
Hence when the page size is huge, the kernel runs out of memory (aligned 
addresses in this case) even before max_map_count is reached.

Please find below test results suggesting that it is because of the big 
page size that MAP_FAILED is triggered.
Note that the amount of free memory is almost the same on both the systems.

IA32:

kernel: 3.10.0-123.9.3

# getconf PAGESIZE
4096
# free -g
              total       used       free     shared    buffers     cached
Mem:            23          1         22          0          0          0
-/+ buffers/cache:          0         22
Swap:            0          0          0
# cat /proc/sys/vm/max_map_count
65530

# ./max_map_count
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
max_map_count    1  TPASS  :  64 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 256
max_map_count    2  TPASS  :  256 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 1024
max_map_count    3  TPASS  :  1024 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 4096
max_map_count    4  TPASS  :  4096 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 16384
max_map_count    5  TPASS  :  16384 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 65536
max_map_count    6  TPASS  :  65536 map entries in total as expected.
max_map_count    0  TINFO  :  set overcommit_memory to 0
max_map_count    0  TINFO  :  set max_map_count to 65530

PPC:

kernel: 3.10.0-123.9.3

-bash-4.2# getconf PAGESIZE
65536
-bash-4.2# free -g
              total       used       free     shared    buffers     cached
Mem:            19          0         18          0          0          0
-/+ buffers/cache:          0         19
Swap:            7          0          7
-bash-4.2# cat /proc/sys/vm/max_map_count
65530

-bash-4.2# cd /opt/fiv/ltp/testcases/bin/
-bash-4.2# ./max_map_count
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
max_map_count    1  TPASS  :  64 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 256
max_map_count    2  TPASS  :  256 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 1024
max_map_count    3  TPASS  :  1024 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 4096
max_map_count    4  TPASS  :  4096 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 16384
max_map_count    5  TPASS  :  16384 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 65536
max_map_count    6  TFAIL  :  max_map_count.c:239: 65489 map entries in 
total, but expected 65536 entries
max_map_count    0  TINFO  :  set overcommit_memory to 0
max_map_count    0  TINFO  :  set max_map_count to 65530

After the patch is applied, the test passes:
-bash-4.2# ./max_map_count
max_map_count    0  TINFO  :  set overcommit_memory to 2
max_map_count    0  TINFO  :  set max_map_count to 64
max_map_count    1  TPASS  :  64 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 256
max_map_count    2  TPASS  :  256 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 1024
max_map_count    3  TPASS  :  1024 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 4096
max_map_count    4  TPASS  :  4096 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 16384
max_map_count    5  TPASS  :  16384 map entries in total as expected.
max_map_count    0  TINFO  :  set max_map_count to 65536
max_map_count    6  TPASS  :  65536 map entries in total as expected.
max_map_count    0  TINFO  :  set overcommit_memory to 0
max_map_count    0  TINFO  :  set max_map_count to 65530

***************************
Meenakshi Sripal
Linux Technology Center - Embedded Linux




--------------070701000909030404070906
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=ISO-8859-1">
  </head>
  <body text="#000000" bgcolor="#ffffff">
    <font face="sans-serif" size="2"></font><font face="sans-serif"
      size="2">Ltp-list:</font>
    <br>
    <br>
    <font face="sans-serif" size="2"><b>Description: </b>Base ltp
      testcase
      max_map_count is failing on ppc arch</font>
    <br>
    <br>
    <font face="sans-serif" size="2">kernel: 3.10.0-123.9.3</font>
    <br>
    <br>
    <font face="sans-serif" size="2">Here is the proposed patch to be
      submitted
      upstream:</font>
    <br>
    <font face="sans-serif" size="2">Patch:<br>
      ---
      ltp-full-20140828.orig/testcases/kernel/mem/tunable/max_map_count.c
      &nbsp; &nbsp;2014-11-11 11:13:39.811776626 -0600<br>
      +++ ltp-full-20140828/testcases/kernel/mem/tunable/max_map_count.c
      &nbsp;
      &nbsp;2014-11-11 11:14:05.650945873 -0600<br>
      @@ -231,7 +231,7 @@ static void max_map_count_test(void)<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* is the mm failure point at the time
      of<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;* writing this COMMENT!<br>
      &nbsp; &nbsp; &nbsp; &nbsp; */<br>
      - &nbsp; &nbsp; &nbsp; &nbsp;if (map_count == (max_maps + 1))<br>
      + &nbsp; &nbsp; &nbsp; &nbsp;if (map_count &lt;= (max_maps + 1))<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; tst_resm(TPASS, "%ld map
      entries in total "<br>
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;"as
      expected.", max_maps);<br>
      &nbsp; &nbsp; &nbsp; &nbsp; else</font>
    <br>
    <font face="sans-serif" size="2"><br>
      <b><br>
      </b>Although according to the description of the test case
      "map_count
      &lt;= max_map_count" is valid, it is implemented as "map_count
      == (max_map_count + 1)" in the code.<br>
      <br>
      We can say that the test case can be passed for "map_count &lt;=
      (max_map_count
      + 1)" &nbsp;because, MAP_FAILED can be triggered NOT ONLY when
      max_map_count
      is reached, but also when the kernel is running out of memory. IN
      THIS
      TESTCASE KERNEL RUNS OUT OF MEMORY BECAUSE THE PAGE SIZE IS HUGE.<br>
      Kernel allocates mapped area for each process, as entered in the
      file /proc/[pid]/maps,
      as multiples of pagesize.<br>
      Hence when the page size is huge, the kernel runs out of memory
      (aligned
      addresses in this case) even before max_map_count is reached. <br>
      <br>
      Please find below test results suggesting that it is because of
      the big
      page size that MAP_FAILED is triggered.<br>
      Note that the amount of free memory is almost the same on both the
      systems.</font>
    <br>
    <br>
    <font face="sans-serif" size="2">IA32:</font>
    <br>
    <br>
    <font face="sans-serif" size="2">kernel: 3.10.0-123.9.3</font>
    <br>
    <font face="sans-serif" size="2"><br>
      # getconf PAGESIZE<br>
      4096<br>
      # free -g</font>
    <br>
    <font face="sans-serif" size="2">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;total &nbsp; &nbsp; &nbsp; used &nbsp; &nbsp; &nbsp; free &nbsp;
      &nbsp; shared &nbsp; &nbsp;buffers &nbsp; &nbsp; cached</font>
    <br>
    <font face="sans-serif" size="2">Mem: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;23 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;1 &nbsp; &nbsp; &nbsp; &nbsp;
      22 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0</font>
    <br>
    <font face="sans-serif" size="2">-/+ buffers/cache: &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; 22</font>
    <br>
    <font face="sans-serif" size="2">Swap: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;0</font>
    <br>
    <font face="sans-serif" size="2"># cat /proc/sys/vm/max_map_count</font>
    <br>
    <font face="sans-serif" size="2">65530</font>
    <br>
    <font face="sans-serif" size="2"><br>
      # ./max_map_count </font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set overcommit_memory to 2</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 64</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;1 &nbsp;TPASS
      &nbsp;: &nbsp;64 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 256</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;2 &nbsp;TPASS
      &nbsp;: &nbsp;256 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 1024</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;3 &nbsp;TPASS
      &nbsp;: &nbsp;1024 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 4096</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;4 &nbsp;TPASS
      &nbsp;: &nbsp;4096 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 16384</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;5 &nbsp;TPASS
      &nbsp;: &nbsp;16384 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 65536</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;6 &nbsp;TPASS
      &nbsp;: &nbsp;65536 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set overcommit_memory to 0</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 65530<br>
    </font>
    <br>
    <font face="sans-serif" size="2">PPC:</font>
    <br>
    <br>
    <font face="sans-serif" size="2">kernel: 3.10.0-123.9.3</font>
    <br>
    <font face="sans-serif" size="2"><br>
      -bash-4.2# getconf PAGESIZE</font>
    <br>
    <font face="sans-serif" size="2">65536</font>
    <br>
    <font face="sans-serif" size="2">-bash-4.2# free -g</font>
    <br>
    <font face="sans-serif" size="2">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;total &nbsp; &nbsp; &nbsp; used &nbsp; &nbsp; &nbsp; free &nbsp;
      &nbsp; shared &nbsp; &nbsp;buffers &nbsp; &nbsp; cached</font>
    <br>
    <font face="sans-serif" size="2">Mem: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;19 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;
      18 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
      &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0</font>
    <br>
    <font face="sans-serif" size="2">-/+ buffers/cache: &nbsp; &nbsp; &nbsp;
      &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; 19</font>
    <br>
    <font face="sans-serif" size="2">Swap: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;7 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp;
      &nbsp;7</font>
    <br>
    <font face="sans-serif" size="2">-bash-4.2# cat
      /proc/sys/vm/max_map_count</font>
    <br>
    <font face="sans-serif" size="2">65530</font>
    <br>
    <br>
    <font face="sans-serif" size="2">-bash-4.2# cd
      /opt/fiv/ltp/testcases/bin/</font>
    <br>
    <font face="sans-serif" size="2">-bash-4.2# ./max_map_count </font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set overcommit_memory to 2</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 64</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;1 &nbsp;TPASS
      &nbsp;: &nbsp;64 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 256</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;2 &nbsp;TPASS
      &nbsp;: &nbsp;256 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 1024</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;3 &nbsp;TPASS
      &nbsp;: &nbsp;1024 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 4096</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;4 &nbsp;TPASS
      &nbsp;: &nbsp;4096 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 16384</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;5 &nbsp;TPASS
      &nbsp;: &nbsp;16384 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 65536</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;6 &nbsp;TFAIL
      &nbsp;: &nbsp;max_map_count.c:239: 65489 map entries in total, but expected
      65536 entries</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set overcommit_memory to 0</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 65530</font>
    <br>
    <br>
    <font face="sans-serif" size="2">After the patch is applied, the
      test
      passes:<br>
      -bash-4.2# ./max_map_count</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set overcommit_memory to 2</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 64</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;1 &nbsp;TPASS
      &nbsp;: &nbsp;64 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 256</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;2 &nbsp;TPASS
      &nbsp;: &nbsp;256 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 1024</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;3 &nbsp;TPASS
      &nbsp;: &nbsp;1024 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 4096</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;4 &nbsp;TPASS
      &nbsp;: &nbsp;4096 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 16384</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;5 &nbsp;TPASS
      &nbsp;: &nbsp;16384 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 65536</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;6 &nbsp;TPASS
      &nbsp;: &nbsp;65536 map entries in total as expected.</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set overcommit_memory to 0</font>
    <br>
    <font face="sans-serif" size="2">max_map_count &nbsp; &nbsp;0 &nbsp;TINFO
      &nbsp;: &nbsp;set max_map_count to 65530</font>
    <br>
    <br>
    <font face="sans-serif" size="2">***************************<br>
      Meenakshi Sripal<br>
      Linux Technology Center - Embedded Linux<br>
      <br>
    </font>
    <br>
    <br>
  </body>
</html>

--------------070701000909030404070906--



--===============3737634961956696956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
--===============3737634961956696956==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3737634961956696956==--


