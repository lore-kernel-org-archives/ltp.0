Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1NRmTv-0003xd-DF
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 12:56:23 +0000
Received: from eu1sys200aog106.obsmtp.com ([207.126.144.121])
	by sfi-mx-4.v28.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NRmTu-0007z5-0E
	for ltp-list@lists.sourceforge.net; Mon, 04 Jan 2010 12:56:23 +0000
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 33D0F105
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Jan 2010 12:56:01 +0000 (GMT)
Received: from mail2.ctn.st.com (mail2.ctn.st.com [164.130.116.137])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C5E361638
	for <ltp-list@lists.sourceforge.net>;
	Mon,  4 Jan 2010 12:56:00 +0000 (GMT)
Message-ID: <4B41E55D.2020801@st.com>
Date: Mon, 04 Jan 2010 13:55:57 +0100
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------050800020602050705010106"
Subject: [LTP] mtest01: free memory allocated
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
To: LTP <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050800020602050705010106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I'm running LTP (I'm using ltp-full-20090731....but asap I will upgrade 
to latest)  on SH based platforms.
Now, during a test-session. I've noted that the test "mtest01" reduced 
drastically the system memory and after its execution this memory wasn't 
de-allocated.

I've analysed the mtest01.c code and I've noted that no "free()" 
istruction was associated to the related malloc:

......
if((mem = (char*)malloc(chunksize)) == NULL) {
......

I've simply added a "free(mem)" of the allocated memory and the issue 
was addressed successfully.

I've attached the trivial patch I've developed.

Best Regards,
--
Francesco

--------------050800020602050705010106
Content-Type: text/plain;
	name="ltp-full-20090731-fix-mtest01_memory_issue.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ltp-full-20090731-fix-mtest01_memory_issue.patch"

Added missed "free" istruction to release memory previosuly allocated.
Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
--- ltp-full-20090731/testcases/kernel/mem/mtest01/mtest01.c.origin	2009-02-26 13:02:27.000000000 +0100
+++ ltp-full-20090731/testcases/kernel/mem/mtest01/mtest01.c	2009-12-15 14:03:28.779240000 +0100
@@ -258,5 +258,8 @@
     else
       tst_resm(TPASS, "%llu kbytes allocated only.", original_maxbytes/1024);
   }
+
+  free(mem);
+  
   exit(0);
 }

--------------050800020602050705010106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
--------------050800020602050705010106
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050800020602050705010106--


