Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WdKIp-00070j-KA
	for ltp-list@lists.sourceforge.net; Thu, 24 Apr 2014 14:07:03 +0000
Date: Thu, 24 Apr 2014 16:06:11 +0200
From: chrubis@suse.cz
Message-ID: <20140424140611.GA27708@rei.suse.cz>
References: <1398336249.2318.3.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1398336249.2318.3.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 1/3] safe_macros: Add SAFE_GETRESUID and
 SAFE_GETRESGID
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +int safe_getresuid(const char *file, const int lineno, void (*cleanup_fn)(void),
> +		   uid_t *ruid, uid_t *euid, uid_t *suid)
> +{
> +	int rval;
> +
> +	rval = getresuid(ruid, euid, suid);
> +	if (rval == -1) {
> +		tst_brkm(TBROK | TERRNO, cleanup_fn,
> +			 "%s:%d: getresuid(%u, %u, %u) failed",
> +			 file, lineno, (unsigned) *ruid, (unsigned) *euid,
> +			 (unsigned) *suid);

Hmm, will there be any usable information ruid, euid and suid when
getresuid failed? My guess is that the values would be filled with
garbage. You should print the pointers passed to the call with %p
instead.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Start Your Social Network Today - Download eXo Platform
Build your Enterprise Intranet with eXo Platform Software
Java Based Open Source Intranet - Social, Extensible, Cloud Ready
Get Started Now And Turn Your Intranet Into A Collaboration Platform
http://p.sf.net/sfu/ExoPlatform
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
