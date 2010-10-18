Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P7mg7-0007Zv-Od
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:10:51 +0000
Received: from mail-iw0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P7mg6-0000EP-W4
	for ltp-list@lists.sourceforge.net; Mon, 18 Oct 2010 10:10:51 +0000
Received: by iwn2 with SMTP id 2so1119576iwn.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 18 Oct 2010 03:10:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201010132342.48804.vapier@gentoo.org>
References: <450673838.432411287026581092.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<201010132342.48804.vapier@gentoo.org>
Date: Mon, 18 Oct 2010 03:10:44 -0700
Message-ID: <AANLkTi=VJx_JTuyGrMa=Y3FhnyUoOMLrKYMAbMakMZcB@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH v6] mmap/munmap /dev/zero: a common way of
 malloc()/free() anonymous memory on Solaris
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, CAI Qian <caiqian@redhat.com>

On Wed, Oct 13, 2010 at 8:42 PM, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday, October 13, 2010 23:23:01 CAI Qian wrote:
>> +void help()
>
> another "(void)" fix
>
> otherwise, assuming it does as you intended, i have no complaints left ;)

+1

------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
