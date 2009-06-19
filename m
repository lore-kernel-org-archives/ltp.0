Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MHb52-0007vX-B6
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 10:12:20 +0000
Received: from yw-out-1718.google.com ([74.125.46.158])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MHb51-0001Gn-5N
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2009 10:12:20 +0000
Received: by yw-out-1718.google.com with SMTP id 5so856689ywr.82
	for <ltp-list@lists.sourceforge.net>;
	Fri, 19 Jun 2009 03:12:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4A3B542E.708@st.com>
References: <f5a7b3810906171317j40473a95y5dfc1b89d9e25950@mail.gmail.com>
	<4A3A049B.2000002@st.com>
	<f5a7b3810906180808l19d1889bn5575cf00de28d801@mail.gmail.com>
	<4A3B542E.708@st.com>
Date: Fri, 19 Jun 2009 15:42:18 +0530
Message-ID: <f5a7b3810906190312l75735199k43df06045d6264be@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [FIX HTML PATCH] ltp-genhtml
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Francesco RUNDO <francesco.rundo@st.com>, subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net, maxin john <maxinbjohn@gmail.com>, brinda_mn@yahoo.co.in, Manas Kumar Nayak <maknayak@in.ibm.com>, Oleg Nesterov <oleg@redhat.com>, rohit.170309@gmail.com

Hi Francesco,

Thanks for your comments.

I have few questions
1. Are you compiling LTP on Host Machine and running on target boards?
Could explain your compilation and execution procedure?
2. Is it cross complication with different tool chains?
3. Do you export KERNEL_VERSION and MACHINE_ARCHITECTURE on Host or target?

At my end I am compile with cross tool chains and copy the LTP
complied source on target and executing the =93runltp=94.
In my case I don=92t get any variables from Host.
I am not exporting Any Macros on target.

I guess. Most of our LTP users do same.
Of course, I will not export KERNEL_VERSION and MACHINE_ARCHITECTURE
either on target or on Host.

I was not aware of exporting these variables.

Thanks for your info.

Is there any other way with out exporting these variables can I get
KERNEL_VERSION and MACHINE_ARCHITECTURE?
I mean the design modification of PERL script to auto extracting of command=
s.

As per my understanding the people use direct target machine for LTP
execution are getting this problem

 Francesco,

I want to have generic script to solve this issue.
could you help in this?

Subrata,


In the published results logs under this URL are not having
KERNEL_VERSION and MACHINE_ARCHITECTURE in HTML.
I have also faced same problem and made a patch for that.

Please refer the results published in LTP download page for May release.
http://sourceforge.net/project/platformdownload.php?group_id=3D3382

LTP Results:

ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-ppc64.tgz
ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-x86_64.tgz
ltp-full-20090531_results_kernel-2.6.18-128.el5PAE_architecture-i386.tgz
ltp-full-20090531_results_kernel-2.6.23.13_architecture-ia64.tgz
ltp-full-20090531_results_kernel-2.6.27.19-5-default_architecture-i386.tgz

None of the above results got printed these two KERNEL_VERSION and
MACHINE_ARCHITECTURE variables in HTML.


Please give me the procedure of ltp execution at your end.
Because there is confusion about generating HTML with KERNEL_VERSION
and MACHINE_ARCHITECTURE, so we want to have a generic method of
extracting.

Do you export KERNEL_VERSION and MACHINE_ARCHITECTURE before ltp
execution as a standard procedure?

I want to know the majority of people
A) Cross compile on host and run LTP on target
B) Compile on Host and run on LTP from Host Machine.
C) Compile and execute on HOST.

Your suggestions are welcome :)


Best regards
Naresh Kamboju


