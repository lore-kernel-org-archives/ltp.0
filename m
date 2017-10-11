From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 11 Oct 2017 17:23:24 +0800
Subject: [LTP] [PATCH] commands/mail: Fix a mismatched sender name in
	mail0[23]
Message-ID: <1507713804-8732-1-git-send-email-yangx.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

In some systems (e.g. debain), both mail02 and mail03 fail because the
sender name of the returned letter is "Mail Deliver Syst" which does
not match existed keywords.  we add the 'Syst' keyword to fix it.

Signed-off-by: Shaoting Lei <leist.fnst@cn.fujitsu.com>
Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
---
 testcases/commands/mail/mail_tests.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 1652aa7..aaf73ef 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -169,8 +169,8 @@ else
 		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 		    $LTPTMP/tst_mail.res)
 	else
-		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDelivery(Subsys|System)")}' \
-		    $LTPTMP/tst_mail.res)
+		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5,
+		    "MailDelivery(Subsys|Systemi|Syst)")}' $LTPTMP/tst_mail.res)
 	fi
 
 	##################################################################
@@ -250,8 +250,8 @@ else
 		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 		    $LTPTMP/tst_mail.res)
 	else
-		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5, "MailDelivery(Subsys|System)")}' \
-		    $LTPTMP/tst_mail.res)
+		RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3 $4 $5,
+		    "MailDelivery(Subsys|System|Syst)")}' $LTPTMP/tst_mail.res)
 	fi
 	##################################################################
 	# In this testcase, mail will get "Returnedmail:", while mailx will
-- 
1.8.3.1



