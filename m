Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1OA5J5-00019q-0d
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:56:19 +0000
Received: from mail-iw0-f200.google.com ([209.85.223.200])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OA5J4-0007OI-3e
	for ltp-list@lists.sourceforge.net; Thu, 06 May 2010 17:56:18 +0000
Received: by iwn38 with SMTP id 38so169924iwn.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 06 May 2010 10:56:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100506065729.23879.9995.sendpatchset@subratamodak.linux.ibm.com>
References: <20100506065548.23879.63131.sendpatchset@subratamodak.linux.ibm.com>
	<20100506065729.23879.9995.sendpatchset@subratamodak.linux.ibm.com>
Date: Thu, 6 May 2010 10:53:45 -0700
Message-ID: <q2z364299f41005061053zcc57d5c4gc5577e9d80ffc8e5@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [06/12 FAILURE] Many CONTAINER tests of LTP fail
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: Linus Test Project <ltp-list@lists.sourceforge.net>, B N Poornima <bnpoorni@in.ibm.com>, Sachin P Sant <ssant@in.ibm.com>, "SUZUKI K. POULOSE" <suzuki@in.ibm.com>, Sharyathi Nagesh <sharyath@in.ibm.com>

Clipping the output to denote the failures.

On Wed, May 5, 2010 at 11:57 PM, Subrata Modak
<subrata@linux.vnet.ibm.com> wrote:
> Subject:Many CONTAINER tests of LTP fail
>
> I know Serge and Dan is already working on it.
>
> Issues Description Below:
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
> # ./runltp -f containers
> <<<test_start>>>

[...]

> pid_namespace3 =A0 =A01 =A0TFAIL =A0: =A0Failed to open /proc directory

This is interesting... is /proc not mounted in the child container?

> pidns30 =A0 =A0 1 =A0TBROK =A0: =A0parent: mq_open() failed (Permission d=
enied)
> pidns31 =A0 =A0 1 =A0TBROK =A0: =A0parent: mq_open() failed (Permission d=
enied)

Does the queue exist?

> posixmq_namespace_01 =A0 =A01 =A0TFAIL =A0: =A0mq_open failed
> Running netns tests.

[...]

> netns_2children =A0 =A01 =A0TFAIL =A0: =A0Error while running the scripts
> two_children_ns: return code is 1 ;
> sshd re-exec requires execution with an absolute path^M

This was going to be fixed with a patch proposed earlier.

> childns.sh =A0 =A00 =A0TINFO =A0: =A0Successfully Renamed device to veth1
> Files /tmp/sys_b4_child_killed and /tmp/sys_aftr_child_killed differ
> Cannot find device "veth1"
> crtchild_delchild: PASS

This seems suspect even though it says passed.

[...]

> sshd re-exec requires execution with an absolute path^M
> Error: Can't ftp to 192.168.0.181: Connection refused
> childns.sh =A0 =A01 =A0TFAIL =A0: =A0ftp failed

One of the prereqs is missing probably (setup an ftp daemon ... maybe
this was going to be done via ssh?)

[...]

> <<<test_end>>>

---------------------------------------------------------------------------=
---
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
