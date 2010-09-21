Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Oy4zg-00022Q-HX
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 15:42:56 +0000
Received: from mail-yx0-f175.google.com ([209.85.213.175])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Oy4zf-0008F2-Aq
	for ltp-list@lists.sourceforge.net; Tue, 21 Sep 2010 15:42:56 +0000
Received: by yxg6 with SMTP id 6so2288699yxg.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 21 Sep 2010 08:42:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000101cb5956$14a99a30$3dfcce90$@co.jp>
References: <000101cb5956$14a99a30$3dfcce90$@co.jp>
Date: Tue, 21 Sep 2010 08:42:49 -0700
Message-ID: <AANLkTinw+GczTRmptpcBHh4WabOKqAdFCGL0Tdk5K6wW@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH] fix "sysctl03" test
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
To: Mitani <mitani@ryobi.co.jp>
Cc: ltp-list@lists.sourceforge.net

On Mon, Sep 20, 2010 at 11:27 PM, Mitani <mitani@ryobi.co.jp> wrote:
> Hi,
>
> I noticed that "sysctl03" failed from about August 17.
> "PASS" is indicated in the log file of "runltp -l", but "TFAIL" is
> indicated in console log:

Thanks for the keen eye and sorry for getting this backwards :/.
-Garrett

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
