Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1N7YYD-0008HZ-ME
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 18:01:13 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N7YY7-00087Z-7V
	for ltp-list@lists.sourceforge.net; Mon, 09 Nov 2009 18:01:13 +0000
Received: by pzk26 with SMTP id 26so2253443pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Nov 2009 10:01:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <364299f40911081202i70797af6uf5968839c60bb133@mail.gmail.com>
References: <20091106095745.GA25377@basil.fritz.box>
	<200911061809.05115.vapier@gentoo.org>
	<20091106233422.GB6619@count0.beaverton.ibm.com>
	<200911061923.09848.vapier@gentoo.org>
	<364299f40911061652l5cf3ac19h696152cdfebb547d@mail.gmail.com>
	<364299f40911061654w221b10f9i10bcb2a3e3b35aee@mail.gmail.com>
	<364299f40911071809r2c47b9d4mfd6a60011fdcd9ce@mail.gmail.com>
	<364299f40911081202i70797af6uf5968839c60bb133@mail.gmail.com>
Date: Mon, 9 Nov 2009 10:01:01 -0800
Message-ID: <364299f40911091001x2f103ef3wc1232c9c132cff38@mail.gmail.com>
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

On Sun, Nov 8, 2009 at 12:02 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
> On Sat, Nov 7, 2009 at 6:09 PM, Garrett Cooper <yanegomi@gmail.com> wrote:
>> On Fri, Nov 6, 2009 at 4:54 PM, Garrett Cooper <yanegomi@gmail.com> wrot=
e:
>>> On Fri, Nov 6, 2009 at 4:52 PM, Garrett Cooper <yanegomi@gmail.com> wro=
te:
>>>> On Fri, Nov 6, 2009 at 4:23 PM, Mike Frysinger <vapier@gentoo.org> wro=
te:
>>>>> On Friday 06 November 2009 18:34:22 Matt Helsley wrote:
>>>>>> On Fri, Nov 06, 2009 at 06:09:04PM -0500, Mike Frysinger wrote:
>>>>>> > On Friday 06 November 2009 18:02:31 Matt Helsley wrote:
>>>>>> > > On Fri, Nov 06, 2009 at 03:09:02PM -0400, Mike Frysinger wrote:
>>>>>> > > > also, i thought we were going to rename the top level Makefile=
 to
>>>>>> > > > GNUmakefile and add a dummy Makefile that just spat out "sorry=
, ltp
>>>>>> > > > requires GNU make".
>>>>>> > >
>>>>>> > > Bleh. Can't we just check the output of $(MAKE) --version rather=
 than
>>>>>> > > assume other makes use "Makefile"?
>>>>>> >
>>>>>> > the assumption is that only GNU make parses "GNUmakefile". =A0i th=
ink
>>>>>> > that's a pretty safe assumption.
>>>>>>
>>>>>> Right, but GNU Make also parses Makefile.
>>>>>
>>>>> not if a GNUmakefile exists in the same dir, or the user forces the i=
ssue via
>>>>> the -f flag
>>>>>
>>>>>> If some poor bastard runs:
>>>>>>
>>>>>> make -f Makefile
>>>>>>
>>>>>> where GNU Make is "make" they may be further confused. Seems like it=
's
>>>>>> better to check what's actually running ($(MAKE)) or will run
>>>>>> (like `which make` in configure) than rely on a filename hack like t=
his.
>>>>>
>>>>> said poor bastard should be smacked :p. =A0checking the value of $(MA=
KE) wont
>>>>> work as it could be an arbitrary number of things which could all be =
valid
>>>>> values under GNU make. =A0configure checks wont matter because it's t=
he user who
>>>>> runs `make` or `gmake` or `make-some-noise`. =A0requiring `make` to b=
e GNU make
>>>>> in configure when the user can easily run `gmake` at make time is poi=
ntless
>>>>> user interference.
>>>>>
>>>>> using a different filename on the other hand is exactly what GNU make=
 has
>>>>> designed in from the get go specifically for this purpose -- when GNU=
 make is
