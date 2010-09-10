Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Ou63n-0003v3-7s
	for ltp-list@lists.sourceforge.net; Fri, 10 Sep 2010 16:02:43 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Ou63l-0000KL-TS
	for ltp-list@lists.sourceforge.net; Fri, 10 Sep 2010 16:02:43 +0000
Received: by bwz12 with SMTP id 12so3112237bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 10 Sep 2010 09:02:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C8A0FEC.4010108@bull.net>
References: <4C8A0FEC.4010108@bull.net>
Date: Fri, 10 Sep 2010 09:02:35 -0700
Message-ID: <AANLkTin=EBzoyFVG_oOJiwYCYhkGEnJG2LtU1qeXFvDU@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] ltp-aiodio.part3 is the last scenario around aio which is
 not working properly
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
To: "Jacky.Malcles" <Jacky.Malcles@bull.net>
Cc: ltp-list@lists.sourceforge.net

On Fri, Sep 10, 2010 at 4:01 AM, Jacky.Malcles <Jacky.Malcles@bull.net> wrote:
> Hi Garet,
>
> I checked, running them, all the scenarios related to aio and there is now
> only ltp-aiodio.part3 that does not work properly;
> so, if you agree, I suggest the following patch, this allows us to have a
> set of working testcases while waiting for a cleaner solution,
> many thanks,

    I modified the script (ltp-aiodio.sh) to honor $TMP instead of
/test, so things should be ok now... please pull from git, test, and
let me know the outcome.
Thanks,
-Garrett

------------------------------------------------------------------------------
Automate Storage Tiering Simply
Optimize IT performance and efficiency through flexible, powerful, 
automated storage tiering capabilities. View this brief to learn how
you can reduce costs and improve performance. 
http://p.sf.net/sfu/dell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
