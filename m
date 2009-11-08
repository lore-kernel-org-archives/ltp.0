Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N7Dxr-0004lK-2y
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 20:02:19 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7Dxj-0004lR-5F
	for ltp-list@lists.sourceforge.net; Sun, 08 Nov 2009 20:02:19 +0000
Received: by pwi18 with SMTP id 18so1666087pwi.2
	for <ltp-list@lists.sourceforge.net>;
	Sun, 08 Nov 2009 12:02:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40911071809r2c47b9d4mfd6a60011fdcd9ce@mail.gmail.com>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061809.05115.vapier@gentoo.org>
	<20091106233422.GB6619@count0.beaverton.ibm.com>
	<200911061923.09848.vapier@gentoo.org>
	<364299f40911061652l5cf3ac19h696152cdfebb547d@mail.gmail.com>
	<364299f40911061654w221b10f9i10bcb2a3e3b35aee@mail.gmail.com>
	<364299f40911071809r2c47b9d4mfd6a60011fdcd9ce@mail.gmail.com>
Date: Sun, 8 Nov 2009 12:02:05 -0800
Message-ID: <364299f40911081202i70797af6uf5968839c60bb133@mail.gmail.com>
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

On Sat, Nov 7, 2009 at 6:09 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Fri, Nov 6, 2009 at 4:54 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Fri, Nov 6, 2009 at 4:52 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>> On Fri, Nov 6, 2009 at 4:23 PM, Mike Frysinger <vapier@gentoo.org> wrot=
e:
>>>> On Friday 06 November 2009 18:34:22 Matt Helsley wrote:
>>>>> On Fri, Nov 06, 2009 at 06:09:04PM -0500, Mike Frysinger wrote:
>>>>> > On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
>>>>> > > On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
>>>>> > > > also, i thought we were going to rename the top level Makefile =
to
>>>>> > > > GNUmakefile and add a dummy Makefile that just spat out "sorry,=
 ltp
>>>>> > > > requires GNU make".
>>>>> > >
>>>>> > > Bleh. Can't we just check the output of $(MAKE) --version rather =
than
>>>>> > > assume other makes use "Makefile"?
>>>>> >
>>>>> > the assumption is that only GNU make parses "GNUmakefile". =A0i thi=
nk
>>>>> > that's a pretty safe assumption.
>>>>>
>>>>> Right, but GNU Make also parses Makefile.
>>>>
>>>> not if a GNUmakefile exists in the same dir, or the user forces the is=
sue via
>>>> the -f flag
>>>>
>>>>> If some poor bastard runs:
>>>>>
>>>>> make -f Makefile
>>>>>
>>>>> where GNU Make is "make" they may be further confused. Seems like it's
>>>>> better to check what's actually running ($(MAKE)) or will run
>>>>> (like `which make` in configure) than rely on a filename hack like th=
is.
>>>>
>>>> said poor bastard should be smacked :p. =A0checking the value of $(MAK=
E) wont
>>>> work as it could be an arbitrary number of things which could all be v=
alid
>>>> values under GNU make. =A0configure checks wont matter because it's th=
e user who
>>>> runs `make` or `gmake` or `make-some-noise`. =A0requiring `make` to be=
 GNU make
