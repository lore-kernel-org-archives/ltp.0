Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <liubo2009@cn.fujitsu.com>) id 1N9xL0-0007Bq-0g
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:53:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N9xKt-0001MU-1e
	for ltp-list@lists.sourceforge.net; Mon, 16 Nov 2009 08:53:29 +0000
Message-ID: <4B01131D.8090604@cn.fujitsu.com>
Date: Mon, 16 Nov 2009 16:53:49 +0800
From: liubo <liubo2009@cn.fujitsu.com>
MIME-Version: 1.0
References: <4AF137E8.3090408@cn.fujitsu.com>	
	<4AFCB13D.9040203@cn.fujitsu.com>
	<1258359222.5677.34.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1258359222.5677.34.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] mail: fix the bug of mail01
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3650250979776393610=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============3650250979776393610==
Content-Type: multipart/alternative;
	boundary="------------080401060309080501010704"

This is a multi-part message in MIME format.
--------------080401060309080501010704
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi, Subrata,
On 11/16/2009 04:13 PM, Subrata Modak wrote:
> On Fri, 2009-11-13 at 09:07 +0800, liubo wrote: 
>   
>> Hi, Subrata,
>>
>> On 11/04/2009 04:14 PM, liubo wrote:
>>     
>>> In the testcase "mail01",
>>>
>>> when mail is send to nosuchuser@domain
>>> and mail is send to user@nosuchdomain,
>>> mail program may return either "Returnedmail:"
>>> or "UndeliveredMailReturned", regardless of
>>> the existence of /etc/redhat-release.
>>>
>>> So, we did a bit of changes to recongnize both of
>>> returned values.
>>>
>>> This patch fixes the problem.
>>>
>>> Signed-off-by: Liu Bo <liubo2009@cn.fujitsu.com>
>>>   
>>>       
>> Is there any problem about this patch?
>>     
>
> Hey, i missed this. Not able to find it in my mailbox also. Can you
> please resend it ?
>
>   

Ok, I will.

> Regards--
> Subrata
>
>   
>>> ---
>>>  testcases/commands/mail/mail_tests.sh |   65 ++++++++++++++++-----------------
>>>  1 files changed, 31 insertions(+), 34 deletions(-)
>>>
>>> diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
>>> index 45bac93..024120f 100755
>>> --- a/testcases/commands/mail/mail_tests.sh
>>> +++ b/testcases/commands/mail/mail_tests.sh
>>> @@ -172,28 +172,27 @@ else
>>>      echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
>>>      RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
>>>  	$LTPTMP/tst_mail.res)
>>> -    RC2=$(awk '/^>N/ {print match($9 $10 $11, "Maildeliveryfailed:")}' \
>>> -        $LTPTMP/tst_mail.res)
>>> -#####
>>> -# Some mailers (e.g., Red Hat's sendmail) print different messages 
>>> -#####
>>> -if [ -f /etc/redhat-release ] 
>>> -then 
>>> -  [ -z "$RC2" -o "X$RC2" = "X0" ] && \
>>> +##################################################################
>>> +# In this testcase, mail will get "Returnedmail:", while mailx will
>>> +# get "UndeliveredMailReturned:".
>>> +# Either of mail and mailx may be linked to another.
>>> +# For example,
>>> +# /bin/mail -> /bin/mailx
>>> +# or
>>> +# /bin/mailx -> /bin/mail
>>> +##################################################################
>>>       RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
>>>               $LTPTMP/tst_mail.res)
>>> -else 
>>> -  [ -z "$RC2" -o "X$RC2" = "X0" ] && \
>>> -     RC2=$(awk '/^>N/ {print match($9 $10 $11, "UndeliveredMailReturned")}' \
>>> +     RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
>>>               $LTPTMP/tst_mail.res)
>>>  fi 
>>> -    if [ -z "$RC1" -a -z "$RC2" ]
>>> +    if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
>>>      then
>>>          $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
>>>          "Test #2: No new mail for root. Reason:"
>>>          TFAILCNT=$(( $TFAILCNT+1 ))
>>>      else
>>> -        if [ $RC1 -ne 0 -a $RC2 -ne 0 ]
>>> +        if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]
>>>          then
>>>              $LTPBIN/tst_resm TPASS \
>>>                  "Test #2: Mailer-Deamon reported delivery failure"
>>> @@ -203,7 +202,6 @@ fi
>>>              TFAILCNT=$(( $TFAILCNT+1 ))
>>>          fi
>>>      fi
>>> -fi
>>>  else
>>>      $LTPBIN/tst_resm TCONF "mail command not installed"
>>>  fi    
>>> @@ -242,29 +240,28 @@ else
>>>      echo "d" | mail -u root > $LTPTMP/tst_mail.res 2>&1
>>>      RC1=$(awk '/^>N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
>>>  	$LTPTMP/tst_mail.res)
>>> -    RC2=$(awk '/^>N/ {print match($9 $10 $11, "Maildeliveryfailed:")}' \
>>> -        $LTPTMP/tst_mail.res)
>>> -#####
>>> -# Some mailers (e.g., Red Hat's sendmail) print different messages 
>>> -#####
>>> -if [ -f /etc/redhat-release ] 
>>> -then 
>>> -   [ -z "$RC2" -o "X$RC2" = "X0" ] && \
>>> -      RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
>>> -              $LTPTMP/tst_mail.res)
>>> -else 
>>> -    [ -z "$RC2" -o "X$RC2" = "X0" ] && \
>>> -        RC2=$(awk '/^>N/ {print match($9 $10 $11, "UndeliveredMailReturned")}' \
>>> -                $LTPTMP/tst_mail.res)
>>> -fi 
>>> -    if [ -z "$RC1" -a -z "$RC2" ]
>>> +##################################################################
>>> +# In this testcase, mail will get "Returnedmail:", while mailx will
>>> +# get "UndeliveredMailReturned:".
>>> +# Either of mail and mailx may be linked to another.
>>> +# For example,
>>> +# /bin/mail -> /bin/mailx
>>> +# or
>>> +# /bin/mailx -> /bin/mail
>>> +##################################################################
>>> +     RC2=$(awk '/^>N/ {print match($9 $10, "Returnedmail:")}' \
>>> +             $LTPTMP/tst_mail.res)
>>> +     RC3=$(awk '/^>N/ {print match($9 $10, "UndeliveredMail")}' \
>>> +             $LTPTMP/tst_mail.res)
>>> +fi
>>> +    if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
>>>      then
>>>          $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
>>> -        "Test #3: No new mail for root. Reason:"
>>> +        "Test #2: No new mail for root. Reason:"
>>>          TFAILCNT=$(( $TFAILCNT+1 ))
>>>      else
>>> -        if [ $RC1 -ne 0 -a $RC2 -ne 0 ]
>>> -        then
>>> +        if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]
>>> +	then
>>>              $LTPBIN/tst_resm TPASS \
>>>                  "Test #3: Mailer-Deamon reported delivery failure"
>>>          else
>>> @@ -273,7 +270,7 @@ fi
>>>              TFAILCNT=$(( $TFAILCNT+1 ))
>>>          fi
>>>      fi
>>> -fi
>>> +
>>>  else
>>>      $LTPBIN/tst_resm TCONF "mail command not installed"
>>>  fi
>>>   
>>>       
>
>
>
>   


