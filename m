Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1M4j1N-00037O-JV
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2009 22:03:21 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1M4j1D-0004FN-UY
	for ltp-list@lists.sourceforge.net; Thu, 14 May 2009 22:03:16 +0000
Message-ID: <4A0C9518.8040009@web.de>
Date: Fri, 15 May 2009 00:03:04 +0200
From: Jiri Palecek <jpalecek@web.de>
MIME-Version: 1.0
References: <E733EF347D18094EB0D8B89116EB269C01DF29F7@MADARRMAIL4.indra.es>
In-Reply-To: <E733EF347D18094EB0D8B89116EB269C01DF29F7@MADARRMAIL4.indra.es>
Subject: Re: [LTP] Error installing ltp-full-20090430
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
To: =?windows-1252?Q?=22Cobreces_=C1lvarez=2C_Ana_Maria=22?= <amcobreces@eservicios.indra.es>
Cc: ltp-list@lists.sf.net, =?windows-1252?Q?=22Bri=F1as_Alonso=2C_Fra?=@suse.de, =?windows-1252?Q?ncisco_Manuel=22?= <fbrinas@indra.es>

Cobreces =C1lvarez, Ana Maria wrote:
> When I run =93make all=94 with the default configuration, some errors
> appear. I send you the config.log file. =BFcould you please provide any
> answer on which is the problem?

 From the log file you provided, I can see you have a rather old kernel tha=
t =

lacks some of the tested features. However, this should not be a problem pe=
r se.

Could you send the actual errors you experience? ie. the output of "make al=
l", =

or "make -k all"?

Regards
     Jiri Palecek


---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables =

unlimited royalty-free distribution of the report engine =

for externally facing server and web deployment. =

http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
