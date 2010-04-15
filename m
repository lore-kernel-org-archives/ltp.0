Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1O2FIq-00029r-2p
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 02:59:40 +0000
Received: from out04.sjc.mx.trendmicro.com ([216.99.131.8])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1O2FIn-000442-7X
	for ltp-list@lists.sourceforge.net; Thu, 15 Apr 2010 02:59:39 +0000
Received: from relay03.sjc.mx.trendmicro.com (unknown [10.30.239.25])
	by out04.sjc.mx.trendmicro.com (Postfix) with ESMTP id 10ED858C629
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 02:59:30 +0000 (UTC)
Received: from smtp-gate.ryobi.co.jp (unknown [210.163.224.132])
	by relay03.sjc.mx.trendmicro.com (Postfix) with ESMTP id 6D61D3DD01C
	for <ltp-list@lists.sourceforge.net>;
	Thu, 15 Apr 2010 02:59:29 +0000 (UTC)
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 15 Apr 2010 11:59:28 +0900
Message-ID: <003201cadc47$a9bcec80$fd36c580$@co.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0033_01CADC93.19A49480"
Content-Language: ja
Subject: Re: [LTP] [PATCH] fix \"ar\" test
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: mitani@ryobi.co.jp
Cc: ltp-list@lists.sourceforge.net, kamimura@ryobi.co.jp

This is a multi-part message in MIME format.

------=_NextPart_000_0033_01CADC93.19A49480
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Sorry.
My patch was destroyed by e-mail.
I attach patch for "ar01" file.


Signed-off-by: Tomonori Mitani <mitani@ryobi.co.jp>


Regards--

-Tomonori Mitani

------=_NextPart_000_0033_01CADC93.19A49480
Content-Type: application/octet-stream;
	name="ar01.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ar01.patch"

--- a/testcases/commands/ade/ar/ar01	2010-04-01 16:15:00.000000000 +0900=0A=
+++ b/testcases/commands/ade/ar/ar01	2010-04-06 19:04:44.000000000 +0900=0A=
@@ -519,19 +519,19 @@=0A=
 rm -rf $TCtmp/lib.a;cd $TCdat=0A=
 ar -cr $TCtmp/lib.a file0.in file2.in =0A=
 crtest=0A=
-File1time=3D`ar -tv $TCtmp/lib.a | grep file0.in | cut -f2 -d: | cut =
-f1 -d" "`=0A=
-File2time=3D`ar -tv $TCtmp/lib.a | grep file2.in | cut -f2 -d: | cut =
-f1 -d" "`=0A=
+File1time=3D`ar -tv $TCtmp/lib.a | grep file0.in`=0A=
+File2time=3D`ar -tv $TCtmp/lib.a | grep file2.in`=0A=
 =0A=
 #sleep 5=0A=
 touch -c -t 201503030303.55 file0.in=0A=
 =0A=
 ar -ru $TCtmp/lib.a file0.in file2.in 2>&1 1>/dev/null=0A=
-File1time1=3D`ar -tv $TCtmp/lib.a | grep file0.in | cut -f2 -d: | cut =
-f1 -d" "`=0A=
-File2time2=3D`ar -tv $TCtmp/lib.a | grep file2.in | cut -f2 -d: | cut =
-f1 -d" "`=0A=
+File1time1=3D`ar -tv $TCtmp/lib.a | grep file0.in`=0A=
+File2time2=3D`ar -tv $TCtmp/lib.a | grep file2.in`=0A=
 =0A=
-if [ $File2time =3D $File2time2 ]=0A=
+if [ "$File2time" =3D "$File2time2" ]=0A=
 then=0A=
-	if [ $File1time =3D $File1time1 ]=0A=
+	if [ "$File1time" =3D "$File1time1" ]=0A=
 	then=0A=
     		TCRESULT=3D20=0A=
     		echo "FAIL - ar with -u flag failed"=0A=

------=_NextPart_000_0033_01CADC93.19A49480
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
------=_NextPart_000_0033_01CADC93.19A49480
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

------=_NextPart_000_0033_01CADC93.19A49480--



