Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N6xDw-00013M-Mh
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 02:09:48 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N6xDq-0006dA-7x
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 02:09:48 +0000
Received: by pzk26 with SMTP id 26so1435359pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Sat, 07 Nov 2009 18:09:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40911061654w221b10f9i10bcb2a3e3b35aee@mail.gmail.com>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061809.05115.vapier@gentoo.org>
	<20091106233422.GB6619@count0.beaverton.ibm.com>
	<200911061923.09848.vapier@gentoo.org>
	<364299f40911061652l5cf3ac19h696152cdfebb547d@mail.gmail.com>
	<364299f40911061654w221b10f9i10bcb2a3e3b35aee@mail.gmail.com>
Date: Sat, 7 Nov 2009 18:09:36 -0800
Message-ID: <364299f40911071809r2c47b9d4mfd6a60011fdcd9ce@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] LTP 20091031 Makefiles totally broken?!?
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net, Andi Kleen <andi@firstfloor.org>

On Fri, Nov 6, 2009 at 4:54 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Nov 6, 2009 at 4:52 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Fri, Nov 6, 2009 at 4:23 PM, Mike Frysinger <vapier@gentoo.org> wrote:
>>> On Friday 06 November 2009 18:34:22 Matt Helsley wrote:
>>>> On Fri, Nov 06, 2009 at 06:09:04PM -0500, Mike Frysinger wrote:
>>>> > On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
>>>> > > On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
>>>> > > > also, i thought we were going to rename the top level Makefile to
>>>> > > > GNUmakefile and add a dummy Makefile that just spat out "sorry, =
ltp
>>>> > > > requires GNU make".
>>>> > >
>>>> > > Bleh. Can't we just check the output of $(MAKE) --version rather t=
han
>>>> > > assume other makes use "Makefile"?
>>>> >
>>>> > the assumption is that only GNU make parses "GNUmakefile". =A0i think
>>>> > that's a pretty safe assumption.
>>>>
>>>> Right, but GNU Make also parses Makefile.
>>>
>>> not if a GNUmakefile exists in the same dir, or the user forces the iss=
ue via
>>> the -f flag
>>>
>>>> If some poor bastard runs:
>>>>
>>>> make -f Makefile
>>>>
>>>> where GNU Make is "make" they may be further confused. Seems like it's
>>>> better to check what's actually running ($(MAKE)) or will run
>>>> (like `which make` in configure) than rely on a filename hack like thi=
s.
>>>
>>> said poor bastard should be smacked :p. =A0checking the value of $(MAKE=
) wont
>>> work as it could be an arbitrary number of things which could all be va=
lid
>>> values under GNU make. =A0configure checks wont matter because it's the=
 user who
>>> runs `make` or `gmake` or `make-some-noise`. =A0requiring `make` to be =
GNU make
>>> in configure when the user can easily run `gmake` at make time is point=
less
>>> user interference.
>>>
>>> using a different filename on the other hand is exactly what GNU make h=
as
>>> designed in from the get go specifically for this purpose -- when GNU m=
ake is
>>> required. =A0if you honestly think people are doing something pointless=
 like
>>> `make -f Makefile`, then it's trivial to add a check to it to (1) check
>>> $(MAKE) --version and include GNUmakefile or (2) $(error out). =A0no po=
int in
>>> forcing the shell/etc... overhead in the default build for the majority=
 of
>>> users.
>>
>> No, but you can do something like:
>>
>> ifdef MAKE_SANITY_CHECK
>> export MAKE_SANITY_CHECK =3D 1
>> ifneq ($(lastword $(sort 3.80 $(MAKE_VERSION))),$(MAKE_VERSION))
>> $(error Upgrade your junk..)
>> endif
>> endif
>>
>> that way it only executes this once.
>
> Ugh... $(lastword ) didn't exist in 3.80... I'll change it around to
> $(firstword ).

Crap. So here are some of the high notes for changes between make 3.80 and =
3.81:

