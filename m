Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <alexey.kodanev@oracle.com>) id 1YdCsN-0006RR-3H
	for ltp-list@lists.sourceforge.net; Wed, 01 Apr 2015 07:15:47 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YdCsM-0001Hz-71
	for ltp-list@lists.sourceforge.net; Wed, 01 Apr 2015 07:15:47 +0000
Message-ID: <551B9B15.10302@oracle.com>
Date: Wed, 01 Apr 2015 10:15:33 +0300
From: Alexey Kodanev <alexey.kodanev@oracle.com>
MIME-Version: 1.0
References: <1427787975-10668-1-git-send-email-gux.fnst@cn.fujitsu.com>
	<551AB4B5.4020902@oracle.com> <551B4C2F.3040108@cn.fujitsu.com>
In-Reply-To: <551B4C2F.3040108@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/6] lib6/runcc.c: use TCONF instead of TBROK when
 no C compiler is present
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
To: "gux.fnst" <gux.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
On 04/01/2015 04:38 AM, gux.fnst wrote:
>>>       if (WEXITSTATUS(es) == 127) {
>>> -        tst_resm(TBROK, "can't run C compiler: \"%s\"", cmd);
>>> +        tst_resm(TCONF, "can't run C compiler: \"%s\"", cmd);
>>>           if (unlink(filename) < 0)
>>>               tst_resm(TWARN, "%s; unlink \"%s\" failed: %s", tname,
>>>                    filename, strerror(errno));
>>
>> Why not 'tst_brkm(TCONF, ...)', do we need to proceed further?
>>
>
> The function "runcc" has created a file named "filename" before
> executing "cmd" command, so I think we should delete this file
> after tst_resm(TCONF,...).
>

So, there is temp test directory... you could pass some cleanup function 
to tst_brkm().

Thanks,
Alexey


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
