Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1YIZvq-0001uN-Ax
	for ltp-list@lists.sourceforge.net; Tue, 03 Feb 2015 09:38:06 +0000
Date: Tue, 3 Feb 2015 10:37:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20150203093752.GA4264@rei.scz.novell.com>
References: <54D08FAC.5010601@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <54D08FAC.5010601@linux.vnet.ibm.com>
Subject: Re: [LTP] proposed patch to fix sendmsg01 invalid flags set w/
 control ; returned -1 (expected -1), errno 22 (expected 95)
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
To: snehalphule <snehal@linux.vnet.ibm.com>
Cc: ltp-list@lists.sourceforge.net, Chuck Ebbert <cebbert.lkml@gmail.com>

Hi!
> *Description:*
> For bug: https://bugs.launchpad.net/linaro-qa/+bug/1327251
> Purpose of Change: Because of code changes in socket.c file for 
> 32bit-userspace, return value changed to EINVAL in case of 
> 32bit-userspace/64-bit-kernelspace.
> Test changed to check if 32user/64kernel , then return value should be 
> checked to EINVAL ,
> for other systems return value should be EOPNOTSUPP
> 
> Kernel : 3.10.0-123.13.2
> Signed-off-by: snehalphule <snehal@linux.vnet.ibm.com>

I can see this exact failure when I compile the testsuite with -m32 on
64bit hardware as well. But the patch below is wrong on several levels.

My guess is that the root of the problem is similar to the problem fixed in:

commit 1153a8438fe45530eb480d902271476c2e330663
Author: Chuck Ebbert <cebbert.lkml@gmail.com>
Date:   Wed Oct 1 17:10:32 2014 -0500

    recvfrom01: fix test for invalid message flags


The test passes ~MSG_CMSG_COMPAT as flags and expect to hit particular safety
check. The difference may be that the order of checks is different for compat
syscalls, but that is just a guess. This would need more investigation to
figure out what is wrong.

> --- ltp-full-20140828/testcases/kernel/syscalls/sendmsg/sendmsg01.c.orig 
> 2015-01-23 00:54:22.804582530 -0600
> +++ ltp-full-20140828/testcases/kernel/syscalls/sendmsg/sendmsg01.c 
> 2015-01-23 00:57:26.149032808 -0600
> @@ -677,6 +677,38 @@ static void setup4(void)
>       control->cmsg_type = SCM_RIGHTS;
>       *(int *)CMSG_DATA(control) = tfd;
>       controllen = control->cmsg_len;
> +
> +        // In case of Compact (32bit) user space and 64bit kernel 
> space, return value is EINVAL
> +        if (tdat[testno].flags == (unsigned)~MSG_CMSG_COMPAT)
> +        {
> +            char user_space_bit[BUFSIZ];
> +            char kernel_arch[BUFSIZ];
> +            int kernel_space_bit;
> +
> +            FILE *pipe = popen("getconf LONG_BIT", "r");
> +            if (fgets(user_space_bit, BUFSIZ, pipe) != NULL)
> +            {
> +               pipe = popen("arch", "r");
> +               if (fgets(kernel_arch, BUFSIZ, pipe) != NULL)
> +               {
> +                   // Remove carriage return from the buffer
> +                   size_t len = strlen(user_space_bit);
> +                   if (len > 0 && user_space_bit[len-1] == '\n') { 
> user_space_bit[--len] = '\0';}
> +                   len = strlen(kernel_arch);
> +                   if (len > 0 && kernel_arch[len-1] == '\n') { 
> kernel_arch[--len] = '\0';}
> +
> +                   // Check if Kernel used is 64 bit or 32 bit
> +                   if (!strcmp(kernel_arch, "ppc64") || 
> !strcmp(kernel_arch, "s390x") || !strcmp(kernel_arch, "x86_64"))
> +                      kernel_space_bit = 64;
> +                   else
> +                      kernel_space_bit = 32;
> +
> +                   // Only if it is Compact user space (32bit), then 
> return value is EINVAL
> +                   if (atoi(user_space_bit) == 32  && kernel_space_bit 
> == 64)
> +                   tdat[testno].experrno = EINVAL;
> +               }
> +            }
> +         }
>   }
> 
>   static void cleanup4(void)
> 
> 
> 

> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming. The Go Parallel Website,
> sponsored by Intel and developed in partnership with Slashdot Media, is your
> hub for all things parallel software development, from weekly thought
> leadership blogs to news, videos, case studies, tutorials and more. Take a
> look and join the conversation now. http://goparallel.sourceforge.net/

> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
