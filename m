Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NaLIh-0008Nr-Af
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 03:44:11 +0000
Received: from mail-pz0-f190.google.com ([209.85.222.190])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NaLIg-0006pG-EZ
	for ltp-list@lists.sourceforge.net; Thu, 28 Jan 2010 03:44:11 +0000
Received: by pzk28 with SMTP id 28so207225pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 27 Jan 2010 19:44:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <4B60DED0.70508@jp.fujitsu.com>
References: <4B5FCC2D.7070304@jp.fujitsu.com>
	<364299f41001270101s6821a3a3l64bf928e599073cc@mail.gmail.com>
	<4B60DED0.70508@jp.fujitsu.com>
Date: Wed, 27 Jan 2010 19:44:02 -0800
Message-ID: <364299f41001271944j7dcc647ch2c409f6ff763907e@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix aio_suspend/3-1
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
To: Yasuaki Ishimatsu <isimatu.yasuaki@jp.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

On Wed, Jan 27, 2010 at 4:48 PM, Yasuaki Ishimatsu
<isimatu.yasuaki@jp.fujitsu.com> wrote:
> Hi Garrett
>
>> =A0 =A0 Wouldn't it just be better to memset(&list, 0, sizeof(list)) the
>> array and just set that one array value to &aiocb[0]? Seems like a
>> much better idea...
>
> Thank you for your good idea.
> I applied it.

Committed -- thanks!
-Garrett

---------------------------------------------------------------------------=
---
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the busine=
ss
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
