Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <vapierfilter@gmail.com>) id 1OlSwT-0003ki-5k
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:39:29 +0000
Received: from mail-fx0-f47.google.com ([209.85.161.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1OlSwS-0000Ie-AC
	for ltp-list@lists.sourceforge.net; Tue, 17 Aug 2010 20:39:29 +0000
Received: by fxm6 with SMTP id 6so4774192fxm.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 17 Aug 2010 13:39:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4C6AD62B.2010905@redhat.com>
References: <4C6AD62B.2010905@redhat.com>
Date: Tue, 17 Aug 2010 16:39:22 -0400
Message-ID: <AANLkTinp94tZRbNveZO3VzEQ_gOR1jFQadqVnvRR95ak@mail.gmail.com>
From: Mike Frysinger <vapier@gentoo.org>
Subject: Re: [LTP] problems building lchown02.c for uClinux
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
To: dmarlin@redhat.com
Cc: LTP list <ltp-list@lists.sourceforge.net>

On Tue, Aug 17, 2010 at 2:34 PM, David Marlin wrote:
> 'lchown02.c' does not build properly due to calls to mmap and
> get_high_address (which references sbrk) when UCLINUX=1 is defined.

you'll need to clarify.  it builds fine for me, it just may not run
correctly due to the assumptions of memory placement.

for runtime issues, how about we change lib/get_high_address.c to
return NULL for UCLINUX targets.  then in lchown.c, we can check for
NULL and skip the test when we get that value.

that leaves your ifdefing of -1 pointer address.  any sane nommu port
should reject that address in the kernel.  if yours isnt, fix your
kernel.
-mike

------------------------------------------------------------------------------
This SF.net email is sponsored by 

Make an app they can't live without
Enter the BlackBerry Developer Challenge
http://p.sf.net/sfu/RIM-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
