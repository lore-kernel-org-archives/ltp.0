Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1Ri1ne-0008TA-Hj
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 10:40:58 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Ri1nd-00043m-Op
	for ltp-list@lists.sourceforge.net; Tue, 03 Jan 2012 10:40:58 +0000
Message-ID: <4F02DB32.1050503@imgtec.com>
Date: Tue, 3 Jan 2012 10:40:50 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <4F02CBDE.70400@imgtec.com>	<CAGH67wSFbMM+3Dr_pe=_+w_B4Su6p6wZ42LpP5vUwVE1hiH6QQ@mail.gmail.com>
	<4F02D122.7090704@imgtec.com>
In-Reply-To: <4F02D122.7090704@imgtec.com>
Content-Type: multipart/mixed; boundary="------------010901090407060205070504"
Subject: Re: [LTP] [PATCH 02/21] lib/self_exec: Remove extra argument from
 tst_resm function call
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

--------------010901090407060205070504
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 01/03/2012 09:57 AM, Markos Chandras wrote:
> On 01/03/2012 09:50 AM, Garrett Cooper wrote:
>> On Tue, Jan 3, 2012 at 1:35 AM, Markos Chandras
>> <Markos.Chandras@imgtec.com>   wrote:
>>> Hi, please review the attached patch
>>
>>       Converting the function to tst_brkm and removing the tst_exit call
>> below it would be better.
>> Thanks!
>> -Garrett
> Agreed, but to make this consistent, all the tst_resm&&  tst_exit pairs
> should be replaced with tst_brkm. I will prepare a patch
>
Here is a patch that converts all tst_resm && tst_exit calls to 
tst_brkm. Please review it.

-- 
markos

--------------010901090407060205070504
Content-Type: text/plain;
	name="0002-lib-self_exec-Convert-tst_resm-tst_exit-calls-to-tst.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-lib-self_exec-Convert-tst_resm-tst_exit-calls-to-tst.pa";
	filename*1="tch"

From 9259c9318e099c84291afaa1de5279dfb26a763d Mon Sep 17 00:00:00 2001
From: Markos Chandras <markos.chandras@imgtec.com>
Date: Thu, 22 Dec 2011 10:43:19 +0000
Subject: [PATCH 02/21] lib/self_exec: Convert tst_resm && tst_exit calls to tst_brkm

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 lib/self_exec.c |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)

diff --git a/lib/self_exec.c b/lib/self_exec.c
index a457468..abbfeb4 100644
--- a/lib/self_exec.c
+++ b/lib/self_exec.c
@@ -86,8 +86,7 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 
 	child_dir = strtok(args, ",");
 	if (strlen(child_dir) == 0) {
-	    tst_resm(TBROK, NULL, "Could not get directory from -C option");
-	    tst_exit();
+	    tst_brkm(TBROK, NULL, "Could not get directory from -C option");
 	}
 
 	va_start(ap, fmt);
@@ -95,8 +94,7 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 	for (p = fmt; *p; p++) {
 	    tok = strtok(NULL, ",");
 	    if (!tok || strlen(tok) == 0) {
-		tst_resm(TBROK, "Invalid argument to -C option");
-		tst_exit();
+		tst_brkm(TBROK, NULL, "Invalid argument to -C option");
 	    }
 
 	    switch (*p) {
@@ -104,8 +102,7 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 		iptr = va_arg(ap, int *);
 		i = strtol(tok, &endptr, 10);
 		if (*endptr != '\0') {
-		    tst_resm(TBROK, "Invalid argument to -C option");
-		    tst_exit();
+		    tst_brkm(TBROK, NULL, "Invalid argument to -C option");
 		}
 		*iptr = i;
 		break;
@@ -113,8 +110,7 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 		j = va_arg(ap, int);
 		i = strtol(tok, &endptr, 10);
 		if (*endptr != '\0') {
-		    tst_resm(TBROK, "Invalid argument to -C option");
-		    tst_exit();
+		    tst_brkm(TBROK, NULL, "Invalid argument to -C option");
 		}
 		if (j != i) {
 		    va_end(ap);
@@ -124,21 +120,18 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 	    case 's':
 		s = va_arg(ap, char *);
 		if (!strncpy(s, tok, strlen(tok)+1)) {
-		    tst_resm(TBROK, "Could not strncpy for -C option");
-		    tst_exit();
+		    tst_brkm(TBROK, NULL, "Could not strncpy for -C option");
 		}
 		break;
 	    case 'S':
 		sptr = va_arg(ap, char **);
 		*sptr = strdup(tok);
 		if (!*sptr) {
-		    tst_resm(TBROK, "Could not strdup for -C option");
-		    tst_exit();
+		    tst_brkm(TBROK, NULL, "Could not strdup for -C option");
 		}
 		break;
 	    default:
-		tst_resm(TBROK, "Format string option %c not implemented", *p);
-		tst_exit();
+		tst_brkm(TBROK, NULL, "Format string option %c not implemented", *p);
 		break;
 	    }
 	}
@@ -146,8 +139,7 @@ maybe_run_child(void (*child)(), char *fmt, ...)
 	va_end(ap);
 
 	if (chdir(child_dir) < 0) {
-	    tst_resm(TBROK, "Could not change to %s for child", child_dir);
-	    tst_exit();
+	    tst_brkm(TBROK, "Could not change to %s for child", child_dir);
 	}
 
 	(*child)();
@@ -215,4 +207,4 @@ self_exec(char *argv0, char *fmt, ...)
     return execlp(argv0, argv0, "-C", arg, (char *) NULL);
 }
 
-#endif /* UCLINUX */
\ No newline at end of file
+#endif /* UCLINUX */
-- 
1.7.1


--------------010901090407060205070504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Write once. Port to many.
Get the SDK and tools to simplify cross-platform app development. Create 
new or port existing apps to sell to consumers worldwide. Explore the 
Intel AppUpSM program developer opportunity. appdeveloper.intel.com/join
http://p.sf.net/sfu/intel-appdev
--------------010901090407060205070504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010901090407060205070504--