>>>>> required. =A0if you honestly think people are doing something pointle=
ss like
>>>>> `make -f Makefile`, then it's trivial to add a check to it to (1) che=
ck
>>>>> $(MAKE) --version and include GNUmakefile or (2) $(error out). =A0no =
point in
>>>>> forcing the shell/etc... overhead in the default build for the majori=
ty of
>>>>> users.
>>>>
>>>> No, but you can do something like:
>>>>
>>>> ifdef MAKE_SANITY_CHECK
>>>> export MAKE_SANITY_CHECK =3D 1
>>>> ifneq ($(lastword $(sort 3.80 $(MAKE_VERSION))),$(MAKE_VERSION))
>>>> $(error Upgrade your junk..)
>>>> endif
>>>> endif
>>>>
>>>> that way it only executes this once.
>>>
>>> Ugh... $(lastword ) didn't exist in 3.80... I'll change it around to
>>> $(firstword ).
>>
>> Crap. So here are some of the high notes for changes between make 3.80 a=
nd 3.81:
>>
>> 1. $(and ) and $(or ) didn't exist [we use $(or ) once]. This can be
>> replaced by an `ifeq ($(strip)) else endif'.

Fixed~ish. This one's a minor pain with $(or ). $(if ) doesn't
function either because it appears to have been introduced in the same
timeframe -_-...

>> 2. $(abspath ) // $(realpath ) didn't exist [we use $(abspath )
>> extensively, but just in one spot -- fixed that, need to test].

Fixed.

>> 3. .DEFAULT_GOAL was originally .DEFAULT_TARGET, but DID NOT exist in
>> make 3.81 (this is going to be a bloody pain to hack around with,
>> maybe -- depends on where I put all:). It'll be like herding cats to
>> make sure that other developers don't create targets before the first
>> include.

Need to check.

>> 4. Secondary expansion was busted as all hell in <3.81 (now this is
>> going to be a serious pain point in some areas because I'll have to
>> hunt down wherever I used % and $* and adjust things to work with make
>> 3.80 -- this mostly affects the top-level Makefile).
>> 5. Secondary expansion did NOT exist in static nor implicit rules
>> (another pain point -- mostly with the top-level Makefile).

.SECONDEXPANSION - fixed.

>> 6. $(lastword ) didn't exist [can be replaced by $(firstword ) with
>> inverse logic, maybe...].
>> 7. Some funkiness with how .PHONY was treated:
>>
>> 2004-09-21 =A0Boris Kolpackov =A0<boris@kolpackov.net>
>>
>> =A0 =A0 =A0 =A0* file.c (snap_deps): Mark .PHONY prerequisites as target=
s.
>>
>> 8. Variable expansion was partially broken [used underlying caller
>> from $(subst ) instead of $(patsubst )].
>> 9. Now this one flat out spooks me:
>>
>> 2004-03-20 =A0Paul D. Smith =A0<psmith@gnu.org>
>>
>> [...]
>>
>> =A0 =A0 =A0 =A0* rule.c (count_implicit_rule_limits): Don't delete patte=
rns which
>> =A0 =A0 =A0 =A0refer to absolute pathnames in directories that don't exi=
st: some
>> =A0 =A0 =A0 =A0portion of the makefile could create those directories be=
fore we
>> =A0 =A0 =A0 =A0match the pattern. =A0Fixes bugs #775 and #108.
>>
>> =A0This makes me think that out-of-build-tree could be REALLY broken wit=
h 3.80.
>>
>> 10. Ouch -- this is a really f'ed up bug:
>>
>> 2004-01-07 =A0Paul D. Smith =A0<psmith@gnu.org>
>>
>> [...]
>>
>> =A0 =A0 =A0 =A0* job.c (construct_command_argv_internal): Add "!" to the=
 list of
>> =A0 =A0 =A0 =A0shell escape chars. =A0POSIX sh allows it to appear befor=
e a
>> =A0 =A0 =A0 =A0command, to negate the exit code. =A0Fixes bug #6404.
>>
>> 11. Yipes -- this scares me because we do use implicit and pattern rules:
>>
>> 2003-04-19 =A0Paul D. Smith =A0<psmith@gnu.org>
>>
>> =A0 =A0 =A0 =A0Fix bug #1405: allow a target to match multiple pattern-s=
pecific
>> =A0 =A0 =A0 =A0variables.
>>
>> =A0 =A0 =A0 =A0* rule.c (create_pattern_var, lookup_pattern_var): Move t=
hese to
>> =A0 =A0 =A0 =A0variable.c, where they've always belonged.
>> =A0 =A0 =A0 =A0* rule.h: Move the prototypes and struct pattern_var as w=
ell.
>> =A0 =A0 =A0 =A0* variable.c (initialize_file_variables): Invoke
>> =A0 =A0 =A0 =A0lookup_pattern_var() in a loop, until no more matches are=
 found.
>> =A0 =A0 =A0 =A0If a match is found, create a new variable set for the ta=
rget's
>> =A0 =A0 =A0 =A0pattern variables. =A0Then merge the contents of each mat=
ching
>> =A0 =A0 =A0 =A0pattern variable set into the target's pattern variable s=
et.
>> =A0 =A0 =A0 =A0(lookup_pattern_var): Change this function to be usable
>> =A0 =A0 =A0 =A0in a loop. =A0It takes a starting position: if NULL, star=
t at the
>> =A0 =A0 =A0 =A0beginning; if non-NULL, start with the pattern variable a=
fter that
>> =A0 =A0 =A0 =A0position, and return the next matching pattern.
>> =A0 =A0 =A0 =A0(create_pattern_var): Create a unique instance of
>> =A0 =A0 =A0 =A0pattern-specific variables for every definition in the ma=
kefile.
>> =A0 =A0 =A0 =A0Don't combine the same pattern together. =A0This allows u=
s to
>> =A0 =A0 =A0 =A0process the variable handling properly even when the same=
 pattern
>> =A0 =A0 =A0 =A0is used multiple times.
>> =A0 =A0 =A0 =A0(parse_variable_definition): New function: break out the =
parsing
>> =A0 =A0 =A0 =A0of a variable definition line from try_variable_definitio=
n.
>> =A0 =A0 =A0 =A0(try_variable_definition): Call parse_variable_definition=
 to
>> =A0 =A0 =A0 =A0parse.
>> =A0 =A0 =A0 =A0(print_variable_data_base): Print out pattern-specific va=
riables.
>> =A0 =A0 =A0 =A0* variable.h (struct variable): Remember when a variable =
is
>> =A0 =A0 =A0 =A0conditional. =A0Also remember its flavor.
>> =A0 =A0 =A0 =A0(struct pattern_var): Instead of keeping a variable set, =
we just
>> =A0 =A0 =A0 =A0keep a single variable for each pattern.
>> =A0 =A0 =A0 =A0* read.c (record_target_var): Each pattern variable conta=
ins only a
>> =A0 =A0 =A0 =A0single variable, not a set, so create it properly.
>> =A0 =A0 =A0 =A0* doc/make.texi (Pattern-specific): Document the new beha=
vior
>>
>> 12. Hmmm -- this could get nasty:
>>
>> 2003-01-22 =A0Paul D. Smith =A0<psmith@gnu.org>
>>
>> =A0 =A0 =A0 =A0* function.c (func_call): Fix Bug #1744. =A0If we're insi=
de a
>> =A0 =A0 =A0 =A0recursive invocation of $(call ...), mask any of the outer
>> =A0 =A0 =A0 =A0invocation's arguments that aren't used by this one, so t=
hat this
>> =A0 =A0 =A0 =A0invocation doesn't "inherit" them accidentally.
>>
>> I'm concerned now that this is going to take 4 +/- 1 weekends to
>> complete and will be semi-painful to validate... The funny thing is
>> that our Makefiles were implementing some of this logic before (in a
>> hodgepodge manner), so this maybe some items like these were failing
>> in the past but not being caught, or were masked by all of the
>> explicit target specifications which are a MFPiTA to maintain.
>
> =A0 =A0I think what I need to do is run some tests in these problem areas
> to figure out the gaps, now that I have an inkling of what might be
> missing, so I can properly fill in the gaps if I can...

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
