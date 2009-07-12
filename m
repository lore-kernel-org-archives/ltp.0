Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MPqI9-0007Nz-VL
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 04:03:57 +0000
Received: from wf-out-1314.google.com ([209.85.200.168])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MPqI1-0002wB-OG
	for ltp-list@lists.sourceforge.net; Sun, 12 Jul 2009 04:03:57 +0000
Received: by wf-out-1314.google.com with SMTP id 26so526156wfd.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 11 Jul 2009 21:03:49 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 11 Jul 2009 21:03:49 -0700
Message-ID: <364299f40907112103h3b0864a0l1e1c203a77c5476e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Content-Type: multipart/mixed; boundary=000e0cd18264f0c78f046e7a4ab7
Subject: [LTP] [PATCH] Fix shadowed declaration of basename(3) in
	testcases/kernel/fs/fsx-linux/fsx-linux.c
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

--000e0cd18264f0c78f046e7a4ab7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This is the 21st century, and yes we have a basename(3) libcall in
string.h. This attached patch fixes that so -Wshadow passes:

Signed-off-by: Garrett Cooper <yanegomi@gmail.com>

Index: testcases/kernel/fs/fsx-linux/fsx-linux.c
===================================================================
RCS file: /cvsroot/ltp/ltp/testcases/kernel/fs/fsx-linux/fsx-linux.c,v
retrieving revision 1.12
diff -r1.12 fsx-linux.c
449,455d448
< static const char *basename(const char *path)
< {
<       char *c = strrchr(path, '/');
<
<       return c ? c++ : path;
< }
<

--000e0cd18264f0c78f046e7a4ab7
Content-Type: application/octet-stream; name="fix_basename_decl.diff"
Content-Disposition: attachment; filename="fix_basename_decl.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fx18oyqj0

SW5kZXg6IHRlc3RjYXNlcy9rZXJuZWwvZnMvZnN4LWxpbnV4L2ZzeC1saW51eC5jCj09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KUkNTIGZpbGU6IC9jdnNyb290L2x0cC9sdHAvdGVzdGNhc2VzL2tlcm5lbC9mcy9mc3gtbGlu
dXgvZnN4LWxpbnV4LmMsdgpyZXRyaWV2aW5nIHJldmlzaW9uIDEuMTIKZGlmZiAtcjEuMTIgZnN4
LWxpbnV4LmMKNDQ5LDQ1NWQ0NDgKPCBzdGF0aWMgY29uc3QgY2hhciAqYmFzZW5hbWUoY29uc3Qg
Y2hhciAqcGF0aCkKPCB7CjwgCWNoYXIgKmMgPSBzdHJyY2hyKHBhdGgsICcvJyk7CjwgCjwgCXJl
dHVybiBjID8gYysrIDogcGF0aDsKPCB9CjwgCg==
--000e0cd18264f0c78f046e7a4ab7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
--000e0cd18264f0c78f046e7a4ab7
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--000e0cd18264f0c78f046e7a4ab7--

