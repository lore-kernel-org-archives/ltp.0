Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dmarlin@redhat.com>) id 1Ol4MJ-0000Tz-Mb
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 18:24:31 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ol4MI-0006Ds-Ho
	for ltp-list@lists.sourceforge.net; Mon, 16 Aug 2010 18:24:31 +0000
Received: from int-mx02.intmail.prod.int.phx2.redhat.com
	(int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id o7GIOOxd019749
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 14:24:24 -0400
Received: from dmarlin.csb (dhcp-224-3.tha.redhat.com [10.15.224.3])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id o7GIONpa010375
	for <ltp-list@lists.sourceforge.net>; Mon, 16 Aug 2010 14:24:24 -0400
Message-ID: <4C698256.4010804@redhat.com>
Date: Mon, 16 Aug 2010 13:24:22 -0500
From: David Marlin <dmarlin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040006040401050403040104"
Subject: [LTP] warning when building pread01.c
Reply-To: dmarlin@redhat.com
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
To: LTP list <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040006040401050403040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Function compare_bufers in pread01.c does not expect any arguments, but 
the reference to compare_bufers passes two arguments:

     compare_bufers(write_buf, read_buf);


Within the function compare_bufers, write_buf and read_buf are accessed 
via their global definitions.  These variables are also accessed via the 
global definitions in other functions in this testcase.

Attached is a patch to remove the unnecessary arguments from the 
compare_bufers function reference.


Signed-off-by: d.marlin <dmarlin@redhat.com>



--------------040006040401050403040104
Content-Type: text/x-patch;
 name="pread01.c.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pread01.c.patch"

--- testcases/kernel/syscalls/pread/pread01.c.orig	2010-04-01 01:23:10.000000000 -0500
+++ testcases/kernel/syscalls/pread/pread01.c	2010-07-07 19:07:30.375647906 -0500
@@ -183,7 +183,7 @@
 			 * with the data written to write buffer
 			 * in the setup.
 			 */
-			compare_bufers(write_buf, read_buf);
+			compare_bufers();
 		} else {
 			tst_resm(TPASS, "calls to pread() succeeded");
 		}


--------------040006040401050403040104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
--------------040006040401050403040104
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------040006040401050403040104--

