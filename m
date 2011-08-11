Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1QrVTl-0000XR-5k
	for ltp-list@lists.sourceforge.net; Thu, 11 Aug 2011 13:39:21 +0000
Date: Thu, 11 Aug 2011 15:43:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110811134320.GA15662@saboteur.suse.cz>
References: <235cb4cd6481ca25245b6b6d5ed988736d8a2991.1312043382.git.czhang@redhat.com>
	<4387b2003cde3c5841dd4bcd9d58560aa891501d.1312147752.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4387b2003cde3c5841dd4bcd9d58560aa891501d.1312147752.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v2] [mm] vma01: new testcase
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
To: Caspar Zhang <czhang@redhat.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> +	case 0:
> +		sprintf(mapfile, "/proc/%u/maps", getpid());

You could use /proc/self/maps instead.

> +		memset(t, 2, ps);
> +		u = mmap(t + 3*ps, 3*ps, PROT_WRITE,
> +			    MAP_ANONYMOUS|MAP_PRIVATE, 0, 0);
> +		if (u == MAP_FAILED)
> +			tst_brkm(TBROK|TERRNO, NULL, "mmap");
> +		tst_resm(TINFO, "u = %p", u);
> +		memset(u, 2, 4096);
> +		x = get_end_addr(u, mapfile);
> +		if (x == u + 6*ps)
> +			tst_resm(TFAIL, "A single 6*ps VMA found.");
> +		else if (x == u + 3*ps) {
> +			y = get_end_addr(x, mapfile);
> +			if (y == x + 3*ps)
> +				tst_resm(TPASS, "two 3*ps VMAs found.");
> +		} else
> +			tst_brkm(TBROK, cleanup, "unexpected VMA found.");
> +		exit(0);
> +	default:
> +		break;
> +	}
> +
> +}
> +
> +static void *get_end_addr(void *addr_s, char *mapfile)
> +{
> +	FILE *fp;
> +	void *s, *t;
> +	char buf[BUFSIZ];
> +
> +	fp = fopen(mapfile, "r+");

Hmm, "r+" opens the file for reading and writing (and sets the possition
on the start of the file). Shouldn't just "r" be sufficient?


-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get a FREE DOWNLOAD! and learn more about uberSVN rich system, 
user administration capabilities and model configuration. Take 
the hassle out of deploying and managing Subversion and the 
tools developers use with it. 
http://p.sf.net/sfu/wandisco-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
