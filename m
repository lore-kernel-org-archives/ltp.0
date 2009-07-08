Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MOe51-0008QN-Pb
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 20:49:27 +0000
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOe4v-0005oy-Vt
	for ltp-list@lists.sourceforge.net; Wed, 08 Jul 2009 20:49:22 +0000
Received: by bwz11 with SMTP id 11so177451bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Jul 2009 13:49:21 -0700 (PDT)
Message-ID: <4A54FF65.5090503@petalogix.com>
Date: Wed, 08 Jul 2009 22:19:49 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <364299f40907080908y531e3fa8m2c783f9328278ddd@mail.gmail.com>
	<C6C9BE7D-3880-4896-98E2-4588D4318709@gmail.com>
In-Reply-To: <C6C9BE7D-3880-4896-98E2-4588D4318709@gmail.com>
Subject: Re: [LTP] [PATCH] Fix IDcheck.sh - awk problem
Reply-To: michal.simek@petalogix.com
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP <ltp-list@lists.sourceforge.net>, Mike Frysinger <vapier.adi@gmail.com>

Garrett Cooper wrote:
> On Jul 8, 2009, at 9:08 AM, Garrett Cooper <yanegomi@gmail.com> wrote:
>
>> On Wed, Jul 8, 2009 at 7:36 AM, Michal
>> Simek<michal.simek@petalogix.com> wrote:
>>> Garrett Cooper wrote:
>>>> On Tue, Jul 7, 2009 at 11:04 PM, Michal
>>>> Simek<michal.simek@petalogix.com> wrote:
>>>>
>>>>> Hi All,
>>>>>
>>>>> There will be good to prevent missing /etc/passwd for installing to
>>>>> different folder.
>>>>>
>>>>> export DESTDIR=`pwd`/nfs
>>>>> mkdir -p nfs
>>>>> make install
>>>>
>>>> That's part of the reason why I wanted it to be reviewed before it was
>>>> committed, and I halfway expected Mike to provide that assistance but
>>>> he didn't... *sigh*.
>>>>
>>>> Does the /etc/passwd // /etc/group file exist?
>>>>
>>> Of course not because I cross compile ltp for Microblaze - correct
>>> /etc/passwd - group is on
>>> target system. Maybe worth to remove calling IDcheck.sh from make
>>> install and call it only before
>>> running the test.
>>
>> Well, it's up to you folks how you want to do it, because it should
>> not be called by default, but it still is because I haven't added my
>> changes into the top-level Makefile yet, because that's under review.
>>
>> =================
>> PATCH FOLLOWS
>> =================
>>
>> This fixes the bad DESTDIR logic that was recently checked in, as
>> validated with the output shown below (see the attached file --
>> test_IDcheck_sh_regression_set.py -- for more details):
>>
>> Nose output:
>>
>> gcooper@orangebox /scratch/ltp-vanilla/ltp $ nosetests
>> test_IDcheck_sh_regression_set.py
>> Checking for required user/group ids
>>
>> 'nobody' user id and group found.
>> 'bin' user id and group found.
>> 'daemon' user id and group found.
>> Users group found.
>> Sys group found.
>> Required users/groups exist.
>> .Checking for required user/group ids
>>
>>
>> *****************************************
>> * Required users/groups do NOT exist!!! *
>> *                                       *
>> * Some kernel/syscall tests will FAIL!  *
>> *****************************************
>> .Checking for required user/group ids
>>
>>
>> *****************************************
>> * Required users/groups do NOT exist!!! *
>> *                                       *
>> * Some kernel/syscall tests will FAIL!  *
>> *****************************************
>> .Checking for required user/group ids
>>
>>
>> *****************************************
>> * Required users/groups do NOT exist!!! *
>> *                                       *
>> * Some kernel/syscall tests will FAIL!  *
>> *****************************************
>> .Checking for required user/group ids
>>
>> Failed to touch //etc/group or //etc/passwd
>> .Checking for required user/group ids
>>
>> Creating entries for nobody
>> Creating entries for bin
>> Creating entries for daemon
>> Required users/groups exist.
>> .Checking for required user/group ids
>>
>> Failed to touch /tmp/tmpvQw2kZ/etc/group or /tmp/tmpvQw2kZ/etc/passwd
>> .Checking for required user/group ids
>>
>> Failed to touch /some/path/that/does/not/exist/etc/group or
>> /some/path/that/does/not/exist/etc/passwd
>> .
>> ----------------------------------------------------------------------
>> Ran 8 tests in 0.090s
>>
>> OK
>>
>> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>>
>> Index: IDcheck.sh
>> ===================================================================
>> RCS file: /cvsroot/ltp/ltp/IDcheck.sh,v
>> retrieving revision 1.19
>> diff -u -r1.19 IDcheck.sh
>> --- IDcheck.sh  7 Jul 2009 14:30:27 -0000       1.19
>> +++ IDcheck.sh  8 Jul 2009 16:06:42 -0000
>> @@ -22,7 +22,6 @@
>> #
>>
>> # Prompt user if ids/groups should be created
>> -clear
>> echo "Checking for required user/group ids"
>> echo ""
>>
>> @@ -41,12 +40,11 @@
>>
>> # find entry.
>> fe() {
>> -       ID=$1; shift
>> -       FILE=$1; shift
>> -       awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 0; }
>> exit 1; }" \
>> -       "$FILE"
>> -       ec=$?
>> -       echo "$ID => $ec"
>> +    ID=$1; shift
>> +    FILE=$1; shift
>> +    [ -e "$FILE" ] || return $?
>> +    awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 1; }
>> exit 0; }" \
>> +    "$FILE"
>> }
>>
>> prompt_for_create() {
>> @@ -70,13 +68,12 @@
>>        EUID=$(id -u)
>> fi
>>
>> -if [ -e "$passwd" -a ! -r "$passwd" ] ; then
>> -       echo "/etc/passwd not readable by uid $EUID"
>> +for i in "$passwd" "$group"; do
>> +    if [ -e "$i" -a ! -r "$i" ] ; then
>> +       echo "$i not readable by uid $EUID"
>>        exit 1
>> -elif [ -e "$group" -a ! -r "$group" ] ; then
>> -       echo "$group not readable by uid $EUID"
>> -       exit 1
>> -fi
>> +    fi
>> +done
>>
>> fe bin "$passwd"; NO_BIN_ID=$?
>> fe daemon "$passwd"; NO_DAEMON_ID=$?
>> @@ -110,10 +107,10 @@
>> #debug_vals
>>
>> if [ $CREATE_ENTRIES -ne 0 ] ; then
>> -       if ! touch "$group" ; then
>> -               echo "Couldn't touch $group"
>> -               exit 1
>> -       fi
>> +    if ! touch "$group" "$passwd" 2>/dev/null; then
>> +        echo "Failed to touch $group or $passwd"
>> +        exit 1
>> +    fi
>> fi
>>
>> make_user_group() {
>> <test_IDcheck_sh_regression_set.py>
>
> Michal,
>     Would you please also verify this patch prior to commit in your
> build env?

First of all - I am not sure about asking anything when you do make
install. This break our automatic
building system. Second - this make no sense when you cross compile for
different arch.
"If any required user ids and/or groups are missing, would you like
these created? [y/N]"

IMHO we shouldn't ask any question like that in make. As I wrote before
- maybe we should remove @./IDcheck.sh from Makefile.
On MMU Microblaze I haven't seen any problem with it.

Michal

> Thanks,
> -Garrett


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
