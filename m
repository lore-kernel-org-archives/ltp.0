Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hyei@mvista.com>) id 1O7wDA-0001V6-9w
	for ltp-list@lists.sourceforge.net; Fri, 30 Apr 2010 19:49:20 +0000
Received: from mail-px0-f174.google.com ([209.85.212.174])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1O7wD8-0003zK-Va
	for ltp-list@lists.sourceforge.net; Fri, 30 Apr 2010 19:49:19 +0000
MIME-Version: 1.0
In-Reply-To: <s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
References: <103530624.1121001272433642504.JavaMail.root@zmail04.collab.prod.int.phx2.redhat.com>
	<8B8139E0-F07A-433D-B38D-30DAB81E3FF5@gmail.com>
	<s2r700385ec1004272327n8b26491bt3609f8877b71a385@mail.gmail.com>
From: Henry Yei <hyei@mvista.com>
Date: Fri, 30 Apr 2010 12:27:04 -0700
Message-ID: <m2z42aa607e1004301227tfec6a200kda741f32b6feeb11@mail.gmail.com>
Subject: Re: [LTP] UTIMENSAT test fails hugely
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
To: Garrett Cooper <yanegomi@gmail.com>, ltp-list <ltp-list@lists.sf.net>

Speaking of the utimesat test and prerequisites, our test systems
don't have a sudoers file by default, so we have an internal patch to
utimesat to create a default one if non exist and remove it after the
test is done. Would that be of interest to LTP?

Henry Yei <hyei@mvista.com>





On Tue, Apr 27, 2010 at 11:27 PM, Caspar Zhang <casparant@gmail.com> wrote:
> On Wed, Apr 28, 2010 at 2:04 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> The first item is different from the other two. The first one ignores the
>> signal (SIG_IGN), whereas the latter two cases reset the handler to the
>> default one (SIG_DFL). I prefer the former format, because otherwise the
>> signal handlers become reentrable on accident.
>
> I see. Thank you.
>
> The final patch ;-)
>
> Cheers,
> -Caspar
>
> --
> Tags: Ant, Beijing, BUPT, Caspar, Kernel QA, Linux, Open Source,
> Photography, Programmer, Red Hat Inc., Zhejianger, etc.
>
> Current: Kernel Associate Quality Engineer @ Red Hat Inc.
>
> Home Page: http://www.CasparZhang.com/
>
> ------------------------------------------------------------------------------
>
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
>

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
