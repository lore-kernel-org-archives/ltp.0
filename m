Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yanegomi@gmail.com>) id 1Sw3gD-0006Wb-VP
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 04:03:33 +0000
Received: from mail-ob0-f175.google.com ([209.85.214.175])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Sw3gD-0001aM-9o
	for ltp-list@lists.sourceforge.net; Tue, 31 Jul 2012 04:03:33 +0000
Received: by obcva7 with SMTP id va7so10404590obc.34
	for <ltp-list@lists.sourceforge.net>;
	Mon, 30 Jul 2012 21:03:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ba9ec47929d3aa8783905c1e9061536e515ca9f6.1343703433.git.caspar@casparzhang.com>
References: <35d6826c595733530915a3467146b9532f427429.1343703433.git.caspar@casparzhang.com>
	<ba9ec47929d3aa8783905c1e9061536e515ca9f6.1343703433.git.caspar@casparzhang.com>
Date: Mon, 30 Jul 2012 21:03:27 -0700
Message-ID: <CAGH67wRjmm5puB_ci+4xcnDBtn-v-OJtjf-Jec5p75o056qPmg@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [PATCH/RFE 2/2] mm: use new numa_helper
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

On Mon, Jul 30, 2012 at 7:57 PM, Caspar Zhang <caspar@casparzhang.com> wrote:
>
> This patch makes the tests in mem/ dir use numa_helper in libkerntest.
>
> Signed-off-by: Caspar Zhang <caspar@casparzhang.com>

Inline patches are easier to review...

>-		tst_brkm(TCONF, NULL, "required a NUMA system.");
>+		tst_brkm(TCONF, NULL, "require a NUMA system.");

`requires` is probably what was meant here, but nonetheless the
comment is incomplete.

> /* shared */
>-long count_numa(long nodes[]);
>+unsigned get_a_numa_node(void (*cleanup_fn)(void));

Please use `unsigned int`.

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