--------------080401060309080501010704
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html; charset=ISO-8859-1"
 http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hi, Subrata,<br>
On 11/16/2009 04:13 PM, Subrata Modak wrote:
<blockquote
 cite="mid:1258359222.5677.34.camel@subratamodak.linux.ibm.com"
 type="cite">
  <pre wrap="">On Fri, 2009-11-13 at 09:07 +0800, liubo wrote: 
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi, Subrata,

On 11/04/2009 04:14 PM, liubo wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">In the testcase "mail01",

when mail is send to nosuchuser@domain
and mail is send to user@nosuchdomain,
mail program may return either "Returnedmail:"
or "UndeliveredMailReturned", regardless of
the existence of /etc/redhat-release.

So, we did a bit of changes to recongnize both of
returned values.

This patch fixes the problem.

Signed-off-by: Liu Bo <a class="moz-txt-link-rfc2396E" href="mailto:liubo2009@cn.fujitsu.com">&lt;liubo2009@cn.fujitsu.com&gt;</a>
  
      </pre>
    </blockquote>
    <pre wrap="">Is there any problem about this patch?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Hey, i missed this. Not able to find it in my mailbox also. Can you
please resend it ?

  </pre>
</blockquote>
<br>
Ok, I will.<br>
<br>
<blockquote
 cite="mid:1258359222.5677.34.camel@subratamodak.linux.ibm.com"
 type="cite">
  <pre wrap="">Regards--
Subrata

  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">---
 testcases/commands/mail/mail_tests.sh |   65 ++++++++++++++++-----------------
 1 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/testcases/commands/mail/mail_tests.sh b/testcases/commands/mail/mail_tests.sh
