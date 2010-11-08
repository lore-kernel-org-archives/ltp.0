Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PFZbG-0000VD-Kh
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:50:02 +0000
Received: from mail-ww0-f41.google.com ([74.125.82.41])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PFZbF-00031B-KZ
	for ltp-list@lists.sourceforge.net; Mon, 08 Nov 2010 21:50:02 +0000
Received: by wwb39 with SMTP id 39so432381wwb.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 08 Nov 2010 13:49:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4CD7A289.8020002@cn.fujitsu.com>
References: <4CCA1F3E.5000202@cn.fujitsu.com> <4CD7A289.8020002@cn.fujitsu.com>
Date: Mon, 8 Nov 2010 13:49:55 -0800
Message-ID: <AANLkTikTMn2iK9dNk4btxidwvsKvG9Z7Sd27C78qFssq@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
To: Bian Naimeng <biannm@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Sun, Nov 7, 2010 at 11:11 PM, Bian Naimeng <biannm@cn.fujitsu.com> wrote:
> Bian Naimeng wrote:
>> Open posix documents point lio_listio may return EINTR caused by a await=
ed I/O requst
>> completion signal.
>>
>> [EINTR]
>> =A0 =A0 A signal was delivered while waiting for all I/O requests to com=
plete during an
>> =A0 =A0 LIO_WAIT operation. Note that, since each I/O operation invoked =
by lio_listio()
>> =A0 =A0 may possibly provoke a signal when it completes, this error retu=
rn may be caused
>> =A0 =A0 by the completion of one (or more) of the very I/O operations be=
ing awaited.
>> =A0 =A0 Outstanding I/O requests are not canceled, and the application s=
hall examine each
>> =A0 =A0 list element to determine whether the request was initiated, can=
celed, or completed.
>>
>> So it's unnecessary to setup handler for IO operation completion, we jus=
t need check
>> the aio_error and aio_return for each request, it has same effect on che=
cking
>> received_selected.
>>
>> Signed-off-by: Bian Naimeng <biannm@cn.fujitsu.com>
>>
>
> =A0Hi Garrett,
>
> =A0 =A0Would you like to pick up this patch? =A0Any reply is helpful to m=
e, so please let me
> =A0know what's your opinion if you are free. ^_^

I have some potential concerns with the above patch. Let me fully
digest it and I'll get back to you.

---------------------------------------------------------------------------=
---
The Next 800 Companies to Lead America's Growth: New Video Whitepaper
David G. Thomson, author of the best-selling book "Blueprint to a =

Billion" shares his insights and actions to help propel your =

business during the next growth cycle. Listen Now!
http://p.sf.net/sfu/SAP-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
