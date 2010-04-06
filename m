Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1Nz6IZ-0003ce-1t
	for ltp-list@lists.sourceforge.net; Tue, 06 Apr 2010 10:46:23 +0000
Received: from out01.sjc.mx.trendmicro.com ([216.99.131.5])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Nz6IX-00082y-Bl
	for ltp-list@lists.sourceforge.net; Tue, 06 Apr 2010 10:46:22 +0000
Received: from relay02.sjc.mx.trendmicro.com (unknown [10.30.239.27])
	by out01.sjc.mx.trendmicro.com (Postfix) with ESMTP id 08E21239AA5
	for <ltp-list@lists.sourceforge.net>;
	Tue,  6 Apr 2010 10:46:15 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay02.sjc.mx.trendmicro.com (Postfix) with ESMTP id 539DA95846
	for <ltp-list@lists.sourceforge.net>;
	Tue,  6 Apr 2010 10:46:14 +0000 (UTC)
Received: from 5109496 ([10.113.10.40]) by po.rsoa.ryobi.co.jp
	(Post.Office MTA v4.1.1 release 20090730
	ID# 201-058U1200L1200S0V41J) with ESMTP id jp
	for <ltp-list@lists.sourceforge.net>; Tue, 6 Apr 2010 19:46:12 +0900
From: "Mitani" <mitani@ryobi.co.jp>
Date: Tue, 6 Apr 2010 19:46:11 +0900
Message-ID: <000601cad576$5f86fde0$1e94f9a0$@co.jp>
MIME-Version: 1.0
Content-Language: ja
Subject: [LTP] [PATCH] fix "ar" test
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

  * I don't know whether I can add "[PATCH]" to the title of my 
    contribution. (Because I'm not maintainer.)
    If my manners are wrong, I am sorry.


---

I found out that "-)20" test of "ar01" failed once in a while.
Its code is as follows:
------------
...
rm -rf $TCtmp/lib.a;cd $TCdat
ar -cr $TCtmp/lib.a file0.in file2.in
crtest
File1time=`ar -tv $TCtmp/lib.a | grep file0.in | cut -f2 -d: | cut -f1 -d"
"`
File2time=`ar -tv $TCtmp/lib.a | grep file2.in | cut -f2 -d: | cut -f1 -d"
"`

#sleep 5
touch -c -t 201503030303.55 file0.in

ar -ru $TCtmp/lib.a file0.in file2.in 2>&1 1>/dev/null
File1time1=`ar -tv $TCtmp/lib.a | grep file0.in | cut -f2 -d: | cut -f1 -d"
"`
File2time2=`ar -tv $TCtmp/lib.a | grep file2.in | cut -f2 -d: | cut -f1 -d"
"`

if [ $File2time = $File2time2 ]
then
        if [ $File1time = $File1time1 ]
        then
                TCRESULT=20
                echo "FAIL - ar with -u flag failed"
        else
                echo "-)20"
        fi
else
        TCRESULT=20
        echo "FAIL - ar with -u flag failed"
fi
#Reset the timestamp on file0.in to current
touch file0.in
...
------------

"file0.in" and "file2.in" are offered with "ar01" source, and they are 
copied when "make install" is executed.

In this code, "File1time" and "File1time1" are times of before and 
after time-stamp changing of "file0.in" by "touch -c -t ..." command.
But "File1time" and "File1time1" are only minute numbers.
It's problem, I think.

If installation is at 2010.04.06 XX:03 accidentally, both of 
"File1time" and "File1time1" are "03".
And this code ends as "FAIL".
This happens with a one-60th probability. 


Why must not all time informations are compared?

---

How about following patch?

Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>

============
--- a/testcases/commands/ade/ar/ar01    2010-04-01 16:15:00.000000000 +0900
+++ b/testcases/commands/ade/ar/ar01    2010-04-06 19:04:44.000000000 +0900
@@ -519,19 +519,19 @@
 rm -rf $TCtmp/lib.a;cd $TCdat
 ar -cr $TCtmp/lib.a file0.in file2.in
 crtest
-File1time=`ar -tv $TCtmp/lib.a | grep file0.in | cut -f2 -d: | cut -f1 -d"
"`
-File2time=`ar -tv $TCtmp/lib.a | grep file2.in | cut -f2 -d: | cut -f1 -d"
"`
+File1time=`ar -tv $TCtmp/lib.a | grep file0.in`
+File2time=`ar -tv $TCtmp/lib.a | grep file2.in`

 #sleep 5
 touch -c -t 201503030303.55 file0.in

 ar -ru $TCtmp/lib.a file0.in file2.in 2>&1 1>/dev/null
-File1time1=`ar -tv $TCtmp/lib.a | grep file0.in | cut -f2 -d: | cut -f1 -d"
"`
-File2time2=`ar -tv $TCtmp/lib.a | grep file2.in | cut -f2 -d: | cut -f1 -d"
"`
+File1time1=`ar -tv $TCtmp/lib.a | grep file0.in`
+File2time2=`ar -tv $TCtmp/lib.a | grep file2.in`

-if [ $File2time = $File2time2 ]
+if [ "$File2time" = "$File2time2" ]
 then
-       if [ $File1time = $File1time1 ]
+       if [ "$File1time" = "$File1time1" ]
        then
                TCRESULT=20
                echo "FAIL - ar with -u flag failed"
============


Thank you--

-Tomonori Mitani



------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
