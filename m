Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Sz0jc-0004qi-DY
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 07:31:16 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sz0jW-0003SH-TJ
	for ltp-list@lists.sourceforge.net; Wed, 08 Aug 2012 07:31:16 +0000
Received: by obc16 with SMTP id 16so786086obc.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 08 Aug 2012 00:31:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <5021FA02.8000905@casparzhang.com>
References: <1343924528-1811-1-git-send-email-xu.simon@oracle.com>
	<5021FA02.8000905@casparzhang.com>
Date: Wed, 8 Aug 2012 00:31:05 -0700
Message-ID: <CAGH67wRuCxnP_5GC1rnY=n4J7s7DDz1NFt=tVJR6f81NG3L+JA@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/1] capability: fix sys/capability.h compile error
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net

On Tue, Aug 7, 2012 at 10:32 PM, Caspar Zhang <caspar@casparzhang.com> wrote:
> On 08/03/2012 12:22 AM, Simon Xu wrote:
>> Capability testcases fail to compile with sys/capability.h of libcap-devel in
>> RHEL5-like distros:
>>
>> In file included from /usr/include/sys/capability.h:34, from cap_bounds_r.c:30:
>> /usr/include/linux/capability.h:70:
>>           error: expected specifier-qualifier-list before '__le32'
>>
>> This is due to sys/capability.h preventing the correct _LINUX_TYPES_H_ from
>> being included.  The problem can be bypassed by including linux/types.h in
>> capability testcases.
>>
>> Signed-off-by: Simon Xu <xu.simon@oracle.com>
>
> from doc/style-guide.txt:
>
> "
> 14. System headers
> ~~~~~~~~~~~~~~~~~~
>
> Don't use +linux/+ headers if at all possible. Usually they are replaced
> with
> +sys/+ headers as things work their way into glibc.  Furthermore, +linux/+
> headers get shuffled around a lot more than their +sys/+ counterparts it
> seems.
> "
>
> Do we have a better solution?

It's a guideline, not a hard rule. The intent was to avoid nasty
snaking #ifdefs [and special case autoconf tests], or avoid including
system headers (e.g. linux/inotify.h vs sys/inotify.h); this kind of
exists in LTP and exists in other projects like hdparm, iozone,
net-snmp, etc as there isn't a tight coupling between kernel and
userland in Linux.

I doublechecked and there really isn't a good way to check for this in
Fedora (at least), so it's ok, but the upstream author should be
encouraged to not do things like that in headers. It really wreaks
havoc with projects trying to achieve consistency.

Thanks,
-Garrett

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
