Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jpalecek@web.de>) id 1NGi7g-0005jV-6X
	for ltp-list@lists.sourceforge.net; Sat, 05 Dec 2009 00:03:40 +0000
Received: from fmmailgate02.web.de ([217.72.192.227])
	by sfi-mx-4.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NGi7a-0002wU-N3
	for ltp-list@lists.sourceforge.net; Sat, 05 Dec 2009 00:03:40 +0000
References: <4b1944a0.8713f30a.3b2f.4a0fSMTPIN_ADDED@mx.google.com>
	<200912041413.11781.vapier@gentoo.org>
Date: Sat, 05 Dec 2009 01:03:26 +0100
MIME-Version: 1.0
From: =?iso-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Message-ID: <op.u4fuf0b9u2flwt@marcela-gaxm89c>
In-Reply-To: <200912041413.11781.vapier@gentoo.org>
Subject: Re: [LTP] [PATCH] Support for parallel compilation
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

On Fri, 04 Dec 2009 20:13:11 +0100, Mike Frysinger <vapier@gentoo.org>  
wrote:

> On Friday 04 December 2009 12:04:06 Jiri Palecek wrote:
>> -.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>> +.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>>  $(foreach tgt,$(RECURSIVE_TARGETS),$(addprefix
>>  trunk-subdir-$(tgt)--,$(SUBDIRS)))
>
> these foreach look like an overly complicated form of $(patsubst):
> 	$(patsubst %,moo_%,$(DIRS))

It may look like it, but they aren't. What you've written is a simple  
addprefix, while the foreach does some for of cartesian product  
($(TARGETS)x$(DIRS)).

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
