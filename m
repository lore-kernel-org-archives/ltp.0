Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1Z5ynY-0003eR-6y
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 16:05:44 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1Z5ynW-0006MU-0G
	for ltp-list@lists.sourceforge.net; Fri, 19 Jun 2015 16:05:43 +0000
Message-ID: <55843E93.3080003@oracle.com>
Date: Fri, 19 Jun 2015 19:08:51 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <5572ED1E.1020203@oracle.com>
	<1434457479-20493-1-git-send-email-zenglg.jy@cn.fujitsu.com>
	<1434457479-20493-2-git-send-email-zenglg.jy@cn.fujitsu.com>
In-Reply-To: <1434457479-20493-2-git-send-email-zenglg.jy@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v3 2/7] lib6/runcc.c: Cleanup
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net


On 06/16/2015 03:24 PM, Zeng Linggang wrote:
>   
> -char *filetmpl = "/tmp/%.*s_XXXXXX";
> +static const char *filetmpl = "/tmp/%.*s_XXXXXX";
>   

Sorry, I missed that one in the previous review, could you use 
tst_tmpdir()? So here should be "%.*s_XXXXX".

There is /tmp/test file that left after the test, it could be fixed if 
we hadn't used absolute path in the patch. I would print it in case of 
test-case failure.

>   
> -int runcc(char *tname, char *filename0, char *program)
> +static int runcc(char *tname, char *filename0, char *program)

If we don't use return value - why it is still "int runcc()"?

Also please change perror() and exit(1) to LTP library functions.

Thanks,
Alexey


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
