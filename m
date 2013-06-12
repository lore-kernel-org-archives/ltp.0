Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UmngB-0000yz-4D
	for ltp-list@lists.sourceforge.net; Wed, 12 Jun 2013 16:13:47 +0000
Date: Wed, 12 Jun 2013 18:15:11 +0200
From: chrubis@suse.cz
Message-ID: <20130612161511.GA14096@rei>
References: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
Subject: Re: [LTP] Help compiling in AIX 6.1
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
To: Ismael Farf??n <sulfurfff@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> We have this AIX 6.1 box running LTP 2005-something. Now I'm trying to
> compile 20130109 without much luck.
> 
> I'm running this without much luck:
> 
> ./configure
> gmake
> 

What is you gmake version? Note that we support 3.80 and newer.

Also running the LTP on AIX is not supported nor tested, so you are on
your own...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
