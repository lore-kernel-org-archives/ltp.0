Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MSvEf-0005ku-I6
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 15:57:05 +0000
Received: from mail-pz0-f201.google.com ([209.85.222.201])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MSvEa-000575-6I
	for ltp-list@lists.sourceforge.net; Mon, 20 Jul 2009 15:57:05 +0000
Received: by pzk39 with SMTP id 39so198649pzk.28
	for <ltp-list@lists.sourceforge.net>;
	Mon, 20 Jul 2009 08:56:59 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A64541C.9090408@in.ibm.com>
References: <4A48667F.9050101@in.ibm.com> <4A486E66.5050102@cn.fujitsu.com>
	<4A64541C.9090408@in.ibm.com>
Date: Mon, 20 Jul 2009 08:56:58 -0700
Message-ID: <364299f40907200856p1fe1552ch573f00be6918211a@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Issue observed with chmod05, fchmod05 test cases
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
To: Sharyathi Nagesh <sharyath@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net, mbeeraka@in.ibm.com

On Mon, Jul 20, 2009 at 4:25 AM, Sharyathi Nagesh<sharyath@in.ibm.com> wrot=
e:
> Hi
> =A0I was able to understand the problem...
> This is what I learnt
>
> Supplementary group IDs of a process is inherited from its parent process,
> so
> who ever spawns the process transfer its supplementary group ids also to =
its
> child process.
>
> in our test case scenario checking the supplementary group IDs of root wh=
ich
> is
> spawning the test cases fchmod5 and chmod5 shows this
>
> ---------------------------------------------------------
> cat test.c
> ---------------------------------------------------------
> int main()
> {
> =A0 =A0 =A0 =A0int size =3D 10;
> =A0 =A0 =A0 =A0int i, index;
> =A0 =A0 =A0 =A0gid_t list[10];
> =A0 =A0 =A0 =A0index =3D getgroups(size, list);
> =A0 =A0 =A0 =A0for ( i =3D0 ;i < index; i++)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printf("\n list[%d]:%d", i, list[i]);
> =A0 =A0 =A0 =A0printf("\n");
> }
> ---------------------------------------------------------
>
> [root@mx3350a sharyathi]# ./a.out
>
> =A0list[0]:0
> =A0list[1]:1
> =A0list[2]:2
> =A0list[3]:3
> =A0list[4]:4
> =A0list[5]:6
> =A0list[6]:10
> ---------------------------------------------------------
> This shows that bin->GID (1) is one of the supplementary group IDs of the
> process
> while nobody->GID (99) is not.
> So in the kernel code
> --------------------------------------------------------
> =A0if (ia_valid & ATTR_MODE) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0umode_t mode =3D attr->ia_mode;
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (!in_group_p(inode->i_gid) && !capable(=
CAP_FSETID))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mode &=3D ~S_ISGID;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0inode->i_mode =3D mode;
> =A0 =A0 =A0 =A0}
> --------------------------------------------------------
> S_ISGID is cleared in case file attribute is nobody and not in case of GID
> being bin
>
> I was thinking of what could be the best solution as earlier solution
> proposed
> are not fool proof
> Attaching a fix I though is the best way to handle the issue

Hi Yeehaw,
    1. You didn't provide sign-off, as noted in the DCO:
http://ltp.sourceforge.net/DCO.txt
    2. This appears to be a legitimate documentation bug (at least as
far as the manpages for 2.6.29-r5 are concerned), because I can't find
a single reference to nobody in the manpage, as far as special
importance is concerned. Furthermore, looking at the OpenGroup's
documentation, I don't see anything there either:
http://www.opengroup.org/onlinepubs/000095399/functions/getgroups.html
. So, I'm a bit stumped as to whether or not we'd be doing the right
thing by `fixing' this test.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Enter the BlackBerry Developer Challenge  =

This is your chance to win up to $100,000 in prizes! For a limited time, =

vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize=
  =

details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
