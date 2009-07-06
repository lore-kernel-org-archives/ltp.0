Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MNntS-00049d-0Z
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 13:06:02 +0000
Received: from eu1sys200aog116.obsmtp.com ([207.126.144.141])
	by 1b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNntO-0007xK-1j
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 13:06:00 +0000
Message-ID: <4A51F6A9.4000607@st.com>
Date: Mon, 06 Jul 2009 15:05:45 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>	
	<4A51E745.3060105@linux.vnet.ibm.com> <4A51F13C.3050701@st.com>
	<1246884921.4887.15.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1246884921.4887.15.camel@subratamodak.linux.ibm.com>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building
	cgroup	tests
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4150228605332575512=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sf.net

This is a multi-part message in MIME format.
--===============4150228605332575512==
Content-Type: multipart/alternative;
	boundary="------------060608080501030205080008"

This is a multi-part message in MIME format.
--------------060608080501030205080008
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrata,

Ok, thanks for your reply.
Currently I'm working with kernel 2.6.23-17 ported for SH platforms, 
without cgroup features.

My target was to understand if my previous patch can help Gowri....but I 
think no.... ;-)

Regards
Francesco Rundo

Subrata Modak wrote:

>On Mon, 2009-07-06 at 14:42 +0200, Francesco RUNDO wrote:
>  
>
>>Hi Gowri,
>>
>>thanks so much for your quick reply.
>>My question is: "Is there a 'real' scenario in which cgroup is enabled 
>>in the Kernel without cgroupstat.h header" ?
>>
>>    
>>
>
>Yes, there can be many situations.
>
>  
>
>>Because I think the above scenario (cgroup enabled but no cgroupstat.h 
>>header) is wrong so that your patch provide a "cover" for an error 
>>placed in the system. Is it true ?
>>
>>    
>>
>
>Say you have a older distro with kernel 2.6.18, where those stuff are
>not there. Now, you have built kernel 2.6.30 on it with CGROUP enabled,
>and booted in that kernel. So, your kernel is enabled with CGROUP, but
>you may not have the user utilities like the libcgroup, etc. And until
>you upgrade your system with latest glibc-headers or kernel-headers, any
>build for userspace tools using CGROUP*.h fiel fail.
>
>Regards--
>Subrata
>
>  
>
>>If my understanding is wrong, for me there are no concerns about your patch.
>>
>>Regards
>>Francesco Rundo
>>
>>gowrishankar wrote:
>>
>>    
>>
>>>Hi Francesco,
>>>
>>>Francesco RUNDO wrote:
>>>
>>>      
>>>
>>>>Hi Gowri,
>>>>
>>>>I've already fixed the same issue you reported. I've tested it 
>>>>successfully.
>>>>
>>>>Subrata has already merged my patch (please, find it in attachment).
>>>>
>>>>Please, check it before to submit another patch.
>>>>
>>>>        
>>>>
>>>I had already seen your patch and generated mine on top of Jun release 
>>>(which
>>>has your fix for CROSS_COMPILE).Your patch could not help in a 
>>>scenario where kernel has cgroup support but cgroupstat.h file is 
>>>missing in base OS, and
>>>build failed. And hence, I am proposing this patch.
>>>
>>>Thanks,
>>>Gowri
>>>
>>>      
>>>
>>>>Thanks
>>>>Regards
>>>>Francesco Rundo
>>>>
>>>>gowrishankar wrote:
>>>>
>>>>        
>>>>
>>>>>Hi Subrata,
>>>>>Please accept the patch below.
>>>>>
>>>>>Thanks,
>>>>>Gowri
>>>>>---
>>>>>cgroups: conditionally enable building cgroup tests
>>>>>
>>>>>controllers tests gets included into default ltp build if 
>>>>>"/proc/cgroup"
>>>>>exists. It stops the ltp build in realtime kernel environment where 
>>>>>kernel
>>>>>is new and supports cgroups, but necessary file 
>>>>>"linux/cgroupstats.h" may not
>>>>>exist in the base OS (like RHEL5.3). So configure command enables 
>>>>>the build,
>>>>>but actual build fails, due to missing header file.
>>>>>
>>>>>Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for 
>>>>>header file
>>>>>"linux/cgroupstats.h" and include controllers in the list of tests 
>>>>>to build.
>>>>>
>>>>>Tested the patch in non-RT as well as RT environment for the changes.
>>>>>
>>>>>Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
>>>>>Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
>>>>>---
>>>>>
>>>>>------------------------------------------------------------------------ 
>>>>>
>>>>>
>>>>>Index: ltp-full-20090630/m4/ltp-cgroupstats.m4
>>>>>===================================================================
>>>>>--- /dev/null    1970-01-01 00:00:00.000000000 +0000
>>>>>+++ ltp-full-20090630/m4/ltp-cgroupstats.m4    2009-07-03 
>>>>>13:41:55.000000000 +0530
>>>>>@@ -0,0 +1,9 @@
>>>>>+dnl
>>>>>+dnl LTP_CHECK_CGROUPSTATS
>>>>>+dnl ----------------------------
>>>>>+dnl
>>>>>+AC_DEFUN([LTP_CHECK_CGROUPSTATS],
>>>>>+[dnl
>>>>>+AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes]) 
>>>>>
>>>>>+AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
>>>>>+])
>>>>>Index: ltp-full-20090630/configure.ac
>>>>>===================================================================
>>>>>--- ltp-full-20090630.orig/configure.ac    2009-07-03 
>>>>>13:59:48.000000000 +0530
>>>>>+++ ltp-full-20090630/configure.ac    2009-07-03 14:00:14.000000000 
>>>>>+0530
>>>>>@@ -21,5 +21,6 @@
>>>>> LTP_CHECK_SELINUX
>>>>> LTP_CHECK_CRYPTO
>>>>> LTP_CHECK_TASKSTATS
>>>>>+LTP_CHECK_CGROUPSTATS
>>>>>
>>>>> AC_OUTPUT
>>>>>Index: ltp-full-20090630/testcases/kernel/Makefile
>>>>>===================================================================
>>>>>--- ltp-full-20090630.orig/testcases/kernel/Makefile    2009-07-03 
>>>>>14:01:25.000000000 +0530
>>>>>+++ ltp-full-20090630/testcases/kernel/Makefile    2009-07-03 
>>>>>14:02:42.000000000 +0530
>>>>>@@ -1,6 +1,12 @@
>>>>>-SUBDIRS = power_management numa containers controllers connectors 
>>>>>include fs io ipc mem pty sched security syscalls timers
>>>>>+include ../../config.mk
>>>>>+
>>>>>+SUBDIRS = power_management numa containers connectors include fs io 
>>>>>ipc mem pty sched security syscalls timers
>>>>> UCLINUX_SUBDIRS = include syscalls
>>>>>
>>>>>+ifeq ($(LTP_CHECK_CGROUPSTATS_HEADER),yes)
>>>>>+    SUBDIRS+= controllers
>>>>>+endif
>>>>>+
>>>>> all:
>>>>>     @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
>>>>>
>>>>>  
>>>>>------------------------------------------------------------------------ 
>>>>>
>>>>>
>>>>>------------------------------------------------------------------------------ 
>>>>>
>>>>>  
>>>>>------------------------------------------------------------------------ 
>>>>>
>>>>>
>>>>>_______________________________________________
>>>>>Ltp-list mailing list
>>>>>Ltp-list@lists.sourceforge.net
>>>>>https://lists.sourceforge.net/lists/listinfo/ltp-list
>>>>>  
>>>>>          
>>>>>
>>>      
>>>
>
>
>  
>

