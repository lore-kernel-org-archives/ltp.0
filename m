Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NLqxe-000771-PL
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:30:34 +0000
Received: from mail-px0-f189.google.com ([209.85.216.189])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NLqxW-0001An-K6
	for ltp-list@lists.sourceforge.net; Sat, 19 Dec 2009 04:30:32 +0000
Received: by pxi27 with SMTP id 27so831624pxi.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 18 Dec 2009 20:30:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <op.u45xfvwou2flwt@debian>
References: <4b1944a0.8713f30a.3b2f.4a0fSMTPIN_ADDED@mx.google.com>
	<200912041413.11781.vapier@gentoo.org>
	<op.u4fuf0b9u2flwt@marcela-gaxm89c>
	<364299f40912050001k12c39c45sa5b870851ca915ad@mail.gmail.com>
	<op.u45xfvwou2flwt@debian>
Date: Fri, 18 Dec 2009 20:30:20 -0800
Message-ID: <364299f40912182030n73761bd1re0cc3a0a2ba1fd42@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
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
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: =?ISO-8859-2?B?Smn47SBQYWxl6GVr?= <jpalecek@web.de>
Cc: ltp-list@lists.sourceforge.net, Mike Frysinger <vapier@gentoo.org>

2009/12/18 Ji=F8=ED Pale=E8ek <jpalecek@web.de>:
> Hello,
>
> On Sat, 05 Dec 2009 09:01:52 +0100, Garrett Cooper <yanegomi@gmail.com>
> wrote:
>
>> On Fri, Dec 4, 2009 at 4:03 PM, Ji=F8=ED Pale=E8ek <jpalecek@web.de> wro=
te:
>>>
>>> On Fri, 04 Dec 2009 20:13:11 +0100, Mike Frysinger <vapier@gentoo.org>
>>> wrote:
>>>
>>>> On Friday 04 December 2009 12:04:06 Jiri Palecek wrote:
>>>>>
>>>>> -.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>>>>> +.PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>>>>> =A0$(foreach tgt,$(RECURSIVE_TARGETS),$(addprefix
>>>>> =A0trunk-subdir-$(tgt)--,$(SUBDIRS)))
>>>>
>>>> these foreach look like an overly complicated form of $(patsubst):
>>>> =A0 =A0 =A0 $(patsubst %,moo_%,$(DIRS))
>>>
>>> It may look like it, but they aren't. What you've written is a simple
>>> addprefix, while the foreach does some for of cartesian product
>>> ($(TARGETS)x$(DIRS)).
>>
>> 1. I checked in the fixes for the autotools targets after verifying
>> them (thank you btw!).
>> 2. Inline mkdirs are bad, because mkdir's can fail or cause failures
>> over NFS due to excessive I/O, which is why I quickly removed the test
>> -d || mkdir -p logic in the 2nd major draft of the makefile
>> infrastructure.
>
> OK.
>
>> 3. Although your idea for fixing the lack of recursive make'ing is
>> good, what about this instead?
>>
>> #
>> # A canned set of operations for leaf makes. This creates a series of
>> targets, like:
>> #
>> # $(subdir)-all $(subdir)-clean $(subdir)-install:
>> #
>> # 1 - Recursive targets to act upon.
>> # 2 - the subdirectory to do the leaf_make on.
>> #
>> define generate_dir_dep
>> ifndef __$(1)_dir_dep__
>> __$(1)_dir_dep__ =3D 1
>> $(1):
>> =A0 =A0 =A0 =A0mkdir -p "$$@"
>> endif
>> endif
>>
>> define leaf_make
>> $$(foreach recursive_target,$(1),$$(addprefix
>> $(2)-$$(recursive_target))): $(1)-%: $(2)
>> =A0 =A0 =A0$(MAKE) -C $* -f ""$(abs_srcdir)/$$*/Makefile" $$(patsubst
>> $(1)-%,%,$$@)
>> endef
>> $(foreach subdir $(SUBDIRS),$(eval $(call generate_dir_dep,$(subdir))))
>> $(foreach subdir,$(SUBDIRS),$(eval $(call leaf_make
>> $(RECURSIVE_TARGETS),$(subdir))
>>
>> Ultimately I suppose, it's another means to a similar end. It's just a
>> bit more discrete as to what's going on in the operation... if this is
>> a good idea, I'll modify functions.mk to match this. $(abspath) //
>> $(realpath) junk is already a PITA, so it might be a good idea just to
>> remove it in favor of keeping things as-is.
>
> Well, I can't say I got used to your generated rules and double dollars
> (you've got $* instead of $$* in the above IMHO). But if you deem it bett=
er,
> fine by me.

    Yes, you're right on the s/\Q$*\E/\Q$$*\E/. The $$ is required, as
per http://www.gnu.org/software/make/manual/make.html#Eval-Function,
unless I use $(value) (I just tested out this function and it
functions as expected on 3.80).
    My primary concern when we're doing these changes is that the
changes need to be as straightforward as possible. If you disagree,
please let me know. My offer was as much of a proposal as your's was.
I see a great deal of value in what you're proposing, so please feel
free to let me know what you feel :).
Thanks!
-Garrett

---------------------------------------------------------------------------=
---
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev =

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
