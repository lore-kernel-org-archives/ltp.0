Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <caspar@casparzhang.com>) id 1SS46A-0001Jn-Ek
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 10:26:22 +0000
Received: from mail-pz0-f47.google.com ([209.85.210.47])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SS465-0007Ib-01
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 10:26:22 +0000
Received: by dalh21 with SMTP id h21so125373dal.34
	for <ltp-list@lists.sourceforge.net>;
	Wed, 09 May 2012 03:26:11 -0700 (PDT)
Message-ID: <4FAA4617.4090007@casparzhang.com>
Date: Wed, 09 May 2012 18:25:27 +0800
From: Caspar Zhang <caspar@casparzhang.com>
MIME-Version: 1.0
References: <4FAA34D4.5000706@redhat.com>
In-Reply-To: <4FAA34D4.5000706@redhat.com>
Subject: Re: [LTP] [PATCH] move_pages09: move_pages returns 0 if nothing got
 migrated
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
Cc: ltp-list@lists.sourceforge.net, Jeffrey Burke <jburke@redhat.com>

On 05/09/2012 05:11 PM, Jan Stancek wrote:
> +		if ((tst_kvercmp(2, 6, 28)) >= 0) {
> +			if (ret == 0)
> +				tst_resm(TPASS, "move_pages succeeded");
> +			else
> +				tst_resm(TFAIL, "move_pages failed with: %s",
> +				    strerror(TEST_ERRNO));

Hi Jan,

We can use: tst_resm(TFAIL|TERRNO, "move_pages");

This will produce messages like:

TFAIL    : move_pages: errno=ENOENT(2): No such file or directory

> +		} else {
> +			if (ret == -1 && errno == ENOENT)
> +				tst_resm(TPASS, "move_pages failed with "
> +				    "ENOENT as expected");
> +			else
> +				tst_resm(TFAIL, "move_pages failed with: "
> +				    "%s", strerror(TEST_ERRNO));

Here as well.

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
