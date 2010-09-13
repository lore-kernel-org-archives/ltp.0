Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1Ov41p-00042O-5l
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 08:04:41 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Ov41k-0005iq-MN
	for ltp-list@lists.sourceforge.net; Mon, 13 Sep 2010 08:04:41 +0000
Message-ID: <4C8DDB11.3020009@windriver.com>
Date: Mon, 13 Sep 2010 16:04:33 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
References: <4C887D32.60608@windriver.com>	<6AA0EB8D-1C22-4BFD-BC94-BB687B5C08CD@gmail.com>	<4C8895FD.5010809@windriver.com>
	<AANLkTinN16fSjXo-5E=VaSS+F=jmAPfF_vHmY8EJdQ7Y@mail.gmail.com>
In-Reply-To: <AANLkTinN16fSjXo-5E=VaSS+F=jmAPfF_vHmY8EJdQ7Y@mail.gmail.com>
Content-Type: multipart/mixed; boundary="------------050307020206080801000303"
Subject: Re: [LTP] [PATCH]mktemp command in runltp version issue
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050307020206080801000303
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

mnt_pnt=`mktemp -d $TMP/mnt_pnt.XXXXXX` works well.

please check the patch.

> On Thu, Sep 9, 2010 at 1:08 AM, lina.zhao <lina.zhao@windriver.com> wrote:
>   
>> but $TMPDIR may not be defined in the environment, so we need --tmpdir / -p
>> to specify the directory
>>     
>
> export TMPDIR=$TMP
>
> Done.
>
>   
>> -p is support on most of versions.
>>     
>
> The key word you used there is `most'. We need to support all logical
> versions of mktemp, which means that it needs to work for about all of
> them (I don't care about package versions from back in the kernel
> 2.4.x days too terribly much, and the other earlier versions, i.e.
> 2.2, etc, are a non-issue).
>
>   
>> mnt_pnt=`mktemp -d $TMP/mnt_pnt.XXXXXX` doesn't work well
>>
>> lina@lina-desktop:~$  export TMP=/home/lina/tmp/
>> lina@lina-desktop:~$ mktemp -d $TMP/mnt_pnt.XXXXXX
>> /home/lina/tmp//mnt_pnt.i12144
>> lina@lina-desktop:~$ mktemp -d -p $TMP mnt_pnt.XXXXXX
>> /home/lina/tmp/mnt_pnt.Q12146
>>
>> if $TMP include / in end, then there will be 2 // for the temp file
>>     
>
> So... what's the issue if there are 2 or more slashes? FWIW that issue
> is extremely easy to work around anyhow...
>
> TMP=`dirname $TMP/GARBAGE`
>
> (GARBAGE is required so that it maintains the desired contents in $TMP)
>
>   
>>> On Sep 8, 2010, at 11:22 PM, lina.zhao wrote:
>>>
>>>       
>>>> Hi,
>>>>
>>>> In runltp:
>>>>
>>>> if [ -n "$DEVICE" ]; then
>>>>     mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`
>>>>
>>>> --tmpdir is a invalid option for mktemp version 1.5, which is used
>>>> widely. The valid option to specify a directory for version 1.5 is
>>>> -p directory.
>>>>         
>>> Or just remove --tmpdir=<blah> altogether? If $TMPDIR is defined in the
>>> environment, then it is the fallback if --tmpdir / -p isn't specified
>>> (please see the manpage for more details)... OR... just do:
>>>
>>> mnt_pnt=`mktemp -d $TMP/mnt_pnt.XXXXXX`
>>>
>>> The same change will probably need to be applied to the runltp lite
>>> script.
>>>       
>
> Simple universal solutions are what I seek :). See if either of the
> two suggestions I provided above meets your approval (and FWIW if we
> change TMP to TMPDIR, stuff might start working a lot better in LTP
> because TMPDIR is the standard variable used for mktemp, not $TMP, etc
> that we define in the environment).
>
> Cheers,
> -Garrett
>
>   


--------------050307020206080801000303
Content-Type: text/x-diff;
 name="0001-mktemp-version-issue-in-runltp.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="0001-mktemp-version-issue-in-runltp.patch"

From 08de712ef1ada48353c2c0b782e2089a3fdb7263 Mon Sep 17 00:00:00 2001
From: Lina Zhao <lina.zhao@windriver.com>
Date: Mon, 13 Sep 2010 15:59:55 +0800
Subject: [PATCH] mktemp version issue in runltp

--tmpdir is a invalid option for mktemp version 1.5, which is used
widely. mktemp with no special directory argument works well.

Signed-off-by: Lina Zhao < lina.zhao@windriver.com >
---
 runltp |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/runltp b/runltp
index b385984..04c16af 100755
--- a/runltp
+++ b/runltp
@@ -716,7 +716,7 @@ main()
     fi
 
     if [ -n "$DEVICE" ]; then
-        mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`
+        mnt_pnt=`mktemp -d $TMP/mnt_pnt.XXXXXX`
         if [ -n "$DEVICE_FS_TYPE" ]; then
             mount -t $DEVICE_FS_TYPE $DEVICE $mnt_pnt
         else
-- 
1.6.3.1


--------------050307020206080801000303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing
http://p.sf.net/sfu/novell-sfdev2dev

--------------050307020206080801000303
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------050307020206080801000303--

