Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1So7xO-0005jZ-Rk
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 07:00:30 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1So7xK-0001OQ-Rw
	for ltp-list@lists.sourceforge.net; Mon, 09 Jul 2012 07:00:30 +0000
Date: Mon, 09 Jul 2012 03:00:19 -0400 (EDT)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <49d6e6bd-1813-435d-aa6c-aaa8459b9979@zmail17.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4FED6D23.5060500@casparzhang.com>
MIME-Version: 1.0
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net



----- Original Message -----
> From: "Caspar Zhang" <caspar@casparzhang.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Friday, 29 June, 2012 10:53:55 AM
> Subject: Re: [LTP] [PATCH/RFC] style-guide: sending patch series
> 
> On 06/29/2012 04:44 PM, Jan Stancek wrote:
> > +git config format.numbered auto
> > +git config sendemail.signoffbycc false
> > +git config sendemail.suppresscc all
> > +git config sendemail.suppressfrom true
> > +git config sendemail.smtpserver "your.smtp.server"
> > +git config sendemail.confirm always
> 
> These lines look like not related to thread-shallow issue?

(sorry for late answer, was on holiday)

True, those are related to sending patch series with git send-email in general.
I took 'best practices' from different mailing list as initial suggestion.

Regards,
Jan

> 
> Caspar
> 

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
