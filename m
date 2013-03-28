Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ULDXV-0002Y3-PE
	for ltp-list@lists.sourceforge.net; Thu, 28 Mar 2013 14:10:49 +0000
Date: Thu, 28 Mar 2013 15:11:28 +0100
From: chrubis@suse.cz
Message-ID: <20130328141127.GB5788@rei.suse.cz>
References: <CA+YMQO_xOrCp0B5iS9+ek3kEmk5RUnzrbho0PdEoXfEP88apLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+YMQO_xOrCp0B5iS9+ek3kEmk5RUnzrbho0PdEoXfEP88apLQ@mail.gmail.com>
Subject: Re: [LTP] how to test gpio driver, usb driver,
 touch screen driver using ltp
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
To: "sujesh.k.p Kp" <sujeshlx@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
>   Please tell me how to test gpio diriver,usb  driver,touch screen driver
> using
>   LTP .

I've told this to several people allready (maybe I should start LTP FAQ
page).

The kernel module tests in LTP are abandoned and known to be broken. You
can look into them if you want but I can't help you there.


You can test the touchscreen driver with evtest (google evtest.c)
program that dumps raw events into the stdout. For the rest, I have no
idea.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Own the Future-Intel&reg; Level Up Game Demo Contest 2013
Rise to greatness in Intel's independent game demo contest.
Compete for recognition, cash, and the chance to get your game 
on Steam. $5K grand prize plus 10 genre and skill prizes. 
Submit your demo by 6/6/13. http://p.sf.net/sfu/intel_levelupd2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
