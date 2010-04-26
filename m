Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chrubis@suse.de>) id 1O6Onq-0004yG-DQ
	for ltp-list@lists.sourceforge.net; Mon, 26 Apr 2010 13:56:50 +0000
Date: Mon, 26 Apr 2010 16:04:21 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20100426140420.GA29365@saboteur.suse.cz>
References: <20100402185908.GA478@saboteur.suse.cz>
	<g2x364299f41004021212z6e85833ybccad62e6780ec26@mail.gmail.com>
	<20100419184131.GA20776@saboteur.suse.cz>
	<20100423125351.GA24523@saboteur.suse.cz>
	<n2s364299f41004231253offfe856amfa09260ba50cf18b@mail.gmail.com>
	<20100423204312.GA26503@saboteur.suse.cz>
	<m2i364299f41004231439kbe4017dayfc57d5d8b622a744@mail.gmail.com>
	<20100426130400.GA28340@saboteur.suse.cz>
	<g2o364299f41004260623kb1627f65ld8765f98d8be1790@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <g2o364299f41004260623kb1627f65ld8765f98d8be1790@mail.gmail.com>
Subject: Re: [LTP] [PATCH] fix fs_perms tests
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
Cc: ltp-list@lists.sourceforge.net

Hi!
> 2. Why do you feel this is required?

Well, accordingly to POSIX you can't realy rely on having /bin/sh or even
/usr/bin/sh. On the other hand I haven't seen any linux system that has no
/bin/sh. And accordingly to FSH /bin/sh is required to exist. So this really
depends on how much we want to be compatible with POSIX and strange unixes out
there (if there are any).

* FSH http://www.pathname.com/fhs/
* POSIX http://www.opengroup.org/onlinepubs/000095399/utilities/sh.html
        (paragraph "application usage")

> 3. This should really be a single snprintf call:
> 
> +		/* copy path */
> +		for (i = 0; i < buf_len && path[i] != '\0' && path[i] != ':'; i++)
> +			buf[i] = path[i];
> +
> +		/* add slash at the end if needed */
> +		if (buf[i - 1] != '/')
> +			buf[i++] = '/';
> +		/* copy the program name */
> +		strncpy(buf + i, prog_name, buf_len - i);
> 
>     similar to the following:
> 
> if (snprintf(buf, buf_len, "%s/%s", path_element, prog_name) > buf_len)
>     /* error out */
> else if (file_exist(buf))
>     return 0; /* etc... */
> /* ... */

This way I would need either to copy the path element into temporary
path_element[] array each time before snprintf is called or duplicate the
string returned by getenv("PATH") so that I could insert '\0' in it.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
