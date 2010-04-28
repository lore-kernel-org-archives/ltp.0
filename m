Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1O7AeP-0007sd-HI
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 17:02:17 +0000
Received: from mail-gy0-f175.google.com ([209.85.160.175])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7AeM-0007AJ-Jx
	for ltp-list@lists.sourceforge.net; Wed, 28 Apr 2010 17:02:17 +0000
Received: by gya1 with SMTP id 1so6181162gya.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 28 Apr 2010 10:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100428134252.GA31204@us.ibm.com>
References: <1272444847.5696.9.camel@munipradeep-laptop>
	<y2q364299f41004280213xf8326524n9248b16b38d9cac4@mail.gmail.com>
	<20100428134252.GA31204@us.ibm.com>
Date: Wed, 28 Apr 2010 10:01:48 -0700
Message-ID: <k2t364299f41004281001v356f74a7h17a5c160ec9efbc2@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] mqns tests are failing
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
Cc: ltp-list@lists.sourceforge.net

On Wed, Apr 28, 2010 at 6:42 AM, Serge E. Hallyn <serue@us.ibm.com> wrote:
> Quoting Garrett Cooper (yanegomi@gmail.com):
>> On Wed, Apr 28, 2010 at 1:54 AM, Munipradeep Beerakam
>> <mpradeep@linux.vnet.ibm.com> wrote:
>> > Hi,
>> >
>> > I noticed that mqns test cases are failing. I am using March 2010 LTP.
>> > After changing mq_open syscall in mqns_01.c file, test is passing. Same
>> > thing is happening w.r.t. other mqns test cases. Below is the change I
>> > made.
>> >
>> > Changed
>> > =A0 mqd =3D syscall(__NR_mq_open, SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL,077=
7,
>> > NULL);
>> >
>> > to
>> > =A0 mqd =3D mq_open(SLASH_MQ1, O_RDWR|O_CREAT|O_EXCL, 0777, NULL);
>> >
>> > Failure output I got is below:
>> > # ./mqns_01
>> > posixmq_namespace_01 =A0 =A00 =A0TINFO =A0: =A0Testing posix mq namesp=
aces through
>> > unshare(2).
>> >
>> > mq_open: Permission denied
>> > posixmq_namespace_01 =A0 =A01 =A0TFAIL =A0: =A0mq_open failed
>> >
>> > After changing as above, I got the below output:
>> > # ./mqns_01
>> > posixmq_namespace_01 =A0 =A00 =A0TINFO =A0: =A0Testing posix mq namesp=
aces through
>> > unshare(2).
>> >
>> > posixmq_namespace_01 =A0 =A00 =A0TINFO =A0: =A0Checking namespaces iso=
lation from
>> > parent to child
>> >
>> > posixmq_namespace_01 =A0 =A01 =A0TPASS =A0: =A0child process didn't fi=
nd mqueue
>> >
>> > So, my question is that what is the difference between the two, i.e.,
>> > the previous one and the changed one. Both are calling the same mq_open
>
> See http://www.mail-archive.com/ltp-list@lists.sourceforge.net/msg09073.h=
tml
> for the ansswer.
>
>> > system call. But first one is failing whereas the second one is
>> > succeeding.
>> >
>> > So, do we need to modify all mqns test cases to the new form?
>>
>> =A0 =A0 Track down the execution path by first starting with glibc. It
>> might be a library vs kernel mismatch or a bug. Make sure that the
>> syscall number matches per your architecture, determine whether or not
>> your architecture has issues executing code in a biarch manner (64-bit
>> on 32-bit) if it applies.
>> HTH,

Ah, forgot about that...
-Garrett

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