index 45bac93..024120f 100755
--- a/testcases/commands/mail/mail_tests.sh
+++ b/testcases/commands/mail/mail_tests.sh
@@ -172,28 +172,27 @@ else
     echo "d" | mail -u root &gt; $LTPTMP/tst_mail.res 2&gt;&amp;1
     RC1=$(awk '/^&gt;N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 	$LTPTMP/tst_mail.res)
-    RC2=$(awk '/^&gt;N/ {print match($9 $10 $11, "Maildeliveryfailed:")}' \
-        $LTPTMP/tst_mail.res)
-#####
-# Some mailers (e.g., Red Hat's sendmail) print different messages 
-#####
-if [ -f /etc/redhat-release ] 
-then 
-  [ -z "$RC2" -o "X$RC2" = "X0" ] &amp;&amp; \
+##################################################################
+# In this testcase, mail will get "Returnedmail:", while mailx will
+# get "UndeliveredMailReturned:".
+# Either of mail and mailx may be linked to another.
+# For example,
+# /bin/mail -&gt; /bin/mailx
+# or
+# /bin/mailx -&gt; /bin/mail
+##################################################################
      RC2=$(awk '/^&gt;N/ {print match($9 $10, "Returnedmail:")}' \
              $LTPTMP/tst_mail.res)
-else 
-  [ -z "$RC2" -o "X$RC2" = "X0" ] &amp;&amp; \
-     RC2=$(awk '/^&gt;N/ {print match($9 $10 $11, "UndeliveredMailReturned")}' \
+     RC3=$(awk '/^&gt;N/ {print match($9 $10, "UndeliveredMail")}' \
              $LTPTMP/tst_mail.res)
 fi 
-    if [ -z "$RC1" -a -z "$RC2" ]
+    if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then
         $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
         "Test #2: No new mail for root. Reason:"
         TFAILCNT=$(( $TFAILCNT+1 ))
     else
-        if [ $RC1 -ne 0 -a $RC2 -ne 0 ]
+        if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]
         then
             $LTPBIN/tst_resm TPASS \
                 "Test #2: Mailer-Deamon reported delivery failure"
@@ -203,7 +202,6 @@ fi
             TFAILCNT=$(( $TFAILCNT+1 ))
         fi
     fi
-fi
 else
     $LTPBIN/tst_resm TCONF "mail command not installed"
 fi    
@@ -242,29 +240,28 @@ else
     echo "d" | mail -u root &gt; $LTPTMP/tst_mail.res 2&gt;&amp;1
     RC1=$(awk '/^&gt;N/ {IGNORECASE=1; print match($3, "Mailer-Daemon")}' \
 	$LTPTMP/tst_mail.res)
-    RC2=$(awk '/^&gt;N/ {print match($9 $10 $11, "Maildeliveryfailed:")}' \
-        $LTPTMP/tst_mail.res)
-#####
-# Some mailers (e.g., Red Hat's sendmail) print different messages 
-#####
-if [ -f /etc/redhat-release ] 
-then 
-   [ -z "$RC2" -o "X$RC2" = "X0" ] &amp;&amp; \
-      RC2=$(awk '/^&gt;N/ {print match($9 $10, "Returnedmail:")}' \
-              $LTPTMP/tst_mail.res)
-else 
-    [ -z "$RC2" -o "X$RC2" = "X0" ] &amp;&amp; \
-        RC2=$(awk '/^&gt;N/ {print match($9 $10 $11, "UndeliveredMailReturned")}' \
-                $LTPTMP/tst_mail.res)
-fi 
-    if [ -z "$RC1" -a -z "$RC2" ]
+##################################################################
+# In this testcase, mail will get "Returnedmail:", while mailx will
+# get "UndeliveredMailReturned:".
+# Either of mail and mailx may be linked to another.
+# For example,
+# /bin/mail -&gt; /bin/mailx
+# or
+# /bin/mailx -&gt; /bin/mail
+##################################################################
+     RC2=$(awk '/^&gt;N/ {print match($9 $10, "Returnedmail:")}' \
+             $LTPTMP/tst_mail.res)
+     RC3=$(awk '/^&gt;N/ {print match($9 $10, "UndeliveredMail")}' \
+             $LTPTMP/tst_mail.res)
+fi
+    if [ -z "$RC1" -a -z "$RC2" -a -z "$RC3" ]
     then
         $LTPBIN/tst_res TFAIL $LTPTMP/tst_mail.res \
-        "Test #3: No new mail for root. Reason:"
+        "Test #2: No new mail for root. Reason:"
         TFAILCNT=$(( $TFAILCNT+1 ))
     else
-        if [ $RC1 -ne 0 -a $RC2 -ne 0 ]
-        then
+        if [ $RC1 -ne 0 -a $RC2 -ne 0 ] || [ $RC1 -ne 0 -a $RC3 -ne 0 ]
+	then
             $LTPBIN/tst_resm TPASS \
                 "Test #3: Mailer-Deamon reported delivery failure"
         else
@@ -273,7 +270,7 @@ fi
             TFAILCNT=$(( $TFAILCNT+1 ))
         fi
     fi
-fi
+
 else
     $LTPBIN/tst_resm TCONF "mail command not installed"
 fi
  
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->


  </pre>
</blockquote>
<br>
</body>
</html>

--------------080401060309080501010704--


--===============3650250979776393610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
--===============3650250979776393610==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============3650250979776393610==--

