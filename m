Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Date: Tue, 14 Sep 2010 08:58:09 -0500
From: "Serge E. Hallyn" <serge.hallyn@canonical.com>
Message-ID: <20100914135808.GA29733@hallyn.com>
References: <AANLkTikNqwWCuz0zo9mfM1ju=ahU15L7i2ovUj130khP@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikNqwWCuz0zo9mfM1ju=ahU15L7i2ovUj130khP@mail.gmail.com>
Subject: Re: [LTP] ima
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net, Ltp-list-request@lists.sourceforge.net, Mimi Zohar <zohar@us.ibm.com>

Quoting ARJIT SHARMA (joyarjit@gmail.com):
> hi,
>      in ima testcase all the 4 testcases are failing because of error as
> "cannot mount security fs"
>      Why is this error coming......please tell me.....

Do you have CONFIG_SECURITYFS=y ?

-serge

------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
