Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1P0yOO-0006QO-7o
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 15:16:24 +0000
Received: from mail-gx0-f175.google.com ([209.85.161.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P0yON-0005NH-An
	for ltp-list@lists.sourceforge.net; Wed, 29 Sep 2010 15:16:24 +0000
Received: by gxk10 with SMTP id 10so389563gxk.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 29 Sep 2010 08:16:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001cb5fa4$3def0160$b9cd0420$@co.jp>
References: <000001cb5fa4$3def0160$b9cd0420$@co.jp>
Date: Wed, 29 Sep 2010 08:16:17 -0700
Message-ID: <AANLkTikD7h4KtrtUkCkOWciQ9EKG5eL6g-dj_5=Ode62@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] POSIX some testsets failed by permission error
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Wed, Sep 29, 2010 at 12:02 AM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
>
> I noticed that following POSIX testsets failed with "Permission denied".
> =A0- pthread_attr_getschedparam/2-1
> =A0- pthread_attr_setschedparam/2-1
> =A0- pthread_rwlock_destroy/2-1
>
> ------------
> conformance/interfaces/pthread_attr_getschedparam/2-1: execution: FAILED:
> Output:
> Unable to run child application: Permission denied
> [...]
> conformance/interfaces/pthread_attr_setschedparam/2-1: execution: FAILED:
> Output:
> Unable to run child application: Permission denied
> [...]
> conformance/interfaces/pthread_rwlock_destroy/2-1: execution: FAILED:
> Output:
> Unable to run child application: Permission denied
> ------------
>
> They are shell scripts, but they weren't given rights of execution.
>
> It is necessary to give them rights of execution and to make them
> into package, I think.

How did you execute the tests?
-Garrett

---------------------------------------------------------------------------=
---
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
