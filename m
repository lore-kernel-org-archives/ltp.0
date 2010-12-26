Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PWqVJ-0006qI-Vl
	for ltp-list@lists.sourceforge.net; Sun, 26 Dec 2010 13:19:17 +0000
Date: Sun, 26 Dec 2010 14:34:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101226133420.GB6473@saboteur.suse.cz>
References: <4CCA1F3E.5000202@cn.fujitsu.com> <4CD7A289.8020002@cn.fujitsu.com>
	<AANLkTikTMn2iK9dNk4btxidwvsKvG9Z7Sd27C78qFssq@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikTMn2iK9dNk4btxidwvsKvG9Z7Sd27C78qFssq@mail.gmail.com>
Subject: Re: [LTP] [POSIX][PATCH]A awaited IO request completion signal can
 case lio_listio return EINTR.
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >> Open posix documents point lio_listio may return EINTR caused by a awa=
ited I/O requst
> >> completion signal.
> >>
> >> [EINTR]
> >> =A0 =A0 A signal was delivered while waiting for all I/O requests to c=
omplete during an
> >> =A0 =A0 LIO_WAIT operation. Note that, since each I/O operation invoke=
d by lio_listio()
> >> =A0 =A0 may possibly provoke a signal when it completes, this error re=
turn may be caused
> >> =A0 =A0 by the completion of one (or more) of the very I/O operations =
being awaited.
> >> =A0 =A0 Outstanding I/O requests are not canceled, and the application=
 shall examine each
> >> =A0 =A0 list element to determine whether the request was initiated, c=
anceled, or completed.
> >>
> >> So it's unnecessary to setup handler for IO operation completion, we j=
ust need check
> >> the aio_error and aio_return for each request, it has same effect on c=
hecking
> >> received_selected.
> >>
> >> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
> >>
> >
> > =A0Hi Garrett,
> >
> > =A0 =A0Would you like to pick up this patch? =A0Any reply is helpful to=
 me, so please let me
> > =A0know what's your opinion if you are free. ^_^
> =

> I have some potential concerns with the above patch. Let me fully
> digest it and I'll get back to you.
>

Ping. The patch seems to be reasonable.

-- =

Cyril Hrubis
chrubis@suse.cz

---------------------------------------------------------------------------=
---
Learn how Oracle Real Application Clusters (RAC) One Node allows customers
to consolidate database storage, standardize their database environment, an=
d, =

should the need arise, upgrade to a full multi-node Oracle RAC database =

without downtime or disruption
http://p.sf.net/sfu/oracle-sfdevnl
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
