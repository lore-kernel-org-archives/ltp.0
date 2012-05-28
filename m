Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1SZ4ew-0004cL-3J
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 18:27:14 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1SZ4ev-0004Wu-GE
	for ltp-list@lists.sourceforge.net; Mon, 28 May 2012 18:27:14 +0000
Received: by obhx4 with SMTP id x4so867956obh.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 28 May 2012 11:27:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4FC363DD.3080303@redhat.com>
References: <4FC363DD.3080303@redhat.com>
Date: Mon, 28 May 2012 11:27:07 -0700
Message-ID: <CAGH67wQGm+enSKVpCu9jb0ton6J2Q7VyqVUdA5MUp0SFRwQuNg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH 1/4] add libnuma_helper
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

On Mon, May 28, 2012 at 4:39 AM, Jan Stancek <jstancek@redhat.com> wrote:
>
> A library to share NUMA helper functions shared by
> multiple testcases.
>
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

One comment...

+			tst_resm(TFAIL, "get_allowed_nodes, i >= num_allowed_nodes: "
+			    "%d > %d", i, num_nodes);

1. I would just remove this because it's obvious from the API
definition what's going on when it sets ret to -3.
2. I would add a break there so it doesn't iterate through the loop
more than necessary.

Cheers,
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
