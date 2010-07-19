Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oaiv2-0008Ew-Mz
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 05:29:36 +0000
Received: from mail-iw0-f174.google.com ([209.85.214.174])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oaiv1-0005L8-Ut
	for ltp-list@lists.sourceforge.net; Mon, 19 Jul 2010 05:29:36 +0000
MIME-Version: 1.0
In-Reply-To: <4C3D7641020000E8000664BA@sinclair.provo.novell.com>
References: <9603429.236361279111653386.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<4C3D7641020000E8000664BA@sinclair.provo.novell.com>
Date: Sun, 18 Jul 2010 22:29:30 -0700
Message-ID: <AANLkTimPGnf0duGznWcBDPd-wePqLfWUCUzMsFdFl7CO@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Is there a good way to check kernel config in LTP?
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
To: Murlin Wenzel <mwenzel@novell.com>
Cc: ltp-list <ltp-list@lists.sf.net>

On Wed, Jul 14, 2010 at 7:33 AM, Murlin Wenzel <mwenzel@novell.com> wrote:
>>>> On 7/14/2010 at 07:03 AM, in message
> <1263127425.237831279112632038.JavaMail.root@zmail04.collab.prod.int.phx2=
.redhat
> com>, Caspar Zhang <czhang@redhat.com> wrote:
>> Hi all, I find a FAIL result in syscalls/swapon03 with RHEL6 kernel,
>> on a x86_64 machine, it always fails with the following message:
>>
>> swapon03 =A0 =A01 =A0TFAIL =A0: =A0Failed swapon for file swapfile30: er=
rno=3DEPERM(1):
>> Operation not permitted
>> swapon03 =A0 =A01 =A0TFAIL =A0: =A0Failed to setup swaps
>>
>> This is because in some >=3D2.6.32 kernels, the
>> CONFIG_MEMORY_FAILURE option is enabled by default in kernel.
>> As the NOTES in man 2 swapon says:
>>
>> "...Since kernel 2.6.32, the limit is decreased by 1 if the kernel is bu=
ilt
>> with the CONFIG_MEMORY_FAILURE option..."
>>
>
> That's not the only option that affects MAX_SWAPFILES now.
>
>> so MAX_SWAPFILES is not 30 anymore, it's 29. While LTP defines MAX_SWAPF=
ILES
>> to 30 in include/swaponoff.h(hmmm....hardcode, I don't think it's a good
>> idea :-|).
>>
>> So the way to solve(maybe) the problem is clear: change MAX_SWAPFILES
>> to 29 when CONFIG_MEMORY_FAILURE is enabled. My question is: is there
>> a good way to check whether a kernel option is enabled or not? I searched
>> in the old discussions in this maillist and found nothing. I want to kno=
w if
>>
>> the developers have some new ideas?
>>
>
> I've seen 28 as the MAX as well, it all depends on the config options. =
=A0I've been looking at re-architecting the test to do some sort of repeat =
test to the max number of successful swap creations and then verifying that=
 the same number is reachable at least 2 times. =A0MAX_SWAPFILES is never e=
xported to userspace. =A0It's a compile time #define that depends on the ke=
rnel config options.

    What about /proc/config.gz (or something similar)? Seems like a
simple enough thing to check for absolute clarity... don't remember
the kernel option for that though.
Cheers,
-Garrett

---------------------------------------------------------------------------=
---
This SF.net email is sponsored by Sprint
What will you do first with EVO, the first 4G phone?
Visit sprint.com/first -- http://p.sf.net/sfu/sprint-com-first
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