On Fri, Jun 19, 2009 at 2:32 PM, Francesco RUNDO<francesco.rundo@st.com> wr=
ote:
> Hi Naresh,
>
> thanks for your reply. Below some considerations:
>
> naresh kamboju wrote:
>
> Hi Francesco,
>
>
>
> In fact, in case the results of LTP session was related to cross-executio=
n,
> the >infiormation about KERNEL_VERSION and MACHINE_ARCHITECTURE have to >=
be
> referred to the target and not to the host. Do you agree ?
>
>
> Yes.
> I agree with you.
> I have been using LTP for Target Board executions not on Host Machine.
> As per my understating KERNEL_VERSION and MACHINE_ARCHITECTURE are
> should come from env right?
>
> Yes.
>
>
> But I could not print these variables in HTML file.
>
> Why not ?
> By means of (before to run genhtml.pl on the HOST):
> export KERNEL_VERSION=3D" xxxxxxxxxxxxxxxx"
> export MACHINE_ARCH=3D" xxxxxxxxxxxxxxxxxxxxx"
> you will be able to export on the final HTML file the info contained in t=
he
> above env variables.
> The attached HTML log shows a typical summary (I report only subset of in=
fo
> related to the env variables).
>
> Please refer the results published in LTP download page for 31-May-2009
> release.
> http://sourceforge.net/project/platformdownload.php?group_id=3D3382
>
>
> LTP Results:
>
> ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-ppc64.tgz
> ltp-full-20090531_results_kernel-2.6.18-128.el5_architecture-x86_64.tgz
> ltp-full-20090531_results_kernel-2.6.18-128.el5PAE_architecture-i386.tgz
> ltp-full-20090531_results_kernel-2.6.23.13_architecture-ia64.tgz
> ltp-full-20090531_results_kernel-2.6.27.19-5-default_architecture-i386.tgz
>
> None of the above results got printed these two KERNEL_VERSION and
> MACHINE_ARCHITECTURE variables in HTML.
>
> Probably because they haven't been defined the env variables.
>
>
>
>
> With your fix, by using "uname -r" and "uname -m", to avoid to report wro=
ng
>>information, you have to run the "genhtml.pl" script over the target syst=
em
> because if >you run the genhtml.pl on the host, you will get wrong
> information about the kernel >version and machine architecture.
>
>
> No.
> As per my understanding to make generic script =93uname -r" and "uname
> -m" are best way of use. All the target Machines are wont have full
> =93env=94 support to extract KERNEL_VERSION and MACHINE_ARCHITECTURE info.
> Ofcourse my target Machine can not extract these variables.
>
> No env variables have to be processed in the target. The env variables wi=
ll
> be used on the HOST execution of genthml.pl.
>
>
> "uname -r" and "uname -m" are from target not from Host I guess.
> Because runltp script will runs on target so obviously genhtml.pl will
> run when =96g option is  specified. =93 #sh runltp =96g
> ltp-full-results-file.html=94
>
>
> Moreover, the assumption to run genhtml.pl over the target is not safe as
> often the target >systems are embedded systems which do not support PERL.
>
>
> Yes. That is true.
> When we run runltp with =96g option to create HTML file the person using
> this option should have knowledge that this script will use PERL
> script if there is no PERL no HTML file will generate right?
>
>
> No, with the usage of env variables on the "genhtml.pl", you can have HTML
> file even though PERL is not supported on your target. This is an advanta=
ge!
>
> Moreover, you can manage and process "off-line" LTP report without having
> the risk to add in the report HOST information instead of TARGET ones.
>
>
>
> With the fix I've proposed and accepted, the LTP-user by means of the sim=
ple
> env >variables, can define the right information to be reported on the LTP
> results table about >kernel version and machine architecture.
>
>
> I have attached my HTML output file after and before patch.
> Please share your commands for ltp executions and results HTML file
> and other files.
> Before and after your patch.
>
> The steps I follow are simply:
>
> 1) runltp >> LTP.log (run on the TARGET platform);
>
> 2)=A0 export KERNEL_VERSION=3D" xxxxxxxxxxxxxxxx"
> =A0=A0=A0=A0 export MACHINE_ARCH=3D" xxxxxxxxxxxxxxxxxxxxx"
> =A0 =A0=A0 ...................... (run on the HOST platform)
>
> 3) genhtml.pl LTP.log LTP.html (run on the HOST platform);
>
> In this way I avoid to make assumptions about TARGET requirements (PERL,
> HTML, etc...).
>
> The piece of attached LTP-log.html shows what I got.
>
> I confirm my opinion to keep the current policy to generate HTML summary
> info.
>
> Best Regards,
> FR
>
>
>
> Summary Report
>
> Test SummaryPan reported all Test Pass
> LTP Version ltp-full-20090430
> Start Time Fri May 22, 2009 - 2.44 pm
> End Time Fri May 22, 2009 - 2.44 pm
> Log Result http://www.stlinux.com/drupal/
> Output/Failed Result http://www.stlinux.com/drupal/
> Total Tests
> Total Test TPASS:
> Total Test TFAIL:
> Total Test TBROK
> Total Test TWARN
> Total Test TRETR
> Total Test TCONF 7
> Kernel Version linux-sh4-2.6.23_stm23_120
> Machine Architecture SuperH(SH) - STBi7100c3 reference board -mb442-
> Hostname STSLX02
> Click Here for Detailed Report
>
>

---------------------------------------------------------------------------=
---
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing =

server and web deployment.
http://p.sf.net/sfu/businessobjects
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