--------------060608080501030205080008
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Hi Subrata,<br>
<br>
Ok, thanks for your reply.<br>
Currently I'm working with kernel 2.6.23-17 ported for SH platforms,
without cgroup features.<br>
<br>
My target was to understand if my previous patch can help Gowri....but
I think no.... ;-)<br>
<br>
Regards<br>
Francesco Rundo<br>
<br>
Subrata Modak wrote:<br>
<blockquote type="cite"
 cite="mid1246884921.4887.15.camel@subratamodak.linux.ibm.com">
  <pre wrap="">On Mon, 2009-07-06 at 14:42 +0200, Francesco RUNDO wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi Gowri,

thanks so much for your quick reply.
My question is: "Is there a 'real' scenario in which cgroup is enabled 
in the Kernel without cgroupstat.h header" ?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Yes, there can be many situations.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Because I think the above scenario (cgroup enabled but no cgroupstat.h 
header) is wrong so that your patch provide a "cover" for an error 
placed in the system. Is it true ?

    </pre>
  </blockquote>
  <pre wrap=""><!---->
Say you have a older distro with kernel 2.6.18, where those stuff are
not there. Now, you have built kernel 2.6.30 on it with CGROUP enabled,
and booted in that kernel. So, your kernel is enabled with CGROUP, but
you may not have the user utilities like the libcgroup, etc. And until
you upgrade your system with latest glibc-headers or kernel-headers, any
build for userspace tools using CGROUP*.h fiel fail.

Regards--
Subrata

  </pre>
  <blockquote type="cite">
    <pre wrap="">If my understanding is wrong, for me there are no concerns about your patch.

