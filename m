Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SkWyP-0002f5-DU
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 08:54:41 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SkWyK-00034T-2l
	for ltp-list@lists.sourceforge.net; Fri, 29 Jun 2012 08:54:41 +0000
Received: by dalh21 with SMTP id h21so3978431dal.34
	for <ltp-list@lists.sourceforge.net>;
	Fri, 29 Jun 2012 01:54:30 -0700 (PDT)
Message-ID: <4FED6D23.5060500@casparzhang.com>
Date: Fri, 29 Jun 2012 16:53:55 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <1c21689296e79eb48004e2f9eb879d717481cf73.1340959271.git.jstancek@redhat.com>
In-Reply-To: <1c21689296e79eb48004e2f9eb879d717481cf73.1340959271.git.jstancek@redhat.com>
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

On 06/29/2012 04:44 PM, Jan Stancek wrote:
> +git config format.numbered auto
> +git config sendemail.signoffbycc false
> +git config sendemail.suppresscc all
> +git config sendemail.suppressfrom true
> +git config sendemail.smtpserver "your.smtp.server"
> +git config sendemail.confirm always

These lines look like not related to thread-shallow issue?

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
