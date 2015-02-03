Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <snehal@linux.vnet.ibm.com>) id 1YIZRq-0005dk-L3
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 09:07:06 +0000
Received: from e28smtp08.in.ibm.com ([122.248.162.8])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YIZRo-0004j0-Cu
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 09:07:06 +0000
Received: from /spool/local
	by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <ltp-list@lists.sourceforge.net> from <snehal@linux.vnet.ibm.com>; 
	Tue, 3 Feb 2015 14:36:56 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by d28dlp03.in.ibm.com (Postfix) with ESMTP id C81801258053
	for <ltp-list@lists.sourceforge.net>;
	Tue,  3 Feb 2015 14:37:55 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
	t1396rOp47120480
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:36:53 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
	t1396r9m024387
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:36:53 +0530
Received: from oc3708147017.ibm.com ([9.184.191.36])
	by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
	t1396rri024351
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Feb 2015 14:36:53 +0530
Message-ID: <54D08FAC.5010601@linux.vnet.ibm.com>
Date: Tue, 03 Feb 2015 14:36:52 +0530
From: snehalphule <snehal@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: [LTP] proposed patch to fix sendmsg01 invalid flags set w/ control ;
 returned -1 (expected -1), errno 22 (expected 95)
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2339057793223564214=="
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--===============2339057793223564214==
Content-Type: multipart/alternative;
	boundary="------------030604070305020100000809"

This is a multi-part message in MIME format.
--------------030604070305020100000809
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



*Description:*
For bug: https://bugs.launchpad.net/linaro-qa/+bug/1327251
Purpose of Change: Because of code changes in socket.c file for 
32bit-userspace, return value changed to EINVAL in case of 
32bit-userspace/64-bit-kernelspace.
Test changed to check if 32user/64kernel , then return value should be 
checked to EINVAL ,
for other systems return value should be EOPNOTSUPP


Kernel : 3.10.0-123.13.2
Signed-off-by: snehalphule <snehal@linux.vnet.ibm.com>

--- ltp-full-20140828/testcases/kernel/syscalls/sendmsg/sendmsg01.c.orig 
2015-01-23 00:54:22.804582530 -0600
+++ ltp-full-20140828/testcases/kernel/syscalls/sendmsg/sendmsg01.c 
2015-01-23 00:57:26.149032808 -0600
@@ -677,6 +677,38 @@ static void setup4(void)
      control->cmsg_type = SCM_RIGHTS;
      *(int *)CMSG_DATA(control) = tfd;
      controllen = control->cmsg_len;
+
+        // In case of Compact (32bit) user space and 64bit kernel 
space, return value is EINVAL
+        if (tdat[testno].flags == (unsigned)~MSG_CMSG_COMPAT)
+        {
+            char user_space_bit[BUFSIZ];
+            char kernel_arch[BUFSIZ];
+            int kernel_space_bit;
+
+            FILE *pipe = popen("getconf LONG_BIT", "r");
+            if (fgets(user_space_bit, BUFSIZ, pipe) != NULL)
+            {
+               pipe = popen("arch", "r");
+               if (fgets(kernel_arch, BUFSIZ, pipe) != NULL)
+               {
+                   // Remove carriage return from the buffer
+                   size_t len = strlen(user_space_bit);
+                   if (len > 0 && user_space_bit[len-1] == '\n') { 
user_space_bit[--len] = '\0';}
+                   len = strlen(kernel_arch);
+                   if (len > 0 && kernel_arch[len-1] == '\n') { 
kernel_arch[--len] = '\0';}
+
+                   // Check if Kernel used is 64 bit or 32 bit
+                   if (!strcmp(kernel_arch, "ppc64") || 
!strcmp(kernel_arch, "s390x") || !strcmp(kernel_arch, "x86_64"))
+                      kernel_space_bit = 64;
+                   else
+                      kernel_space_bit = 32;
+
+                   // Only if it is Compact user space (32bit), then 
return value is EINVAL
+                   if (atoi(user_space_bit) == 32  && kernel_space_bit 
== 64)
+                   tdat[testno].experrno = EINVAL;
+               }
+            }
+         }
  }

  static void cleanup4(void)




