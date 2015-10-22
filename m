Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vichy.kuo@gmail.com>) id 1Zp8d3-00077H-FB
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2015 05:41:33 +0000
Received: from mail-oi0-f44.google.com ([209.85.218.44])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zp8d2-000357-Qo
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2015 05:41:33 +0000
Received: by oiao187 with SMTP id o187so41907988oia.3
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2015 22:41:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANKSX+EC8p803DByyYE4ECw11gQk4a3Hr1SKZXpPPjw8aoz-fQ@mail.gmail.com>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
	<CANKSX+EC8p803DByyYE4ECw11gQk4a3Hr1SKZXpPPjw8aoz-fQ@mail.gmail.com>
Date: Thu, 22 Oct 2015 13:41:27 +0800
Message-ID: <CAOVJa8HkBesYGEuEocDWgeSUpGxntKFEPnS7vU6xjR+4maWYsw@mail.gmail.com>
From: vichy <vichy.kuo@gmail.com>
Subject: Re: [LTP] how to cross compile linux test project?
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
To: srikanth007m@gmail.com
Cc: ltp-list@lists.sourceforge.net

hi Strik:

2015-10-21 23:59 GMT+08:00 $rik@nth <srikanth007m@gmail.com>:
> you need to run autoconf program with no arguments and then autoconf
> processes `configure.ac' to generate configure file.
when i use autoconf I get below error message
# autoconf
configure.ac:4: error: possibly undefined macro: AM_INIT_AUTOMAKE
      If this token and others are legitimate, please use m4_pattern_allow.
      See the Autoconf documentation.
configure.ac:15: error: possibly undefined macro: AM_CONDITIONAL
#

I use ubuntu 14.04 64bit to cross compile linux test project.
appreciate your kind help,

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