Regards
Francesco Rundo

gowrishankar wrote:

    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi Francesco,

Francesco RUNDO wrote:

      </pre>
      <blockquote type="cite">
        <pre wrap="">Hi Gowri,

I've already fixed the same issue you reported. I've tested it 
successfully.

Subrata has already merged my patch (please, find it in attachment).

Please, check it before to submit another patch.

        </pre>
      </blockquote>
      <pre wrap="">I had already seen your patch and generated mine on top of Jun release 
(which
has your fix for CROSS_COMPILE).Your patch could not help in a 
scenario where kernel has cgroup support but cgroupstat.h file is 
missing in base OS, and
build failed. And hence, I am proposing this patch.

Thanks,
Gowri

      </pre>
      <blockquote type="cite">
        <pre wrap="">Thanks
Regards
Francesco Rundo

gowrishankar wrote:

        </pre>
        <blockquote type="cite">
          <pre wrap="">Hi Subrata,
Please accept the patch below.

Thanks,
Gowri
---
cgroups: conditionally enable building cgroup tests

controllers tests gets included into default ltp build if 
"/proc/cgroup"
exists. It stops the ltp build in realtime kernel environment where 
kernel
is new and supports cgroups, but necessary file 
"linux/cgroupstats.h" may not
exist in the base OS (like RHEL5.3). So configure command enables 
the build,
but actual build fails, due to missing header file.

Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for 
header file
"linux/cgroupstats.h" and include controllers in the list of tests 
to build.

Tested the patch in non-RT as well as RT environment for the changes.

Signed-off-by: Gowrishankar <a class="moz-txt-link-rfc2396E" href="mailto:gowrishankar.m@in.ibm.com">&lt;gowrishankar.m@in.ibm.com&gt;</a>
Tested-by: Gowrishankar <a class="moz-txt-link-rfc2396E" href="mailto:gowrishankar.m@in.ibm.com">&lt;gowrishankar.m@in.ibm.com&gt;</a>
---

------------------------------------------------------------------------ 


Index: ltp-full-20090630/m4/ltp-cgroupstats.m4
===================================================================
--- /dev/null    1970-01-01 00:00:00.000000000 +0000
+++ ltp-full-20090630/m4/ltp-cgroupstats.m4    2009-07-03 
13:41:55.000000000 +0530
@@ -0,0 +1,9 @@
+dnl
+dnl LTP_CHECK_CGROUPSTATS
+dnl ----------------------------
+dnl
+AC_DEFUN([LTP_CHECK_CGROUPSTATS],
+[dnl
+AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes]) 

+AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
+])
Index: ltp-full-20090630/configure.ac
===================================================================
--- ltp-full-20090630.orig/configure.ac    2009-07-03 
13:59:48.000000000 +0530
+++ ltp-full-20090630/configure.ac    2009-07-03 14:00:14.000000000 
+0530
@@ -21,5 +21,6 @@
 LTP_CHECK_SELINUX
 LTP_CHECK_CRYPTO
 LTP_CHECK_TASKSTATS
+LTP_CHECK_CGROUPSTATS

 AC_OUTPUT
Index: ltp-full-20090630/testcases/kernel/Makefile
===================================================================
--- ltp-full-20090630.orig/testcases/kernel/Makefile    2009-07-03 
14:01:25.000000000 +0530
+++ ltp-full-20090630/testcases/kernel/Makefile    2009-07-03 
14:02:42.000000000 +0530
@@ -1,6 +1,12 @@
-SUBDIRS = power_management numa containers controllers connectors 
include fs io ipc mem pty sched security syscalls timers
+include ../../config.mk
+
+SUBDIRS = power_management numa containers connectors include fs io 
ipc mem pty sched security syscalls timers
 UCLINUX_SUBDIRS = include syscalls

+ifeq ($(LTP_CHECK_CGROUPSTATS_HEADER),yes)
+    SUBDIRS+= controllers
+endif
+
 all:
     @set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done

  
------------------------------------------------------------------------ 


------------------------------------------------------------------------------ 

  
------------------------------------------------------------------------ 


_______________________________________________
Ltp-list mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Ltp-list@lists.sourceforge.net">Ltp-list@lists.sourceforge.net</a>
<a class="moz-txt-link-freetext" href="https://lists.sourceforge.net/lists/listinfo/ltp-list">https://lists.sourceforge.net/lists/listinfo/ltp-list</a>
  
          </pre>
        </blockquote>
      </blockquote>
      <pre wrap="">
      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------060608080501030205080008--



--===============4150228605332575512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------

--===============4150228605332575512==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============4150228605332575512==--


