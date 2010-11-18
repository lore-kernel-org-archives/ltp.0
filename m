Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mitani@ryobi.co.jp>) id 1PItGi-00071a-Ad
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 01:26:32 +0000
Received: from out10.sjc.mx.trendmicro.com ([216.99.131.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1PItGg-0003w6-Ln
	for ltp-list@lists.sourceforge.net; Thu, 18 Nov 2010 01:26:32 +0000
Message-ID: <000001cb86bf$78f99850$6aecc8f0$@co.jp>
From: "Mitani" <mitani@ryobi.co.jp>
Date: Thu, 18 Nov 2010 10:25:23 +0900
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="--=_NextPart_ST_10_25_26_Thursday_November_18_2010_2266"
References: <000001cb8470$6662ddb0$33289910$@co.jp>	<AANLkTimGi4v_OHzZAD8BbyGKsuVzpBcokEECezPeTC8e@mail.gmail.com>	<000b01cb8481$c3c9a1d0$4b5ce570$@co.jp>	<AANLkTim3wqv3fS8Sg9TNvZ=nDuXGcTB4GmPcH4d9pEee@mail.gmail.com>	<001501cb848e$7e894960$7b9bdc20$@co.jp>	<AANLkTi=2ZMmCCHYFjX3ZK203hTHE9W=QTUZgDzkLyB=e@mail.gmail.com>	<000301cb8568$4a9060a0$dfb121e0$@co.jp>	<AANLkTi=Aia-KRKPT8JJtE_ts4jCPsDqjSF5cyhHMVjJo@mail.gmail.com>	<000601cb8603$7519a570$5f4cf050$@co.jp>	<AANLkTi=yU5JkGE496Gg5mOtaO2FRfdfF7wkNvUKEqnHu@mail.gmail.com>	<001601cb86b6$9d505ad0$d7f11070$@co.jp>
	<AANLkTi=V85s0-9tzTvdXtqedgQFABJWvW3pjQQ+F7DcM@mail.gmail.com>
In-Reply-To: <AANLkTi=V85s0-9tzTvdXtqedgQFABJWvW3pjQQ+F7DcM@mail.gmail.com>
Content-Language: ja
Subject: Re: [LTP] Realtime test failure
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: 'Garrett Cooper' <yanegomi@gmail.com>
Cc: ltp-list@lists.sourceforge.net, =?iso-2022-jp?B?GyRCYUQ6QhsoQiAbJEI3cjtUGyhC?= <toza@ryobi.co.jp>

This is a multi-part message in MIME format.

----=_NextPart_ST_10_25_26_Thursday_November_18_2010_2266
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit

> -----Original Message-----
> From: Garrett Cooper [mailto:yanegomi@gmail.com]
> Sent: Thursday, November 18, 2010 9:30 AM
> To: Mitani
> Cc: ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Realtime test failure
> 
> > Thank you for your response.
> >
> > I tried to build with "ltp-66d67b5.tar.gz", but it failed in configure.
> > Therefore, I tried with older git "ltp-92dfd5b.tar.gz", and it succeeded
> > in RHEL5.5-x86 and RHEL4.8-x86 systems.
> >
> > From "ltp-92dfd5b.tar.gz" to "ltp-66d67b5.tar.gz", new probrem occured.
> >
> > New revisions are released in sequence. Therefore I intend to build
> > with the latest version again.
> 
> Huh...? What do you mean failed in configure? Logs please (PS the
> latest snapshot is different from that)!
> Thanks,
> -Garrett


I send configure's logs.

I tried with "ltp-92dfd5b.tar.gz", "ltp-66d67b5.tar.gz" and
"ltp-86209d2.tar.gz".
Only "ltp-92dfd5b.tar.gz" succeeded.

> the latest snapshot is different from that

Yes. latest snapshot is  "ltp-86209d2.tar.gz". But it failed, too.
I send two logs just in case.

  - ltp-86209d2_configure.txt --- result of "ltp-86209d2.tar.gz"
  - ltp-66d67b5_configure.txt --- result of "ltp-66d67b5.tar.gz"


Thank you--


-Tomonori Mitani

----=_NextPart_ST_10_25_26_Thursday_November_18_2010_2266
Content-Type: application/x-zip-compressed;
	name="configure_logs.zip"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="configure_logs.zip"

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
UEsFBgAAAAACAAIAsAAAAJANAAAAAA==

----=_NextPart_ST_10_25_26_Thursday_November_18_2010_2266
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today
http://p.sf.net/sfu/msIE9-sfdev2dev
----=_NextPart_ST_10_25_26_Thursday_November_18_2010_2266
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

----=_NextPart_ST_10_25_26_Thursday_November_18_2010_2266--

