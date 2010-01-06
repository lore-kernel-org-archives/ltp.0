Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NSM1c-000214-57
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 02:53:32 +0000
Received: from mail-px0-f200.google.com ([209.85.216.200])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NSM1Z-0007Uk-M8
	for ltp-list@lists.sourceforge.net; Wed, 06 Jan 2010 02:53:32 +0000
Received: by pxi38 with SMTP id 38so6085760pxi.28
	for <ltp-list@lists.sourceforge.net>;
	Tue, 05 Jan 2010 18:53:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0921C697-823F-42DE-98CB-D99C9903323A@gmail.com>
References: <20100104171643.GA545@us.ibm.com>
	<D107C512-245B-4187-9A8D-7FDC28234A0D@gmail.com>
	<20100104233622.GA9018@us.ibm.com>
	<AA968A69-C9C7-4FC1-B4B5-849719CCB8E8@gmail.com>
	<20100105153021.GA11873@us.ibm.com>
	<948507EC-6E01-4C79-A497-0425B44863CA@gmail.com>
	<20100105173325.GA5204@us.ibm.com>
	<0921C697-823F-42DE-98CB-D99C9903323A@gmail.com>
Date: Tue, 5 Jan 2010 18:53:24 -0800
Message-ID: <364299f41001051853n3d95e1b8hd2cdabca77ad59ef@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Jan 5, 2010 at 9:46 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
> Sent from my iPhone
>
> On Jan 5, 2010, at 10:33 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
>
>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>>
>>> Sent from my iPhone
>>>
>>> On Jan 5, 2010, at 8:30 AM, "Serge E. Hallyn" <serue@us.ibm.com> wrote:
>>>
>>>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>>>>
>>>>> On Jan 4, 2010, at 3:36 PM, "Serge E. Hallyn" <serue@us.ibm.com>
>>>>> wrote:
>>>>>
>>>>>> Quoting Garrett Cooper (yanegomi@gmail.com):
>>>>>>>
>>>>>>> On Jan 4, 2010, at 9:16 AM, "Serge E. Hallyn" <serue@us.ibm.com>
>>>>>>> wrote:
>>>>>>>
>>>>>>>> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
>>>>>>>> ---
>>>>>>>> testcases/kernel/security/p9auth/p9priv.sh | =A0 =A02 +-
>>>>>>>> 1 files changed, 1 insertions(+), 1 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/testcases/kernel/security/p9auth/p9priv.sh
>>>>>>>> b/testcases/kernel/security/p9auth/p9priv.sh
>>>>>>>> index ad2eead..c1a14d0 100755
>>>>>>>> --- a/testcases/kernel/security/p9auth/p9priv.sh
>>>>>>>> +++ b/testcases/kernel/security/p9auth/p9priv.sh
>>>>>>>> @@ -101,7 +101,7 @@ while [ ! -f $LTPTMP/d/childready ];
>>>>>>>> do :; done
>>>>>>>> touch $LTPTMP/childgo
>>>>>>>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do
>>>>>>>> :; done;
>>>>>>>> if [ -f $LTPTMP/d/childpass ]; then
>>>>>>>> - =A0 =A0echo "PASS: child could setuid from wrong source uid"
>>>>>>>> + =A0 =A0echo "FAIL: child could setuid from wrong source uid"
>>>>>>>> exit 1
>>>>>>>> fi
>>>>>>>> echo "PASS: child couldn't setuid from wrong source uid"
>>>>>>>> --
>>>>>>>> 1.6.1.1
>>>>>>>
>>>>>>> Is there a reason why this isn't using tst_resm?
>>>>>>
>>>>>> No good reason
>>>>>
>>>>> Could this be converted then :)?
>>>>
>>>> This appears to work.
>>>>
>>>> thanks,
>>>> -serge
>>>>
>>>> From 05713db9e0db910fa2fdfa85c452f0be8d820e8c Mon Sep 17 00:00:00 2001
>>>> From: Serge E. Hallyn <serue@us.ibm.com>
>>>> Date: Tue, 5 Jan 2010 10:30:11 -0500
>>>> Subject: [PATCH 1/1] p9auth: use tst_resm
>>>>
>>>> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
>>>> ---
>>>> testcases/kernel/security/p9auth/p9priv.sh =A0 | =A0 25
>>>> ++++++++++++++++---------
>>>> testcases/kernel/security/p9auth/p9unpriv.sh | =A0 =A02 +-
>>>> 2 files changed, 17 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/testcases/kernel/security/p9auth/p9priv.sh
>>>> b/testcases/kernel/security/p9auth/p9priv.sh
>>>> index c1a14d0..0f3ea7e 100755
>>>> --- a/testcases/kernel/security/p9auth/p9priv.sh
>>>> +++ b/testcases/kernel/security/p9auth/p9priv.sh
>>>> @@ -19,7 +19,12 @@
>>>> ##
>>>> ##
>>>> ############
>>>> ####################################################################
>>>>
>>>> -LTPTMP=3D/tmp/p9auth_ltp
>>>> +export LTPTMP=3D/tmp/p9auth_ltp
>>>> +export TST_TOTAL=3D3
>>>> +export TCID=3D"p9auth"
>>>> +
>>>> +export TST_COUNT=3D1
>>>> +
>>>> rm -rf $LTPTMP
>>>> mkdir $LTPTMP
>>>> chmod 755 $LTPTMP
>>>> @@ -37,14 +42,14 @@ cleanup() {
>>>> }
>>>>
>>>> if [ `id -u` -ne 0 ]; then
>>>> - =A0 =A0echo "Must start p9auth tests as root"
>>>> + =A0 =A0tst_resm TBROK "Must start p9auth tests as root"
>>>> =A0exit 1
>>>> fi
>>>>
>>>> ltpuid=3D`grep ltp /etc/passwd | head -1 | awk -F: '{ print $3 '}`
>>>> ret=3D$?
>>>> if [ $? -ne 0 ]; then
>>>> - =A0 =A0echo "Failed to find ltp userid"
>>>> + =A0 =A0tst_resm TCONF "Failed to find ltp userid"
>>>> =A0exit 1
>>>> fi
>>>>
>>>> @@ -57,12 +62,13 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
>>>> touch $LTPTMP/childgo
>>>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do
>>>> :; done;
>>>> if [ -f $LTPTMP/d/childpass ]; then
>>>> - =A0 =A0echo "FAIL: child could setuid with bad hash"
>>>> + =A0 =A0tst_resm TFAIL "FAIL: child could setuid with bad hash"
>>>> =A0exit 1
>>>> fi
>>>> -echo "PASS: child couldn't setuid with bad hash"
>>>> +tst_resm TPASS "PASS: child couldn't setuid with bad hash"
>>>>
>>>> # TEST 2: ltp setuids to 0 with valid hash
>>>> +export TST_COUNT=3D2
>>>>
>>>> # create the hash. =A0randstr doesn't have to be int, but it's ok
>>>> cleanup
>>>> @@ -80,12 +86,13 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
>>>> touch $LTPTMP/childgo
>>>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do
>>>> :; done;
>>>> if [ -f $LTPTMP/d/childfail ]; then
>>>> - =A0 =A0echo "FAIL: child couldn't setuid with good hash"
>>>> + =A0 =A0tst_resm TFAIL "FAIL: child couldn't setuid with good hash"
>>>> =A0exit 1
>>>> fi
>>>> -echo "PASS: child could setuid with good hash"
>>>> +tst_resm TPASS "PASS: child could setuid with good hash"
>>>>
>>>> # TEST 3: 0 setuids to 0 with hash valid for ltp user
>>>> +export TST_COUNT=3D3
>>>> cleanup
>>>> randstr=3D$RANDOM
>>>> txt=3D"0@0"
>>>> @@ -101,10 +108,10 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
>>>> touch $LTPTMP/childgo
>>>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do
>>>> :; done;
>>>> if [ -f $LTPTMP/d/childpass ]; then
>>>> - =A0 =A0echo "FAIL: child could setuid from wrong source uid"
>>>> + =A0 =A0tst_resm TFAIL "FAIL: child could setuid from wrong source ui=
d"
>>>> =A0exit 1
>>>> fi
>>>> -echo "PASS: child couldn't setuid from wrong source uid"
>>>> +tst_resm TPASS "PASS: child couldn't setuid from wrong source uid"
>>>>
>>>> touch $LTPTMP/childexit
>>>>
>>>> diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh b/
>>>> testcases/kernel/security/p9auth/p9unpriv.sh
>>>> index 077b8ac..894b3c4 100755
>>>> --- a/testcases/kernel/security/p9auth/p9unpriv.sh
>>>> +++ b/testcases/kernel/security/p9auth/p9unpriv.sh
>>>> @@ -27,7 +27,7 @@ echo ltptmp is $LTPTMP
>>>>
>>>> myuid=3D`id -u`
>>>> if [ "$myuid" -eq 0 ]; then
>>>> - =A0 =A0echo "Unprivileged child was started as root!"
>>>> + =A0 =A0tst_resm TBROK "Unprivileged child was started as root!"
>>>> =A0exit 1
>>>> fi
>>>>
>>>> --
>>>> 1.6.1.1
>>>
>>> The patch is very close. /tmp -> TMPDIR=3D${TMPDIR:-/tmp} will do the
>>> trick.
>>> Also, eith the new changes PASS: / FAIL: shouldn't be required
>>> because the result is inline with the printout.
>>> Thanks!
>>> -Garrett
>>
>> New version. =A0(Hope I understood what you meant with tmpdir
>> correctly - and you don't mind me using a subdir of it)
>>
>> thanks,
>> -serge
>>
>> From 85401ac7279276eb46852ba828dc9f0ef2d62873 Mon Sep 17 00:00:00 2001
>> From: Serge E. Hallyn <serue@us.ibm.com>
>> Date: Tue, 5 Jan 2010 10:30:11 -0500
>> Subject: [PATCH 1/1] p9auth: use tst_resm
>>
>> Changelog:
>> =A0 Jan 5: Use ltp's TMPDIR, and don't print redundant 'PASS/FAIL'
>>
>> Signed-off-by: Serge E. Hallyn <serue@us.ibm.com>
>> ---
>> testcases/kernel/security/p9auth/p9priv.sh =A0 | =A0 26
>> +++++++++++++++++---------
>> testcases/kernel/security/p9auth/p9unpriv.sh | =A0 =A05 +++--
>> 2 files changed, 20 insertions(+), 11 deletions(-)
>>
>> diff --git a/testcases/kernel/security/p9auth/p9priv.sh
>> b/testcases/kernel/security/p9auth/p9priv.sh
>> index c1a14d0..6738600 100755
>> --- a/testcases/kernel/security/p9auth/p9priv.sh
>> +++ b/testcases/kernel/security/p9auth/p9priv.sh
>> @@ -19,7 +19,13 @@
>> ##
>> ##
>>
>> ########################################################################=
########
>>
>> -LTPTMP=3D/tmp/p9auth_ltp
>> +export TMPDIR=3D${TMPDIR:-/tmp}
>> +export LTPTMP=3D${TMPDIR}/p9auth_ltp
>> +export TST_TOTAL=3D3
>> +export TCID=3D"p9auth"
>> +
>> +export TST_COUNT=3D1
>> +
>> rm -rf $LTPTMP
>> mkdir $LTPTMP
>> chmod 755 $LTPTMP
>> @@ -37,14 +43,14 @@ cleanup() {
>> }
>>
>> if [ `id -u` -ne 0 ]; then
>> - =A0 =A0echo "Must start p9auth tests as root"
>> + =A0 =A0tst_resm TBROK "Must start p9auth tests as root"
>> =A0 exit 1
>> fi
>>
>> ltpuid=3D`grep ltp /etc/passwd | head -1 | awk -F: '{ print $3 '}`
>> ret=3D$?
>> if [ $? -ne 0 ]; then
>> - =A0 =A0echo "Failed to find ltp userid"
>> + =A0 =A0tst_resm TCONF "Failed to find ltp userid"
>> =A0 exit 1
>> fi
>>
>> @@ -57,12 +63,13 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
>> touch $LTPTMP/childgo
>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :;
>> done;
>> if [ -f $LTPTMP/d/childpass ]; then
>> - =A0 =A0echo "FAIL: child could setuid with bad hash"
>> + =A0 =A0tst_resm TFAIL "child could setuid with bad hash"
>> =A0 exit 1
>> fi
>> -echo "PASS: child couldn't setuid with bad hash"
>> +tst_resm TPASS "child couldn't setuid with bad hash"
>>
>> # TEST 2: ltp setuids to 0 with valid hash
>> +export TST_COUNT=3D2
>>
>> # create the hash. =A0randstr doesn't have to be int, but it's ok
>> cleanup
>> @@ -80,12 +87,13 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
>> touch $LTPTMP/childgo
>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :;
>> done;
>> if [ -f $LTPTMP/d/childfail ]; then
>> - =A0 =A0echo "FAIL: child couldn't setuid with good hash"
>> + =A0 =A0tst_resm TFAIL "child couldn't setuid with good hash"
>> =A0 exit 1
>> fi
>> -echo "PASS: child could setuid with good hash"
>> +tst_resm TPASS "child could setuid with good hash"
>>
>> # TEST 3: 0 setuids to 0 with hash valid for ltp user
>> +export TST_COUNT=3D3
>> cleanup
>> randstr=3D$RANDOM
>> txt=3D"0@0"
>> @@ -101,10 +109,10 @@ while [ ! -f $LTPTMP/d/childready ]; do :; done
>> touch $LTPTMP/childgo
>> while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :;
>> done;
>> if [ -f $LTPTMP/d/childpass ]; then
>> - =A0 =A0echo "FAIL: child could setuid from wrong source uid"
>> + =A0 =A0tst_resm TFAIL "child could setuid from wrong source uid"
>> =A0 exit 1
>> fi
>> -echo "PASS: child couldn't setuid from wrong source uid"
>> +tst_resm TPASS "child couldn't setuid from wrong source uid"
>>
>> touch $LTPTMP/childexit
>>
>> diff --git a/testcases/kernel/security/p9auth/p9unpriv.sh
>> b/testcases/kernel/security/p9auth/p9unpriv.sh
>> index 077b8ac..d42ee8e 100755
>> --- a/testcases/kernel/security/p9auth/p9unpriv.sh
>> +++ b/testcases/kernel/security/p9auth/p9unpriv.sh
>> @@ -19,7 +19,8 @@
>> ##
>> ##
>>
>> ########################################################################=
########
>>
>> -LTPTMP=3D/tmp/p9auth_ltp
>> +export TMPDIR=3D${TMPDIR:-/tmp}
>> +export LTPTMP=3D${TMPDIR}/p9auth_ltp
>>
>> TOUCH=3D`which touch`
>> ID=3D`which id`
>> @@ -27,7 +28,7 @@ echo ltptmp is $LTPTMP
>>
>> myuid=3D`id -u`
>> if [ "$myuid" -eq 0 ]; then
>> - =A0 =A0echo "Unprivileged child was started as root!"
>> + =A0 =A0tst_resm TBROK "Unprivileged child was started as root!"
>> =A0 exit 1
>> fi
>
> Perfect -- I'll commit this once I get back home in a few hours!
> Thanks,

Ok, so before I commit I just want to make sure that this makes sense with =
you:

The differences are:
1. The id -?r?u use.
2. The while [ ! ... -a ... ] vs until [ ... -o ... ] logic (is more
clear in my mind because it better describes the desired end-state)
3. Removing the which calls (because which doesn't exist on busybox
from what I've heard) and replacing them with non-absolute commands
(because it's the same thing...).

Thanks!
-Garrett

Index: testcases/kernel/security/p9auth/p9priv.sh
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvsroot/ltp/ltp/testcases/kernel/security/p9auth/p9priv.sh,v
retrieving revision 1.1
diff -u -r1.1 p9priv.sh
--- testcases/kernel/security/p9auth/p9priv.sh  21 Sep 2009 15:48:09
-0000     1.1
+++ testcases/kernel/security/p9auth/p9priv.sh  6 Jan 2010 02:50:09 -0000
@@ -19,32 +19,32 @@
 ##
        ##
 ##########################################################################=
######

-LTPTMP=3D/tmp/p9auth_ltp
+export TMPDIR=3D${TMPDIR:-/tmp}
+export LTPTMP=3D${TMPDIR}/p9auth_ltp
+export TST_TOTAL=3D3
+export TCID=3D"p9auth"
+
+export TST_COUNT=3D1
+
 rm -rf $LTPTMP
 mkdir $LTPTMP
 chmod 755 $LTPTMP

 comms=3D"$LTPTMP/childgo $LTPTMP/d/childready $LTPTMP/d/childfail
$LTPTMP/d/childpass $LTPTMP/childexit"

-RM=3D`which rm`
-MKDIR=3D`which mkdir`
-CHOWN=3D`which chown`
-
 cleanup() {
-       $RM -rf $LTPTMP/d $comms
-       $MKDIR -p $LTPTMP/d
-       $CHOWN -R ltp $LTPTMP/d
+       rm -rf $LTPTMP/d $comms
+       mkdir -p $LTPTMP/d
+       chown -R ltp $LTPTMP/d
 }

-if [ `id -u` -ne 0 ]; then
-       echo "Must start p9auth tests as root"
+if [ "$(id -ru)" -ne 0 ]; then
+       tst_resm TBROK "Must start p9auth tests as root"
        exit 1
 fi

-ltpuid=3D`grep ltp /etc/passwd | head -1 | awk -F: '{ print $3 '}`
-ret=3D$?
-if [ $? -ne 0 ]; then
-       echo "Failed to find ltp userid"
+if ! ltpuid=3D$(id -u ltp); then
+       tst_resm TCONF "Failed to find ltp userid"
        exit 1
 fi

@@ -55,12 +55,12 @@
 su ltp p9unpriv.sh &
 while [ ! -f $LTPTMP/d/childready ]; do :; done
 touch $LTPTMP/childgo
-while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
+until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
 if [ -f $LTPTMP/d/childpass ]; then
-       echo "FAIL: child could setuid with bad hash"
+       tst_resm TFAIL "child could setuid with bad hash"
        exit 1
 fi
-echo "PASS: child couldn't setuid with bad hash"
+tst_resm TPASS "child couldn't setuid with bad hash"

 # TEST 2: ltp setuids to 0 with valid hash

@@ -78,12 +78,12 @@
 su ltp p9unpriv.sh &
 while [ ! -f $LTPTMP/d/childready ]; do :; done
 touch $LTPTMP/childgo
-while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
+until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done
 if [ -f $LTPTMP/d/childfail ]; then
-       echo "FAIL: child couldn't setuid with good hash"
+       tst_resm TFAIL "child couldn't setuid with good hash"
        exit 1
 fi
-echo "PASS: child could setuid with good hash"
+tst_resm TPASS "child could setuid with good hash"

 # TEST 3: 0 setuids to 0 with hash valid for ltp user
 cleanup
@@ -99,12 +99,12 @@
 su ltp p9unpriv.sh &
 while [ ! -f $LTPTMP/d/childready ]; do :; done
 touch $LTPTMP/childgo
-while [ ! -f $LTPTMP/d/childfail -a ! -f $LTPTMP/d/childpass ]; do :; done;
+until [ -f $LTPTMP/d/childfail -o -f $LTPTMP/d/childpass ]; do :; done;
 if [ -f $LTPTMP/d/childpass ]; then
-       echo "PASS: child could setuid from wrong source uid"
+       tst_resm TFAIL "child could setuid from wrong source uid"
        exit 1
 fi
-echo "PASS: child couldn't setuid from wrong source uid"
+tst_resm TPASS "child couldn't setuid from wrong source uid"

 touch $LTPTMP/childexit

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
