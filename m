Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1MOqrb-0002bk-6c
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 10:28:27 +0000
Received: from mail-bw0-f215.google.com ([209.85.218.215])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MOqra-0002br-6U
	for ltp-list@lists.sourceforge.net; Thu, 09 Jul 2009 10:28:27 +0000
Received: by bwz11 with SMTP id 11so55414bwz.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 09 Jul 2009 03:28:24 -0700 (PDT)
Message-ID: <4A55C646.5060805@petalogix.com>
Date: Thu, 09 Jul 2009 12:28:22 +0200
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4A5436D4.6070201@petalogix.com>	
	<364299f40907080719q4ab01842v7e47a352b8214b8a@mail.gmail.com>	
	<4A54AEFA.3030100@petalogix.com>
	<364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>
In-Reply-To: <364299f40907082230m27683f17yd042bd569d0a5165@mail.gmail.com>
Subject: Re: [LTP] IDcheck.sh - awk problem
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
> On Wed, Jul 8, 2009 at 7:36 AM, Michal Simek<michal.simek@petalogix.com> wrote:
>   
>> Of course not because I cross compile ltp for Microblaze - correct
>> /etc/passwd - group is on
>> target system. Maybe worth to remove calling IDcheck.sh from make
>> install and call it only before
>> running the test.
>>
>>     
>
> Michal,
>     Please give this patch a try, and instead when you run make
> install, do SKIP_IDCHECK=1.
> HTH,
> -Garrett
>
> This patch does the same as the previous released patch in this
> thread, which is:
>
> IDcheck.sh:
> 1. Fixes the DESTDIR != "" | "/" behavior.
> 2. Spew out less awk errors if files don't exist by instead
> short-circuiting the logic to detect whether or not the file exists in
> the fe function subroutine.
>
> In addition to the above, this adds SKIP_IDCHECK behavior, by request
> of Michal, so it's no longer required for make install, and can be
> disabled by entering specifying the variable SKIP_IDCHECK=1 when
> calling make install, e.g...
>
> make \
> [make-options-and-variables] \
> SKIP_IDCHECK=1 \
> install
>   
you should add SKIP_IDCHECK to uclinux_install too.

[monstr@monstr ltp-microblaze.git]$ make SKIP_IDCHECK=1 install
Makefile:43: *** insufficient number of arguments (1) to function
`filter'.  Stop.

Michal

> Warning! This patch has Makefile changes and as such the files patched
> contents should be committed directly, NOT the inline text shown below
> (for reviewing purposes only).
>
> Signed-off-by: Garrett Cooper <yanegomi@gmail.com>
>
> Index: IDcheck.sh
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/IDcheck.sh,v
> retrieving revision 1.19
> diff -u -r1.19 IDcheck.sh
> --- IDcheck.sh  7 Jul 2009 14:30:27 -0000       1.19
> +++ IDcheck.sh  9 Jul 2009 05:21:34 -0000
> @@ -22,7 +22,6 @@
>  #
>
>  # Prompt user if ids/groups should be created
> -clear
>  echo "Checking for required user/group ids"
>  echo ""
>
> @@ -41,12 +40,11 @@
>
>  # find entry.
>  fe() {
> -       ID=$1; shift
> -       FILE=$1; shift
> -       awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 0; }
> exit 1; }" \
> -       "$FILE"
> -       ec=$?
> -       echo "$ID => $ec"
> +    ID=$1; shift
> +    FILE=$1; shift
> +    [ -e "$FILE" ] || return $?
> +    awk "/^$ID:/ { FOUND=1 } END { if (\$FOUND == 1) { exit 1; } exit 0; }" \
> +    "$FILE"
>  }
>
>  prompt_for_create() {
> @@ -70,13 +68,12 @@
>         EUID=$(id -u)
>  fi
>
> -if [ -e "$passwd" -a ! -r "$passwd" ] ; then
> -       echo "/etc/passwd not readable by uid $EUID"
> +for i in "$passwd" "$group"; do
> +    if [ -e "$i" -a ! -r "$i" ] ; then
> +       echo "$i not readable by uid $EUID"
>         exit 1
> -elif [ -e "$group" -a ! -r "$group" ] ; then
> -       echo "$group not readable by uid $EUID"
> -       exit 1
> -fi
> +    fi
> +done
>
>  fe bin "$passwd"; NO_BIN_ID=$?
>  fe daemon "$passwd"; NO_DAEMON_ID=$?
> @@ -110,10 +107,10 @@
>  #debug_vals
>
>  if [ $CREATE_ENTRIES -ne 0 ] ; then
> -       if ! touch "$group" ; then
> -               echo "Couldn't touch $group"
> -               exit 1
> -       fi
> +    if ! touch "$group" "$passwd" 2>/dev/null; then
> +        echo "Failed to touch $group or $passwd"
> +        exit 1
> +    fi
>  fi
>
>  make_user_group() {
> Index: Makefile
> ===================================================================
> RCS file: /cvsroot/ltp/ltp/Makefile,v
> retrieving revision 1.39
> diff -u -r1.39 Makefile
> --- Makefile    25 Mar 2009 06:17:48 -0000      1.39
> +++ Makefile    9 Jul 2009 05:27:34 -0000
> @@ -14,6 +14,10 @@
>  export CFLAGS += -Wall $(CROSS_CFLAGS)
>  export CC AR RANLIB CPPFLAGS LDFLAGS HAS_NUMA
>
> +# SKIP_IDCHECK != 1, defaults to previous behavior, which is to execute
> +# IDcheck.sh at the end of `make install'.
> +SKIP_IDCHECK           ?= 0
> +
>  -include config.mk
>
>  VPATH += include m4
> @@ -36,8 +40,9 @@
>         @$(MAKE) -C m4 install
>         @$(MAKE) -C doc/man1 install
>         @$(MAKE) -C doc/man3 install
> -
> +ifneq ($(filter $(SKIP_IDCHECK)),1)
>         @./IDcheck.sh
> +endif
>
>  libltp.a: config.h
>         @$(MAKE) -C lib $@
>   


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
