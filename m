Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGjJ7-000052-D5
	for ltp-list@lists.sourceforge.net; Sat, 05 Dec 2009 01:19:33 +0000
Received: from fmmailgate01.web.de ([217.72.192.221])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGjIz-0006Xq-5r
	for ltp-list@lists.sourceforge.net; Sat, 05 Dec 2009 01:19:33 +0000
References: <4b1940f3.8413f30a.2877.6a27SMTPIN_ADDED@mx.google.com>
	<200912041406.40770.vapier@gentoo.org>
Date: Sat, 05 Dec 2009 02:19:13 +0100
MIME-Version: 1.0
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Message-ID: <op.u4fxyb2ou2flwt@marcela-gaxm89c>
In-Reply-To: <200912041406.40770.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Don't install datafiles with executable mode
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
To: Mike Frysinger <vapier@gentoo.org>, ltp-list@lists.sourceforge.net

On Fri, 04 Dec 2009 20:06:40 +0100, Mike Frysinger <vapier@gentoo.org>  
wrote:

> On Friday 04 December 2009 11:58:13 Jiri Palecek wrote:
>> the makefiles install all files with executable mode by default. This  
>> patch
>>  changes it for some of the Makefiles, that install data files, which
>>  should IMHO not be executable. The change makes INSTALL_MODE decide the
>>  actual mode when it is expanded inside the install rule (depending on  
>> $@,
>>  which is the install target name).
>
> that's pretty fugly way to go about it.  let's go the more natural route  
> and
> have the common code default to $(INSTALL_MODE_$@) and if that's unset,  
> use
> the default $(INSTALL_MODE).

Sorry, but I don't agree with that. This is a function-like approach which  
is not any less "natural" than what you propose - and it makes no demands  
on anyone who doesn't need it, and gives great power to those who need it.

The main reason I don't like the INSTALL_MODE_$@ thing, is that eg.  
INSTALL_TARGETS can contain wildcards (eg. dir/*.ext), and there cannot be  
any such thing as $(INSTALL_MODE_dir/*.ext). You would have to enumerate  
all data files - or all program files - which would be a chore esp. if any  
of these isn't known in the makefile until "make all" is ran.

OTOH I would agree on some method to automagically determine the correct  
mode.

   Jiri Palecek

------------------------------------------------------------------------------
Join us December 9, 2009 for the Red Hat Virtual Experience,
a free event focused on virtualization and cloud computing. 
Attend in-depth sessions from your desk. Your couch. Anywhere.
http://p.sf.net/sfu/redhat-sfdev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
