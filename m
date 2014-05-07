Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Wi0xK-0005Uw-ET
	for ltp-list@lists.sourceforge.net; Wed, 07 May 2014 12:28:14 +0000
Date: Wed, 7 May 2014 14:27:14 +0200
From: chrubis@suse.cz
Message-ID: <20140507122714.GB20240@rei>
References: <1389353374.2061.9.camel@G08JYZSD130126>
	<1389409991.2061.14.camel@G08JYZSD130126>
	<20140224193305.GC31562@rei>
	<1393309618.1952.52.camel@G08JYZSD130126>
	<5368A32E.7070805@oracle.com> <20140506144740.GA7908@rei.Home>
	<1399450341.2397.16.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1399450341.2397.16.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH 2/2] linkat/linkat02.c: fix xfs with EMLINK issue
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
>  static void setup(void);
>  static void cleanup(void);
> @@ -127,8 +128,15 @@ int main(int ac, char **av)
>  
>  static void linkat_verify(const struct test_struct *desc)
>  {
> -	if (desc->setupfunc != NULL)
> -		desc->setupfunc();
> +	if (desc->setupfunc != NULL) {
> +		if (desc->setupfunc == setup_emlink && emlink_flag == 1) {
> +			tst_resm(TCONF, "We can't reach the max links for %s",
> +				 fstype);
> +			return;
> +		} else {
> +			desc->setupfunc();
> +		}
> +	}
>  
>  	TEST(ltp_syscall(__NR_linkat, AT_FDCWD, desc->oldfname,
>  			 AT_FDCWD, desc->newfname, desc->flags));
> @@ -204,8 +212,10 @@ static void setup(void)
>  					 fstype, link_max);
>  				break;
>  			default:
> -				tst_brkm(TBROK | TTERRNO, cleanup,
> -					 "Unexpected error: ");
> +				emlink_flag = 1;
> +				tst_resm(TINFO | TTERRNO,
> +					 "for %s we can't reach the max links",

What errno do we get here instead of the EMLINK?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Is your legacy SCM system holding you back? Join Perforce May 7 to find out:
&#149; 3 signs your SCM is hindering your productivity
&#149; Requirements for releasing software faster
&#149; Expert tips and advice for migrating your SCM now
http://p.sf.net/sfu/perforce
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
