Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1XHxTT-0006rN-P2
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 16:01:59 +0000
Received: from aserp1040.oracle.com ([141.146.126.69])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XHxTR-0002TI-Ps
	for ltp-list@lists.sourceforge.net; Thu, 14 Aug 2014 16:01:59 +0000
Message-ID: <53ECDD67.9050101@oracle.com>
Date: Thu, 14 Aug 2014 20:01:43 +0400
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
MIME-Version: 1.0
References: <1408005051-22700-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<612129579.7085586.1408017043505.JavaMail.zimbra@redhat.com>
In-Reply-To: <612129579.7085586.1408017043505.JavaMail.zimbra@redhat.com>
Subject: Re: [LTP] [PATCH] sparc64 syscall definitions' fixes
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



On 08/14/2014 03:50 PM, Jan Stancek wrote:
>
>
>
>
> ----- Original Message -----
>> From: "Stanislav Kholmanskikh" <stanislav.kholmanskikh@oracle.com>
>> To: ltp-list@lists.sourceforge.net
>> Cc: "vasily isaenko" <vasily.isaenko@oracle.com>
>> Sent: Thursday, 14 August, 2014 10:30:51 AM
>> Subject: [LTP] [PATCH] sparc64 syscall definitions' fixes
>>
>> 1. Changed '__sparc64__' to 'defined(__sparc__) && defined(__arch64__)'
>> 2. Removed non-implemented syscall numbers from sparc64.in (in accordance
>>     to linux-stable/arch/sparc/include/uapi/asm/unistd.h)
>> 2. Re-executed regen.sh
>>
>> Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
>> ---
>> Hi!
>>
>> I forgot to send it with earlier "SPARC fixes" series.
>>
>> I will be more than happy, if it gets reviewed before the forthcoming
>> release.
>>
>> Thanks.
>
> Pushed.

Thank you, Jan, Cyril.



------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
