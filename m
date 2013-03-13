Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <markos.chandras@gmail.com>) id 1UFpNf-0000Gs-Vk
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:22:24 +0000
Received: from mail-wg0-f42.google.com ([74.125.82.42])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UFpNf-0004PW-4M
	for ltp-list@lists.sourceforge.net; Wed, 13 Mar 2013 17:22:23 +0000
Received: by mail-wg0-f42.google.com with SMTP id 12so183303wgh.1
	for <ltp-list@lists.sourceforge.net>;
	Wed, 13 Mar 2013 10:22:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <201303131320.17542.vapier@gentoo.org>
References: <1363183294-21203-1-git-send-email-markos.chandras@gmail.com>
	<201303131320.17542.vapier@gentoo.org>
From: Markos Chandras <markos.chandras@gmail.com>
Date: Wed, 13 Mar 2013 17:21:56 +0000
Message-ID: <CAG2jQ8ibH=Z2HPrt-a250Cub8vbtCdDSFFq12=C5+S-eA8+EpA@mail.gmail.com>
Subject: Re: [LTP] [PATCH 1/2] syscalls/getdents: Use getdents64 if
 SYS_getdents is not defined
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
To: Mike Frysinger <vapier@gentoo.org>
Cc: ltp-list@lists.sourceforge.net

On 13 March 2013 17:20, Mike Frysinger <vapier@gentoo.org> wrote:
> On Wednesday 13 March 2013 10:01:34 Markos Chandras wrote:
>> +#ifdef SYS_getdents
>>  struct linux_dirent {
>>       unsigned long   d_ino;
>>       unsigned long   d_off;
>>       unsigned short  d_reclen;
>>       char            d_name[];
>>  };
>> +#else
>> +/* Use the 64-bit definition */
>> +struct linux_dirent {
>> +     unsigned long long      d_ino;
>> +     long long               d_off;
>> +     unsigned short          d_reclen;
>> +     unsigned char           d_type;
>> +     char                    d_name[0];
>
> any reason for using [0] instead of [] ?
> -mike

Nope just copying what kernel does in $KDIR/include/linux/dirent.h

-- 
Regards,
Markos Chandras

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_mar
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
