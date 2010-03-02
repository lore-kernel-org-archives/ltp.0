Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <maxin.john@gmail.com>) id 1NmZTL-0001fT-1l
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 21:17:43 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NmZTI-00080v-Rd
	for ltp-list@lists.sourceforge.net; Tue, 02 Mar 2010 21:17:43 +0000
Received: by pwi5 with SMTP id 5so376868pwi.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 02 Mar 2010 13:17:35 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 3 Mar 2010 02:47:34 +0530
Message-ID: <9debc4411003021317p4b7a2872lb200d17726df24c4@mail.gmail.com>
From: Maxin John <maxin.john@gmail.com>
Content-Type: multipart/mixed; boundary=001636e0ab1afe00970480d7e4f1
Subject: [LTP] [PATCH] Makefile fix for 'createfile.c' build in
	network/tcp_cmds/echo
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
To: ltp-list@lists.sourceforge.net

--001636e0ab1afe00970480d7e4f1
Content-Type: text/plain; charset=ISO-8859-1

Hi,

I have observed that the 'createfile.c' in
testcases/network/tcp_cmds/echo directory is not getting compiled and
installed during the LTP build. The "echo_createfile.patch" makes the
necessary changes in the Makefile.

Signed-off-by: Maxin B. John <maxin.john@gmail.com>

Best Regards,
Maxin B. John

--001636e0ab1afe00970480d7e4f1
Content-Type: text/x-patch; charset=US-ASCII; name="echo_createfile.patch"
Content-Disposition: attachment; filename="echo_createfile.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g6b6wa980

ZGlmZiAtdU5yIGx0cC1mdWxsLTIwMTAwMjI4LW9yaWcvdGVzdGNhc2VzL25ldHdvcmsvdGNwX2Nt
ZHMvZWNoby9NYWtlZmlsZSBsdHAtZnVsbC0yMDEwMDIyOC90ZXN0Y2FzZXMvbmV0d29yay90Y3Bf
Y21kcy9lY2hvL01ha2VmaWxlCi0tLSBsdHAtZnVsbC0yMDEwMDIyOC1vcmlnL3Rlc3RjYXNlcy9u
ZXR3b3JrL3RjcF9jbWRzL2VjaG8vTWFrZWZpbGUJMjAxMC0wMy0wMSAyMDoyODoyOS4wMDAwMDAw
MDAgKzA1MzAKKysrIGx0cC1mdWxsLTIwMTAwMjI4L3Rlc3RjYXNlcy9uZXR3b3JrL3RjcF9jbWRz
L2VjaG8vTWFrZWZpbGUJMjAxMC0wMy0wMyAwMjoyNjo0MC4wMDAwMDAwMDAgKzA1MzAKQEAgLTI4
LDcgKzI4LDcgQEAKIAogSU5TVEFMTF9UQVJHRVRTCQk6PSBlY2hvMDEKIAotTUFLRV9UQVJHRVRT
CQk6PSBlY2hvZXMgZWNob2VzNgorTUFLRV9UQVJHRVRTCQk6PSBlY2hvZXMgZWNob2VzNiBjcmVh
dGVmaWxlCiAKICU2OiBDUFBGTEFHUyArPSAtRElORVQ2CiAK
--001636e0ab1afe00970480d7e4f1
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
--001636e0ab1afe00970480d7e4f1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--001636e0ab1afe00970480d7e4f1--

