Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lina.zhao@windriver.com>) id 1OtcBY-00034p-To
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 08:08:44 +0000
Received: from mail.windriver.com ([147.11.1.11])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OtcBS-0006yT-88
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 08:08:44 +0000
Message-ID: <4C8895FD.5010809@windriver.com>
Date: Thu, 09 Sep 2010 16:08:29 +0800
From: "lina.zhao" <lina.zhao@windriver.com>
MIME-Version: 1.0
References: <4C887D32.60608@windriver.com>
	<6AA0EB8D-1C22-4BFD-BC94-BB687B5C08CD@gmail.com>
In-Reply-To: <6AA0EB8D-1C22-4BFD-BC94-BB687B5C08CD@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

but $TMPDIR may not be defined in the environment, so we need --tmpdir / 
-p to specify the directory
-p is support on most of versions.

mnt_pnt=`mktemp -d $TMP/mnt_pnt.XXXXXX` doesn't work well

lina@lina-desktop:~$  export TMP=/home/lina/tmp/
lina@lina-desktop:~$ mktemp -d $TMP/mnt_pnt.XXXXXX
/home/lina/tmp//mnt_pnt.i12144
lina@lina-desktop:~$ mktemp -d -p $TMP mnt_pnt.XXXXXX
/home/lina/tmp/mnt_pnt.Q12146

if $TMP include / in end, then there will be 2 // for the temp file

> On Sep 8, 2010, at 11:22 PM, lina.zhao wrote:
>
>> Hi,
>>
>> In runltp:
>>
>> if [ -n "$DEVICE" ]; then
>>      mnt_pnt=`mktemp -d --tmpdir=${TMP} mnt_pnt.XXXXXX`
>>
>> --tmpdir is a invalid option for mktemp version 1.5, which is used
>> widely. The valid option to specify a directory for version 1.5 is
>> -p directory.
>
> Or just remove --tmpdir=<blah> altogether? If $TMPDIR is defined in 
> the environment, then it is the fallback if --tmpdir / -p isn't 
> specified (please see the manpage for more details)... OR... just do:
>
> mnt_pnt=`mktemp -d $TMP/mnt_pnt.XXXXXX`
>
> The same change will probably need to be applied to the runltp lite 
> script.
>
> Cheers,
> -Garrett
>


------------------------------------------------------------------------------
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
