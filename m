Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <francesco.rundo@st.com>) id 1MEfD7-0006vo-Kb
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2009 08:00:33 +0000
Received: from eu1sys200aog104.obsmtp.com ([207.126.144.117])
	by 1b2kzd1.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MEfD5-0001Cr-GH
	for ltp-list@lists.sourceforge.net; Thu, 11 Jun 2009 08:00:33 +0000
Message-ID: <4A30B95F.4090903@st.com>
Date: Thu, 11 Jun 2009 09:59:27 +0200
From: Francesco RUNDO <francesco.rundo@st.com>
MIME-Version: 1.0
References: <4A267148.8000700@st.com>
	<1244114998.4879.25.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1244114998.4879.25.camel@subratamodak.linux.ibm.com>
Content-Type: multipart/mixed; boundary="------------080606030404040104070803"
Subject: Re: [LTP] kernel/controllers/ testcase and CGROUPS support
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080606030404040104070803
Content-Type: multipart/alternative;
	boundary="------------040702090007020305040804"


--------------040702090007020305040804
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Subrata,

please, replace on the LTP main the previous patch with ones attached.
The attached patch add the right labels of ifdef.

Sorry for that.

Thanks in advance.
--
Francesco Rundo

Subrata Modak wrote:

>On Wed, 2009-06-03 at 14:49 +0200, Francesco RUNDO wrote:
>  
>
>>This patch allows the cross-build of kernel/controllers (cgroups
>>tests) testcase changing the policy to check the cgroups capability at
>>build-time.
>>Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
>>    
>>
>
>Great if that helps your CROSS_COMPILE environment. Merged.
>
>Regards--
>Subrata
>
>  
>
>>---
>>ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig  2009-05-26 15:37:35.140000000 +0200
>>+++
>>ltp-full-20090430-cross/testcases/kernel/controllers/Makefile       2009-05-28 13:36:36.669998000 +0200
>>@@ -1,10 +1,26 @@
>>+ifdef $(CROSS_COMPILE)
>>+CHECK_CGROUP := $(shell test -f
>>$(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
>>+else
>> CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
>> CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut
>>-f1)
>> CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut
>>-f1)
>> CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups
>>2>/dev/null|cut -f1)
>> CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null|
>>cut -f1)
>> CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|
>>cut -f1)
>>+endif
>>
>>+ifdef $(CROSS_COMPILE)
>>+ifeq ($(CHECK_CGROUP),cgroup)
>>+SUBDIRS += cgroup
>>+SUBDIRS += cpuctl
>>+SUBDIRS += memctl
>>+SUBDIRS += io-throttle
>>+SUBDIRS += freezer
>>+SUBDIRS += cpuset
>>+else
>>+$(info "Kernel is not compiled with control cgroup support")
>>+endif
>>+else
>> ifeq ($(CHECK_CGROUP),cgroup)
>> SUBDIRS += cgroup
>> else
>>@@ -36,6 +52,7 @@
>> else
>> $(info "Kernel is not compiled with cpuset resource controller
>>support")
>> endif
>>+endif
>>
>> # If at least one of the controllers is available then build
>>libcontrollers.
>> ifneq ($(SUBDIRS),)
>>    
>>
>
>
>  
>

--------------040702090007020305040804
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
please, replace on the LTP main the previous patch with ones attached.<br>
The attached patch add the right labels of ifdef.<br>
<br>
Sorry for that.<br>
<br>
Thanks in advance.<br>
--<br>
Francesco Rundo<br>
<br>
Subrata Modak wrote:<br>
<blockquote type="cite"
 cite="mid1244114998.4879.25.camel@subratamodak.linux.ibm.com">
  <pre wrap="">On Wed, 2009-06-03 at 14:49 +0200, Francesco RUNDO wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">This patch allows the cross-build of kernel/controllers (cgroups
tests) testcase changing the policy to check the cgroups capability at
build-time.
Signed-off-by: Francesco Rundo <a class="moz-txt-link-rfc2396E" href="mailto:francesco.rundo@st.com">&lt;francesco.rundo@st.com&gt;</a>
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Great if that helps your CROSS_COMPILE environment. Merged.

