Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <ashish.g@teldevice.co.jp>) id 1NY9qL-00010D-Jp
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 03:05:53 +0000
Received: from mail-gw.teldevice.co.jp ([124.215.243.245] helo=teldevice.co.jp)
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NY9qJ-0004vI-Tk
	for ltp-list@lists.sourceforge.net; Fri, 22 Jan 2010 03:05:53 +0000
Message-ID: <4B591601.701@teldevice.co.jp>
Date: Fri, 22 Jan 2010 12:05:37 +0900
From: TED ITC Agarwal Ashish <ashish.g@teldevice.co.jp>
MIME-Version: 1.0
References: <0016e649c930347566047d6e6c5b@google.com>
In-Reply-To: <0016e649c930347566047d6e6c5b@google.com>
Subject: Re: [LTP] i.MX31 Platform Embedded Linux LTP Test
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
To: md.zafar.ziya@gmail.com, yanegomi@gmail.com
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

Hi All

As i am novice to LTP. thanks for your help.


 >    Please read the INSTALL file for more details on how to configure,
 >compile, and install LTP. The out-of-build-tree method may be suitable
 >for your needs.
 >HTH,
 > -Garrett


 > cross compile LTP for the target board and port only binary for the
 > required test cases and the required scripts.
 >--
 >md.zafar.ziya


yes it is true that Cross compile option will help me out.
but the main target for now is to how to cross compile LTP.

i did goo' for the cross compile steps or hints but not got any specific help from whr i have to start
or wch way i will proceed.

like some questions mention that there were some settings to the makefile

------------------------------------

CROSS_COMPILER=/opt/ppc64/powerpc64-linux/bin/powerpc64-linux-
CROSS_CFLAGS= -mpowerpc64
LDFLAGS=-static
LOADLIBES=-lpthread -lc -lresolv -lnss_dns -lnss_files -lm -lc
LIB_DIR=/lib64
export LOADLIBES LIB_DIR
---------------------------------------

i had no idea about what to do where to do :(

really it feels you terrible ...

but i had no other choice .. i tried to search lot but not succeeded
:-(

Please suggest me any link that can help me or the starting point manual

any language material will be a gre8 help :)

--
Ashish



md.zafar.ziya@gmail.com ????????:
> Hi,
> 
> cross compile LTP for the target board and port only binary for the 
> required test cases and the required scripts.
> 
> 
> Thanks and regards
> 
> zafar ziya
> 
> On Jan 18, 2010 4:19pm, TED ITC Agarwal Ashish 
> <ashish.g@teldevice.co.jp> wrote:
>  > Hello All,
>  >
>  >
>  >
>  > This is Ashish Agarwal, I am new to LTP.
>  >
>  >
>  >
>  > Last day i was succeeded to install the LTP over Fedora 7 system. and 
> run test as well.
>  >
>  >
>  >
>  > As my main motive of LTP learn is to Test a customized Embedded Linux 
> system for Freescale i.Mx31 CPU.
>  >
>  >
>  >
>  > My Project specs are as below:
>  >
>  >
>  >
>  > Kernel: 2.6.19.2
>  >
>  > CPU: i.MX31
>  >
>  > Rootfs mounted over : Flash (jffs2 file system, 256MB)
>  >
>  >
>  >
>  > So my motive is to install the LTP and run the test.
>  >
>  >
>  >
>  > Because my system is mounted over Flash, so it can be seen as the 
> memory is remained is not so much as we can use in general projects (PC's).
>  >
>  > and i had not include any "make" and "gcc" components to my 
> customized kernel. (because of memory)
>  >
>  >
>  >
>  > So how can i install the LTP over the system.  (i have USB ports, and 
> mass storage driver support).
>  >
>  >
>  >
>  > --
>  >
>  >
>  >
>  > Ashish Agarwal
>  >
>  >
>  >
>  > 
> ------------------------------------------------------------------------------
>  >
>  > Throughout its 18-year history, RSA Conference consistently attracts the
>  >
>  > world's best and brightest in the field, creating opportunities for 
> Conference
>  >
>  > attendees to learn about information security's most important issues 
> through
>  >
>  > interactions with peers, luminaries and emerging and established 
> companies.
>  >
>  > http://p.sf.net/sfu/rsaconf-dev2dev
>  >
>  > _______________________________________________
>  >
>  > Ltp-list mailing list
>  >
>  > Ltp-list@lists.sourceforge.net
>  >
>  > https://lists.sourceforge.net/lists/listinfo/ltp-list
>  >

------------------------------------------------------------------------------
Throughout its 18-year history, RSA Conference consistently attracts the
world's best and brightest in the field, creating opportunities for Conference
attendees to learn about information security's most important issues through
interactions with peers, luminaries and emerging and established companies.
http://p.sf.net/sfu/rsaconf-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
