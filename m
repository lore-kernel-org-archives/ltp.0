Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SoB23-0001AS-TA
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 10:17:31 +0000
Received: from mail-pb0-f47.google.com ([209.85.160.47])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SoB23-0008FQ-4N
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 10:17:31 +0000
Received: by pbbrq2 with SMTP id rq2so17958957pbb.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 09 Jul 2012 03:17:25 -0700 (PDT)
Message-ID: <4FFAAFAE.4080607@casparzhang.com>
Date: Mon, 09 Jul 2012 18:17:18 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <49d6e6bd-1813-435d-aa6c-aaa8459b9979@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <49d6e6bd-1813-435d-aa6c-aaa8459b9979@zmail17.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH/RFC] style-guide: sending patch series
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
Cc: ltp-list@lists.sourceforge.net

On 07/09/2012 03:00 PM, Jan Stancek wrote:
> 
> 
> ----- Original Message -----
>> From: "Caspar Zhang" <caspar@casparzhang.com>
>> To: "Jan Stancek" <jstancek@redhat.com>
>> Cc: ltp-list@lists.sourceforge.net
>> Sent: Friday, 29 June, 2012 10:53:55 AM
>> Subject: Re: [LTP] [PATCH/RFC] style-guide: sending patch series
>>
>> On 06/29/2012 04:44 PM, Jan Stancek wrote:
>>> +git config format.numbered auto
>>> +git config sendemail.signoffbycc false
>>> +git config sendemail.suppresscc all
>>> +git config sendemail.suppressfrom true
>>> +git config sendemail.smtpserver "your.smtp.server"
>>> +git config sendemail.confirm always
>>
>> These lines look like not related to thread-shallow issue?
> 
> (sorry for late answer, was on holiday)
> 
> True, those are related to sending patch series with git send-email in general.
> I took 'best practices' from different mailing list as initial suggestion.

Okay. This caused a little confusion to me, I thought you were
suggesting use all configurations above as "shallow thread" style.

BTW, I don't think they[1] are necessary to put in style-guide.txt,
they're more likely to be tips instead.  i.e. we don't _require_ patch
contributor to avoid cc-ing to people in sign-off-by lines, nor require
they to suppress cc/from, blah, blah, etc.

Also, on my system, this line is not required either:

    +git config sendemail.thread false

once you have set this:

    +git config format.thread shallow

Whenever I enable or disable thread in sendemail section, the patchset
will be displayed as shallow format.

Thanks,
Caspar

[1] "they" refers to:
>>> +git config sendemail.signoffbycc false
>>> +git config sendemail.suppresscc all
>>> +git config sendemail.suppressfrom true
>>> +git config sendemail.smtpserver "your.smtp.server"
>>> +git config sendemail.confirm always

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
