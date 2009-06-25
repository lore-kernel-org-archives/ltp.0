Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <naresh.kernel@gmail.com>) id 1MJp0G-0002Lo-6L
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 13:28:36 +0000
Received: from mail-gx0-f227.google.com ([209.85.217.227])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MJp0B-0005ka-Sq
	for ltp-list@lists.sourceforge.net; Thu, 25 Jun 2009 13:28:36 +0000
Received: by gxk27 with SMTP id 27so2703428gxk.10
	for <ltp-list@lists.sourceforge.net>;
	Thu, 25 Jun 2009 06:28:30 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 25 Jun 2009 17:47:57 +0530
Message-ID: <f5a7b3810906250517k3b8c3bf3gde1957e93c95314@mail.gmail.com>
From: naresh kamboju <naresh.kernel@gmail.com>
Subject: Re: [LTP] [PATCH] Re::personality test case build fails
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
To: Subrata Modak <subrata@linux.vnet.ibm.com>, Jiri Palecek <jpalecek@web.de>, Pradeep K Surisetty <pradeepkumars@in.ibm.com>
Cc: ltp-list@lists.sourceforge.net

Hi,

>+#ifdef __NR_personality
 >int main(int ac, char **av)
 >{

>+#else
>+int main(int ac, char **av)
>+{
>+       tst_resm(TCONF, "personality() not defined in your system");
>+       tst_exit();
>+}
>+#endif


Instead of using
#ifdef __NR_personality
 in test code, Better we will add these this syscall numbers in the
ltp/testcases/kernel/include/ARCHXXX.in files.
This can be Multi ARCH support.

Jiri,
I think you are doing Multi ARCH support right?

Your suggestions are welcome :)

Best regards
Naresh Kamboju

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