--------------030604070305020100000809
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>

    <meta http-equiv="content-type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-text-html" lang="x-unicode"> <br>
      <div class="moz-forward-container"><br>
        <font face="sans-serif" size="2"><b>Description:</b></font><br>
        For bug: <a class="moz-txt-link-freetext"
          href="https://bugs.launchpad.net/linaro-qa/+bug/1327251">https://bugs.launchpad.net/linaro-qa/+bug/1327251</a>
        <br>
        Purpose of Change: Because of code changes in socket.c file for
        32bit-userspace, return value changed to EINVAL in case of
        32bit-userspace/64-bit-kernelspace.<br>
        Test changed to check if 32user/64kernel , then return value
        should be checked to EINVAL ,<br>
        for other systems return value should be EOPNOTSUPP<br>
        <br>
        <br>
        Kernel : 3.10.0-123.13.2<br>
        Signed-off-by: snehalphule <a moz-do-not-send="true"
          class="moz-txt-link-rfc2396E"
          href="mailto:snehal@linux.vnet.ibm.com">&lt;snehal@linux.vnet.ibm.com&gt;</a>
        <br>
        <br>
        ---
        ltp-full-20140828/testcases/kernel/syscalls/sendmsg/sendmsg01.c.orig   
        2015-01-23 00:54:22.804582530 -0600<br>
        +++
        ltp-full-20140828/testcases/kernel/syscalls/sendmsg/sendmsg01.c   
        2015-01-23 00:57:26.149032808 -0600<br>
        @@ -677,6 +677,38 @@ static void setup4(void)<br>
             control-&gt;cmsg_type = SCM_RIGHTS;<br>
             *(int *)CMSG_DATA(control) = tfd;<br>
             controllen = control-&gt;cmsg_len;<br>
        +        <br>
        +        // In case of Compact (32bit) user space and 64bit
        kernel space, return value is EINVAL<br>
        +        if (tdat[testno].flags == (unsigned)~MSG_CMSG_COMPAT)<br>
        +        {<br>
        +            char user_space_bit[BUFSIZ];<br>
        +            char kernel_arch[BUFSIZ];<br>
        +            int kernel_space_bit;<br>
        +<br>
        +            FILE *pipe = popen("getconf LONG_BIT", "r");<br>
        +            if (fgets(user_space_bit, BUFSIZ, pipe) != NULL) <br>
        +            {<br>
        +               pipe = popen("arch", "r");<br>
        +               if (fgets(kernel_arch, BUFSIZ, pipe) != NULL)<br>
        +               {<br>
        +                   // Remove carriage return from the buffer<br>
        +                   size_t len = strlen(user_space_bit);<br>
        +                   if (len &gt; 0 &amp;&amp;
        user_space_bit[len-1] == '\n') { user_space_bit[--len] = '\0';}<br>
        +                   len = strlen(kernel_arch);<br>
        +                   if (len &gt; 0 &amp;&amp; kernel_arch[len-1]
        == '\n') { kernel_arch[--len] = '\0';}<br>
        +<br>
        +                   // Check if Kernel used is 64 bit or 32 bit
        <br>
        +                   if (!strcmp(kernel_arch, "ppc64") ||
        !strcmp(kernel_arch, "s390x") || !strcmp(kernel_arch, "x86_64"))<br>
        +                      kernel_space_bit = 64; <br>
        +                   else <br>
        +                      kernel_space_bit = 32;<br>
        +<br>
        +                   // Only if it is Compact user space (32bit),
        then return value is EINVAL<br>
        +                   if (atoi(user_space_bit) == 32  &amp;&amp; 
        kernel_space_bit == 64)<br>
        +                   tdat[testno].experrno = EINVAL;<br>
        +               }<br>
        +            }  <br>
        +         }<br>
         }<br>
         <br>
         static void cleanup4(void)<br>
        <br>
        <br>
      </div>
      <br>
    </div>
  </body>
</html>

--------------030604070305020100000809--



--===============2339057793223564214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
--===============2339057793223564214==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--===============2339057793223564214==--


