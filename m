Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1Qbyq6-0002un-Ch
	for ltp-list@lists.sourceforge.net; Wed, 29 Jun 2011 17:46:14 +0000
Date: Wed, 29 Jun 2011 19:46:33 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20110629174633.GA17217@saboteur.suse.cz>
References: <ef44f6feaa6d46350761dae93d997c3f6a3a7e9e.1307968048.git.czhang@redhat.com>
	<bc82b67194b388102909bc38335c42bd661c3e55.1309361232.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bc82b67194b388102909bc38335c42bd661c3e55.1309361232.git.czhang@redhat.com>
Subject: Re: [LTP] [PATCH v3] [syscalls] getrusage03: test ru_maxrss
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
> +static void consume(int mega)
> +{
> +	size_t sz;
> +	void *ptr;
> +
> +	sz  = mega * 1024 * 1024;
> +	ptr = SAFE_MALLOC(cleanup, sz);
> +	memset(ptr, 0, sz);
> +}
> +
> +static long get_long(const char *str)
> +{
> +	long val;
> +	char *endptr;
> +
> +	val = strtol(str, &endptr, 10);
> +	if (((val == LONG_MAX || val == LONG_MIN) && errno == ERANGE) ||
> +		    (errno != 0 && val == 0))
> +		tst_brkm(TBROK|TERRNO, cleanup, "strtol");
> +	if (endptr == str || *endptr != '\0')
> +		tst_brkm(TBROK, cleanup, "Non-digits were found.");
> +
> +	return val;
> +}

One more thing, please keep the error meesages sweet and to the point.

Just imagine you get "Non-digits were found." error from some utility.
Which doesn't say much, for example where was these non digits found.

I would do something like:

tst_brkm(TBROK, "Invalid number parameter '%s'", str);

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
All of the data generated in your IT infrastructure is seriously valuable.
Why? It contains a definitive record of application performance, security 
threats, fraudulent activity, and more. Splunk takes this data and makes 
sense of it. IT sense. And common sense.
http://p.sf.net/sfu/splunk-d2d-c2
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
