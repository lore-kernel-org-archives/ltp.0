Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1ZKiXd-0005Wf-Jl
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 07:46:13 +0000
Received: from mx2.suse.de ([195.135.220.15])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZKiXc-00063p-5k
	for ltp-list@lists.sourceforge.net; Thu, 30 Jul 2015 07:46:13 +0000
Date: Thu, 30 Jul 2015 09:45:54 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150730074554.GA27713@rei.suse.de>
References: <CANKSX+HAqaZARVLcDWU3Uhv2CYDjSBrrq2H4OrkOSaY647saaA@mail.gmail.com>
	<20150729144508.GB3427@rei.suse.de>
	<CANKSX+ETp0jdXp+zSUtUPn8SWUQaCh1bETYzcpF_C8kZpPtGdQ@mail.gmail.com>
	<20150729152949.GA6478@rei.suse.de>
	<1186607709.563342.1438184803657.JavaMail.zimbra@redhat.com>
	<20150729155005.GC3427@rei.suse.de>
	<CANKSX+EukvUBmjMf7TMxTzcsMXmzfGb+FYqrdo7vKnEiLb6wyg@mail.gmail.com>
	<20150729194515.GA7009@rei.suse.de>
	<CANKSX+FRJcg3xmc2BbWiDzmSqT2NC+hQib-UsWA4yoWTq8fB3g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANKSX+FRJcg3xmc2BbWiDzmSqT2NC+hQib-UsWA4yoWTq8fB3g@mail.gmail.com>
Subject: Re: [LTP] LTP make failed
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
To: "$rik@nth " <srikanth007m@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> Can you tell me what kind of steps you followed to cross compile LTP
> for arm? Does it make any difference from the configure what i am
> using and you.

I've just installed arm cross compiler and used the configure parameters
you send. But I've removed the CFLAGS=-static, passing -static to CFLAGS
is wrong and indeed it breaks at testcases/ade/ldd/ that creates dynamic
library for testing ldd binary.

> memtest suite? can you point me to the location

https://en.wikipedia.org/wiki/Memtest86

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
