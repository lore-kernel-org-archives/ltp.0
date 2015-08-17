Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1ZRKHs-0008H9-KQ
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 13:17:16 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ZRKHq-0006fp-Cx
	for ltp-list@lists.sourceforge.net; Mon, 17 Aug 2015 13:17:16 +0000
Message-ID: <55D1DED0.2080303@oracle.com>
Date: Mon, 17 Aug 2015 16:17:04 +0300
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1439813598-11524-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<980148897.10916298.1439815783172.JavaMail.zimbra@redhat.com>
In-Reply-To: <980148897.10916298.1439815783172.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH 1/2] ltp_rt_sigaction: SPARC fixes for -O0
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
To: Jan Stancek <jstancek@redhat.com>
Cc: vasily isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net



On 08/17/2015 03:49 PM, Jan Stancek wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>> To: ltp-list@lists.sourceforge.net
>> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
>> Sent: Monday, 17 August, 2015 2:13:17 PM
>> Subject: [LTP] [PATCH 1/2] ltp_rt_sigaction: SPARC fixes for -O0
>>
>> The *sigreturn_stub functions are copied from glibc, and they
>> work only if optimization > 0, since they expect that the compiler
>> does not add an epilogue.
>
> Isn't that prologue?
> Other than that it looks good to me, ACK.

Yes, sure. You are right. That was my typo :-[

Thanks.

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
