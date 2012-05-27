Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SYYlR-0006Sn-4d
	for ltp-list@lists.sourceforge.net; Sun, 27 May 2012 08:23:49 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SYYlO-0002Qt-Jb
	for ltp-list@lists.sourceforge.net; Sun, 27 May 2012 08:23:49 +0000
Received: by obhx4 with SMTP id x4so4878646obh.34
	for <ltp-list@lists.sourceforge.net>;
	Sun, 27 May 2012 01:23:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FC1E248.6040008@cn.fujitsu.com>
References: <CAGH67wQmnoUVOftT8=hL_T7Tv28WdGaQpmL09YQ5LWWqf=9U2w@mail.gmail.com>
	<4FC1D8C5.4050804@cn.fujitsu.com>
	<CAGH67wQw2j6AMgKxs0JwynQYT7JB0mjVkiB+hztWUSnLRneS9w@mail.gmail.com>
	<4FC1E248.6040008@cn.fujitsu.com>
Date: Sun, 27 May 2012 01:23:40 -0700
Message-ID: <CAGH67wT3etJ-v7sA4ygKpXZNeX=0quNQkXmCp_PC9No2wxu4kA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] Fix the fork/11-1 conformance testcase
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
To: gaowanlong@cn.fujitsu.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Sun, May 27, 2012 at 1:14 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com> wr=
ote:
> On 05/27/2012 04:00 PM, Garrett Cooper wrote:
>
>> On Sun, May 27, 2012 at 12:33 AM, Wanlong Gao <gaowanlong@cn.fujitsu.com=
> wrote:
>>> On 05/26/2012 10:15 PM, Garrett Cooper wrote:
>>>
>>>> The testcase tests to see whether or not locks are successfully
>>>> inherited across forking processes, as the requirements for fork state
>>>> that they should not be. The problem is that the test tests the negati=
ve
>>>> case for ftrylockfile (!=3D 0) instead of the positive case, which cre=
ates
>>>
>>> The ftrylockfile() function returns zero for success (the lock was obta=
ined),
>>> and nonzero for failure.
>>> So I think the origin is right.
>>
>> =A0 =A0 My description might be wrong, but the fix is right. ftrylockfile
>> should fail in the testcase (not succeed) because the file lock isn't
>> owned by the forked process. It succeeds simply because the delay is
>
>
> But on my system ftrylockfile() always return 0, and the test PASSED.
> and with your patch, it fails.

Then that's a Linux/POSIX bug then. From fork(2) on OpenGroup [1]:

"File locks set by the parent process are not inherited by the child proces=
s."

And from flockfile(2) on OpenGroup [2]:

"   The flockfile() function is used by a thread to acquire ownership
of a ( FILE *) object.

    The ftrylockfile() function is used by a thread to acquire
ownership of a ( FILE *) object if the object is available;
ftrylockfile() is a non-blocking version of flockfile().

...

    None for flockfile() and funlockfile(). The function
ftrylockfile() returns zero for success and non-zero to indicate that
the lock cannot be acquired."

The goal/algorithm as stated at the top of the testcase was...

"* The steps are:
* -> lock stdout
* -> fork
* -> child creates a thread
* -> child thread trylock stdout
* -> join the child

* The test fails if the child thread cannot lock the file
* -- this would mean the child process got stdout file lock ownership."

Thanks!
-Garrett

1. http://pubs.opengroup.org/onlinepubs/009695399/functions/fork.html
2. http://pubs.opengroup.org/onlinepubs/009695399/functions/flockfile.html

---------------------------------------------------------------------------=
---
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and =

threat landscape has changed and how IT managers can respond. Discussions =

will include endpoint security, mobile security and the latest in malware =

threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
