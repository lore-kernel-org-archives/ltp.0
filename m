Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1My9Na-0005oo-1O
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:19:22 +0000
Received: from mail-px0-f180.google.com ([209.85.216.180])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1My9NT-00031C-Qd
	for ltp-list@lists.sourceforge.net; Wed, 14 Oct 2009 19:19:21 +0000
Received: by pxi10 with SMTP id 10so45446pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Wed, 14 Oct 2009 12:19:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A0780153D4DC@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780153D4DC@svexch01.mvista.com>
Date: Wed, 14 Oct 2009 12:19:05 -0700
Message-ID: <364299f40910141219q59e9b87evdfe4a5f2e131b7f4@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH][rwtest] use default size for blks if parsing df
	output fails to return numeric argument
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Wed, Oct 14, 2009 at 12:04 PM, Henry Yei <hyei@mvista.com> wrote:
> All,
>
> This patch for rwtest.sh sets a default size for the number of blocks within the filesystem the test is executing on if parsing "df output" somehow results in a non-numeric value(unexpected df output). Also removes trailing whitespace.
>
> Signed-off-by: Henry Yei <hyei@mvista.com>
>
>
> Garret,
>
> Per message Subject: [LTP] [issue 8] rwtest*: iogen / rwtest needs to createprerequisite directory paths,
> Would a simple mkdir suffice inside the rwtest script to handle that issue?

mkdir -p would, yup!
Thanks,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
