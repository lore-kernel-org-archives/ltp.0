Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1PQFtT-0002WF-K9
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:00:59 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1PQFtS-00061P-Qr
	for ltp-list@lists.sourceforge.net; Wed, 08 Dec 2010 09:00:59 +0000
Received: by mail-ww0-f53.google.com with SMTP id 18so845852wwi.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Dec 2010 01:00:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0A8C979C21B8D745A471962AD91DBAD8495BCEF365@SAFEX1MAIL4.st.com>
References: <0A8C979C21B8D745A471962AD91DBAD8495BB8736E@SAFEX1MAIL4.st.com>
	<0A8C979C21B8D745A471962AD91DBAD8495BCEF365@SAFEX1MAIL4.st.com>
Date: Wed, 8 Dec 2010 01:00:58 -0800
Message-ID: <AANLkTinzsSWFMCyo6ZmmWhw6gyhqvGhqckStwO6XASb4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] Patch to cover fallocate issue
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

On Tue, Nov 30, 2010 at 5:10 AM, Francesco RUNDO <francesco.rundo@st.com> w=
rote:
> All,
>
>
>
> Any updates about the fallocate() issue I=92ve described (I sent the rela=
ted
> patch) below reported ?

Pretty sure this breaks 32-bit archs.
Thanks,
-Garrett

---------------------------------------------------------------------------=
---
What happens now with your Lotus Notes apps - do you make another costly =

upgrade, or settle for being marooned without product support? Time to move
off Lotus Notes and onto the cloud with Force.com, apps are easier to build,
use, and manage than apps on traditional platforms. Sign up for the Lotus =

Notes Migration Kit to learn more. http://p.sf.net/sfu/salesforce-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
