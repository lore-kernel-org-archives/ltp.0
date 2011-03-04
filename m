Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <yanegomi@gmail.com>) id 1PvRIu-0003Ci-DJ
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 09:28:08 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.74) id 1PvRIt-0007c2-Fi
	for ltp-list@lists.sourceforge.net; Fri, 04 Mar 2011 09:28:08 +0000
Received: by wwb29 with SMTP id 29so2679342wwb.10
	for <ltp-list@lists.sourceforge.net>;
	Fri, 04 Mar 2011 01:28:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4D6FCCF7.2010101@redhat.com>
References: <20110120143028.4df7ab81@regolo>
	<AANLkTikt-TBmgTSqcRT4OY21udzxpuq-s0yGqirMrWFr@mail.gmail.com>
	<4D6FCCF7.2010101@redhat.com>
Date: Fri, 4 Mar 2011 01:28:01 -0800
Message-ID: <AANLkTi=v3wogPd8sC_5qmSxjmOhJUgn3i90r3yD8AARo@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] syscalls: acct01: fix testcases [was: Re: [PATCH]
 Add tst_require_root to acct01 testcase.]
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
To: Caspar Zhang <czhang@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On Thu, Mar 3, 2011 at 9:16 AM, Caspar Zhang <czhang@redhat.com> wrote:
> On 01/21/2011 04:28 PM, Garrett Cooper wrote:
>> On Thu, Jan 20, 2011 at 5:30 AM, Cristian Greco <cristian@regolo.cc> wro=
te:
>>> > Hi,
>>> >
>>> > [ please keep CC as I'm not currently subscribed to the list ]
>>> >
>>> > please find attached a small fix to check for root privileges in
>>> > acct(2) testcase (syscalls/acct/acct01.c).
>> =A0 =A0 Thanks for spotting the issue. I've fixed it, added a few more
>> testcases, and discovered what appears to be a kernel bug on 2.6.34
>> (acct("/tmp/does/not/exist") should fail with =3D=3D -1 and errno =3D=3D
>> ENOTDIR) :)...
>> Cheers,
>> -Garrett
>
> a follow-up fix for http://article.gmane.org/gmane.linux.ltp/13576 .
> In fact, it's not a kernel bug of ENOTDIR's failure. ENOTDIR means that
> you setup a string as directory in argument, but it is actually a file.
> The patch fixes this failure. The result of given path
> /tmp/does/not/exist should be expected as ENOENT.
>
> And also, there is a mistake in EPERM case, to restore the permissions,
> SAFE_SETUID should be used instead of SAFE_SETGID, else it will never
> recover the permissions.

Yeah, you're right... committed.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
What You Don't Know About Data Connectivity CAN Hurt You
This paper provides an overview of data connectivity, details
its effect on application quality, and explores various alternative
solutions. http://p.sf.net/sfu/progress-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