1. $(and ) and $(or ) didn't exist [we use $(or ) once]. This can be
replaced by an `ifeq ($(strip)) else endif'.
2. $(abspath ) // $(realpath ) didn't exist [we use $(abspath )
extensively, but just in one spot -- fixed that, need to test].
3. .DEFAULT_GOAL was originally .DEFAULT_TARGET, but DID NOT exist in
make 3.81 (this is going to be a bloody pain to hack around with,
maybe -- depends on where I put all:). It'll be like herding cats to
make sure that other developers don't create targets before the first
include.
4. Secondary expansion was busted as all hell in <3.81 (now this is
going to be a serious pain point in some areas because I'll have to
hunt down wherever I used % and $* and adjust things to work with make
3.80 -- this mostly affects the top-level Makefile).
5. Secondary expansion did NOT exist in static nor implicit rules
(another pain point -- mostly with the top-level Makefile).
6. $(lastword ) didn't exist [can be replaced by $(firstword ) with
inverse logic, maybe...].
7. Some funkiness with how .PHONY was treated:

2004-09-21  Boris Kolpackov  <boris@kolpackov.net>

        * file.c (snap_deps): Mark .PHONY prerequisites as targets.

8. Variable expansion was partially broken [used underlying caller
from $(subst ) instead of $(patsubst )].
9. Now this one flat out spooks me:

2004-03-20  Paul D. Smith  <psmith@gnu.org>

[...]

        * rule.c (count_implicit_rule_limits): Don't delete patterns which
        refer to absolute pathnames in directories that don't exist: some
        portion of the makefile could create those directories before we
        match the pattern.  Fixes bugs #775 and #108.

  This makes me think that out-of-build-tree could be REALLY broken with 3.=
80.

10. Ouch -- this is a really f'ed up bug:

2004-01-07  Paul D. Smith  <psmith@gnu.org>

[...]

        * job.c (construct_command_argv_internal): Add "!" to the list of
        shell escape chars.  POSIX sh allows it to appear before a
        command, to negate the exit code.  Fixes bug #6404.

11. Yipes -- this scares me because we do use implicit and pattern rules:

2003-04-19  Paul D. Smith  <psmith@gnu.org>

        Fix bug #1405: allow a target to match multiple pattern-specific
        variables.

        * rule.c (create_pattern_var, lookup_pattern_var): Move these to
        variable.c, where they've always belonged.
        * rule.h: Move the prototypes and struct pattern_var as well.
        * variable.c (initialize_file_variables): Invoke
        lookup_pattern_var() in a loop, until no more matches are found.
        If a match is found, create a new variable set for the target's
        pattern variables.  Then merge the contents of each matching
        pattern variable set into the target's pattern variable set.
        (lookup_pattern_var): Change this function to be usable
        in a loop.  It takes a starting position: if NULL, start at the
        beginning; if non-NULL, start with the pattern variable after that
        position, and return the next matching pattern.
        (create_pattern_var): Create a unique instance of
        pattern-specific variables for every definition in the makefile.
        Don't combine the same pattern together.  This allows us to
        process the variable handling properly even when the same pattern
        is used multiple times.
        (parse_variable_definition): New function: break out the parsing
        of a variable definition line from try_variable_definition.
        (try_variable_definition): Call parse_variable_definition to
        parse.
        (print_variable_data_base): Print out pattern-specific variables.
        * variable.h (struct variable): Remember when a variable is
        conditional.  Also remember its flavor.
        (struct pattern_var): Instead of keeping a variable set, we just
        keep a single variable for each pattern.
        * read.c (record_target_var): Each pattern variable contains only a
        single variable, not a set, so create it properly.
        * doc/make.texi (Pattern-specific): Document the new behavior

12. Hmmm -- this could get nasty:

2003-01-22  Paul D. Smith  <psmith@gnu.org>

        * function.c (func_call): Fix Bug #1744.  If we're inside a
        recursive invocation of $(call ...), mask any of the outer
        invocation's arguments that aren't used by this one, so that this
        invocation doesn't "inherit" them accidentally.

I'm concerned now that this is going to take 4 +/- 1 weekends to
complete and will be semi-painful to validate... The funny thing is
that our Makefiles were implementing some of this logic before (in a
hodgepodge manner), so this maybe some items like these were failing
in the past but not being caught, or were masked by all of the
explicit target specifications which are a MFPiTA to maintain.

Thoughts :\?

Thanks,
-Garrett

---------------------------------------------------------------------------=
---
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day =

trial. Simplify your report design, integration and deployment - and focus =
on =

what you do best, core application coding. Discover what's new with
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
