Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Subject: The results of your email commands
From: ltp-list-bounces@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6273273659159998852=="
Message-ID: <mailman.62257.1281964534.4910.ltp-list@lists.sourceforge.net>
Date: Mon, 16 Aug 2010 13:15:34 +0000
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: chrubis@suse.cz

--===============6273273659159998852==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

The results of your email command are provided below. Attached is your
original message.


- Unprocessed:
    > please help me by telling that how to disable the function "tst_rmdir()" in
    > LTP.
    > this function is causing lots of failures in many testcases.
    > mainly tests in dio testcase are failing because of some error in this
    > function.
    > i tried lots of things,like made the function "tst_rmdir()" to skip. Bt
    > still there is same error.
    > the error is like dat-----     "Tst_rmdir():failed:errno=16: device or
    > resource busy."
    > please help me out as soon as possible.
    > 
    Function tst_rmdir() does cleanup of temporary directories used for
    testing, when it's failing either you test setup or system is broken.
    Hmm errno 16 says that someone is still using these directories when
    test is going to delete them and exit. You could try to track this down
    with lsof and fuser.
    -- 
    Cyril Hrubis
    chrubis@suse.cz

- Done.


--===============6273273659159998852==
Content-Type: message/rfc822
MIME-Version: 1.0

Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>)
	id 1OkzXJ-0003ah-HD; Mon, 16 Aug 2010 13:15:33 +0000
X-ACL-Warn: 
Received: from cantor2.suse.de ([195.135.220.15] helo=mx2.suse.de)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OkzXD-0003oY-Bn; Mon, 16 Aug 2010 13:15:33 +0000
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 93D7588B6C;
	Mon, 16 Aug 2010 15:15:21 +0200 (CEST)
Date: Mon, 16 Aug 2010 15:33:00 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net,
	Ltp-list-request@lists.sourceforge.net
Subject: Re: [LTP] Help....
Message-ID: <20100816133300.GA26474@saboteur.suse.cz>
References: <AANLkTi=xTEhb3pOfzMv5-GE6uT8iQa6xTRWHVY050t39@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTi=xTEhb3pOfzMv5-GE6uT8iQa6xTRWHVY050t39@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	-0.0 T_RP_MATCHES_RCVD Envelope sender domain matches handover relay
	domain 0.0 AWL AWL: From: address is in the auto white-list
X-Headers-End: 1OkzXD-0003oY-Bn

Hi!
> please help me by telling that how to disable the function "tst_rmdir()" in
> LTP.
> this function is causing lots of failures in many testcases.
> mainly tests in dio testcase are failing because of some error in this
> function.
> i tried lots of things,like made the function "tst_rmdir()" to skip. Bt
> still there is same error.
> the error is like dat-----     "Tst_rmdir():failed:errno=16: device or
> resource busy."
> please help me out as soon as possible.
> 

Function tst_rmdir() does cleanup of temporary directories used for
testing, when it's failing either you test setup or system is broken.

Hmm errno 16 says that someone is still using these directories when
test is going to delete them and exit. You could try to track this down
with lsof and fuser.

-- 
Cyril Hrubis
chrubis@suse.cz


--===============6273273659159998852==--
