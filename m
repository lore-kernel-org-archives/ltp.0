Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1PLhur-0002Sr-Sn
	for ltp-list@lists.sourceforge.net; Thu, 25 Nov 2010 19:55:37 +0000
Date: Thu, 25 Nov 2010 21:08:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20101125200800.GA11386@saboteur.suse.cz>
References: <197804608.229291290511437013.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1163307688.229311290511451623.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<AANLkTin0d_pskgoJ7otHc-nsYcYsT6ZJocNS83t38u6F@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <AANLkTin0d_pskgoJ7otHc-nsYcYsT6ZJocNS83t38u6F@mail.gmail.com>
Subject: Re: [LTP] [PATCH] mbind_range() vma merge
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +static void usage(void);
> 
> gcooper> Get rid of this function please (unused).

Well it's passed to parse_opts(), which is, by the way, just another
dumb LTP interface...

> +int main(int argc, char** argv)
> +{
> +	FILE *fp;
> +	void* addr;
> +	int node;
> +	struct bitmask *nmask = numa_allocate_nodemask();
> +	int err;
> +	char buf[BUFSIZ];
> +	char start[BUFSIZ];
> +	char end[BUFSIZ];
> +	char string[BUFSIZ];
> +	char *p;
> +
> +	/* message returned from parse_opts */
> +	char *msg;
> +
> +	/* loop counter */
> +	int lc;
> +
> +	msg = parse_opts(argc, argv, options, usage);
> +	if (msg != NULL) {
> +		tst_brkm(TBROK, NULL, "OPTION PARSING ERROR - %s", msg);
> +		tst_exit();
> +	}

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Increase Visibility of Your 3D Game App & Earn a Chance To Win $500!
Tap into the largest installed PC base & get more eyes on your game by
optimizing for Intel(R) Graphics Technology. Get started today with the
Intel(R) Software Partner Program. Five $500 cash prizes are up for grabs.
http://p.sf.net/sfu/intelisp-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
