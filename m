Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <vichy.kuo@gmail.com>) id 1Zp8mq-0006Hr-8C
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2015 05:51:40 +0000
Received: from mail-oi0-f65.google.com ([209.85.218.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Zp8mp-0001uM-DK
	for ltp-list@lists.sourceforge.net; Thu, 22 Oct 2015 05:51:40 +0000
Received: by oies6 with SMTP id s6so3860670oie.2
	for <ltp-list@lists.sourceforge.net>;
	Wed, 21 Oct 2015 22:51:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOVJa8HkBesYGEuEocDWgeSUpGxntKFEPnS7vU6xjR+4maWYsw@mail.gmail.com>
References: <CAOVJa8FYtVzST_sEkeWxaEVFCC1FBo_ASgDjncAy50AaYiFGhA@mail.gmail.com>
	<CANKSX+EC8p803DByyYE4ECw11gQk4a3Hr1SKZXpPPjw8aoz-fQ@mail.gmail.com>
	<CAOVJa8HkBesYGEuEocDWgeSUpGxntKFEPnS7vU6xjR+4maWYsw@mail.gmail.com>
Date: Thu, 22 Oct 2015 13:51:33 +0800
Message-ID: <CAOVJa8GOZO=ZSVteHiqXdjy4iXN+7Jkz5-AXPhtXQ=s2KmgGPQ@mail.gmail.com>
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

hi all:

2015-10-22 13:41 GMT+08:00 vichy <vichy.kuo@gmail.com>:
> hi Strik:
>
> 2015-10-21 23:59 GMT+08:00 $rik@nth <srikanth007m@gmail.com>:
>> you need to run autoconf program with no arguments and then autoconf
>> processes `configure.ac' to generate configure file.
> when i use autoconf I get below error message
> # autoconf
> configure.ac:4: error: possibly undefined macro: AM_INIT_AUTOMAKE
>       If this token and others are legitimate, please use m4_pattern_allow.
>       See the Autoconf documentation.
> configure.ac:15: error: possibly undefined macro: AM_CONDITIONAL
> #
>
> I use ubuntu 14.04 64bit to cross compile linux test project.
forget to mentioned
Below is my autoconf version

autoconf (GNU Autoconf) 2.65
Copyright (C) 2009 Free Software Foundation, Inc.
License GPLv3+/Autoconf: GNU GPL version 3 or later
<http://gnu.org/licenses/gpl.html>, <http://gnu.org/licenses/exceptions.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Written by David J. MacKenzie and Akim Demaille.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
