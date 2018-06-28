From: Abhishek Kumar Rai <abhishekr@eximiusdesign.com>
Date: Thu, 28 Jun 2018 10:51:33 +0530
Subject: [LTP] Regarding Use the Latest LTP on Latest YOCTO build
In-Reply-To: <20180627141145.GC32300@rei>
References: <CALYWmf98UHkNKAeR3EKTSGhKYzWCs-LjVoDSo=Ze1yfPGduYAQ@mail.gmail.com>
 <20180627141145.GC32300@rei>
Message-ID: <CALYWmf_QWDGFUCqNdm3su1xxKeOR4x+3Mwfqs9R7HV0ngMGCeQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

 Hi Cyril Hrubis,
Thanks for your prompt reply.

I have some doubt please clarify
I am getting following errors while building LTP with YOCTO(2.3)
{{{

     ltp-20170116-r0 do_compile: NOTE: ltp: compiling from external source
tree /home/sathishc/kapil/build/https:/github.com/linux-test-project/ltp.git
     ERROR: ltp-20170116-r0 do_compile: oe_runmake failed
     ERROR: ltp-20170116-r0 do_compile: Function failed: do_compile (log
file is located at
/home/sathishc/kapil/build/tmp/work/cortexa9hf-neon-agl-linux-gnueabi/ltp/20170116-
r0/temp
     /log.do_compile.161006)
     ERROR: Logfile of failure stored in:
/home/sathishc/kapil/build/tmp/work/cortexa9hf-neon-agl-
linux-gnueabi/ltp/20170116-r0/temp/log.do_compile.161006
     Log data follows:
     | DEBUG: Executing python function externalsrc_compile_prefunc
     | NOTE: ltp: compiling from external source tree
/home/sathishc/kapil/build/https:/github.com/linux-test-project/ltp.git
     | DEBUG: Python function externalsrc_compile_prefunc finished
     | DEBUG: SITE files ['endian-little', 'bit-32', 'arm-common',
'arm-32', 'common-linux', 'common-glibc', 'arm-linux', 'arm-linux-gnueabi',
'common']
     | DEBUG: Executing shell function do_compile
     | NOTE: make -j 16
     | ERROR: oe_runmake failed
     | make: Entering directory '/home/sathishc/kapil/build/https:/
github.com/linux-test- project/ltp.git/testcases/kernel'
     | make: 'include/linux_syscall_numbers.h' is up to date.
     | make: Leaving directory '/home/sathishc/kapil/build/https:/
github.com/linux-test- project/ltp.git/testcases/kernel'
     | /home/sathishc/kapil/build/https:/github.com/linux-test-
project/ltp.git/include/mk/automake.mk:108: *** target pattern contains no
'%'.  Stop.
     | ERROR: Function failed: do_compile (log file is located at
/home/sathishc/kapil/build/tmp/work/cortexa9hf-neon-agl-linux-gnueabi/ltp/20170116-
r0/temp/log.do_compile.161006)

}}}
Note :
        $ bitbake --version
           BitBake Build Tool Core version 1.34.0
Regards,
Abhishek

On Wed, Jun 27, 2018 at 7:41 PM, Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > I am planning to use the LTP latest version on YOCTO latest vesion.
> > It seems that the earlier YOCTO versions are released with LTP and
> > latest version are not.
> > Found the below difficulties so far:
> > 1. Latest LTP version(20180118) suitable for old gcc version(4.8).
> > 2. But at the same time, latest version of YOCTO build(2.3) supporting
> > latest
> > gcc version(6.3) only.
> >
> > so we want to use a latest LTP version(20180118) with latest YOCTO
> > build(2.3) which has latest gcc version(6.3) .
> >
> > Please share your valuable inputs with me to achieve the same.
>
> LTP should not depend on gcc version at all, it should compile fine with
> anything new enough. We do test the build with travis for each commit
> againts various gcc versions starting at 4.9 to gcc 7 and also with
> several clang versions.
>
> --
> Cyril Hrubis
> chrubis@suse.cz
>

-- 














The information contained in this e-mail message (including 
any 


attachments) may be confidential, proprietary, privileged, or 
otherwise


exempt from disclosure under applicable laws. It is intended to 
be 


conveyed only to the designated recipient(s). Any use, dissemination, 



distribution, printing, retaining or copying of this e-mail (including 
its 


attachments) by unintended recipient(s) is strictly prohibited and 
may 


be unlawful. If you are not an intended recipient of this e-mail, or 
believe 


that you have received this e-mail in error, please notify the 
sender 


immediately (by replying to this e-mail), delete any and all 
copies of 


this e-mail (including any attachments) from your system, and 
do not


disclose the content of this e-mail to any other person. Thank you 
for your cooperation.






-- 
_This e-mail message (including any attachments) may be confidential, 
proprietary, privileged, or otherwise exempt from disclosure under 
applicable laws. If you are not an intended recipient, please delete this 
message. Thank you.
_
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20180628/55757fde/attachment-0001.html>
