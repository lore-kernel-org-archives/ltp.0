Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSCXo-00018Z-3B
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 16:46:08 +0000
Received: from mail-yw0-f176.google.com ([209.85.211.176])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSCXn-0001It-4L
	for ltp-list@lists.sourceforge.net; Tue, 05 Jan 2010 16:46:08 +0000
Received: by ywh6 with SMTP id 6so16545889ywh.4
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 08:46:01 -0800 (PST)
References: <20100104171643.GA545@us.ibm.com>
	<D107C512-245B-4187-9A8D-7FDC28234A0D@gmail.com>
	<20100104233622.GA9018@us.ibm.com>
	<AA968A69-C9C7-4FC1-B4B5-849719CCB8E8@gmail.com>
	<20100105153021.GA11873@us.ibm.com>
Message-Id: <948507EC-6E01-4C79-A497-0425B44863CA@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <20100105153021.GA11873@us.ibm.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Tue, 5 Jan 2010 09:45:36 -0700
Subject: Re: [LTP] [PATCH 1/1] say FAIL not PASS when we failed
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
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Sent from my iPhone

On Jan 5, 2010, at 8:30 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:

> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On Jan 4, 2010, at 3:36 PM, "Serge E. Hallyn" <serue@us.ibm.com>  
>> wrote:
>>
>>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>>> On Jan 4, 2010, at 9:16 AM, "Serge E. Hallyn" <serue@us.ibm.com>
>>>> wrote:
>>>>
>>>>> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
>>>>> ---
>>>>> testcases/kernel/security/p9auth/p9priv.sh |    2 +-
>>>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>
>>>>> diff --git a/testcases/kernel/security/p9auth/p9priv.sh
>>>>> b/testcases/kernel/security/p9auth/p9priv.sh
>>>>> index ad2eead..c1a14d0 100755
>>>>> --- a/testcases/kernel/security/p9auth/p9priv.sh
>>>>> +++ b/testcases/kernel/security/p9auth/p9priv.sh
>>>>> @@ -101,7 +101,7 @@ while [ ! -f $LTPTMP/d/childready ]; do :;  
>>>>> done
>>>>> touch $LTPTMP/childgo
>>>>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do
>>>>> :; done;
>>>>> if [ -f $LTPTMP/d/childpass ]; then
>>>>> -    echo "PASS: child could setuid from wrong source uid"
>>>>> +    echo "FAIL: child could setuid from wrong source uid"
>>>>> exit 1
>>>>> fi
>>>>> echo "PASS: child couldn't setuid from wrong source uid"
>>>>> -- 
>>>>> 1.6.1.1
>>>>
>>>> Is there a reason why this isn't using tst_resm?
>>>
>>> No good reason
>>
>> Could this be converted then :)?
>
> This appears to work.
>
> thanks,
> -serge
>
> From 05713db9e0db910fa2fdfa85c452f0be8d820e8c Mon Sep 17 00:00:00 2001
> From: Serge E. Hallyn <serue@us.ibm.com>
> Date: Tue, 5 Jan 2010 10:30:11 -0500
> Subject: [PATCH 1/1] p9auth: use tst_resm
>
> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
> ---
> testcases/kernel/security/p9auth/p9priv.sh   |   25 +++++++++++++++ 
> +---------
> testcases/kernel/security/p9auth/p9unpriv.sh |    2 +-
> 2 files changed, 17 insertions(+), 10 deletions(-)
>
> diff --git a/testcases/kernel/security/p9auth/p9priv.sh b/testcases/ 
> kernel/security/p9auth/p9priv.sh
> index c1a14d0..0f3ea7e 100755
> --- a/testcases/kernel/security/p9auth/p9priv.sh
> +++ b/testcases/kernel/security/p9auth/p9priv.sh
> @@ -19,7 +19,12 @@
> ##  
>     
>     
>                                                                       
> ##
> ### 
> ### 
> ### 
> ### 
> ####################################################################
>
> -LTPTMP=/tmp/p9auth_ltp
> +export LTPTMP=/tmp/p9auth_ltp
> +export TST_TOTAL=3
> +export TCID="p9auth"
> +
> +export TST_COUNT=1
> +
> rm -rf $LTPTMP
> mkdir $LTPTMP
> chmod 755 $LTPTMP
> @@ -37,14 +42,14 @@ cleanup() {
> }
>
> if [ `id -u` -ne 0 ]; then
> -    echo "Must start p9auth tests as root"
> +    tst_resm TBROK "Must start p9auth tests as root"
>    exit 1
> fi
>
> ltpuid=`grep ltp /etc/passwd | head -1 | awk -F: '{ print $3 '}`
> ret=$?
> if [ $? -ne 0 ]; then
> -    echo "Failed to find ltp userid"
> +    tst_resm TCONF "Failed to find ltp userid"
>    exit 1
> fi
>
> @@ -57,12 +62,13 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
> touch $LTPTMP/childgo
> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ];  
> do :; done;
> if [ -f $LTPTMP/d/childpass ]; then
> -    echo "FAIL: child could setuid with bad hash"
> +    tst_resm TFAIL "FAIL: child could setuid with bad hash"
>    exit 1
> fi
> -echo "PASS: child couldn't setuid with bad hash"
> +tst_resm TPASS "PASS: child couldn't setuid with bad hash"
>
> # TEST 2: ltp setuids to 0 with valid hash
> +export TST_COUNT=2
>
> # create the hash.  randstr doesn't have to be int, but it's ok
> cleanup
> @@ -80,12 +86,13 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
> touch $LTPTMP/childgo
> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ];  
> do :; done;
> if [ -f $LTPTMP/d/childfail ]; then
> -    echo "FAIL: child couldn't setuid with good hash"
> +    tst_resm TFAIL "FAIL: child couldn't setuid with good hash"
>    exit 1
> fi
> -echo "PASS: child could setuid with good hash"
> +tst_resm TPASS "PASS: child could setuid with good hash"
>
> # TEST 3: 0 setuids to 0 with hash valid for ltp user
> +export TST_COUNT=3
> cleanup
> randstr=$RANDOM
> txt="0@0"
> @@ -101,10 +108,10 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
> touch $LTPTMP/childgo
> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ];  
> do :; done;
> if [ -f $LTPTMP/d/childpass ]; then
> -    echo "FAIL: child could setuid from wrong source uid"
> +    tst_resm TFAIL "FAIL: child could setuid from wrong source uid"
>    exit 1
> fi
> -echo "PASS: child couldn't setuid from wrong source uid"
> +tst_resm TPASS "PASS: child couldn't setuid from wrong source uid"
>
> touch $LTPTMP/childexit
>
> diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh b/ 
> testcases/kernel/security/p9auth/p9unpriv.sh
> index 077b8ac..894b3c4 100755
> --- a/testcases/kernel/security/p9auth/p9unpriv.sh
> +++ b/testcases/kernel/security/p9auth/p9unpriv.sh
> @@ -27,7 +27,7 @@ echo ltptmp is $LTPTMP
>
> myuid=`id -u`
> if [ "$myuid" -eq 0 ]; then
> -    echo "Unprivileged child was started as root!"
> +    tst_resm TBROK "Unprivileged child was started as root!"
>    exit 1
> fi
>
> -- 
> 1.6.1.1

The patch is very close. /tmp -> TMPDIR=${TMPDIR:-/tmp} will do the  
trick.
Also, eith the new changes PASS: / FAIL: shouldn't be required because  
the result is inline with the printout.
Thanks!
-Garrett

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
