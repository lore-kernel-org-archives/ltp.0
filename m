Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hannuxx@gmail.com>) id 1P6qgd-0001Sd-LT
	for ltp-list@lists.sourceforge.net; Fri, 15 Oct 2010 20:15:31 +0000
Received: from mail-bw0-f47.google.com ([209.85.214.47])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P6qgc-0001E4-Kg
	for ltp-list@lists.sourceforge.net; Fri, 15 Oct 2010 20:15:31 +0000
Received: by bwz9 with SMTP id 9so2031764bwz.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 15 Oct 2010 13:15:24 -0700 (PDT)
Date: Fri, 15 Oct 2010 23:15:32 +0300
From: Hannu Heikkinen <hannuxx@iki.fi>
Message-ID: <20101015201532.GB2940@debian-master.elisa-laajakaista.fi>
References: <AANLkTikQh4d58rgjQNH=UfyVHEvzC+v-FNiFeEKhFrai@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTikQh4d58rgjQNH=UfyVHEvzC+v-FNiFeEKhFrai@mail.gmail.com>
Subject: Re: [LTP] PTY testcase
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
To: ARJIT SHARMA <joyarjit@gmail.com>
Cc: ltp-list@lists.sourceforge.net

On 14/10/10 11:56 +0530, ARJIT SHARMA wrote:
> Hi,
> 
>      PTY tests are failing.....
>      giving the error as    "TBROK: ptsname() call failed"
> 
>      i tried correcting it but doesnt worked out.
>      So please tell me the cause...
> 
> -- 
> Best Regards,
> Arjit Sharma.

Hi,

can u please send strace -f <your-ltp-run> over here?
-f gives log for childs also.

And also, please give exact info, which test case, what are all the lines,
etc.

What command:
# cat /proc/sys/kernel/pty/max

says?

br,
Hannu


> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list


------------------------------------------------------------------------------
Download new Adobe(R) Flash(R) Builder(TM) 4
The new Adobe(R) Flex(R) 4 and Flash(R) Builder(TM) 4 (formerly 
Flex(R) Builder(TM)) enable the development of rich applications that run
across multiple browsers and platforms. Download your free trials today!
http://p.sf.net/sfu/adobe-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
