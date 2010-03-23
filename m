Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Nu7Db-0005Uo-Ac
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:44:39 +0000
Received: from mail-pw0-f47.google.com ([209.85.160.47])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Nu7Da-0003NC-Ff
	for ltp-list@lists.sourceforge.net; Tue, 23 Mar 2010 16:44:39 +0000
Received: by pwj6 with SMTP id 6so126755pwj.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 23 Mar 2010 09:44:32 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4BA85020.9040202@cn.fujitsu.com>
References: <4B9B0B3A.3080008@cn.fujitsu.com>
	<364299f41003122227w6859d6f3i829466a6fc5099f2@mail.gmail.com>
	<364299f41003122313i47334168u25a6b12c6c64a7d9@mail.gmail.com>
	<4BA74116.9020009@cn.fujitsu.com>
	<364299f41003222057i6caa2cc8g6b1786f3cee86a74@mail.gmail.com>
	<4BA85020.9040202@cn.fujitsu.com>
Date: Tue, 23 Mar 2010 09:44:31 -0700
Message-ID: <364299f41003230944m49f4e729r8e5a664a3b89d3bb@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [BUG?] proc01: read /proc/acpi/event failed if acpi
	daemon stopped
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
To: Shi Weihua <shiwh@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Mon, Mar 22, 2010 at 10:22 PM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
> at 2010-3-23 11:57, Garrett Cooper wrote:
>> On Mon, Mar 22, 2010 at 3:06 AM, Shi Weihua <shiwh@cn.fujitsu.com> wrote:
>>> Hi Garrett
>>>
>>> at 2010-3-13 15:13, Garrett Cooper wrote:
>>>> On Fri, Mar 12, 2010 at 10:27 PM, Garrett Cooper <yanegomi@gmail.com> =
wrote:
>>>>> On Fri, Mar 12, 2010 at 7:49 PM, Shi Weihua <shiwh@cn.fujitsu.com> wr=
ote:
>>>>>> An error message occured when i tested proc01.
>>>>>> ---------
>>>>>> proc01 =A0 =A0 =A01 =A0TFAIL =A0: =A0read failed: /proc/acpi/event: =
errno=3DEAGAIN(11): Resource temporarily unavailable
>>>>>> ---------
>>>>>>
>>>>>> If "service acpid start", this message will be turned to:
>>>>>> ---------
>>>>>> proc01 =A0 =A0 =A00 =A0TINFO =A0: =A0/proc/acpi/event: known issue: =
errno=3DEBUSY(16): Device or resource busy
>>>>>> ---------
>>>>>>
>>>>>> I think we should to add a check of acpi daemon's status in testcase=
s/kernel/fs/proc/proc01.c.
>>>>>
>>>>> =A0 =A0No, that's making things too complicated and won't scale as ev=
ery
>>>>> distro has developed a different means for specifying the status for a
>>>>> service. Why not just add EAGAIN for that /proc node?
>>>>
>>>> =A0 =A0 And FWIW the error condition is correct in my opinion if kernel
>>>> acpi hasn't been enabled, which was the case here.
>>>
>>> I think we should to give a warning message to LTP users.
>>> How do you think the following patch?
>>>
>>> diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/pr=
oc/proc01.c
>>> index 2d4a5fd..62d44b1 100644
>>> --- a/testcases/kernel/fs/proc/proc01.c
>>> +++ b/testcases/kernel/fs/proc/proc01.c
>>> @@ -101,6 +101,7 @@ const Mapping known_issues[] =3D {
>>> =A0 =A0 {"read", "/proc/fs/nfsd/filehandle", EINVAL},
>>> =A0 =A0 {"read", "/proc/fs/nfsd/.getfs", EINVAL},
>>> =A0 =A0 {"read", "/proc/fs/nfsd/.getfd", EINVAL},
>>> + =A0 =A0{"read", "/proc/acpi/event", EAGAIN}, //EAGAIN will be returne=
d if acpi daemon disabled
>>> =A0 =A0 {"", "", 0}
>>> =A0};
>>
>> =A0 =A0 Looks good minus the C++ style comment ;).
>
> ok, let's use C style comment.
>
> diff --git a/testcases/kernel/fs/proc/proc01.c b/testcases/kernel/fs/proc=
/proc01.c
> index 2d4a5fd..355b7dd 100644
> --- a/testcases/kernel/fs/proc/proc01.c
> +++ b/testcases/kernel/fs/proc/proc01.c
> @@ -101,6 +101,7 @@ const Mapping known_issues[] =3D {
> =A0 =A0 {"read", "/proc/fs/nfsd/filehandle", EINVAL},
> =A0 =A0 {"read", "/proc/fs/nfsd/.getfs", EINVAL},
> =A0 =A0 {"read", "/proc/fs/nfsd/.getfd", EINVAL},
> + =A0 =A0{"read", "/proc/acpi/event", EAGAIN}, /* EAGAIN will be returned=
 if acpi daemon disabled */
> =A0 =A0 {"", "", 0}
> =A0};

Acked-by: Garrett Cooper <yanegomi@gmail.com>

---------------------------------------------------------------------------=
---
Download Intel&#174; Parallel Studio Eval
Try the new software tools for yourself. Speed compiling, find bugs
proactively, and fine-tune applications for parallel performance.
See why Intel Parallel Studio got high marks during beta.
http://p.sf.net/sfu/intel-sw-dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
