Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1Soq3Z-00058C-9n
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 06:05:49 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Soq3U-0005yz-W5
	for ltp-list@lists.sourceforge.net; Wed, 11 Jul 2012 06:05:49 +0000
Received: by pbbrq2 with SMTP id rq2so1474834pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Tue, 10 Jul 2012 23:05:38 -0700 (PDT)
Message-ID: <4FFD17A8.4080305@casparzhang.com>
Date: Wed, 11 Jul 2012 14:05:28 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4FFD1202.2020903@gmail.com>
In-Reply-To: <4FFD1202.2020903@gmail.com>
Subject: Re: [LTP] I want to make contribution for ltp
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
To: Miles Xu <miles.xu3@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/11/2012 01:41 PM, Miles Xu wrote:
> Hi Casper,
>
> I want to write some new cases for ltp. My issue is whether this is a
> todo list for reference.
> Please give me a document or link related to todo list.
>
>
> thanks,
>
> Miles
>

Hi Miles, thanks for your interests in LTP, new cases are always 
welcomed! There is a TODO list under $LTPROOT, but 1) it's kind of 
out-of-date and 2) it doesn't describe what kind of *new* test cases we 
need, so I wonder if it can be used for your reference.

If you have codes for LTP already, you can send it to the list for 
review (of course don't forget to take a look at 
$LTPROOT/doc/style-guide.txt first :)), if you are just seeking for some 
cases to be implemented in LTP, I'd suggest you can search upstream 
kernel tree, there might be some test codes in commit logs, you can see 
if you can port it to LTP. We always encourage kernel developers provide 
such cases to LTP, but very few people do that so far... And as we have 
ported some of them to LTP already, please take a look at the git commit 
log in case of overlaps.

HTH,
Caspar

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