>>>> in configure when the user can easily run `gmake` at make time is poin=
tless
>>>> user interference.
>>>>
>>>> using a different filename on the other hand is exactly what GNU make =
has
>>>> designed in from the get go specifically for this purpose -- when GNU =
make is
>>>> required. =A0if you honestly think people are doing something pointles=
s like
>>>> `make -f Makefile`, then it's trivial to add a check to it to (1) check
>>>> $(MAKE) --version and include GNUmakefile or (2) $(error out). =A0no p=
oint in
>>>> forcing the shell/etc... overhead in the default build for the majorit=
y of
>>>> users.
>>>
>>> No, but you can do something like:
>>>
>>> ifdef MAKE_SANITY_CHECK
>>> export MAKE_SANITY_CHECK =3D 1
>>> ifneq ($(lastword $(sort 3.80 $(MAKE_VERSION))),$(MAKE_VERSION))
>>> $(error Upgrade your junk..)
>>> endif
>>> endif
>>>
>>> that way it only executes this once.
>>
>> Ugh... $(lastword ) didn't exist in 3.80... I'll change it around to
>> $(firstword ).
>
> Crap. So here are some of the high notes for changes between make 3.80 an=
d 3.81:
>
> 1. $(and ) and $(or ) didn't exist [we use $(or ) once]. This can be
> replaced by an `ifeq ($(strip)) else endif'.
> 2. $(abspath ) // $(realpath ) didn't exist [we use $(abspath )
> extensively, but just in one spot -- fixed that, need to test].
> 3. .DEFAULT_GOAL was originally .DEFAULT_TARGET, but DID NOT exist in
> make 3.81 (this is going to be a bloody pain to hack around with,
> maybe -- depends on where I put all:). It'll be like herding cats to
> make sure that other developers don't create targets before the first
> include.
> 4. Secondary expansion was busted as all hell in <3.81 (now this is
> going to be a serious pain point in some areas because I'll have to
> hunt down wherever I used % and $* and adjust things to work with make
> 3.80 -- this mostly affects the top-level Makefile).
> 5. Secondary expansion did NOT exist in static nor implicit rules
> (another pain point -- mostly with the top-level Makefile).
> 6. $(lastword ) didn't exist [can be replaced by $(firstword ) with
> inverse logic, maybe...].
> 7. Some funkiness with how .PHONY was treated:
>
> 2004-09-21 =A0Boris Kolpackov =A0<boris@kolpackov.net>
>
> =A0 =A0 =A0 =A0* file.c (snap_deps): Mark .PHONY prerequisites as targets.
>
> 8. Variable expansion was partially broken [used underlying caller
> from $(subst ) instead of $(patsubst )].
> 9. Now this one flat out spooks me:
>
> 2004-03-20 =A0Paul D. Smith =A0<psmith@gnu.org>
>
> [...]
>
> =A0 =A0 =A0 =A0* rule.c (count_implicit_rule_limits): Don't delete patter=
ns which
> =A0 =A0 =A0 =A0refer to absolute pathnames in directories that don't exis=
t: some
> =A0 =A0 =A0 =A0portion of the makefile could create those directories bef=
ore we
> =A0 =A0 =A0 =A0match the pattern. =A0Fixes bugs #775 and #108.
>
> =A0This makes me think that out-of-build-tree could be REALLY broken with=
 3.80.
>
> 10. Ouch -- this is a really f'ed up bug:
>
> 2004-01-07 =A0Paul D. Smith =A0<psmith@gnu.org>
>
> [...]
>
> =A0 =A0 =A0 =A0* job.c (construct_command_argv_internal): Add "!" to the =
list of
> =A0 =A0 =A0 =A0shell escape chars. =A0POSIX sh allows it to appear before=
 a
> =A0 =A0 =A0 =A0command, to negate the exit code. =A0Fixes bug #6404.
>
> 11. Yipes -- this scares me because we do use implicit and pattern rules:
>
> 2003-04-19 =A0Paul D. Smith =A0<psmith@gnu.org>
>
> =A0 =A0 =A0 =A0Fix bug #1405: allow a target to match multiple pattern-sp=
ecific
> =A0 =A0 =A0 =A0variables.
>
> =A0 =A0 =A0 =A0* rule.c (create_pattern_var, lookup_pattern_var): Move th=
ese to
> =A0 =A0 =A0 =A0variable.c, where they've always belonged.
> =A0 =A0 =A0 =A0* rule.h: Move the prototypes and struct pattern_var as we=
ll.
> =A0 =A0 =A0 =A0* variable.c (initialize_file_variables): Invoke
> =A0 =A0 =A0 =A0lookup_pattern_var() in a loop, until no more matches are =
found.
> =A0 =A0 =A0 =A0If a match is found, create a new variable set for the tar=
get's
> =A0 =A0 =A0 =A0pattern variables. =A0Then merge the contents of each matc=
hing
> =A0 =A0 =A0 =A0pattern variable set into the target's pattern variable se=
t.
> =A0 =A0 =A0 =A0(lookup_pattern_var): Change this function to be usable
> =A0 =A0 =A0 =A0in a loop. =A0It takes a starting position: if NULL, start=
 at the
> =A0 =A0 =A0 =A0beginning; if non-NULL, start with the pattern variable af=
ter that
> =A0 =A0 =A0 =A0position, and return the next matching pattern.
> =A0 =A0 =A0 =A0(create_pattern_var): Create a unique instance of
> =A0 =A0 =A0 =A0pattern-specific variables for every definition in the mak=
efile.
> =A0 =A0 =A0 =A0Don't combine the same pattern together. =A0This allows us=
 to
> =A0 =A0 =A0 =A0process the variable handling properly even when the same =
pattern
> =A0 =A0 =A0 =A0is used multiple times.
> =A0 =A0 =A0 =A0(parse_variable_definition): New function: break out the p=
arsing
> =A0 =A0 =A0 =A0of a variable definition line from try_variable_definition.
> =A0 =A0 =A0 =A0(try_variable_definition): Call parse_variable_definition =
to
> =A0 =A0 =A0 =A0parse.
> =A0 =A0 =A0 =A0(print_variable_data_base): Print out pattern-specific var=
iables.
> =A0 =A0 =A0 =A0* variable.h (struct variable): Remember when a variable is
> =A0 =A0 =A0 =A0conditional. =A0Also remember its flavor.
> =A0 =A0 =A0 =A0(struct pattern_var): Instead of keeping a variable set, w=
e just
> =A0 =A0 =A0 =A0keep a single variable for each pattern.
> =A0 =A0 =A0 =A0* read.c (record_target_var): Each pattern variable contai=
ns only a
> =A0 =A0 =A0 =A0single variable, not a set, so create it properly.
> =A0 =A0 =A0 =A0* doc/make.texi (Pattern-specific): Document the new behav=
ior
>
> 12. Hmmm -- this could get nasty:
>
> 2003-01-22 =A0Paul D. Smith =A0<psmith@gnu.org>
>
> =A0 =A0 =A0 =A0* function.c (func_call): Fix Bug #1744. =A0If we're insid=
e a
> =A0 =A0 =A0 =A0recursive invocation of $(call ...), mask any of the outer
> =A0 =A0 =A0 =A0invocation's arguments that aren't used by this one, so th=
at this
> =A0 =A0 =A0 =A0invocation doesn't "inherit" them accidentally.
>
> I'm concerned now that this is going to take 4 +/- 1 weekends to
> complete and will be semi-painful to validate... The funny thing is
> that our Makefiles were implementing some of this logic before (in a
> hodgepodge manner), so this maybe some items like these were failing
> in the past but not being caught, or were masked by all of the
> explicit target specifications which are a MFPiTA to maintain.

    I think what I need to do is run some tests in these problem areas
to figure out the gaps, now that I have an inkling of what might be
missing, so I can properly fill in the gaps if I can...
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
