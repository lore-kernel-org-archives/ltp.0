Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Date: Thu, 16 Sep 2010 21:53:31 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20100916185331.GA1541@hannu-ubuntu>
References: <AANLkTim+EuMGgPZWxoZjAX0-4Mmrvfm_Jb_MpW3Y6QM+@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTim+EuMGgPZWxoZjAX0-4Mmrvfm_Jb_MpW3Y6QM+@mail.gmail.com>
Subject: Re: [LTP] rwtest03,rwtest04
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
Cc: ltp-list@lists.sourceforge.net, Ltp-list-request@lists.sourceforge.net

On 16/09/10 14:24 +0530, ARJIT SHARMA wrote:
> hello...
>          I am facing the error in rwtest03 and rwtest04, both of them are
> failing due to some data comparison error.
> 
>          Please help me out to sove this error, i am running LTP om ARM
> architechture...
> -- 
> Regards,
> Arjit Sharma.

Hi,

please include relevant parts from your logfiles.

> cd $LTPROOT
> ./runltp > your.log
> head -n 115 your.log
> grep FAILED result/LTP_RUN_ON-<your-run-date>.log

And dig also the few lines from and below those FAILED lines.

> failing due to some data comparison error.

br,
Hannu

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Start uncovering the many advantages of virtual appliances
and start using them to simplify application deployment and
accelerate your shift to cloud computing.
http://p.sf.net/sfu/novell-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
