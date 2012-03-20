Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <carmelo.amoroso@st.com>) id 1S9uX0-0007WR-KK
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 08:35:02 +0000
Received: from eu1sys200aog112.obsmtp.com ([207.126.144.133])
	by sog-mx-3.v43.ch3.sourceforge.com with smtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1S9uWu-0002y7-SI
	for ltp-list@lists.sourceforge.net; Tue, 20 Mar 2012 08:35:02 +0000
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 96D3217C
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Mar 2012 08:34:34 +0000 (GMT)
Received: from mail7.sgp.st.com (mail7.sgp.st.com [164.129.223.81])
	by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 4A94018DD
	for <ltp-list@lists.sourceforge.net>;
	Tue, 20 Mar 2012 08:34:34 +0000 (GMT)
Message-ID: <4F6840EB.5000306@st.com>
Date: Tue, 20 Mar 2012 09:33:47 +0100
From: Carmelo AMOROSO <carmelo.amoroso@st.com>
MIME-Version: 1.0
References: <653A85C7F32C4741880F71219266EA02612A3E578E@EXGMBX01.sasken.com>
In-Reply-To: <653A85C7F32C4741880F71219266EA02612A3E578E@EXGMBX01.sasken.com>
Subject: Re: [LTP] cannot find -lpthread error in ltp cross compilation for
 Android
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
To: ltp-list@lists.sourceforge.net

On 19/03/2012 12.59, Sandeep Mahato wrote:
> Hi,
>   I am trying to cross compile LTP using NDK toolchain for Android . while executing the "make all" I am facing the below error.
> 
> pcb-msandeep:/u/ltp14032012/ltp-full-20120104# make all
> make -C "lib" \
>                 -f "/u/ltp14032012/ltp-full-20120104/lib/Makefile" all
> make[1]: Entering directory `/u/ltp14032012/ltp-full-20120104/lib'
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/u/ltp14032012/ltp-full-20120104/lib'
> make -C "pan" \
>                 -f "/u/ltp14032012/ltp-full-20120104/pan/Makefile" all
> make[1]: Entering directory `/u/ltp14032012/ltp-full-20120104/pan'
> /u/ltp14032012/ltp-full-20120104/pan/Makefile:43: ltp-scanner will not be built because a working copy of lex was not found
> make[1]: Nothing to be done for `all'.
> make[1]: Leaving directory `/u/ltp14032012/ltp-full-20120104/pan'
> make -C "utils" \
>                 -f "/u/ltp14032012/ltp-full-20120104/utils/Makefile" all
> make[1]: Entering directory `/u/ltp14032012/ltp-full-20120104/utils'
> make[2]: Entering directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark'
> make[3]: Entering directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark/ebizzy-0.3'
> arm-linux-androideabi-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I../../../include -I../../../include   -L../../../lib  ebizzy.c   -lpthread -o ebizzy
> /usr/local/android-ndk-r7/my-android-toolchain/bin/../lib/gcc/arm-linux-androideabi/4.4.3/../../../../arm-linux-androideabi/bin/ld: cannot find -lpthread
> collect2: ld returned 1 exit status
> make[3]: *** [ebizzy] Error 1
> make[3]: Leaving directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark/ebizzy-0.3'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/u/ltp14032012/ltp-full-20120104/utils/benchmark'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/u/ltp14032012/ltp-full-20120104/utils'
> make: *** [utils-all] Error 2
> 
> Can anybody please tell me why this "cannot find -lpthread" error is coming and how to resolve that.
> 

bionic (the Android C runtime library) does provide pthreads into libc,
so you don't need to link against libpthread.

> 
> Regards
> Sandeep
> 

cheers,
carmelo

> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
> 
> ------------------------------------------------------------------------------
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here 
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 


------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