Regards--
Subrata

  </pre>
  <blockquote type="cite">
    <pre wrap="">---
ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig  2009-05-26 15:37:35.140000000 +0200
+++
ltp-full-20090430-cross/testcases/kernel/controllers/Makefile       2009-05-28 13:36:36.669998000 +0200
@@ -1,10 +1,26 @@
+ifdef $(CROSS_COMPILE)
+CHECK_CGROUP := $(shell test -f
$(TARGET_DIR)/usr/include/linux/cgroupstats.h &amp;&amp; echo 'cgroup')
+else
 CHECK_CGROUP := $(shell test -f /proc/cgroups &amp;&amp; echo 'cgroup')
 CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2&gt;/dev/null|cut
-f1)
 CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2&gt;/dev/null|cut
-f1)
 CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups
2&gt;/dev/null|cut -f1)
 CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2&gt;/dev/null|
cut -f1)
 CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2&gt;/dev/null|
cut -f1)
+endif

+ifdef $(CROSS_COMPILE)
+ifeq ($(CHECK_CGROUP),cgroup)
+SUBDIRS += cgroup
+SUBDIRS += cpuctl
+SUBDIRS += memctl
+SUBDIRS += io-throttle
+SUBDIRS += freezer
+SUBDIRS += cpuset
+else
+$(info "Kernel is not compiled with control cgroup support")
+endif
+else
 ifeq ($(CHECK_CGROUP),cgroup)
 SUBDIRS += cgroup
 else
@@ -36,6 +52,7 @@
 else
 $(info "Kernel is not compiled with cpuset resource controller
support")
 endif
+endif

 # If at least one of the controllers is available then build
libcontrollers.
 ifneq ($(SUBDIRS),)
    </pre>
  </blockquote>
  <pre wrap=""><!---->

  </pre>
</blockquote>
</body>
</html>

--------------040702090007020305040804--

--------------080606030404040104070803
Content-Type: text/plain; name="ltp-full-20090430-fix-cgroups-testcase.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="ltp-full-20090430-fix-cgroups-testcase.patch"

This patch allows the cross-build of kernel/controllers (cgroups tests) testcase changing the policy to check the cgroups capability at build-time.
Signed-off-by: Francesco Rundo <francesco.rundo@st.com>
--- ltp-full-20090430-cross/testcases/kernel/controllers/Makefile.orig	2009-05-26 15:37:35.140000000 +0200
+++ ltp-full-20090430-cross/testcases/kernel/controllers/Makefile	2009-05-28 13:36:36.669998000 +0200
@@ -1,10 +1,26 @@
+ifdef CROSS_COMPILE
+CHECK_CGROUP := $(shell test -f $(TARGET_DIR)/usr/include/linux/cgroupstats.h && echo 'cgroup')
+else
 CHECK_CGROUP := $(shell test -f /proc/cgroups && echo 'cgroup')
 CHECK_CPUCTL := $(shell grep -w cpu /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_MEMCTL := $(shell grep -w memory /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_BLOCKIOCTL := $(shell grep -w blockio /proc/cgroups 2>/dev/null|cut -f1)
 CHECK_FREEZER := $(shell grep -w freezer /proc/cgroups 2>/dev/null| cut -f1)
 CHECK_CPUSETCTL = $(shell grep -w cpuset /proc/cgroups 2>/dev/null|cut -f1)
+endif
 
+ifdef CROSS_COMPILE
+ifeq ($(CHECK_CGROUP),cgroup)
+SUBDIRS += cgroup
+SUBDIRS += cpuctl
+SUBDIRS += memctl
+SUBDIRS += io-throttle
+SUBDIRS += freezer
+SUBDIRS += cpuset
+else
+$(info "Kernel is not compiled with control cgroup support")
+endif
+else
 ifeq ($(CHECK_CGROUP),cgroup)
 SUBDIRS += cgroup
 else
@@ -36,6 +52,7 @@
 else
 $(info "Kernel is not compiled with cpuset resource controller support")
 endif
+endif
 
 # If at least one of the controllers is available then build libcontrollers.
 ifneq ($(SUBDIRS),)

--------------080606030404040104070803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Crystal Reports - New Free Runtime and 30 Day Trial
Check out the new simplified licensing option that enables unlimited
royalty-free distribution of the report engine for externally facing 
server and web deployment.
http://p.sf.net/sfu/businessobjects
--------------080606030404040104070803
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------080606030404040104070803--


