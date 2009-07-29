Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <galak@kernel.crashing.org>) id 1MWEyQ-0007nF-JK
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 19:38:02 +0000
Received: from gate.crashing.org ([63.228.1.57])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MWEyP-00013Q-HS
	for ltp-list@lists.sourceforge.net; Wed, 29 Jul 2009 19:38:02 +0000
Message-Id: <255CA943-00F5-4590-BA07-BBF1A6F93D7C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <364299f40907291213m2e8a9c95w5da003ad9f063128@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v935.3)
Date: Wed, 29 Jul 2009 14:37:47 -0500
References: <E69DB27D-E186-4934-AB69-C5EDB67A48AF@kernel.crashing.org>
	<364299f40907291155p52d2aa90jd73ecc9818aa6c6a@mail.gmail.com>
	<80F3D7EC-7B0F-455C-98E0-914D10E88288@kernel.crashing.org>
	<364299f40907291213m2e8a9c95w5da003ad9f063128@mail.gmail.com>
Subject: Re: [LTP] top of tree fails to build on PPC fc11 box
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
Cc: LTP <ltp-list@lists.sourceforge.net>


On Jul 29, 2009, at 2:13 PM, Garrett Cooper wrote:

> On Wed, Jul 29, 2009 at 11:59 AM, Kumar  
> Gala<galak@kernel.crashing.org> wrote:
>>
>> On Jul 29, 2009, at 1:55 PM, Garrett Cooper wrote:
>>
>>> On Wed, Jul 29, 2009 at 11:33 AM, Kumar Gala<galak@kernel.crashing.org 
>>> >
>>> wrote:
>>>>
>>>> I get the following compile error:
>>>>
>>>> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/ 
>>>> fstat'
>>>> make[4]: Entering directory `/root/ltp/testcases/kernel/syscalls/
>>>> fstatat'
>>>> cc -Wall  -I../../include -g -Wall -I../../../../include -Wall -
>>>> DTST_USE_NEWER64_SYSCALL=1 -D_FILE_OFFSET_BITS=64   -c -o
>>>> fstatat01_64.o fstatat01.c
>>>> fstatat01.c:95:37: error: missing binary operator before token "5"
>>>> fstatat01.c: In function 'main':
>>>> fstatat01.c:126: error: expected ')' before numeric constant
>>>> make[4]: *** [fstatat01_64.o] Error 1
>>>> make[4]: Leaving directory `/root/ltp/testcases/kernel/syscalls/ 
>>>> fstatat'
>>>> make[3]: *** [all] Error 2
>>>> make[3]: Leaving directory `/root/ltp/testcases/kernel/syscalls'
>>>> make[2]: *** [all] Error 2
>>>> make[2]: Leaving directory `/root/ltp/testcases/kernel'
>>>> make[1]: *** [all] Error 2
>>>> make[1]: Leaving directory `/root/ltp/testcases'
>>>> make: *** [all] Error 2
>>>
>>> Got config.log?
>>
>> Nope, I tried doing the non-autoconf build:
>>
>>        $ touch include/config.h.default
>>        $ make config.h
>>        $ make all
>>
>> when I try the autoconf build I get:
>>
>> [root@monty ltp]# make autotools
>> aclocal -I m4
>> autoconf
>> configure.ac:9: error: possibly undefined macro: AC_PROG_AR
>>      If this token and others are legitimate, please use  
>> m4_pattern_allow.
>>      See the Autoconf documentation.
>> make: *** [configure] Error 1
>
> That's odd why it wouldn't work. `yum search autoconf automake m4'  
> says?
> -Garrett

I think you wanted 'yum info'

[root@monty ~]# yum info autoconf automake m4
Loaded plugins: refresh-packagekit
Installed Packages
Name       : autoconf
Arch       : noarch
Version    : 2.63
Release    : 2.fc11
Size       : 2.5 M
Repo       : installed
 From repo  : fedora
Summary    : A GNU tool for automatically configuring source code
URL        : http://www.gnu.org/software/autoconf/
License    : GPLv2+ and GFDL
Description: GNU's Autoconf is a tool for configuring source code and  
Makefiles.
            : Using Autoconf, programmers can create portable and  
configurable
            : packages, since the person building the package is  
allowed to
            : specify various configuration options.
            :
            : You should install Autoconf if you are developing  
software and
            : would like to create shell scripts that configure your  
source code
            : packages. If you are installing Autoconf, you will also  
need to
            : install the GNU m4 package.
            :
            : Note that the Autoconf package is not required for the  
end-user who
            : may be configuring software with an Autoconf-generated  
script;
            : Autoconf is only required for the generation of the  
scripts, not
            : their use.

Name       : automake
Arch       : noarch
Version    : 1.11
Release    : 2.fc11
Size       : 1.7 M
Repo       : installed
 From repo  : updates
Summary    : A GNU tool for automatically creating Makefiles
URL        : http://sources.redhat.com/automake
License    : GPLv2+ and GFDL and MIT
Description: Automake is a tool for automatically generating  
`Makefile.in'
            : files compliant with the GNU Coding Standards.
            :
            : You should install Automake if you are developing  
software and would
            : like to use its ability to automatically generate GNU  
standard
            : Makefiles. If you install Automake, you will also need  
to install
            : GNU's Autoconf package.

Name       : m4
Arch       : ppc
Version    : 1.4.12
Release    : 2.fc11
Size       : 462 k
Repo       : installed
 From repo  : fedora
Summary    : The GNU macro processor
URL        : http://www.gnu.org/software/m4/
License    : GPLv3+
Description: A GNU implementation of the traditional UNIX macro  
processor.  M4 is
            : useful for writing text files which can be logically  
parsed, and is used
            : by many programs as part of their build process.  M4 has  
built-in
            : functions for including files, running shell commands,  
doing arithmetic,
            : etc.  The autoconf program needs m4 for generating  
configure scripts, but
            : not for running configure scripts.
            :
            : Install m4 if you need a macro processor.



------------------------------------------------------------------------------
Let Crystal Reports handle the reporting - Free Crystal Reports 2008 30-Day 
trial. Simplify your report design, integration and deployment - and focus on 
what you do best, core application coding. Discover what's new with 
Crystal Reports now.  http://p.sf.net/sfu/bobj-july
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
