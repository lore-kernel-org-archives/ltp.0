Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Otjq1-0003XD-St
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 16:19:01 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Otjpx-0003fu-Pj
	for ltp-list@lists.sourceforge.net; Thu, 09 Sep 2010 16:19:01 +0000
Received: by bwz12 with SMTP id 12so1705323bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Sep 2010 09:18:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C8895FD.5010809@windriver.com>
References: <4C887D32.60608@windriver.com>
	<6AA0EB8D-1C22-4BFD-BC94-BB687B5C08CD@gmail.com>
	<4C8895FD.5010809@windriver.com>
Date: Thu, 9 Sep 2010 09:18:51 -0700
Message-ID: <AANLkTinN16fSjXo-5E=VaSS+F=jmAPfF_vHmY8EJdQ7Y@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: "lina.zhao" <lina.zhao@windriver.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Sep 9, 2010 at 1:08 AM, lina.zhao <lina.zhao@windriver.com> wrote:
> but $TMPDIR may not be defined in the environment, so we need --tmpdir / =
-p
> to specify the directory

export TMPDIR=3D$TMP

Done.

> -p is support on most of versions.

The key word you used there is `most'. We need to support all logical
versions of mktemp, which means that it needs to work for about all of
them (I don't care about package versions from back in the kernel
2.4.x days too terribly much, and the other earlier versions, i.e.
2.2, etc, are a non-issue).

> mnt_pnt=3D`mktemp -d $TMP/mnt_pnt.XXXXXX` doesn't work well
>
> lina@lina-desktop:~$ =A0export TMP=3D/home/lina/tmp/
> lina@lina-desktop:~$ mktemp -d $TMP/mnt_pnt.XXXXXX
> /home/lina/tmp//mnt_pnt.i12144
> lina@lina-desktop:~$ mktemp -d -p $TMP mnt_pnt.XXXXXX
> /home/lina/tmp/mnt_pnt.Q12146
>
> if $TMP include / in end, then there will be 2 // for the temp file

So... what's the issue if there are 2 or more slashes? FWIW that issue
is extremely easy to work around anyhow...

TMP=3D`dirname $TMP/GARBAGE`

(GARBAGE is required so that it maintains the desired contents in $TMP)

>> On Sep 8, 2010, at 11:22 PM, lina.zhao wrote:
>>
>>> Hi,
>>>
>>> In runltp:
>>>
>>> if [ -n "$DEVICE" ]; then
>>> =A0 =A0 mnt_pnt=3D`mktemp -d --tmpdir=3D${TMP} mnt_pnt.XXXXXX`
>>>
>>> --tmpdir is a invalid option for mktemp version 1.5, which is used
>>> widely. The valid option to specify a directory for version 1.5 is
>>> -p directory.
>>
>> Or just remove --tmpdir=3D<blah> altogether? If $TMPDIR is defined in the
>> environment, then it is the fallback if --tmpdir / -p isn't specified
>> (please see the manpage for more details)... OR... just do:
>>
>> mnt_pnt=3D`mktemp -d $TMP/mnt_pnt.XXXXXX`
>>
>> The same change will probably need to be applied to the runltp lite
>> script.

Simple universal solutions are what I seek :). See if either of the
two suggestions I provided above meets your approval (and FWIW if we
change TMP to TMPDIR, stuff might start working a lot better in LTP
because TMPDIR is the standard variable used for mktemp, not $TMP, etc
that we define in the environment).

Cheers,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net Dev2Dev email is sponsored by:

Show off your parallel programming skills.
Enter the Intel(R) Threading Challenge 2010.
http://p.sf.net/sfu/intel-thread-sfd
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
