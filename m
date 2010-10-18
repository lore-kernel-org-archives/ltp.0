Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P7mi4-0000kJ-Ct
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:12:52 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7mi3-00085h-Js
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:12:52 +0000
Received: by iwn2 with SMTP id 2so1121494iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 03:12:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <231814590.568741287143700402.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
References: <231814590.568741287143700402.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
Date: Mon, 18 Oct 2010 03:12:42 -0700
Message-ID: <AANLkTinGU2YA=E3_+fYn6ChUeCF9MkxfDAvDFhg9qMpF@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] overcommit libhugetlbfs and check the statistics
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
To: CAI Qian <caiqian@redhat.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

On Fri, Oct 15, 2010 at 4:55 AM, CAI Qian <caiqian@redhat.com> wrote:
> =A0First, it resets nr_hugepages and nr_overcommit_hugepages. Then, set
> =A0both to 128 and reserve 192 hugepages. Finally, it reads and writes
> =A0every page. There are command options to choose either to manage
> =A0hugepages from sysfs or procfs, and reserve them by mmap or shmget.

    Just like before, you're specifying the how and the what, but not
the why behind the test. Please describe why you are doing this.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly =

Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
