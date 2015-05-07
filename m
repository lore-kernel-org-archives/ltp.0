Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YqLVa-0002ry-11
	for ltp-list@lists.sourceforge.net; Thu, 07 May 2015 13:06:34 +0000
Date: Thu, 7 May 2015 15:05:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150507130558.GB28637@rei.suse.de>
References: <CAGMUi-D7ziRtBGaFcqy1i1CBbgLzqwiVY5Fq5W8a7=m=3yYLbw@mail.gmail.com>
	<CAGMUi-BhFdOmi0DNuXqOt__+WakP+bOiqHJbEHiarqtjMGF4Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAGMUi-BhFdOmi0DNuXqOt__+WakP+bOiqHJbEHiarqtjMGF4Ww@mail.gmail.com>
Subject: Re: [LTP] LTP-DDT build error
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
To: Narendra Kumar <narendrakumar.chepuri@gmail.com>
Cc: ltp-list@lists.sf.net

Hi!
>            May I know how to test the usb using testusb.c in of ltp my
> devices are like /dev/bus/usb/001/001, I am tryng both ./testusb -a and
> ./testusb -D  /dev/bus/usb/001/001 first one is giving "no test devices
> recognized" and second command is returning "./testusb:
> /dev/bus/usb/001/001 may see only control tests\n /dev/bus/usb/001/001 test
> 0 --> 38 (Function not implemented)".

You are asking on wrong mailing list. LTP-DDT is based on LTP but
developed by TI and the testusb testcases are developed by them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
